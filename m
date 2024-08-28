Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C52FC636EB
	for <kexec@archiver.kernel.org>; Wed, 28 Aug 2024 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AVqDPoh6meQgiyGt5GTWV8Pss562jfk3QEnrBgpqkRo=; b=QhvwOmFw7XPBCB
	iqWekw+aAr+HGWhFXq5gvs/YnFZ2/YqDcYCJhDYGRcevfU4oJaViHTXA/MNV9M2aG9LDdb3JXk8XK
	hA2UvylgASj/5VUn/IuxMeMP9/V0aO3InDyt7ElIswJZ+RA4daMZdpUHH9qy5TGi0VjwYWkxrl5JH
	0tciQeFbtSy9mIWLVAKchQjJPJyEwZZh/O4FSPj9dc22FvIbfzGeB8EcKS3bF9OzGWSE1Eqh/70EC
	EiJoic9YA21pNz/6aFuhYx2kUlJlzEB17M4WbcjmSd22QrUptWVUEEQ2113TyulM77bnhRKu9hiVg
	04T4/0sdadDzWnYNhmnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjMGk-0000000GKOC-3vrK;
	Wed, 28 Aug 2024 17:15:42 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjMFQ-0000000GK1a-44KY
	for kexec@lists.infradead.org;
	Wed, 28 Aug 2024 17:14:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0770FAE2D43
	for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 17:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5EEC4CECC
	for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724865258;
	bh=JMXcxtayu0gzzaCBWTcXmf2eB/HAKHtp+/XlQYk6MBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=azHCmxiTXKE3x7rwJPOfbJepWeWHKeou6GzC9yWlspuG4haAA3acy6WVh77iaM4z5
	 O2OEFuda+1O6DK77JDqyue3RDMfwcX8207p6iR328o/8iCFuXjPiZeb+JIgV8NOlcs
	 lMlASpeCY07DWlr9IefrQ5mr8lwLYIVSElhKb3L+YVjJ0eNch1k5kT5b39NgeDMQ6m
	 wnqxzfoiN7p2vuIQv8LhOqnhQpNfhEaLIS5uA0nb9odqS6zthIw0K7LuXuSkMirueU
	 Hto6PVWap9ehICcysOfp3iK4wrSz5Wd9tZ+DWn7JRrZ5fOm0dlYbkUW1gOfwO2wnms
	 ruA65lYdzvEAA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53438aa64a4so7360448e87.3
        for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 10:14:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW4SNNasvTOCYQa90EZRCy10b5pDeeYINyOfG4+HjtoEqgY6Eq8IkmA9wdlJRLUS45sbVmTg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwGJoG7foc8A7Yvbje01DKq8vdbW+EEl3A+Jr3z3qD+3LVfBM1Y
	Fi1OMDOFjaWMK95HiJIhiYgBGgkdTltuXh85cnMy6gn2vnbd50OC/5c3ZEnlzkKMw8hLGXRYOZp
	YXdIXpS2Xhryjhqlu4zdvFcE/mHI=
X-Google-Smtp-Source: AGHT+IGjIAEHfnaAvWDGrHZH9ur0Yqdu+2C9S8V61720ewupp4mWfrA47TtZM9rrWmWlkP/s8kuZindCvpyLzRoi8jM=
X-Received: by 2002:a05:6512:3052:b0:52e:9b2f:c313 with SMTP id
 2adb3069b0e04-53438831efbmr11902856e87.22.1724865257121; Wed, 28 Aug 2024
 10:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240826223835.3928819-21-ross.philipson@oracle.com> <202408290030.FEbUhHbr-lkp@intel.com>
In-Reply-To: <202408290030.FEbUhHbr-lkp@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 19:14:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
Message-ID: <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: kernel test robot <lkp@intel.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	oe-kbuild-all@lists.linux.dev, dpsmith@apertussolutions.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_101421_289296_51D8B0BA 
X-CRM114-Status: GOOD (  20.31  )
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

On Wed, 28 Aug 2024 at 19:09, kernel test robot <lkp@intel.com> wrote:
>
> Hi Ross,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on tip/x86/core]
> [also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
> [cannot apply to herbert-crypto-2.6/master next-20240828]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225
> base:   tip/x86/core
> patch link:    https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson%40oracle.com
> patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
> config: i386-randconfig-062-20240828 (https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config)


This is a i386 32-bit build, which makes no sense: this stuff should
just declare 'depends on 64BIT'


> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408290030.FEbUhHbr-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/firmware/efi/libstub/x86-stub.c:945:41: sparse: sparse: non size-preserving pointer to integer cast
>    drivers/firmware/efi/libstub/x86-stub.c:953:65: sparse: sparse: non size-preserving pointer to integer cast
> >> drivers/firmware/efi/libstub/x86-stub.c:980:70: sparse: sparse: non size-preserving integer to pointer cast
>    drivers/firmware/efi/libstub/x86-stub.c:1014:45: sparse: sparse: non size-preserving integer to pointer cast
>
> vim +945 drivers/firmware/efi/libstub/x86-stub.c
>
>    927
>    928  static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
>    929                                                   struct boot_params *boot_params)
>    930  {
>    931          struct slr_entry_intel_info *txt_info;
>    932          struct slr_entry_policy *policy;
>    933          struct txt_os_mle_data *os_mle;
>    934          bool updated = false;
>    935          int i;
>    936
>    937          txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
>    938          if (!txt_info)
>    939                  return false;
>    940
>    941          os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
>    942          if (!os_mle)
>    943                  return false;
>    944
>  > 945          os_mle->boot_params_addr = (u64)boot_params;
>    946
>    947          policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
>    948          if (!policy)
>    949                  return false;
>    950
>    951          for (i = 0; i < policy->nr_entries; i++) {
>    952                  if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
>    953                          policy->policy_entries[i].entity = (u64)boot_params;
>    954                          updated = true;
>    955                          break;
>    956                  }
>    957          }
>    958
>    959          /*
>    960           * If this is a PE entry into EFI stub the mocked up boot params will
>    961           * be missing some of the setup header data needed for the second stage
>    962           * of the Secure Launch boot.
>    963           */
>    964          if (image) {
>    965                  struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
>    966                                              offsetof(struct boot_params, hdr));
>    967                  u64 cmdline_ptr;
>    968
>    969                  boot_params->hdr.setup_sects = hdr->setup_sects;
>    970                  boot_params->hdr.syssize = hdr->syssize;
>    971                  boot_params->hdr.version = hdr->version;
>    972                  boot_params->hdr.loadflags = hdr->loadflags;
>    973                  boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
>    974                  boot_params->hdr.min_alignment = hdr->min_alignment;
>    975                  boot_params->hdr.xloadflags = hdr->xloadflags;
>    976                  boot_params->hdr.init_size = hdr->init_size;
>    977                  boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
>    978                  efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
>    979                                   &cmdline_ptr);
>  > 980                  boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
>    981          }
>    982
>    983          return updated;
>    984  }
>    985
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
