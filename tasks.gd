class_name tasks

func Is_T0(v):
	if(v[0]=="0"):
		return true
	else:
		return false
		
func Is_T1(v):
	if(v[len(v)-1]=="1"):
		return true
	else:
		return false
		
func Is_S(v):
	for i in range(0, len(v)/2):
		if(v[i]==v[len(v)-1-i]):
			return false
	return true
	
func Is_M(v):
	var is_monot=true
	var n = len(v)
	for i in range(n):
		for j in range(i+1, n):
			var is_mon=1
			for k in range(n):
				if ((i >> k) & 1) > ((j >> k) & 1):
					is_mon = false
					break
			if is_mon:
				if v[i] > v[j]:
					is_monot=0
	return is_monot
	
func Is_L(v):
	var arr_linear = []

	for i in range(len(v)):
		arr_linear.append([])
		for q in range(len(v) - i):
			if i == 0:
				arr_linear[i].append(int(v[q]))
			else:
				arr_linear[i].append(int(arr_linear[i - 1][q] != arr_linear[i - 1][q + 1]))

	var p=true
	for i in range(len(v)):
		if arr_linear[i][0] == 1 and not ((i & (i - 1)) == 0):
			p=false
			break
	return p


# На вход — число n, на выход — булева функция от n аргументов (строка f)
func first_task(n):
	var f = ""
	for i in range(0, 1<<n):
		f+=str(randi_range(0, 1))
	return f
	
# На вход — вектор функции (v), 0 или 1 (bi), номер аргумента (n), на выход — соответствующая остаточная (строка s)
func second_task(vec, bi, n):
	var cnt=0
	cnt=int(log(len(vec))/log(2))
	n=cnt-n+1
	var s=""
	for i in range(0, len(vec)):
		if(i%(1<<n)/(1<<(n-1))==bi):
			s+=(vec[i])
	return(s)
# На вход — два вектора (это нулевая и единичная остаточные функции по некоторому аргументу), номер аргумента, на выход — вектор функции.
# vec1 - это нулевая остаточная (строка), vec2 - это единичная остаточная (строка), n - это номер переменной (аргумента) (целое число), s - возвращаемый вектор функции (строка)
func third_task(vec1, vec2, n):
	#сократить код
	var cnt=0
	cnt=int(log(len(vec1)+len(vec2))/log(2))
	n=cnt-n+1
	var s=""
	var x=0
	var y=0
	for i in range(0,len(vec1)+len(vec2)):
		if(i%(1<<n)/(1<<(n-1))==0):
			s+=vec1[x]
			x+=1
		if(i%(1<<n)/(1<<(n-1))==1):
			s+=vec2[y]
			y+=1
	return(s)
#Игра. Узнать имя функции от 2-х аргументов. Система предлагает вектор функции, пользователь выбирает «имя» (одно из 16).
# Здесь x - это имя функции ,которое выбирает пользователь (вроде строка), y - вектор функции (строка), который ему предлагает система, возврашаем 1, если правильно и 0, если не правильно.
func fourth_task(x,y):
	var gr={"0000":"тождественный ноль", "0001":"конъюнкция","0010":"коимпликация","0011":"функция-переменная","0100":"обратная коимпликация","0101":"функция-переменная","0110":"сложение","0111":"дизъюнкция","1000":"стрелка Пирса","1001":"эквивалентность","1010":"функция-отрицания","1011":"обратная импликация","1100":"функция-отрицания","1101":"импликация","1110":"штрих Шеффера","1111":"тождественная единица"}
	if(gr[y]==x):
		return 1
	return 0
# Игра. Существенные и фиктивные переменные. Система предлагает вектор функции. Пользователь выбирает существенные и фиктивные переменные
# Здесь v - это предлагаемый системой вектор (строка), s - строка с выбранными пользователем переменными по номерам (то есть что-то вроде 
# "123", пишется без пробелов), n - число переменных функции.
# в идеале от n можно избавиться с помощью логарифмов и находить его в самой функции, но это потом решим. Также вывод следует дописать,
# так как выводить win в командную строку такое себе. 
func fifth_task(v, s, n):
	var ans=""
	for i in range (1,n+1):
		if second_task(v,0,i)==second_task(v,1,i):
			ans+=str(i)
	if(s==ans):
		return true
	return false


