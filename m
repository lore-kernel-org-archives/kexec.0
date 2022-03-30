From: kernel test robot <lkp@intel.com>
Date: Wed, 30 Mar 2022 21:29:57 +0800
Subject: [PATCH v2 -next 5/6] RISC-V: Add purgatory
In-Reply-To: <20220330081701.177026-6-lizhengyu3@huawei.com>
References: <20220330081701.177026-6-lizhengyu3@huawei.com>
Message-ID: <202203302109.2IHqpKOe-lkp@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220329]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhengyu/riscv-kexec-add-kexec_file_load-support/20220330-162008
base:    c2528a0cdebd8ba7ef30e0655f8ea89f34c3a633
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220330/202203302109.2IHqpKOe-lkp at intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f59da20dab679116176a82c5b23517ce69584123
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Zhengyu/riscv-kexec-add-kexec_file_load-support/20220330-162008
        git checkout f59da20dab679116176a82c5b23517ce69584123
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/purgatory/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/purgatory/purgatory.c:20:5: warning: no previous prototype for 'verify_sha256_digest' [-Wmissing-prototypes]
      20 | int verify_sha256_digest(void)
         |     ^~~~~~~~~~~~~~~~~~~~
>> arch/riscv/purgatory/purgatory.c:36:6: warning: no previous prototype for 'purgatory' [-Wmissing-prototypes]
      36 | void purgatory(void)
         |      ^~~~~~~~~


vim +/verify_sha256_digest +20 arch/riscv/purgatory/purgatory.c

    19	
  > 20	int verify_sha256_digest(void)
    21	{
    22		struct kexec_sha_region *ptr, *end;
    23		struct sha256_state ss;
    24		u8 digest[SHA256_DIGEST_SIZE];
    25	
    26		sha256_init(&ss);
    27		end = purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);
    28		for (ptr = purgatory_sha_regions; ptr < end; ptr++)
    29			sha256_update(&ss, (uint8_t *)(ptr->start), ptr->len);
    30		sha256_final(&ss, digest);
    31		if (memcmp(digest, purgatory_sha256_digest, sizeof(digest)) != 0)
    32			return 1;
    33		return 0;
    34	}
    35	
  > 36	void purgatory(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

