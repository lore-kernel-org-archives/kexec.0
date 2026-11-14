Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B1606A336
	for <kexec@archiver.kernel.org>; Sat, 14 Nov 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZBqTK6+i;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G6IJMeDa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JNaJcXdU6JL88Hplnr1u9aTEynknq2tK7kpa3hgYbA8=; b=ZBqTK6+iaHn9Nq/1ZsLvKZxz7t
	iDp6RuKazNW5PreAX5y8Xs2nXlpaLNJ/hHLmerL+8ajRAJjnJgp+sqVLQ0wCeqtggVQrMekE0Bd4M
	Ef39GTZbbvdK3Rvkm6SoZk/f/YFZ5tud+H8aA84Q7KAeYvm7/jhTnnUFE8rQIz+R3WXUemY/328PV
	h0e5R5vXqauqY2Z+Aj3TxGyysk/+pPp79RzBPqdIlAREo5xL70C60DHdXNGkGTi50hOaUl+y7E7Hw
	cfZLrYFnemBwPWbotlJFCJfyfsypjE2LPQ45I5iKWAiMNUw2G5U+SeKor/Uh9n8ZlvwlPhvNyfsuR
	o0ivDh+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHfS-0000000GY8O-3Y2j;
	Sat, 14 Nov 2026 17:35:58 +0000
