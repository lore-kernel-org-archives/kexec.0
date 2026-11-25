Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0575606A32E
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JWfrUs17;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaxxUP7L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DSDBbrxDF7QE7mJ7cGh5psk8NDNsiMzdc0pE9t4TEt8=; b=JWfrUs17aLLgtQ/rRgwhGK2U67
	EFNkePoiQqk0GbJmU5MHTM2oGMzwuWfVknfbMqwIXvOuNjvMJylli/BbpQ9gcm6WZ1P+jdtOEWNTl
	TTpU9imqpLZmjRQhycFwcWin+DDoVHR7TSUjdJ7Rf1g1rY0Fv9kaAED4Kigd+l+oA7s26NjTrE+ub
	W2OS6H55+MYSdq4YUazICwePO4IIjhPtUHUsyBuzk4khqcy8ezbgCL0VXmUxSaHHIZhhet9PjY2nY
	g42D6hZrwXMRWyd/fKvsiaLUJlMiqOkImwKcs4S/qVZdCs6mMoiwJ6jZXgtgrfwKA6odHl8U5gelq
	cPxwkbXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWEE2-0000000ADZH-27Vk;
	Wed, 25 Nov 2026 14:43:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWEE0-0000000ADZ3-2P07;
	Wed, 25 Nov 2026 14:43:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9802761140;
	Wed, 25 Nov 2026 14:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3521F000C6;
	Wed, 25 Nov 2026 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617835;
	bh=DSDBbrxDF7QE7mJ7cGh5psk8NDNsiMzdc0pE9t4TEt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IaxxUP7LRnqywT22he7m+Fp7ezJgAfkpHSw5REph0tRYPRC/9tQDBnxNGaqFCUe0P
	 HC4OCPR1FvefXZR0jreOarx1/ItxF0Kd5XwRm18+njWXI6kfrP7K+QHWF1l9XvxXHk
	 Wb3T7KBp5sU8Uq3JjMSsDtDz2cQ1vDbxW6cRqzm0jkDQjr5S84bbH7Zbc/9r5XtFga
	 tXPaD+SS8GZvYPYpD187DBOSIhZ28zt4gF80M0lT+Uc0vOeuoEM5ntTj2myprO+Uo6
	 0KAYN/vccLRY3U4aBHQmotXHdObAadnDVOITnax/jMq8UASOsc7R09dQV9GiPujVaw
	 zu/OOYjuPVOYA==
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
In-Reply-To: <DN3VG4JCILOO.YN40XHHSWRPH@google.com> (David Matlack's message
	of "Tue, 24 Nov 2026 16:39:52 -0800")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-4-tarunsahu@google.com>
	<2vxz4idb1i2w.fsf@kernel.org> <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
Date: Wed, 25 Nov 2026 14:43:47 +0000
Message-ID: <2vxzld6hx97g.fsf@kernel.org>
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

> On Fri Nov 20, 2026 at 10:19 AM PST, Pratyush Yadav wrote:
> [...]
>
>>> +static size_t memfd_luo_ser_size(void)
>>> +{
>>> +	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
>>> +}
>>> +
>>> +static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
>>> +{
>>> +	struct kho_vmalloc *kho_vmalloc = mem + sizeof(struct memfd_luo_ser);
>>> +	struct memfd_luo_ser *ser = mem;
>>> +
>>> +	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
>>> +	return ser;
>>> +}
>>> +
>>
>> Hmm, I am not a huge fan of this. This makes doing such allocations
>> quite annoying, and I reckon we will be seeing a fair bit of them in
>> many places.
>>
>> The key observation here is that most file handlers need to allocate a
>> bunch of preserved memory, but they usually can free it all at once. So
>> we can get away with a very simple allocator that hands out memory
>> linearly.
>>
>> I have sketched out some code for this, take a look at the patch below.
>> Note that it is only compile tested.
>>
>> Perhaps give it a try and see if it does the job better.
>
> I agree the manual packing in memfd_luo_ser_init() isn't great, but I'm
> not sure we need an arena. This seems like something KHO slab support
> will solve properly, and since kho_alloc_preserve() already takes a
> size, KHO slab can be dropped in underneath it later without changing
> any callers.

While it would be nice to have, I peeked at what we need for slab
support and it sounds overkill. For one, a slab cache is for fixed size
objects. So you'd need a bucket of slabs for different sizes, similar to
what kmalloc() does. You probably don't want to preserve objects spread
around in kmalloc's buckets, so you would need a set of buckets
dedicated for LUO/KHO.

For another, slab cache is great when you are allocating and freeing a
bunch of objects of varying sizes. But that isn't really the workload
preservation has. Each preservation hook needs to allocate a handful of
objects, and then hold them until unpreserve. This arena style allocator
does the job pretty well.

And finally, the object layout within a page/slab of the cache can
change based on configs or kernel versions. See SLAB_RED_ZONE or KASAN
for example. We would need to standardize the layout without
compromising the non-KHO slab users. We can probably solve these
problems, but I don't expect it to be easy.

So I wouldn't want to support slab until we have file handlers that
churn through a lot of preserved objects.

>
> Until then, maybe we should just allocate struct kho_vmalloc separately
> with kho_alloc_preserve() and accept wasting a folio per object. For
> memfd that's one extra page per preserved file.

Yeah, that is fine too I suppose, at least until we start to run into
problems with the memory overhead. I think the arena style allocator is
fairly straightforward and makes the memory savings easy so to me it
sounds promising.

-- 
Regards,
Pratyush Yadav

