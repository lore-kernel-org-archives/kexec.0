Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41401606A327
	for <kexec@archiver.kernel.org>; Sat, 14 Nov 2026 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UF7FOAMt;
	dkim=pass (2048-bit key) header.d=multikernel-io.20260707.gappssmtp.com header.i=@multikernel-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mCKXHy8A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ob3egBMDWREMyKIFGAgfTNtbB0svXcBxgsRZj9sWFXs=; b=UF7FOAMtghnCYs
	ajTzbOdtyNclDBRtxXPOhms8WV9p2D1qq38wqHSREeH7600+TDBWTkVGpvNFH2oo2xH3EQBmuSWqk
	O+hX/B0gbJwXd/s5gS46Vl4xE1nD5ILOZ6pruLI0TSyCstTA6BijSOHHaD0cGKNGT9nfogMbCN0rb
	AQzf7XqYHRqxmUYP3a7q3EkwvhalHP1CMMEtFviKkChh8MIahXJiYpEI/tmXHRBRyuqx8zsrOXCvz
	L5e4MzSkMBtsVCzzfAzGCuvvozbJpaBUyvqg2zxs56cvGRIZCKgaiQZMlt+jx7gfuYEaY1FhTwp4r
	KdHIIv2PcHOGgWN1Kzqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS62G-0000000FUGB-47wc;
	Sat, 14 Nov 2026 05:10:44 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS62E-0000000FUFK-1vXf
	for kexec@lists.infradead.org;
	Sat, 14 Nov 2026 05:10:44 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6b7ddb99db4so776949a12.0
        for <kexec@lists.infradead.org>; Fri, 13 Nov 2026 21:10:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794633039; cv=none;
        d=google.com; s=arc-20260327;
        b=AMeU1IBh/2EpKZKwJKNgsFBQfgKMixONwNo4QJOGi5yKXmtzyZYAOhsE46PUS6vjqJ
         vIpYAU8VXb73W7kWwfQKat2TRHkIufz8MtP29DESChBCq4DD11UQ+hsFtil5mi6R2YgM
         FH1O/vM0QQ7Z5vHvLa8u7Ygt9pqg2hLe4eNTpm86CpqVo+eASt0HJ4Xl2Pw3JNW/S0uS
         6R3fN7bWp9+TOLr7nZYpYqlUg+pzBsSEzD8h9tpcof4Fnhjq/zdEMV/5pKksIUDM+m28
         FiBjS3VBUPpX2mKLbqwyZAioGdTUbN2Pm4KuckurHv69ALxkX/pVnSsvurQIjIg1OARs
         zFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ob3egBMDWREMyKIFGAgfTNtbB0svXcBxgsRZj9sWFXs=;
        fh=qbnnSbKoyRh6qi3JA1SICQ4DFExH22MB0XuHqyff4ec=;
        b=Pufwjx59PIueSuMhugh2m/OpSD6OprleyQsc8cl5AbfomSEqnOouFkUDCjF23Ybqi2
         woKcnMzicAljoqKMTb6isaIkwe2tWptH5haFlFZbEgBOvd3+RDvDMhnsc3v5O2uFa2/k
         2nPw8GSYom4OseVwEx2y64P7XVzjvEK1DNyvJAe23HWv7jHi3NjEl3egsRp7lrKjdQde
         XqcunBHUTB3ghIrIw+a8kENvPbEZQqGiZs42NCTN2tW9h6VFfh0WI1lOGNaGuV1Pcnw/
         jGqojCDYZMyFZ0f9un6yviCXGJwXdcgnzBes9eJbgSBG5MXYQVmXTEf73skHrkVxK6XX
         vkGg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20260707.gappssmtp.com; s=20260707; t=1794633039; x=1795237839; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ob3egBMDWREMyKIFGAgfTNtbB0svXcBxgsRZj9sWFXs=;
        b=mCKXHy8Ao5SJCohTrngXT4l8fs99nZ01rbuzlEdqPWStoBjrfa78TW9QYQLEPqgZjO
         9bOsht5/CHcZQT9ZnM+510rrez1Wdx4h4iaLJUdoM/jZQ51Obt7rxjPcqDZJrEUST1kc
         YYAGUBX88HlDMB78eE+j8Gyl1R9itemxRLELaPIakno7lbmnkYjE6mu3Ys90ir6VVq3V
         6aLOOVhwvSpcfH3Vcr/SMYAj4ziPiGBgHmCSZKkIa5dlQtSHt6dbmwfmi33RDkjRHTUJ
         8XPIUKPQQlPpYhpw5cY+Q2yL+csKZtkKWcN8t5nZtpKUrxm95IzWpdTcSUfipP4rvxOQ
         vROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633039; x=1795237839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ob3egBMDWREMyKIFGAgfTNtbB0svXcBxgsRZj9sWFXs=;
        b=XJiPP613m/kCcxdIOVKdynkY8361t7dTcQuhwVkQbl054o5k4NPwuAx+d8X4OMD+KR
         MGfii6z3Mb+KZNzNodGPKiUp2syM+hrNNPzYnE/tPtOMi3nTMdB43oK1E1dxkN+/8ofr
         hKJU4ECfLcVZiFNj5l4kb6VE+G5Fle28wesyPGkpNhueocHEQM3GrAo8XddRpMqnDNQr
         PWW4URF544ibZaRH6PJv+GIRvcCDvbsuO8TV8Lg6tFChy2muMt+FAdnQyOHrnBDmuEFA
         uKipvxaoQSW+slbUrw0efFAkcgQxB0KpstMFIR8mf4SBKmTRaK2PU4tKFO+/fZqyUm/e
         lM1g==
