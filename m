From: kernel test robot <lkp@intel.com>
Date: Sat, 8 Jan 2022 22:58:56 +0800
Subject: [PATCH v3 3/6] kexec_file: Don't opencode appended signature
 verification.
In-Reply-To: <378d956adfa3be2a6d95a71391b4bb2f7458ada3.1641555875.git.msuchanek@suse.de>
References: <378d956adfa3be2a6d95a71391b4bb2f7458ada3.1641555875.git.msuchanek@suse.de>
Message-ID: <202201082218.opQ7qKfJ-lkp@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Michal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on s390/features linus/master jeyu/modules-next v5.16-rc8 next-20220107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michal-Suchanek/KEXEC_SIG-with-appended-signature/20220107-195818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: arc-randconfig-r043-20220107 (https://download.01.org/0day-ci/archive/20220108/202201082218.opQ7qKfJ-lkp at intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c59400c94a653abe5a5fbfd5bc166bd3ac1ebb41
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michal-Suchanek/KEXEC_SIG-with-appended-signature/20220107-195818
        git checkout c59400c94a653abe5a5fbfd5bc166bd3ac1ebb41
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/module.c: In function 'module_sig_check':
>> kernel/module.c:2898:54: error: passing argument 2 of 'verify_appended_signature' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2898 |                 err = verify_appended_signature(mod, &info->len,
         |                                                      ^~~~~~~~~~
         |                                                      |
         |                                                      long unsigned int *
   In file included from kernel/module.c:60:
   include/linux/verification.h:63:57: note: expected 'size_t *' {aka 'unsigned int *'} but argument is of type 'long unsigned int *'
      63 | int verify_appended_signature(const void *data, size_t *len, struct key *trusted_keys,
         |                                                 ~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/verify_appended_signature +2898 kernel/module.c

  2880	
  2881	#ifdef CONFIG_MODULE_SIG
  2882	static int module_sig_check(struct load_info *info, int flags)
  2883	{
  2884		int err = -ENODATA;
  2885		const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
  2886		const char *reason;
  2887		const void *mod = info->hdr;
  2888	
  2889		/*
  2890		 * Require flags == 0, as a module with version information
  2891		 * removed is no longer the module that was signed
  2892		 */
  2893		if (flags == 0 &&
  2894		    info->len > markerlen &&
  2895		    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
  2896			/* We truncate the module to discard the signature */
  2897			info->len -= markerlen;
> 2898			err = verify_appended_signature(mod, &info->len,
  2899							VERIFY_USE_SECONDARY_KEYRING, "module");
  2900			if (!err) {
  2901				info->sig_ok = true;
  2902				return 0;
  2903			}
  2904		}
  2905	
  2906		/*
  2907		 * We don't permit modules to be loaded into the trusted kernels
  2908		 * without a valid signature on them, but if we're not enforcing,
  2909		 * certain errors are non-fatal.
  2910		 */
  2911		switch (err) {
  2912		case -ENODATA:
  2913			reason = "unsigned module";
  2914			break;
  2915		case -ENOPKG:
  2916			reason = "module with unsupported crypto";
  2917			break;
  2918		case -ENOKEY:
  2919			reason = "module with unavailable key";
  2920			break;
  2921	
  2922		default:
  2923			/*
  2924			 * All other errors are fatal, including lack of memory,
  2925			 * unparseable signatures, and signature check failures --
  2926			 * even if signatures aren't required.
  2927			 */
  2928			return err;
  2929		}
  2930	
  2931		if (is_module_sig_enforced()) {
  2932			pr_notice("Loading of %s is rejected\n", reason);
  2933			return -EKEYREJECTED;
  2934		}
  2935	
  2936		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
  2937	}
  2938	#else /* !CONFIG_MODULE_SIG */
  2939	static int module_sig_check(struct load_info *info, int flags)
  2940	{
  2941		return 0;
  2942	}
  2943	#endif /* !CONFIG_MODULE_SIG */
  2944	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

