def get_varinfo(config_path:str)->[str,[]]:
    f = open(config_path,"r")
    varname = f.readline().strip()
    varidxs = []
    for line in f.readlines():
        for idx in line.split():
            varidxs.append(int(idx.strip())-1)
    f.close()
    return [varname,varidxs]
def output_expression(varname:str,varidxs:[int],linenum=8,databit=2)->None:
    print("{")
    idx_count = 0
    for idx in range(len(varidxs)-1,0,-1):
    # for idx in range(len(varidxs)-1):
        print(("{}[{:"+str(databit)+"}],").format(varname,varidxs[idx]),end=' ')
        if (idx_count+1)%linenum == 0 :
            print("")
        idx_count += 1
    print(("{}[{:"+str(databit)+"}]").format(varname,varidxs[0]))
    # print(("{}[{:"+str(databit)+"}]").format(varname,varidxs[len(varidxs)-1]))
    print("};")
        

def main():
    varname , varidxs = get_varinfo("./ip_table.txt")
    output_expression(varname,varidxs)

if __name__ == "__main__":
    main()
