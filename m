Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A9EF532E8
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j0p7ruypCDdXXfhz5IqiaSpJ0nIoncl+MrV7FY/rAAI=; b=x9EndKmVNnyviLMvJ8kJnMga+Z
	yYKA4q/GryzoAOZ9dJoxaJJbJ6otiXCKW7jOpjaKPq5Mg/NH3xSObxyP4eD2ofi1+R0W/43RXl85X
	G5a+hWQyUzhqWP0z4w/mhtLyXoxUH8hKBcxCoxerwv+XcwQMABR8DWc3wfbrx+Oz9hUlBBsf/JiyY
	7Wgj7Tw81RUqcsPzzTic/vpDVIl1uKFPG1rGPt09/M9XCpON7ZeJOmvO4As5Oi3LIlGXaTobCZf3q
	XOMwuSQf+/bZQBKjSWJqg3qyDCDmjPvKjbU1MdPzEkUG9IzzYnmO0QQZxEYSj2c7ADVIgWKwCdYro
	Kz0U5nDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vtw-00000000rki-2Jhm;
	Tue, 24 Mar 2026 07:10:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vtt-00000000riy-1bzP
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 07:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774336202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0p7ruypCDdXXfhz5IqiaSpJ0nIoncl+MrV7FY/rAAI=;
	b=PD/Ej470eOb+g84OhCkfHcxaEVAW2ZaWGBRxMZ/6RlQWtlPDUE73LTb2OcLeiY5mcx5x5T
	mVRx4h59t4Cd+8/kGeq4nYb49CPsOOSik5h5yA5LZOaygJiXlduKycoP3wEJOtuXPP6PTw
	XV44ms/XCid68DShZR9v9dgbyfvVFSY=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-m0KpNOUwOjCB7YPz09WUsg-1; Tue, 24 Mar 2026 03:10:01 -0400
X-MC-Unique: m0KpNOUwOjCB7YPz09WUsg-1
X-Mimecast-MFC-AGG-ID: m0KpNOUwOjCB7YPz09WUsg_1774336200
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c109ba1296so8329021eec.1
        for <kexec@lists.infradead.org>; Tue, 24 Mar 2026 00:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336199; x=1774940999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j0p7ruypCDdXXfhz5IqiaSpJ0nIoncl+MrV7FY/rAAI=;
        b=Zl81tKubiLb+kOHSc2g8Ys0TXN6I1h0AjmUHwalta2SVgc5IAli5GHuUBpiBpG+Y/B
         gfYLRJdLhSXd1UwN2MgiO34smDc9Ix78mFgYn+GWekOe8f+MJ0vgMz9cXi45XY9sL8FR
         gZmqgw1IvqLiYQS8YvMpSc3p5CZWoC/vnjDRF5MHfL5qyHsixrYKf3r/+QhwU66rLEMd
         eGSnamNjDqLbbvQMl5NVsihuBEWgiLNn9gnZr49IOYIttmcThiY3wRZibe/0bLwyaum3
         6woyn8ebXqJc6FHBUuKf7pqCg5IC/KketQIZIpTpkWm/NAPXBEMy00C4CNeRglZgSubk
         8h6A==
X-Forwarded-Encrypted: i=1; AJvYcCWJukJyEkZCA3OHdi39ROCFgMCfh6U7NHTPfdqn5HQdabiax5/fhH3ZC/ouyeZdv/D9tqSTXQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdDUycYFWw7otTisLdHihrko9wj0Wlu6luwrPNKJ3TYGc5RYb9
	9hBMnFdSQdOuF5K1oRTLoX2rpmwBdaMNo4sV9Tnf7s/MwESTvn3uBUuY25y3yKPEfFc7gQb7nIC
	z6BlqPnhEMT/d7ZvpZ4qJAx9lZLvddbnVcKa0CFx/HvTK6wOuCmRgCATEcCa0pdwNr9vUHK68GC
	cwAQ18fqxBqxOJTfhyDsnRBF8LejKFKwjlHRjzt7GAV6JncuY=
X-Gm-Gg: ATEYQzxSkzOCfdm6FBsPkXJI/MTSnGN+vXaeQ4UhNYFxw12igCAkd69mwbqaQABmAFI
	tjauGdqcI1XJVSnzh6H57aNgG0b3uKpO/zCB3p/pWb3zP81K3mq0cupNnCuZAS97TKO9G5sK0BO
	1dZla6E/yjMfg9DeAtFKAF2+NvJd5UDivY+qV8284J1xiBNKDPeNhdpKN2iuW/XDWxtOBu7LOot
	Qkn2r4=
X-Received: by 2002:a05:7300:a145:b0:2be:617:2ddf with SMTP id 5a478bee46e88-2c10970ed0fmr7262393eec.16.1774336199480;
        Tue, 24 Mar 2026 00:09:59 -0700 (PDT)
X-Received: by 2002:a05:7300:a145:b0:2be:617:2ddf with SMTP id
 5a478bee46e88-2c10970ed0fmr7262363eec.16.1774336199034; Tue, 24 Mar 2026
 00:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260322014402.8815-1-piliu@redhat.com> <20260323120202.e662110de3ca696086f9e1f9@linux-foundation.org>
In-Reply-To: <20260323120202.e662110de3ca696086f9e1f9@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 24 Mar 2026 15:09:48 +0800
X-Gm-Features: AQROBzArO1s8UFiUXdDfYP1zd5xobyzeix-spM303OTU0oAnUprxLEsDtBalr70
Message-ID: <CAF+s44RKERrXWEt+a7c8+bMt5fDbFUfVo109nS2d++sTH_S9fw@mail.gmail.com>
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WeHkdaQDjwCalLPh0eXSYRDk1OI1sgarex4fBg4HUsY_1774336200
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_001005_513660_A14B08B0 
X-CRM114-Status: GOOD (  20.84  )
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

On Tue, Mar 24, 2026 at 3:02=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun, 22 Mar 2026 09:43:49 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > Nowadays, UEFI PE bootable images are becoming increasingly popular
> > among distributions. Currently, we have several kinds of image format
> > parsers in user space (kexec-tools). However, this approach breaks the
> > integrity protection of the images. To address this integrity protectio=
n
> > concern, several approaches have been proposed to resolve this issue,
> > but none of them have been accepted upstream yet.
> >
> > The summary of those approaches:
> >   -1. UEFI service emulator for UEFI stub
> >   -2. PE format parser in kernel
> >   -3. Signing the arm64/boot/Image
> >
> >
> > For the first approach, I tried a purgatory-style emulator [1], but it
> > encounters hardware scaling issues. For the second approach, both
> > zboot-format [2] and UKI-format [3] parsers were rejected due to
> > concerns that variant format parsers would bloat the kernel code.
> > Additionally, for example in arm64, both UKI and zboot format parsers
> > would need to be introduced and chained together to handle image
> > loading. For the third approach, I attempted [4], but since zboot or UK=
I
> > images already have signatures, upstream maintainers dislike the
> > additional signature on the Image. Moreover, for secure boot UKI, this
> > method cannot use signatures to protect the initramfs.
> >
> >
> > *** The approach in this series ***
> >
> > This series introduces an approach that allows image formats to be
> > parsed by BPF programs.
>
> AI review has a ton of questions:
>         https://sashiko.dev/#/patchset/20260322014402.8815-1-piliu@redhat=
.com
>
> Coverage is partial because some patches didn't apply.  Probably some
> of these questions are legitimate, others will be false positives -
> we're still figuring this out.
>

Thank you, I will check them too.

Best Regards,

Pingfan


