Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEBDC47DB7
	for <kexec@archiver.kernel.org>; Sat, 20 Jan 2024 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dov9PHrx2Gx9wOREo2Oc3xcoxgZBDLKrJPaZGIOGWF8=; b=3H8fx/QcvUgkey
	vdGxg3TzNtx0xUm6VT9NQBjTaLjsjHor+gaB8exVCK4JGC38IgC3fACIf3NhLUatCy+NoRvSb4GmD
	F+os1jcYayXk/3ZUN/Mc0ajBxJLVgutii0cPgj17MA9n1Ei4bELpaIpAQeMp32Rnx3OpLRzWrYKRc
	fCT0dZeSTcZ+Tg+g73ma7uDPJDgJF8wBwB90HFZ47Bh99DRvg23TARxfI5U11R5r1BwuTb9MRDTGE
	ZN2wVv2HpIGc9KkdJTETyc0o6BQLD2iNfwAH52z539luwxy+gcbIQLFKf7YxBlp87AbOm3KNy7lW7
	0mP0vuJXQ9pdcwpMPSKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRAFQ-007rNK-0U;
	Sat, 20 Jan 2024 12:14:52 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRAFK-007rMo-13;
	Sat, 20 Jan 2024 12:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705752887; x=1737288887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lYlNdQ0Gc+gMkO+7wnw6RT9UdR/P8tIvnMQnN95xP0A=;
  b=l26Ystvj9e2Z9O+wbjDuhr+s1dpFonzLCWLP8LnyCSxUUZ92PKRi91UZ
   FVQyiT0aBvwlY6vLiF278CagL2y7nF3Qmlos1nvtUPtwKLdi6wNWAEfA/
   t+xvSZgS7I4jZTy7nLfUjfl+xBS39pWA4SatlKLB8gxPux5gmbyE5BcH+
   vLsUIczNwtBpf85QBlnu/Pk6ALec8KPGRD6hoJWxbn8Wa45IUk6a+ZHai
   7L9EWPIrXBl/Qb+DIq1uyPU+ygI4//zWORUmnI9rm0+X56P1KoXNH8AjA
   sYhai7Gji6bISnkucc5xbR5KkqmhdIm5mAslXpLQao0rXMw7P0xohb1jQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="19508284"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="19508284"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 04:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="26963912"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2024 04:14:39 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRAFA-00054k-0l;
	Sat, 20 Jan 2024 12:14:36 +0000
Date: Sat, 20 Jan 2024 20:13:45 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, akpm@linux-foundation.org,
	ebiederm@xmission.com, hbathini@linux.ibm.com, piliu@redhat.com,
	viro@zeniv.linux.org.uk, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 11/14] arm, crash: wrap crash dumping code into crash
 related ifdefs
