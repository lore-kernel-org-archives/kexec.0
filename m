Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC88606A686
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=u8Og1QA7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4YDuVLo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ATJlsXEmgBegCpn5BwHudI3qqubv1tTP7fksevRvHqo=; b=u8Og1QA75dmkHphwx4fJP+hviu
	gDpshIN7XH8P3EvXpQ9lUVP08DFN7T6gFzPZy5WrGB5U4PsyvXNwW9/zKFhZO1DTpeseRblUAuwvf
	NtbMuByTfONwbrn4+7VHHT4Bl6YyqCWC2/RepgLUCxleU6+OEtX9t9oFFkA+E3nFcvSO63kKpUCs4
	4F6Xr/NCjO68aDqaqLO9NakAlOcVb13LY+Udzy7AaHgcW9v3ZwehnkhiykdZVkS1gcAy14YN+HhGY
	jAktkiUoroKsRiBDHIveIZ48AwtIFkkQSPehnQJ/nHYn9o0l5yP4omYuPmXAw8tSI3XNoxAqR13x/
	/qxiav+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWcS9-0000000DvmN-0TIG;
	Thu, 26 Nov 2026 16:36:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWcS3-0000000Dvm0-1rPo;
	Thu, 26 Nov 2026 16:36:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC21E43D4C;
	Thu, 26 Nov 2026 16:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBB51F000C0;
	Thu, 26 Nov 2026 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710962;
	bh=ATJlsXEmgBegCpn5BwHudI3qqubv1tTP7fksevRvHqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P4YDuVLowB3qq6ykOWDZcHMLKiSKQ8CQtAy4yUDqIkd8odRAKualfMPxWHGSnkm+R
	 2PWj2HwPnluHX217yIVBnz4ltf8gud7DVpDIOVnWPvj2tmRtQDwkW5GrLyBPVwc1P2
	 H8DVFw6/ujmQyjdb8hK5mKWwhnS5tQTm/FrakhOc6yTOGs/qksPdzN8PYv8RMpUQw7
	 ulmxngnaHoudWBkL+v4xPagIwwh7UNMjhR3rRlw1bwVr1T+AnwXiCuZycThNIvKJJn
	 Anqy+ejek6aYvEhB9sE0PqvuZhyTpgFBZ7BDw7EvqPO1q3MBdMmd2U7pPYubVmNwfN
	 QLihl37EmKX6Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Matlack" <dmatlack@google.com>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Tarun Sahu"
 <tarunsahu@google.com>,  "Pasha Tatashin" <pasha.tatashin@soleen.com>,
  "Mike Rapoport" <rppt@kernel.org>,  <robin.murphy@arm.com>,
  <maz@kernel.org>,  <will@kernel.org>,  "Alexander Graf"
 <graf@amazon.com>,  <seanjc@google.com>,  <jgg@nvidia.com>,
  <loganodell@google.com>,  <arnd@arndb.de>,  <dwmw2@infradead.org>,
  <baolu.lu@linux.intel.com>,  "Bjorn Helgaas" <bhelgaas@google.com>,
  <oupton@kernel.org>,  <alex@shazbot.org>,  <gle.com@google.com>,
  <pbonzini@redhat.com>,  "Andrew Morton" <akpm@linux-foundation.org>,
  <kevin.tian@intel.com>,  <joro@8bytes.org>,  <kvmarm@lists.linux.dev>,
  <linux-pci@vger.kernel.org>,  <kexec@lists.infradead.org>,
  <kvm@vger.kernel.org>,  <iommu@lists.linux.dev>,
  <linux-arm-kernel@lists.infradead.org>,  <skhawaja@google.com>,
  <sagis@google.com>,  <linux-arch@vger.kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
In-Reply-To: <DN4H5ST3X9L1.3IUEC1CA5QI8H@google.com> (David Matlack's message
	of "Wed, 25 Nov 2026 09:40:47 -0800")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-4-tarunsahu@google.com>
	<2vxz4idb1i2w.fsf@kernel.org> <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
	<2vxzld6hx97g.fsf@kernel.org> <DN4H5ST3X9L1.3IUEC1CA5QI8H@google.com>
Date: Thu, 26 Nov 2026 16:35:54 +0000
Message-ID: <2vxzse0nwnx1.fsf@kernel.org>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25 2026, David Matlack wrote:

> On Wed Nov 25, 2026 at 6:43 AM PST, Pratyush Yadav wrote:
> [...]
>
>> So I wouldn't want to support slab until we have file handlers that
>> churn through a lot of preserved objects.
>
> Makes sense. If KHO slab isn't coming, then I'm fine with the arena.
>
> One thing I realized is that the choice between the two is visible to
> the incoming kernel. With separate allocations, the incoming kernel has
> to free struct kho_vmalloc and struct memfd_luo_ser separately. With
> the arena, it must only free the top-level allocation. So we should
> pick one now (while memfd is bumping its compatible string anyway)
> rather than switching later.
>
> Separate allocations leaves the door open to KHO slab but wastes memory
> in the short term. It's not obvious to me which direction to go :)

Separate allocations aren't any more flexible than arena allocations.
Even if you have separate allocations, you need to know how they were
allocated to be able to free them. If they came from slab, you need to
call kmem_cache_free(), if they came from kho_alloc_preserve(), you need
to call kho_restore_free().

So you need to store the information of their origin somewhere, probably
in a feature flag. Same goes for arena. If we ever want to move away
from arena, we'd have to use a feature flag.

So to me, I think they are about the same in flexibility. Using separate
allocations is a tiny bit easier, arena is a tiny bit more efficient.
Which is why I like arena mode.

-- 
Regards,
Pratyush Yadav

