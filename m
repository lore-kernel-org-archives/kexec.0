Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453E9C4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bal3vq7VkBTjYa0x4PUcZXGonL7Ezv6rECsV+VwN6FA=; b=vo5k0Cc6eQe2U3
	6kPcB9kJGVMEom9g0PvL1YxnBvxP8iF84LWanJyTX85hla2vSqHNP7fTpo9Ng7Ww8tgx5eaLFIGht
	+N04eH7Ole8UE6CRXyaIL4gLLPQ9QLpcjOFEW4TqrFHXxeE5gEmzM7bw853iY8BcjGx18H4P8E3sE
	EWQsBUHD50Hnxcz4JY58ttQRsxcxcdypIQp5bm69upw86HOxu7snVimqbiZtHi1IebrQ3U8Wf3UG8
	qZ4oIx9h8lz+2jEMG/URh65N8BnyuWLcQUZocC1+YL0uVxyKLFtnnYnRe8uw2h0AlSmI2uGBJiRKM
	WoChQ5tBG1fXWBNny0jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAYbm-007us4-2b;
	Tue, 05 Dec 2023 16:49:18 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAYbj-007uoH-0C
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 16:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701794955; x=1733330955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7vZuH5HdSCPRNmPWg/voqIUI80Iu2AQu2Qzt7cwlHqI=;
  b=ObJ8vgKlOPPjtzbU6cH36xGUayQPAi9oYqaercy2kqzm4rPa8rol5/HC
   edo3FvPVm5dWV4Rkic0D+0MfCjIs4iaRzqkXlIvtxZ0W6NlATWE7YNUS/
   gd9ai/K9gBIEBa5NcqSKpG6KxoO4tKFdCpbxn6bqnKDCnBTIbZH42DfWD
   /a/Nom1fKYCCTj2ZrE5hyq2akn3LN5cAISMxL5XxECnnQo2clLz6rAqw9
   KvAHkpT0UnUofSZrcizCTwdAZXqTPhKGWc2DqxWiFcMVhIoxejtcG0YO7
   K0O7XYmRjMrg/EpWkKkIV7geGE4Y2jfO5zrbFd7hnJG7Xnt0/niAdq/1u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396714342"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="396714342"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944328444"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="944328444"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 08:49:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAYbU-0009OE-1c;
	Tue, 05 Dec 2023 16:49:00 +0000
Date: Wed, 6 Dec 2023 00:48:40 +0800
From: kernel test robot <lkp@intel.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Baoquan He <bhe@redhat.com>, x86@kernel.org,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v13 6/6] powerpc: add crash memory hotplug support
Message-ID: <202312060059.JITEJl8B-lkp@intel.com>
References: <20231204053253.25305-7-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231204053253.25305-7-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_084915_241445_B6659002 
X-CRM114-Status: GOOD (  12.37  )
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

Hi Sourabh,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes tip/x86/core akpm-mm/mm-everything linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sourabh-Jain/crash-make-CPU-and-Memory-hotplug-support-reporting-flexible/20231204-143305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20231204053253.25305-7-sourabhjain%40linux.ibm.com
patch subject: [PATCH v13 6/6] powerpc: add crash memory hotplug support
config: powerpc64-randconfig-001-20231205 (https://download.01.org/0day-ci/archive/20231206/202312060059.JITEJl8B-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060059.JITEJl8B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060059.JITEJl8B-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kexec/core_64.c: In function 'arch_crash_get_elfcorehdr_size':
>> arch/powerpc/kexec/core_64.c:595:33: error: implicit declaration of function 'memory_hotplug_max' [-Werror=implicit-function-declaration]
     595 |                 elf_phdr_cnt += memory_hotplug_max() / (2 * drmem_lmb_size());
         |                                 ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/memory_hotplug_max +595 arch/powerpc/kexec/core_64.c

   579	
   580	/*
   581	 * Advertise preferred elfcorehdr size to userspace via
   582	 * /sys/kernel/crash_elfcorehdr_size sysfs interface.
   583	 */
   584	unsigned int arch_crash_get_elfcorehdr_size(void)
   585	{
   586		unsigned int sz;
   587		unsigned long elf_phdr_cnt;
   588	
   589		/* Program header for CPU notes and vmcoreinfo */
   590		elf_phdr_cnt = 2;
   591		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
   592			/* In the worst case, a Phdr is needed for every other LMB to be
   593			 * represented as an individual crash range.
   594			 */
 > 595			elf_phdr_cnt += memory_hotplug_max() / (2 * drmem_lmb_size());
   596	
   597		/* Do not cross the max limit */
   598		if (elf_phdr_cnt > PN_XNUM)
   599			elf_phdr_cnt = PN_XNUM;
   600	
   601		sz = sizeof(struct elfhdr) + (elf_phdr_cnt * sizeof(Elf64_Phdr));
   602		return sz;
   603	}
   604	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
