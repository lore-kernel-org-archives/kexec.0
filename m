Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E376606A331
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gwn882Zz;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IgmDLLBf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=; b=gwn882ZzNAY12OLCL9+JlBvLZq
	LgP50xkJba1DDGrfCnff0xLspK9n4dCvipGeIr1x6btLVwOkY84jbikQ6MHfiuqF/vOYyWZAv+0CC
	T4lEwfYUxCqXh4P2OsWF/B1qjfa8t0bIbSPFlwEUqYIb76v/tka8Wpz1uN8RuMRoBEuLbGt3RKCsY
	UXyzi4wjnTdivq9vJJWngrm1eAmMg8aHAnkS8utSjvqoST6W6TBH+xGz6XqvjCK5D0zGlkCoBQcNO
	/v+pS095ws/pdbyXlzgMkLo2p4QHZ8YxNtuFexyRtiSh9MMY1TIPuquLKKWbS/VCLp25Nz27vPcbw
	U1vBzlKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrbl-00000001UnF-46aX;
	Mon, 16 Nov 2026 07:58:34 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrbj-00000001Ulh-1X5S
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 07:58:32 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-49412eb1474so1449599f8f.3
        for <kexec@lists.infradead.org>; Sun, 15 Nov 2026 23:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815909; x=1795420709; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=IgmDLLBfrFdsaPqlNCX700adF3vdT83kDFQXlYadlcFAcD0K8waDricPSM1R4eSnPC
         CxHx0IRQhscMGUrs/KpqDz76cFig4JXRRWfYYotqbrdlPabYszlEfv+3RE7YRSbPT0CN
         t9wN+7zZpImEcP1WyPmaxxH29ZugGGHXTqQmgalR0vZHSfgxD01NrqcL/47Y2QLx25YM
         LNs7+9Wb7OeB7JFJPrgYaotNq+2lVC2XJtpazyqoW13fvwlGoswKE+pJSu8TiBhAnQmP
         WrW5tZ7gh3dPobwq6zXvzTUSXMJ1IYabLMWu7dpx5hxehBLFhT61bJVZBqahhcm+342n
         WP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815909; x=1795420709;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=Oxv6L0ecHlGB3PeDT3Ti3fefG6xwGna6C9kQYOyTlclsEk/Ke17HZOigvqnzsOZZY6
         5mcUQCekurri/pQnThSG4qGNa+IoXvnGhXKuWfUrObYs/VEIez6YOp+Tthl6tCqvmLBo
         AGTB/k//chi8DrQ0pB2YM6rlIVwI1xgiGPULffC3SqJ2XYiQbgrJ/UU60mL0T9F9BT+f
         DuBQ9ikNNnRU4w5ygKkU1V332yAd+wo3YTFpfwd0/wbGNiFd8ehQV1quaytevXq0Dofg
         WsEqCKG777x1mxiAcybBlFJPayzY9f3L86MzaZGkPRrGlhjI952LgkuicsrfUA/c9VQy
         H1XQ==
X-Forwarded-Encrypted: i=1; AL+hErE0olWuwJe+u+fI4F8chGZ2ePvSMv+83U8vLHzJzglMRjxSFjTtn01gKi33mCUdTM5ipbrwEg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+lDVdMQivDL5hHaPjtEUG9ezjK1KIlqu+Vkwr4vqko9n3Yg19/
	QWK/vGg/CpFg7QG9gf4OCFsjYp/rZX9jdZkZugGuTH7vUoI9FtrdNcA2ohnEMsYkP78x
X-Gm-Gg: AYBFou2ZgsKmtj7o3yk8NZegEjX6NzSwg3i+KXCJNUFfg6a5bYTxUboc8L5Xry8IriC
	XLahUoEAwSxSV3OPykfeKUUkQaz8RtLSjxi99bHUEdevyZA1TBUHJ8b6PSMhqlOIxrqBNfYjig0
	JrwG+zrll9Z0Y3TgS0nhcUkrcBvOTfC1MU7ST+b6AdjcNJXdB3mccCeoIlv4NbHPS0iPN6M5kUs
	zTSXiZ3bNjV8D40QhW9YC6rrSSVfiJW1mOQUNuzdz9Xa2LDywdBq/1/xwRMny0dewHU+KLDEe60
	qv4M9FSn/Ef/EAgU9B4Jil19PI3pxvstK9zKfHSQPe9Q2H7OfW+oUb3rYwFxOH6rcIeRplS6iWd
	wH4G31jehJfWBTKbSy0fMF98px0/mQhjTDzO0S5R1L0v2s7hihkyW3U3BSKsSyh4fC/AN4nVDuo
	a1djDP1WOiUcZoBeARb5wEeTRy7pcANmAb0VfBNa/cIDcTKy0ej5eh8AiMH+El7OKt3v4d8im0t
	0fSLOsBqIZfXuTatCF05OWCT8iHVN3piNI4tsgmNxeejisBNxB1yV693nKUSGxlsCK/YI8P9gz6
	sWeFFjB5T8LDjAn8f2hSon/V1IW3aKEFAgSl8keuplbZWf9Axvy1q2tv+smUB0w=
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20084703f8f.45.1794815908942;
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm21124748f8f.28.2026.11.15.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Message-ID: <19b4c35c016a91302bf6bc3380bfcd3d21dc50c0.camel@amutable.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 08:58:26 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_235831_473967_516EC76E 
X-CRM114-Status: GOOD (  15.00  )
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without
> checking
> whether the mapping worked. If it didn't, the copy reads from an
> offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent
> copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/powerpc/kernel/crash_dump.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/crash_dump.c
> b/arch/powerpc/kernel/crash_dump.c
> index 103b6605dd68f..1543917bd3e1d 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	} else {
> =C2=A0		vaddr =3D ioremap_cache(paddr, PAGE_SIZE);
> +		if (!vaddr)
> +			return -ENOMEM;
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0		iounmap(vaddr);
> =C2=A0	}

