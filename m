Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61566CA100F
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emhyNRhrBwQ4CdpIHjJ4yJ4POd9IH39xkLLPja2O5AI=; b=3T2GkT4O1QhTnGI8rovblqYtTv
	jJs38EVT8c08jcX7YeCt42rbv5o2q7M+29lcrFe9rXM3sApoYS4xF+WgCih0yUXQWQGGlMDzGGJYn
	QCeO54/DuX9QNaw1zRHjsDtKJxqomQ1xSx22yKpgxBXRibZmxJ/tiQ3FHwAYmByutnnLElweYA2OR
	PVVsX6S1DTjtb2bff3QsV7jFUCi7xx9sozqMO/tB/pRnnYosiaTJ8+lj8TQ8kfdlow4qCAk12Cd3K
	k2ZJOhvTp4UaAc17EkpbT10hzxE+bktzoeHub87tWglGvoRErmOfpfYr6E4+rffgzN4qhkrOPNJB9
	xcWBIVTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0peD-0000000Bhf0-3Xmr;
	Mon, 22 Sep 2025 23:08:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0peA-0000000BheU-3LEJ
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 23:08:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 31ABC403F0;
	Mon, 22 Sep 2025 23:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E45C4CEF0;
	Mon, 22 Sep 2025 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758582518;
	bh=QmCUwDfXfg4W2Dr+QVycDtLbh1Xl7d+GJAEjUK5WNlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/360iHNLVYROtKeN/fgEBdD6WzJbXBsP73BrcZHpBpzMiIiaUC0Hk6OtLYrHKxkR
	 g0KelA+qBAZXcUXf20lJgWNGk3lxjQzWxbfHU4DooTmBJABrOB53zHebZwUdQgP6mJ
	 Z7XS8B7HCEcpCgWbA971c0C/FER1G6pMwW4fHT9I=
Date: Mon, 22 Sep 2025 16:08:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, Chris
 Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250922160836.8d0dc984ff0986b3809c9ab0@linux-foundation.org>
In-Reply-To: <8f893019-bd87-4f54-8238-acd8fdeed051@linux.dev>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<8f893019-bd87-4f54-8238-acd8fdeed051@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_160838_852787_C98FF278 
X-CRM114-Status: GOOD (  11.60  )
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

On Mon, 22 Sep 2025 15:31:42 -0700 "yanjun.zhu" <yanjun.zhu@linux.dev> wrote:

> > +int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
> > +{
> > +	struct kho_vmalloc_chunk *chunk;
> > +	struct vm_struct *vm = find_vm_area(ptr);
> > +	unsigned int order, flags, nr_contig_pages;
> > +	unsigned int idx = 0;
> > +	int err;
> 
> This is a trivial issue. I’m not sure whether RCT (Reverse Christmas 
> Trees) is used in the Linux MM mailing list.

Not as far as I know.  Some like it.

If I was to have a preference I'd suggest that things be laid out in a
logical order rather than by column count.  Group like things together,
avoid use of unintialized storage in initializers(!).


