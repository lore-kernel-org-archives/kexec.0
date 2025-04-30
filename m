Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9428DC369D9
	for <kexec@archiver.kernel.org>; Wed, 30 Apr 2025 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1CXwSD/7j6NwMGG4ZTzid19BC6+JXchxfFkihst34w=; b=TR0IhzENDW3sjoJmfAhGjqN2/J
	WEczTfxb/bddHsDqZvTBlPFkzRTyUTA8bWdABbuFt2YFJqFYYx6P8HdOnFY3rmTzgL36rhc+DXuj9
	frOu6oF4rL5VVS/kia+j/YctfaGsTNA0pHUH+ycZiBtNanHFGcvXo3b3brq6LStW2+bdq83dQbIat
	s4azJG9w/hPOyd8Ger/XHW2oEku1J/9XwFmlJtCWdZDQcHrpyiHOz/FJK/VnIJCsuiL+506GOs5dF
	nYBFmv9g/nSurrIZ5PA5Vd3FwhQg4o6lDeUd8qgej7DhIo+cvTxzj38S/kwPCss9f/M9RHhY+hxVR
	bnX8rYZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA7ZX-0000000D0oI-356I;
	Wed, 30 Apr 2025 13:33:59 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA7Y2-0000000D0g1-0gYe
	for kexec@lists.infradead.org;
	Wed, 30 Apr 2025 13:32:27 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1791B40E0214;
	Wed, 30 Apr 2025 13:32:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lVgQPf0OlpAX; Wed, 30 Apr 2025 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746019940; bh=A1CXwSD/7j6NwMGG4ZTzid19BC6+JXchxfFkihst34w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iso/t97O4sCD8JcHCssOB0D0XRGWmX32iIraGerTh5NEBTbcs9T0GbdMp/U7DtPcO
	 cAf0Q5p4itQrHWSEfAWlGXf50qMHkYQxHStiweP0v472YuXJAEXBFPXCNT6rtmBf8d
	 Oj9dm1uCyFPyUCSxKMhaUPjvyld6xQojCDXT5NYpP2keKQB+Gk3N8LgMi8/sRQXWrw
	 euoxensXE7TpEjb7FxHADeGlv9IHRIPcZBp4r/iOBDyj86+SVt400ZH9kI71J484yf
	 tblDIS7SROL9YHhmxlwwcMZROkkqOZhEtFuSv5ytd/nLyvv8aMg6EwoMGF60tn6aGw
	 YZCtAHnP5br9OgoMBczGWjs+qYwS4Iz/XgwN62PWvy7PvJmr9NDm/GKg8n7f+idGLT
	 7S37pJGf0ZGQH0XA1N2M+Z3GqNHo8+CPFIXHtZPqzjfI9U0SdZKtVEdkS4BMES6Vb0
	 Mn2YuggWaaagSV8ZyizN/BN5p35zSatsYlVe77GX/3EWxUTZ6ZuCb21x2X6ubP4fBa
	 3kntCATbaCrCJIfuIPm3fg+1ALzbW7gQ6bGLIVH8aQUjtP8suWlu62bcpvgNFBtZbM
	 X85uW67/bgi6YSTa70xhyqFwXmmUuFg7fp+KymNW8QcEwBWrk/XIdC/YmH2Ewa6jCt
	 fsbxkEmKrqDzcNil5LeUHB4M=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EA7740E016E;
	Wed, 30 Apr 2025 13:32:05 +0000 (UTC)
Date: Wed, 30 Apr 2025 15:31:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
	ardb@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v2] x86/sev: Fix making shared pages private during kdump
Message-ID: <20250430133159.GEaBImTw8E1cqU3k5C@fat_crate.local>
References: <20250428192657.76072-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428192657.76072-1-Ashish.Kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_063226_352278_92710C89 
X-CRM114-Status: GOOD (  11.50  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Apr 28, 2025 at 07:26:57PM +0000, Ashish Kalra wrote:
> There is a bug in this additional check for GHCB page contained

You don't write in the commit message that there is a bug - you explain what
the bug is.

> within a huge page which causes any shared page just below the
> per-cpu GHCB getting skipped from being transitioned back to private
> before kdump preparation which subsequently causes a 0x404 #VC
> exception when this shared page is accessed later while dumping guest
> memory during vmcore generation via kdump.

And you explain that *not* in a single, never-ending sentence but in simpler,
smaller, more palatable sentences. Imagine you're trying to explain this to
your colleagues who are not in your head.

I've been staring at the diff and trying to reverse-engineer what you're
trying to tell me in the commit message and I have an idea but I'm not sure.
And when I'm not sure, it often means the commit message needs more work.

So try again pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

