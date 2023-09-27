Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F09E80A93
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R9SF6dpVvkqPtyEkVLLC8BFZvUiU9MM4/WslGe/g8Dw=; b=FKh+1WFUw1LBXi
	0VK4LxdTy1qezqNBmLb141+Y74DY7hpfdOd9pU1PHSQbcQxJSIDOBXJHn0wCDUIYtCPJstLzX66eZ
	9h4fi+OlXS63fkEkYUFIEipnIDzBVikLEVRPp4uXbA0g2WTGljbjOJXOXYzD+AW+9HAVVJiW79Jqx
	T7Ohmi0ygcoh/lWwUEJ/MEN7MN0H7IhLJIWwTMnmbN6V2SPjKUNsfYuTYK44vRSuS3WxxW9oODZ6Z
	gg5kvSiQnbP4ULYoyOqQHNdIQZpqnU+4xOnFccMniCo0Ap00bgGRjbkBI2F2I7xTSuyoCZ5QD3qUa
	jkXMmfyZ07fNhNLxurBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlOIY-0007Oc-0R;
	Wed, 27 Sep 2023 06:45:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlNLs-0001aP-1I
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 05:44:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695793486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXF3ES7XN1Pl7q/U2YCy77+dCD8e5lolOS847DdNDAY=;
	b=QPMghQ5C5th5DgD/x+UBQb5tAro1SIZl1vHKuQwSt41Dc8SsqfoDiXww7ysggi+z67nT7i
	km4Zk6YtsjBgfR9OyA0wyDTLfkWJ/gs7cXEWjQN+7BY7rstFx+PM9qROmwwBxAFqD77+lS
	VCtHIDFzySRx5LKyaUyT5FptVZu3taE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-O_z9u9y5N2y72j6BNqnfEQ-1; Wed, 27 Sep 2023 01:44:44 -0400
X-MC-Unique: O_z9u9y5N2y72j6BNqnfEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992B085A5BE;
	Wed, 27 Sep 2023 05:44:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 76FA12026D4B;
	Wed, 27 Sep 2023 05:44:41 +0000 (UTC)
Date: Wed, 27 Sep 2023 13:44:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ebiederm@xmission.com, akpm@linux-foundation.org,
	stanislav.kinsburskii@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
	wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	graf@amazon.de, pbonzini@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_224448_531776_0FF82559 
X-CRM114-Status: GOOD (  29.18  )
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

Hi Stanislav,

On 09/25/23 at 02:27pm, Stanislav Kinsburskii wrote:
> This patch introduces a memory allocator specifically tailored for
> persistent memory within the kernel. The allocator maintains
> kernel-specific states like DMA passthrough device states, IOMMU state, and
> more across kexec.

Can you give more details about how this persistent memory pool will be
utilized in a actual scenario? I mean, what problem have you met so that
you have to introduce persistent memory pool to solve it?

Thanks
Baoquan

> 
> The current implementation provides a foundation for custom solutions that
> may be developed in the future. Although the design is kept concise and
> straightforward to encourage discussion and feedback, it remains fully
> functional.
> 
> The persistent memory pool builds upon the continuous memory allocator
> (CMA) and ensures CMA state persistency across kexec by incorporating the
> CMA bitmap into the memory region instead of allocation it from kernel
> memory.
> 
> Persistent memory pool metadata is passed across kexec by using Flattened
> Device Tree, which is added as another kexec segment for x86 architecture.
> 
> Potential applications include:
> 
>   1. Enabling various in-kernel entities to allocate persistent pages from
>      a unified memory pool, obviating the need for reserving multiple
>      regions.
> 
>   2. For in-kernel components that need the allocation address to be
>      retained on kernel kexec, this address can be exposed to user space
>      and subsequently passed through the command line.
> 
>   3. Distinct subsystems or drivers can set aside their region, allocating
>      a segment for their persistent memory pool, suitable for uses such as
>      file systems, key-value stores, and other applications.
> 
> Notes:
> 
>   1. The last patch of the series represents a use case for the feature.
>      However, the patch won't compile and is for illustrative purposes only
>      as the code being patched hasn't been merged yet.
> 
>   2. The code being patched is currently under review by the community. The
>      series is named "Introduce /dev/mshv drivers":
> 
>          https://lkml.org/lkml/2023/9/22/1117
> 
> 
> Changes since v1:
> 
>   1. Persistent memory pool is now a wrapper on top of CMA instead of being a
>      new allocator.
> 
>   2. Persistent memory pool metadata doesn't belong to the pool anymore and
>      is now passed via Flattened Device Tree instead over kexec to the new
>      kernel.
> 
> The following series implements...
> 
> ---
> 
> Stanislav Kinsburskii (7):
>       kexec_file: Add fdt modification callback support
>       x86: kexec: Transfer existing fdt to the new kernel
>       x86: kexec: Enable fdt modification in callbacks
>       pmpool: Introduce persistent memory pool
>       pmpool: Update device tree on kexec
>       pmpool: Restore state from device tree post-kexec
>       Drivers: hv: Allocate persistent pages for root partition
> 
> 
>  arch/x86/Kconfig                  |   16 +++
>  arch/x86/kernel/kexec-bzimage64.c |   97 +++++++++++++++++
>  drivers/hv/hv_common.c            |   13 ++
>  include/linux/kexec.h             |    7 +
>  include/linux/pmpool.h            |   22 ++++
>  kernel/kexec_file.c               |   24 ++++
>  mm/Kconfig                        |    9 ++
>  mm/Makefile                       |    1 
>  mm/pmpool.c                       |  208 +++++++++++++++++++++++++++++++++++++
>  9 files changed, 394 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/pmpool.h
>  create mode 100644 mm/pmpool.c
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
