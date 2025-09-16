Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5C6CAC599
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fprz1xZ/mcGg42/AgPY7FztcFyFx3gVlKE+V0o3eZVo=; b=GBW1r+6R2a1wdb6bUUVkIbMkrR
	tVf1gLwmLRKlzyrySb8aBwpVnRMxp0CnosEeNhU8xHKrTsQzOImahHHC2LpPvyp1Z7R/hjXBhkB5R
	z+D2dicvgtQzLcM4f4vChHA1He/UVwI4iINJGD7kbXz9NKRBU9UKiWL3E6cncTrZJs+Bd7LN1BWnG
	JKvNtdW3e6gPiPWulGT9bzt015N7O5FHaEzgPJ0BCZjRWwk4wgkm4yFZmYP12l9573KGN3NQBYN0s
	A+ZDv3nogfC2iRBaeqfs/1R7YJQcTGuVTMekboUTXZgj6cFLLJR76Zq6tlUt1zM7y4Wgmw5TnTAcg
	oyJk+5aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyV7F-00000007pF6-14GA;
	Tue, 16 Sep 2025 12:49:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyV7C-00000007pEb-2qhB
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 12:48:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DF104385A;
	Tue, 16 Sep 2025 12:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E8FC4CEFB;
	Tue, 16 Sep 2025 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026938;
	bh=4YrNCsR+tG6pZaieZYZjT9mkupyBVaPEFfVB53YgEk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vG3T6Zf8eW6m6XVKvRviu1cHQLljMJq5lwAFbzIkX5FUvGZ4IpWXPGB+bfYW8Opw+
	 x+2weGhsEjE6UQyH4e+9ijZMK7z7o79BmY6/6ylGHainjNYeL2+p+ufqOaN9Elhptk
	 a5vP7PNrFKMzSQYZDyzuYtHHJ1sSxIw3JmmEo78UwhABYMMSaUJZKTZ9pX4nEOTLf5
	 gB/PKSYEaJen/ooKrHcipAnXazTz3u27GESDjb8ZV/ByfIFKApWEsXPM0FirrZaNO5
	 dLT0zncbTLr1XqK/ibIDwWC3ARmDV3C6/TR03oFFTVLlRb4KKj5S1yyISWRJELS4pe
	 vbrsWgY0cJB5A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Alexander Graf <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,
  Changyuan Lyu <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,
  Jason Gunthorpe <jgg@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc allocations
In-Reply-To: <aMgey9qEC_XUejXm@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
	<20250908103528.2179934-2-rppt@kernel.org> <mafs0ldmon784.fsf@kernel.org>
	<mafs0ldmnlmq0.fsf@yadavpratyush.com> <aMgey9qEC_XUejXm@kernel.org>
Date: Tue, 16 Sep 2025 14:48:55 +0200
Message-ID: <mafs0bjnaimvc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_054858_755422_7E37D1DE 
X-CRM114-Status: GOOD (  21.64  )
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

On Mon, Sep 15 2025, Mike Rapoport wrote:

> On Tue, Sep 09, 2025 at 04:33:27PM +0200, Pratyush Yadav wrote:
>> Hi Mike,
>> 
>> Couple more thoughts.
>> 
>> On Mon, Sep 08 2025, Pratyush Yadav wrote:
>> > On Mon, Sep 08 2025, Mike Rapoport wrote:
>> >> +
>> >> +	while (chunk) {
>> >> +		struct page *page;
>> >> +
>> >> +		for (int i = 0; i < chunk->hdr.num_elms; i++) {
>> >> +			phys_addr_t phys = chunk->phys[i];
>> >> +
>> >> +			for (int j = 0; j < (1 << order); j++) {
>> >> +				page = phys_to_page(phys);
>> >> +				kho_restore_page(page, 0);
>> >> +				pages[idx++] = page;
>> >
>> > This can buffer-overflow if the previous kernel was buggy and added too
>> > many pages. Perhaps keep check for this?
>> 
>> Thinking about this a bit more, I think this should check that we found
>> _exactly_ chunk->hdr.total_pages pages, and should error out otherwise.
>> If too few are found, pages array will contain bogus data, if too many,
>> buffer overflow.
>
> Sure, I can add the checks, but it feels superfluous to me.

See my reasoning in the other reply:
https://lore.kernel.org/linux-mm/mafs0frcmin3t.fsf@kernel.org/

>  
>> Also, I am not a fan of using kho_restore_page() directly. I think the
>> vmalloc preservation is a layer above core KHO, and it should use the
>> public KHO APIs. It really doesn't need to poke into internal APIs. If
>> any of the public APIs are insufficient, we should add new ones.
>> 
>> I don't suppose I'd insist on it, but something to consider since you
>> are likely going to do another revision anyway.
>
> I think vmalloc is as basic as folio. At some point we probably converge to 
> kho_preserve(void *) that will choose the right internal handler. like
> folio, vmalloc, kmalloc etc.

Sure, but do you need to use the internal APIs? Because doing this way
would miss some improvements for the public APIs. See my patch for
adding more sanity checking to kho_restore_folio() for example:
https://lore.kernel.org/linux-mm/20250910153443.95049-1-pratyush@kernel.org/

vmalloc preservation would miss this improvement since it uses the
internal API, even though it will clearly benefit from it.

-- 
Regards,
Pratyush Yadav