X-Forwarded-Encrypted: i=1; AL+hErGQbROirgAFEt/aT01M7ZNdNFqhj4Zuhbm0ppdltTnPxjW2y95i2qpEyxRAnCeQyGqLSL/7eQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z+3HM9hb2aIMIiiQPr6xquFZs6rSiI4eiA5ObGG1EvDYWgkyVF1
	d3hzUCoPikDuZWtQpwlTI6I9MmjfRLLxsPO4mstHnwuIyqKCrQKJz+myD+yhdYUzoJgHNH2jxQH
	1n6vbWqRHVEfMT9gF1p5nsII2fksgPlUnoxIguVbKLw==
X-Gm-Gg: AYBFou00ytpC0y7o/wj23dIcC2zpcv8Asa8Y1C8lMu1yznEiKCTfVD/82cUWqUPME+G
	3iZoU7euXtc6ZD4ugXOhIaZpKOKpewfBum6xcZ+p9xGjzImS0009tYBhvkbU1VTRvL9jbYCRPaJ
	xr9Aqydm6Ry2Bp3R407TOGWSGqHC8S/SGmHRbnRsYGueDEbIydB5Nh2AKRLc0TVT0tFAB9URD2l
	UEc9bizGfaJgvHG7x4OpeaEXFy07tJ7hweLfFpc9qsLESmbIww+sQuh8dG0vvcLpr92AwLK68fu
	NXdyjV7/toLWVeUeelJ0t1e6CaolxlVKuyTaa/9TzwCKCCEYxiY7abpsO3QXAVMW14qV1sVPLEL
	ZfqVf/tv2T5BGk7/RXz5wiqWtllT2euK9s6cf8m3z5sFnwy464cxwbUjgawfKSCCpN8WoXWH8rZ
	0gCj255vJUsUZgQsZO+3/Mys57yA==
X-Received: by 2002:a05:6402:450a:b0:6b7:6485:23cf with SMTP id
 4fb4d7f45d1cf-6b7c0c71b38mr3747576a12.42.1794633039273; Fri, 13 Nov 2026
 21:10:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114034901.107028-1-xiyou.wangcong@gmail.com> <sashiko-outbox-214131@kernel.org>
In-Reply-To: <sashiko-outbox-214131@kernel.org>
From: Cong Wang <cwang@multikernel.io>
Date: Fri, 13 Nov 2026 21:10:28 -0800
X-Gm-Features: AclHuK9b9YbnQrkMNNBhoXZWszfVxhoLcU0mX9oRO4yAMe-BoLYXAumd77k65Mk
Message-ID: <CAGHCLaQZkusf3a0sD4jSky=u09hpmc=_i+CYdZ_vPsJotTSNdA@mail.gmail.com>
Subject: Re: [PATCH] riscv: kexec_file: Keep segments out of the new kernel's
 PMD padding
To: sashiko-reviews@lists.linux.dev
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Song Shuai <songshuaishuai@tinylab.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Han Gao <gaohan@iscas.ac.cn>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Mike Rapoport <rppt@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Guo Ren <guoren@kernel.org>, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_211042_782111_C25AF26A 
X-CRM114-Status: GOOD (  15.59  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 7:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] kexec_file: missing placement bounds checks in
>   kexec_alloc_contig() [1]
> --
>
> commit e91ae0bea9270620f64704189d1d94046334bdb0
> Author: Cong Wang <cwang@multikernel.io>
>
> riscv: kexec_file: Keep segments out of the new kernel's PMD padding
>
> This commit aligns kbuf.buf_min in load_extra_segments() to PMD_SIZE so
> extra kexec segments are not placed inside the new kernel's PMD padding.
>
> > diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel=
/machine_kexec_file.c
> > index 26cd2a8bd0cd3..0d2d43a7dbfaa 100644
> > --- a/arch/riscv/kernel/machine_kexec_file.c
> > +++ b/arch/riscv/kernel/machine_kexec_file.c
> > @@ -251,7 +251,8 @@ int load_extra_segments(struct kimage *image, unsig=
ned long kernel_start,
> >       char *modified_cmdline =3D NULL;
> >
> >       kbuf.image =3D image;
> > -     kbuf.buf_min =3D kernel_start + kernel_len;
> > +     /* The new kernel reserves itself up to the next PMD boundary */
> > +     kbuf.buf_min =3D ALIGN(kernel_start + kernel_len, PMD_SIZE);
> >       kbuf.buf_max =3D PFN_PHYS(max_low_pfn);
> >
> >  #ifdef CONFIG_CRASH_DUMP
>
> [Severity: High]
> This problem wasn't introduced by this patch, but can kexec_alloc_contig(=
)
> bypass kbuf.buf_min and kbuf.buf_max when allocating a CMA segment for a
> non-crash kexec_file_load() [1]?
>
> Unlike locate_mem_hole_top_down() and locate_mem_hole_bottom_up(), which
> check kbuf->buf_min, kbuf->buf_max, and arch_check_excluded_range(),
> kexec_alloc_contig() only checks kimage_is_destination_range() (and passe=
s
> the exclusive end mem + kbuf->memsz rather than mem + kbuf->memsz - 1):

It looks valid to me. I can send a separate patch for this.

Thanks.
Cong

