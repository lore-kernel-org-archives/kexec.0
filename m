Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281B5CD98D2
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J5TEdRcU1HNGEpxe5iEk5mmqGpDPc+8AZK6bCaNbHIo=; b=XYX2leCLoim+9y0DnOhB0kE4Zx
	Vh4d9NdCYwtiE8xSKWU35AZ4+3KjC8UNmwD9dz5+Nc5jvob60iCGTbf1Ubrnfufq9l3056deF0wc2
	cU5GSg64VWZFHOFnIvT6QKViZdK4ZEEcC+0y2RA0lLjexWZ1Fzko8Qoik/tNJGmCoqo2/NMZ8F1z7
	JbLn0pp13cQcPHsRiKsEX98FrY68aUVaFoh0sWkK2FgXwtNVPIx8axBqn8wXCvakx5kPblkirKZAP
	AbFSJZw5CcuGNO58ozwiUdDQpFnSUD+wzenMkjv0qUVZa5+2MU+2R723jMgGEub503J7ITSJ6YiqY
	Oq6ZpM3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjYI-0000000Cwvk-0lvH;
	Sun, 14 Jun 2026 12:02:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjYG-0000000Cwup-485b
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:02:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5FA22601E2;
	Sun, 14 Jun 2026 12:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB4F1F00A3A;
	Sun, 14 Jun 2026 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781438576;
	bh=J5TEdRcU1HNGEpxe5iEk5mmqGpDPc+8AZK6bCaNbHIo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IfMVTgE/4qXI2cKR0GiZUoy1hcqZjKxQD9Ge7/d/1Nd5Lr8JaiLmAXIB42VO3ZUC9
	 PpFfv5WcH8uQC2D76eecRtkapuGD2uWmrE1CMYrxIkCu8WT2eK0yEQ3mIdqEdZj+E8
	 rOI4qVLNNFrCK58h/BLJ8Z45HgvxNdEg5k9gbyMMnwwVkcOYk5fsdVwPVemHuTdxmo
	 2rlphDI4zjcCN2VcLn47n23fex86Rjb6BFrb2KXg/AJmuizeVOdfx6g4s4Ogy2UaW4
	 xqOG81hztDTG/+9QmA2ASRi9sFFiNd/rX4ykHKOHx2EHtJoES1NwwSzjZ9TPzoTRi5
	 X2Xe7iBh2EUgg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 16/18] memblock: make HugeTLB bootmem allocation
 work with KHO
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260605183501.3884950-17-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
 <20260605183501.3884950-17-pratyush@kernel.org>
Date: Sun, 14 Jun 2026 15:02:31 +0300
Message-Id: <178143855120.2123877.5431342391381982046.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 20:34:49 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
> Gigantic huge page allocation is somewhat broken currently when KHO is
> used.
> 
> Firstly, they break KHO scratch size accounting. RSRV_KERN is used to
> track how much memory is reserved for use by the kernel. Since
> alloc_bootmem() calls the memblock_alloc*() APIs, the hugepages

hugetlb::alloc_bootmem()

> [...]
> First, it does not use mirrored memory for hugetlb. Mirrored memory is a
> limited resource that is best saved for kernel data structures, not user
> memory.
> 
> Second, if the memory found overlaps with KHO scratch areas, it discards
> the memory and retries.

This sentence is somewhat hard to parse.

>
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 6349c48154f4..131e54dd5d8d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1756,6 +1761,69 @@ void * __init memblock_alloc_try_nid_raw(
> [ ... skip 51 lines ... ]
> +		if (memblock_bottom_up())
> +			start = addr + size;
> +		else
> +			start = addr - size;
> +
> +		goto retry;

Hmm, two goto retry don't seem nice :/
Although I can't see how to imporove it really.

Maybe add a helper for going the node fallback?

-- 
Sincerely yours,
Mike.


