Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350C9C54736
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iOtMrEi0I/4POMWMHgO6RPqeFHIzSQEVronPnzY+LWo=; b=wFQIQ4o98l+cmJ
	/MAykUOADyOSRGf9siPFODT59piEshPUfIjxS/KhojLCdDRJl4dsF1irPlsd2pX2JBa0RE14UnH15
	pRxXDDvioBdySSw0jQpv+2eE0A0PjODa464ZakNT6L5AcNCDb0PgiAF82jhXsXCIhHWQVNnd8yF5G
	hj9MVNNL3L9ds/WA+ygf/27pwkwMc7fH3htM1rJUMjin+MdUrQqP5zIuHe3uldzZyCGDM7lVIOylf
	VA7+ryVlrka2WCm+gXCIdgISdYfOqUiuoi0IamKaEY97VZ9So5TVIdDiaqe7wPKiN5yXz47UsDjCx
	AxURD1GkfKgMwzuMZG1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj2WK-0000000ChVQ-1T4U;
	Tue, 27 Aug 2024 20:10:28 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj2WG-0000000ChUU-1Aop
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 20:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724789424; x=1756325424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f3sZbsLPe/J4HvOjV7og6WTUbkDT102FyoUUj5gFOAY=;
  b=QdiR/O5UyEEGAkiUzaB4OV09qiXC1NanDNCjMQBkH0Mb2ojeHMz0E1c4
   FPdKYFO2vzMYbrTLmHrZzYVAc0Bmnw30YLEoM5Tp0bei97YXzOlaqxdCN
   35xtt++iFB6+HWssktsRJg6UULU33DUunxudyZDCEO0/rOSlSj+rLw1F0
   QqFY+MUJ1o0By6jXWoXok4Ceke2MgiWM/7J3vCZcswHpu8XtQeKOTDnlX
   jssMe/E5rnnUWl8wEwAsKosQJGXfmSKPVLXDNB1O0Obos+Zys/13kA5jL
   F0M0sd8B64/AQ/8SzdG9orLiOC59kjMu1/YlD3gswILJ3eZN7RDET2eVM
   g==;
X-CSE-ConnectionGUID: I6P40hr7QSqJmTzgsTLFmw==
X-CSE-MsgGUID: Sz6AeKOKQbeBisjSOWthwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27085004"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="27085004"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 13:10:21 -0700
X-CSE-ConnectionGUID: MkWdwHFPSaORUXRLLgx3tA==
X-CSE-MsgGUID: pScGyMYhQB+U1HU6Fp8Wxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="100500178"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Aug 2024 13:10:14 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj2W3-000K2k-0N;
	Tue, 27 Aug 2024 20:10:11 +0000
Date: Wed, 28 Aug 2024 04:09:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, ross.philipson@oracle.com,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
Message-ID: <202408280656.66ZxoOOL-lkp@intel.com>
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240826223835.3928819-21-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_131024_687769_83EAFF9C 
X-CRM114-Status: GOOD (  13.73  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
[cannot apply to herbert-crypto-2.6/master next-20240827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson%40oracle.com
patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240828/202408280656.66ZxoOOL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280656.66ZxoOOL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280656.66ZxoOOL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/libstub/x86-stub.c: In function 'efi_secure_launch_update_boot_params':
>> drivers/firmware/efi/libstub/x86-stub.c:941:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     941 |         os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
         |                                        ^
   drivers/firmware/efi/libstub/x86-stub.c:945:36: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     945 |         os_mle->boot_params_addr = (u64)boot_params;
         |                                    ^
   drivers/firmware/efi/libstub/x86-stub.c:953:60: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     953 |                         policy->policy_entries[i].entity = (u64)boot_params;
         |                                                            ^
   drivers/firmware/efi/libstub/x86-stub.c:980:56: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     980 |                 boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
         |                                                        ^
   drivers/firmware/efi/libstub/x86-stub.c: In function 'efi_secure_launch':
   drivers/firmware/efi/libstub/x86-stub.c:1014:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1014 |         handler_callback = (dl_handler_func)dlinfo->dl_handler;
         |                            ^


vim +941 drivers/firmware/efi/libstub/x86-stub.c

   927	
   928	static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
   929							 struct boot_params *boot_params)
   930	{
   931		struct slr_entry_intel_info *txt_info;
   932		struct slr_entry_policy *policy;
   933		struct txt_os_mle_data *os_mle;
   934		bool updated = false;
   935		int i;
   936	
   937		txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
   938		if (!txt_info)
   939			return false;
   940	
 > 941		os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
   942		if (!os_mle)
   943			return false;
   944	
   945		os_mle->boot_params_addr = (u64)boot_params;
   946	
   947		policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
   948		if (!policy)
   949			return false;
   950	
   951		for (i = 0; i < policy->nr_entries; i++) {
   952			if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
   953				policy->policy_entries[i].entity = (u64)boot_params;
   954				updated = true;
   955				break;
   956			}
   957		}
   958	
   959		/*
   960		 * If this is a PE entry into EFI stub the mocked up boot params will
   961		 * be missing some of the setup header data needed for the second stage
   962		 * of the Secure Launch boot.
   963		 */
   964		if (image) {
   965			struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
   966						    offsetof(struct boot_params, hdr));
   967			u64 cmdline_ptr;
   968	
   969			boot_params->hdr.setup_sects = hdr->setup_sects;
   970			boot_params->hdr.syssize = hdr->syssize;
   971			boot_params->hdr.version = hdr->version;
   972			boot_params->hdr.loadflags = hdr->loadflags;
   973			boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
   974			boot_params->hdr.min_alignment = hdr->min_alignment;
   975			boot_params->hdr.xloadflags = hdr->xloadflags;
   976			boot_params->hdr.init_size = hdr->init_size;
   977			boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
   978			efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
   979					 &cmdline_ptr);
   980			boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
   981		}
   982	
   983		return updated;
   984	}
   985	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
