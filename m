Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E972C61DCB
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q0eNhqvMX0/iJyiBrToLKqr6Y2gSqCXGI85V9zCEwnI=; b=ZtLLqalp/4Rmz//dZkxoa/0ih0
	isojzStTpfXKrQRm3eYtZijf2lPnMyTVDcvAEnfjwO0Ilk3f8mb9bYZt2KUOYj7txfON44K2+J+1Q
	tHtoWxco/eBkbWh8P8OI33+vmugtfNWOuQTyOWCr/GlkVDRVp2Qm1exhVadikLuq1/9AgRAb8rihg
	g2/B7uRvgNj1uTml0/oW5fCaUTT1t1U6HzzDS9hJM34m00Gl27B8/QYwOJ6j3JcKxiYrJn9kaq5G5
	9YxLPI/ckJWmf55DE3H2QWY5iVU7202HddDDZc+6h6T7FlwXwmdfdr9o6Zfqg7r0rDZgYRd22QfuW
	sn/WV2WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzwvt-00000005qvQ-1QK9;
	Fri, 28 Aug 2026 13:47:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzwvs-00000005qvF-1Hjd
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 13:47:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E4EBF408D3;
	Fri, 28 Aug 2026 13:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3CD1F00A3A;
	Fri, 28 Aug 2026 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787924867;
	bh=q0eNhqvMX0/iJyiBrToLKqr6Y2gSqCXGI85V9zCEwnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B8OVBi4twqUHT/S7twyHkWKJvi0Xty50bWZLsgLdUjH3nHQVyiaBK1AsPVPty6GY3
	 CpLNAUUkFEyJ4+w/M1poxHibGE1QkZfvatu0qnlUkyLZ6sB5cRTVmGrT8v0XQDQITu
	 o7t7HCrfJFnRBBj0/q5rE0t6eS5wSCG83cu/ZDFcV2U7x4JtmHAL9mKoaktAxwvPaI
	 NYDwT5qjwRAZkfmmJP8yyRlSIRCkU31HEHBsdlYCRbUSD2/lsmL6OFuAYMqddqUtCz
	 9e4DAviAQYM8qfJvDF2KYmTB4Efky7gFx9GpzI6j0wCr4ltT6ZBU9rIarIEnjsNY8r
	 4KeEra8xa2S/Q==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 407C8198005A;
	Fri, 28 Aug 2026 09:47:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 28 Aug 2026 09:47:45 -0400
X-ME-Sender: <xms:fZGRajO8tbszWQe3PiKqVvkxLMsSZjlif2S9uYt-vjmJEpeOFvfHCw>
    <xme:fZGRahH2nr9VObEBXt262phMqxEp4YMB8N3cIZaF2OTvfKvZa1goN1Mt3jlO2MLhR
    XRBGh-yo1OqJZU_2scto5I2lWzjToiY8e-T_Jdwf5V-V1qBqKdNia54>
X-ME-Received: <xmr:fZGRavucriFI5JGLOyzGMK7DHAHpqFqJWaIRUP3Pm9cs-8ugBLWe2PJg7Ws>
X-ME-Proxy-Cause: dmFkZTGhuVEzINoxJX9iq+sBnTJn/YGfvUD4BbjHGtjEf0PAh/o/tXr2vuzbX9U8fMq0zF
    J5YoWoO47NsZs3vKY4l9KIcKbSS0+BRZwuTUJ9JEu04yQDq/7Q2T0DrqDQ14+GS1y4+Kii
    qbLumtOCdeF31VVkfQ15zMW49EJKPf9ai0w8NgPevT7/2tBdBdQF+5JevWefJ8gD9CFyC6
    vy8t6c7nt9Z81+VYeNx6xVt0oCjgXOQEQ8R1XTjNdsxXQezprFGSM7EVxQoC61FUFtMtjl
    j14I5/V5nIn5meZ617TWS99yg4QSmnCPaVaojmBd58z3obTWdBXUPQx6YOwdozC1RPkake
    b7CQo7h8uFUrdwxo+a+KEEZRo+rgnaAsXWTX3FZp40gpI88PBF5pdoEJQoYaVNDsOYdDLv
    nnOn00p8Mp1YDklKa5PNmImiyNBrjQq3pWispVkCYL/vHtE6rX0yKfGG/mSXj2CxL8wv4i
    r0y0+WYSXNM3YyKgzh/zanZGTQ8dGkGWLsvQDqq9bBRVJpv+ELs7/2/XXATJ4u91Jmv4mc
    tIbaJNv5r4NMz9B8LAhg6+b4cg8ASkvBonDuNoJuQ96vXhlmquzGIh0JUSLqN/uz6B0edi
    gEefM8IBWm9PYMz+eSfeOcqLTGPPyW08nMQUgJOuQmELSCPiO+sNgH26i5Kg
X-ME-Proxy: <xmx:fZGRasTX6KiaE4c_cg9PXtcf5lFwklOXMwCMJ8S4HpMKKGNHaatHcQ>
    <xmx:fZGRaqEkizgCxDrFfZWtyhjb-WQ1yjdKVnYNxlNWXltvS36zBr81og>
    <xmx:fZGRahciHnap5NePGxNCROZtKGgBB-XszR-01EHbjJXxOf2TXxTKDA>
    <xmx:fZGRaqrf2oas2ahHPRsmyNxb7N__Av5_rVQJm6K2AU3sMslJ7AlTcQ>
    <xmx:fZGRauGMdH0cmV4-9-yzqayTn6Pm4Cv2Uey5kNm71uwNCdeE6SiHXVPU>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 09:47:40 -0400 (EDT)
Date: Fri, 28 Aug 2026 14:47:39 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/5] mm/memory-failure: efi: add the
 LINUX_EFI_POISONED_MEMORY configuration table
Message-ID: <apGOr0BAFc1DMQe6@thinkstation>
References: <20260826-hwpoison-kho-v3-0-6f79c4b605bc@debian.org>
 <20260826-hwpoison-kho-v3-1-6f79c4b605bc@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826-hwpoison-kho-v3-1-6f79c4b605bc@debian.org>
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

On Wed, Aug 26, 2026 at 05:03:52AM -0700, Breno Leitao wrote:
> @@ -1271,6 +1274,16 @@ struct linux_efi_memreserve {
>  #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
>  	/ sizeof_field(struct linux_efi_memreserve, entry[0]))
>  
> +/* Bit N covers unit N of physical address space, counting from address 0. */
> +struct linux_efi_poisoned_memory {
> +	u32		version;
> +	u32		unit_size;	/* bytes of phys space per bitmap bit */
> +	u64		size;		/* bitmap size in bytes */
> +	unsigned long	bitmap[];
> +};

struct efi_unaccepted_memory has 'phys_base'. Do we want it here too?

It can be helpful if physical memory starts very high for some reason.
I believe it is common for risc-v.

Tenstorrent Blackhole card has 4G of RAM based at 0x400030000000.
Counting from address 0 that is a 4M bitmap for 4G of RAM. :-/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

