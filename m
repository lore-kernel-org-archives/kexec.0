Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B3606A324
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ryUYzFJU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Klcqtq67J8++CxJ47wWJ4KmRtmeIU5oN8tRyALYYbAY=; b=ryUYzFJUm8RSiZsLwQvSFWXZ0Z
	bgIHrJu7Z4r87WnpaDqwPVMRv6CqRO9m4VhBb2GBuBjhPr8GWEA9U3Voq2j5u1kONqQNbyar5B1Q3
	fzxausUbp/PC2dh41yNVbQ8WLU5+1TvhJFgZ18T3otOB18/lb7hjyGYjCYb7wP+PJW3/0hF+HVGXe
	KJhS0xuQP3iCFNfk1DwcOOhzG5b8vl3kaO4YWsUfx1iL0jxNMEtdHof4uxl2AtVOTPRyCst9peIAl
	Rd5qlPYHBNkVV7Jf05RtAN9BxuDxdef0F7Zf8D99xGtgytiIQlMKwa/oHR6s/rZs0yoVxz9nINaYN
	IdpyKEfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTway-0000000B50N-0LsG;
	Thu, 19 Nov 2026 07:30:12 +0000
Received: from mail-vs1-f50.google.com ([209.85.217.50])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTwas-0000000B4yy-1Kpq
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 07:30:09 +0000
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc603a168fso697915137.3
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 23:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795073402; x=1795678202;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Klcqtq67J8++CxJ47wWJ4KmRtmeIU5oN8tRyALYYbAY=;
        b=Xss+5ezuSVzcAJUUOx4+7O96mY7mLG/4PTbb3ZtuvEgG8hpbvGB3TiEyweKPvETQAF
         6evCqp+ZK+SUzawPHmCr37UCVA6UoyLovxeRDN07A+zwEEBuIEHTZ8VkqbIGb8429iW9
         UIgXB9RlSuxv33fiMnGeTLYTMqcLOd6Qq92h/9ATIIGIoz/1WsS5tPz0zVfmFXWr5OFp
         sEuBnT5FKFwSAgdzgwM/uNenK7xI6Hf9Zw8Hv7ESaugApUtee67Gw1STSajb1IsRC7NF
         hjJBlY/QHR0+lZooFwVswLrcsUnprnYwBeOFB5Tmw/TWEbJVJH20HIHgqo4ADvbKn1Qc
         mb0g==
X-Forwarded-Encrypted: i=1; AL+hErEIhf1U92u5JkSawnZIV6UwKkr59y5FK1DWc6IthV+VH3jSaVWzuEQaS5jYaYkHutgUb1KAHw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9jI8IGrRINCpkmu0IqLzk/lqcmLWO0XklI0G6ZpbxJw3lsTizt
	XWpDKJb3eucQsHDgG7tq41Ufv1mErOkdXFsSKjYLV1K1+PgcUBwbeaGMZEq86bK1
X-Gm-Gg: AYBFou0PmX3NwaqgtIojCAXLgGxzI8faCZaRN3Buto1BNT39AjfnYSncL2mN6dW8gPN
	7sBJ97iDLJpeCWpHFxK3o9MUzu7h86m5a5YZehV1tOzY6V5pQ5YE8iXTJdMzW9/u4Cwsu9aPkN2
	eBs1vew8pM3bETeq6WNHxBipxHq00w647nZSntCoRoiu3uXx14na3JM7okL9OynbXQgyyrB0WdF
	Os8GrlGkNdulznOQSGvfM9fYoHdmDWlbCi8uGCZCWbgcYUWSkkX3l3kbBYW8qOd6VFDYslDsCs6
	bUTQmSAqVdKo4M6GT/+Is7JtfRme9eGfmirmcx6zBL9YJxGTPxvqwB/lFy5slHDI7G9T9VHgwvY
	qHIhCWuKw1RALi/dpaeCD/FqpzQWQ8fAmUyX8T72DAwH+nRY1XCP1XTdjx0B0Fo5LJBYvlYTVjC
	+ujelnYiignKiWd+Hsh1c8ae0Sae1GpIawDDXElmhQzAgSdn/CneFkrxVjU2kO92MClvTJ9OIxK
	Q+zk9praICWSGd2d6IClH2dypNjv1qFsNKEf0/+ENJlLwwvx3VUH+EAZtfXCCh7j0nyGY1wRVyL
	mxyJCk1GphvBR+z0xQkn2vsKAavzdVn8+l8sWiBqBtmoDMtXkaxEzMvEI2lEi/+einX7HYEeIuT
	/YarqifFrJfEL
X-Received: by 2002:a05:6102:290a:b0:7c3:9b8d:5124 with SMTP id ada2fe7eead31-7d6ba3c20b4mr1649501137.18.1795073402091;
        Wed, 18 Nov 2026 23:30:02 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b8ae4778sm3608929137.0.2026.11.18.23.30.01
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 23:30:01 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98301b325c4so632285241.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 23:30:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFkN2LLlZ06I5unsg57MO/99KoJQUUOe/fcfz8LAGYihoV1PcvkKQqV1GhRJnaqenxgggMiyA==@lists.infradead.org
X-Received: by 2002:a05:6102:e0c:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d6ba35b7d8mr1806982137.13.1795073401089; Wed, 18 Nov 2026
 23:30:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org> <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Nov 2026 08:29:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2u9wDiqp+H-aDWSRcT8_VtDg1NS0gVmqYYm9rt2ZSrA@mail.gmail.com>
X-Gm-Features: Aa3M54rf5ygj8ORK3fy8Y6Bg5UcrfzvYekQ-eoJmIgxSYs0ZeBrecHV4-2jERSw
Message-ID: <CAMuHMdU2u9wDiqp+H-aDWSRcT8_VtDg1NS0gVmqYYm9rt2ZSrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Cong Wang <cwang@multikernel.io>, 
	Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_233006_552912_320FB192 
X-CRM114-Status: GOOD (  19.48  )
X-Spam-Score: -0.8 (/)
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

On Thu, 19 Nov 2026 at 07:17, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # sh

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

