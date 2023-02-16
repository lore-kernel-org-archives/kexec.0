Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD39BC61DA4
	for <kexec@archiver.kernel.org>; Thu, 16 Feb 2023 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SRn5vtkURVL7VIl4MYfAbQt/VYtv5zZorc08iE8yl+M=; b=PgWeH2WJvH5bMt
	262TJqhnuLUQ4RtPCKoA3z206lEIvSLNWZ+FdwJf9omrS/e8MfdKkibwnfIKpWpOKvd5sZHiHK1zG
	i9cpK6XhCH5XzrvhUwJDZRLTzdP2HsnnPNHH+ybc9c7NwXKz+m+Gfe9/L0Rn0J9ptsFFEdY6wXoH2
	np7L5jW/3EsZ/+6fixKo2kKja86bCxtNm1eXLhKy7EG5eQI8X0o18/SULhuri5jHJHDpPsy+823U1
	KHpBkKHEUFrPo33xUeCZ+neCTFtfs82+M8bnrSNJ6UD0JJIdz2Uxl+7YvqlLkgM1DZjs3iBNl6plJ
	GVXKSzYb7lQ5rdi8+p9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSaup-009NL3-M6; Thu, 16 Feb 2023 09:50:59 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSanx-009KOG-LD
	for kexec@lists.infradead.org; Thu, 16 Feb 2023 09:43:55 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 648C532005CA;
	Thu, 16 Feb 2023 04:43:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 16 Feb 2023 04:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1676540623; x=1676627023; bh=Ma
	uptOrcEq/R4JiJgXsd5CZP971Bx6za6UCWfDcqgIE=; b=bdgv3Sjeg13bIffXGI
	0jm1TgPqMPZfDIlNJSvHzgbUWMrufucwfQA3CaDXEHjomxiDAdLbdhKt/qot+pu6
	ZgCRUqLHiCTcZlur9VoAUorQzBSQoakIXwMBjFfGlC2y2++tNDBUQA0kv1RcB9to
	TkYJZ2Hrw1sEc+WbKwibGR4S4BKHC5gjG5hCUeqhc8veB3z+Nh1WlPJUJw1Bi0Tu
	Gmxd+noGE1xve0uy537Mu86e8gOzkZ208dcAj832jjMcxlFdPbgCbBe27AxIJKNW
	pjjaxeRyXDzdPIC8sQhXIWPhf5CkRT2t/515qkhVp6Svuym+zllg41YQa72GFfEJ
	3gkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1676540623; x=1676627023; bh=MauptOrcEq/R4JiJgXsd5CZP971B
	x6za6UCWfDcqgIE=; b=jv9I7BrJh7rTlSTGHV7STFbjydsdYrsZ3gmB/mmiFy62
	x9Y59OQCrMRYMuzGtIvBDSJ7levTWQZKcNWjDHzGscrNfbQb+4tz2V6b8JxDF0AU
	DSojRk/OD8+kfgl1mfGr4N2lVjdpaA3fUY6QFySUDJbXOrOR3ZbDU/Ecodq3//ZG
	2rLw6/QPzoOYr+fgDH2Z5tnexoVhQpDHOc9wWgG/nQYWhwCeOrRau3Fk9Ogttn7t
	owlBGqMa55JMbm3HQoCVIiRbTcJG1BQiniS8nO2cxYhNGn8aHEkmAGpNaaFiCVDI
	26+P4WleCJb+33PVYdTQUSujU/ECPP88cFBW/gfSkg==
X-ME-Sender: <xms:z_rtY2LbGZnwawWE1FIv3x5whMqJ3-XeCV1Ay-Jaw5p9WKVyC9-RPA>
    <xme:z_rtY-KQau3iRw-dD2Uw6tDTo8NpsjBqPoJ-r3-2-d2LscWcArtIVDdB8sc8RfiVb
    EqDliDuTims0n2bI08>
X-ME-Received: <xmr:z_rtY2sUQ1ijXaUcmEkmxaDeW-eh6FxxQ6P7FafD1ZRkIOy9inHd8z3CRGeONJv3kmnU8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:z_rtY7Y_b7r8EhDXm6Ayn4xk6QznTAUNBjg18LpPvrGdm_MM4V8G4A>
    <xmx:z_rtY9ZopyDoaTR6ORJYuhHt4aLH6J3PesMUSDxbwsNb8_-81szxTQ>
    <xmx:z_rtY3CDpgmXqSuJUsCVkdc7Jz59ItGE_5dPzLNKlbOTuiNS_gl6Rw>
    <xmx:z_rtY_m5S3AyiS4h4f-UnmymdiseCASbaAUMJs6e4MN273JeOrYpSA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 04:43:42 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 5F03E10CCE1; Thu, 16 Feb 2023 12:43:40 +0300 (+03)
Date: Thu, 16 Feb 2023 12:43:40 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Message-ID: <20230216094340.bl3k5q6ine2luhoz@box.shutemov.name>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
 <bcaf4b7121e20ba27dd2cc2b347feb35ae7bfa53.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bcaf4b7121e20ba27dd2cc2b347feb35ae7bfa53.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_014353_740145_434C01D3 
X-CRM114-Status: GOOD (  11.58  )
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

On Thu, Feb 16, 2023 at 01:49:39AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-02-14 at 02:48 +0300, Kirill A. Shutemov wrote:
> > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it
> > leads
> > to #VE.
> > 
> > Preserve the flag during kexec.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> I wonder whats going on with the pre-existing switching between eax and
> rax in this code for the cr0 and cr4 manipulations. Do you know what
> the reason is?

32-bit ORs and ANDs save one byte per instruction. And there's no 32-bit
MOV to/from control registers in 64-bit mode.

> 
> Also, for a simple non-tdx kexec regression test:
> Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
