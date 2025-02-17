Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284DCC021A6
	for <kexec@archiver.kernel.org>; Mon, 17 Feb 2025 03:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EgbKbeBQm7lkao3p6uQLBUr3dfHH6Bslim0jMF3gJaE=; b=DeLdV4dzv7SatOqfSNg4iJU1hv
	w6mAA7V7oiYgnz1INIvca+2w1Sq/su+vzaOkASPpxsGk45vNfjH53Up0/Qg4RYiI1DFLf3EbEnJF5
	IlLWbWxooVSZ0TAL1LJbqegxxQ0MXUSJrq5GPuFRYgAIGiyRP1519XVQhwxA4xeKLBQlbCIcKEy7q
	kk/GgBAUzdJazrTr7MOVK1rAlDIljRXyAE703ck+Sl9AfbYRKI7rN/r8zNCqSsXLvna+3qh+6g9KJ
	KJL1JuJ06b2CITMZRpvZ5sQ5ARTDOqRQL8xTdSXvw3O2V6CYd6wV6WYDKmdS2hipfl7OqmQKPINRl
	XxaDwD7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjrfX-000000037el-2ALn;
	Mon, 17 Feb 2025 03:19:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjrfU-000000037dQ-2ygI
	for kexec@lists.infradead.org;
	Mon, 17 Feb 2025 03:19:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739762374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgbKbeBQm7lkao3p6uQLBUr3dfHH6Bslim0jMF3gJaE=;
	b=cKYSpcVN82Li331bz/K+rHyBcOloznPdKoFJgT4dzMmb698dPOFAKA+nYc0UhSc9+UCDdL
	14ns5WcCqpQ48V74GuUeEzpok0upG8tTzBuAdCKgUWIhv+CSDA+uVcJnIWGRiIjcXPb540
	9QoIb9+iIiXGtPEsAHGdFa+kxnma7eM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-iLVR2JlXO1elUk-Kvnl_xg-1; Sun, 16 Feb 2025 22:19:32 -0500
X-MC-Unique: iLVR2JlXO1elUk-Kvnl_xg-1
X-Mimecast-MFC-AGG-ID: iLVR2JlXO1elUk-Kvnl_xg_1739762372
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so74970595ab.0
        for <kexec@lists.infradead.org>; Sun, 16 Feb 2025 19:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739762372; x=1740367172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgbKbeBQm7lkao3p6uQLBUr3dfHH6Bslim0jMF3gJaE=;
        b=VE5eZuVJ32vuIMPgf26edMxcZrUBL+FlRScdBDQ1eokQKq8rNYCZQg3z8w/Horkxiv
         9GX31IfoSAlFqMRlB351i/3zG3X0FvpKQGIiNvEdofbuZcuw3mWVjlbC63ZdY6ZYzlvk
         j0R0ap5HZAiGlJZ8BCKPAR8DRMm14xfa/wrsgh48bUVYUzgYK7PrO9vi+y9sBtCh8HR8
         AbgZZCLL9uwZIUpk86FljRifQZXnN8xmBhzuJChpqpozgU5VXWT/dlKGNafTkQ1dRBDU
         NEJMD7z/fi7acA3czMCwg5MMVNn/rPGyKQQP84gm+SkyUiC6Pj1LtP53Aq8/AMJdUfw/
         93XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHnoDZzIQJDmq8TrNRl/ISLCkWhKmwQwwgDAl9jog86SIRPuekaP6EtOR2alhtcPL51ydmDA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0j1A3/2uijUksVunONcdZZ5xuvt6V6jURxPtMItXmUnphcwF4
	BD9gJJLD6TyXzHKGcOc2yM68L/zjautFM89ZqHNTTXJb76obvNjGZH9IWDoI2olnLpJvjxJTB/f
	nw1Aowrgt+YPfhb+Ea1U7PfZHD+G42rBEoU7uM6JiProOH0GGDhnWRvRp3j6p9QK3CD4TkTU9t0
	skO/tWl2VVlArRi7L4/CRcqz3GAvY95T5J
X-Gm-Gg: ASbGnctttDJiexSFOOf3VsmXECepMT+S6L4c5fr0YgIZRvR/bWsBRSV+ewEzBGv6QU3
	JiLVhapYG84hcaanTtnc2dM7AUK+DCuhVSkSRUgmZ6f4zTOlkWbkNjtrigOnVHbw=
X-Received: by 2002:a05:6e02:1b09:b0:3d0:fe8:607e with SMTP id e9e14a558f8ab-3d280940c9bmr64357355ab.14.1739762371858;
        Sun, 16 Feb 2025 19:19:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLJ+sakoWDc92vC5PVdrAPLBDgA51ioqiveqE/kVlhzpNtt+A2nTfHDcNxz2e0uNeHln7kmPyQMRXuDBPUaYI=
