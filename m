Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5BF606A31B
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p2WPIJ4x;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHd5gRUn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=I7P4Z0m4H0zqdvZ0EHWJXAmTbybltS5XLjPO30+Sp4U=; b=p2WPIJ4xs+54hjr7sTMUUSXEsc
	Qni2D+/0z6HH1KR49dJykpQbjgibCyeY1y71hEXmN1FPRIMyoonROYxWqMwpDetOdxDPfBmlvss+n
	fKFJ/aNuI5eaHaPmLZJCPKRHz0ItxUBpj2quPZNVO9AevtDaSa3NRvie9rLXTa6w5tR154pLQhDXV
	yWsMiO9uuKnufV75Z1EXxbXfT05XDjYB4gqYZRQg/wq1CdDVUOXoOLSnUO4UiI6R0vW8prr/XpNpl
	KUNhELpTsW6HU/Vdbt7CogJy8Rb7w30FwOeO6iZm9odVX+BlR98HcCIFgQVQXu61u7m4M+04ocSUF
	hh7cbYlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEc-0000000DfuC-4BfK;
	Thu, 22 Oct 2026 08:33:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEY-0000000Dfsa-1aSS
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 08:33:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 10D9343583;
	Thu, 22 Oct 2026 08:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3205D1F000C4;
	Thu, 22 Oct 2026 08:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657989;
	bh=I7P4Z0m4H0zqdvZ0EHWJXAmTbybltS5XLjPO30+Sp4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHd5gRUnE0JYDC3bp5XYFM4M/eFH8QH8Dc9624RyNopi6jrA63TrpPxiyLDK/Hxjp
	 dw5vmKunP6b5VJRmYtyolQYedMj8zpkxe4kTSvv6Yx5TLKjoz7LVRCaaJRZ4SmqgXS
	 RM6TsMCxzxI4Qw+eWb4axqtD9EgAr/ui5D8M22eqSDsnysEV9vlhxtFEAf7EDzaMV3
	 LVkNFsb2Og6luB4nAm1yyk8i2bQVKZXnn3Wz1vbnU+J8D78hHl/zN+anlyf9In7npl
	 qFa9L+D6YdrtMpgoGXVDuikaojWF4qso2fNrL2X5Luk7ZwdIzcdEo79jL6ezwFUHb2
	 byjglWZorCaRg==
Message-ID: <sashiko-outbox-181179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/8] crash_core: serialize crash header preparation
 against hotplug
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, conor+dt@kernel.org
In-Reply-To: <20261021083011.2170525-4-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-4-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:33:07 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] crash_core: cmem->ranges overflow via unlocked iomem_resource ho=
tplug
--

commit 24cd8bf08b74ae3e07f992972d3cd97b77d9fcf6
Author: Wandun Chen <chenwandun@lixiang.com>

crash_core: serialize crash header preparation against hotplug

This commit serializes crash_prepare_headers() with device_hotplug_lock
to prevent concurrent memory hotplug from changing the number of memory
ranges between counting and populating cmem->ranges. It also introduces
__crash_prepare_headers() for hotplug paths that already hold the lock.