func sixth_task(dnf_expression, v):
	var parse_DNF = func (expression):
		var dnf_list = []
		var sub_expression = {}
		var is_negative = false
		var current_var = ""

		for i in range(0, len(expression)):
			if expression[i]=='X' or expression[i]=='x':
				current_var += expression[i+1]
			elif expression[i] == "-":
				is_negative = true
			elif expression[i] == " ":
				if current_var:
					var var_index = int(current_var)
					sub_expression[var_index] = not is_negative
					current_var = ""
					is_negative = false
			elif expression[i] == "V":
				if sub_expression:
					dnf_list.append(sub_expression)
					sub_expression = {}
		if sub_expression:
			dnf_list.append(sub_expression)
		return dnf_list

	var dnf = parse_DNF.call(dnf_expression+" ")

	var f = func (args: Array):
		for clause in dnf:
			var satisfied = true
			for keys in clause:
				if args[keys-1] != clause[keys]:
					satisfied = false
					break
			if satisfied:
				return '1'
		return '0'
	
	var json_ = [
		[[false], [true]],
	[[false, false], [false, true], [true, false], [true, true]],
	[[false, false, false], [false, false, true], [false, true, false], [false, true, true],
		[true, false, false], [true, false, true], [true, true, false], [true, true, true]]]
	
	var s = ''
	for i in json_[log(len(v))/log(2)-1]:
		s += f.call(i)
	if s==v:
		return true
	return false


func seventh_task(cnf_expression, v):
	# Парсер для КНФ
	var parse_CNF = func (expression):
		var cnf_list = []
		var sub_expression = {}
		var is_negative = false
		var current_var = ""

		for i in range(0, len(expression)):
			if expression[i] == 'X' or expression[i]=='x':
				current_var += expression[i+1]
			elif expression[i] == "-":
				is_negative = true
			elif expression[i] == " ":
				if current_var:
					var var_index = int(current_var)
					sub_expression[var_index] = not is_negative
					current_var = ""
					is_negative = false
			elif expression[i] == "&":  # Используем символ ^ для AND
				if sub_expression:
					cnf_list.append(sub_expression)
					sub_expression = {}
		if sub_expression:
			cnf_list.append(sub_expression)
		return cnf_list

	var cnf = parse_CNF.call(cnf_expression + " ")
	
	# Функция для оценки КНФ
	var f = func (args: Array):
		for clause in cnf:
			var satisfied = false
			for key in clause:
				if args[key - 1] != clause[key]:
					satisfied = true
					break
			if not satisfied:
				return '0'
		return '1'

	var json_ = [
		[[false], [true]],
		[[false, false], [false, true], [true, false], [true, true]],
		[[false, false, false], [false, false, true], [false, true, false], [false, true, true],
		 [true, false, false], [true, false, true], [true, true, false], [true, true, true]]]
	
	var s = ''
	for i in json_[log(len(v)) / log(2) - 1]:
		s += f.call(i)
	s =s.reverse()
	
	if s == v:
		return true
	return false


#  Пользователь вводит вектор функции. Система строит СДНФ.
# v - вектор функции (строка). Возвращаем строку, которая является СДНФ
func eigth_task(v):
	var ans=""
	var cnt=0
	cnt=int(log(len(v))/log(2))
	var matrix = []
	for i in range (0, 1<<cnt):
		matrix.append([])
		for j in range(cnt-1, -1, -1):
			matrix[i].append(i/(1<<j)%2)
	for i in len(v):
		if (v[i]=="1"):
			for j in len(matrix[i]):
				if(matrix[i][j]==1):
					ans+=" x"+str(j+1)+" &"
				else:
					ans+=" -x"+str(j+1)+" &"
			ans[len(ans)-1]=""
			ans+=" V "
	ans[len(ans)-1]=""
	ans[len(ans)-1]=""
	return ans
	
