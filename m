Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A704C4450C
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V2FperODPZffItYX4p15vEdb2ZOhGatoLT7/6czMrMY=; b=jiB34s6oasV7cer/5mxURzQajf
	nf8CiDVN97fWMiktDrTBvIuYsPDtLW6HpMrLOwRivQ70IxvYu9C7kUOPC+aKXsfZO1zXgegAksb4z
	2mHJ18OLBnJKR/MVEnaRbeTn5TsGXOyEh2uqmtwzB37v5WbCEk/SrQE0u/Md8g919Mlti1+Tsh1P/
	hls5Of8+lYUCzSsQDdGJVew/RviJqHv8nhJ/zIPykNjlsv0CnQkE2HraoadFW5a6WxFBodZmfcRfx
	564rbekOiub2Fki7Ue9oArWXLfS3nWHbfAc8jd9nsB83CADhe8hqHFhSjD+x53LpxHGNEG8xcw1qP
	DOp8zD1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1b-0000000EKqx-1cxR;
	Wed, 15 Jul 2026 09:35:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1X-0000000EKqk-26Z4
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 09:35:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 911656001A;
	Wed, 15 Jul 2026 09:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E901F000E9;
	Wed, 15 Jul 2026 09:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108126;
	bh=V2FperODPZffItYX4p15vEdb2ZOhGatoLT7/6czMrMY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NVkH46VB7EGTTwGXH1+rcUmZxIU16Pahcwjpy6qmHiuEqJiyx1qm6Z3gqsSsf7u1j
	 AYM76d7FRYRO0X7xyF/hi87TxYJP1jDORTrTgR27WIlswmGvMbtjBDfgYPGY3OuVKs
	 LuCkHItwcE/FojDCndtZyHE+IgMJGexMpUYg8DhsifYSDL4SBJlbrnawizXfzjSfOt
	 Tzjz2Vp0O3RE6UnhM4Wya82MYmy1Pq9LhGi9K7SI/MsXyVzGsG6Yre64bD2Pet7jof
	 LeCEqjo1JCsQ8Ech3SudVX6QhF9xT5DGXksfUQsoVgZmagTY3J1jfXzzhAAF9IaoVX
	 Dga6XXzdJdKRw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 02/21] kho: make radix max key width more obvious
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260709173821.429921-3-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
 <20260709173821.429921-3-pratyush@kernel.org>
Date: Wed, 15 Jul 2026 12:35:19 +0300
Message-Id: <178410811938.820181.13900740219188125186.b4-review@b4>
X-Mailer: b4 0.16-dev
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

> The KHO radix tree constants are somewhat hard to understand. The tree
> depth essentially comes from the max key width. The max key width comes
> from the need to store a 52-bit PFN plus one more bit for the order.
> 
> All this is very obscure with the corrent code. The PFN width is defined
> as KHO_ORDER_0_LOG2, which makes very little sense to a new reader not
> already familiar with what the value means. Then the fact that an extra
> bit is needed is hidden in the KHO_TREE_MAX_DEPTH calculation.
> 
> Simplify this by removing KHO_ORDER_0_LOG2 and replace it with
> KHO_RADIX_KEY_WIDTH. Update the comment to explain why this value is
> used. This moves the +1 from KHO_TREE_MAX_DEPTH to KHO_RADIX_KEY_WIDTH,
> making things clearer.
> 
> Update kho_{encode,decode}_radix_key() to not use KHO_ORDER_0_LOG2.
> Instead, refactor the code and comments to make it clearer how the
> encoding and decoding is done.
> 
> In kho_encode_radix_key(), add a new variable for the shift for phys.

Nit:                                                 physical address ^

-- 
Sincerely yours,
Mike.


