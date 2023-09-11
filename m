Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFE3EE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 15:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mIEkKFO8jyD6uFxvJ/4mo0k8MFhAUZK59OwVD4bVTUM=; b=K93pQMki9h8ARI
	/IR4MR+Agk5FYXpbF9G+WPGLNDqIFvHtcx0lhAYRf2cMhsggaTn+Xo5BhrgE1QiHmEQFewYliahFp
	/Np/ql91ZUeX5cyg3d5x6BUa3kaBCy0fu2MJn4uD5PzhKO9Sy8jTv0jIUYybldeFHFhxGG7qtJD3H
	465gNnSaEzcAu5CoAY2Dq8/UXrakCjrZIS7og4cfddAksaMlqpyk7pYYsORJzats3IxHQb/X/LUf0
	U1bnAFTplSIVOuoEWBAP9Wd8t3nSU61U14pk7XLRo84qQpBSQ7eZvIEssZIiOqoyLKkKwZKG+9C2O
	HDy7lxcL+gK6Hfw/UpAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfjES-000wWZ-24;
	Mon, 11 Sep 2023 15:53:48 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfjEQ-000wWD-0k
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 15:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694447626; x=1725983626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3au/kS7+xlc1DadqPxAfLqVMyeQTdx0TDMJbbvFtqQ=;
  b=m8SGKveUf1ic8OEdcs2QZecfKd5x/6p5rz0sQ51QfdznoEXfcuEjKmWB
   863qfYoWvGpeF/amP2vXN4aYzpH5OSGDQ737zDWqocyaN3lHfVkSQGwRr
   KE327QaW+ggF4TfiPXfx3ciEYPyxXi1OTTHZZtsMcUo+nZsvqgDxrFLQ0
   8LuBR9nz0s3IFgy7ERxnZR7FJOEX7PxPtNMd9uX/MDmVZuI54GdXVtdaF
   EKVFcgo4cunh3LsPUmyKS6u8IvyOKUQTUcr6TqzIonhUdAEfvi7PPxR5Y
   506Icc5onXt1klvIGayL1U21THABYDJc3OeYiNQHc46CEYp4sDG2Rl5yD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358414871"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="358414871"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990131344"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990131344"
Received: from aabuleil-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.192])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:53:43 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 4FC9810940E; Mon, 11 Sep 2023 18:53:40 +0300 (+03)
Date: Mon, 11 Sep 2023 18:53:40 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@google.com>,
	Kees Cook <keescook@chromium.org>, Aaron Lu <aaron.lu@intel.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	kexec@lists.infradead.org
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230911155340.mzfngcnjpazwsn76@box.shutemov.name>
References: <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
 <b41a26ae-52f5-f9d9-edc7-32ee665f2482@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b41a26ae-52f5-f9d9-edc7-32ee665f2482@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_085346_277458_C3A731ED 
X-CRM114-Status: GOOD (  31.87  )
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

On Mon, Sep 11, 2023 at 10:33:01AM -0500, Tom Lendacky wrote:
> On 9/11/23 09:57, Kirill A. Shutemov wrote:
> > On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
> > > > early console in extract_kernel
> > > > input_data: 0x000000807eb433a8
> > > > input_len: 0x0000000000d26271
> > > > output: 0x000000807b000000
> > > > output_len: 0x0000000004800c10
> > > > kernel_total_size: 0x0000000003e28000
> > > > needed_size: 0x0000000004a00000
> > > > trampoline_32bit: 0x000000000009d000
> > > > 
> > > > Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
> > > > pages->pgt_buf_offset: 0x0000000000006000
> > > > pages->pgt_buf_size: 0x0000000000006000
> > > > 
> > > > 
> > > > Error: kernel_ident_mapping_init() failed
> > > > 
> > > > It crashes on #PF due to stbl->nr_tables dereference in
> > > > efi_get_conf_table() called from init_unaccepted_memory().
> > > > 
> > > > I don't see anything special about stbl location: 0x775d6018.
> > > > 
> > > > One other bit of information: disabling 5-level paging also helps the
> > > > issue.
> > > > 
> > > > I will debug further.
> > 
> > The problem is not limited to unaccepted memory, it also triggers if we
> > reach efi_get_rsdp_addr() in the same setup.
> > 
> > I think we have several problems here.
> > 
> > - 6 pages for !RANDOMIZE_BASE is only enough for kernel, cmdline,
> >    boot_data and setup_data if we assume that they are in different 1G
> >    regions and do not cross the 1G boundaries. 4-level paging: 1 for PGD, 1
> >    for PUD, 4 for PMD tables.
> > 
> >    Looks like we never map EFI/ACPI memory explicitly.
> > 
> >    It might work if kernel/cmdline/... are in single 1G and we have
> >    spare pages to handle page faults.
> > 
> > - No spare memory to handle mapping for cc_info and cc_info->cpuid_phys;
> > 
> > - I didn't increase BOOT_INIT_PGT_SIZE when added 5-level paging support.
> >    And if start pagetables from scratch ('else' case of 'if (p4d_offset...))
> >    we run out of memory.
> > 
> > I believe similar logic would apply for BOOT_PGT_SIZE for RANDOMIZE_BASE=y
> > case.
> > 
> > I don't know what the right fix here. We can increase the constants to be
> > enough to cover existing cases, but it is very fragile. I am not sure I
> > saw all users. Some of them could silently handled with pagefault handler
> > in some setups. And it is hard to catch new users during code review.
> > 
> > Also I'm not sure why do we need pagefault handler there. Looks like it
> > just masking problems. I think everything has to be mapped explicitly.
> > 
> > Any comments?
> 
> There was a similar related issue around the cc_info blob that is captured
> here: https://lore.kernel.org/lkml/20230601072043.24439-1-ltao@redhat.com/
> 
> Personally, I'm a fan of mapping the EFI tables that will be passed to the
> kexec/kdump kernel. To me, that seems to more closely match the valid
> mappings for the tables when control is transferred to the OS from UEFI on
> the initial boot.

I don't see how it would help if initialize_identity_maps() resets
pagetables. See 'else' case of 'if (p4d_offset...).

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
