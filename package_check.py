# coding = utf-8
import os
import re


class package_seeker():
    def __init__(self, path):
        self.path = path

    def find_notebook(self, dir, path_list):
        files = os.listdir(dir)
        for file in files:
            file_path = os.path.join(dir, file)

            if os.path.isdir(file_path):
                if not file[0] == '.':
                    self.find_notebook(file_path, path_list)
            else:
                # note that some files don't have postfix, like dockerfile
                file_name = file.split('.')
                if len(file_name) > 1 and file_name[1] == 'ipynb':
                        file_path = os.path.join(dir, file)
                        path_list.append(file_path)
        return path_list

    def parse_notebook(self, path):
        file = open(path, 'r', encoding='utf-8')
        content = file.read()
        # from sklearn.naive_bayes import GaussianNB
        pattern = '"(.*import.*)"'
        rows = re.findall(pattern, content)
        rough = []
        for row in rows:
            s = row.split(' ')[1]
            s = re.search('\\w*', s).group(0)
            rough.append(s)
        # print('rough:', rough)
        return rough

    def get_package_list(self):
        path_list = self.find_notebook(path, [])
        package_list = []
        for i in path_list:
            package_list += self.parse_notebook(i)
        package_list = list(set(package_list))
        package_list.sort()
        print(package_list)
        return package_list


# path = '/home/lenke/projects/statistical-learning-method/'
path = 'E:\MyProjects\statistical-learning-method'
# path = 'E:\\MyProjects\\problem_fix'
l = package_seeker(path).get_package_list()
# ['collections', 'graphviz', 'itertools', 'math', 'matplotlib', 'numpy', 'pandas', 'pprint', 'scipy', 'sklearn']
print(l)