X-Received: by 2002:a05:6e02:1b09:b0:3d0:fe8:607e with SMTP id
 e9e14a558f8ab-3d280940c9bmr64357085ab.14.1739762371480; Sun, 16 Feb 2025
 19:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org>
In-Reply-To: <20250206132754.2596694-1-rppt@kernel.org>
From: RuiRui Yang <ruyang@redhat.com>
Date: Mon, 17 Feb 2025 11:19:45 +0800
X-Gm-Features: AWEUYZmTtRGOQe_1FWRhP6QKOKg6j7aVMk1lhIeHe6H83IiAgYz-eSDseytmTwE
Message-ID: <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l16lUG-5yoRtytE2rKcxUFEjdKld7AxlAmsNao1yl4U_1739762372
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_191936_828077_B467358B 
X-CRM114-Status: GOOD (  38.45  )
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

On Thu, 6 Feb 2025 at 21:34, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> This a next version of Alex's "kexec: Allow preservation of ftrace buffers"
> series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com),
> just to make things simpler instead of ftrace we decided to preserve
> "reserve_mem" regions.
>
> The patches are also available in git:
> https://git.kernel.org/rppt/h/kho/v4
>
>
> Kexec today considers itself purely a boot loader: When we enter the new
> kernel, any state the previous kernel left behind is irrelevant and the
> new kernel reinitializes the system.
>
> However, there are use cases where this mode of operation is not what we
> actually want. In virtualization hosts for example, we want to use kexec
> to update the host kernel while virtual machine memory stays untouched.
> When we add device assignment to the mix, we also need to ensure that
> IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
> need to do the same for the PCI subsystem. If we want to kexec while an
> SEV-SNP enabled virtual machine is running, we need to preserve the VM
> context pages and physical memory. See "pkernfs: Persisting guest memory
> and kernel/device state safely across kexec" Linux Plumbers
> Conference 2023 presentation for details:
>
>   https://lpc.events/event/17/contributions/1485/
>
> To start us on the journey to support all the use cases above, this patch
> implements basic infrastructure to allow hand over of kernel state across
> kexec (Kexec HandOver, aka KHO). As a really simple example target, we use
> memblock's reserve_mem.
> With this patch set applied, memory that was reserved using "reserve_mem"
> command line options remains intact after kexec and it is guaranteed to
> reside at the same physical address.
>
> == Alternatives ==
>
> There are alternative approaches to (parts of) the problems above:
>
>   * Memory Pools [1] - preallocated persistent memory region + allocator
>   * PRMEM [2] - resizable persistent memory regions with fixed metadata
>                 pointer on the kernel command line + allocator
>   * Pkernfs [3] - preallocated file system for in-kernel data with fixed
>                   address location on the kernel command line
>   * PKRAM [4] - handover of user space pages using a fixed metadata page
>                 specified via command line
>
> All of the approaches above fundamentally have the same problem: They
> require the administrator to explicitly carve out a physical memory
> location because they have no mechanism outside of the kernel command
> line to pass data (including memory reservations) between kexec'ing
> kernels.
>
> KHO provides that base foundation. We will determine later whether we
> still need any of the approaches above for fast bulk memory handover of for
> example IOMMU page tables. But IMHO they would all be users of KHO, with
> KHO providing the foundational primitive to pass metadata and bulk memory
> reservations as well as provide easy versioning for data.
>
> == Overview ==
>
> We introduce a metadata file that the kernels pass between each other. How
> they pass it is architecture specific. The file's format is a Flattened
> Device Tree (fdt) which has a generator and parser already included in
> Linux. When the root user enables KHO through /sys/kernel/kho/active, the
> kernel invokes callbacks to every driver that supports KHO to serialize
> its state. When the actual kexec happens, the fdt is part of the image
> set that we boot into. In addition, we keep a "scratch regions" available
> for kexec: A physically contiguous memory regions that is guaranteed to
> not have any memory that KHO would preserve.  The new kernel bootstraps
> itself using the scratch regions and sets all handed over memory as in use.
> When drivers initialize that support KHO, they introspect the fdt and
> recover their state from it. This includes memory reservations, where the
> driver can either discard or claim reservations.
>
> == Limitations ==
>
> Currently KHO is only implemented for file based kexec. The kernel
> interfaces in the patch set are already in place to support user space
> kexec as well, but it is still not implemented it yet inside kexec tools.
>

What architecture exactly does this KHO work fine?   Device Tree
should be ok on arm*, x86 and power*, but how about s390?

Thanks
Dae


