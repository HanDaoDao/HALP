# -*- coding: UTF-8 -*-  
#!/usr/bin/env python3 

import os
import glob

count100k = 0
count50k = 0
count10k = 0
count = 0
sumSize = 0
# 寻找每个仓库的Resources文件中的png大小
def findResource_item(path):
	global count100k
	global count50k
	global count10k
	global count
	num100k = 0
	num50k = 0
	num10k = 0
	sumBgSize = 0
	for dirname, _, filenames in os.walk(path):
		# print('dirname = ',dirname,'filename = ',filenames)
		# if not dirname.endswith('Resources'):
		# 	continue
		# print('dirname = ',dirname)

		for filename in filenames:
			if not filename.endswith('.png'):
				continue
			# print(filename)
			# 图片路径
			filePath = dirname + '/' + filename
			# print(filePath)

			# 获取图片大小
			fileSize = get_FileSize(filePath)
			# get_FileRang(fileSize)
			if fileSize >= (1024 * 100):
				num100k += 1
			elif fileSize >= (1024 * 50):
				num50k += 1
			elif fileSize >= (1024 * 10):
				num10k += 1
	print(num100k)
	print(num50k)
	print(num10k)


	count100k += num100k
	count50k += num50k
	count10k += num10k
        
			# sumBgSize += fileSize
	# 仓库图片大小
	# print(sumBgSize/float(1024))
	

# 获取文件大小
def get_FileSize(filePath):
	global sumSize
	filePath = unicode(filePath,'UTF-8')
	fsize = os.stat(filePath).st_size
	# print(fsize)
	sumSize += fsize
	return fsize

# 文件大小范围统计

# 输出文件个数
def fileNumbers():
	print(count100k)
	print(count50k)
	print(count10k)
	print(count)

# 遍历仓库文件夹
for item in os.listdir('.'):
	if not os.path.isdir(item):
		continue
	print(item)
	findResource_item(item)
	print'\n'

fileNumbers()
print('sumSize',sumSize / float(1024*1024))








