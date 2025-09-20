Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FC2CAC5A7
	for <kexec@archiver.kernel.org>; Sat, 20 Sep 2025 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UIugca8SZaxMzP/24yjEddM7n8Al4cXmz5gSsZCJUE=; b=qPUzTqIZY4Lzag2FHCPkp9fU+9
	C8PGv0nfUeiGgDL3qboOSIUatw54hBOECQZ5N+Po3kow3IvnfL+SS0KzRpfePgSd19TGqEWz0Xs9g
	VONWNlKssjgyWgCj/ZZZpBcWaEPZyHMvYkyuu+WTxImefXTqeZNIJvN2NI2LqAYhwtTVeum2zEYW+
	LiAByKdJDYQapxqcemOiAar2HERAC+ias1iqep6l4LcnzOnSjhirMwwxFq8NeIzmRG3Axw9rifIY8
	3360GG8XjIgJz+rwgvVMtlXp1hwAHKGxaJdSGqAdUbPpqfT8Z+buzH65LhFM/j5yhCeRDIh9W0qI5
	iie/RHFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v04uE-00000005xIT-1VRm;
	Sat, 20 Sep 2025 21:14:06 +0000
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v04u8-00000005xHy-1Rx0
	for kexec@lists.infradead.org;
	Sat, 20 Sep 2025 21:14:01 +0000
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-8e261568020so935373241.1
        for <kexec@lists.infradead.org>; Sat, 20 Sep 2025 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758402839; x=1759007639; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UIugca8SZaxMzP/24yjEddM7n8Al4cXmz5gSsZCJUE=;
        b=dfXbJP+hLJr52RFMP6VXA/oFGw0nhlXUzcwJVKmgu5QNdEzi2/am2J2nZKiPlDhQRT
         jukOQ1EVFfWPU4PRm3G8IEqfgua0Qz7LxZ9NqLYAdpsBgP51C9IzGGHey++mkQfzCVvL
         IXgvcn0CNjS5cx3Mf6f/laRYQQR/nDEeFPf7H8N7y46DS9nQNK4moEdv9LjJMG5aPTh7
         1pGb2G51Hcru40TaPQlIqSqVNlwLESFnrdkHH3QaAnxBcIWzCWE1vT31ndU4TUWRDGfM
         cBtSW+lPanuOurJcPeyo9hRdqN4F3Vp2P8at/t4TJpaUdswTLB+C2ky7/dTGCaElRDcx
         JVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758402839; x=1759007639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UIugca8SZaxMzP/24yjEddM7n8Al4cXmz5gSsZCJUE=;
        b=T85qpJHSMZ4QKOgF0sDSE/AjEvxt8sh4XFMLYbbfAhKBeEyl7TFyfxhC0ZjKtyptti
         6aoZub/l8v4Hug5aRImpUh9Cy7TyNgyxKjGp8spX3bvm+2C6a4WSg2/1nRbwgDLSuyR+
         SJROeKUjBQFTCC3PJfWo5q5YYpSs2rUU2z2K9cFK4nHjgbIcBxCXobIlvZ5lueZvLjrR
         Qf/3hez5aM3og4me9rLPHE+UPw/Z3HyMiBc1sHK2kpBtcEz8Qzet05LeeDYt98Fshigs
         8w/L82dgfZxm5Qvzcyi4Fb42Uwn+xWkdFezxSyt/ZzDIYboXsOCxQTP0Y+ldDuZype60
         1FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVpBI50Q/5Totil/nLOh2OPRZs1nXS/IVVSPuK28DMKzFV5owPPOs78b8Z18VZANEBxadSvg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwvZC17zK21CNgswOv5HtSTYGINJXnC2oAfaw7DgIdeWeV1c7FL
	1oUyb4G1YLlL9D2Je/HBTQ9DbLcbjft4kOPpqo7YzZXPJa0TRg1hFpzogFzKHnVg2ZrUEdDOh8X
	5/KKX0wuhPqmA+ROqxruSp8BAGQdrBxGUkhbJ
