Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D5AC43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H62G7zY/G7fEPGH1tQglCcEYZ+0YjI+oCCkcVMWIavI=; b=uXUvg5pFzJDVdkCvBGeLGacOdz
	xSU3/fyTHkOeAl/bXDuik9kqI40/R81TBWOr5a3swAIWuUYI7vs4M41ah4tZAAuc1dPtyTxuV14zR
	8fYGlHytDQxXShr6rM1kBSgz2CcM6ces2EidosFpBpzRBTc3dWm+x566vMwCv1vnHVwGd57a4WqAc
	hhFS2hHFM2MAGbX/HRgJKDGXxB7K9xoFGfcjBQdX+EyzOWqJGj35NY5bd6QVVyacYTdj0C6UG1waS
	om3SwijMbLMbP4xlnvuwep2SeCT7BhIdNHcP42GmFog8SJh96/ax61rqT2XHa/pXjUSGSIB/3LfGj
	gt0gm4Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wffYN-00000007N2N-2N5m;
	Fri, 03 Jul 2026 15:11:43 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wffYK-00000007N1K-1VZ7
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 15:11:43 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C56E40E01D8;
	Fri,  3 Jul 2026 15:11:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LGvNGMpdV1QX; Fri,  3 Jul 2026 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783091485; bh=H62G7zY/G7fEPGH1tQglCcEYZ+0YjI+oCCkcVMWIavI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HP+5Ufqh6uVGlyJF32W1CkhFFK3l0dI8tiHdkZF+0QiNTGa2Xb303AT0/H+UuOAje
	 /jTxnzi4cVz3GmPMGjTd4AME9r1w22ao/RlFRYdvrsLtsOTWB0YE2aCUusD3BovGHB
	 AJCNIB1Pd76bQZl+EA5WOGTahmN60OxgTkDXWJORX9YMIPEhAJ7dRunhdvfa1LQIdJ
	 yPp+emyuU6XxEfJs0rnAmhKqmkjwJx6ncpC8vwv0oZRMCLgbBGj2V3hKZ9C4Ipqf1c
	 8KMKXH/FX0rKRD13DQDCWGbamVRQb6JnJTecNfgi7Mv8meFRQ3YNU24UpMvevb0rj5
	 mogA5Nq3hX6TeX5rsPakguJZ7gvwQ+8gTe0yPzYokjYQ24OmXcTibN24/cgPVjHnf6
	 Yf7UwGfrLxV6sDf7OAJC9gbImhujcQyTLvC6oYzc4AyVpt6CdtcU0RiRCgeGz64RYL
	 wIOfR/ZgRNfCb7QXBC3viPXUF/Uq+MlI4P1ulZH9rlrnLqFtIKFtakWnsLgO5qkMbp
	 0Q148uUQ8xE0gw1ml7yXJh3Y4ynVU3WsrVNPodyLf9dyuFWVWhg8VtbPnmDgC+TBny
	 8jp8P8aMPpD0mlVvUy1KV0/Pz4nX5EtHMFIBg5+e1yN1z3QlKRd/ZuST0G4pgBYzOy
	 7WTJyY5fVGUQmoO32dbm6Oj4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0313940E01CE;
	Fri,  3 Jul 2026 15:11:14 +0000 (UTC)
Date: Fri, 3 Jul 2026 08:11:11 -0700
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
Message-ID: <20260703151111.GAakfRD6J8a1-g-aua@fat_crate.local>
References: <20260701151536.3068791-1-pratyush@kernel.org>
 <20260701165714.GAakVG6p191JTJ0nJS@fat_crate.local>
 <aka8f1RNJH-zI7Kl@kernel.org>
 <20260703001128.GBakb-MO4o6AUffNAx@fat_crate.local>
 <akdUX4vUEEJWrlGO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akdUX4vUEEJWrlGO@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_081140_599490_01307D76 
X-CRM114-Status: GOOD (  11.45  )
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

On Fri, Jul 03, 2026 at 09:19:11AM +0300, Mike Rapoport wrote:
> The size does not matter ;-P

Yeah, that's what they all say :-P

> asm-generic would be my preference too if that's fine to include in
> decompressor.

Sure, the main idea is that if we add more linux/ namespace includes into the
decompressor, they end up pulling in the world and more and then you end up in
build and include hell. So we try to make sure only more or less
self-contained headers are included.

And there's a bunch of build magic in scripts/Makefile.asm-headers and this

# Support for using generic headers in asm-generic
asm-generic := -f $(srctree)/scripts/Makefile.asm-headers obj

in the main Makefile which lets you do things like that apparently:

$ git grep generic-y arch/x86/
arch/x86/include/asm/Kbuild:13:generic-y += early_ioremap.h
arch/x86/include/asm/Kbuild:14:generic-y += fprobe.h
arch/x86/include/asm/Kbuild:15:generic-y += mcs_spinlock.h
arch/x86/include/asm/Kbuild:16:generic-y += mmzone.h
arch/x86/include/asm/Kbuild:17:generic-y += ring_buffer.h

but you'd need to try it - I've only heard about it from the sidelines.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

