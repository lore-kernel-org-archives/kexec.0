Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBEDC4707B
	for <kexec@archiver.kernel.org>; Sat, 13 Jan 2024 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JdlPUw4kzSy5fmWG6DrZMSi2QTePJy7lkLKAIibHUUQ=; b=WqzrGk8aqxEU33
	ZcmchMI7Vvp42qBVoicU8AiklDaGU4ehQ8qmXKYEy3iFEhI9Iy/MKp5WrKGRExVvJIlv6RUUHebYr
	rrNzURM4IZ8KgZS6Qd5xUFCSKhWQ6Z15rndU8ncI7MGOtbWGfzeAALXWgVKYiL5fhsJqUqKeYV4KG
	30lZA2BM9RrORO378MIC+XBjflX6+KNTmub2dMbY8NQC4zNX7+NgjZMw59KjeTUAEeIbOjUuDshsI
	hRXvh1/swRHwSe3fxG4C0LNt2lHM5ZkAtL1MUSATTCZuVjer7h0wBTSj+qNLw84w++iWGkx3+ioK6
	cUaXDuP/s19xSq0lMuGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOhUT-005QsW-2d;
	Sat, 13 Jan 2024 17:08:13 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOhUM-005QrB-1i
	for kexec@lists.infradead.org;
	Sat, 13 Jan 2024 17:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705165686; x=1736701686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vWmE/dT1yTfSBYgScFYbn8fx4KW7ZAfBUCis00NG2D8=;
  b=Wo421eB/OC8E6g08lDgbdMM2db5YR2yRiImaNAUQo2S/aW0VNnlKp48A
   +B2p3Zjpa2BLKvgmaBWxmHup8ia1elKV/G1614RmELaEjucr+sll+D3vf
   mmngGUBzSvKxlEi0tt1TnMhLaik+z1/q4UttRxsCXjuj9hzPAvc98xSzn
   Pfyy7r2V94nEXnOGOMpvnVJE0mHHXbR2WJsN2C3zR8SGhthLKlD3Z9/zv
   dRL+ZDCfNzQa1/UdfOvg0NY06moIPJvPVzvVq1Nrmi3jJQ5lJZPDwNdP8
   iIMg7YvZVSd1Otx8ULttcGbdUeP2XhGBBqOsRXVGwp682CDcTE3dPjosR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="389841129"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="389841129"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 09:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="25336943"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 13 Jan 2024 09:07:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOhU6-000Aj6-05;
	Sat, 13 Jan 2024 17:07:50 +0000
