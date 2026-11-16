Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDEA606A31C
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bI2SDjyE;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gNK/4zmR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=; b=bI2SDjyEmDGy6dyf22zPx8oepQ
	BW86BJS1okMq/D7dtCExw9nNdCbRkkXyrzef56AI7WG0cJ8YnPOmbQKXz4pkmoYWHjJV3es8nOg2s
	et0JIVw6LLeOiGFQt2l6avsXb8XmH+UPFyJ3fpWvkgxS2Bxnl4JPjmxFFAuwQZssNNXZGWpw4ifv/
	46k1+l92GfoTWwMtFYCdpYLGikldxrnFJUt8H8Xfe1LmbtqICquEkr6MZxZO++nBgO+Yp7OYTHjr8
	fTUkU8QLWNLOx6iq/5cnXV/bZn9fvOT0GX9BHAzifnm1j46m9jgG9DmKS0ry9b67unBSGhafeaB2r
	wQNynr0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrc6-00000001Uve-2HL7;
	Mon, 16 Nov 2026 07:58:54 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrc2-00000001Usz-38r1
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 07:58:52 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso16838855e9.1
        for <kexec@lists.infradead.org>; Sun, 15 Nov 2026 23:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815928; x=1795420728; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=gNK/4zmRT2q1aK0LSns8/fdKbUg4n807+pACXJH+HhISRyHkaSCuZx9i9aoPTfhxbd
         2Ta4idS2JZt5odxHqjSpYqBobsAA36WFID8U6CXQzNAEGoNotdF1Hf5POxKIsEQs+g7o
         O3evmDEPgNGGXXS34e9qNwOhwtjrW1j3/jZXEgXjUXq6hIBnYwtm+2NJjK3wgQZig6bz
         hTBWFFxH2TP6LXATPoEvT8T6difSsQtNeoKSnofhQKQIfSFqWxgu5TZKKra/+aKFSnjq
         QSEcrn/UX0C6ZTzZ8DJ08GJ5AwM6TPexAvfbcKroQxaVYWDJTROcQXmm4iJ3M8OnaTPU
         DblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815928; x=1795420728;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=W4/G8pHArCFAQANcfIvVUAthcjT8ZU5t0xdBsAKQetzTxir2UstNBKLh2L3sOIxHdt
         0KYXoBetNgL6kbmsdo/5rQkCuCB7hG0oa5sUXRFJ6qP1JRhXHIPz3R6sW0oDl55cIdUe
         UQJa3g5baqZQMEvFIjo1QypR6oBCaW8Ilsf9IxjdtoHXaIsxGmIA429njJSxYqpfWjyp
         hR85MscBEsw5HGygr1OJdO1I7uE2WtA4kh5WbqrC24ZzRbIdjvJNTnq0NI/IECEiZghx
         fiMoXjJHSGjMRE0JQuylf1UgeArZzUQIkUDdHq1MYcX5e69O/btCEDPjdDAvYJ38tO1U
         GVSQ==
X-Forwarded-Encrypted: i=1; AL+hErFLhCWNpUmo2KykZ7n4CIRQuAwVNfZcpZm2sv8E6ysf0RWMONyHPMk7BfilAcNmUXYLlJNtog==@lists.infradead.org
X-Gm-Message-State: APuU4Z8wHU87UF2brhUGWY/hNa7oKzkr6aXxw8FR9ufKEjYYGisLhdEJ
	dGYndGkgf5DGH5aSMEEil8I0sWaA+Zq3Xo7IuHEvXtp8JRtqOUPXGbkw4ikS/Z/e274S
X-Gm-Gg: AYBFou3Yq4qFIlyzZJ8wctGXG/KmdWe4sl+sS4ukTOYiyh8pPLxs2Lvn3EF5DNZHm96
	iO7Q3wvDMMl469ncntJkpHH480RLzDZU3yz0v8OBR4QKX2fUL21FzHRIAMipeRHBL6AUOep5S0K
	UsmciySn7EfjtlYQmte/F7LM6DKykQQrF2baJ1aZ92OVgL0VfuboakIvlEpmCVgZ50aHF6MlDaM
	6KCjyfWU7PXL+fZIp3CwgHF00AlD4gruYAGd/uL8lnoY8nfKp5sh+5EY/sijdtqV4+xLomvAIjr
	IFep1kM+eYyWU9STGiBsGj/fy7F15ABvtWJ0Rk39ntRYJ8QJ+f2ptdh5x5fid5pj1vg2XPaug7N
	qAMJr994x6Bd9rcbRrvaw5/ywNuX3iHwMbF3nONFoTLem2cLdv32Rq+lprzvZrTtsz27jTm8e44
	gDXSANPgYxgDduQMtBDEYOVnN4P1BHmFTz9Rox7IOGdTc2q2e274+RHb9Ouf5+GWBjq/lJvwv4B
	l9SyKUvYzykuf0z2TYv6xAFhAWGNh0a8qERvOFia9GZr6EpOakubQ+ylUmQQBxznwMB9PAygLBt
	nChl1Omo3ifpE2QpcpRdKmvMlpYcVzqg+xiQ99IwYn0v3/Cbmh131yxylKJtcRo=
X-Received: by 2002:a05:600c:3b07:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb5de1f216mr172834365e9.1.1794815928232;
        Sun, 15 Nov 2026 23:58:48 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e252f7fsm375768305e9.2.2026.11.15.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:47 -0800 (PST)
Message-ID: <aa32167cd3865049bfe0281b8b651c47f5e1c05d.camel@amutable.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in
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
Date: Mon, 16 Nov 2026 08:58:46 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_235850_801856_654C333D 
X-CRM114-Status: GOOD (  13.41  )
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
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns
> that into -EFAULT like any other short copy.
>=20
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/sh/kernel/crash_dump.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 19ce6a950aaca..85c0e58f1a59f 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -20,6 +20,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> =C2=A0	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0

