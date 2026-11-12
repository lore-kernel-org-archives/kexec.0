Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC460A2624
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PtRYc3Ex
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=; b=PtRYc3ExI74vfl6S6O5zekfY2H
	36os/1RxJYsMpY4Yeed+LkmKa1cZiKN3Y7m42f/edgRyiQHevUb8SLhYsa7/cS0Hj1fPD99opqrbL
	pt4JdV+dsHC+v9+ppFHVKFBTA9fpVp2htu4VZ4exE8rROw9zcJrkkjEXJAMwW/lNxHKRcAm/fXw0g
	pKryhzBY8F8Mm94YPo3T9xu7oGec8Dur0QUWsF+KIQKLr2u4SbrdbBiCpeI9ftYlYJRU2e9ak1aTF
	vRsJH19RlVTkMLU7nQ9JAdZvas73qMbnlAAk9Zf7W8a8fQ/cprm1dl3frEjuATOGd1KcLALfZgp9E
	xXL9HSHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRaBi-0000000AvNb-3Th3;
	Thu, 12 Nov 2026 19:10:22 +0000
Received: from mail-ua1-f48.google.com ([209.85.222.48])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRaBg-0000000AvMk-2NXb
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 19:10:21 +0000
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-998d151f441so70216241.2
        for <kexec@lists.infradead.org>; Thu, 12 Nov 2026 11:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510619; x=1795115419;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
        b=OT54GBkKB+u83qTm9jiDlhmf5BpMrz1JZdiRsBZCye+VGf8erf44VSVEscYx4szLMb
         pskYFKXWXxWwgUmI9BORY7EklQsGnWhrKD8qeo4bjCHPhcNkbhLFevCdiuNyMThhzWFZ
         bVteBtI2sPIf0tI+c5OsckfWjQaf3w2+Hb/3uFqqm68zsYDOS8PeoMBFHQM/X0lb94Bo
         MZXfyc7T8MjnbavetEymjaoZsLHxfrL/AgV/hCK8W2BRNO2Eo8MCPgnnd5RrysSUg3K0
         711SaHsOrkMgTpLLsweDAAZCCm3aWkLSRvQebHQ+xGOzPHkqqpHAjci+IgNZn7gi1KGH
         q/og==
X-Forwarded-Encrypted: i=1; AL+hErFm52+vpJ/Rj1RiTGe9ICdlbTw4vBJbk5jesG03RCEIK7BIbLV1bQPOJzEcPxwhXQMcV+gkYA==@lists.infradead.org
X-Gm-Message-State: APuU4Z9Ql7RTugweL+fyvaEh+bjNI44AXZd9R4AguXbHD2V6pPggaxZ7
	RXMcu3x3cuuhiF/749SZSjXcKQn4kiB6DLpqgrBVNSs2z02IkTEmHZTjjKXPTSBh2os=
X-Gm-Gg: AYBFou313AGh1lcIzGAzxkLmIt26t35GLrGxE83S9aT1qLxc4CSFzx9FnO1lK/Xh0qo
	G4Tod4xmPfIyDDEiKFjwZMIiknXC7ed4U/FbkKzgtk7Zx77Cj18K6gIQPJs9lsmIbDzob7y7Ret
	YHvYInFpGe7wDnpOcv7+58QH8lCmQlX++PscmMdhQgZY4ITB7T6UkBJzx/VsjmeaQlK7RwrNVWv
	RYvMpPKKmQBY77JkupM1JpIE0uBWrvrhiTG8oRGhxLXlBnrSvAtgye82bECtC3f668pH+zOmMZG
	ZW5mjkYhIjW5GoOtxhAPyjYgDMLHFS4QBYNxs/XVgA1SSKBcshaJeEn0Cou06NOS0gcfUAk3Uhk
	ESHZTnY7HFOt86RpQqavn15TWFAlRHo5KZC4DDj2yBJe8Zde85YxQ9nvgHFmlR/5WOhI8Naf/hn
	KLkQYROf5THcBKJSlyb1U80d+LGFx2XD3VDeuUVmDEFT0XHmL+V045aRe7Py+rA9c5ndn+AxCC1
	umO15PPpliAixJ/FO0xxAWmX1rBByXx4TBkF5CdcFprIPAJL48sAuWteH0yDCZbnlPvyoBZ0+Hu
	chuHcJfjQ2Zc50PGk+KpAKYNVBIPEV+r0ex8emkPf7UnSEak/JNdCNb3JvX7ya0oBww=
X-Received: by 2002:a05:6102:644c:b0:7c4:a0e4:1a79 with SMTP id ada2fe7eead31-7d64d76b2bamr62999137.19.1794510618947;
        Thu, 12 Nov 2026 11:10:18 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c3fd27fsm212440137.4.2026.11.12.11.10.18
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:10:18 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc81984fceso32289137.0
        for <kexec@lists.infradead.org>; Thu, 12 Nov 2026 11:10:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGdQTaFRwVYHQXOh+GAWhmev4dMpxTiDeGmzg6t4Z7naXNN7mklqGTWyILTvXDdV4GrJg+vqA==@lists.infradead.org
X-Received: by 2002:a05:6102:5ccb:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d64db29605mr42432137.36.1794510618289; Thu, 12 Nov 2026
 11:10:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:10:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
X-Gm-Features: AclHuK-k7G9fpVKu6BhCbcWfXavvnldoQZhCl9e2eioRf49lg5T7xpzAfc2z5gM
Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_111020_608803_39878E08 
X-CRM114-Status: GOOD (  19.44  )
X-Spam-Score: -1.6 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 17:39, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without checking
> whether the mapping worked. If it didn't, the copy reads from an offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

