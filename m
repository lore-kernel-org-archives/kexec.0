Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4607CAC5BC
	for <kexec@archiver.kernel.org>; Sat, 27 Sep 2025 20:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HL8OHm/tOdgmn/uUV1BO+N8G/bzT1Rw1z+XhcpcLJZU=; b=uv0yPpeNuFal6tHf3+0+19RvzQ
	NtmtAOtbZGIDImkyO8pjEQzwfT7SGoFF4i55PgZYbO/jHIXo4+L0quzkOtxlxLs2fSd53ZXGbEciT
	/ten84eqUzwk4Zhz0nXh5qt7m3EZe49AmOfC1+JtvjEOF8AmP+fJ8kM6Zvo8HOXDL3QTsobdA6doA
	tIiVEAW4SCF9+uCWvm2YDWutG88/6YMHTcnzq6J9dA/LWka/Ygvc92KU5SuNr9TqKhO6XpzvTk91s
	zZmzmldVxelY3Kql/mOe91kgjawLkdhRwG6xy7kDXIEStMGThDCogZgEepnJyXJ3e0NO4vyQPxiCp
	4q0cbuAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2bCC-0000000CEiU-3Eav;
	Sat, 27 Sep 2025 20:07:04 +0000
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2bC9-0000000CEi7-3z3k
	for kexec@lists.infradead.org;
	Sat, 27 Sep 2025 20:07:03 +0000
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-59d576379b9so1623280137.1
        for <kexec@lists.infradead.org>; Sat, 27 Sep 2025 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759003621; x=1759608421; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL8OHm/tOdgmn/uUV1BO+N8G/bzT1Rw1z+XhcpcLJZU=;
        b=OZI/TJHyATpilJUM0uhdilY9cm7DzxX/dJPOFZKiuSfDX0SE2zWhqik/8jV3mpHy9D
         IMFdGp24l5dh8k0TeiClIhFQ+SuhtvNoFLGaZSGG6BhVneiaUkpCU+IB0k+qVX5JeGG8
         eIbCu5a0zfjcCilcclLXxhp1krpstrhqHeIJRQCJV1fZSakLyQowyvbxAkSXStyrlNFM
         rGmhhXPyJEwnCzklbc51V86yMCzPuWt12fyoXfjs/U/MvTmmMZfmKmiUud/aExiJMrdI
         9ZV8SfHdvVtfEUpm9XUTORs5ye8SCde3Z6Bp6OKcuBe8fx9TZICFBY0RlENzqesRVRHY
         J2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759003621; x=1759608421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL8OHm/tOdgmn/uUV1BO+N8G/bzT1Rw1z+XhcpcLJZU=;
        b=vrGIMZkeyoVO6K4FfimHk6stTh1bQ/Gt6v2lz+kBG9YAjhmsjArzlPRhDopTd+P3xi
         0nyza8c2r1/Jkwn10tCTiqH0x9p3LZUwo8jco3w1LOgqMZGORzLTMIvxmAWc1O2yJa3B
         cpo+dWmuTKmhcA8MsVjUX8XJq0xrxqiZFEKommDlUL7PxaZZlr/AZ8+37SZPI34uH3uG
         bl+QOJnMuDUkGG1hYotVX2S+v5M1+1zY300g7cXDvSW/jOx1W71eSXJTQRbS7Iv4HzT2
         i5GCTrPwjYt/KUc2R9JNfKLTnmx0h2hfpq4Y7IYulPNKQyI788ptHLvJwj8Bw0H2gqH3
         KEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxgCoF/hWP+PebwHLaG5iZm5CKumLveNjIGBGqx5utJ89oCMDOUCMfcwO29Yorv5ngfYJzQg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/D8+EpjMwvyZ9EYZV1TwQ6p0nIq3LaFmitwGQKq23MqmIKTCd
	+ZUrhFnUib3j24swoNQ86YCXp6aA5Kg/MnzukD1r8FSwpSZCdcf7FI4s32XH8RNzp9CxF89peB+
	VN3AvQW//GWcfxQsJ9ELqcvN/OKkPPok=
X-Gm-Gg: ASbGncvyMF1JV9XAB8pke5iF4xMqe9tB61njfSHuaN+uXtiKDk2X2LTkFkyDGkDNx0r
	bSZ4hOLc9DFyzBHxKuMA+o1crzrA99j7BaoKTNOGHZRC2QP8EhCiaxWsXZF7s6+6MKkbL4uEYl6
	eRTBkOfAKZX5+Z5nwdMaaB55Bhtk60GvJ1YPXwIFnpGGqho+CXJJm9tEFsw4Iy3ANqGSsQERTSg
	X1zUFXlJYRNu26Tsg9S+g87uj8AtcZO92okjRvXejkwyPKoC5M=
