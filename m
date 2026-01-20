Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA771CA5FA9
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/J1YAop1V/r8c2DlUWbLz43fckCY4iAx9abYxpe3Yo=; b=jPQ0Psr0E3RJLBQKXUkv/5yrLw
	Yrp2Hd9O+gga9kiKb2abBJoSRyZ3EGcz+xOEhb6jPxAWyfawoAA83Ia8cojTDqHvQCZSDpjxi9+qe
	wrQbLn9WRK6vxY8sSQWXbJ8R/ht89ZjsbCCWgz//GFWeIo/TzAA23c8pgXf9mhLkmsflJRzTBLxHT
	iiwev2ETkAYS+tmZmmevEPpHum8UEfTGYy4bw0oxwu9SoS0AtKTLbc0T5cy3ltrVSFHG11RQdGOio
	HOI+f06DeSDC+lEabeadYrSmgJr3cn5SEMCHmihGnxacw+vllceLGH7tVquQhO7m2u/WlzplTsi67
	fbRQPPrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEZG-00000004AAP-0hhg;
	Tue, 20 Jan 2026 16:26:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEZE-00000004AAA-1Csx
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 16:26:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7388060010;
	Tue, 20 Jan 2026 16:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5254CC16AAE;
	Tue, 20 Jan 2026 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768926415;
	bh=4ywi/Ge6byP7fAvuQcqc1ZOy3qOB/jgJwjF/tX2C4Vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u/Jbtm1Uy7tW11ltZw+UNuQwuvnWlKzzSwmmZlJVZv6+RiqUfcPPqXDDuQNuAsvQa
	 CBF3rwzUzEOnYqQI99rTEJF/0p4B+UHohQ4OG8Fcv67bLjRByLmqjTIcj+5nasml8/
	 Fq8mdc02ZJ69FoXRZuLUgllceE+DLZts0A+7+7FslqKnXo8GDBQvrX6vlh/yRn3avF
	 qzc1f/vB033q95iTw/v9m0JzrKBJnKB+bSvcm4CPZSuLfHlp8bMj8mcfaYy+2sWtRz
	 z9jKx5XCC9uJmPnfArcbKqFqbODWK0TNEPHBUindT+YeOOcjB/KQicQU08LHn+tVOz
	 n51upe5GYDzQA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 5/6] kho: Relocate vmalloc preservation structure to KHO
 ABI header
In-Reply-To: <20260105165839.285270-6-rppt@kernel.org> (Mike Rapoport's
	message of "Mon, 5 Jan 2026 18:58:38 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
	<20260105165839.285270-6-rppt@kernel.org>
Date: Tue, 20 Jan 2026 16:26:51 +0000
Message-ID: <2vxzy0lscks4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Jan 05 2026, Mike Rapoport wrote:

> From: Jason Miu <jasonmiu@google.com>
>
> The `struct kho_vmalloc` defines the in-memory layout for preserving
> vmalloc regions across kexec. This layout is a contract between kernels
> and part of the KHO ABI.
>
> To reflect this relationship, the related structs and helper macros are
> relocated to the ABI header, `include/linux/kho/abi/kexec_handover.h`.
> This move places the structure's definition under the protection of the
> KHO_FDT_COMPATIBLE version string.
>
> The structure and its components are now also documented within the
> ABI header to describe the contract and prevent ABI breaks.
>
> Signed-off-by: Jason Miu <jasonmiu@google.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[...]
> +/* Helper macro to define a union for a serializable pointer. */
> +#define DECLARE_KHOSER_PTR(name, type)	\
> +	union {                        \
> +		u64 phys;              \
> +		type ptr;              \
> +	} name
> +
> +/* Stores the physical address of a serializable pointer. */
> +#define KHOSER_STORE_PTR(dest, val)               \
> +	({                                        \
> +		typeof(val) v = val;              \
> +		typecheck(typeof((dest).ptr), v); \
> +		(dest).phys = virt_to_phys(v);    \
> +	})
> +
> +/* Loads the stored physical address back to a pointer. */
> +#define KHOSER_LOAD_PTR(src)						\
> +	({                                                                   \
> +		typeof(src) s = src;                                         \
> +		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
> +	})

Nit: not a fan of exposing code internals to the ABI header. But without
this the definition of kho_vmalloc_hdr won't make any sense to someone
reading the doc without looking at the code. Dunno if we can do anything
better though...

> +
> +/*
> + * This header is embedded at the beginning of each `kho_vmalloc_chunk`
> + * and contains a pointer to the next chunk in the linked list,
> + * stored as a physical address for handover.
> + */
> +struct kho_vmalloc_hdr {
> +	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
> +};
> +
> +#define KHO_VMALLOC_SIZE				\
> +	((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
> +	 sizeof(u64))
> +
> +/*
> + * Each chunk is a single page and is part of a linked list that describes
> + * a preserved vmalloc area. It contains the header with the link to the next
> + * chunk and an array of physical addresses of the pages that make up the
> + * preserved vmalloc area.

Perhaps also mention that the array is 0-terminated?

Looks good otherwise.

[...]

-- 
Regards,
Pratyush Yadav

