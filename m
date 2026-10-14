Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18B6CC6B1A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsSGsibKBP3ddM/Tx5DMN2MSA5WttKxWQypBiGvEWqM=; b=pfGuerNzgCTaTVVcVAAoFr+277
	ULnM4CxPQiUpmIPZO9luE0jrJu7CQmY8tpjchdTH4dSrm3v4ABnvAunzfmAn0Z0XyECyuMNjiwCCk
	9x+j8+bOn4lWh+1JD964bA3cGvdO9R/ejwXo1KS59fDvtgOjWGyrNT+UDuwwPXdvdhJNUHZ/U0aGb
	T4im93829vd9OQqfsy+RJgHi6AytMJ0WP7kFg7TwWGKCGdOGjYodQvCyojkrdHXQtJrMI9neJnZaA
	ErMOHwU2CDfXzeARLWRaEeLPKCqrfYUfMxbK7yd0FVSbkXqosJzYHu/KE2NN1jqB9PCOe94B97yDH
	jFKhX7Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH0Zv-0000000Fnx8-3K1P;
	Wed, 14 Oct 2026 15:07:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH0Zt-0000000Fnwk-36zh
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 15:07:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C4DB438CB;
	Wed, 14 Oct 2026 15:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5701F000C4;
	Wed, 14 Oct 2026 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990457;
	bh=YsSGsibKBP3ddM/Tx5DMN2MSA5WttKxWQypBiGvEWqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kl7FWvy6BvO+29adRHyGwd3nwlykWSveJ81Mb69sF/t3KP2li2s+zuSQk5Nzfh1i8
	 ePWiUVoJWC1COf11g3v6z7BUT6ByQ2A0fTTd928dvtZPcrdVns6iQ0FS7CTAHnptfk
	 30U2ONOa8mkslSXVnOXa6z/eVZQll1dDZRFDDF4xXxqfJRZQAEkNhtRqVE8LJ5l/Bx
	 0mTTZFkeuAho7lClPjWe6rZdvOHuoXITbW0QBbKW17u8cTPK0L2caT5BY8tdLXhCKE
	 M4I8q+9B0PySWHrIW7GnAi31cWn5LcWm15gC/CjBpDj2n0V1l0tX53b56F4D7T/Jrg
	 AKBvxO0nzt1bA==
Message-ID: <sashiko-outbox-171454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] kexec: do not place the next kernel in a
 fixed-address CMA area
To: "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20261014145731.3431527-2-radhey.shyam.pandey@amd.com>
References: <20261014145731.3431527-1-radhey.shyam.pandey@amd.com>
 <20261014145731.3431527-2-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:07:36 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> kexec_alloc_contig() picks the destination of the next kernel out of the
> default CMA area, and the next kernel then runs from there in place
> instead of being copied out. That is only safe if the area will not exist
> at the same address in the kernel being loaded.
>=20
> For an area whose base came from the device tree, it will. The loaded
> kernel parses the same description, declares the range it is executing
> from as a shared-dma-pool, and cma_activate_area() releases the pages
> holding its own image to the page allocator.
>=20
> Distinguish the two cases. An area placed by cma_declare_contiguous_nid()
> without a fixed base lands wherever this kernel found room, and the next
> kernel repeats that search against its own memblock state, so it cannot
> collide. Record the difference as CMA_FIXED_BASE and refuse to use such
> an area for the payload, which leaves kexec_locate_mem_hole() to fall
> [ ... ]
> them overlapping the running kernel.
>=20
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014145731.3431=
527-1-radhey.shyam.pandey@amd.com?part=3D1


