Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEECC43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMl/Hl9vchj200XFGcGCOCkDW3TMDHU36nBeESh9U+g=; b=j0B7UIhx8U2bDeLrzhWyq2m2D7
	Lb5Dl0ajKVzHOU2AQwCZODlwVdPcy9a3ry8a84RlzQUTTMtMd3yY6YloOOilsTpbU7DT9zZh5fY7L
	JnheMIvw+xH3nsO8EQkXRHvL3clPdNf2GfPxw3EdT9fIJbw1QnMi06miX4SyzAyQEzWleDA88kLmg
	EKNmJm9CPQLiS3v7YuXlzmDv0sOyl7CnigPOzf+aEm1F0opMk4iPeWV+I1XiSPomeWsqiN9WjFyoz
	I7AWJ3SctjHI4shj3qsBaPXA0EZMhoHjo7ltlUYLMELpiThKtUxwsMl0ZmdEqcdMgZfx9vRjQM5Vk
	CY9RRFzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whTLo-0000000HML1-3ncS;
	Wed, 08 Jul 2026 14:34:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whTLn-0000000HMKc-2uUa
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 14:34:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 72D2143F3A;
	Wed,  8 Jul 2026 14:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977651F00A3A;
	Wed,  8 Jul 2026 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521251;
	bh=yMl/Hl9vchj200XFGcGCOCkDW3TMDHU36nBeESh9U+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gkp8WN81Xw1+3ZEkuWvUYxFshXJZ/yQOPS7JoVjHAG33Ow3qX6AMrvVMPVydpxbJr
	 NjWhiPqXSxGGTD6P1tK49i1Iu88eYDUyp5560l8rg0In5aPnqZUp3veBvqCFfhYPw5
	 jORC0MmWPIsTYbmOwLQu7NQ9zwVmIZ52rxC04wkaDcUJ8nj1eHp6t6hpmlwQq3h3vI
	 ksb525Q3DGV/pcBOebrChZQfScER8OFD89JWU5slohAEvMjcJ+dHGk5VKJdHkrvCFu
	 PCcu51S1BU+7AI8LN7lpTDnbUWWzeTz4Wsg0ynFQp7YbluiF/mC2mwovOdkygZ32n5
	 SjiWo06DMVvVg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  David Matlack <dmatlack@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
In-Reply-To: <178341290876.3292146.16538284698967245356.b4-review@b4> (Mike
	Rapoport's message of "Tue, 07 Jul 2026 11:28:28 +0300")
References: <20260703020832.1731864-1-praan@google.com>
	<178341290876.3292146.16538284698967245356.b4-review@b4>
Date: Wed, 08 Jul 2026 16:34:08 +0200
Message-ID: <2vxz33xtmty7.fsf@kernel.org>
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

On Tue, Jul 07 2026, Mike Rapoport wrote:
>> 2. The type bit is preserved in the high bits of the KHO radix tree key
>>    (Bit 63) and stashed in page->private metadata during boot.
>
> This brings a broader question - what is the best way to deal with page
> metadata. This particular case requires only a single bit and luckily we
> have a few spare high bits in the radix tree key. But what if going
> forward we'll need more than a few bits? Do we need a parallel data
> structure for the page metadata? Or something in kho_radix_leaf in
> addition to the bitmap?

FWIW, I am not convinced we need the extra bit of metadata _in this
case_ [0]. But in general, I think the answer depends on how many pages
need that metadata.

Storing it in the key has a side effect because it increases the memory
usage. Since the keys will be more spread apart due to the metadata
bits, it will result in more radix table pages being allocated.

If we need the metadata for each preservation, I'd guess we should just
change the leaf nodes to have more bits per key instead of just one. If
the metadata is fairly rare, maybe we just do a parallel data structure.
Although parallel data structures do run the risk of going out of sync.

So I guess it depends on the use case, as always...

[0] https://lore.kernel.org/kexec/2vxz7bn5mv0n.fsf@kernel.org/

>
> I'm not saying that a generic solution for page metadata must be a part
> of this series, but we definitely need to consider and better sooner
> than later.

-- 
Regards,
Pratyush Yadav

