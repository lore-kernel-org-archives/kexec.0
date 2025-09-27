Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7EACAC5B8
	for <kexec@archiver.kernel.org>; Sat, 27 Sep 2025 19:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xQ9bzFk69iukmKUY25ufCAqjrKMzVtKfHbiTqiaUsA=; b=RxOrkdLbbcnm8dtGvmiVe6xyaC
	mOe5lqEG7FiYtvKTROzjtPBdldUNP/2IKApTgcstVvyQEYVbtnsCbq2ew4nvhni9EHpBcgONGCykG
	YuTSAVmjFhmZwkCERIUUWjx0YcYDUbniPRWwaXLY3pfEUflFp3Fl7amnfqBSSRCzC+y+BuxizBs6W
	LATIP4Rvd9FSsTTJPIV4MiL8ZuVAhT/AovuTUdFSC/H4tRkMtNpf80WoqDYz6MMLAkX7co4PHjWGA
	IKjvf19YwuejUfbz6I4IJQP19XCJQVo+EtInt7RNb8kJUh9Lb4FNOCF0b6BzqWUWd/XzCG8xfreeX
	E9EEC5Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2aoc-0000000C6Mv-0reM;
	Sat, 27 Sep 2025 19:42:42 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2aoX-0000000C6L1-09Up
	for kexec@lists.infradead.org;
	Sat, 27 Sep 2025 19:42:38 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-55784771e9dso1665216137.1
        for <kexec@lists.infradead.org>; Sat, 27 Sep 2025 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759002155; x=1759606955; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xQ9bzFk69iukmKUY25ufCAqjrKMzVtKfHbiTqiaUsA=;
        b=JWpUAWPnqBGGrCJS1yXLCZB7Wkrsv5V6Y4lq9kH+BtAeXHDAgVnVhyX3tLMz+fLg/x
         loe2JKT1Ckys5SLCJIOV9hI7QTigMrquAz8OoaYaw9aOecduSOQvPP44qDrlyrjRip3s
         Wet5dabYRlXf7LyuC9d1qmOCq+JbdF+V2neZmETaVpm9pDlsUnGstGOrsgOeKZVBYTLU
         rBeJ5Ctv8M9JN8j2mOHOfJ1/zGrZuxZcxhJjP5juwh7FxFOxahvgbCAKViF2WO0a13+8
         STF9NRyfSCijlq1vWPnpu9qm8x8eb6jF/mI6MippqDk0hL9lS31EDvUP+eI2Qo9gZUg/
         VY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759002155; x=1759606955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xQ9bzFk69iukmKUY25ufCAqjrKMzVtKfHbiTqiaUsA=;
        b=Nw4NsEWcPqHsVjC1//j3lmIHpA85uHavuXvnLB6mnfABz4af7JLmeMFsIiKZtOn2Lq
         /CE1yvDT8qfEMh3oNfT5yCTahEC6hLO6uUh+u1Oh8F+505Su6MhU+uT1JET/5Wyam4+7
         d6z2Z9t865KD9mXX41bTTIlIejvFPu98CsBypz5N8/YPCXP9Tm9OHhmo08i35EK/05wE
         BrxZYfhHlprhCjTzs4z/IJqVj0w5ar50vcIwFDFonnczU5rUMqv6pl8jPTSRixyNDIcI
         u3SbwTs1Yj8Gydlet/DwvomvkPIylg1Gi9UfR+ice6K4zkfwKZdHcix2bLsupRXz2aX0
         ufYg==
X-Forwarded-Encrypted: i=1; AJvYcCXPNcm4bHwqPJ+HpKwKSf8LkZQiWs45WoFbrvEzFQtnJL3NcPrH0T68tjZN48qM8rk5yhNaJg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwSsiDewu3UahnuPxwsx0TdM2uWSBmtHcmNfYH57rA+slHaN97o
	sCPa3434NBkGrmO1qVlCvlqccF/Rfo8cgHX6jrCLX01puKA4jN88l9TxIzNnCHPUdO8bYx8c5RY
	2QKyqhyNOz0SkEo8HEdtgOvYwOXeJBAI=
X-Gm-Gg: ASbGnctjK9TA0fqlSCpzv0+nFus8BSNg21VCqsE0otvMAKgE7AdWntKQv1zPI550RC+
	6I11NJ+9aBN+Ug/EBhS0pmVrsaxgVc2QQSwO10ig3Bq9HW1+vqCCgHQKKcVgH+I1YIJ+e3rzVtJ
	kGtKHDRbFdvcmbT59aiQ/qaaTc0b7xXcTO6O/gTe8rKSG19IsULlAH3TQLEH6fWmYsJVQGPLbUm
	ElhdNpiKIdwJvmG+6Py3x07FLlvAYIGMrU74vZOr25TXLTxPWw=
X-Google-Smtp-Source: AGHT+IGglDo1/gdOcNhsuSzZl7FEO053NNm+ZSGFGErw4ULSPn8POBz7Kmhwj8faLx+8S9aP6qgFUy5HNQzHFDYGmS0=
X-Received: by 2002:a05:6102:6499:10b0:5b9:c38a:c4f9 with SMTP id
 ada2fe7eead31-5b9c3a94dcbmr1525519137.31.1759002155340; Sat, 27 Sep 2025
 12:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora> <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora> <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora> <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
 <20250924190316.GA8709@fedora>
In-Reply-To: <20250924190316.GA8709@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 27 Sep 2025 12:42:23 -0700
X-Gm-Features: AS18NWCeP2cGzDoATwSVHNUS5qX7kDmrKwGEMa7Qt3ofJhYYTiaA4U-AxyJEbYo
Message-ID: <CAM_iQpXnvyZWrv4W45SBTDV-tCXU4Fz1=S8z_0s5en+U29vSZQ@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250927_124237_087230_B65DE9AB 
X-CRM114-Status: GOOD (  14.09  )
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

On Wed, Sep 24, 2025 at 12:03=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> Thanks, that gives a nice overview!
>
> I/O Resource Allocation part will be interesting. Restructuring existing
> device drivers to allow spawned kernels to use specific hardware queues
> could be a lot of work and very device-specific. I guess a small set of
> devices can be supported initially and then it can grow over time.

My idea is to leverage existing technologies like XDP, which
offers huge benefits here:

1) It is based on shared memory (although it is virtual)

2) Its API's are user-space API's, which is even stronger for
kernel-to-kernel sharing, this possibly avoids re-inventing
another protocol.

3) It provides eBPF.

4) The spawned kernel does not require any hardware knowledge,
just pure XDP-ringbuffer-based software logic.

But it also has limitations:

1) xdp_md is too specific for networking, extending it to storage
could be very challenging. But we could introduce a SDP for
storage to just mimic XDP.

2) Regardless, we need a doorbell anyway. IPI is handy, but
I hope we could have an even lighter one. Or more ideally,
redirecting the hardware queue IRQ into each target CPU.

>
> This also reminds me of VFIO/mdev devices, which would be another
> solution to the same problem, but equally device-specific and also a lot
> of work to implement the devices that spawned kernels see.

Right.

I prototyped VFIO on my side with AI, but failed with its complex PCI
interface. And the spawn kernel still requires hardware knowledge
to interpret PCI BAR etc..

Regards,
Cong Wang

