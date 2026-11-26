Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2E606A32C
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MTJKlCdB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7FHZ7/q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fv3YfealIuJOICIo52kCGcexbGGkcP1zYkCoBpg/CRc=; b=MTJKlCdBOeJgypLSUz6piSx04w
	YvGOiFBm7kMn8td38YLklvNKFrzxZPVhaS53vFUb/Qoa/LGhF3rReG+8Bta5C37HC4OkpUVY03rHR
	ceiDGgw7xoVl//0Vg69C1PqjxyhGjOqrRfLlmZGuUWAD3/pAghcRmPwjKek+qcWr845dFbeuk+bcP
	+IQTNR73nzx67n+6PA70/7Ysn8lwLDKyGD2Y5Lw79Ruy95dzp6ob0ZqkGzLqAqDkdO/I2OdfVFIlN
	+RTFl5O4YoEZJ5T27y3zOApVLfoae/eX7cQ+MGkFnDh1j+2xp4SKAx0AszEPS03979HUU73qettdE
	HGu4DzRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWYQS-0000000D8Dw-3oDE;
	Thu, 26 Nov 2026 12:18:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWYQQ-0000000D8DA-372l;
	Thu, 26 Nov 2026 12:18:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 33C2740C1A;
	Thu, 26 Nov 2026 12:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A351F000E0;
	Thu, 26 Nov 2026 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695486;
	bh=fv3YfealIuJOICIo52kCGcexbGGkcP1zYkCoBpg/CRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=d7FHZ7/qUp6WWqybny1XNnHENYGPzZQbY033qB8LP+ktd04t0YBSNl5E0O+sG4tfb
	 qYjI0sP/lnADMjPMofkcXeziLzNt7GqRbBheXfA2+1yhLE0CUrcyMTtSlYaCCY7H09
	 uoMkRwHYyHZRx5vDQSEUejVWNr5nGWk78t+OYL5ASbIHgkGtkdyCcdhFJV2QYRTSX/
	 AntiUF73LI7CSYKoLAM+NcGDiRodxjxMn3ADxZ3atvxtzb+Myp9Q0iMVOVib4BIMtZ
	 Fakbv0fVxZv2UKoKkwnrXPj8HzqFSo+iA92jTp57TPWKBAjOTopU0UM3cZv4WOkqPY
	 L5VoV6BiLk/zg==
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
In-Reply-To: <DN3O9LHR4XNH.1EYLA6D1F0J2P@google.com> (David Matlack's message
	of "Tue, 24 Nov 2026 11:02:12 -0800")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-6-tarunsahu@google.com>
	<2vxzse0rzjdn.fsf@kernel.org> <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
	<2vxz33sqz1xj.fsf@kernel.org> <DN3O9LHR4XNH.1EYLA6D1F0J2P@google.com>
Date: Thu, 26 Nov 2026 12:17:58 +0000
Message-ID: <2vxz5wxjyefd.fsf@kernel.org>
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

On Tue, Nov 24 2026, David Matlack wrote:

> On Tue Nov 24, 2026 at 7:25 AM PST, Pratyush Yadav wrote:
>> I don't think it buys us any functionality. It just hides the problem in
>> some lucky cases.
>
> Following up on our offline discussion: I think it's worth keeping
> support for optional features, both before and after the spec changes
> land.
>
> Before the spec lands, optional features are the only way to enable new
> features at all. For example, the PCI follow-up series [1] preserves
> BARs and bridge windows using an optional flag. It's purely additive: a
> kernel that doesn't understand it keeps behaving the way it does today.
> With optional features it can be enabled as soon as it lands, and Live
> Update keeps working in both directions, including rollback. If every
> feature is required, there is no way to enable it until the outgoing
> kernel can learn what its target supports.

Right, that's a fair point. But I really do hope we land the spec API,
because I don't think we will get very far with only optional features.
More on this below.

>
> After the spec lands, optional features are still useful, and at worst
> harmless:
>
>  - Kernels that predate the spec mechanism can't provide a spec. As long
>    as one of them is a possible target (e.g. for rollback), optional
>    features are still the only features the outgoing kernel can use.

Technically speaking, you can generate their spec by hand and feed it
into the outgoing kernel, as long as they use the same flags format
(which they should).

>
>  - The outgoing kernel doesn't need to consult the spec for optional
>    features at all (less complexity), since by definition the target can
>    ignore them. It can always produce the same payload, and only
>    required features need to be gated on what the target supports.
>
>  - Nothing prevents an outgoing kernel that has a spec from choosing not
>    to set optional bits its target doesn't understand, if we ever want
>    that.

Makes sense.

>
> The cost of keeping them is negligible in the current design: the same
> number of bits in the header, and one range check on the incoming side.

Yeah. The ABI ends up being a tiny bit more complex, but I think it
should be fine. It does plug a gap until we land the spec API, and since
PCI would use it in the near future, I think it is fine to keep both.

>
> The one rule we need is that optional really means safe to ignore, e.g.
> optional data must not reference preserved memory or carry restrictions
> that the next kernel has to act on. Anything like that must be a
> required feature.

Right. If an optional feature preserves any memory, it will get leaked
if the next kernel doesn't understand it. So I think it is only useful
for adding extra information in the main serialization structure.

While we're on this topic, here's a brain dump of my ideas of how the
feature flags should be used.

I don't think feature flags from the spec should be a passive check of
"can the next kernel understand my payload?". I think it should take an
active role in deciding how serialization works. Each serializer should
look at the spec to figure out what tools it can use to best describe
the object being preserved.

I'll take the example of memfd and KHO map once again. If we already had
the spec API available, multi-index entries would be added as a required
feature.

Then, during preserve(), memfd_luo should look at the spec of the next
kernel, and decide if it can use multi-index entries, or if it should
fall back to single-index entries. Userspace does not directly dictate
any of this. memfd_luo makes this decision based on the spec it has for
the next kernel (set at a system-wide level). It figures out the best
way to describe the memfd with the features that the next kernel can
understand.

Another example to demonstrate this would be LUO moving from a fixed
buffer to hold LUO sessions and files to KHO block.

Assuming the spec and feature flags were available at that time, we
should have added a new feature flag for KHO block, but still kept the
old code around for the fixed buffer. When doing the serialization, the
kernel decides if the spec has KHO block enabled. If it does, LUO uses
KHO block. Otherwise, it falls back to the fixed buffer.

I think this scheme will be a lot more flexible and future proof than
using the spec passively for validation and trying to write a payload
that can be understood by as many kernels as possible.

-- 
Regards,
Pratyush Yadav

