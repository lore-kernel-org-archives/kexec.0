Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A711606A333
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w5AUWTQS;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EK685C6B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aE92BuA/q+u7mWs8kchTDkcjs1m/i8lsv1ezZ7OruqU=; b=w5AUWTQSE8K3RX7NhdXgRbXC9U
	GagvmsYXyUsHauoj2E29H6d2HtI19dmS65FBKmSkVll9V/hD8vc6ZqcqqPg82NyQVs9JeuvWs8k4y
	fL7EwQuqhAblvj4w15bJX32ZWpbcqE74qycyS/J3okEARQyDvGzA+knAmqXhqs0sALA/NKPrTAFU2
	Za1frsA5Y4a3dh38rLWwzLfdUlsX/cIzK3rPmiepLpUJXx6nV0vyKwVoEsDd1WlZXfubMdMdg5VRj
	UZujyRO+JUTdSVtpzSgyj+l5C+sDhkDrAQCdW9vsEpuxb68HUDEPkDDYaCAJbox7eCtr8+7AsCOSB
	N9dOF8HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSTrt-0000000H8R2-14F8;
	Sun, 15 Nov 2026 06:37:37 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSTrq-0000000H8QI-44gw
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 06:37:36 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c293e604f0eso151931866b.3
        for <kexec@lists.infradead.org>; Sat, 14 Nov 2026 22:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794724652; x=1795329452; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aE92BuA/q+u7mWs8kchTDkcjs1m/i8lsv1ezZ7OruqU=;
        b=EK685C6B4qvgHeOjdPFHNpRqiBOop4zjSDapTbg6z3Z2OZI+O4eT0cdpQZm8CyYHKD
         T0BvzlOGfSdTOoL+T9xrAe11laGd2tXQZHPcbz2TbxIoYWwIbeapbogZPYAmy+v+8li4
         Ep6EA7jTiu97eNrSxAvdgQ6xwtloXhK1/epxpUwDLJwjhHvOmPM51N93DM+Iy8qd0CU/
         e+t9lxI1UphxyeY4HwFTmhUJXHrC/sxsIidUjplf+b3GetFVE+LfGufIRyDhQBtPFBm1
         NRZhpbhx9mOtft/maLkSY543RWK4Nls0NIQSVLwM+Mgfk8L5pEnwtZ45atR82aqiBQIz
         h1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794724652; x=1795329452;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aE92BuA/q+u7mWs8kchTDkcjs1m/i8lsv1ezZ7OruqU=;
        b=fiFad3/OsKr0lknFha04LrmzS0gmzPuNAFXhsAWq7jGfRJ7z2xLw7u6s7AXKnw7UT6
         1Sono+G1Stq8tYiaIKqEXb8YET1pPxh7ysjYvPs22+51YShskQhYGj961IgE7ISdyvx1
         585HFdWhyuYruVSOWT6mAMgWAdvD/uVuWesrP0LXCmR7FeIQOi7jxfQpZLlqHT6g2rpK
         3o21tKPPqTxxes09QeZu15ucpK0MrG2eS418ZLs1RgGpQuz7HvHYRpwU9Q01MTS9WwYc
         9kajU53cOVtT6Lm6f1bueLTnTmsEfOujfxYA1mzpgM0VVJkQpDaYmsaw37QHYAbfDnhk
         PPUQ==
X-Forwarded-Encrypted: i=1; AL+hErECX7K+76zDxDvf7FfmAsT4OayulyymrKReL35hl5Ad2owho88ZnSizAoFt5W53OKj6pKXk2g==@lists.infradead.org
X-Gm-Message-State: APuU4Z+VL3FVH1Gppqg3QIP6Zo97BwZVNP+rLjtBv82eN0A8ESv3CFRP
	K5mkpvbTE4UDwMxYYWO6Xesrilv3ekYEGAf8rKknVDVyWh33Vdw+iLXKiHzILIIVMVjSQkyhkUf
	LpJTbUwtJniXIJ1Jx9w==
X-Received: from ejbge24.prod.google.com ([2002:a17:907:9098:b0:c46:7bd3:aa06])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a714:b0:c42:5363:38dc with SMTP id a640c23a62f3a-c509637e20cmr533164966b.25.1794724652053;
 Sat, 14 Nov 2026 22:37:32 -0800 (PST)
Date: Sun, 15 Nov 2026 06:37:31 +0000
In-Reply-To: <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-3-tarunsahu@google.com>
 <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
Message-ID: <9huzjymepplg.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block header
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
X-CRM114-CacheID: sfid-20261114_223735_063935_B7AF8175 
X-CRM114-Status: GOOD (  23.00  )
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
>> Add an entry_size field to struct kho_block_header_ser. On the outgoing
>> side, record bs->entry_size into every block header during allocation.
>> During restoration, derive the entry stride directly from the block
>> header instead of relying on caller-supplied dimensions. The
>> kho_block_set_init() interface remains unchanged. A zero entry size,
>
> Since the entry size now comes from the block headers, incoming block
> sets should not take an entry size at all. I pointed this out on the
> PCI patch (16/19) as well. As is, every incoming path still calls
> kho_block_set_init() with this kernel's (outgoing) entry size, which
> kho_block_set_restore() then silently overwrites. That makes the
> callers (e.g. pci_flb_retrieve() and the LUO session/file restore
> paths) read as if they iterate incoming entries with the outgoing entry
> size. kho_block_set_restore() should initialize the block set itself
> from the incoming block headers, and the incoming paths should drop the
> kho_block_set_init() call.
>
I agree, responded to the PCI 16/19 patch.

> Please also add an accessor for the entry size, e.g.
> kho_block_set_entry_size(). Users of the block set need it to check that
> incoming entries are large enough for the fields they read, and that
> the fields of a feature are within the entry.

Sure, Will update it.

> [...]
>
>> + * Each block header also records the size of its entries. A newer kernel may
>> + * append fields to an entry, so the kernel that writes a block and the kernel
>> + * that reads it can use different entry sizes. The reader steps through the
>> + * entries with the recorded size, so every entry is found, and it does not read
>> + * beyond the recorded size of an entry.
>
> KHO blocks can't guarantee the last part. The iterator returns a void *
> that the caller casts to its own struct, so it is up to the caller to
> not read fields beyond the entry size. Please document that callers must
> check the entry size before accessing fields that may not be present.

Yes, I meant the same thing. by having a check on entry_size reader must
prevent itself to read beyong the provded entry_size. I update the
correct the documentation.

Also, I realize tha, after checking the base fields using offsetofend,
for any following new feature fields, a entry_size should also be
compared against the readers offsetofend till this feature field for
required fields. Incase reader does not have that field and
kho_ser_validate passes, that means that field certainly is optional.

I can add this also part of the documentation.

~Tarun