Received: from mail-ej1-x645.google.com ([2a00:1450:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHfK-0000000GY6e-43T7
	for kexec@lists.infradead.org;
	Sat, 14 Nov 2026 17:35:54 +0000
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c37b2763f1bso244877466b.1
        for <kexec@lists.infradead.org>; Sat, 14 Nov 2026 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794677748; x=1795282548; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNaJcXdU6JL88Hplnr1u9aTEynknq2tK7kpa3hgYbA8=;
        b=G6IJMeDaUi1eOo0oNvqt/VEzSCFMtNzGOab1/IMNLfvDn0NtNfGnz0XUA7gGKxBSLP
         T+mGEEBegJzdYVQMoQv0jjjuiQgInQpMDU3Gj8mU0WoKsqRbxMiyWUxhSNvPogazo35+
         F4iErExvxGdAhE2RzHBrxIU9mmnfENOT0w+ax/u3GCyPAsyC81ElCr/G9PHB9mEMv0PC
         ANSW5gYX+QYTh3rkJDypJkAvleHSHk3xtofS/EDUZNemh8bux+gCdN4gVr3ypWX255BS
         92UZyLHFM+3PAW24ii13ZGLlEjQn1Mj5e04hhYmL0FI0bOEd5/x9DXU7S4BJC0FRx3HS
         WnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794677748; x=1795282548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNaJcXdU6JL88Hplnr1u9aTEynknq2tK7kpa3hgYbA8=;
        b=OCpgygTBohVYvpNjvnwphHo0cOFZwkR0y3pEYJ59syENhZXS/jGTaKv9tzKm7jHYpX
         bVT/tcLCSm+wGgEzrjt7TM82Eewv6qiozhzOE9M858FEqpUSJbVNminhr/H5zDvyVRPp
         kwmRbnTeW803tSfysFGfnzTIXlXAOoZ81LzQLfrgU162Rr7MoT7rndiMTwR0Lr8wAZew
         RZrVJHYFLpyrtNdW0W4l7Lf7q+PhUGZ9syhd/qIrGRvAfIr5oZAXfe3s/+DW0PaEUMqI
         RLeoSL913dnZSUSIaugn21LOybs4cFDF9ZZGI0nK+mtt9Tom8VUnfAvn8QvciJJRWtYi
         614A==
X-Forwarded-Encrypted: i=1; AL+hErHcDvJ3uDwOHv2mw/Pzbcazm2pZt6S7X9yO8fsDrR/w4qPneAwVmDjqhvXOL51romV8RieDdg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/tJigv6XAkUQF9hBUPQqABeoyg+MwVEt534vkMN9AH3pAImnuU
	2gi2mFpt2iv1YCy0jacijzpnBTTdYLOVDQ6sQ+G0nCKFIprEW0mjGsE3zLH/9RNClwgi0piCE/H
	YSJ7fk//W6qji+4INbA==
X-Received: from ejfz7.prod.google.com ([2002:a17:906:ac7:b0:c2e:3202:ef75])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:868f:b0:c33:ae8b:817d with SMTP id a640c23a62f3a-c509654f9admr515384166b.46.1794677747981;
 Sat, 14 Nov 2026 09:35:47 -0800 (PST)
Date: Sat, 14 Nov 2026 17:35:47 +0000
In-Reply-To: <DMRO4QXXB8H4.127C1CPT3RZ18@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-17-tarunsahu@google.com>
 <DMRO4QXXB8H4.127C1CPT3RZ18@google.com>
Message-ID: <9huzmrrbpb7w.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 16/19] PCI: liveupdate: Add feature header to struct pci_dev_ser
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_093553_514718_658D09DE 
X-CRM114-Status: GOOD (  32.44  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"David Matlack" <dmatlack@google.com> writes:

> On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
>> Precede each serialized PCI device entry in the PCI Live Update KHO block
>> set with struct kho_ser_hdr via DECLARE_KHO_SER so future per-device PCI
>> Live Update features can append fields to struct pci_dev_ser without
>> breaking compatibility between adjacent kernels.
>
> Elements of a collection should not have their own feature headers. This
> applies to patches 10, 12, 14, 16 and 18. I raised this during the v2
> discussion [1][2], but I don't think it was addressed.
>

As per [3], I tried to add feature header to all possible instances of
ser structs. Maybe this is the right time to audit these structs and decide
which one will never need feature header.

[3]: https://lore.kernel.org/kexec/CA+CK2bB9xoAWP0kC+KtXeDTdwt0kWqb-PLHN=6DsA=mnRpMfxA@mail.gmail.com/

> All entries in a KHO block set are written by the same kernel using the
> same struct, and the block set has a single entry_size, so every entry
> header is necessarily identical. They don't convey anything that the
> header of the struct that owns the collection can't. In this case,
> struct pci_ser's header can define features that describe fields in
> struct pci_dev_ser, and the PCI core checks them once before iterating.
> If a feature only applies to some devices, the field's value in each
> entry says whether that device uses it.
>

pci_dev_ser can be refrained from using kho_ser_hdr but not
memfd_luo_folio_ser.

The difference lies in their API usage. one use kho block and other one
kho_vmalloc. With kho block, we carry entry_size, so the parent
pci_ser's kho_ser_hdr can communicate about the new field/feature in the
pci_dev_ser and entry_size will carry correct the size of pci_dev_ser
for iterator on deserialization. But for memfd_luo_ser, kho_vmalloc does
not carry such entry_size. So we can solve this by adding the
folio_ser_size into memfd_luo_ser struct.

Without entry_size, we can only add new changes to such structs by
adding feature in parent struct with required = 1. That way rollback or
upgrade will fail to the kernel which does not support this required
feature. Incase, if we have entry_size (folio_ser_size in above
example), it will help marking such feature to be optional also and
deserialization can correctly parse with entry_size and can ignore those
changes if the kernel wants to.


> Per-entry headers also cost a lot for small entries. struct pci_dev_ser
> goes from 8 to 16 bytes, and to 24 bytes once the first feature is
> added. Patch 18 does the same for every preserved memfd folio, which for
> a large guest backed by 4K pages adds gigabytes of preserved metadata.
>

Yeah, we are carrying 8/16 byte of extra memory where every entry share
the same header. Which is a waste.

> They also add new ways to read out of bounds. kho_ser_payload() trusts
> nr_required/nr_optional in each entry, and nothing checks that the entry
> header plus payload fit within entry_size. In patches 14 and 18 the walk
> uses each entry's fhdr->size to find the next entry, so one bad header
> throws off every entry after it.

Bad feature header is not the reasoning here we should back this
requirement. A bad feature header already imply the deserialization is
compromised and hence accessing anything further is undefined. This
holds true for any struct with feature header.

>
> Instead I would keep struct pci_dev_ser as a plain struct, take the
> entry size from the KHO block header (patch 2), and in pci_flb_retrieve()
> check once that the entry size covers the base fields, plus the fields
> of any features set in struct pci_ser's header, e.g.:
>
> 	entry_size = kho_block_set_entry_size(&incoming->block_set);
> 	if (entry_size < offsetofend(struct pci_dev_ser, refcount))
> 		panic(...);
>
> That also restores the minimum entry size check that the v10 PCI series
> had with PCI_DEV_SER_MIN_SIZE, which this version drops.

offsetofend() is a good idea to replace PCI_DEV_SER_MIN_SIZE.

>
> [...]
>
>> -	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
>> +	kho_block_set_init(&incoming->block_set, kho_ser_size(pci_dev_ser));
>
> This size is never used. kho_block_set_restore() overwrites it with the
> entry size recorded by the previous kernel. Passing this kernel's size
> here is misleading: pci_flb_retrieve() (and the LUO session/file restore
> paths) read as if they iterate incoming entries with the outgoing entry
> size, which would be a bug.
>
> Incoming block sets should not take an entry size at all.
> kho_block_set_restore() should initialize the block set itself from the
> incoming block headers, and the incoming paths should drop the
> kho_block_set_init() call.

Yes, We can avoid this dual initialization. kho_block_set_restore can
take care of it. Also once we will agree on having having
kho_block_set_ser to have entry_size which will be part of only
block[0], then we will not have to update the entry_size inside the loop
again and again and count_per_block can also be calculated before the
loop for block 0 and 1..N.

~Tarun
>
> [1] https://lore.kernel.org/kexec/atl6K2Juy6Bh29lh@google.com/
> [2] https://lore.kernel.org/kexec/at-8vkVpN2SF3XgB@google.com/

