Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1481BCAC592
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4TO8ldCpCwaQtoLKPhvsFlsBIhB9gZdGySwv7zH4ykU=; b=dLRs8QWRgBBgg2VhMuINgjlEXN
	1De0Yir8HXFJmJhhqsIGpMSpqvnPO0waUHx5TNLCPpt/+PQOQ4nwGWyPvQkoubg0A/ZStNIq69DUA
	3b0DONobq3ykKtIUpyEEXIT4eo6GnELOrmd3TitefyCGQOkUZPrpImqWz1uPrRKeURKYDWewiNTtR
	VTWe61NO2MR0L/qdnaJ7KKdui6ij7lI5PF7SHztaxQVu2eYpOm3X/En5p2iaRZAvA2J3xxeMB9kr8
	K0Y5nGNcp8wOhzIGBch9E/tmGfAAbWwtv0XLfGqLNWKOeOohIkaQaKA0bJhHvohK0nP/2wa7O2XGO
	gM0RWvlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzawx-00000002xE5-0uQJ;
	Fri, 19 Sep 2025 13:14:55 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzawu-00000002xDV-3dCV
	for kexec@lists.infradead.org;
	Fri, 19 Sep 2025 13:14:54 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4b548745253so34004731cf.0
        for <kexec@lists.infradead.org>; Fri, 19 Sep 2025 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758287691; x=1758892491; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TO8ldCpCwaQtoLKPhvsFlsBIhB9gZdGySwv7zH4ykU=;
        b=I/AimJY0FhiiTNH1dupakPEj1xS5+svOOfVoIgmnPQw96zNR7lqBi75IFicDsd8nML
         wbNR6b7mIfjyLY6RLQN4kWR0iZbjNoRA2qjWFHQKrPppBODi21KsaQ9dVnxtZ3eizqsD
         5+Ur7SjrtQyh1JZulwcBgJeaAwFWJk7vFSxgepg9CJhjv7wonqyxG4zg5ne4gx1nlWBe
         HXp+1gN2izp9hlzPXwo2mOdRW+bh4O29leMoeN0faaKsUQSVYppvxDpZN5pifwgmukv+
         Q7mrpMvQCapcJuu2DUR43kQz2RAYqcmjVU0AQumsIiCzD3Y06Ws26o1AVNsSYbAJT1zA
         pUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287691; x=1758892491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TO8ldCpCwaQtoLKPhvsFlsBIhB9gZdGySwv7zH4ykU=;
        b=A6TiSeF+XK9vJ3s23WDAT3nv1HzXTdNG03POqHhKr1ABzcJ/tpYWwJ1/J5RM3Q+BHA
         /PafP+wiHZmfjqvCiyxnoT5Alb9uufM9d/nxjljrUjERL1lRcCwmZTNYRd8TrFii3pyb
         NL/nxzORaqmq0TKIPUIbrF71OAGVP5NXiBTjXg4zLdcJyBaHv1JPFnMmxaRSBg0FTguP
         TTXzXCCxDhySZxKK6kGv0bma59JK0EPGOMOWn1zqM/Nk4sjJtISTI0JeF10kNlCNDKGk
         lzNAvtO52VoatyKLRpfK7I2eAqfBt41yOVeLDQtRLJ9cp7YlNhObZC31mTtaXnfnGlzV
         kbGw==
X-Forwarded-Encrypted: i=1; AJvYcCUvVe+FKf47q7jpiw6IssjvGvz/MSzO9cNF3R9oCBCVE18l8jabuBH2rQ4aJRMWRJ9k0Z6a0A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyPOJJy3/V4mkhVBwS77Iw2IUN5oQG3ZUW+70/U8d6tx8tUAiRE
	i0jwmd++d+2LNDyYnTHnhH63bmllCVP3uF7NJKl4TTk/8lHNFuYA03DW0LlUfWF60kIHT1b756N
	zhRolZQHxq0PCP7N7iqPzuDDBpX/IVLlNg29N/gR/VA==
