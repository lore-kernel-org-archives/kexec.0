Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F03E71093
	for <kexec@archiver.kernel.org>; Thu, 21 Sep 2023 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rkioV4deF0JLlao3yozwvE5lV+woq1xCSsO0dTk0WRU=; b=hIEYB3g4Y96o4t
	X89UAc4W37U/50dL4Mmww2ryxe6Jqk0+bokrB6KOUpFb8PNwcMjkI5xMpuHO8QDg6RhPDuGHfnM/6
	4QzpiEARCPXIVUFJHuYWIPb9Plcuo8SQ4BwkYeUjs6yjrqDTJZ/napPwpQvhcYoegdKLlWwATSIRJ
	NTy3cNex9H3WXTxCyFHMcoyenedXgcP1CnHmaWHhQhIjhYGW6fWihmwYYC1m9IS0FM86WNZJa+3Lw
	qRlu/rGPifJQSruKwGjJJUeHj0+txKZLDvrKM5nkRuD932sWDn92clve7PgD6SVGNp4LD5+74hkA6
	vGdRGKa1o0RI9a1XbWJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjMDt-006TPM-0u;
	Thu, 21 Sep 2023 16:08:13 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjMDp-006TOc-1r
	for kexec@lists.infradead.org;
	Thu, 21 Sep 2023 16:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695312489; x=1726848489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WcLEf00Eqb1E6LPJncnTQV2d5+wdroqiKE95ygxlftk=;
  b=ZElK1yQ+DsZQkMLCu8BDD7MLPCTjclDdzGLezEL3khM3NNV3tdSTdRe1
   SdUdbAfZO9uUcq0KGViDWaBC1eYrWC7yvftYfqoiurWQDL88TFP8jS0aH
   0EAgvBEDVltdB1TwAlT1QWxcSrR5Nv2JeUmPIljhkStrnFQzMRM90jsTA
   RfEL52FRTqZw2H9YP2/ZHDZlXbsIEbAZ5nB7Dpu+aBEr6YFfSW/Qm+Zbv
   GLn/3GMeM0/8F1SRkFd1jnMplE04uFsoLi0aT+xcCprFU863oHTbPDhwR
   bYQ42D31bPVMyIWoM2fTpfqPRXcScIHKOOKVcbqFsR6OzOtiXB4HQ3Ffh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="377858636"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="377858636"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="740706780"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740706780"
Received: from xwan118-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.51.175])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:03:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id E4B0B109F14; Thu, 21 Sep 2023 19:03:25 +0300 (+03)
Date: Thu, 21 Sep 2023 19:03:25 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@google.com>,
	Kees Cook <keescook@chromium.org>, Aaron Lu <aaron.lu@intel.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kexec@lists.infradead.org, Tom Lendacky <thomas.lendacky@amd.com>,
	x86@kernel.org
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230921160325.g5ei2gfads6deb32@box.shutemov.name>
References: <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
 <20230913142410.dfqsg3l5v44mr5j3@box>
 <91daa8b6-57c2-424f-8c6c-647e05f2a8c9@leemhuis.info>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <91daa8b6-57c2-424f-8c6c-647e05f2a8c9@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_090809_688933_482FF6A8 
X-CRM114-Status: GOOD (  18.26  )
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

On Thu, Sep 21, 2023 at 11:54:15AM +0200, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 13.09.23 16:24, Kirill A. Shutemov wrote:
> > On Mon, Sep 11, 2023 at 05:57:07PM +0300, Kirill A. Shutemov wrote:
> >> On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
> >>>> early console in extract_kernel
> >>>> input_data: 0x000000807eb433a8
> >>>> input_len: 0x0000000000d26271
> >>>> output: 0x000000807b000000
> >>>> output_len: 0x0000000004800c10
> >>>> kernel_total_size: 0x0000000003e28000
> >>>> needed_size: 0x0000000004a00000
> >>>> trampoline_32bit: 0x000000000009d000
> >>>>
> >>>> Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/id=
ent_map_64.c!?
> >>>> pages->pgt_buf_offset: 0x0000000000006000
> >>>> pages->pgt_buf_size: 0x0000000000006000
> >>>>
> >>>> Error: kernel_ident_mapping_init() failed
> > [...]
> >> The problem is not limited to unaccepted memory, it also triggers if we
> >> reach efi_get_rsdp_addr() in the same setup.
> >>
> >> I think we have several problems here.
> > [...]
> >> Any comments?
> > =

> > I struggle to come up with anything better than increasing the constant=
 to
> > a value that "ought to be enough for anybody" =A9, let's say 128K.
> > =

> > And we can eliminate logic on no-KASLR vs. KASLR vs. KASLR+VERBOSE_BOOT=
UP.
> > =

> > Objections?
> =

> Apparently not, as there was no reply since then (which is why I show up
> here, as it looked like fixing this regression stalled).

It has been fixed in upstream by the commit f530ee95b72e
("x86/boot/compressed: Reserve more memory for page tables")

-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
