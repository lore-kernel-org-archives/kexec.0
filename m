Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2291E82CAF
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0KW75Pu6fZFxbNAPHfEq+ESoTAcUkWPjFhZ1bp0w8Z4=; b=1adUTrO6Cscbsz
	LC6gL3hXJX7JgMSV2imVlZ8XNiwsvJGvPui9bD1/1I5ejkMwYPq5VSe8QE0SCn3PNxtRJT4FJRqZ3
	dFVz32dxTjGJCa/vGY/hUMZ7iw2HXuv86tR9+5xGmy2YMWnSReIbZSVo546p1TtBPIXwgZD7nM56A
	3IM34MlDReYc7egHm/hzs+Ah0wEZ5+YafkznZwjzW+xuWDMMtrsH0oPRIUbm9ADGEJ/0bepCPCFX9
	y82F58aheq25IYoboWEhQtsbvyKp/DNqYFfWhX6t8g39dKyE5gU1HBLgQF45dgH9h2QXwg4TYD1Kj
	IoLEfb5ABUqzCITFRYgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlXAK-001PXK-2v;
	Wed, 27 Sep 2023 16:13:32 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlXAH-001PWQ-2w
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 16:13:31 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id E95A220B74C0;
	Wed, 27 Sep 2023 09:13:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E95A220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695831206;
	bh=Zfxd0XgnyX3RnoanlPmdbDw6VIWPa59+GnWOWvgjd7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJmfWGCC04I1cFG6G//N3/op/ZdDaRZ/V8tE7Rr5tNosAHurBYGvK9gAVY7wsH+YV
	 817KbQrSY14dkvttUvE6RTaH0cDSkVbITUSAFdXq56WBPNvBm97oouuO5gCDDyL/tZ
	 xCv4kPbeRm2sGZ6XevpjlMb5j41oYogyDQOAAeh0=
Date: Wed, 27 Sep 2023 09:13:19 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Baoquan He <bhe@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <20230927161319.GA19976@skinsburskii.>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_091330_019144_0BC3072D 
X-CRM114-Status: GOOD (  36.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Sep 27, 2023 at 01:44:38PM +0800, Baoquan He wrote:
> Hi Stanislav,
> 
> On 09/25/23 at 02:27pm, Stanislav Kinsburskii wrote:
> > This patch introduces a memory allocator specifically tailored for
> > persistent memory within the kernel. The allocator maintains
> > kernel-specific states like DMA passthrough device states, IOMMU state, and
> > more across kexec.
> 
> Can you give more details about how this persistent memory pool will be
> utilized in a actual scenario? I mean, what problem have you met so that
> you have to introduce persistent memory pool to solve it?
> 

The major reason we have at the moment, is that Linux root partition
running on top of the Microsoft hypervisor needs to deposit pages to
hypervisor in runtime, when hypervisor runs out of memory.
"Depositing" here means, that Linux passes a set of its PFNs to the
hypervisor via hypercall, and hypervisor then uses these pages for its
own needs.

Once deposited, these pages can't be accessed by Linux anymore and thus
must be preserved in "used" state across kexec, as hypervisor state is
unware of kexec. In the same time, these pages can we withdrawn when
usused. Thus, an allocator persistent across kexec looks reasonable for
this particular matter.

Also, the last patch in the series is aimed to demonstrate the usage,
described above.

Thanks,
Stanislav

> Thanks
> Baoquan
> 
> > 
> > The current implementation provides a foundation for custom solutions that
> > may be developed in the future. Although the design is kept concise and
> > straightforward to encourage discussion and feedback, it remains fully
> > functional.
> > 
> > The persistent memory pool builds upon the continuous memory allocator
> > (CMA) and ensures CMA state persistency across kexec by incorporating the
> > CMA bitmap into the memory region instead of allocation it from kernel
> > memory.
> > 
> > Persistent memory pool metadata is passed across kexec by using Flattened
> > Device Tree, which is added as another kexec segment for x86 architecture.
> > 
> > Potential applications include:
> > 
> >   1. Enabling various in-kernel entities to allocate persistent pages from
> >      a unified memory pool, obviating the need for reserving multiple
> >      regions.
> > 
> >   2. For in-kernel components that need the allocation address to be
> >      retained on kernel kexec, this address can be exposed to user space
> >      and subsequently passed through the command line.
> > 
> >   3. Distinct subsystems or drivers can set aside their region, allocating
> >      a segment for their persistent memory pool, suitable for uses such as
> >      file systems, key-value stores, and other applications.
> > 
> > Notes:
> > 
> >   1. The last patch of the series represents a use case for the feature.
> >      However, the patch won't compile and is for illustrative purposes only
> >      as the code being patched hasn't been merged yet.
> > 
> >   2. The code being patched is currently under review by the community. The
> >      series is named "Introduce /dev/mshv drivers":
> > 
> >          https://lkml.org/lkml/2023/9/22/1117
> > 
> > 
> > Changes since v1:
> > 
> >   1. Persistent memory pool is now a wrapper on top of CMA instead of being a
> >      new allocator.
> > 
> >   2. Persistent memory pool metadata doesn't belong to the pool anymore and
> >      is now passed via Flattened Device Tree instead over kexec to the new
> >      kernel.
> > 
> > The following series implements...
> > 
> > ---
> > 
> > Stanislav Kinsburskii (7):
> >       kexec_file: Add fdt modification callback support
> >       x86: kexec: Transfer existing fdt to the new kernel
> >       x86: kexec: Enable fdt modification in callbacks
> >       pmpool: Introduce persistent memory pool
> >       pmpool: Update device tree on kexec
> >       pmpool: Restore state from device tree post-kexec
> >       Drivers: hv: Allocate persistent pages for root partition
> > 
> > 
> >  arch/x86/Kconfig                  |   16 +++
> >  arch/x86/kernel/kexec-bzimage64.c |   97 +++++++++++++++++
> >  drivers/hv/hv_common.c            |   13 ++
> >  include/linux/kexec.h             |    7 +
> >  include/linux/pmpool.h            |   22 ++++
> >  kernel/kexec_file.c               |   24 ++++
> >  mm/Kconfig                        |    9 ++
> >  mm/Makefile                       |    1 
> >  mm/pmpool.c                       |  208 +++++++++++++++++++++++++++++++++++++
> >  9 files changed, 394 insertions(+), 3 deletions(-)
> >  create mode 100644 include/linux/pmpool.h
> >  create mode 100644 mm/pmpool.c
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
