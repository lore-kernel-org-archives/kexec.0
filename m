Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438BAC636E5
	for <kexec@archiver.kernel.org>; Wed, 28 Aug 2024 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7aayYC7h99TG9R8tiXqCzKtIl5504aYF+4wPWDlbbmc=; b=lbndkscmrWR8bG
	q7NWY+/x0/CRZuZBRoRNqU7x20OkOkh9lHLCm++NMhqCyaHoZKF0RvdPw3cOLUqZRJFxVxHEwWNdX
	58sj1T72BBWYNWKro1Vl3rVLaXisz/+Qt2vhQMJyotbwKcuiG0LVRTuINrowkbFK9bK9yaNqTcyL0
	m/5woAmVBOAaLjQ7mQIziTrhMqIBHF8HGoHHvoXhBe/X3MB7ihT+Kh6+zDtClQQ6FomiCna5xvrI7
	psGEm6X/PJcxZyo2Xi3hQOKZ4dwckt9kU9l6o+4LLLgTjp9rOugd5qXRryR99F5ofB88QA3GdsJ/h
	AD6a4jn5LTZfJnZXM4OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjMAq-0000000GJI0-3V2p;
	Wed, 28 Aug 2024 17:09:36 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjMAn-0000000GJGV-1R8I
	for kexec@lists.infradead.org;
	Wed, 28 Aug 2024 17:09:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724864973; x=1756400973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lt/vVZGxbPxIVeHUQrwZ9LbuJ1MJIFdjEIvRXf/Rn54=;
  b=O+22VtlmAcULuzGEDJmSXICrWgNFMMxqFjkOj7pxP05A95NuEHbZHyfJ
   PK9TY21uzzGcrCbimsAYX2d61UI9ggEJxFmfqGzSy9JWX1Dgzoqob4/NB
   YvwDAenZ8bwMQrYp3iYCllN3D6Gm3iUsz84ugZaX+US06LEl1aaZrqehF
   EdBW30r3tOeMlLQFWMRxnlLDezvXzApixzsczJyyUiGiT+9tZYASBgBby
   xCxfwl4FC1/286mumK/5oRPxKf4FppsyVXPoZ4FSvr2nCGAgh27rVWpqO
   SQse7GEcLmJ26WcZwN2JoFTZ2qfA2WPed4b8d4ZpJ1GjoYWxufXvAEA1O
   Q==;
X-CSE-ConnectionGUID: 5CgGS1cIQQ21cASkAL+4wA==
X-CSE-MsgGUID: AqRp6kF0Q72q9GWqmztwgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23572339"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23572339"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 10:09:28 -0700
X-CSE-ConnectionGUID: suS3Usx0QSylOdqWws6zyg==
X-CSE-MsgGUID: NbAZYs2EQZqfjlEChoUyUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="100787474"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2024 10:09:22 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjMAZ-000LBE-0t;
	Wed, 28 Aug 2024 17:09:19 +0000
Date: Thu, 29 Aug 2024 01:09:15 +0800
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
Message-ID: <202408290030.FEbUhHbr-lkp@intel.com>
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240826223835.3928819-21-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_100933_420589_F4227FB1 
X-CRM114-Status: GOOD (  12.99  )
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
[cannot apply to herbert-crypto-2.6/master next-20240828]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson%40oracle.com
patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
config: i386-randconfig-062-20240828 (https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408290030.FEbUhHbr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/efi/libstub/x86-stub.c:945:41: sparse: sparse: non size-preserving pointer to integer cast
   drivers/firmware/efi/libstub/x86-stub.c:953:65: sparse: sparse: non size-preserving pointer to integer cast
>> drivers/firmware/efi/libstub/x86-stub.c:980:70: sparse: sparse: non size-preserving integer to pointer cast
   drivers/firmware/efi/libstub/x86-stub.c:1014:45: sparse: sparse: non size-preserving integer to pointer cast

vim +945 drivers/firmware/efi/libstub/x86-stub.c

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
   941		os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
   942		if (!os_mle)
   943			return false;
   944	
 > 945		os_mle->boot_params_addr = (u64)boot_params;
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
 > 980			boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
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
