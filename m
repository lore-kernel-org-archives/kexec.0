Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53366CAC5A5
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 05:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Onfd9zYeL+OEf7fiK3TSj5PyIeGLL4m+H+3TpOEWGw=; b=EguJmyFV+wt1AO3UbVMnvxWUpy
	Uz8k0xFp+rIyyIhOZTkqzOrvQE/gPdszDvFf9Fb1u46az245qb0HaVozhhINrB2ffoabdCYfyjD9B
	SG5X1XlHQj+gjnaq4FwfPMv4uoKpqMcsjsDkKpTQM/w27gXyIlKICPioiZvRISVFa2jgZXPxhdGE1
	OG+9iOKeIKmfT9qnLw9HHeWYucZxCRuk/F6EYja+ywf/kx6Ik5hrxpk1CBlb7PCw6+fWRU3r1xi2i
	6RLSsCH2QtOh6/sz7tk82Ka4KsRCPVUUiioXH5jTkgkRbxpn9fIH9ZDGDTSiyNubPcpfook9QuDBN
	bXaKv5WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0vDJ-0000000CNMO-2Vg2;
	Tue, 23 Sep 2025 05:05:17 +0000
Received: from out-180.mta1.migadu.com ([95.215.58.180])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0vDG-0000000CNL7-2ISP
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 05:05:16 +0000
Message-ID: <188710e0-6683-4bc3-af64-9ce1e8ae4b32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758603911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Onfd9zYeL+OEf7fiK3TSj5PyIeGLL4m+H+3TpOEWGw=;
	b=wfMr0eHeLbrLQ3sqtgI2OVXU+fV60p1sUB/DRs87DoUK/bMRNC4UeVwc39oy5L5HYtrIPB
	UuGFzBIT8H/WQDm1hHKQaQgxnfYPN588eHXLx3TqjzoVP1ycc6nan7+cJ3fYu108XfXhnz
	576/7u+y7X6gLaAvm4NFwihKHjXOiNo=
Date: Mon, 22 Sep 2025 22:04:52 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
 Chris Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250921054458.4043761-1-rppt@kernel.org>
 <20250921054458.4043761-4-rppt@kernel.org>
 <8f893019-bd87-4f54-8238-acd8fdeed051@linux.dev>
 <20250922160836.8d0dc984ff0986b3809c9ab0@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250922160836.8d0dc984ff0986b3809c9ab0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_220515_265447_BFB3F792 
X-CRM114-Status: GOOD (  12.69  )
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


在 2025/9/22 16:08, Andrew Morton 写道:
> On Mon, 22 Sep 2025 15:31:42 -0700 "yanjun.zhu" <yanjun.zhu@linux.dev> wrote:
>
>>> +int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
>>> +{
>>> +	struct kho_vmalloc_chunk *chunk;
>>> +	struct vm_struct *vm = find_vm_area(ptr);
>>> +	unsigned int order, flags, nr_contig_pages;
>>> +	unsigned int idx = 0;
>>> +	int err;
>> This is a trivial issue. I’m not sure whether RCT (Reverse Christmas
>> Trees) is used in the Linux MM mailing list.
> Not as far as I know.  Some like it.
>
> If I was to have a preference I'd suggest that things be laid out in a
> logical order rather than by column count.  Group like things together,
> avoid use of unintialized storage in initializers(!).

Thanks for your input. I consider this a trivial issue. RCT will help 
make the local variables more organized. Since the Linux MM code does 
not currently use RCT and prefers to group similar logical variables and 
initialize these local variables, I am fine with the current approach.

Yanjun.Zhu

>
-- 
Best Regards,
Yanjun.Zhu


