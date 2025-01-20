Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4537C02181
	for <kexec@archiver.kernel.org>; Mon, 20 Jan 2025 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDjp/3qZSP0yaVZ7+rsBSDc0lEeMc58n2sy+4YwlrQs=; b=c+rzO1GAwGYvSeOUdlP6/bNugD
	bvJp87qUey1N2d6iXxLAkGmc+xfRiXdk/av3qf1TCpqIzrLkXQWg2CyV8dppHmBBVREuI0o0mtNb4
	blQhGvMaSx/7yq/S4sgF8vvDXetqNOem+lHBaN4F2TkvJwsWbJSuI+pRNMc5uaV5NTE3pmSvHYF7n
	EFmYb6dGlnG/gg0PCKCLZzFZ69D3hXJnub+sRdD18sny+I4SKjh5VCEUaUqHF8LCufa70O2pQNIKG
	1KAxxfaKD7bSYaGZTrxLgWuH9015sG7zoPIoUDaFBioGMzE895Odf6t2mScvUKJGZTojjbv3qKJn5
	8oaWh0WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZp58-00000005LWy-1xbr;
	Mon, 20 Jan 2025 10:32:34 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZp56-00000005LWY-3wgf
	for kexec@lists.infradead.org;
	Mon, 20 Jan 2025 10:32:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7529EA40DD4
	for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 10:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF300C4AF09
	for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737369151;
	bh=GDjp/3qZSP0yaVZ7+rsBSDc0lEeMc58n2sy+4YwlrQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iiwhTKLFlGUtKynzWQkLAjTigZC4aTPbgKZfoBP3T5+z1WApZABr+cWr9fAgWuHYu
	 HgNWr8mOGEwlGLJV1fFnzv+aUa43kas/Q4SmuUO3mWSotyZsSsCYFWFZxtRyxZ2fMm
	 iWJ9F9Spobf4xhHlhE5QhdaAnvPf2opseThrBYhlsCnVFPoQjLwQGE8wBoRZ1fw0qC
	 +RtZ9L+UXJBrPned2oP8hr51lauM9PxKE5zTwnrqZF9RN3KaHEafmTozMZlJrOXsbG
	 uvrIMofxnjY6VjEm1QchD0NUlzaCqY2cPSRgRq70mMLW9goaBxNsMsz2ykbrNQNYI7
	 TQ8ncQqL9Fwbg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401c68b89eso4095184e87.0
        for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 02:32:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWihxQ3T8lzjrg2XAGPyvQAUJl3+165ZMvCF2AC8U59WHDufKtZpEtpiO3L59+0ug11FaHb2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/98t2+HqhxkZ/9E1IloR2WypQyTzZ1e4W6LTzdtjx0wvlf7Wl
	V320gyP8BjCkEbw5mHX35J549wyo60/IYP5xBJ7Scgh9HgCGF6i39TusUikuXriYboig2yc7h/H
	B8t0l6zfNALwgThZkK6xsjrknB8o=
X-Google-Smtp-Source: AGHT+IHx9QEuYpomCSuy/AQ5ViuNCow0gDRQDlzuXyvnGAsOyS0+452OrfOi+IpmB8bQ9WARQeP3HuK6mgnW2rxwtkI=
X-Received: by 2002:a05:6512:1045:b0:542:8a7c:509f with SMTP id
 2adb3069b0e04-542abf503d2mr6892244e87.2.1737369150134; Mon, 20 Jan 2025
 02:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com> <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com> <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com> <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
In-Reply-To: <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 20 Jan 2025 11:32:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
X-Gm-Features: AbW1kvbSiocF5LdXALV9g5C9SpoIRpL6JzzoTt3_wpE-me8DVnzqOJgG_TGGx4s
Message-ID: <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	leitao@debian.org, gourry@gourry.net, kernel-team@meta.com, 
	Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_023233_092388_0A35298B 
X-CRM114-Status: GOOD (  11.59  )
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

On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
...
> Hi Ard,
>
> Just wanted to check how should we proceed forward? Should we try and fix the warning
> and corruption during kexec as done in this series or not initialize memory attributes
> table at all in kexec boot? I would prefer fixing the issues as in this series.
>

I would prefer kexec boot on x86 to disregard the memory attributes
table entirely.

