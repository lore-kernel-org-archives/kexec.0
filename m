From: kernel test robot <lkp@intel.com>
Date: Fri, 8 Apr 2022 21:17:51 +0800
Subject: [PATCH v5 RESEND 1/3] vmcore: Convert copy_oldmem_page() to take
 an iov_iter
In-Reply-To: <20220408090636.560886-2-bhe@redhat.com>
References: <20220408090636.560886-2-bhe@redhat.com>
Message-ID: <202204082128.JKXXDGpa-lkp@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Baoquan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on s390/features linus/master v5.18-rc1 next-20220408]
[cannot apply to tip/x86/core hnaz-mm/master arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/Convert-vmcore-to-use-an-iov_iter/20220408-170846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: sh-randconfig-s032-20220408 (https://download.01.org/0day-ci/archive/20220408/202204082128.JKXXDGpa-lkp at intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a5e42962f5c0bea73aa382a2415094b4bd6c6c73
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baoquan-He/Convert-vmcore-to-use-an-iov_iter/20220408-170846
        git checkout a5e42962f5c0bea73aa382a2415094b4bd6c6c73
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/crash_dump.c:23:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem * @@
   arch/sh/kernel/crash_dump.c:23:36: sparse:     expected void const *addr
   arch/sh/kernel/crash_dump.c:23:36: sparse:     got void [noderef] __iomem *

vim +23 arch/sh/kernel/crash_dump.c

    13	
    14	ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
    15				 size_t csize, unsigned long offset)
    16	{
    17		void  __iomem *vaddr;
    18	
    19		if (!csize)
    20			return 0;
    21	
    22		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
  > 23		csize = copy_to_iter(vaddr + offset, csize, iter);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

