#!/usr/bin/env python
'''
' Author:   Cheng-Shih Wong
' Email:    mob5566@gmail.com
' Date:     
'''

def main():
    pass

if __name__ == '__main__':
    import sys, os
    if len(sys.argv)>1 and os.path.exists(sys.argv[1]):
        sys.stdin = open(sys.argv[1], 'rb')
    st = time()
    main()
    print('----- Run {:.6f} seconds. -----'.format(time()-st), file=sys.stderr)
