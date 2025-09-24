Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE6BCAC5A5
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fO6Z//rPL79a8R8QZxUtb2XRgOYLfIxN6LnW/zgnSJE=; b=EJgN3zC00mP29OG5XVqGR6rNEm
	QlYxouMV/TxhvwbDWsvSWBhd5YbrA8rrwkY4zxAS11sY/mVCAezpgBF95ZTYzFWahFUYSJqFMXC9K
	huFCoPFORwq+PjSislOXJ0fTynEbegm1QFQEapjnu4Boj1fGztWEHr0J79hVrYPkzDxonbLzVXJ5X
	9OVktLjM4CQkcgVd5vqJauOkQzHreVjORVy2YXxOMZE4PFEP4IY9nhe2Fi4l/n3ebAN1UMt+TFu3/
	r7Ifam9uNM1LlVeqUFlCYrzN8p+rd8OY1dYbXHvOjJ1DyzdZQ6/FgeT+4aZOFatVqFTzuLy1S+NQD
	/VR3l0CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1RPg-00000001G8P-2zL6;
	Wed, 24 Sep 2025 15:28:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1RPf-00000001G65-2GHv
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 15:28:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9EFFD601EB;
	Wed, 24 Sep 2025 15:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F31FC4CEE7;
	Wed, 24 Sep 2025 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758727690;
	bh=O/bKTpvQARqt8FVg/y21EPm0JoWae7amDRNYbxV7ONc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=irQgTQzjfSAjWwFVUQYTRj/oZ1GIQOmw6hdssvbkPidionp5q5qRBCVgMhNc71jUA
	 RpsG9bOvIDFcynHxs5toNX9PmUeYLEkApMwKR07l/VKoaqMkKEi4uDMFbIKmpvCMF4
	 FdTi3dHPyvwoX3cnCcLsFQKRZXASwWuDUzS3vQoQFz2Vn2adC+XM1YHWXIcklNt1p/
	 wYGFAX22klRZ7NuqxsHnDpJjIRZeFh9CCAqb0si0AEFWD9ZP5V67PvFMS8xdbyMuBT
	 V+OlOwvaf35CchUJqb0cx5b/InhHOicYhWFNucyh5gLSkC2/UiOMh2riv7Cjk+T1j/
	 j0+7OvHvZ2RUg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,
  Changyuan Lyu <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
	(Andrew Morton's message of "Mon, 22 Sep 2025 14:34:07 -0700")
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<20250922131948.GX1391379@nvidia.com>
	<20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
Date: Wed, 24 Sep 2025 17:28:07 +0200
Message-ID: <mafs0ikh7dg54.fsf@kernel.org>
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

On Mon, Sep 22 2025, Andrew Morton wrote:

> On Mon, 22 Sep 2025 10:19:48 -0300 Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>> > +static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
>> > +{
>> > +	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(kho_vmalloc->first);
>> > +
>> > +	while (chunk) {
>> > +		struct kho_vmalloc_chunk *tmp = chunk;
>> > +
>> > +		kho_vmalloc_unpreserve_chunk(chunk);
>> > +
>> > +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>> > +		kfree(tmp);
>> 
>> Shouldn't this be free_page()?
>
> Or vfree()?

It should be free_page(). The chunk isn't in the vmalloc-ed area, it is
the metadata to track it. It gets allocated in new_vmalloc_chunk() using
get_zeroed_page().

>
> Not sure why this code works - I'll suspend the series from linux-next
> for now.

It only gets called in the error path and that didn't get hit during
testing I suppose. Until v3 the chunk was being allocated using
kzalloc() so I guess this got missed in the move to get_zeroed_page().

I think Mike is out of office this week. Do you think this series is
stable enough to land in the upcoming merge window? If so, I can send a
v6 with the fix today.

-- 
Regards,
Pratyush Yadav

