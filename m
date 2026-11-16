Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F129606A31C
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iSEuK5ME;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZL9lQ+Ij
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=; b=iSEuK5MELxVfF7XIqw0VnOmllv
	q5fLjwcQLPBENiRghmOcbhrfiyVRuguxqfdAgdK7DfLeQL8iROLhZ/W0PQ2pwiP150ZGl/GBGte3s
	jWXy8plDL7JJiLoJPOVc305MIuoPNX/E8DThw4sogiFR+Bc/dufy4ulQbfTTyJ6YLcT1HXhE2zUip
	8rnnz+V2fCfaMQMb4gEOq27mfw0oHg1bWLmAN4rA7Ykw6S7l1rkz+RZsd1MNRVC7xDVJ1YCHAHuHb
	Y0SDIHaGkGAVLw3qc3tJv9uoS8Hj8GmB77uSQES5q0Q666MK45zoKQiW3ud3aDr/RTCMLLi0+rDqn
	Gl9JIh+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSres-00000001VqG-3BbO;
	Mon, 16 Nov 2026 08:01:46 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrep-00000001VnZ-3WBY
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 08:01:45 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-c50e26763a4so55822166b.1
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 00:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794816100; x=1795420900; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
        b=ZL9lQ+Ij/OHBOtOQ/43LNApMmnlCsRCqo1I9FM9QB7yoe9Y0Jc2twTqTJlSTAhGuVl
         S2uSvCnydGkcqC1T64WuEI8t1zrzHEO8T7pa76UM1ezXZszIUU5yqsOj6AV9mLvZOEMV
         lThdg+xxom4pfNA5pyONynvNSyW/4WTBi0vTV/X4W+J3LheAoQk6+Gt1eYB0VXB+mzsT
         pFkCDXsh+DqSluCX3Sd7c+b/pCRIyc4DTdu4B3H3Hfy7iEkAnbJm30SyYuuKtUweXsLr
         hKBsTcChRaAidYZ8gLc8Y186xazoi6UwZMo8+SWe7CVFOOHu4FPmQJTPydT9Ce4N9P0R
         qBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816100; x=1795420900;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
        b=IiZON80OJlvEsedO+G+QJteOem1SQDyUs5pdn+Y9KR4qrYApo2FQeeGmVW771AR7kM
         T1vH67MOq2aHWpSlE1hVrXF+lWA+hEQGgsmySgFM+vYmwPCZ7tb95qTZMLT2XscWlrJN
         KxsNgzLnTZ1Y0v4yyOnl5ceaNc+DVD9W6owk4D8fhikburMb26LRhWYUlpHtymQZgYWN
         v1mYLCzq+4F2N1ohqE6HnWacQOheZnV6Mrge/uIa5vHdvCsMO2Auijuj704dmohbPYmQ
         Il1cxsIPoQ5DG4X6fR/EfqNBzJ6DZLqLENDG9QL4fA9NCjiLuGB46+gDjquZbNUA2u76
         /kpw==
X-Forwarded-Encrypted: i=1; AL+hErHseFtaqgMC2CBEEyTztMpjXCGICRKnAyoElmR8ncFRHtdMMkomNeV7dqss4PsrMS/k+0BxoA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/s71zW2/RoAs6bwhC6hJJcKEQfGxo6wNLiJ1H7jfar54mv5Zjx
	puft8BTHr4EASnq1wgFMj3t9TwaWPesaTpJ/mBgm6SdXTjNZ9SPJ+pytp38vY3HO1vKK
X-Gm-Gg: AYBFou1b01I+wETiJ5ALrbtRDMGBiJDjGkbghtB46jPOc+xUb1M8PrAXjcYRtufhn4m
	Sux+JGnxDTvnPro4QzrS7HzGPgfbdQ3bSTwct5tkwCIrjlE5mg4DzsEyznAVFhLLoENPkYZAihW
	uVZlZHHV1Ci2VPoWYQhLNwz37zlo1oKOrg6e6trHNxP0OkxAH7Tb7R/YvjHKnuq5XJxSQe6G1ef
	vxn2Om2MwHospjsZEKrzPmfIVFUPAqhejlbFeMf4PXhsqvD0SN2XcBqx+o5kuUKa09HC8XSlPfT
	KHnBcTiMJWVsjSEP8xU/ivPLOLqAxlT6gyOXdCNxZhl8R5DXlGDQmWl4KZszgPsM+Ps4z0BXK3Z
	vLT4gdceWYXU1xSFG8l6LWM5Gc7d7XhHYktC5cj1hiNbJbLmIcKqw8/FqAM1XmUTz34+Mtx4utD
	Ca4u+q1uROVlE4hmktIBg2IG4j1XrpzUkALc91ygsXhwti0nYlhjFCawLq7HK/G+hc5Z5mA08md
	n6iL2ldnXxd7KpBwpObvorZotQ72EOHtSxs9XO3i46Wm5udVB2jSMicoNOiJiHbFyf5pTZOpxHr
	bEN/c/oAcGjqaGpANY+sXtaSIY3q4ouulAMF6kHhRZDFyO1QjBJ+trppEbpiem8=
