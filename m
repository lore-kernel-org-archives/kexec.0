Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B98EC43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pt58UFrI+m7UNalVegnFEw3qwRjZ/a9DXQ+poHAhA6s=; b=UKKGfSCiMrWLg4aEXQBFwr6Z1i
	DyfQNoAI/ron5OkuD6T0vtjrwkNjnL5nGAQsi57r03igELsJd4cQ79b4ZbCi1uTdh+bobnBsATIbX
	picADDP4EuBtV+H+u/Sg5QJXxacF5zebrcuRXYfqqrCmvbI6y7VP9LnTU84VHXN5WX8i9PDt7Q0Yr
	zxRhI37PSCl1ZP2EoJ1OqRdgq1ZckJZrkRs66K1NVSfoxDM5jNRlPvEf/uC7S8LSxhzoVumOth0yZ
	YA7lDAkJIZvDM9A9GhDhaBhnvrQruH7NoxcR9sIcXYJF6FPQcxFypQGd7Ld+2wSOjyIfxf1L8gxhS
	aKq9Apuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfRVr-00000005mUJ-488U;
	Fri, 03 Jul 2026 00:12:11 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfRVn-00000005mSn-2Zb6
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 00:12:10 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8198140E01D8;
	Fri,  3 Jul 2026 00:11:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IOgeZtdNccZh; Fri,  3 Jul 2026 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783037502; bh=Pt58UFrI+m7UNalVegnFEw3qwRjZ/a9DXQ+poHAhA6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYBPO/y/7k8uoPBTbauuEAOnPEBF/i1DrDXVCfg72niX5SQC4DACqfJm1mHurCA7v
	 PjiU2HkElA6i93BdExSuydRR+mC6K+hrQzAmrckXR+QlIVsHSpi+MzFAciA/bW5+Pv
	 bkvfw4WRT0KxeYiE4BLfr31KrsICbQvN506uUj5Ni15H8vew9EGp6w5F2fAUB8wg8U
	 vtTNjsZu2T2Qja0mI2fdzTOkxSJ2dPi9b4mEVsXCTsSrAFTZ62+08PBF1n2UjD3h8d
	 kr/lyh7t2OZGXEjSiavdoadUGVnUZU8rk2UMTmaUaC8L3d1CO7hhopxdYg7dEL4uYO
	 YZq0aYUZe5qVz0wY40Vu/ruRQCcA4wfO80EJWzYyAnQy1cY6bfWF007DjOL1q/Fr7s
	 G7eU72rrWBDGm9yo8G0sWTi1SNyey/jf4pSUWA6CrR/EhJ0vljwmjgi9zixc84hpg/
	 y5n14CB3Ms6lwLjANJiMLklwaA5evR9QkvGjRqvnlxPHBJzIL8/21X+4YQRaGjtqnP
	 hUhZPGgV0J0tnItd2W+fdl/f8d/XQhHo5CAiZ+WalFWprRKZu9N39K+WHuLO2PZ0IK
	 X1EwaYYf4+P0gd4OIRqh9Q38EtnzGpK4MYZnyEkXpCbeMuufO6Spqv/WVmrcMABzYe
	 MySJqFe/kcfXzXB899qK/zkQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B84E40E0140;
	Fri,  3 Jul 2026 00:11:31 +0000 (UTC)
Date: Thu, 2 Jul 2026 17:11:28 -0700
From: Borislav Petkov <bp@alien8.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH] x86/setup: do not include kexec_handover.h from
 asm/setup.h
Message-ID: <20260703001128.GBakb-MO4o6AUffNAx@fat_crate.local>
References: <20260701151536.3068791-1-pratyush@kernel.org>
 <20260701165714.GAakVG6p191JTJ0nJS@fat_crate.local>
 <aka8f1RNJH-zI7Kl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aka8f1RNJH-zI7Kl@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_171207_806424_949DBCF3 
X-CRM114-Status: UNSURE (   9.17  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Jul 02, 2026 at 10:31:11PM +0300, Mike Rapoport wrote:
> The examples there are really x86 specific.
> KHO needs decompressor to recognise 'struct kho_scratch' that's defined in
> include/linux/kexec_handover.h

That struct is huuuge :-P

struct kho_scratch {
        phys_addr_t addr;
        phys_addr_t size;
};

> I see there's a duplicated 'struct efi_unaccepted_memory' for decompressor
> needs, should KHO do the same for 'struct kho_scratch'?

You could. But it would go out of sync perhaps.

You could also try a 

include/asm-generic/kho.h

and put only really generic, basic gunk there and include it everywhere.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

