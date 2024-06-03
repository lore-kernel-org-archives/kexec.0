Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003FBC25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BdX6W32UWgVWgPpFSoViI7soHqk1ecT7gTdX7TOvea0=; b=foj/oyjOZkK4JB
	IepLhPZu5rODMo74YjsE4k+IuDYR6R3U+zAO0NKNtCHFqChTrH4BbktgNt1lgATAIXl5aGMZaQzcl
	lEnkeSz4iLgLyFGr7m/mYxIMj9kqiyNGDpB/MU00GzwF4TpTHcGTBhQv5HMc+9Mub5r4at7R51pjC
	0IxuEp8RwF5txSLCzTX9935wZoyctLomKtyO+JR2L5JFWgUezbdy+FCbtdJw02wMBRCfmfngPGSM4
	43YFEqiit8yZqc8xeEVGpTwbuKfRL11HNieS77yb5Fw83YFNrXoxlBWoTCltRe1sRmg+dC9oEyC5o
	qMhsCbmdeDfIolPwQWVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBF8-0000000HTcv-2FmY;
	Mon, 03 Jun 2024 17:13:10 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBF5-0000000HTbf-1P3U
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 17:13:09 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CDD140E0177;
	Mon,  3 Jun 2024 17:13:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zLdRqpM4nFQ2; Mon,  3 Jun 2024 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717434781; bh=wOb77vMkzvVjJuhfqxH+VEthZC7Q6K8Sm8HZ2/2VE40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoaF02iA3K/R2Ga4rSD8TjWmvRmhPDxfX3vDeaXd+3U9e5ZSUahv33jd7fe/EXJJM
	 8FTXfVfhfDQ4u+ust1pO7uax3JgQB5Uy44DW5H0XNR2lM4uBglT0SYhpNdQfMFj9qB
	 k0p9ZBF7cXCZMVWwKeNuM4XF5sM6uu4n3WfmKQ81sXI7yr2lBKmGDYgoaeSTMsGYYs
	 K2PA9a7pxIqXSvg1/+10b+ty69rzST/Zxs2Zcc6OrhoS4wljm2MTV/KBFKTGiA52hf
	 ONf5o4GGnDJQy6MKh97jSpYf6SdlTqR2OyYNR1cUbO+Z7YCoQexsCcuGXASVFspuEM
	 jGXqeZp6cHr3WIcHxQNJTH1jPIj/A7p96BHaU2FtwDkolplAUBoPsC31O/DnJSdB5v
	 IVDfUcdNnyxZBmfkhHsndJMdywSZ1ZapwYxABiZ6HNZfxs8yvqmOB+xKhG3fBlDuIM
	 la4gCiMeTcbV9X5vmPNcpFoPDuaDNiH0+8uED+H9Hwe4J2gmUbf531rX6Ep1y3yuMy
	 +NIPKYBNT8e8/wcXaeLzVN2mBe+kCUM3n9EYAUBlLs62YERvkpwRJKpUoQfKoZcRQC
	 j9nOG6K/KO1JGOpwggSeu95jo3dbAmo5xBRBi91Ag8xR3he86BMG6WLrTrqrdUV0CV
	 Dz1+sR6jE5uHY8WXwPpf0LsA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AFA940E016A;
	Mon,  3 Jun 2024 17:12:32 +0000 (UTC)
Date: Mon, 3 Jun 2024 19:12:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2343889c-887a-49ce-86df-343737d70d37@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_101307_556763_DDF96FBA 
X-CRM114-Status: UNSURE (   5.30  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jun 03, 2024 at 12:08:48PM -0500, Kalra, Ashish wrote:
> efi_arch_mem_reserve().

Now it only remains for you to explain why...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
