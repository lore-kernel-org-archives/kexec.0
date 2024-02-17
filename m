Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27B9C48BF6
	for <kexec@archiver.kernel.org>; Sat, 17 Feb 2024 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6u6ymxAd8Q+vi9/i0LdMajJLrRTN0PbdL+emkxEYxRk=; b=NSKpEj8U3AiP5R
	pBs8mFCEILTlvc9XXlYr1OOG2xV3BG3Hea9BGYdkFgnq8xX9T5fCvkjskG/3e7SpgRKMfvn07MMLp
	8dZtAohxyEK4R04W61QZ1ih/alj469W6irCt7NG+EEJta5PdL9GCmqXDNCK1nAGqx9goHifvOfASB
	xI8k4JtfhznxsI4qF+4hAhQ2zgsQhWKHGhq1ppv3XQ/gay9wvCMM+5Rhh4cLOIs1ekXjXs/SrKzL4
	IsHn8vp9TQtRELt4yMyJpCLWrTklCiSsuHJCsop7bSkRPrS3Mta1xBbDDmVHTGymH12tFImf1H700
	GnjXEvZkNPRrhrZf72nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbFBa-00000004p9O-25QC;
	Sat, 17 Feb 2024 07:32:34 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbFBW-00000004p87-3AWm
	for kexec@lists.infradead.org;
	Sat, 17 Feb 2024 07:32:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708155151; x=1739691151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ccjuSqOZPclsskdcJMYR2Q3/YUCIG6fCIeDpqvIsxfk=;
  b=RWrQPBIsuwiOs2gnoIAfHWiBtIpg65xljGqPrdqZHnv188pHsRUmBfPF
   MjCmgRqO4CtFDV8YUQE3IqnwQAQfDNDdTrnq/1K37uJBb8tBcGt/VQ3Be
   qwIUF2/fD/d5XUtJNa0R43MlbfsmH1js7+upPQeE8DlHIdjTpW7bZ7yC8
   WqarxkpzFe6/HlvmuYLLfLtKwKHqHwgFub0XurSQEvj0tMdf4K7K8o4hr
   XoV3lj92U1LSaH5eRY4j9yC6hEHUvWDzVWSF1Llu63AA/2+kGqyX8Wmku
   7GSllFVpudx2nX/haq1t4K5sGqPOcdlthvYlc4Clh3inCXuSSlfV/hxNp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2433568"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2433568"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 23:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8656739"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 16 Feb 2024 23:32:23 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbFBN-0001vY-01;
	Sat, 17 Feb 2024 07:32:21 +0000
Date: Sat, 17 Feb 2024 15:31:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ross.philipson@oracle.com,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure
 Launch
Message-ID: <202402171503.kLhNHtkM-lkp@intel.com>
References: <20240214221847.2066632-16-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240214221847.2066632-16-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_233230_901360_81FB41DB 
X-CRM114-Status: GOOD (  11.46  )
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

Hi Ross,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v6.8-rc4 next-20240216]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/x86-boot-Place-kernel_info-at-a-fixed-offset/20240215-064712
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240214221847.2066632-16-ross.philipson%40oracle.com
patch subject: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure Launch
config: i386-randconfig-052-20240215 (https://download.01.org/0day-ci/archive/20240217/202402171503.kLhNHtkM-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402171503.kLhNHtkM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402171503.kLhNHtkM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/x86-stub.c:862:18: error: invalid input size for constraint 'a'
     862 |                       : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
         |                                ^
   1 error generated.


vim +/a +862 drivers/firmware/efi/libstub/x86-stub.c

   813	
   814	static void efi_secure_launch(struct boot_params *boot_params)
   815	{
   816		struct slr_entry_uefi_config *uefi_config;
   817		struct slr_uefi_cfg_entry *uefi_entry;
   818		struct slr_entry_dl_info *dlinfo;
   819		efi_guid_t guid = SLR_TABLE_GUID;
   820		struct slr_table *slrt;
   821		u64 memmap_hi;
   822		void *table;
   823		u8 buf[64] = {0};
   824	
   825		table = get_efi_config_table(guid);
   826	
   827		/*
   828		 * The presence of this table indicated a Secure Launch
   829		 * is being requested.
   830		 */
   831		if (!table)
   832			return;
   833	
   834		slrt = (struct slr_table *)table;
   835	
   836		if (slrt->magic != SLR_TABLE_MAGIC)
   837			return;
   838	
   839		/* Add config information to measure the UEFI memory map */
   840		uefi_config = (struct slr_entry_uefi_config *)buf;
   841		uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
   842		uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
   843		uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
   844		uefi_config->nr_entries = 1;
   845		uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
   846		uefi_entry->pcr = 18;
   847		uefi_entry->cfg = boot_params->efi_info.efi_memmap;
   848		memmap_hi = boot_params->efi_info.efi_memmap_hi;
   849		uefi_entry->cfg |= memmap_hi << 32;
   850		uefi_entry->size = boot_params->efi_info.efi_memmap_size;
   851		memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
   852			strlen("Measured UEFI memory map"));
   853	
   854		if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))
   855			return;
   856	
   857		/* Jump through DL stub to initiate Secure Launch */
   858		dlinfo = (struct slr_entry_dl_info *)
   859			slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
   860	
   861		asm volatile ("jmp *%%rax"
 > 862			      : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
   863	}
   864	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
