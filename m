Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6C606A32F
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4jcOf+TH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EO2BJ/6+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6LZ+1+Vvz+jfm5vRHAeunaTxWBAAAXS8a4MaB1JvOmw=; b=4jcOf+THwEoJXN
	Gp8qk5Z+hZt8wRJVCeURq2yWYnAqJxGcRIzCW+RgCeAwrCLetGURMYzhA3DVcZNHiEfipyIKuQ5iC
	4I11z/iHHMKeH1hPuEeTaUflrj0WqjAaqe+Ynwj0Kucfd75lnxh+DiIlYh1d7frJ+/8xaSqkjWLyo
	OicF0Gp7uLrHuxUu5rfm2IWtPlZsrHfeTwRpT/Y6RSw939jmHaT6aqZudxVwrZ4Q044EdJG6mxtel
	yPcvTfFT6mOkgaqaqciYhSBfLm48NZG5Mc8xHSvXtEVHu0Chu1xyLB7b3PJr3hgAVMfpxLH7XDZjF
	f1XiwucYsDnRPAirl/EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOz3c-00000009Meg-1Yic;
	Thu, 05 Nov 2026 15:07:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOz3a-00000009MeT-2e9S
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 15:07:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 237104401B
	for <kexec@lists.infradead.org>; Thu,  5 Nov 2026 15:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF6E1F00919
	for <kexec@lists.infradead.org>; Thu,  5 Nov 2026 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891234;
	bh=6LZ+1+Vvz+jfm5vRHAeunaTxWBAAAXS8a4MaB1JvOmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EO2BJ/6+M7a0iVK+i0E4JAgIf0guklGRku6bWT0XQ+WcRveIX2swjjcEIo80eGySO
	 Zxwzw8nUep52BHRGVFDCqzj8MkwArw/D/cG+4k9VHdAUSkeTKyuVvrWfqL9HngrE+b
	 fctXZ9EOEIb2b2BwXoMxVj1b3kwiSyO3Te/F20K90NaAQvczD7ROuj9T2Wh7m9zwx4
	 qoffAGSr4/I8IVNzmJCJDgjFqm14vbHAlpFE4Ddpq+2dosEMN65pDabHtkLRweRqSF
	 FKXUAGogl5giMaahe7YMTTTl4OLkvYcSN4TZEU9UC4zNJKQ6bMkXRDwPZkGTMDpUh6
	 Yi0+lZbT1/B/w==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso196413a12.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 07:07:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxfxttFMTZfjgPc+e5wQ8xOKL6jj3hXu/AUCY4gudFtUVUYlrFKouTrzn/ppK8WjpWbGktd2g==@lists.infradead.org
X-Gm-Message-State: APuU4Z9sXKeK22wkXyrW0bdPD7Nd7hJbpugnltieWR/BPnRaHxsFl1LT
	abl23bFrSsCkApCs2rJwx9YU6214CzivZOHK6UksrydYuRxXAUrLkWdNPtqr4ma/RIGExUvOlR8
	b6Qj96O8OPH0n1ITIRssCueg6nXD162E=
X-Received: by 2002:a05:6402:27cb:b0:6b5:685a:aa29 with SMTP id
 4fb4d7f45d1cf-6b5685aabaemr3342720a12.30.1793891232594; Thu, 05 Nov 2026
 07:07:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029172956.20791-1-dongtai.guo@linux.dev> <20261029172956.20791-6-dongtai.guo@linux.dev>
 <aux9Hm0QFJLUDPWv@kernel.org>
In-Reply-To: <aux9Hm0QFJLUDPWv@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 5 Nov 2026 23:07:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Dsnz03iXChzE6nYM2cs+D6fdDFiWrDxX5jM13kYL6HA@mail.gmail.com>
X-Gm-Features: AclHuK-7ZT562FqR8Q8-CsL50vorYou5ohB9VqtWfcaV8ssgwEH9NV-xDdP2-NM
Message-ID: <CAAhV-H7Dsnz03iXChzE6nYM2cs+D6fdDFiWrDxX5jM13kYL6HA@mail.gmail.com>
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

Hi, Mike,

On Thu, Nov 5, 2026 at 8:57=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Fri, Oct 30, 2026 at 02:29:52AM +0900, George Guo wrote:
> > From: George Guo <guodongtai@kylinos.cn>
> >
> > LoongArch never calls memblock_allow_resize(), so the reserved region
> > array cannot grow beyond INIT_MEMBLOCK_RESERVED_REGIONS entries
> > (INIT_MEMBLOCK_REGIONS + NR_CPUS).
>
> This might be something to fix independent of KHO.
>
> Huacai,
>
> What's the reason LoongArch never enables memblock resizing and why it
> defines INIT_MEMBLOCK_RESERVED_REGIONS to include NR_CPUS?
At first we didn't define INIT_MEMBLOCK_RESERVED_REGIONS, then we got
boot failures on a 128-cores machine, so define it, and the value is
similar to arm64.

The reason LoongArch never enables memblock resizing is because the mm
code is derived from MIPS, and MIPS never enables it.

Huacai

>
> --
> Sincerely yours,
> Mike.

