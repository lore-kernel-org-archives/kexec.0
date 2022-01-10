From: kernel test robot <lkp@intel.com>
Date: Tue, 11 Jan 2022 03:30:09 +0800
Subject: [PATCH v4 6/6] module: Move duplicate mod_check_sig users code
 to mod_parse_sig
In-Reply-To: <59d134a3eae4fa802ed9135385cee6fe4838ec01.1641822505.git.msuchanek@suse.de>
References: <59d134a3eae4fa802ed9135385cee6fe4838ec01.1641822505.git.msuchanek@suse.de>
Message-ID: <202201110303.sLPF0o29-lkp@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Michal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on s390/features linus/master jeyu/modules-next v5.16 next-20220110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michal-Suchanek/KEXEC_SIG-with-appended-signature/20220110-215157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220111/202201110303.sLPF0o29-lkp at intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/cc363ca7724d96c534c176b8ed248336f562b7ae
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michal-Suchanek/KEXEC_SIG-with-appended-signature/20220110-215157
        git checkout cc363ca7724d96c534c176b8ed248336f562b7ae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/module_signing.c: In function 'verify_appended_signature':
>> kernel/module_signing.c:33:35: error: passing argument 2 of 'mod_parse_sig' from incompatible pointer type [-Werror=incompatible-pointer-types]
      33 |         ret = mod_parse_sig(data, len, &sig_len, key_being_used_for[purpose]);
         |                                   ^~~
         |                                   |
         |                                   long unsigned int *
   In file included from kernel/module_signing.c:11:
   include/linux/module_signature.h:45:45: note: expected 'size_t *' {aka 'unsigned int *'} but argument is of type 'long unsigned int *'
      45 | int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name);
         |                                     ~~~~~~~~^~~
   kernel/module_signing.c:33:40: error: passing argument 3 of 'mod_parse_sig' from incompatible pointer type [-Werror=incompatible-pointer-types]
      33 |         ret = mod_parse_sig(data, len, &sig_len, key_being_used_for[purpose]);
         |                                        ^~~~~~~~
         |                                        |
         |                                        long unsigned int *
   In file included from kernel/module_signing.c:11:
   include/linux/module_signature.h:45:58: note: expected 'size_t *' {aka 'unsigned int *'} but argument is of type 'long unsigned int *'
      45 | int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name);
         |                                                  ~~~~~~~~^~~~~~~
   cc1: some warnings being treated as errors
--
   security/integrity/ima/ima_modsig.c: In function 'ima_read_modsig':
>> security/integrity/ima/ima_modsig.c:47:33: error: passing argument 2 of 'mod_parse_sig' from incompatible pointer type [-Werror=incompatible-pointer-types]
      47 |         rc = mod_parse_sig(buf, &buf_len, &sig_len, func_tokens[func]);
         |                                 ^~~~~~~~
         |                                 |
         |                                 long unsigned int *
   In file included from security/integrity/ima/ima_modsig.c:12:
   include/linux/module_signature.h:45:45: note: expected 'size_t *' {aka 'unsigned int *'} but argument is of type 'long unsigned int *'
      45 | int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name);
         |                                     ~~~~~~~~^~~
   security/integrity/ima/ima_modsig.c:47:43: error: passing argument 3 of 'mod_parse_sig' from incompatible pointer type [-Werror=incompatible-pointer-types]
      47 |         rc = mod_parse_sig(buf, &buf_len, &sig_len, func_tokens[func]);
         |                                           ^~~~~~~~
         |                                           |
         |                                           long unsigned int *
   In file included from security/integrity/ima/ima_modsig.c:12:
   include/linux/module_signature.h:45:58: note: expected 'size_t *' {aka 'unsigned int *'} but argument is of type 'long unsigned int *'
      45 | int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name);
         |                                                  ~~~~~~~~^~~~~~~
   cc1: some warnings being treated as errors


vim +/mod_parse_sig +33 kernel/module_signing.c

    16	
    17	/**
    18	 * verify_appended_signature - Verify the signature on a module
    19	 * @data: The data to be verified
    20	 * @len: Size of @data.
    21	 * @trusted_keys: Keyring to use for verification
    22	 * @purpose: The use to which the key is being put
    23	 */
    24	int verify_appended_signature(const void *data, unsigned long *len,
    25				      struct key *trusted_keys,
    26				      enum key_being_used_for purpose)
    27	{
    28		unsigned long sig_len;
    29		int ret;
    30	
    31		pr_devel("==>%s %s(,%lu)\n", __func__, key_being_used_for[purpose], *len);
    32	
  > 33		ret = mod_parse_sig(data, len, &sig_len, key_being_used_for[purpose]);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