X-Received: by 2002:a17:907:1c90:b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c50963bc4f0mr777600066b.48.1794816099924;
        Mon, 16 Nov 2026 00:01:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm385795866b.73.2026.11.16.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:01:39 -0800 (PST)
Message-ID: <dfdd6f4437cbf8f55458b908ec5347f3189bce80.camel@amutable.com>
Subject: Re: [PATCH RFC 4/4] crash_dump: use copy_oldmem_to_iter() everywhere
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Date: Mon, 16 Nov 2026 09:01:37 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_000143_913890_7F0386B3 
X-CRM114-Status: GOOD (  17.79  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> Make the remaining copy_oldmem_page() implementations copy the page
> of
> the crashed kernel with copy_oldmem_to_iter() like x86_64 and powerpc
> do. None of these architectures has a machine check safe copy today,
> so
> for them this is copy_to_iter() under another name. But the copy of a
> page of the old kernel is in one place now, and an architecture that
> gains ARCH_HAS_COPY_MC later gets the recovery without touching its
> crash dump code.
>=20
> s390 stays as it is. It copies the old kernel's memory through its
> real
> address mode window in memcpy_real_iter(), and an uncorrected storage
> error is fatal on s390 anyway (cf. s390_handle_damage()).
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/arm/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A0arch/arm64/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/loongarch/kernel/crash_dump.c | 2 +-
> =C2=A0arch/mips/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/riscv/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/sh/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0arch/x86/kernel/crash_dump_32.c=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A07 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/kernel/crash_dump.c
> b/arch/arm/kernel/crash_dump.c
> index 938bd932df9a0..0f2628872b00c 100644
> --- a/arch/arm/kernel/crash_dump.c
> +++ b/arch/arm/kernel/crash_dump.c
> @@ -28,7 +28,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	iounmap(vaddr);
> =C2=A0	return csize;
> diff --git a/arch/arm64/kernel/crash_dump.c
> b/arch/arm64/kernel/crash_dump.c
> index 670e4ce818223..c774b3aba107d 100644
> --- a/arch/arm64/kernel/crash_dump.c
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -24,7 +24,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0
> diff --git a/arch/loongarch/kernel/crash_dump.c
> b/arch/loongarch/kernel/crash_dump.c
> index e559307c10929..03a136b8be8da 100644
> --- a/arch/loongarch/kernel/crash_dump.c
> +++ b/arch/loongarch/kernel/crash_dump.c
> @@ -15,7 +15,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0
> diff --git a/arch/mips/kernel/crash_dump.c
> b/arch/mips/kernel/crash_dump.c
> index 6e50f49024094..078c0d1e8df46 100644
> --- a/arch/mips/kernel/crash_dump.c
> +++ b/arch/mips/kernel/crash_dump.c
> @@ -12,7 +12,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D kmap_local_pfn(pfn);
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	kunmap_local(vaddr);
> =C2=A0
> =C2=A0	return csize;
> diff --git a/arch/riscv/kernel/crash_dump.c
> b/arch/riscv/kernel/crash_dump.c
> index ea2158cee97b3..0820e3db12603 100644
> --- a/arch/riscv/kernel/crash_dump.c
> +++ b/arch/riscv/kernel/crash_dump.c
> @@ -21,7 +21,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0	return csize;
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 85c0e58f1a59f..2a5988b6e9d7a 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -23,7 +23,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0
> =C2=A0	return csize;
> diff --git a/arch/x86/kernel/crash_dump_32.c
> b/arch/x86/kernel/crash_dump_32.c
> index 5f4ae5476e193..cb202d4e1f703 100644
> --- a/arch/x86/kernel/crash_dump_32.c
> +++ b/arch/x86/kernel/crash_dump_32.c
> @@ -40,7 +40,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn, size_t csize,
> =C2=A0		return -EFAULT;
> =C2=A0
> =C2=A0	vaddr =3D kmap_local_pfn(pfn);
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	kunmap_local(vaddr);
> =C2=A0
> =C2=A0	return csize;

