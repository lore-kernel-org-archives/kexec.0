Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1376C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7Ux8SvwXgyrbJIRqj3C7tDh9Pxj7i8inIMKgMzpWiU=; b=kuRrnfvLwbGrojbKQySZbSn/8W
	rN05yJnFwpvokzfpIhSqnk+Kl+a4CUnSYgRVbdenGpUZdlultAtFmPebIS/hMZfbLkU+HAG9L1A7o
	T44oHDTeNrIxTS7Xc/xRo16OeXKTUgdJ5OPAGQo7+rWj0uScMbFfvIs03SZe/aKxqyWS7l64FBG2+
	NPHGBhUw6qIrqiob+1bPY4pBSyABdvbrKYjq9oTy8N3BIbCrpWdC6u/WyeEWEjYFgycIAmL53brdC
	CfsdI2EwIQF38dDp1U5CkdqVAtbwqqyPz/3P08JqLCjwuCpFHYjbur7UwJESOtm3Edcj7NyynHoCL
	ne+MhnsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weyG1-00000002dyl-1IoQ;
	Wed, 01 Jul 2026 16:57:53 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weyFx-00000002dqC-2Z1O
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 16:57:51 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6E7C040E00C0;
	Wed,  1 Jul 2026 16:57:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eZNWrhC4CrjC; Wed,  1 Jul 2026 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782925048; bh=D7Ux8SvwXgyrbJIRqj3C7tDh9Pxj7i8inIMKgMzpWiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xc1Nsy3vHp6PaNdjT+jQ70baAzX4p0TzIG/CZnSa4VJvncqiqcWp8r00M2QgYVYj1
	 Hq+WWl7zy0kCyJ6ET9ynDbm5VBGFYZBbuYgEqWeUtCKtzcSjtc+XFomqX+4EvX6J7f
	 eGEKuKXSpYqmcp5/B6tDriB7INwwiTDgTlvcj5oC7HO29LhN6KwhhZN857Hnu3ANsn
	 3EZCFSgsT009K+Cd0akgIRBS2y1BbiBZabaIitPRlR7z0l1Xcs3LrbIc1kA7gXUGew
	 VEO7PMQ7Y/ICPpKWQcmPPoOk+r0nbmWlolymnaiNIQxC0k09VsJWUi4xJblCr7/zDl
	 3cCOipvEK7p0b9ajEE6czHcij8cI/TgXvxxVLRkWPfZaAUYVRT0v3DOqLHY84hOUIn
	 pRP7A3bVIqg1bzfurbYh6tl2l7Ooov5xKq1565GYLV/lFTv0ok7J0ZvLoYifnLc8EK
	 uF7DfYqHbh6q4m6yJpse5NSjExhBV1qa6XEEz1mg1JQcRMSZ9hrJeu4QRRrZjnMyJ0
	 w4nqXOA/uLEiNuwUo3+r9DCsAb+P7ZCpA3o8RPMvBHRFZah2zwWwEy5G/M58Zc+4Em
	 JoJX4xpoRceA5lj13t5Fpp7kkMSb4wBdpKhys5PayFjiyfP+SPmOwhNpZk7dhgV7D4
	 ET6HPJNim2jox8ei73kXaqys=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DF9C40E01B4;
	Wed,  1 Jul 2026 16:57:17 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:57:14 -0700
From: Borislav Petkov <bp@alien8.de>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] x86/setup: do not include kexec_handover.h from
 asm/setup.h
Message-ID: <20260701165714.GAakVG6p191JTJ0nJS@fat_crate.local>
References: <20260701151536.3068791-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701151536.3068791-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_095750_385565_F796F523 
X-CRM114-Status: GOOD (  11.73  )
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

On Wed, Jul 01, 2026 at 05:15:33PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> x86 asm/setup.h includes linux/kexec_handover.h. This is because it is
> used by setup.c and kaslr.c. But this inclusion is problematic. The
> header is included in many places, so it results in the KHO header being
> propagated there. Also, the setup header is used by realmode code. If
> KHO header includes things like mm.h, it causes a big dump of
> compliation failures.

This is exactly why we are trying hard to block people from using more linux/
namespace headers in the decompressor code. Please split it and put only the
bits that are needed by the decompressor into a header in
arch/x86/include/asm/shared/ and use that in the decompressor.

There are examples there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

