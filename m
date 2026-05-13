Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4538CD37AC
	for <kexec@archiver.kernel.org>; Wed, 13 May 2026 22:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mA4XPxt99InvEi52HHcECLiAVCsaocxzcIUnAfAs5LA=; b=mUR7WizMyj6un0XpvQPICN2g88
	M25mYK2cFeD8MYb3F13XWtPAMxVwcj9p7K4vp1P72yqpw+90ZLstB1ibwJBTyPdis7aRvw8N/9vM0
	5mIIR9GvQPtD5Gug7fhpljLInWsFcSYrZ14pSNBoq3m55J1oRVgfW3AYSOn/+Q9JewR4y9+1ke4Qp
	7RLpwNDH88AULIZTjhWWtRRv/Ma8c6Ws40yIifzShNgo6t+TMhx98cXDSVxMalZHp7jTffNQoZ0sv
	sfV97anmSHesjasWZJYC62sXJtN2Go6NY1vaGg0OskvWrsjLT6T6Wjc7s5TN4PazhrNBo1hFDG1Wy
	Cyr1AufQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNI0T-00000003ufh-09SB;
	Wed, 13 May 2026 22:24:45 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNI0P-00000003uf2-0VJq
	for kexec@lists.infradead.org;
	Wed, 13 May 2026 22:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778711081; x=1810247081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9izmYS1Q0D0k4I5HeNs52Eo1sxcceosqE8+HHZxbOIE=;
  b=l+7WKc7VNxY1IOo7DgEdrccsk53XUds9IBpmBAN+Pl7Amm6In742Noky
   hmugLLbOFACHEqCGAVsowxLi6F7HjdW/ohVzUux4BeIm5p4MAf/qdng3X
   kXoDoARVjHap8DExUqALTeYdZjefv8WZRV9f4sGDXyEMIuidCNKzu+IuY
   nmpZd4OPth+Y6szK6IEQ+niqlitdY7lb5FT+Cx09CCAAhg3WFhInbsBve
   eJUNbxia4FGa7+oEDmYxiSllSvMcKk8s5LVdEDU3y8CZB2VUIsdEjOu5B
   aL0uJ/VsGXVVZUhmt1k9JJRAh640CBYh5qhZ2TkXQHGfPt/qeP9xDkxmA
   w==;
X-CSE-ConnectionGUID: KCPayg9RR2CF3ZkM+E4EaQ==
X-CSE-MsgGUID: JUPGRozgSDmKwPiLmEgI8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79545923"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79545923"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 15:24:40 -0700
X-CSE-ConnectionGUID: 5twPmlezQ+m5PPCvlGRG0Q==
X-CSE-MsgGUID: V9jclXIDSDaPJYHx+rFwIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237345529"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 May 2026 15:24:38 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNI0I-000000005Dr-3o3n;
	Wed, 13 May 2026 22:24:34 +0000
Date: Thu, 14 May 2026 06:23:54 +0800
From: kernel test robot <lkp@intel.com>
To: hangej <hangej@amazon.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	kexec@lists.infradead.org, hangej@amazon.com
Subject: Re: [PATCH] pci_crash: capture PCI config space at panic time
Message-ID: <202605140624.Tw71sECt-lkp@intel.com>
References: <20260512162402.1929687-1-hangej@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512162402.1929687-1-hangej@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_152441_238334_D2B95844 
X-CRM114-Status: GOOD (  16.04  )
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
config: x86_64-randconfig-161-20260514 (https://download.01.org/0day-ci/archive/20260514/202605140624.Tw71sECt-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605140624.Tw71sECt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605140624.Tw71sECt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/pci_crash.c:661:25: error: no member named 'aer_cap' in 'struct pci_dev'
     661 |                                 if (!pdev || !pdev->aer_cap)
         |                                               ~~~~  ^
   kernel/pci_crash.c:666:19: error: no member named 'aer_cap' in 'struct pci_dev'
     666 |                                                              pdev->aer_cap + PCI_ERR_ROOT_STATUS,
         |                                                              ~~~~  ^
   2 errors generated.


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

