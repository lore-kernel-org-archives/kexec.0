Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0798606A32E
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FzswQ47g;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NW+CiO38
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ABFV9qqW5v9B/veTK1qFSxVFzw8UX9r8phfo5f88bHM=; b=FzswQ47gEAUin2
	RGQELCkpRM1CT5DM7FNLZXVrht3yTNSKXfpMjR/+UhIHRANinu8V1d5uZdWZq9gNrxczB3OfE2Vwe
	K0fP/wLrfS6lFBnk2C6SbTSFyA8+zBi6p3iulae2Olwb4uuVRlHWSrVxZ1yeI3HznKL7fJ2LLlkkO
	u5r4sUulQXEvpWP5wD9H3e8Yy20njVoH7hi0n7mg4Rt5VezCiBa9aVB5jmOiHOJUuOw276lYVPRXM
	T38I7WihzRItZPaY4huPD74smmnDcwIEV++PL2c8Ww5Fc4/iLjROyUgWxTgMAoB1eilGewK35Gi01
	2CHgkndg3z66HDSSZejg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPL2C-0000000CgkG-0U2c;
	Fri, 06 Nov 2026 14:35:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPL29-0000000Cgjb-3sMx
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 14:35:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 35B0D608FA
	for <kexec@lists.infradead.org>; Fri,  6 Nov 2026 14:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44081F008A7
	for <kexec@lists.infradead.org>; Fri,  6 Nov 2026 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975712;
	bh=ABFV9qqW5v9B/veTK1qFSxVFzw8UX9r8phfo5f88bHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NW+CiO38XAipmRfvZb5pGzPtdB2zoSkBFY3QqVyfdPAFpM6fBH+ps3C/WRq7ZfzE2
	 o7WUwzmqQQ3PkE3gvMRfgOCP9XzXNGtg12V8S2fi5UZdZmB4q3mp8G+xTIwOtPAtXN
	 3uNZAFMQ5hm//mnLWi8wTsZWz9GGPkHPOFoVPJnbpwCohuzkA8Xk3qgp15B/Qd4kC/
	 XXTNMv1YKeN4P6VHCjS/J2rMGpKFjXdtYP8tYgnawdShP5GHiBIrTMXGFyBBhzj8Df
	 6SsOM4/1dFVK9LCCm2l2qkHcdnKYWKMJ3f1ACFpTO2jqaReJZQlahdWNR0bptLYcEb
	 BhkFz9AHmxvVw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so924845a12.1
        for <kexec@lists.infradead.org>; Fri, 06 Nov 2026 06:35:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGTsZZfyPXk0k8wdQcas+ZYN6Ys+hUK7Uh/qa5mgtk3zaX43l8vzAhAFzkphiwSpYjoO1b/Mw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+tEpc5ZfgCVJUvS8fPLWvvephzsbtUPaLIwVeSnXq8fcq2Dvfz
	YLxDjXAEwjxCwKNVzvEeMvyo8U4mI5TiMX8UCOhgWoUGoT/MHKYSF2QbM4gQx5ertMI2z+fgDpX
	BeArU1wTzNuu14rXjJKNgY5c2SNR/tkI=
X-Received: by 2002:a05:6402:1e94:b0:6b6:edd7:7928 with SMTP id
 4fb4d7f45d1cf-6b6edd7899emr802991a12.26.1793975711577; Fri, 06 Nov 2026
 06:35:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029172956.20791-1-dongtai.guo@linux.dev> <20261029172956.20791-6-dongtai.guo@linux.dev>
 <aux9Hm0QFJLUDPWv@kernel.org> <CAAhV-H7Dsnz03iXChzE6nYM2cs+D6fdDFiWrDxX5jM13kYL6HA@mail.gmail.com>
 <auypq8_7T-vml5_B@kernel.org>
In-Reply-To: <auypq8_7T-vml5_B@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 6 Nov 2026 22:35:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6aO_QNEzV-r6+FbNa=9EUQgv1vH0ET-ETXAH5x6oQGjA@mail.gmail.com>
X-Gm-Features: AclHuK9KCIrf61pzsewLNfcg32ftrSETM4BdWXL6OTYNNDPn4F3U0UamXyiZ-QM
Message-ID: <CAAhV-H6aO_QNEzV-r6+FbNa=9EUQgv1vH0ET-ETXAH5x6oQGjA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] LoongArch: Allow memblock arrays to resize
To: Mike Rapoport <rppt@kernel.org>
Cc: George Guo <dongtai.guo@linux.dev>, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ardb@kernel.org, shuah@kernel.org, ilias.apalodimas@linaro.org, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, 
	guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, 
	liukexin@kylinos.cn, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 12:07=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Nov 05, 2026 at 11:07:01PM +0800, Huacai Chen wrote:
> > Hi, Mike,
> >
> > On Thu, Nov 5, 2026 at 8:57=E2=80=AFPM Mike Rapoport <rppt@kernel.org> =
wrote:
> > >
> > > On Fri, Oct 30, 2026 at 02:29:52AM +0900, George Guo wrote:
> > > > From: George Guo <guodongtai@kylinos.cn>
> > > >
> > > > LoongArch never calls memblock_allow_resize(), so the reserved regi=
on
> > > > array cannot grow beyond INIT_MEMBLOCK_RESERVED_REGIONS entries
> > > > (INIT_MEMBLOCK_REGIONS + NR_CPUS).
> > >
> > > This might be something to fix independent of KHO.
> > >
> > > Huacai,
> > >
> > > What's the reason LoongArch never enables memblock resizing and why i=
t
> > > defines INIT_MEMBLOCK_RESERVED_REGIONS to include NR_CPUS?
> > At first we didn't define INIT_MEMBLOCK_RESERVED_REGIONS, then we got
> > boot failures on a 128-cores machine, so define it, and the value is
> > similar to arm64.
>
> AFAIR, arm64 had to reserve some per cpu data before they could enable
> memblock resizing, so they had to make it static.
LoongArch is similar, so below 64-cores machine has no problem.

>
> > The reason LoongArch never enables memblock resizing is because the mm
> > code is derived from MIPS, and MIPS never enables it.
>
> If that's the only reason, you might want to revisit that :)
Yes, it seems we need memblock_allow_resize(), but maybe it is better
to bring back paging_init()? Most other archs call
memblock_allow_resize() in paging_init().

Huacai

>
> > Huacai
> >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.

