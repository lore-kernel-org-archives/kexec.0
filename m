Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2176CAC5A5
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 12:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pv61tD4P8aN8G99P4hprmtnCocCmXPeRvv+dvhxOQIE=; b=fC5gSDY3c3q5zVQHp8o+5euA5m
	tib9+jkC6/cQcrGsPhDnaKMEXWk0zwffzoQjbm3UT6U9baOv07XACj/xU43CQLLZmr+fzjXvlWQNo
	8UmP3tCbJHvDupBKQDxFRPguqZufvWanAMYIDKV+f6xzV6NSJ4nHannpf/Q6fOn/TzNpSo7R1XyIK
	OliDFUFGXa3ECZl88ud6Q3U31mieI/mx9wa0fH4g2KI6RgAS4igQKF3sxVvHY4D5jUDuF8KGJwRYF
	eYifUwR0ZxFite9tdyex0XC1O2UUhgyTfEDEoomiXwXf3rQzOp6vvYF5EYRZXGSF7mVoP2v8SvHi1
	hjaCrBeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1l4Z-00000008y4r-3VxW;
	Thu, 25 Sep 2025 12:27:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1l4X-00000008y3R-49F2
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 12:27:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A90060532;
	Thu, 25 Sep 2025 12:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC7EC4CEF0;
	Thu, 25 Sep 2025 12:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803231;
	bh=TGWxGUpcHpB3h2qtjo8FUCjA58tEH0rqxhAVZjG2Njs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LgSmC1iMmZkyqek98Zpj5gcQK7t8yjVTTPof1tyA11bQLdEY78iNcCpjGdTONyJLF
	 /KPFfdm5h1o3qH5DVQhdcINnsIx1iovkZHJH5syKKIxx2UmSAZB/k5N47BfWnabakg
	 QxcN32NUMwElacrAn4TvYui9oc4//gAXhQl3il/eIzh1gxx0qVXsRu1JKJjGeVhvM4
	 KGSMrULRtssQDuHOcuzL7s7jWWOru4Si0qZvOWhJSuWY4z2o6XeBc8euWU3aGhlD1G
	 pvk95ACwwE7iwDQgNblwJ1vpBg1fGXSi493citgCfqgFLfupa0mLqMoDOnzGTsA6MS
	 Aadu/bJnhvQwA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jason Miu <jasonmiu@google.com>,  Alexander Graf <graf@amazon.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  Changyuan Lyu <changyuanl@google.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason
 Gunthorpe <jgg@nvidia.com>,  Joel Granados <joel.granados@kernel.org>,
  Marcos Paulo de Souza <mpdesouza@suse.com>,  Mario Limonciello
 <mario.limonciello@amd.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Petr Mladek <pmladek@suse.com>,  "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>,  Steven Chen <chenste@linux.microsoft.com>,
  Yan Zhao <yan.y.zhao@intel.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [RFC v1 0/4] Make KHO Stateless
In-Reply-To: <aNUJIsElr5L5uxNv@kernel.org> (Mike Rapoport's message of "Thu,
	25 Sep 2025 12:19:30 +0300")
References: <20250917025019.1585041-1-jasonmiu@google.com>
	<aNUJIsElr5L5uxNv@kernel.org>
Date: Thu, 25 Sep 2025 14:27:06 +0200
Message-ID: <mafs05xd6d8f9.fsf@kernel.org>
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

On Thu, Sep 25 2025, Mike Rapoport wrote:

> Hi Jason,
>
> On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
>> This series transitions KHO from an xarray-based metadata tracking
>> system with serialization to using page table like data structures
>> that can be passed directly to the next kernel.
>> 
>> The key motivations for this change are to:
>> - Eliminate the need for data serialization before kexec.
>> - Remove the former KHO state machine by deprecating the finalize
>>   and abort states.
>> - Pass preservation metadata more directly to the next kernel via the FDT.
>
> If we pass the preservation metadata directly between the kernels, it means
> that any change to that data structure will break compatibility between the
> new and old kernels. With serialization this is less severe because a more
> recent kernel can relatively easy have backward compatible deserialization.
>
> I'm all for removing KHO state machine, but that does not necessarily mean
> we must remove the serialization of memory persistence metadata?

I think the tables should be treated as the final serialized data
structure, and should get all the same properties that other KHO
serialization formats have like stable binary format, versioning, etc.

It just so happens that the table format lends itself very well to being
serialized on-the-go. When a page is marked as preserved during normal
operation, it is very simple to just allocate all the intermediate
levels and mark the page as reserved. There is no further processing
needed to "serialize" it -- like we need to do with the bitmaps today.

So I don't really see why we should introduce an intermediate processing
step when it is easy to just directly build the serialized data
structure during normal operation.

>
> For example, we can do the serialization at kernel_kexec() time and if we
> want to avoid memory allocations there we might preallocate pages for
> khoser_mem_chunk's as amount of bitmaps grow.
>
> It also would be interesting to see how much time is saved if we remove the
> serialization.

-- 
Regards,
Pratyush Yadav

