Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142E606A33E
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QHDUSU4k;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7Lr7h2H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8qHTsTGMbRUu4uHJjKWa8mMXyZqa434909JPIyvfASg=; b=QHDUSU4kVrcyyNj6Ckh6HTyp7+
	GtzFWiVa/OyE7NnN0VcDb+xmXStsqAVf1eoxyHpG017IwaheFu/RUpJJq3/Wwtz7h7FXcJbluKlMU
	Lc2CY005xNlWbkctw26yvX7PhoNZU/EsA8s3hUlEXyyplsxbaFWrBvKaYPgRlATLZ8CcmrDSinwjU
	fbeeVEzBojGWGfm5NyGQMcfU7bmOgZe7L2cW7HUHE+68qj9XLw4V6Y8+jrALwbyo53PMFITKXg3Ov
	U2axWs1VaMJGIAviglfWE8TdbKuWCW+6DzLPZ6XrDC0rN2XQRbksiSDyT0O1Uevu5kCdwvMA1fOsC
	UCvsNCfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIA3-00000005bac-44RE;
	Tue, 17 Nov 2026 12:19:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIA3-00000005ba9-08tO
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 12:19:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30529429F2;
	Tue, 17 Nov 2026 12:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DB71F000C4;
	Tue, 17 Nov 2026 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794917982;
	bh=8qHTsTGMbRUu4uHJjKWa8mMXyZqa434909JPIyvfASg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=J7Lr7h2HCcgTuVQeG8fRdX1IORtvd+WG/QKrKgksiuuBAwy5PUrWttWaBgbQS4H8S
	 +EgMMP+IqOirMk9hGcIyY9WsoYaVKR0dIYN7CN65qdqCDdOQqVenj6SaYIGh3iXEv9
	 U+6Di/xavaw+hN85Ql0/4V6FUOGEPFsmDMcWMCC+wcDkXdAuxucNzfsGSW5rfi6Vo+
	 PHXlulLyptBwr4ni6mh56hYPqWO77XVkXAK4NMXl3X6siimEarGlGJVr7FogKDftmU
	 vkZMZLknl5jyFa6uP8mzNs8f3AWWO6MYFfTrD/3tElPEzr1KANCYN6qsP8TS8l+lcj
	 7xe/CNz6RyxGw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Alexander Graf
 <graf@amazon.com>,  Jonathan Corbet <corbet@lwn.net>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Tarun Sahu
 <tarunsahu@google.com>,  David Matlack <dmatlack@google.com>,  Samiullah
 Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] KHO map
In-Reply-To: <avwoBj5ceKYjcS9G@chrisdown.name> (Chris Down's message of "Tue,
	17 Nov 2026 02:10:14 -0800")
References: <20261116134013.1636689-1-pratyush@kernel.org>
	<avwoBj5ceKYjcS9G@chrisdown.name>
Date: Tue, 17 Nov 2026 13:19:38 +0100
Message-ID: <2vxz1p8jhcpx.fsf@kernel.org>
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

Hi Chris,

On Tue, Nov 17 2026, Chris Down wrote:

> Hi Pratyush,
>
> Pratyush Yadav writes:
>>The main user of the map is memfd. Currently memfd uses a vmalloc buffer
>>that has a pair of {index,pfn} to track the folios in the file. That
>>uses 16 bytes per page. The KHO map uses only 8 bytes per page with some
>>overhead. So for a 1 GiB memfd, it uses roughly half the memory.
>
> That only holds for order-0 folios though. A leaf covers 512 indices, so
> a populated memfd needs one leaf page for every 2M of file whatever the
> folio size, while the array needs 16 bytes per folio. Per 2M of file,
> that works out as:
>
>     folio size   array    map     map/array
>     4K (o0)      8K       4K      0.5x
>     8K (o1)      4K       4K      1x
>     16K (o2)     2K       4K      2x
>     64K (o4)     512      4K      8x
>     2M (o9)      16       4K      256x

Right.

>
>>- Multi-index entry support: currently, while the map is very efficient
>>  with 4k folios, it is horribly inefficient with 2M folios. Each folio
>>  in the memfd takes up a full page to track. Multi-index entry support
>>  can fix this by tracking entries that cover a whole page in the
>>  previous level, similar to page tables.
>
> Since patch 5 makes things worse for memfds with large folios, I agree
> with Pasha that this needs fixing before memfd switches over. Storing

Right, I agree as well.

> PMD-sized entries at L1 fixes the 2M case, but mTHP sizes between 4K and
> 2M would still take a full leaf for every 2M of file. Do you expect
> mTHP-backed memfds to be preserved? If so, it's probably worth handling
> them in the format before it becomes ABI.

mTHP will still work, it will just be less space efficient than 2M THPs.
Even then, the overhead is around 2M for every 1G, which is roughly
0.2%. Even then, I don't think that is too bad. If you want to be more
space efficient, use 2M THPs, or hugetlb[*]. I think that is a fair
tradeoff. Using larger page sizes also makes KHO more efficient.

We _can_ make mTHPs fairly efficient, but that comes at the cost of a
more complicated ABI. For example, we can have a per-order KHO map in
the memfd, and shift the keys by the order. That should improve the
density. We could also do some other tricks like the shifted key
encoding scheme that KHO preserved memory map uses (see
kho_encode_radix_key()) to improve density.

So unless someone can explain why mTHP memfds are important to optimize
for, I'd say mTHP users can either take the 0.2% preservation overhead,
or use 2M THPs.

[*] I sent an RFC for that some time ago, but it's been blocked on
    pending infrastructure rework like extended bootmem. I plan to send
    out a refreshed version soon.

-- 
Regards,
Pratyush Yadav

