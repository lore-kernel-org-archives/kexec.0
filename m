Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CE7CD37B9
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZQJxSREndNeWY0QSKayND5FwKAqjDoolWABKOjg8Z8=; b=DC/OY2tqysuIF26+9lxTl+MnGB
	K2LkjoHpUihldyRmFtTEhzRCRlw34llqs+19L9ZX21fTzRfjcNP4nVFkZHbGQpy6kSoNImeYuGWR8
	S+Mrt14sDPFdAQ/rDvJTCi1PDoD0/SsSBBPCo0p4Jpuo8ZqyTn93ufP+yhGBmeBpTodZY0Oa/DdJx
	y9BoWG1kUpgjEbmlY6bypKspUBBGoCm9/X1/VniGFXmAYcaEUgbFvk8deNQFcFj4/6qLLI5YQDGo6
	Wg94xSfJ9kgEom/p92jQ7ESJA35hJOcp+8FFJHJElCWidLggMPngV+ZY6kZwSInd6eN7/YZZzX2CZ
	uwf4YoxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPGt-0000000DQxS-21nQ;
	Mon, 11 May 2026 11:58:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPGr-0000000DQwK-0TIE
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:58:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 76EB243665;
	Mon, 11 May 2026 11:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31CFC2BCB0;
	Mon, 11 May 2026 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500680;
	bh=8u/DkKbzXWz4HHmWqQJvvG6MveKLzCay21kFajVzBDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyOb0IU7gWFYiZYPYVc9Idy05AXZUQqn0+9mA2PrU8CqATbLjZ/IXu4XueHk6D/El
	 uughM/5K8wRXiCWef0BGpGBLq66eSgqPYBRp2HsLSEaKB29nQpg2dFYvKAJoA/4DYu
	 go/hJdBidE248CdbZU6yTwpaj0FbymnsTw7ZPk0iURif9+JsOciWDfiwEevphDryGQ
	 0L+r4olBP21lQua8ciU0/Wbqqf2o78/u7RybbJZOEu2G8cq/2IEmHwBFs63uzEUGRR
	 8BEQzH9R9ktBtBioOaX06+c6+17QhwC6xgvpr68n9FvnJ5PF+lT1N35kaC7DyU5jgG
	 1wDhQKB09BO3A==
Date: Mon, 11 May 2026 14:57:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] kho: allow destroying KHO radix tree
Message-ID: <agHEQYbDmeOiH5IU@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-8-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-8-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_045801_173974_A2EA205A 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message.
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

On Wed, Apr 29, 2026 at 03:39:09PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Add kho_radix_destroy_tree() which allows destroying the radix tree and
> freeing all its pages.

A sentence why it Will be useful would be nice.
 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kho_radix_tree.h     |  3 +++
>  kernel/liveupdate/kexec_handover.c | 34 ++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)

-- 
Sincerely yours,
Mike.

