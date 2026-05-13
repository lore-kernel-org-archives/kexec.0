Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C976CD37AC
	for <kexec@archiver.kernel.org>; Wed, 13 May 2026 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ll7YfgaZYKbKPVF2FoQZiNWQVqfngOu2EHndRqB0ZM=; b=SPD15arhlWolTFXrybmbW+8TB+
	NDiOuL8V+hZeJ+JJ8H3BD+Ex0z8R77jhXDs4NdQLd1RV4qHaD6ydkDRHyZyxRKXzQN3kNZInhXKPC
	TmpJpyo8OpCi5hyBygNzwdgpYoWDLimDRVUK8XFAxNH6kET5AyVjofni1X76Be4zNAaCsImOyXqVK
	g8caUrRBw2UggM9VpV/z2aCL0WtBai8PfyXzmdt14jVTV2cd0mpoGxd/J+0ix5WvpMvGmvk5iQ8av
	OzpKPryaW97vt5U6ug1hTrZL1nk4sSF07zbInkNqydQC1Tg6G5vZaGIjuZv5UbEjABWAJOMriANfL
	VMkKTW+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNHAC-00000003pa6-49Es;
	Wed, 13 May 2026 21:30:44 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNHA4-00000003pYu-1NzL
	for kexec@lists.infradead.org;
	Wed, 13 May 2026 21:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778707836; x=1810243836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g3wMfuEDUADeG/Bz9ZkpBAT2Wx94bpqi+QsWArtwE8s=;
  b=H8QGxiAgSejRH5e9wQWMzyNl/YZxhuPCLWc7kGwPnZCbiQh4BShyv6AC
   KXTgMQylL6xsWiNsvIyN/bsJA9e8OJXvUyqsJGkVAgY/RVRQrobD8m8Y5
   jBNr/FMpJ7oljGLX+sa1pwjlMZKHAi9CkI6NidT75fC8Mm//oUQKL8Nvm
   shTClVsiXAnggvah9+AXzKYOA4vaR100ky2jBJdA0vBKjPCsb4Mn7wW7c
   sEH1Q6t4E8pvgoXRTgJ97qJioZqsqGYyo7kITPNxzOv/yHXbjq80AQ7k1
   iWyfAapVUZFgVrmfFXkWna4WctZwmOC6+mJScvhsEk8TDFqReImMZvvR1
   g==;
X-CSE-ConnectionGUID: 6DnYohIjQhiYeZvMh8UeJw==
X-CSE-MsgGUID: s7p5FEMBQku6eHwrhcYZow==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79679785"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79679785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 14:30:36 -0700
X-CSE-ConnectionGUID: nNPTa2otShGAdZpu7RZ+tw==
X-CSE-MsgGUID: N9TK/gvNQouXUa3DubQDXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="276296913"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 May 2026 14:30:34 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNH9z-0000000059X-0KIs;
	Wed, 13 May 2026 21:30:31 +0000