# Пользователь вводит вектор функции. Система строит СКНФ.
# v - вектор функции (строка). Возвращаем строку, которая является СКНФ
func ninth_task(v):
	var ans=""
	var cnt=0
	cnt=int(log(len(v))/log(2))
	var matrix = []
	for i in range (0, 1<<cnt):
		matrix.append([])
		for j in range(cnt-1, -1, -1):
			matrix[i].append(i/(1<<j)%2)
	ans+="("
	for i in len(v):
		if (v[i]=="0"):
			for j in len(matrix[i]):
				if(matrix[i][j]==0):
					ans+=" x"+str(j+1)+" V"
				else:
					ans+=" -x"+str(j+1)+" V"
			ans[len(ans)-1]=""
			ans+=") & ("
	#вот эту штуку потехничнее сделать
	ans[len(ans)-1]=""
	ans[len(ans)-1]=""
	ans[len(ans)-1]=""
	return ans
	
#Игра. Предполные классы б.ф. Система предлагает вектор функции. Пользователь должен выбрать предполные классы, которым эта функция принадлежит. Система определяет правильно выбраны классы или нет.
# v - вектор функции (строка), ans - ответ пользователя, это строка, где без пробелов записаны классы, которые выбрал пользователь в порядке T0T1SML и ни в каком другом.

func tenth_task(v, ans):
	var s=""
	if(Is_T0(v)):
		s+="T0"
	if(Is_T1(v)):
		s+="T1"
	if(Is_S(v)):
		s+="S"
	if(Is_M(v)):
		s+="M"
	if(Is_L(v)):
		s+="L"
		
	#с проверкой лучше еще пошаманить
	print(s)
	if(s==ans):
		return true
	return false

#Игра. Полные системы б.ф. Система предлагает набор векторов функций. Пользователь определяет полным или нет является набор функций. Если система б.ф. неполна, то пользователь должен указать замкнутый класс, которому набор функций принадлежит.
# system - это система векторов (массив строк), inp - ответ пользователя в таком же формате, как в 10: строка с классами в следующем порядке T0T1SML, 
func eleventh_task(system, inp):
	var ans=""
	var cnt=0
	for v in system:
		if(not Is_T0(v)):
			break
		cnt+=1
	if(cnt==len(system)):
		ans+="T0"
	cnt=0
	
	for v in system:
		if(not Is_T1(v)):
			break
		cnt+=1
	if(cnt==len(system)):
		ans+="T1"
	cnt=0
	
	for v in system:
		if(not Is_S(v)):
			break
		cnt+=1
	if(cnt==len(system)):
		ans+="S"
	cnt=0
	
	for v in system:
		if(not Is_M(v)):
			break
		cnt+=1
	if(cnt==len(system)):
		ans+="M"
	cnt=0
	
	for v in system:
		if(not Is_L(v)):
			break
		cnt+=1
	if(cnt==len(system)):
		ans+="L"
	
	if(inp==ans):
		return true
	return false

func generate_term(index, num_vars):
	var term=[]
	for i in range (num_vars):
		var p=num_vars - i
		if index & (1 << i):
			term.append("x"+str(p))
		else:
			term.append("¬x"+str(p))
	return term

func can_combine(term1, term2):
	var differences=0
	for i in range (min(len(term1), len(term2))):
		if(term1[i]!=term2[i]):
			differences+=1
			if (differences>1):
				return false
	return differences == 1
	

func minimize_terms(terms):
	
	while true:
		var changed = false
		var new_terms = []
		var used = []
		used.resize(terms.size())
		for i in range(terms.size()):
			if used[i]:
				continue
			for j in range(i + 1, terms.size()):
				if used[j]:
					continue
				if can_combine(terms[i], terms[j]):
					var new_term = []
					for k in range(terms[i].size()):
						if terms[i][k] == terms[j][k]:
							new_term.append(terms[i][k])
						else:
							new_term.append("-")
					if not new_terms.has(new_term) and not terms.has(new_term):
						new_terms.append(new_term)
						used[i] = true
						used[j] = true
						changed = true
						break
			if not used[i]:
				new_terms.append(terms[i])
		if not changed:
			break
		terms = new_terms
	var result = []
	for term in terms:
		var dop=[]
		for x in term:
			if x!="-":
				dop.append(x)
		result.append(" & ".join(dop))
	return result

