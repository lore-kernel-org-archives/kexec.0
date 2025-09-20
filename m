Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B22CAC5A7
	for <kexec@archiver.kernel.org>; Sat, 20 Sep 2025 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8q2wF8NyUMzUdcB4wo27NEUbPU4EJ5KlqSNJI4hsQkI=; b=NOPd+c+7XS4NRocAvDjv3pAUwO
	9pLyYRYQRjU0n39nBib5GSGY0L4nHIcPSKrf9p1mPh2kvW6Pg1qVgSTMmCjLV8xDt8D8MR0Jnz3fQ
	/h01RBkxDK0PokgaTwTCztFaHPSLN0Zg9HpCH6VPmLtYXdy1ROPfwM4PWc4LwzXQ+jgerc4O9tsZC
	IDctCbFPPLtDi22rLmisLBoRANp+ASskBu912GpUWReA5INBzlOFGmR53VD86FKGMVrigQ2rwhSGN
	uvOu467olmAtVJC0Ok3YO4QiE4I1JrSVxZiDo5WYFxeRAyxaMvYL3EZ/RSf6M6WbegqZOSdxM6bR5
	RWKzZO1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v05Jq-00000005yUj-1mzZ;
	Sat, 20 Sep 2025 21:40:34 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v05Jm-00000005yUH-3cNH
	for kexec@lists.infradead.org;
	Sat, 20 Sep 2025 21:40:32 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-8b32453d838so2273257241.2
        for <kexec@lists.infradead.org>; Sat, 20 Sep 2025 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758404430; x=1759009230; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q2wF8NyUMzUdcB4wo27NEUbPU4EJ5KlqSNJI4hsQkI=;
        b=Z12ljRWTfu52IV70ZAoCaTnt7ox/9GkcHfW7ygJ+f3WCMZQUIa/ItxhzLMJMa9GTyt
         gMBrrnO6ElxvCg4HBY+u4qjAH8cP8JJiXOD4abZmd6c98mwcVLnu+lslRKXPEPY1KRsN
         Bu2cOzbJOtJjGn0T9OUd/Rau1Fu4VpAOMGH/DM1G+5n2AWdz3sheGk9jAgUraExYAudl
         O2ZjT2Ixs/kEYgXz//YACiASiEPm1csACANnpTSZYF5FFWaDZG3jlUqegWKLr/Lay2sY
         GJZIHcWan5FAVqk06pjBqeSHOH9nkV9PZlVW+EqXFfyEycTfzwm9dYEYq9MK1cyGFQVP
         VBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758404430; x=1759009230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q2wF8NyUMzUdcB4wo27NEUbPU4EJ5KlqSNJI4hsQkI=;
        b=chVUbLi8PvYr5ckwWuTO0JBmw0fRmnrNI8BXltv9S7SPzWzUlZCqczA2hXU8b0OnRq
         P5+IGa0C6xHJoyLxS++T9VHmoGkqtHENK9u29n0YaihvPbugvLXcchOkRIT+ZHqEENoc
         jAcnHS6JXT0MIBSq4s3RNE1S2cJZBs37RJUe3UpGdMDagN8JMFEpu8j+3/Z21r0s/DU5
         mA9D+nd7T0hIAimGcKo72ClzXBgzcOegIgraX5vmlG84/sbVN54wzl1WUDrbPAZW0SEK
         9c9me3WWxNIUw9Lg8tOsjwCn6iNtDtO8oAINvhwT7BAZGNGSA4eJAG1LQ85068qsf5Ao
         NWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgJhyK0lyUT132HNUSctOeCmLbIAJjSHGcHrS2EpG9zctm+lAhjGu/MTnfRjHRpgyi1mpgzg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJneMtuP43uDgj4QpIGssBNC3znW9fLuY0dEOd30rTR4m0svOA
	MDNnFvSoepGwduZ/dR0eCf8MKIb2MSGqAGkt3hXM7ZArRchlRdSkWwPCFt3E324umAT33TGj1HU
	am4X6wzCUfAJx1x1kbd91RRRBJlkx0a4=
X-Gm-Gg: ASbGnctTwpw1tQKa+i0RSXCyFSvrWpS9J3fcGgO5WmiNSrbdWbrHDxQ08zvQ2MD8zaK
	fokHjBbcCU0Pf8W3BvtJmSEzMnFyFM97PLnB2/tSobyM1dm7rXtSmKSVpzXJrFKDbt0qR1Pmimb
	GoKCxOuGMx2B9OVjMie5jb2+Y3pAo0EhRB4zBnyWwXg7QDI6+6MlBFO4Cz0B4WzxDXnP1YcKw6A
	Mhouwx1Mm8i2qCkgrMCnivFjtRTn8D7aG2wK5M=
