def generate_term(index, num_vars):
    term = []
    for j in range(num_vars):
        if (index >> j) & 1:
            term.append(f"x{num_vars - j}")
        else:
            term.append(f"¬x{num_vars - j}")
    return term

def can_combine(term1, term2):
    differences = 0
    for a, b in zip(term1, term2):
        if a != b:
            differences += 1
            if differences > 1:
                return False
    return differences == 1

def minimize_terms(terms):
    while True:
        changed = False
        new_terms = []
        used = [False] * len(terms)
        for i in range(len(terms)):
            if used[i]:
                continue
            for j in range(i + 1, len(terms)):
                if used[j]:
                    continue
                if can_combine(terms[i], terms[j]):
                    new_term = [a if a == b else '-' for a, b in zip(terms[i], terms[j])]
                    if new_term not in new_terms and new_term not in terms:
                        new_terms.append(new_term)
                        used[i] = True
                        used[j] = True
                        changed = True
                        break
            if not used[i]:
                new_terms.append(terms[i])
        if not changed:
            break
        terms = new_terms
    return [" ∧ ".join(filter(lambda x: x != '-', term)) for term in terms]

def dnf_from_truth_vector(truth_vector):
    num_vars = len(truth_vector).bit_length() - 1
    terms = [generate_term(i, num_vars) for i in range(2 ** num_vars) if truth_vector[i] == '1']
    minimized_terms = minimize_terms(terms)
    return " ∨ ".join(minimized_terms)

# Пример использования
truth_vector = '10101101'
print(dnf_from_truth_vector(truth_vector))
