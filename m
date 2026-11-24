Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488F606A327
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kz98eQw7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZKayue7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1UXh4PQJOR3VknqTlOD7G3LYkfB1ZlA2WQOnvCIXzSk=; b=kz98eQw7OCV4lvkHMypyi4E1DC
	Wfwu5hAnCix+Rl5RjYuGemDp6oJ01+x2a56jUCUV2fV+2CNmImL904fU878Z8XNVf6i2jsPtyUEgq
	6/hbnqoT43AWkceHTzcT4sHyA4o/UyiR3Agd5zNjtajJDnVXqX9IC390BWZ6P5tNejnKfVjt5NxS2
	9V/gJmvtQf4owXH/7rn/5GTkcX1QluMYhJMABdGLQWf3PjXJ8mXdzTJrkiTQ58VC9RaIt78RG7D+l
	W/REF7Y6VpERHb+tsnzVp1SMvQoWyKxL1DihR54MZ6mgh8YjJU0zw/IYQ4gQDsKfTNa4oLDcKp/uS
	TcsomhAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsP7-00000006t1A-302n;
	Tue, 24 Nov 2026 15:25:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsP3-00000006szp-1Emi;
	Tue, 24 Nov 2026 15:25:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BF5CA443FA;
	Tue, 24 Nov 2026 15:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CC31F000C6;
	Tue, 24 Nov 2026 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533952;
	bh=1UXh4PQJOR3VknqTlOD7G3LYkfB1ZlA2WQOnvCIXzSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BZKayue7T+OsylZjV79b6R0ytIW756sZrlscpck2YyZhapT9Gi9uxQD2TAqTTjgK1
	 Ny12Sm0RAzgn+HtgnA1nCyeqansp2lHh7ivIj/Ix1qFbH4HuVOa8qCEjIyvtoi9D6R
	 +jHmiVlbd0ZMEtoLUPptwix0CB+DWa1XVAy1+YYY895ci0d7bJUu/p9MbsNhjGaGh1
	 rfdPKCuFn+l+eN4jST+wJuMHZLweG6N0w74drNJ6WDvCm0j+qp/odn0AgQomKQb69w
	 XBI0ZPyD+v+OEE7bdKKZ7xDxe6TzGo/x9t8gCGRgnlp50DOQffqNVxBveg3UN2VOyB
	 +YF0ajNdmMBkw==
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
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
In-Reply-To: <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com> (David Matlack's message
	of "Mon, 23 Nov 2026 09:32:17 -0800")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-6-tarunsahu@google.com>
	<2vxzse0rzjdn.fsf@kernel.org> <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
Date: Tue, 24 Nov 2026 15:25:44 +0000
Message-ID: <2vxz33sqz1xj.fsf@kernel.org>
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

On Mon, Nov 23 2026, David Matlack wrote:

> On Mon Nov 23, 2026 at 6:56 AM PST, Pratyush Yadav wrote:
> [...]
>
>> When we have all this available, I don't see the point in
>> differentiating between optional and required features at the ABI level.
>> At the ABI level, all that matters is what the incoming kernel
>> understands. If the incoming kernel does not understand a specific
>> field, the outgoing kernel should just not use it. There's no point.
>> Best case, it gets ignored.
>
> I pretty strongly disagree.
>
> An optional feature is one that the next kernel does not need to
> understand to correctly restore the object. A required feature is one
> that the next kernel must understand to correctly restore the object.
> Optional features can be enabled without any compatibility concerns.
> Required features must be enabled carefully (IMO via uAPI) to avoid
> breaking Live Update.
>
> I agree it's a good idea for the outgoing kernel to check that the next
> kernel supports all of the required features it is using, so the Live
> Update can be stopped before the kexec. But that doesn't remove the
> need for the distinction. The next kernel still has to decide what to
> do when it sees a feature bit it doesn't understand, e.g. because no
> spec was provided, the spec was wrong, or we kexec'd into a different
> kernel than planned. Without the distinction it can only:
>
>  A. Treat all features as optional, which risks misinterpreting state
>     and corrupting memory if the previous kernel did not properly
>     validate the next kernel's capabilities.

Right, that's a bad idea.

>
>  B. Treat all features as required, which means no new feature can be
>     enabled until every kernel it might Live Update to (including
>     rollback targets) understands it, even when those kernels could
>     safely ignore it.

I think this is what we should do.

Why do all kernels need to understand a new feature?

If a kernel can safely parse an object without ever looking at an
optional feature, why set it in the first place? The outgoing kernel
already knows its target can't understand it.

So say you add a new optional feature in kernel X+1. For a rollback, the
kernel X+1 knows it is going to X which doesn't understand the feature.
It should just not use it in the payload, which means it never activates
the bit for that feature. All the feature bits X sees are the ones it
understand, and everything goes smoothly.

And to be clear, I'm saying that the feature bits in the ABI header
should be set dynamically based on what is used in the payload. The
feature bits in the spec are static. They say what the target kernel
understands. The feature bits in the payload are dynamic. They say what
features are actually used.

>
> Neither of those is a good outcome.
>
>> The semantics of required or optional then become "can I describe this
>> object with the capabilities I can use?". If the answer is yes,
>> serialization succeeds, if the answer is no, serialization fails. So
>> with this, KHO_MAP_F_MULTI_INDEX or KHO_MAP_F_DYN_DEPTH are indeed
>> optional. All memfds can be described without these, they just will be
>> less efficient.
>
> I think this is a different meaning of "optional". Whether the outgoing
> kernel can choose not to use a feature is a decision for the serializer.
> Whether the next kernel can safely ignore a feature's data is a property
> of the ABI. KHO_MAP_F_MULTI_INDEX is optional in the first sense, but
> required in the second: a kernel that doesn't understand it will
> misinterpret the map. The header needs to convey the second.

Right, which is why a payload handed to an old kernel should never set
KHO_MAP_F_MULTI_INDEX. Even if you have a property that is truly
optional and ignoring it will still make things work fine, why would you
want to set it in the first place? You know it will be ignored, so just
don't use it.

>
> So I see the spec and required bits as complementary: the spec lets the
> outgoing kernel avoid features the next kernel doesn't support and fail
> before kexec, and required bits let the next kernel fail safely if that
> check was skipped or wrong.

I see a marginal benefit in setting the optional bits by adding a tiny
bit more safety. But even then, it only hides the real problem. The
previous kernel should not be skipping its checks in the first place. If
you're lucky, it might only end up using an optional feature and you
might be able to ignore it. But if the checks don't happen or are
broken, you'd be just as likely to be unlucky and the previous kernel
might use a required feature if it skips the spec checks.

I don't think it buys us any functionality. It just hides the problem in
some lucky cases.

In fact, we could even add a "strict" mode in the future, where the
outgoing kernel refuses KHO if the spec to the incoming kernel is not
provided.

-- 
Regards,
Pratyush Yadav