func twelveth_task(truth_vector):
	var num_vars = log(len(truth_vector))/log(2)
	var terms = []
	
	for i in range(1<<int(num_vars)):
		if truth_vector[i] == '1':
			terms.append(generate_term(i, num_vars))
	
	var minimized_terms = minimize_terms(terms)
	return " v ".join(minimized_terms)
#по сути функция twelveth_task(s) и не нужна, так как она в консоль выводит результат, который возвращает dnf_from_truth_vector(truth_vector)
#func twelveth_task(s):
#	return (dnf_from_truth_vector(s))

#алгоритм для поиска в глубину
#на вход матрица смежности и номер вершины, с котрой начинается обход. На выход - массив из посещенных вершин
func dfs(graph, start):
	var visited = []
	var stack = []

	visited.append(start)
	stack.append(start)

	while stack:
		var node = stack.pop_back()
		for index in range(graph.size()):
			if graph[node][index] == 1 and index not in visited:
				visited.append(index)
				stack.append(index)
	#print(visited)
	return visited

func bfs(graph, start):
	var visited = []
	var stack = []

	visited.append(start)
	stack.append(start)

	while stack:
		var node = stack.pop_front()
		for index in range(graph.size()):
			if graph[node][index] == 1 and index not in visited:
				visited.append(index)
				stack.append(index)
	#print(visited)
	return visited

#первое задание - показать порядок посещенных вершин при обходе в глубину, здесь graph - это матрица смежности, представленная массивом массивов.
#функция в качестве ответа возвращает массив, в котором по порядку записаны пройденные вершины
func task1(graph):
	var visited = []
	visited.resize(len(graph))
	visited.fill(false)
	var v2
	var ans=[]
	for i in range(0,len(visited)):
		if not visited[i]:
			v2=dfs(graph, i)
			for k in v2:
				ans.append(k)
			for j in v2:
				visited[j]=true
	#print(ans)
	return(ans)
	
#второе задание - сравнить порядок вершин после dfs'a с порядком, который введет пользователь в кчестве ответа
#на вход матрица смежности - массив массивов (graph) и answer - массив чисел, вершин которые ввел пользователь
func task2 (graph, answer):
	#for i in range(0, len(graph)):
	if(task1(graph)==answer):
		print("а ты хорош!")
		return true
	print("ну такое")
	return false

#третье задание - показать порядок посещенных вершин при обходе в ширину, здесь graph - это матрица смежности, представленная массивом массивов.
#функция в качестве ответа возвращает массив, в котором по порядку записаны пройденные вершины
func task3(graph):
	var visited = []
	visited.resize(len(graph))
	visited.fill(false)
	var v2
	var ans=[]
	for i in range(0,len(visited)):
		if not visited[i]:
			v2=bfs(graph, i)
			for k in v2:
				ans.append(k)
			for j in v2:
				visited[j]=true
	#print(ans)
	return(ans)
	
#четвертое задание - сравнить порядок вершин после bfs'a с порядком, который введет пользователь в кчестве ответа
#на вход матрица смежности - массив массивов (graph) и answer - массив чисел, вершин которые ввел пользователь
func task4(graph, answer):
	#for i in range(0, len(graph)):
	if(task3(graph)==answer):
		print("а ты хорош!")
		return true
	print("ну такое")
	return false
	
#пятое задание - найти число компонент связности
#на вход матрица смежности - массив массивов (graph), на выход число компонент связности (ks)
func task5(graph):
	var ks=0
	var visited = []
	visited.resize(len(graph))
	visited.fill(false)
	#visited[0]=true
	#var v2=dfs(graph, 0)
	#for i in v2:
	#	visited[i]=true
	var v2
	for i in range(0,len(visited)):
		if not visited[i]:
			v2=dfs(graph, i)
			for j in v2:
				visited[j]=true
			ks+=1
	#print(ks)
	return ks
	
#шестое задание: нужно проверить, правильно ли пользователь определил число компонент связности графа
#на вход матрица смежности - массив массивов (graph) и answer - массив чисел, вершин которые ввел пользователь
func task6(graph,answer):
	if(task5(graph)==answer):
		print("а ты хорош!")
		return true
	print("ну такое")
	return false
	
	