Message-ID: <202401202057.aPg08Eh8-lkp@intel.com>
References: <20240119145241.769622-12-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119145241.769622-12-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240120_041446_443303_A1585CF1 
X-CRM114-Status: GOOD (  15.02  )
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

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[cannot apply to tip/x86/core arm64/for-next/core powerpc/next powerpc/fixes v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec-split-crashkernel-reservation-code-out-from-crash_core-c/20240119-225820
base:   linus/master
patch link:    https://lore.kernel.org/r/20240119145241.769622-12-bhe%40redhat.com
patch subject: [PATCH v2 11/14] arm, crash: wrap crash dumping code into crash related ifdefs
config: arm-randconfig-001-20240120 (https://download.01.org/0day-ci/archive/20240120/202401202057.aPg08Eh8-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d92ce344bf641e6bb025b41b3f1a77dd25e2b3e9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401202057.aPg08Eh8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401202057.aPg08Eh8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm/kernel/setup.c:1036:49: error: use of undeclared identifier 'SECTION_SIZE'
    1036 |                 start = memblock_phys_alloc_range(crash_size, SECTION_SIZE,
         |                                                               ^
   1 error generated.


vim +/SECTION_SIZE +1036 arch/arm/kernel/setup.c

3c57fb43c8fcbe Mika Westerberg 2010-05-10   995  
3c57fb43c8fcbe Mika Westerberg 2010-05-10   996  /**
3c57fb43c8fcbe Mika Westerberg 2010-05-10   997   * reserve_crashkernel() - reserves memory are for crash kernel
3c57fb43c8fcbe Mika Westerberg 2010-05-10   998   *
3c57fb43c8fcbe Mika Westerberg 2010-05-10   999   * This function reserves memory area given in "crashkernel=" kernel command
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1000   * line parameter. The memory reserved is used by a dump capture kernel when
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1001   * primary kernel is crashing.
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1002   */
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1003  static void __init reserve_crashkernel(void)
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1004  {
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1005  	unsigned long long crash_size, crash_base;
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1006  	unsigned long long total_mem;
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1007  	int ret;
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1008  
8f460484669cba Baoquan He      2024-01-19  1009  	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
8f460484669cba Baoquan He      2024-01-19  1010  		return;
8f460484669cba Baoquan He      2024-01-19  1011  
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1012  	total_mem = get_total_mem();
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1013  	ret = parse_crashkernel(boot_command_line, total_mem,
a9e1a3d84e4a0e Baoquan He      2023-09-14  1014  				&crash_size, &crash_base,
a9e1a3d84e4a0e Baoquan He      2023-09-14  1015  				NULL, NULL);
9d17f337230642 Austin Kim      2022-04-01  1016  	/* invalid value specified or crashkernel=0 */
9d17f337230642 Austin Kim      2022-04-01  1017  	if (ret || !crash_size)
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1018  		return;
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1019  
61603016e2122b Russell King    2016-03-14  1020  	if (crash_base <= 0) {
d0506a2395eb07 Russell King    2016-04-01  1021  		unsigned long long crash_max = idmap_to_phys((u32)~0);
67556d7a851c20 Russell King    2017-07-19  1022  		unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
67556d7a851c20 Russell King    2017-07-19  1023  		if (crash_max > lowmem_max)
67556d7a851c20 Russell King    2017-07-19  1024  			crash_max = lowmem_max;
a7259df7670240 Mike Rapoport   2021-09-02  1025  
a7259df7670240 Mike Rapoport   2021-09-02  1026  		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
a7259df7670240 Mike Rapoport   2021-09-02  1027  						       CRASH_ALIGN, crash_max);
61603016e2122b Russell King    2016-03-14  1028  		if (!crash_base) {
61603016e2122b Russell King    2016-03-14  1029  			pr_err("crashkernel reservation failed - No suitable area found.\n");
61603016e2122b Russell King    2016-03-14  1030  			return;
61603016e2122b Russell King    2016-03-14  1031  		}
61603016e2122b Russell King    2016-03-14  1032  	} else {
a7259df7670240 Mike Rapoport   2021-09-02  1033  		unsigned long long crash_max = crash_base + crash_size;
61603016e2122b Russell King    2016-03-14  1034  		unsigned long long start;
61603016e2122b Russell King    2016-03-14  1035  
a7259df7670240 Mike Rapoport   2021-09-02 @1036  		start = memblock_phys_alloc_range(crash_size, SECTION_SIZE,
a7259df7670240 Mike Rapoport   2021-09-02  1037  						  crash_base, crash_max);
a7259df7670240 Mike Rapoport   2021-09-02  1038  		if (!start) {
61603016e2122b Russell King    2016-03-14  1039  			pr_err("crashkernel reservation failed - memory is in use.\n");
61603016e2122b Russell King    2016-03-14  1040  			return;
61603016e2122b Russell King    2016-03-14  1041  		}
61603016e2122b Russell King    2016-03-14  1042  	}
61603016e2122b Russell King    2016-03-14  1043  
1b0f6681fcbc0e Olof Johansson  2013-12-05  1044  	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1045  		(unsigned long)(crash_size >> 20),
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1046  		(unsigned long)(crash_base >> 20),
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1047  		(unsigned long)(total_mem >> 20));
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1048  
f7f0b7dc720f81 Russell King    2016-08-02  1049  	/* The crashk resource must always be located in normal mem */
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1050  	crashk_res.start = crash_base;
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1051  	crashk_res.end = crash_base + crash_size - 1;
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1052  	insert_resource(&iomem_resource, &crashk_res);
f7f0b7dc720f81 Russell King    2016-08-02  1053  
f7f0b7dc720f81 Russell King    2016-08-02  1054  	if (arm_has_idmap_alias()) {
f7f0b7dc720f81 Russell King    2016-08-02  1055  		/*
f7f0b7dc720f81 Russell King    2016-08-02  1056  		 * If we have a special RAM alias for use at boot, we
f7f0b7dc720f81 Russell King    2016-08-02  1057  		 * need to advertise to kexec tools where the alias is.
f7f0b7dc720f81 Russell King    2016-08-02  1058  		 */
f7f0b7dc720f81 Russell King    2016-08-02  1059  		static struct resource crashk_boot_res = {
f7f0b7dc720f81 Russell King    2016-08-02  1060  			.name = "Crash kernel (boot alias)",
f7f0b7dc720f81 Russell King    2016-08-02  1061  			.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
f7f0b7dc720f81 Russell King    2016-08-02  1062  		};
f7f0b7dc720f81 Russell King    2016-08-02  1063  
f7f0b7dc720f81 Russell King    2016-08-02  1064  		crashk_boot_res.start = phys_to_idmap(crash_base);
f7f0b7dc720f81 Russell King    2016-08-02  1065  		crashk_boot_res.end = crashk_boot_res.start + crash_size - 1;
f7f0b7dc720f81 Russell King    2016-08-02  1066  		insert_resource(&iomem_resource, &crashk_boot_res);
f7f0b7dc720f81 Russell King    2016-08-02  1067  	}
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1068  }
3c57fb43c8fcbe Mika Westerberg 2010-05-10  1069  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