X-Gm-Gg: ASbGncucPkR9QHEpCmEcDlxWLRzu2qIU4FDszxuUaMjfTte5/yFWjBYExXcsu7jn8f5
	vHjappbUkoJjZEj1njJlhQsXTdkblJRe+pFCpelNUo48zhAVMlJB1dzgIDJSVQVXpJP57s30RXw
	5V9culWJFO7uoIxiP0FU3vFeqppCVukPeC0k7L21eeCywJKUn4ZqfMdPpe1/ZqPxXD4Gdh0FrEq
	HwQ
X-Google-Smtp-Source: AGHT+IFP5OPPTxwZ8V54f9/k+r549Cc9+2zxQm2wZ1tAr4n+kgl+fwpljr133j453kMoly6d472Qfg2qfJWHUKMsWzY=
X-Received: by 2002:a05:622a:1a02:b0:4b5:da5f:d9b7 with SMTP id
 d75a77b69052e-4c073ab0dd8mr34737991cf.78.1758287690916; Fri, 19 Sep 2025
 06:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 19 Sep 2025 09:14:12 -0400
X-Gm-Features: AS18NWCzyLEt0N2rB1CWsx_n5vr6VC5G7l3ExS6vuWkIq3v8_7YkqfncY9X_FkM
Message-ID: <CA+CK2bD3D_XFu1E60qBYwdDzK0c7_bN0BkGBE7h6h_sxmmfvAQ@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_061453_042795_78EB7720 
X-CRM114-Status: GOOD (  30.86  )
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

On Thu, Sep 18, 2025 at 6:26=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> This patch series introduces multikernel architecture support, enabling
> multiple independent kernel instances to coexist and communicate on a
> single physical machine. Each kernel instance can run on dedicated CPU
> cores while sharing the underlying hardware resources.
>
> The multikernel architecture provides several key benefits:
> - Improved fault isolation between different workloads
> - Enhanced security through kernel-level separation
> - Better resource utilization than traditional VM (KVM, Xen etc.)
> - Potential zero-down kernel update with KHO (Kernel Hand Over)

Hi Cong,

Thank you for submitting this; it is an exciting series.

I experimented with this approach about five years ago for a Live
Update scenario. It required surprisingly little work to get two OSes
to boot simultaneously on the same x86 hardware. The procedure I
followed looked like this:

1. Create an immutable kernel image bundle: kernel + initramfs.
2. The first kernel is booted with memmap parameters, setting aside
the first 1G for its own operation, the second 1G for the next kernel
(reserved), and the rest as PMEM for the VMs.
3. In the first kernel, we offline one CPU and kexec the second kernel
with parameters that specify to use only the offlined CPU as the boot
CPU and to keep the other CPUs offline (i.e., smp_init does not start
other CPUs). The memmap specify the first 1G reserved, and the 2nd 1G
for its own operations, and the rest  is PMEM.
4. Passing the VMs worked by suspending them in the old kernel.
5. The other CPUs are onlined in the new kernel (thus killing the old kerne=
l).
6. The VMs are resumed in the new kernel.

While this approach was easy to get to the experimental PoC, it has
some fundamental problems that I am not sure can be solved in the long
run, such as handling global machine states like interrupts. I think
the Orphaned VM approach (i.e., keeping VCPUs running through the Live
Update procedure) is more reliable and likely to succeed for
zero-downtime kernel updates.

Pasha

