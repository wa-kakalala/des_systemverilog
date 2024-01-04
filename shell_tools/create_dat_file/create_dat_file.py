def get_varinfo(config_path:str)->[]:
    f = open(config_path,"r")
    varidxs = []
    for line in f.readlines():
        for idx in line.split():
            varidxs.append(int(idx.strip()))
    f.close()
    return varidxs

def output_data(data_path:str,var_list:[])->None:
    f = open(data_path,"w")
    for num in var_list[:-1]:
        f.write(hex(num)[2:])
        f.write("\n")
    f.write(hex(var_list[-1])[2:])
    f.close()

def main():
    for idx in range(1,9):
        file_name = "s_table_"+str(idx)
        var_list = get_varinfo(file_name+".txt")
        output_data("./output/"+file_name+".dat",var_list)
    



if __name__ == "__main__":
    main()