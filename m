Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C952C67861
	for <kexec@archiver.kernel.org>; Fri,  5 Apr 2024 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X6FI7ujbZS/8jd4lhkJIUCG5fWb+Br/PhBeZ8pRlScM=; b=GKRZ0OuWBf+jdH
	7MSThSpqivPDVVhsQBbxfFwnwIoQ1usTHTWjroNhFsXT8b9cYldZRQTPPiYrOUrhO904iaevQca2z
	6xEOMs2XPQBUMZnwwI2huOJvWz15k6IruMxtaj9vHXHJ9T9cIZln9HKMbZHYsxMGi1JnVYuexm/Hw
	lzfLqi1xUhfBL+nVvFRzuTcifU+3X6y6ASQcQJ81lGPuYCn5AmC2jnDtTQlqiE1LyQ0oJxBZTHQAj
	efJhgT8Ls00r5n0Y0RUPOv9lZVcdzcf0WL06btNvRwLoiXXUJiFcuKYlEKBUyBPnAMj/DhfzjOh/l
	PuuAzeGSGoHa8O8vPKng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshnZ-00000006h8W-0j6H;
	Fri, 05 Apr 2024 11:31:57 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshnV-00000006h6z-1fur
	for kexec@lists.infradead.org;
	Fri, 05 Apr 2024 11:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712316713; x=1743852713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P1Q+TD9aXToHjoMZ5pt7Cig3oxiTyod8aYgAxTlsc1U=;
  b=OxN+uDhs0arKLMjyfceOe5mj8xCqXlmd4qOIbgZJJkaiz8T3x/MbGwO7
   k4eo3wuhGnXIr+659WXgHTTT/VAcN4MFp5UKKWaYCekicXPG9grC2wjIi
   d+lKP2ji2xvVztgrqBnY7whgXOFv2qS71xhbUOFn9WbhDJOiu2Mt1PssO
   GKatqj2ZprPwwIdje+uS5P3622MZoOsGbMF7DrBLZ6xgyg2SDyY1iwfr8
   McBRuNN3+mLn9kyHIIRo6p7ILA/RbFOJVereG9msViiw3zUdNTkiF5i1d
   QWqK3in0wErxOT3oXzAVzb9ZHUY11sbmTheoL2MXKXtySM3z98pfjkoGJ
   A==;
X-CSE-ConnectionGUID: jD2AFQLLRrGxTWKrzxStvw==
X-CSE-MsgGUID: G3MZFGXWRkmkaMnhdzQtoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7523942"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7523942"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 04:31:49 -0700
X-CSE-ConnectionGUID: nA6gWKx0REmM0LXYHDtZ+w==
X-CSE-MsgGUID: ctCtU/n4QCCmod+41Sd0ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19056002"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Apr 2024 04:31:43 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rshnI-0002Cq-10;
	Fri, 05 Apr 2024 11:31:40 +0000
Date: Fri, 5 Apr 2024 19:30:59 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <202404051940.mApchEy0-lkp@intel.com>
References: <41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_043153_534267_CDA23308 
X-CRM114-Status: GOOD (  10.32  )
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
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240405/202404051940.mApchEy0-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404051940.mApchEy0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404051940.mApchEy0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: snp_kexec_unshare_mem
   >>> defined at init.c
   >>>            arch/x86/realmode/init.o:(snp_kexec_unshare_mem) in archive vmlinux.a
   >>> defined at extable.c
   >>>            arch/x86/mm/extable.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: snp_kexec_unshare_mem
   >>> defined at init.c
   >>>            arch/x86/realmode/init.o:(snp_kexec_unshare_mem) in archive vmlinux.a
   >>> defined at fault.c
   >>>            arch/x86/mm/fault.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: snp_kexec_unshare_mem
   >>> defined at init.c
   >>>            arch/x86/realmode/init.o:(snp_kexec_unshare_mem) in archive vmlinux.a
   >>> defined at amd.c
   >>>            arch/x86/kernel/cpu/amd.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: snp_kexec_unshare_mem
   >>> defined at init.c
   >>>            arch/x86/realmode/init.o:(snp_kexec_unshare_mem) in archive vmlinux.a
   >>> defined at common.c
   >>>            arch/x86/kernel/cpu/common.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: snp_kexec_unshare_mem
   >>> defined at init.c
   >>>            arch/x86/realmode/init.o:(snp_kexec_unshare_mem) in archive vmlinux.a
   >>> defined at probe_roms.c
   >>>            arch/x86/kernel/probe_roms.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: snp_kexec_unshare_mem
   >>> defined at init.c
   >>>            arch/x86/realmode/init.o:(snp_kexec_unshare_mem) in archive vmlinux.a
   >>> defined at nmi.c
   >>>            arch/x86/kernel/nmi.o:(.text+0x0) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: snp_kexec_unshare_mem
   >>> defined at init.c
   >>>            arch/x86/realmode/init.o:(snp_kexec_unshare_mem) in archive vmlinux.a
   >>> defined at head64.c
   >>>            arch/x86/kernel/head64.o:(.text+0x0) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