Link: https://sashiko.dev/#/message/20260806101002.1F84E1F000E9@smtp.kernel=
.org

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index faa0f22dbb41d..8a861a946e261 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
[ ... ]
> @@ -344,8 +345,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
>  	return 0;
>  }
> =20
> -int crash_prepare_headers(int need_kernel_map, void **addr, unsigned lon=
g *sz,
> -			  unsigned long *nr_mem_ranges)
> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned l=
ong *sz,
> +			    unsigned long *nr_mem_ranges)
>  {
>  	unsigned int max_nr_ranges;
>  	struct crash_mem *cmem;
> @@ -382,6 +383,18 @@ int crash_prepare_headers(int need_kernel_map, void =
**addr, unsigned long *sz,
>  	return ret;
>  }
> =20
> +int crash_prepare_headers(int need_kernel_map, void **addr, unsigned lon=
g *sz,
> +			  unsigned long *nr_mem_ranges)
> +{
> +	int ret;
> +
> +	lock_device_hotplug();
> +	ret =3D __crash_prepare_headers(need_kernel_map, addr, sz, nr_mem_range=
s);
> +	unlock_device_hotplug();
> +
> +	return ret;
> +}

[Severity: Medium]
Can cmem->ranges[] still overflow during __crash_prepare_headers() even when
device_hotplug_lock is held?

In __crash_prepare_headers(), arch_get_system_nr_ranges() counts the current
system ram ranges (plus a fixed number of split slots for exclusions),
allocates cmem via alloc_cmem(max_nr_ranges), and then populates
cmem->ranges[] in arch_crash_populate_cmem().

Neither the x86 callback in arch/x86/kernel/crash.c:

static int prepare_elf64_ram_headers_callback(struct resource *res, void *a=
rg)
{
	struct crash_mem *cmem =3D arg;

	cmem->ranges[cmem->nr_ranges].start =3D res->start;
	cmem->ranges[cmem->nr_ranges].end =3D res->end;
	cmem->nr_ranges++;

	return 0;
}

nor the weak implementation in kernel/crash_core.c:

int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
{
	phys_addr_t start, end;
	u64 i;

	for_each_mem_range(i, &start, &end) {
		cmem->ranges[cmem->nr_ranges].start =3D start;
		cmem->ranges[cmem->nr_ranges].end =3D end - 1;
		cmem->nr_ranges++;
	}
	return 0;
}

checks whether cmem->nr_ranges has reached cmem->max_nr_ranges before writi=
ng
to cmem->ranges[cmem->nr_ranges++].

However, Xen balloon memory hotplug inserts new system ram resources into
iomem_resource before acquiring device_hotplug_lock via the call chain:

balloon_thread() / xen_alloc_ballooned_pages()
  -> add_ballooned_pages()
    -> reserve_additional_memory()
      -> additional_memory_resource()

Specifically, in drivers/xen/balloon.c:

static struct resource *additional_memory_resource(phys_addr_t size)
{
	...
	res->name =3D "System RAM";
	res->flags =3D IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;

	ret =3D allocate_resource(&iomem_resource, res,
				size, 0, -1,
				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
	...
}

static enum bp_state reserve_additional_memory(void)
{
	...
	resource =3D additional_memory_resource(balloon_hotplug * PAGE_SIZE);
	if (!resource)
		goto err;
	...
	mutex_unlock(&balloon_mutex);
	/* add_memory_resource() requires the device_hotplug lock */
	lock_device_hotplug();
	rc =3D add_memory_resource(nid, resource, MHP_MERGE_RESOURCE);
	unlock_device_hotplug();
	mutex_lock(&balloon_mutex);
	...
	balloon_stats.total_pages +=3D balloon_hotplug;
	...
}

Because reserve_additional_memory() inserts the resource into iomem_resource
and drops balloon_mutex before waiting on lock_device_hotplug(), and only
updates balloon_stats.total_pages after add_memory_resource() completes,
concurrent callers (such as balloon_thread() and xen_alloc_ballooned_pages(=
))
can insert new system ram entries into iomem_resource while
crash_prepare_headers() or arch_crash_handle_hotplug_event() holds
device_hotplug_lock.

If those entries are inserted between arch_get_system_nr_ranges() and
arch_crash_populate_cmem(), wouldn't the extra ranges consume the reserved
split slots (causing crash_exclude_mem_range() to fail) or overflow
cmem->ranges[]? Should arch_crash_populate_cmem() and
prepare_elf64_ram_headers_callback() also bounds-check cmem->nr_ranges
against cmem->max_nr_ranges?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021083011.2170=
525-1-chenwandun1@gmail.com?part=3D3

