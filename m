Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02B606A31E
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yFPXV1BT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqS38396
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wyeadx8A+qjGGKflAd6kjiHqlv7VopvbXaimXP38c3g=; b=yFPXV1BT+HmK6/KLzjnkJlFNff
	508ArkUIEenuT7jHzFoQPZEM35o5MVGzH4CcTpXlOW5HEsZsx4a2/horbWMOnHmCD/mzY7XpgXOrl
	pOLL1vRg7KHfQy8WIwf75/dTyvUZKyTrr1zh/UcbI7J4QEziW8LCNIYaVoyfX7QGKpK7gZyu5lg07
	XITyO2u6Zpl0rGtORgm1vsB5xWQm1x1S0ZDU009dLrxBK8On7RSYOPwjT4dVEKG7i7LYxfB3pxtlB
	FHgM4IeGMznwsxLi+Brd6MVBlR6jEWiwYCOrS/wRjcvU4luTwZIHC/zWPAH0+1oqETUZQHPrX6Y7Y
	49YyniJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWdq6-0000000E86P-0kc5;
	Thu, 26 Nov 2026 18:04:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWdq5-0000000E86F-0ss8;
	Thu, 26 Nov 2026 18:04:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 75E6160E2D;
	Thu, 26 Nov 2026 18:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1B81F000CA;
	Thu, 26 Nov 2026 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795716296;
	bh=wyeadx8A+qjGGKflAd6kjiHqlv7VopvbXaimXP38c3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EqS38396Z/iq27cU9pt1bZvkBZNs2vlZLiamVFn+y25C+t9ZVrIAPHvMUWzhklPNP
	 HFlsyNtm+f8t96tCn/siJCDZuV1XtDvPYjdJqVqKSpH7VFHyCh9f6uOi3Z9ejseiY4
	 yiA4CVErYDCkwKKlJKqm8i2Sa7AcFoY130mUzRzuiM+gnKIaLLWvpo800U8dbryzmU
	 Ie6ee1bcLsBZPAJVP+PhrLXv/FwN2eXOmuWWDguEbpYP1xOXMR4fwmkl6C5BmqrEfu
	 d4UA9FhkCeKKlVEZWBE+E/unDJ3VkCOcP+G9AxHsM5x6LxQMUSfXvO2ckf9/IBGfFo
	 /Y/pUt7+dSRtg==
From: Pratyush Yadav <pratyush@kernel.org>
To: tarunsahu@google.com
Cc: David Matlack <dmatlack@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,
  robin.murphy@arm.com,  maz@kernel.org,  will@kernel.org,  Alexander Graf
 <graf@amazon.com>,  seanjc@google.com,  jgg@nvidia.com,
  loganodell@google.com,  arnd@arndb.de,  dwmw2@infradead.org,
  baolu.lu@linux.intel.com,  Bjorn Helgaas <bhelgaas@google.com>,
  oupton@kernel.org,  alex@shazbot.org,  gle.com@google.com,
  pbonzini@redhat.com,  Andrew Morton <akpm@linux-foundation.org>,
  kevin.tian@intel.com,  joro@8bytes.org,  kvmarm@lists.linux.dev,
  linux-pci@vger.kernel.org,  Pratyush Yadav <pratyush@kernel.org>,
  kexec@lists.infradead.org,  kvm@vger.kernel.org,  iommu@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  skhawaja@google.com,
  sagis@google.com,  linux-arch@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
In-Reply-To: <9huzse13pxhq.fsf@tarunix.c.googlers.com> (tarunsahu@google.com's
	message of "Sat, 14 Nov 2026 09:34:41 +0000")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-9-tarunsahu@google.com>
	<DMRP21FATCC0.ARAURXWV85JP@google.com>
	<9huzse13pxhq.fsf@tarunix.c.googlers.com>
Date: Thu, 26 Nov 2026 18:04:48 +0000
Message-ID: <2vxzcxrrwjsv.fsf@kernel.org>
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

On Sat, Nov 14 2026, tarunsahu@google.com wrote:

> "David Matlack" <dmatlack@google.com> writes:
>
>> On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
>>> Precede struct kho_block_header_ser with struct kho_ser_hdr using
>>> DECLARE_KHO_SER. Each block in a block set starts with struct
>>> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
>>> start immediately after the header payload at offset fhdr->size.
>>
>> This adds a feature header to every block in the set, but the layout it
>> describes is a property of the whole set: all blocks are written by the
>> same kernel with the same header.
>>
>> Blocks are only ever added and removed at the tail, so the head block
>> is stable for the lifetime of the set. I'd put a single set-wide
>> header in the first block only, e.g. a struct kho_block_set_ser with
>> its own feature header, and keep the per-block header to next and
>> count.
>>
>> entry_size (added in patch 2) is another set-wide property that belongs
>> there. All blocks in a set have the same entry size, so recording it in
>> every block is redundant, and restore has to check that the copies
>> agree.
>>
>
> Yes, adding a ser_hdr to each block_header is unnecessary and also cause
> 8 bytes to get added to every block. This can be solved like you said by
> adding it only to the first block. But this will make number of entries
> in block[0] to be less than blocks 1..N. I am not sure if that is
> acceptable but if it can be then we can avoid adding ser_hdr to each
> block. Same for entry_size which can be moved to the first block only
> like you suggested part of struct kho_block_set_ser.

I think it is simpler to do as kho_vmalloc does and just have a separate
out-of-band structure to hold all the metadata.

[...]

-- 
Regards,
Pratyush Yadav

