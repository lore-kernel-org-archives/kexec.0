Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B71CAC5B0
	for <kexec@archiver.kernel.org>; Sat, 27 Sep 2025 20:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UvNClLKNNn9rK6Vik019kICWDMo2uNNhdQgjV8A+LJY=; b=SjU286Go94BRcZgqMYPXxuZNeA
	Gf/7utw9A4I/7dYlB1ArgX5QZM7SasPhTckHpY/VpMO3FWpbKeyt2IvTAIdniCSPQ+sqSDoO11FrG
	7yfYsKJaTfGeboekBKXuqik4k0jXUPMOj+96oH6BuelM+R8Ep/4Rja3sWvOS1WgM5qs4a2QC2r5D3
	cdx8TvE7bbv41oVz1YbAVH5P0WytSrGPEMLzy5bqmKsOH4epIWlaufLbQFoLoNJLY95MVmaAo0brJ
	BlwtV2tH1wglcE8t0jlj37AHgnF8Yq8RpUkoLNQLx/iaDoP6NIY+2vSjee4Pp4V3baWBv7ZelR3S+
	dHn74w2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2blb-0000000CQrO-3MCp;
	Sat, 27 Sep 2025 20:43:39 +0000
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2blY-0000000CQpG-3r6p
	for kexec@lists.infradead.org;
	Sat, 27 Sep 2025 20:43:38 +0000
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-55716f2d3b9so2704341137.1
        for <kexec@lists.infradead.org>; Sat, 27 Sep 2025 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759005815; x=1759610615; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvNClLKNNn9rK6Vik019kICWDMo2uNNhdQgjV8A+LJY=;
        b=F/dJK+l8x6D+Wg0JybmYzOE8p7G1BbhmDOwqTrj78QJuXoSVFj3WFOEpxGFELcmvLC
         83i1POJZeHJKKi5B+R6sNIJWlos6gZHRTByYS3iEfzV2WxaU50iUM2N5F9JpnJGvzJpq
         rgEMmT7eUJru0SiEDTuSiAewfjeqGY7fsEinFm89jJ4U9f2FghM/AuDQaAps0ESrBj0x
         HrOT9CspjEbYaiFVBySqYedaEAzE/f12qnmbJT85UEO1ZkyAoY0V8E/Ns4lW3zt+c7Ii
         RL1fthqnKwMWmit46MIS4RO6jqWPEsu2aGj1TxhbQj5vIdF0Icr/olicAa3vlCtTrSOe
         A1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005815; x=1759610615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvNClLKNNn9rK6Vik019kICWDMo2uNNhdQgjV8A+LJY=;
        b=LORQZOXVh3BVBsSbRTx1zx0TTs+lHaI5O9bwFOlMZKRgXOjaMJNhqScq0U7avrwo9l
         Gf1WSYGt/3VqPOcCVkk6QHWZ5v4MMjP7GUnY8xyEkNaCfVmK4nwzBnUYxBu2wS9MaNj8
         FVCYmfIlM6rW3vfibxbOzbPBbYjNaFmjCLqnkdqKS5iQb4epTyJWGrsoYXeYQQdvOvt3
         s12Z0FZZMmpbaWiB1+oBzN+48khnnhlsa5M/9u/eCVMLBexoc8NZwCU501Om56KS8Rau
         ZyeWnbsoI28gGXKmAQWsUnvRRIQrRNbSz/LbV0XrEOYkFRGZhsdeytz10zY6lnIVm0O9
         iORA==
X-Forwarded-Encrypted: i=1; AJvYcCUeYmwqGSniCbKGpAM1cqIC59LDFjG1e0f5qgvU6o4edryGdTEyG0gYEZv84sRjEh9DAM/sKA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxpd4w94v3eZcxrRkAelhNg6kslQBSsMOHmevzP4mfQsJADCww2
	69BOMmf0tl6K+7ifEoBkC43QYXomCe+cZFMfsuyjyykVjkAF9Uee5Bkz6BEj1fpfrRji+35F+El
	6BVsMjaQtgeeFrydBWVepjrvdiGBOTMU=