>
> Architecture Overview:
> The implementation leverages kexec infrastructure to load and manage
> multiple kernel images, with each kernel instance assigned to specific
> CPU cores. Inter-kernel communication is facilitated through a dedicated
> IPI framework that allows kernels to coordinate and share information
> when necessary.
>
> Key Components:
> 1. Enhanced kexec subsystem with dynamic kimage tracking
> 2. Generic IPI communication framework for inter-kernel messaging
> 3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
> 4. Proc interface for monitoring loaded kernel instances
>
> Patch Summary:
>
> Patch 1/7: Introduces basic multikernel support via kexec, allowing
>            multiple kernel images to be loaded simultaneously.
>
> Patch 2/7: Adds x86-specific SMP INIT trampoline for bootstrapping
>            CPUs with different kernel instances.
>
> Patch 3/7: Introduces dedicated MULTIKERNEL_VECTOR for x86 inter-kernel
>            communication.
>
> Patch 4/7: Implements generic multikernel IPI communication framework
>            for cross-kernel messaging and coordination.
>
> Patch 5/7: Adds arch_cpu_physical_id() function to obtain physical CPU
>            identifiers for proper CPU management.
>
> Patch 6/7: Replaces static kimage globals with dynamic linked list
>            infrastructure to support multiple kernel images.
>
> Patch 7/7: Adds /proc/multikernel interface for monitoring and debugging
>            loaded kernel instances.
>
> The implementation maintains full backward compatibility with existing
> kexec functionality while adding the new multikernel capabilities.
>
> IMPORTANT NOTES:
>
> 1) This is a Request for Comments (RFC) submission. While the core
>    architecture is functional, there are numerous implementation details
>    that need improvement. The primary goal is to gather feedback on the
>    high-level design and overall approach rather than focus on specific
>    coding details at this stage.
>
> 2) This patch series represents only the foundational framework for
>    multikernel support. It establishes the basic infrastructure and
>    communication mechanisms. We welcome the community to build upon
>    this foundation and develop their own solutions based on this
>    framework.
>
> 3) Testing has been limited to the author's development machine using
>    hard-coded boot parameters and specific hardware configurations.
>    Community testing across different hardware platforms, configurations,
>    and use cases would be greatly appreciated to identify potential
>    issues and improve robustness. Obviously, don't use this code beyond
>    testing.
>
> This work enables new use cases such as running real-time kernels
> alongside general-purpose kernels, isolating security-critical
> applications, and providing dedicated kernel instances for specific
> workloads etc..
>
> Signed-off-by: Cong Wang <cwang@multikernel.io>
>
> ---
>
> Cong Wang (7):
>   kexec: Introduce multikernel support via kexec
>   x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
>   x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
>   kernel: Introduce generic multikernel IPI communication framework
>   x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
>   kexec: Implement dynamic kimage tracking
>   kexec: Add /proc/multikernel interface for kimage tracking
>
>  arch/powerpc/kexec/crash.c          |   8 +-
>  arch/x86/include/asm/idtentry.h     |   1 +
>  arch/x86/include/asm/irq_vectors.h  |   1 +
>  arch/x86/include/asm/smp.h          |   7 +
>  arch/x86/kernel/Makefile            |   1 +
>  arch/x86/kernel/crash.c             |   4 +-
>  arch/x86/kernel/head64.c            |   5 +
>  arch/x86/kernel/idt.c               |   1 +
>  arch/x86/kernel/setup.c             |   3 +
>  arch/x86/kernel/smp.c               |  15 ++
>  arch/x86/kernel/smpboot.c           | 161 +++++++++++++
>  arch/x86/kernel/trampoline_64_bsp.S | 288 ++++++++++++++++++++++
>  arch/x86/kernel/vmlinux.lds.S       |   6 +
>  include/linux/kexec.h               |  22 +-
>  include/linux/multikernel.h         |  81 +++++++
>  include/uapi/linux/kexec.h          |   1 +
>  include/uapi/linux/reboot.h         |   2 +-
>  init/main.c                         |   2 +
>  kernel/Makefile                     |   2 +-
>  kernel/kexec.c                      | 103 +++++++-
>  kernel/kexec_core.c                 | 359 ++++++++++++++++++++++++++++
>  kernel/kexec_file.c                 |  33 ++-
>  kernel/multikernel.c                | 314 ++++++++++++++++++++++++
>  kernel/reboot.c                     |  10 +
>  24 files changed, 1411 insertions(+), 19 deletions(-)
>  create mode 100644 arch/x86/kernel/trampoline_64_bsp.S
>  create mode 100644 include/linux/multikernel.h
>  create mode 100644 kernel/multikernel.c
>
> --
> 2.34.1
>

