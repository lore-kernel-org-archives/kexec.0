Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF28AC27C4F
	for <kexec@archiver.kernel.org>; Tue, 18 Jun 2024 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5o2AaYErj1dbYucurqE+SvmD325FTWpziZsuJQdcv0M=; b=vri7MCEk/WQPT/
	jnJwAjMZTomfRR3CGh+Yv4ZlDUc3Yt2mEEQrJ23V+fmDdx1o/Ns8R6BosaDxezY/K9AfB5Rq4CEdM
	XZ6ac6ZbhWe+grkG7rqDl12txp0PXyzFFVdjbPx4bUYLDE15xJlldGl5ct6UfD/JwwKVCGtjhimkz
	HDEauvFgHDZ5LPGErOjOwCg0cAIj+SPxxGD6GtpTieK3MSq6kKsyNeofhk880gJpTWp4KYXIQkHbz
	U3H2NJgQqGeZM6xMYC7sUgKtafNTkxsUszeWeiBCDWEsSC7x9RNikxHRyS8/IL6gXiYUPhJhyiRX5
	xDuxeXIHMydb70w9Q5Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJXpD-0000000EqtJ-0R2H;
	Tue, 18 Jun 2024 12:20:35 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJXp7-0000000Eqpm-0hWq
	for kexec@lists.infradead.org;
	Tue, 18 Jun 2024 12:20:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718713230; x=1750249230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4POtStJCjE5RRoSLSG+N/j3IB3Xj43A0ipVnukEbGJg=;
  b=m+0upUEg+kJ2IW0qzJFt2H5o3Zrht00/fhyjnU8N+oCn7/Wv2lZuaI5g
   XQlyNpCQTHvhTeuNbuIMLCt7QvWgQLXfR4NLxZIBfyqdhetcN3Om8YfpX
   VkRzFLomlC9FoCTHeD2NlgJBUCdVHBe+g6DZc3vnDJHQ+kJArnHBHABsq
   RHOkcNFNbLf3Hy8qbz1V1xkAoLIa37dLM1uTnjVSRb2PgrHNDrnZShM2j
   wQOV8uvgPluy+9MpjA6Lbz7NDAJnDY3eJ0wkHJ1FmFUFoyWuJiandnWre
   guTH1ahW7qTzu6YWQEExe8J5I4EQrC9phIrdLgYcVAwwOSsgen81fhB1o
   g==;
X-CSE-ConnectionGUID: 8pf0YzjwRquejJkVEyrIDQ==
X-CSE-MsgGUID: YQExngnnRG++axmokdYdww==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26169870"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26169870"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 05:20:28 -0700
X-CSE-ConnectionGUID: DwcjCin0ROGMSatLBuCePA==
X-CSE-MsgGUID: I5+5RDgfRiK1kXbdoeW9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46659137"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2024 05:20:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 381D71CB; Tue, 18 Jun 2024 15:20:20 +0300 (EEST)
Date: Tue, 18 Jun 2024 15:20:20 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <noxbrmequ4inpxgnwna6drnzuymcn3k6ik2kvlbzacxvr2udgf@pximrevgcgmu>
References: <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
 <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
 <20240612092943.GCZmlqh7O662JB-yGu@fat_crate.local>
 <w6ohbffl5wwmralg255ec7nozxksge4z4nnkmwncthxzhuv46d@qq46r2wrjlog>
 <20240613145636.GGZmsIpHn16R04QlaN@fat_crate.local>
 <8efff872-7843-2025-dce2-a5dcdbf31143@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8efff872-7843-2025-dce2-a5dcdbf31143@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_052029_437293_FA062128 
X-CRM114-Status: GOOD (  24.42  )
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

On Fri, Jun 14, 2024 at 09:06:30AM -0500, Tom Lendacky wrote:
> On 6/13/24 09:56, Borislav Petkov wrote:
> > On Thu, Jun 13, 2024 at 04:41:00PM +0300, Kirill A. Shutemov wrote:
> > > It is easy enough to do. See the patch below.
> > 
> > Thanks, will have a look.
> > 
> > > But I am not sure if I can justify it properly. If someone doesn't really
> > > need 5-level paging, disabling it at compile-time would save ~34K of
> > > kernel code with the configuration.
> > > 
> > > Is it worth saving ~100 lines of code?
> > 
> > Well, it goes both ways: is it worth saving ~34K kernel text and for that make
> > the code a lot less conditional, more readable, contain less ugly ifdeffery,
> 
> Won't getting rid of the config option cause 5-level to be used by default
> on all platforms that support it? The no5lvl command line option would have
> to be used to get 4-level paging at that point.

Yes, there won't be compile-time option to disable 5-level paging.

Is it a problem?

We benchmarked it back when 5-level paging got introduced and were not able
to see a measurable difference between 4- and 5-level paging on the same
machine. There's some memory overhead on more page table, but it shouldn't
be a show stopper.

I would prefer to get 5-level paging enabled if the machine supports it.
"no5lvl" cmdline option can be useful for debug or if your workload is
somehow special.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
