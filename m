Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4708C3ABBF
	for <kexec@archiver.kernel.org>; Wed,  7 May 2025 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vd1kP3jlGsAa1/WrA5dgigKmpDxOwjsZqjH8zD+YFvM=; b=PibofFx14hEuUmBzIKgBZoE/oL
	ymFZDZSpWjahisk9Ob1ZwquuSdruLk7W5yuDz9eOHxuGS3U58Gguv0PTV3sqAWCmP4TUxmpMHmKzy
	O1Zj5H/9Z6utty4gjPCAtIH1aKzHiUgBa2QAtcPk1EtJkoJJghtdrjcVgjL2AQX1TpdbdXGyGUOwm
	hZlDI9XTbX1sCP6TE0asDQfg5wm8ILCEiFHTWVmvAvZfTe+FBr3jN4Pf8nOkapEVgr4C93vSR3diJ
	dJqi60Jl34PdeWNjUNpBfRGsHg1AtYj2fxve6QMjr2KbGQbt6ON6fO2W+yi4z9vO1R3vEjPTKmFi9
	mDH0qqlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCba1-0000000F39V-0Yr2;
	Wed, 07 May 2025 10:00:45 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbIu-0000000F09d-3TZY
	for kexec@lists.infradead.org;
	Wed, 07 May 2025 09:43:09 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A428540E01ED;
	Wed,  7 May 2025 09:42:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OinWf2BSwkrW; Wed,  7 May 2025 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746610964; bh=vd1kP3jlGsAa1/WrA5dgigKmpDxOwjsZqjH8zD+YFvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDFvwGafN0Th8/qo/ihTfnszbhzQn+wT+ZETp0X/to5cQgR5nTIWt3xbKH1ftbVY7
	 cjy4PIitedWGDjA+fpImZowNHBiAcZ5QESmMuGasQTbPrCYQ7BDwEvUYzJaiyPyl4g
	 seCRlLQpzl3EZQYZon1kJzaBG9fblD1p1RFYtGDSfHAuPW8sVXe8WSHEFTSpCrC65u
	 jZKd48dPU++3SQsJzncG2COECZKOUA10eP5o3426AKotV8+z8TzBWkdeFtPR3N/tGP
	 NtslWCBAg4GdIRYLn6dep7YW/SCd3/XBqTbWQ3NLpwt+ICdYWatpB6A/bJvspohFgl
	 mD/xi6345sUpwiifTPR1ac+4gyt9qNu16X2yv2a7zy/Ebp/dZVZdgsOVkMVGyuP4SR
	 zO1n5BedP28ExBCYusE2GdfmkuhwROkeKU+D3lQjfiqK1rVy2cDo4oZ2HjeQMVbPVJ
	 pJazDmB3rvbUhOG6QyLslDAHLAbbI89MgvuDJFnjRan3ESUKPdlgdt87Kic4lDQSUu
	 9E1WeyP7e0C+L3giR7kGKS7dx81KBqKgMofunNSn2J24hDzMPgxQl3HvGdlVrymepa
	 Utc/IQUlMu+LwLcLaA61bPRMqTNqRWzJ/wjtieS6+7J+MP/w7Gw7/knBaFUQNj0jwx
	 cpF1CZ0yZpi8cbil45Yd2WUs=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9BA040E0238;
	Wed,  7 May 2025 09:42:28 +0000 (UTC)
Date: Wed, 7 May 2025 11:42:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
	ardb@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v5] x86/sev: Fix making shared pages private during kdump
Message-ID: <20250507094211.GAaBsq8zEJMAuffwmh@fat_crate.local>
References: <20250506183529.289549-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506183529.289549-1-Ashish.Kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_024305_021636_9DA4030D 
X-CRM114-Status: GOOD (  14.32  )
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

On Tue, May 06, 2025 at 06:35:29PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When the shared pages are being made private during kdump preparation
> there are additional checks to handle shared GHCB pages.
> 
> These additional checks include handling the case of GHCB page being
> contained within a huge page.
> 
> The check for handling the case of GHCB contained within a huge
> page incorrectly skips a page just below the GHCB page from being
> transitioned back to private during kdump preparation.
> 
> This skipped page causes a 0x404 #VC exception when it is accessed
> later while dumping guest memory during vmcore generation via kdump.
> 
> Correct the range to be checked for GHCB contained in a huge page.
> Also ensure that the skipped huge page containing the GHCB page is
> transitioned back to private by applying the correct address mask
> later when changing GHCBs to private at end of kdump preparation.
> 
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Ok, I've pushed both patches here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent-sev

Please have those who are affected by the issues test and report back.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