X-Gm-Gg: ASbGncsxrAkh9G4rJAh66p/ElYZUinQDl99K0kYSVXZEHPhHxzQPpGE1UIgzZeD7Wac
	+TBdmXEsnFcMTkXsryXxihV8ud/DeFOZisdtwcloOVzYyUF/oF33PYaRgfWmTjAEJqdbQ3qPdbx
	BmpG9WLsRyzf5OWkBcub7zjted6v2hPZDBlegQLqOQdkBVj719m4adGwosua/m1HvhCAqoeVY+D
	fMHq/kD9/vxi0RSdUY+thawyKvq6168xkiOjUz+
X-Google-Smtp-Source: AGHT+IGYQ8cZXq6p06Ik0TDBdufn7B3v54OBWxKvQ9AFYTgNeyye8BPJ3qw2CKkk7AUAcaDd0Kb3KEG7ImktB5zLhBw=
X-Received: by 2002:a05:6102:2924:b0:52d:1b06:5e34 with SMTP id
 ada2fe7eead31-5b2826795b7mr3196814137.10.1759005815440; Sat, 27 Sep 2025
 13:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org> <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
 <aNZh3uDdORZ5mfSD@kernel.org>
In-Reply-To: <aNZh3uDdORZ5mfSD@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 27 Sep 2025 13:43:23 -0700
X-Gm-Features: AS18NWBZ4NYpS8oIgxtkL6K4jFZHcC-C1DNvJN4aikZTVbjqp7kQjMuXYe8nY8M
Message-ID: <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250927_134336_971138_344EE526 
X-CRM114-Status: GOOD (  27.18  )
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

On Fri, Sep 26, 2025 at 2:50=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> > On Wed, Sep 24, 2025 at 10:51=E2=80=AFAM Christoph Lameter (Ampere)
> > <cl@gentwo.org> wrote:
> > > AFAICT various contemporary Android deployments do the multiple kerne=
l
> > > approach in one way or another already for security purposes and for
> > > specialized controllers. However, the multi kernel approaches are oft=
en
> > > depending on specialized and dedicated hardware. It may be difficult =
to
> > > support with a generic approach developed here.
> >
> > You are right, the multikernel concept is indeed pretty old, the Barrel=
Fish
> > OS was invented in around 2009. Jailhouse was released 12 years ago.
> > There are tons of papers in this area too.
>
> Jailhouse is quite nice actually. Perhaps you should pick that up
> instead, and start refining and improving it? I'd be interested to test
> refined jailhouse patches. It's also easy build test images having the
> feature both with BuildRoot and Yocto.

Static partitioning is not a bad choice, except it is less flexible. We can=
't
get dynamic resource allocation with just static partitioning, but we can
easily get static partitioning with dynamic allocation, in fact, it should =
be
the default case.

In my own opinion, the reason why containers today are more popular
than VM's is not just performance, it is elasticity too. Static partitionin=
g
is essentially against elasticity.

More fundamentally, it is based on VMCS, which essentially requires
a hypervisor:
https://github.com/siemens/jailhouse/blob/master/hypervisor/control.c

>
> It would take me like half'ish day to create build target for it.
>
> > Dual-kernel systems, whether using virtualization or firmware, are inde=
ed
> > common at least for automotives today. This is a solid justification of=
 its
> > usefulness and real-world practice.
>
> OK so neither virtualization nor firmware are well defined here.
> Firmware e.g. can mean anything fro pre-bootloader to full operating
> system depending on context or who you ask.
>
> It's also pretty hard to project why VMs are bad for cars, and
> despite lacking experience with building operating systems for
> cars, I'd like to believe that the hardware enforcement that VT-x
> and VT-d type of technologies bring is actually great for cars.
>
> It's like every other infosec con where someone is hacking a car,
> and I seen even people who've participated to hackatons by car
> manufacturers. That industry is improving gradually and the
> challenge would be to create hard evidence that this brings
> better isolation than VM based solutions..

In case it is still not clear: No one wants to stop you from using a
VM. In fact, at least in theory, you could use a VM inside a multikernel.
Just like today we can still run a container in a VM (Kata Container).

Your choice is always on the table.

I hope this helps.

Regards,
Cong Wang