X-Google-Smtp-Source: AGHT+IFavD4z1GGoEGlY5lI3JUX612+I+UAMojZazeqkDP6BSDuGvbpnL+RUoY1IBixIMQhPSpIruVr/5IWa60JA5b4=
X-Received: by 2002:a05:6102:304c:b0:55d:b35e:7a58 with SMTP id
 ada2fe7eead31-5acce758205mr4579967137.23.1759003620680; Sat, 27 Sep 2025
 13:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <BC25CE95-75A1-48E7-86E7-4E5E933761B8@flygoat.com>
In-Reply-To: <BC25CE95-75A1-48E7-86E7-4E5E933761B8@flygoat.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 27 Sep 2025 13:06:49 -0700
X-Gm-Features: AS18NWBOT7tF0SL4tkvmWuhGCT6OBGfRbzY0O05dFjAR0c0T2kS4_McGk5cJnbk
Message-ID: <CAM_iQpWB1Jq88qDd+z7j+y1fEBRtV86LVHneLemHdvq28g5Dag@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250927_130702_009894_79BD85AB 
X-CRM114-Status: GOOD (  24.98  )
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

Hi Jiaxun,

On Thu, Sep 25, 2025 at 8:48=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> > 2025=E5=B9=B49=E6=9C=8819=E6=97=A5 06:25=EF=BC=8CCong Wang <xiyou.wangc=
ong@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > This patch series introduces multikernel architecture support, enabling
> > multiple independent kernel instances to coexist and communicate on a
> > single physical machine. Each kernel instance can run on dedicated CPU
> > cores while sharing the underlying hardware resources.
>
> Hi Cong,
>
> Sorry for chime in here, and thanks for brining replicated-kernel back to=
 the life.

I have to clarify: in my design, kernel is not replicated. It is the opposi=
te,
I intend to have diversified kernels for highly customization for each
application.

>
> I have some experience on original Popcorn Linux [1] [2], which seems to =
be the
> root of most code in this series, please see my comments below.
>
> >
> > The multikernel architecture provides several key benefits:
> > - Improved fault isolation between different workloads
> > - Enhanced security through kernel-level separation
>
> I=E2=80=99d agree with Stefen=E2=80=99s comments [3], an "isolation=E2=80=
=9D solution is critical for adaptation
> of multikernel OS, given that multi-tenant system is almost everywhere.
>
> Also allowing other kernel to inject IPI without any restriction can impo=
se DOS attack
> risk.

This is true. Like I mentioned, this is also a good opportunity to invite
hardware (CPU) vendors to catch up with software, for example, they
could provide hardware-filtering for IPI via MSR.

If we look at how virtualization evolves, it is the hardware follows softwa=
re.
VMCS comes after Xen or KVM, VPDA comes after virtio.

>
> > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > - Potential zero-down kernel update with KHO (Kernel Hand Over)
> >
> > Architecture Overview:
> > The implementation leverages kexec infrastructure to load and manage
> > multiple kernel images, with each kernel instance assigned to specific
> > CPU cores. Inter-kernel communication is facilitated through a dedicate=
d
> > IPI framework that allows kernels to coordinate and share information
> > when necessary.
> >
> > Key Components:
> > 1. Enhanced kexec subsystem with dynamic kimage tracking
> > 2. Generic IPI communication framework for inter-kernel messaging
>
> I actually have concerns over inter-kernel communication. The origin Popc=
orn
> IPI protocol, which seems to be inherited here, was designed as a prototy=
pe,
> without much consideration on the ecosystem. It would be nice if we can r=
eused
> existing infra design for inter kernel communication.

Popcorn does the opposite: it still stays with a single image which is
essentially against isolation. In fact, I also read its latest paper this y=
ear,
I don't see any essential change on this big direction:
https://www.ssrg.ece.vt.edu/papers/asplos25.pdf

This is why fundamentally Popcorn is not suitable for isolation. Please
don't get me wrong: I am not questioning its usefulness, it is just simply
two opposite directions. I wish people best luck on the heterogeneous
ISA design, and I hope major CPU vendors will catch up with you too. :)

>
> I would suggest look into OpenAMP [4] and remoteproc subsystem in kernel.=
 They
> already have mature solutions on communication between different kernels =
over coherent
> memory and mailboxes (rpmsg [5] co). They also defined ELF extensions to =
pass side band
> information for other kernel images.

Thanks for the pointers. Jim Huang also shared his idea on remoteproc
at LinuxCon this year. After evaluations, I found remoteproc may not be
as good as IPI. Remoteproc is designed for heterogeneous systems with
different architectures, adding unnecessary abstraction layers.

>
> Linaro folks are also working on a new VirtIO transport called virtio-msg=
 [6], [7], which is designed
> with Linux-Linux hardware partitioning scenario in mind.

I think there is still a fundamental difference between static partitioning=
.
and elastic resource allocation.

Static partitioning can be achieved as a default case of dynamic allocation
when resources remain unchanged, but the reverse is not possible.

Hope this makes sense to you.

Regards,
Cong Wang

