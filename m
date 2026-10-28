Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE07606A321
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A6Y6Rj0S;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEpzLNv3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=emSS8rGhFSAVh+HSifwB6oqPZ30JVlQSlhM7wMUoNhg=; b=A6Y6Rj0SGeK7KCdY0BA4kiYUnw
	Ck/fsqUUzSB04NNvGDnXmWMskyhXFmY7ONg/9Z5TST9PjN0AoV1nDaD44LRAnmTacN8DZP4wEeoBt
	rq5/uUcOP8LNAeSuEPl4JrTEsFOCnQVMdHtJa0AxfV4JquPSa+C/w2lPhQsahbMYQu1/QeYBJ+w1Y
	rwxl5Nvkp4hTywrz7yh/UNn+AEY4NkvzBzX+tIxl4R00MnvaGXCuyME90b9HaF23pT+QF+vrO9lnZ
	hWkbQMpBKr1r4CFFrY3D8xnPcor7AAvJP/gEWTxBHy6bUVdtE/aIFXJ1Furh+Ftfgzy+cgm48d5GY
	R1E6t6sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4Sa-00000007BAt-01PO;
	Wed, 28 Oct 2026 14:17:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4SX-00000007BAR-47cz
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 14:16:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D4015600C8;
	Wed, 28 Oct 2026 14:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D581F01828;
	Wed, 28 Oct 2026 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197016;
	bh=emSS8rGhFSAVh+HSifwB6oqPZ30JVlQSlhM7wMUoNhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nEpzLNv3PknOMyHQDCqjJNXNxk/Uc/Xh6hGOvqmAGnYRM75hq1XI6GjwGRVh3QDUU
	 WPyMbIJ96JuiX9TIfrkO7CHN68+xWENn8oz9SnBTMQTtDod7Jw+YJSqjqKB0z6ueQY
	 J+YjJc/Tp5PBrDEN9hIQo6SKn5oz3hKTGYGOCTydvTr5e4+QLq14Y2E28qKbTLrpO2
	 2DthOftJEg8ZxPlmZOeZrR6Bu+RaBacV3FP84D0QE51AGmBqfDN7DZMzEAwYRcikXa
	 cu5ouLFHOwwZcrz5yM3YVxIOLEklM3lPuD/O0NMM/rfTy5E/nfNz73pg2CuQsm7rv6
	 wHzuZ3koXF/xA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: <akpm@linux-foundation.org>,  <david@kernel.org>,  <ljs@kernel.org>,
  <liam@infradead.org>,  <vbabka@kernel.org>,  <rppt@kernel.org>,
  <surenb@google.com>,  <mhocko@suse.com>,  <baoquan.he@linux.dev>,
  <pasha.tatashin@soleen.com>,  <pratyush@kernel.org>,  <graf@amazon.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH 2/2] mm/cma: reject CMA areas that overlap the
 kernel image
In-Reply-To: <20261014145731.3431527-3-radhey.shyam.pandey@amd.com> (Radhey
	Shyam Pandey's message of "Wed, 14 Oct 2026 20:27:31 +0530")
References: <20261014145731.3431527-1-radhey.shyam.pandey@amd.com>
	<20261014145731.3431527-3-radhey.shyam.pandey@amd.com>
Date: Wed, 28 Oct 2026 15:16:52 +0100
Message-ID: <2vxzcxstoqp7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14 2026, Radhey Shyam Pandey wrote:

> cma_init_reserved_mem() takes a base address chosen by its caller and
> requires that the range already be reserved. That makes an overlap with
> the kernel image indistinguishable from the normal case by looking at
> memblock alone, yet such an area is fatal: cma_activate_area() hands it
> to init_cma_reserved_pageblock(), which unconditionally clears
> PageReserved on every page and frees them into MIGRATE_CMA, overriding
> the memblock_reserve() of [_text, _end) that the architecture installed.
> Those pages satisfy ordinary movable allocations from that point on, so
> userspace is handed live kernel text.
>
> The preceding patch closes the way this is reachable today, where a
> kexec'd kernel runs from inside the default CMA area and then declares
> the range it is executing from as a shared-dma-pool. On a VEK385 that
> reproduced within ~300ms of /sbin/init starting, as a copy-on-write
> fault writing to the read-only linear alias of .text:
>
>   Unable to handle kernel write to read-only memory at virtual address ffff00084030c000
>   Call trace:
>    copy_page+0x48/0xc4 (P)
>    copy_user_highpage+0x14/0x30
>    __handle_mm_fault+0x318/0x1340
>
> Dynamically placed areas cannot hit this: __cma_declare_contiguous_nid()
> either rejects a fixed base that is already reserved, or picks an address
> itself and so avoids the kernel image. Only a caller that passes a base
> chosen elsewhere can, so check for the overlap explicitly rather than
> leave the next such caller to corrupt the kernel silently.
>
> Note that failing here is not by itself sufficient for a device-tree
> pool. fdt_init_reserved_mem_node() responds to an error from a non-nomap
> region by calling memblock_phys_free() on the whole range, which drops
> the kernel image's own reservation along with it, so the pages are still
> released - as plain free memory rather than MIGRATE_CMA. Callers that
> keep their reservation on failure, such as powerpc's fadump_cma_init(),
> are fully protected. For the device-tree path this is a diagnostic and a
> second line of defence behind the preceding patch.

Why leave the dangerous code around? Why not update
fdt_init_reserved_mem_node() to expect -EBUSY and skip freeing on it?

Other than this,

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

