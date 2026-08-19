Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB22C5DF89
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xhsxQv3y79BoPZ1auAVTOrY0Ii21yucenX1lTIQciM=; b=s/7iwlMFwMcw9HVeKWXWoGYvj7
	caeU8oybTtxjSNv2tdZgUGP6ribQUIJDZXSie7tux2QEoB0uPz6D3xdlsvvDv6NLfCD8ldi22BC2z
	pposx5I/7za58RiUAYtAeeq3czg2e3bXeXpmcutxFJ3DYW8JVEBXHzKRkT5R/HBhuexK5pcTnubrd
	98ROCQ4rYnN8W7AROvsjWXymPKCQkF166S5H/sJLa9U84Ou7frEnxlcLnlWHCfUshQ8CAuoWMM2bN
	dgUbHBTlYWkKh9GKYZd4lFxrMJieNyY0Dy01lJWvR2jcUQrNrz6Y/04SEE2gAsdWo3m1mEm1KmMIJ
	jcRxugsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwdXK-00000009YC4-2bR7;
	Wed, 19 Aug 2026 10:28:46 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwdXB-00000009Y3W-0Tqc
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 10:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5xhsxQv3y79BoPZ1auAVTOrY0Ii21yucenX1lTIQciM=; b=vrFq7bGgZ8OVvCCw7E7GGeyQ9o
	8BKhCVCvJVQM37dcZrFzK2Fwta26qOB/tl/4c8EQ/Qejg8tbDm6dFi9LvvdWeHxA9tfC2tXa0iBUC
	bb3NFM6YPczL1dcm1aGnzlyAzT2dO2F246MkH7nXhWUYeOfCN95+PVOfFc+NlobQN5a/QJTK4G6OB
	aKVq4a85UqxfotRiM7ZeNXtBDOZ+DQ2XxDdQY1jW33unn522df++A5CqtwsJlPr8kw29OBUwrdbcF
	u+kaezwZFiW4xmWm6TgFMV1C2jZqNhZmidbxcsuxYluseRKZ33ZnRJeRo4BXTQ76Xu+9Ht6naH3qS
	a0ukrU/w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwdWi-009j7Y-22;
	Wed, 19 Aug 2026 10:28:08 +0000
Date: Wed, 19 Aug 2026 03:28:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, kernel-team@meta.com, 
	Kiryl Shutsemau <kas@kernel.org>, Bradley Morgan <include@grrlz.net>
Subject: Re: [PATCH v6 0/2] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <aoWEmbTWYU7wSQWb@gmail.com>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
 <aoV5EfBtlWcyf51E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoV5EfBtlWcyf51E@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_032837_166318_613463C1 
X-CRM114-Status: GOOD (  14.78  )
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

On Wed, Aug 19, 2026 at 12:36:17PM +0300, Mike Rapoport wrote:
> On Wed, Aug 12, 2026 at 04:31:50AM -0700, Breno Leitao wrote:
> > Memory failures are common enough on large fleets that kexec regularly
> > lands the next kernel on a frame the memory failure subsystem has already
> > marked bad. Patch 2 teaches the segment placement to avoid those frames.
> > 
> > Patch 1 is a prerequisite. locate_mem_hole_top_down() walks candidates
> > downwards without ever checking that the subtraction stays above zero, so
> > the walk can wrap and report success with a destination outside of RAM.
> > Patch 2 adds one more downward step to that loop, so the bug is fixed
> > first and both patches rely on the same bail-out.
> 
> I queued this for v7.4, the patches will appear in the liveupdate tree
> after the merge window.

Thanks Mike.

I'll now get back to the most ambicious patchset that carries poisoned
page information over to the next kernel, so memory failure information
survive across kexec:

https://lore.kernel.org/all/20260717-hwpoison-kho-v1-0-9c5eda551998@debian.org/

