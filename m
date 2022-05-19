From: kernel test robot <lkp@intel.com>
Date: Thu, 19 May 2022 23:17:48 +0800
Subject: [PATCH v2] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
In-Reply-To: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <202205192320.CoXevcfR-lkp@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi "Naveen,

I love your patch! Yet something to improve:

[auto build test ERROR on f993aed406eaf968ba3867a76bb46c95336a33d0]

url:    https://github.com/intel-lab-lkp/linux/commits/Naveen-N-Rao/kexec_file-Drop-weak-attribute-from-arch_kexec_apply_relocations-_add/20220519-171432
base:   f993aed406eaf968ba3867a76bb46c95336a33d0
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220519/202205192320.CoXevcfR-lkp at intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/67171688c71cb5b05f26e0dfc45eec8d8d1428ff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naveen-N-Rao/kexec_file-Drop-weak-attribute-from-arch_kexec_apply_relocations-_add/20220519-171432
        git checkout 67171688c71cb5b05f26e0dfc45eec8d8d1428ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/machine_kexec_reloc.c:3:
>> arch/s390/include/asm/kexec.h:89:38: error: unknown type name 'Elf_Shdr'; did you mean 'elf_shdr'?
      89 |                                      Elf_Shdr *section,
         |                                      ^~~~~~~~
         |                                      elf_shdr
   arch/s390/include/asm/kexec.h:90:44: error: unknown type name 'Elf_Shdr'
      90 |                                      const Elf_Shdr *relsec,
         |                                            ^~~~~~~~
   arch/s390/include/asm/kexec.h:91:44: error: unknown type name 'Elf_Shdr'
      91 |                                      const Elf_Shdr *symtab);
         |                                            ^~~~~~~~


vim +89 arch/s390/include/asm/kexec.h

    85	
    86	#ifdef CONFIG_KEXEC_FILE
    87	struct purgatory_info;
    88	int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
  > 89					     Elf_Shdr *section,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