Date: Thu, 14 May 2026 05:30:09 +0800
From: kernel test robot <lkp@intel.com>
To: hangej <hangej@amazon.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	kexec@lists.infradead.org, hangej@amazon.com
Subject: Re: [PATCH] pci_crash: capture PCI config space at panic time
Message-ID: <202605140501.1tSG7lxR-lkp@intel.com>
References: <20260512162402.1929687-1-hangej@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512162402.1929687-1-hangej@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_143037_160215_8307D044 
X-CRM114-Status: GOOD (  15.71  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi hangej,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hangej/pci_crash-capture-PCI-config-space-at-panic-time/20260514-000653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260512162402.1929687-1-hangej%40amazon.com
patch subject: [PATCH] pci_crash: capture PCI config space at panic time
config: i386-randconfig-r071-20260514 (https://download.01.org/0day-ci/archive/20260514/202605140501.1tSG7lxR-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605140501.1tSG7lxR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605140501.1tSG7lxR-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/pci_crash.c: In function 'pci_crash_save':
>> kernel/pci_crash.c:661:53: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'acs_cap'?
     661 |                                 if (!pdev || !pdev->aer_cap)
         |                                                     ^~~~~~~
         |                                                     acs_cap
   kernel/pci_crash.c:666:68: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'acs_cap'?
     666 |                                                              pdev->aer_cap + PCI_ERR_ROOT_STATUS,
         |                                                                    ^~~~~~~
         |                                                                    acs_cap


vim +661 kernel/pci_crash.c

   599	
   600	/**
   601	 * pci_crash_save() - Capture PCI config space at crash time
   602	 *
   603	 * Called from crash_save_vmcoreinfo() inside __crash_kexec(), which
   604	 * runs before machine_kexec() boots the crash kernel.  This is the
   605	 * only reliable capture point -- panic notifiers run AFTER kexec by
   606	 * default (crash_kexec_post_notifiers=0).
   607	 *
   608	 * Capture check (capture param):
   609	 *   always  -- capture unconditionally
   610	 *   aer     -- quick-scan root port AER ROOT_STATUS for uncorrectable
   611	 *             errors; skip if none found
   612	 *
   613	 * When capture=always, captures on every panic.
   614	 * This is useful for cascading failures: a PCI link-down can cause
   615	 * an MCE or NMI watchdog timeout before DPC/AER fires, so the crash
   616	 * reason is UNKNOWN but AER registers may still hold error state.
   617	 *
   618	 * Reads config space fresh -- successful reads get current register
   619	 * state, failed reads (offline devices) write 0xFFFFFFFF.
   620	 *
   621	 * Flushes both buffer and pagemap from CPU cache to RAM so data
   622	 * survives kexec into crash kernel.
   623	 */
   624	void pci_crash_save(void)
   625	{
   626		struct pci_crash_pagemap *pm;
   627		unsigned long cflags;
   628		unsigned int num_devs;
   629		size_t pm_size;
   630		size_t buf_size;
   631		void *buffer;
   632	
   633		num_devs = READ_ONCE(pci_crash_num_devs);
   634		if (num_devs == 0)
   635			return;
   636	
   637		/* Pairs with smp_wmb() in rebuild -- ensures buffer/pagemap visible */
   638		smp_rmb();
   639	
   640		buffer = READ_ONCE(pci_crash_buffer);
   641		buf_size = READ_ONCE(pci_crash_buffer_size);
   642		pm = READ_ONCE(pci_crash_pagemap);
   643		pm_size = READ_ONCE(pci_crash_pagemap_size);
   644		if (!buffer || buf_size == 0)
   645			return;
   646	
   647		cflags = READ_ONCE(capture_flags);
   648		if (!(cflags & PCI_CRASH_CAPTURE_ALWAYS)) {
   649			if (cflags & PCI_CRASH_CAPTURE_AER) {
   650				struct pci_dev **devs = READ_ONCE(pci_crash_devs);
   651				unsigned int i;
   652				bool pci_error_found = false;
   653	
   654				if (!devs)
   655					return;
   656	
   657				for (i = 0; i < num_devs; i++) {
   658					struct pci_dev *pdev = devs[i];
   659					u32 status;
   660	
 > 661					if (!pdev || !pdev->aer_cap)
   662						continue;
   663	
   664					if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
   665						pci_read_config_dword(pdev,
   666								     pdev->aer_cap + PCI_ERR_ROOT_STATUS,
   667								     &status);
   668						if (status & PCI_ERR_ROOT_UNCOR_RCV) {
   669							pci_error_found = true;
   670							break;
   671						}
   672					}
   673				}
   674	
   675				if (!pci_error_found) {
   676					pr_emerg("no PCI errors detected, skipping capture\n");
   677					return;
   678				}
   679			} else {
   680				return;
   681			}
   682		}
   683	
   684		pci_crash_fill_buffer(buffer, num_devs);
   685	
   686		/*
   687		 * Flush buffer and pagemap from CPU cache to RAM so the
   688		 * crash kernel sees our writes after kexec.
   689		 */
   690		pci_crash_flush_dcache(buffer, buf_size);
   691	
   692		if (pm && pm_size > 0)
   693			pci_crash_flush_dcache(pm, pm_size);
   694	
   695		pr_emerg("CAPTURE: %u devices, %zu bytes\n",
   696			 num_devs, buf_size);
   697	}
   698	EXPORT_SYMBOL_GPL(pci_crash_save);
   699	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

