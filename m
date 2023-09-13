Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696C5EDEC5C
	for <kexec@archiver.kernel.org>; Wed, 13 Sep 2023 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W/791Kyr9bOt9Mn1GstsQK988jAw/WqU6kqUaJJnhiQ=; b=o98A5zpIUSuxCY
	su2yriqhvd89Nqan1AGL8iPlvpydVXxE+QwNDm8lPGQ40XtZyqO+J64JPh1CYbYDhE/7zpc1oY89O
	pfuRvZmkqkl/ojHI4XLTmms67eYCKYWQvU1IAnLrT3IrMm7Q5oGUQ83I9N6buqLL3RN/Yb11oSbAS
	C11a1LAMX1VrgnEuAZW2e8oQ+fMyW7JF3Kzi+sVPifrNNFI9GB0dv+jiVn2mPAj2WkyQzda8LSlE0
	UNSfu+Qzc/Zakm1jQ17DIUfekrIqrTCxfb84US2jCa22O3IE1rtf0Ii9erBWWqt6y9E8GBx2xwyz7
	PhvnUR2AoW7RxD+JTxpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgQnf-00673b-2y;
	Wed, 13 Sep 2023 14:25:03 +0000
Received: from mgamail.intel.com ([134.134.136.31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgQnc-00672u-1C
	for kexec@lists.infradead.org;
	Wed, 13 Sep 2023 14:25:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694615100; x=1726151100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XKOsmvZaoSUNMXOhheZXkeEtZd0F/hnfQCZH/hf2+EQ=;
  b=m+ukyv+Za50O08hUtpJvlHEc3MtEcpGiLXU3QdIxa7bGjkuFTZitkP2b
   41nseqRbOgZbJiNSTNPTkIGEmlrshXK8qjboxKi1ZUjrhuXmA/EB58jaz
   OHvZWr5JGlnGpTo6RVNfbvnQQ+q6tBoeClCO3p1C07qih6CRJoUb/WVCL
   /rcJ6O8Ywn6+66VXjjYLJgKBHCa+QNS9NWQ+gWKPbVmWOPFzzCYhkYJhb
   NVoXph50Fl2INU7mynD2i9Li8F3LWsdNH64Jj83Gjbffe6NWPHM9ZiPgf
   OHH1xDAr13gDP6wrO7IkGzA1TLzYiSsjvxbIXF4eOha3U/RJnyT+CktWf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="442705096"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="442705096"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 07:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747322619"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747322619"
Received: from mdhaisne-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.45.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 07:24:18 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id D49C310940B; Wed, 13 Sep 2023 17:24:10 +0300 (+03)
Date: Wed, 13 Sep 2023 17:24:10 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@google.com>, Kees Cook <keescook@chromium.org>,
	Aaron Lu <aaron.lu@intel.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	kexec@lists.infradead.org, Tom Lendacky <thomas.lendacky@amd.com>,
	x86@kernel.org
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230913142410.dfqsg3l5v44mr5j3@box>
References: <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_072500_457640_EB0F00B0 
X-CRM114-Status: GOOD (  25.02  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Sep 11, 2023 at 05:57:07PM +0300, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
> > > early console in extract_kernel
> > > input_data: 0x000000807eb433a8
> > > input_len: 0x0000000000d26271
> > > output: 0x000000807b000000
> > > output_len: 0x0000000004800c10
> > > kernel_total_size: 0x0000000003e28000
> > > needed_size: 0x0000000004a00000
> > > trampoline_32bit: 0x000000000009d000
> > >
> > > Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ide=
nt_map_64.c!?
> > > pages->pgt_buf_offset: 0x0000000000006000
> > > pages->pgt_buf_size: 0x0000000000006000
> > >
> > >
> > > Error: kernel_ident_mapping_init() failed
> > >
> > > It crashes on #PF due to stbl->nr_tables dereference in
> > > efi_get_conf_table() called from init_unaccepted_memory().
> > >
> > > I don't see anything special about stbl location: 0x775d6018.
> > >
> > > One other bit of information: disabling 5-level paging also helps the
> > > issue.
> > >
> > > I will debug further.
> =

> The problem is not limited to unaccepted memory, it also triggers if we
> reach efi_get_rsdp_addr() in the same setup.
> =

> I think we have several problems here.
> =

> - 6 pages for !RANDOMIZE_BASE is only enough for kernel, cmdline,
>   boot_data and setup_data if we assume that they are in different 1G
>   regions and do not cross the 1G boundaries. 4-level paging: 1 for PGD, 1
>   for PUD, 4 for PMD tables.
> =

>   Looks like we never map EFI/ACPI memory explicitly.
> =

>   It might work if kernel/cmdline/... are in single 1G and we have
>   spare pages to handle page faults.
> =

> - No spare memory to handle mapping for cc_info and cc_info->cpuid_phys;
> =

> - I didn't increase BOOT_INIT_PGT_SIZE when added 5-level paging support.
>   And if start pagetables from scratch ('else' case of 'if (p4d_offset...=
))
>   we run out of memory.
> =

> I believe similar logic would apply for BOOT_PGT_SIZE for RANDOMIZE_BASE=
=3Dy
> case.
> =

> I don't know what the right fix here. We can increase the constants to be
> enough to cover existing cases, but it is very fragile. I am not sure I
> saw all users. Some of them could silently handled with pagefault handler
> in some setups. And it is hard to catch new users during code review.
> =

> Also I'm not sure why do we need pagefault handler there. Looks like it
> just masking problems. I think everything has to be mapped explicitly.
> =

> Any comments?

I struggle to come up with anything better than increasing the constant to
a value that "ought to be enough for anybody" =A9, let's say 128K.

And we can eliminate logic on no-KASLR vs. KASLR vs. KASLR+VERBOSE_BOOTUP.

Objections?

-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