#это жесткая бета версия 0 задания, оно по сути своей объединяет последующие задания, так что его лучше в конце делать
func task0(vvi):
	var powers=[]
	for i in range(0,len(vvi)):
		var cnt=0
		for j in range (0, len(vvi[i])):
			cnt+=vvi[i][j];
		powers.append(cnt)
	
	#var visited = []
	#visited.resize(len(vvi))
	#visited.fill(false)
	#for i in range (0, len(vvi)):
	#	visited.append(false)
	var ks=task5(vvi)
	#for i in range(0,len(vvi)):
	#	if (visited[i]):
	#		continue
	#	ks+=1
	#	visited[i]=true
	#	var queue= [i]
	#	while queue:
	#		var v=queue.pop_front()
	#		for h in vvi[v]:
	#			if not visited[h]:
	#				visited[h]=true
	#				queue.append(h)
	print("степени вершин: ", powers)
	print("число компонент связности: ",ks)
	var g=0
	for i in powers:
		if(i%2==0):
			g+=1
	if(ks==1 and len(powers)-g==0):
		print("Это эйлеров граф")
	elif(ks==1 and len(powers)-g<=2):
		print("Это полуэйлеров граф")
	else:
		print("Граф не является эйлеровым или полуэйлеровым")
		
	
	
	var colors = greedy_graph_coloring(vvi)
	if(colors.all(less_than_2)):
		print("Граф двудольный")
	else:
		print("граф не двудольный")
	
	
	
func less_than_2(n):
	return n<2
	
func task8(graph, s):
	var nv=len(graph)
	var dist=[]
	var visited=[]
	
	for i in range(0, nv):
		dist.append(INF)
		visited.append(false)
	
	dist[s]=0
	
	for i in range(0,nv):
		var min_distance=INF
		var min_index=-1
		for j in range(0,nv):
			if visited[j]==false and dist[j]<min_distance:
				min_distance=dist[j]
				min_index=j
			
		if min_index==-1:
			break
		
		visited[min_index]=true
		for j in range(0,nv):
			var new_dist
			if graph[min_index][j]>0 and not visited[j]:
				new_dist = dist[min_index] + graph[min_index][j]
				if new_dist<dist[j]:
					dist[j]=new_dist
					
					
	
	return dist

func task9(graph):
	var ans=[]
	for i in range(0,len(graph)):
		ans.append(task8(graph,i))
	#print (ans)
	return ans


func minKey(key, mstSet):
	var min = INF
	var min_index = -1
	for i in range(key.size()):
		if not mstSet[i] and key[i] < min:
			min = key[i]
			min_index = i
	return min_index

func task7(graph):
	var num_vertices = graph.size()
	var parent = []
	var key = []
	var mstSet = []

	
	key.resize(len(graph))
	key.fill(INF)
	mstSet.resize(len(graph))
	mstSet.fill(false)
	parent.resize(len(graph))
	parent.fill(null)
	key[0] = 0
	parent[0] = -1

	for count in range(num_vertices - 1):
		var u = minKey(key, mstSet)
		mstSet[u] = true

		for v in range(num_vertices):
			if graph[u][v] and not mstSet[v] and graph[u][v] < key[v]:
				parent[v] = u
				key[v] = graph[u][v]


	for i in range(1, num_vertices):
		print(parent[i], "-", i, ":", graph[i][parent[i]])
		

func prufer_code(adjacency_matrix):
	var n = adjacency_matrix.size()
	var degree = []
	var prufer_code = []
	
	# Инициализация массива степеней вершин
	for i in range(n):
		var deg = 0
		for j in range(n):
			if adjacency_matrix[i][j] > 0:
				deg += 1
		degree.append(deg)
	
	for k in range(n - 2):
		# Находим лист с наименьшим номером (степень которого равна 1)
		var leaf = -1
		for i in range(n):
			if degree[i] == 1:
				leaf = i
				break
		
		# Находим соседа листа и добавляем его в код Прюфера
		for j in range(n):
			if adjacency_matrix[leaf][j] > 0:
				prufer_code.append(j)
				adjacency_matrix[leaf][j] = 0
				adjacency_matrix[j][leaf] = 0
				degree[leaf] -= 1
				degree[j] -= 1
				break
	print(prufer_code)
	return prufer_code