X-Google-Smtp-Source: AGHT+IHqnAFDkW9PsCMR9JtuaTJ8E+X1B8qYgA1fXLCBophwWpFMTYWf4IrHqUGDtieqxBjWDIPn4UeSEn1c9B0z+lQ=
X-Received: by 2002:a05:6102:c0b:b0:4fa:25a2:5804 with SMTP id
 ada2fe7eead31-588dada35dfmr2845718137.10.1758404429683; Sat, 20 Sep 2025
 14:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <20250919212650.GA275426@fedora>
In-Reply-To: <20250919212650.GA275426@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 20 Sep 2025 14:40:18 -0700
X-Gm-Features: AS18NWCv9lp8HiEvE89FhMeXwqiYRCfEXvgC7JXXJLUd4dVtbVWEBLn_j1OZgfI
Message-ID: <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_144030_920860_D40C9736 
X-CRM114-Status: GOOD (  31.57  )
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

On Fri, Sep 19, 2025 at 2:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > This patch series introduces multikernel architecture support, enabling
> > multiple independent kernel instances to coexist and communicate on a
> > single physical machine. Each kernel instance can run on dedicated CPU
> > cores while sharing the underlying hardware resources.
> >
> > The multikernel architecture provides several key benefits:
> > - Improved fault isolation between different workloads
> > - Enhanced security through kernel-level separation
>
> What level of isolation does this patch series provide? What stops
> kernel A from accessing kernel B's memory pages, sending interrupts to
> its CPUs, etc?

It is kernel-enforced isolation, therefore, the trust model here is still
based on kernel. Hence, a malicious kernel would be able to disrupt,
as you described. With memory encryption and IPI filtering, I think
that is solvable.

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
> > 3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
> > 4. Proc interface for monitoring loaded kernel instances
> >
> > Patch Summary:
> >
> > Patch 1/7: Introduces basic multikernel support via kexec, allowing
> >            multiple kernel images to be loaded simultaneously.
> >
> > Patch 2/7: Adds x86-specific SMP INIT trampoline for bootstrapping
> >            CPUs with different kernel instances.
> >
> > Patch 3/7: Introduces dedicated MULTIKERNEL_VECTOR for x86 inter-kernel
> >            communication.
> >
> > Patch 4/7: Implements generic multikernel IPI communication framework
> >            for cross-kernel messaging and coordination.
> >
> > Patch 5/7: Adds arch_cpu_physical_id() function to obtain physical CPU
> >            identifiers for proper CPU management.
> >
> > Patch 6/7: Replaces static kimage globals with dynamic linked list
> >            infrastructure to support multiple kernel images.
> >
> > Patch 7/7: Adds /proc/multikernel interface for monitoring and debuggin=
g
> >            loaded kernel instances.
> >
> > The implementation maintains full backward compatibility with existing
> > kexec functionality while adding the new multikernel capabilities.
> >
> > IMPORTANT NOTES:
> >
> > 1) This is a Request for Comments (RFC) submission. While the core
> >    architecture is functional, there are numerous implementation detail=
s
> >    that need improvement. The primary goal is to gather feedback on the
> >    high-level design and overall approach rather than focus on specific
> >    coding details at this stage.
> >
> > 2) This patch series represents only the foundational framework for
> >    multikernel support. It establishes the basic infrastructure and
> >    communication mechanisms. We welcome the community to build upon
> >    this foundation and develop their own solutions based on this
> >    framework.
> >
> > 3) Testing has been limited to the author's development machine using
> >    hard-coded boot parameters and specific hardware configurations.
> >    Community testing across different hardware platforms, configuration=
s,
> >    and use cases would be greatly appreciated to identify potential
> >    issues and improve robustness. Obviously, don't use this code beyond
> >    testing.
> >
> > This work enables new use cases such as running real-time kernels
> > alongside general-purpose kernels, isolating security-critical
> > applications, and providing dedicated kernel instances for specific
> > workloads etc..
>
> This reminds me of Jailhouse, a partitioning hypervisor for Linux.
> Jailhouse uses virtualization and other techniques to isolate CPUs,
> allowing real-time workloads to run alongside Linux:
> https://github.com/siemens/jailhouse
>
> It would be interesting to hear your thoughts about where you want to go
> with this series and how it compares with a partitioning hypervisor like
> Jailhouse.

Good question. A few people pointed me to Jailhouse before. If I understand
correctly, it is still based on hardware virtualization like IOMMU and VMX.
The goal of multikernel is to completely avoid hw virtualization
and without a hypervisor. Of course, this also depends on how we define
hypervisor here: If it is a user-space one like Qemu, this is exactly what
multikernel tries to avoid; or if it is just a broadly "supervisor",
it still exists
in the kernel (unlike Qemu).

This is why I tend to use "host kernel" and "spawned kernel" to distinguish
them, instead of using "hypervisor" and "guest", which easily confuse
people with  virtualization.

Speaking of virtualization, there are some other technologies like
DirectVisor or De-virt. In my humble opinion, they are going the wrong
way as apparently virt + de-virt =3D no virt. Why even bother virt? ;-p

I hope this answers your questions,

Regards,
Cong

