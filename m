Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22114C27C53
	for <kexec@archiver.kernel.org>; Wed, 12 Jun 2024 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2zM9sJzZGY8+iLINrWHhaFnvBc/8IAuaXn6njYN5LIA=; b=4Ii8w3Nrrubp/P
	qe8ggLH+lkP8fBcsjPSo15FQqxCtzX6O9JLo+UMYaHeQUT1boARvEAYrwaQydO2I9Cv4FrhLE1mY/
	f4jUfdrm1A0T3f6jFdBdlRjpXbWaVxc7Rn8hc6WAi3alJ3Y6Xb/cvO7Zc3Wjirvoxpyf8V29Q0ntO
	qxFj1tjp9K0G4f8TDwpdfJgx18lm9xOrsT3CDQ54Fq+Nf7UvdmxObkgHf2a1eueCBewr3CTg0VS3K
	WT9j/7Ib4zQOSf4LZ1LpU3HYpsaAcr/PoHCngqjnPgA660xilOz4f9VhCDFm05QVnsifA9z0vnJYi
	0DFB89keSsP6ngJZRIJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHKJM-0000000Bzxd-3NS5;
	Wed, 12 Jun 2024 09:30:32 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHKJJ-0000000Bztf-0B7X
	for kexec@lists.infradead.org;
	Wed, 12 Jun 2024 09:30:30 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E7E8D40E0176;
	Wed, 12 Jun 2024 09:30:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4kBlhHtppWTH; Wed, 12 Jun 2024 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718184617; bh=bAaBH5qaA/JFcGMfRi72p+tRzwYREYvEMYDRH3DvGZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qsc+AJ2qmMEYH1GmdJ83828PmwbIvMP3sUK4daOukV73GEF20NSxER0+reGrO19uM
	 enPkC9nyrprHCoS67qACrJZ6AC236TaKczMgkdfP9ndjVzVMRLBuqJpPl/zUbgIL4F
	 j7TPT3ohwQ7tErya9eEnipyOdJEg0ctVbZWs+4m632GkVdYeVdekf/qkXvTScifNaY
	 dX27wFRjeZKQ43p1zAbp64UfA4b/jwZsIqc6R9v1ljrqd/5holDsEmLEsEvM03Iv8d
	 70HThSZKGtLrQyaaGH7jj9EK0D4oghYcQSt0vGljohHLJyQ+SAjaV97ukJbGIET8/X
	 Jo9m12QCRFBdDMUXlImk41mbjLSd38G5IY8tlP1WLH3qu2eiguVk57A+GFIFhSGLG1
	 sJXAeb5KSTM5QCxuKRIKgn7CeddxcPEVgnn0uCEMTRhmfjUyh99Y1TJ+AdytrJJXbg
	 g7gH6jyMdp7VFB6YFc70bdkKU41w2xcKniRlcbgYbPtyvGM3H04nCbHyo7QNv/xpw7
	 7XoPxWQnXjNhbBxnnlYyg41SnrbZyzZMjarQGWA0IIHJhMtKjxfJfHPlUZZWWHTevP
	 3M+3mbFDLsLdTSSTsgPEc2QHFfqberzfPrWjfguIc/dgowqsvgMAtAh8XTehTAIo/L
	 NqKts/+d049xpp32sa3U8rLY=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBEAB40E0081;
	Wed, 12 Jun 2024 09:29:49 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:29:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <20240612092943.GCZmlqh7O662JB-yGu@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
 <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_023029_281448_03ABBF59 
X-CRM114-Status: GOOD (  13.68  )
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

On Wed, Jun 12, 2024 at 12:24:30PM +0300, Kirill A. Shutemov wrote:
> I will try to deliver it in timely manner.

:-P

> > Yeah, we have a bunch of different pagetable manipulating things, all
> > with their peculiarities and unifying them and having a good set of APIs
> > which everything else uses, is always a good thing.
> 
> Will give it a try.
> 
> > And since we're talking cleanups, there's another thing I've been
> > looking at critically: CONFIG_X86_5LEVEL. Maybe it is time to get rid of
> > it and make the 5level stuff unconditional. And get rid of a bunch of
> > code since both vendors support 5level now...
> 
> Can do.

Much appreciated, thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
