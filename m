Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30B7CAC5B0
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/knSdUCFMG3lWF+vWXfJAJaG5rbjtKiF+qySoPplzo=; b=wbsnWBojj5LT2JjW0hXTCcwOe4
	NSDKcbHhWuXln5WONhGKna66PxLBd1//hEDc8naVHemJ0mm8geH9Wwl12jZImoqVNJT50UauPKtD7
	v0nj1N/+4toxZ+zLbIPB+g3GDcA3L8kvUITZ5vX3XFg6M5yfc/aQTDlH2CJ/O/+Vq0Rwji54zu+Zi
	RQiaFAayN/qyl+YbdJVnUgVr9yLzJcjuzeHvqya8J9UrdV9BhrynycILbFT4JANbT6rOslPbVCQxy
	2Dw1psyZFMWMB9MuEOLcnPqQsHdDrDl9pd+YQWkTeEZULnZAssSqGrOJ8r3ASKI5/NnG7siKPYwdB
	KYNSxSUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Wb0-00000003ivU-3ajo;
	Wed, 24 Sep 2025 21:00:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Way-00000003it9-0uVs
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 21:00:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8FA2D44B8E;
	Wed, 24 Sep 2025 21:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19600C4CEE7;
	Wed, 24 Sep 2025 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758747611;
	bh=dDJN8b77rN9ysunvOFha1XEVk2yflq4396QA+xCKryA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qANOd8KCLjLmqepp6rdBNv6MmCrjJQdAU6quKdt1acGS2IMaHi6blrwkvKzfR/A2g
	 pLanFR4po7eEdJLjiTLqiKCNSElQhay+3N7EYlL820XKuZIP0G1rqUhse3aEbpG/jt
	 YQ4zbJV7UVgLhM7jEUz3SZDs4Wg2MoCAuIB9KoM8=
Date: Wed, 24 Sep 2025 14:00:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Changyuan
 Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250924140010.81305926b42d0223dcf3b818@linux-foundation.org>
In-Reply-To: <mafs0ikh7dg54.fsf@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<20250922131948.GX1391379@nvidia.com>
	<20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
	<mafs0ikh7dg54.fsf@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_140012_300226_25759F23 
X-CRM114-Status: GOOD (  15.04  )
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

On Wed, 24 Sep 2025 17:28:07 +0200 Pratyush Yadav <pratyush@kernel.org> wrote:

> >
> > Not sure why this code works - I'll suspend the series from linux-next
> > for now.
> 
> It only gets called in the error path and that didn't get hit during
> testing I suppose. Until v3 the chunk was being allocated using
> kzalloc() so I guess this got missed in the move to get_zeroed_page().
> 
> I think Mike is out of office this week. Do you think this series is
> stable enough to land in the upcoming merge window? If so, I can send a
> v6 with the fix today.

A one-liner fiup would be preferred, if no other changes are required,
thanks.

