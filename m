Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705B1EE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S3ljenaV9ukRMcoWN+xfSly4lwatGFpJYCE2+sn2Jn4=; b=mQsWs//q1zbD/K
	HUY2prLfOxlTk7/M1KB1H5CGPGt3f4NZbo8K+4IaV6azcuw5+U8128AKRw+DdHCDql4Q3MUQUWHxl
	XAEO+tUIeDmyEzt96nZ2EbHso+nWqP326xLIRmIpGYj0IouKb8X1tSPiTohokmUZCn0meIuHLFJ8Y
	f8V327RPN65jYMqIKzl85I/BJp84403MoLNu7E1jW/9kO24E0Fg0maPkDaO3ASJQ01CT2lcp4EPZp
	SAQF45r3lg6J3QNFub1PcUi9eaiS4ZHRGULi9UMjNH7Kdr5tX1AKYPoksXaTtYGdSVyG03I59+akS
	MZfrjV4WE/MoiQ2Bnb7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfiMw-000mzl-2F;
	Mon, 11 Sep 2023 14:58:30 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfiMt-000my9-13
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 14:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694444307; x=1725980307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FT4+8y4yqex+aCmnurGGSCi/Y+7+16wH2XrhNGt8psM=;
  b=Kji7OdqPn3EXK2XVN4FiaVb1+SGcCuur0wB43frk/qj/skzsDFecWsxm
   aN36+6QBZea4653mloaymZCXrPf2nXlayUic9JBUpVzSIDqR7Trb/rhg9
   6NdMCiF3vxb5sGvXCtiVo7ATOaiAP5nJbHD2kPFxbB+yE3NGiNlFfZDR1
   d9eqcQ1vCCBCGNagow51ICxx/NwJpRs+Mv1PwQTHAax6iGCyqC6RrGV6L
   6eqKpw3cZsHQ3zCb8+HFwaCM9/3WChiDLcgf9+gIpF4M3Vc/tFfbI2V0L
   c2KSCWl9y+GLP6oxbc51SapUSOajrWMvtcTQ+bwwl6FIJepobhQjfkTJs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368342059"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="368342059"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917047573"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917047573"
Received: from aabuleil-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:57:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 729B810940E; Mon, 11 Sep 2023 17:57:07 +0300 (+03)
Date: Mon, 11 Sep 2023 17:57:07 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@google.com>, Kees Cook <keescook@chromium.org>,
	Aaron Lu <aaron.lu@intel.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	kexec@lists.infradead.org, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
References: <20230829125134.GA509331@ziqianlu-dell>
 <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_075827_532420_611D29B4 
X-CRM114-Status: GOOD (  18.23  )
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

On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
> > early console in extract_kernel
> > input_data: 0x000000807eb433a8
> > input_len: 0x0000000000d26271
> > output: 0x000000807b000000
> > output_len: 0x0000000004800c10
> > kernel_total_size: 0x0000000003e28000
> > needed_size: 0x0000000004a00000
> > trampoline_32bit: 0x000000000009d000
> >
> > Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
> > pages->pgt_buf_offset: 0x0000000000006000
> > pages->pgt_buf_size: 0x0000000000006000
> >
> >
> > Error: kernel_ident_mapping_init() failed
> >
> > It crashes on #PF due to stbl->nr_tables dereference in
> > efi_get_conf_table() called from init_unaccepted_memory().
> >
> > I don't see anything special about stbl location: 0x775d6018.
> >
> > One other bit of information: disabling 5-level paging also helps the
> > issue.
> >
> > I will debug further.

The problem is not limited to unaccepted memory, it also triggers if we
reach efi_get_rsdp_addr() in the same setup.

I think we have several problems here.

- 6 pages for !RANDOMIZE_BASE is only enough for kernel, cmdline,
  boot_data and setup_data if we assume that they are in different 1G
  regions and do not cross the 1G boundaries. 4-level paging: 1 for PGD, 1
  for PUD, 4 for PMD tables.

  Looks like we never map EFI/ACPI memory explicitly.

  It might work if kernel/cmdline/... are in single 1G and we have
  spare pages to handle page faults.

- No spare memory to handle mapping for cc_info and cc_info->cpuid_phys;

- I didn't increase BOOT_INIT_PGT_SIZE when added 5-level paging support.
  And if start pagetables from scratch ('else' case of 'if (p4d_offset...))
  we run out of memory.

I believe similar logic would apply for BOOT_PGT_SIZE for RANDOMIZE_BASE=y
case.

I don't know what the right fix here. We can increase the constants to be
enough to cover existing cases, but it is very fragile. I am not sure I
saw all users. Some of them could silently handled with pagefault handler
in some setups. And it is hard to catch new users during code review.

Also I'm not sure why do we need pagefault handler there. Looks like it
just masking problems. I think everything has to be mapped explicitly.

Any comments?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