Date: Sun, 14 Jan 2024 01:07:03 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
Message-ID: <202401140034.Sh6fQaK6-lkp@intel.com>
References: <20240110071522.1308935-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240110071522.1308935-3-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240113_090806_643798_F137B674 
X-CRM114-Status: GOOD (  20.63  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Coiby,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on v6.7]
[cannot apply to linus/master next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240110-151859
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240110071522.1308935-3-coxu%40redhat.com
patch subject: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
config: i386-buildonly-randconfig-003-20240113 (https://download.01.org/0day-ci/archive/20240114/202401140034.Sh6fQaK6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240114/202401140034.Sh6fQaK6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140034.Sh6fQaK6-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> kernel/crash_dump_dm_crypt.c:8:6: warning: no previous prototype for 'wipe_dm_crypt_key' [-Wmissing-prototypes]
       8 | void wipe_dm_crypt_key(void)
         |      ^~~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_key':
>> kernel/crash_dump_dm_crypt.c:94:16: error: variable 'kbuf' has initializer but incomplete type
      94 |         struct kexec_buf kbuf = {
         |                ^~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:95:18: error: 'struct kexec_buf' has no member named 'image'
      95 |                 .image = image,
         |                  ^~~~~
>> kernel/crash_dump_dm_crypt.c:95:26: warning: excess elements in struct initializer
      95 |                 .image = image,
         |                          ^~~~~
   kernel/crash_dump_dm_crypt.c:95:26: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:96:18: error: 'struct kexec_buf' has no member named 'buf_min'
      96 |                 .buf_min = 0,
         |                  ^~~~~~~
   kernel/crash_dump_dm_crypt.c:96:28: warning: excess elements in struct initializer
      96 |                 .buf_min = 0,
         |                            ^
   kernel/crash_dump_dm_crypt.c:96:28: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:97:18: error: 'struct kexec_buf' has no member named 'buf_max'
      97 |                 .buf_max = ULONG_MAX,
         |                  ^~~~~~~
   In file included from include/linux/limits.h:7,
                    from include/linux/kernel.h:17,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/nospec-branch.h:14,
                    from arch/x86/include/asm/irqflags.h:9,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rbtree.h:24,
                    from include/linux/key.h:15,
                    from include/keys/user-type.h:11,
                    from kernel/crash_dump_dm_crypt.c:2:
>> include/vdso/limits.h:13:25: warning: excess elements in struct initializer
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:97:28: note: in expansion of macro 'ULONG_MAX'
      97 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
   include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:97:28: note: in expansion of macro 'ULONG_MAX'
      97 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:98:18: error: 'struct kexec_buf' has no member named 'top_down'
      98 |                 .top_down = false,
         |                  ^~~~~~~~
   kernel/crash_dump_dm_crypt.c:98:29: warning: excess elements in struct initializer
      98 |                 .top_down = false,
         |                             ^~~~~
   kernel/crash_dump_dm_crypt.c:98:29: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:99:18: error: 'struct kexec_buf' has no member named 'random'
      99 |                 .random = true,
         |                  ^~~~~~
   kernel/crash_dump_dm_crypt.c:99:27: warning: excess elements in struct initializer
      99 |                 .random = true,
         |                           ^~~~
   kernel/crash_dump_dm_crypt.c:99:27: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:94:26: error: storage size of 'kbuf' isn't known
      94 |         struct kexec_buf kbuf = {
         |                          ^~~~
>> kernel/crash_dump_dm_crypt.c:109:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
     109 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:109:20: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/crash_dump_dm_crypt.c:110:15: error: implicit declaration of function 'kexec_add_buffer' [-Werror=implicit-function-declaration]
     110 |         ret = kexec_add_buffer(&kbuf);
         |               ^~~~~~~~~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:94:26: warning: unused variable 'kbuf' [-Wunused-variable]
      94 |         struct kexec_buf kbuf = {
         |                          ^~~~
   cc1: some warnings being treated as errors


vim +/kbuf +94 kernel/crash_dump_dm_crypt.c

     7	
   > 8	void wipe_dm_crypt_key(void)
     9	{
    10		if (dm_crypt_key) {
    11			memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
    12			kfree(dm_crypt_key);
    13			dm_crypt_key = NULL;
    14		}
    15	}
    16	
    17	static void _wipe_dm_crypt_key(struct work_struct *dummy)
    18	{
    19		wipe_dm_crypt_key();
    20	}
    21	
    22	static DECLARE_DELAYED_WORK(wipe_dm_crypt_key_work, _wipe_dm_crypt_key);
    23	
    24	static unsigned __read_mostly wipe_key_delay = 120; /* 2 mins */
    25	
    26	static int crash_save_temp_dm_crypt_key(const char *key_desc, size_t count)
    27	{
    28		const struct user_key_payload *ukp;
    29		struct key *key;
    30	
    31		if (dm_crypt_key) {
    32			memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
    33			kfree(dm_crypt_key);
    34		}
    35	
    36		pr_debug("Requesting key %s", key_desc);
    37		key = request_key(&key_type_user, key_desc, NULL);
    38	
    39		if (IS_ERR(key)) {
    40			pr_debug("No such key %s", key_desc);
    41			return PTR_ERR(key);
    42		}
    43	
    44		ukp = user_key_payload_locked(key);
    45		if (!ukp)
    46			return -EKEYREVOKED;
    47	
    48		dm_crypt_key = kmalloc(ukp->datalen, GFP_KERNEL);
    49		if (!dm_crypt_key)
    50			return -ENOMEM;
    51		memcpy(dm_crypt_key, ukp->data, ukp->datalen);
    52		dm_crypt_key_size = ukp->datalen;
    53		pr_debug("dm crypt key (size=%u): %8ph\n", dm_crypt_key_size, dm_crypt_key);
    54		schedule_delayed_work(&wipe_dm_crypt_key_work,
    55				      round_jiffies_relative(wipe_key_delay * HZ));
    56		return 0;
    57	}
    58	
    59	int crash_sysfs_dm_crypt_key_write(const char *key_desc, size_t count)
    60	{
    61		if (!is_kdump_kernel())
    62			return crash_save_temp_dm_crypt_key(key_desc, count);
    63		return -EINVAL;
    64	}
    65	EXPORT_SYMBOL(crash_sysfs_dm_crypt_key_write);
    66	
    67	int crash_pass_temp_dm_crypt_key(void **addr, unsigned long *sz)
    68	{
    69		unsigned long dm_crypt_key_sz;
    70		unsigned char *buf;
    71		unsigned int *size_ptr;
    72	
    73		if (!dm_crypt_key)
    74			return -EINVAL;
    75	
    76		dm_crypt_key_sz = sizeof(unsigned int) + dm_crypt_key_size * sizeof(u8);
    77	
    78		buf = vzalloc(dm_crypt_key_sz);
    79		if (!buf)
    80			return -ENOMEM;
    81	
    82		size_ptr = (unsigned int *)buf;
    83		memcpy(size_ptr, &dm_crypt_key_size, sizeof(unsigned int));
    84		memcpy(size_ptr + 1, dm_crypt_key, dm_crypt_key_size * sizeof(u8));
    85		*addr = buf;
    86		*sz = dm_crypt_key_sz;
    87		wipe_dm_crypt_key();
    88		return 0;
    89	}
    90	
    91	int crash_load_dm_crypt_key(struct kimage *image)
    92	{
    93		int ret;
  > 94		struct kexec_buf kbuf = {
  > 95			.image = image,
  > 96			.buf_min = 0,
  > 97			.buf_max = ULONG_MAX,
  > 98			.top_down = false,
  > 99			.random = true,
   100		};
   101	
   102		image->dm_crypt_key_addr = 0;
   103		ret = crash_pass_temp_dm_crypt_key(&kbuf.buffer, &kbuf.bufsz);
   104		if (ret)
   105			return ret;
   106	
   107		kbuf.memsz = kbuf.bufsz;
   108		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 > 109		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 > 110		ret = kexec_add_buffer(&kbuf);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