func prufer_decode(code):
	var n = code.size() + 2 # Количество вершин в дереве
	var degree = []
	var adjacency_matrix = []
	
	# Инициализация степени вершин и матрицы смежности
	for i in range(n):
		degree.append(1) # Устанавливаем начальную степень равной единице для каждой вершины
		var row = []
		for j in range(n):
			row.append(0)
		adjacency_matrix.append(row)
	
	for i in code:
		degree[i] += 1
	
	for i in range(code.size()):
		# Находим первую вершину с степенью равной 1
		var u = -1
		for j in range(n):
			if degree[j] == 1:
				u = j
				break
		
		var v = code[i]
		# Добавляем ребро u - v
		adjacency_matrix[u][v] = 1
		adjacency_matrix[v][u] = 1
		
		# Уменьшаем степень у использованных вершин
		degree[u] -= 1
		degree[v] -= 1
	
	# Добавляем последнее ребро между двумя оставшимися вершинами с степенью 1
	var u = -1
	var v = -1
	for i in range(n):
		if degree[i] == 1:
			if u == -1:
				u = i
			else:
				v = i
	
	adjacency_matrix[u][v] = 1
	adjacency_matrix[v][u] = 1
	#print(adjacency_matrix)
	return adjacency_matrix


func greedy_graph_coloring(graph):
	var num_vertices = len(graph)
	var result = []
	
	for y in range(num_vertices):
		result.append(-1) # Изначально все вершины имеют цвет -1 (не цветные)
	
	result[0] = 0 # Первая вершина раскрашивается в цвет 0
	
	var available = []
	for y in range(num_vertices):
		available.append(true) # Доступность всех цветов (если true - цвет доступен)
	
	for u in range(1, num_vertices):
		# Маркируем цвета используемые смежными вершинами
		for i in range(num_vertices):
			if graph[u][i] == 1 and result[i] != -1:
				available[result[i]] = false
		
		# Находим первый доступный цвет
		var cr = 0
		while cr < num_vertices:
			if available[cr]:
				break
			cr += 1
		
		result[u] = cr # Назначаем цвет
		for i in range(num_vertices):
			available[i] = true # Сброс всех цветов в доступные
	#print(result)
	return result


func inc_to_adj(inc_graph):
	var n = len(inc_graph)
	var m = len(inc_graph[0])
	
	# Создаем пустую матрицу смежности
	var adj_graph = []
	for i in range(n):
		adj_graph.append([])
		for j in range(n):
			adj_graph[i].append(0)
	
	# Проходим по всем ребрам (столбцам матрицы инцидентности)
	for j in range(m):
		var vertices = []
		for i in range(n):
			if inc_graph[i][j] == 1:
				vertices.append(i)
			# Если граф ориентированный, можно добавить условие для -1:
			# if incidence_matrix[i][j] == -1
		# Если ребро соединяет две вершины, обновляем матрицу смежности
		if len(vertices) == 2:
			adj_graph[vertices[0]][vertices[1]] = 1
			adj_graph[vertices[1]][vertices[0]] = 1
	#print(adj_graph)
	return adj_graph


func adj_to_inc(adj_graph):
	var n = len(adj_graph)
	var edges = []
	
	# Проходим по верхнему треугольнику матрицы смежности, чтобы избежать дублирования рёбер
	for i in range(n):
		for j in range(i + 1, n):
			if adj_graph[i][j] == 1:
				edges.append([i, j])
	
	# Создаем пустую матрицу инцидентности
	var inc_graph = []
	for i in range(n):
		inc_graph.append([])
		for u in range(len(edges)):
			inc_graph[i].append(0)
	
	# Заполняем матрицу инцидентности
	for e in range(len(edges)):
		var u = edges[e][0]
		var v = edges[e][1]
		inc_graph[u][e] = 1
		inc_graph[v][e] = 1
	#print(inc_graph)
	return inc_graph