X-Gm-Gg: ASbGnctx0Q/qLykemluV7BsnEssx6nKs/wtxtmE/GC0hAMu4AD/gFD4pu0SUijf4BaH
	EEeFoU7PdvPqDVWofYNCwQMCPX1DRR+J0XVQO29P4uKGkW3eLKKtbdw/EyVeJ+6v6UDRkzPsm0c
	tGNPcW9qRzP0m6E54mqhJkLhM71B/6NzswMpom7cWc+lkZpPfhSRyi6tXx+0RBLE2lJ0W7gOrmY
	XD800Q4/arPBY2+N3ReoYmeJRQL0nnWD/yPeJg=
X-Google-Smtp-Source: AGHT+IFvnPA4h7T1ZUVtn4JDNMPpiPFDn9Yh1yg75Ylw2qMBHo9vNQ/p0Qj34UE2hbDoZxw+1L238MnfW2TU2rGaUKs=
X-Received: by 2002:a05:6102:3e06:b0:55d:34c:f231 with SMTP id
 ada2fe7eead31-588f9cfbf36mr2475265137.35.1758402838660; Sat, 20 Sep 2025
 14:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <CA+CK2bD3D_XFu1E60qBYwdDzK0c7_bN0BkGBE7h6h_sxmmfvAQ@mail.gmail.com>
In-Reply-To: <CA+CK2bD3D_XFu1E60qBYwdDzK0c7_bN0BkGBE7h6h_sxmmfvAQ@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 20 Sep 2025 14:13:46 -0700
X-Gm-Features: AS18NWC0ac3RYhgSaViFSOyGBJe0fdwa4OEZ_zquyfPSWFlJlyPiOoaLI9mEwmY
Message-ID: <CAM_iQpWmfkB9VPdV=sCcFzUm71my1bWFL7G+QLtYGHpe3oPHAg@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_141400_400078_B2959636 
X-CRM114-Status: GOOD (  25.13  )
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

On Fri, Sep 19, 2025 at 6:14=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Thu, Sep 18, 2025 at 6:26=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
> >
> > This patch series introduces multikernel architecture support, enabling
> > multiple independent kernel instances to coexist and communicate on a
> > single physical machine. Each kernel instance can run on dedicated CPU
> > cores while sharing the underlying hardware resources.
> >
> > The multikernel architecture provides several key benefits:
> > - Improved fault isolation between different workloads
> > - Enhanced security through kernel-level separation
> > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > - Potential zero-down kernel update with KHO (Kernel Hand Over)
>
> Hi Cong,
>
> Thank you for submitting this; it is an exciting series.

Thanks for your feedback, Pasha.

>
> I experimented with this approach about five years ago for a Live
> Update scenario. It required surprisingly little work to get two OSes
> to boot simultaneously on the same x86 hardware. The procedure I

Yes, I totally agree.

> followed looked like this:
>
> 1. Create an immutable kernel image bundle: kernel + initramfs.
> 2. The first kernel is booted with memmap parameters, setting aside
> the first 1G for its own operation, the second 1G for the next kernel
> (reserved), and the rest as PMEM for the VMs.
> 3. In the first kernel, we offline one CPU and kexec the second kernel
> with parameters that specify to use only the offlined CPU as the boot
> CPU and to keep the other CPUs offline (i.e., smp_init does not start
> other CPUs). The memmap specify the first 1G reserved, and the 2nd 1G
> for its own operations, and the rest  is PMEM.
> 4. Passing the VMs worked by suspending them in the old kernel.
> 5. The other CPUs are onlined in the new kernel (thus killing the old ker=
nel).
> 6. The VMs are resumed in the new kernel.

Exactly.

>
> While this approach was easy to get to the experimental PoC, it has
> some fundamental problems that I am not sure can be solved in the long
> run, such as handling global machine states like interrupts. I think
> the Orphaned VM approach (i.e., keeping VCPUs running through the Live
> Update procedure) is more reliable and likely to succeed for
> zero-downtime kernel updates.

Indeed, migrating hardware resources gracefully is indeed challenging
for both VM or multikernel, especially when not interrupting the applicatio=
ns.
I am imagining that KHO could establish a kind of protocol between two
kernels to migrate resources. The device-tree-inspired abstraction looks
neat to me, it is pretty much like protobuf but in kernel-space.

Although I believe multikernel helps, there are still tons of details neede=
d
to consider. Therefore, I hope my proposal inspires people to think deeper
and discuss together, and hopefully come up with better ideas.

Thanks for sharing your thoughts.

