Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C0C67861
	for <kexec@archiver.kernel.org>; Fri,  5 Apr 2024 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4VFJUq97ha3ae1q/BrCmodCcTcWvD5W3XnTfaNM3nW0=; b=ZOxU+HaZwZTYzd
	WQcxJiReG66x1A4GoJJ6lhvVFeYLKik7N1BElpF9s3CzzFDv8eVWrpbemHEWKN7Op4UAmMa1Blgld
	CAr6ErVCzE/mnPaYjEopKwvptYvMOhPsfyjKDy7AO9xiPog9u4K0mLjLjstNeyNtd2G0Q8VQghzSC
	ac8Ob2JDg2CbRaSVglA1j7xdR9yo1LZN5kOg9qohebnYtuogP9ErL3fMKVY1xWE1vtqMBywYBVRof
	mjZsgQZHoUo3LvHw338eldVa0eVCS8k5MFfNeXzEihY6CMQMq2JNGRWlbvuZVVrTNnUiyGQuujUTX
	d7v4DwhOQ0kUjhyqTdMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshrO-00000006ho9-3aUU;
	Fri, 05 Apr 2024 11:35:54 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshrL-00000006hlh-2wb2
	for kexec@lists.infradead.org;
	Fri, 05 Apr 2024 11:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712316952; x=1743852952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K7i60+sSZKMcg+5XCR700KMaSBu51hz4EyNyn5CxZG4=;
  b=ME7ZNXB9LUsf/kV1Qo0RwlMF2tTk9Tzn6K9oUCj/n8cUjXTYagJGRaOu
   D5oPISuYPM4ezd/XW16RLIZ4pIzVCu9DFPIJRAF+Jvbdko/Ynklaay3FT
   wOxhdC2aOye0hzVhpNgv2N34SVuj0Bdw+RKuTNM1BhvsIEnoDNBongzbq
   wApp40xgqplaUo0RfnU5l9j8YIXt+0n/+WxcqntzoVA00lexPyzydhk98
   /e2sEZcQyMI5Agv9cJ+G0Dvu63xNnyWw84L2knEzSRu+pB0bLfTPTd7Dq
   MGpoIEz8lpWb5LmO/LVLsTQGkIdxzOtG++tV+G4cu/M9aZEamx20yqlmu
   g==;
X-CSE-ConnectionGUID: NbVVF5fYQKiotgVY08ZukA==
X-CSE-MsgGUID: 7XQTqXoOTmyN7Zbim9IFaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7489769"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7489769"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 04:35:49 -0700
X-CSE-ConnectionGUID: RimbYi2GQG6jWw/a34KdQg==
X-CSE-MsgGUID: EXGqfF/sS8OYTSgEDilWUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="42303288"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Apr 2024 04:35:42 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rshrA-0002DC-1T;
	Fri, 05 Apr 2024 11:35:40 +0000
Date: Fri, 5 Apr 2024 19:34:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <202404051912.7Boy0XDE-lkp@intel.com>
References: <41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_043551_926299_2472CBF2 
X-CRM114-Status: GOOD (  10.88  )
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

Hi Ashish,

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on linus/master v6.9-rc2 next-20240405]
[cannot apply to tip/x86/core tip/master tip/x86/mm tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Kalra/efi-x86-skip-efi_arch_mem_reserve-in-case-of-kexec/20240405-071346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra%40amd.com
patch subject: [PATCH v3 4/4] x86/snp: Convert shared memory back to private on kexec
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240405/202404051912.7Boy0XDE-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404051912.7Boy0XDE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404051912.7Boy0XDE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   ld: arch/x86/kernel/head64.o: in function `snp_kexec_unshare_mem':
>> head64.c:(.text+0x110): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/nmi.o: in function `snp_kexec_unshare_mem':
   nmi.c:(.text+0x820): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/probe_roms.o: in function `snp_kexec_unshare_mem':
   probe_roms.c:(.text+0x370): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/cpu/common.o: in function `snp_kexec_unshare_mem':
   common.c:(.text+0x530): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/cpu/amd.o: in function `snp_kexec_unshare_mem':
   amd.c:(.text+0x12b0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/smpboot.o: in function `snp_kexec_unshare_mem':
   smpboot.c:(.text+0xfa0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/crash.o: in function `snp_kexec_unshare_mem':
   crash.c:(.text+0xa0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/mm/fault.o: in function `snp_kexec_unshare_mem':
   fault.c:(.text+0x1ce0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/mm/extable.o: in function `snp_kexec_unshare_mem':
   extable.c:(.text+0x330): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/platform/efi/efi_64.o: in function `snp_kexec_unshare_mem':
   efi_64.c:(.text+0x160): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: drivers/iommu/amd/init.o: in function `snp_kexec_unshare_mem':
   init.c:(.text+0x15e0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
--
   In file included from arch/x86/realmode/init.c:12:
>> arch/x86/include/asm/sev.h:265:6: warning: no previous prototype for 'snp_kexec_unshare_mem' [-Wmissing-prototypes]
     265 | void snp_kexec_unshare_mem(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/sev.h:266:13: warning: 'snp_kexec_stop_conversion' defined but not used [-Wunused-function]
     266 | static void snp_kexec_stop_conversion(bool crash) {}
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
