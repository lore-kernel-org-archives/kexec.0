Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811E3CAC5A5
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ynT/KcSEPgcvXp8oJe87fiXQ3vmBqLD0XZv0bdPzvc=; b=Zk3SSrWSxS49xJojUiHiCozRh4
	roFdW6WQuu1cF7dRBZag+d6TPvaOQTqtQ4hRe78SNJzElsBeWsYYoCl3tiLswwLNWO/js6zo+pgxm
	ZQN0PR6pKg3934+wm2bHqcD88moB9pkq5OoWSx7pjJABkxgl6ACOhqnb3MATuDlozGpvLkLNHVDdc
	ESLtz0NAm82qQZzsu6Zz00lvkLawTqF5iUKSlil44+DC8bAykarE6qxbxISmGXxBdwKszHeDpkDnC
	L66/FneK0pPpGKfbrPdqPBwruHQUkfaWZVm3sD3jOtVgTKRUu45q1ijrbGbdGFFlTD3fspUsWxh14
	vOilnKQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1k3o-00000008The-2oxy;
	Thu, 25 Sep 2025 11:22:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1k3n-00000008Tfc-143C
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 11:22:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 89553604FE;
	Thu, 25 Sep 2025 11:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A71C4CEF0;
	Thu, 25 Sep 2025 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758799370;
	bh=7TY6Mv3GwQKn2+eNHs40STB/z7xZBiylOf9OH7ebP48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OGgHpGxJfEAD//pye7XhrdBdEIhkzl82PuN1xG6OAN75cjulysEjTDqJBVQsKMi5k
	 5vactApsBqJ3kNJoOtqetfcrquQnTyhznPvCFgl93rBrgU3qYHIKF009R0+iJ5oxS0
	 MUIY+CV/PcVMYs66C2FZUJHD2BDRM0PrTVAFyRwkKNMpNZY2zAI9NkWimrMXNIr4oF
	 9ufivXjaY4WvfybMmXR8BPiTzbW6IUXtM4yLrCSh4tvAKjzYfYbypNmRfRRznE+UsI
	 T9K3JWhWHTJUDUQJ/2nrPko8f5v/MWhexD2+ZS4NADYSZdcrZppbQfkfEuSdOAxZEA
	 b8pBHwFAHMS1w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Mike Rapoport <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Baoquan He <bhe@redhat.com>,  Changyuan Lyu <changyuanl@google.com>,
  Chris Li <chrisl@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250924140010.81305926b42d0223dcf3b818@linux-foundation.org>
	(Andrew Morton's message of "Wed, 24 Sep 2025 14:00:10 -0700")
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<20250922131948.GX1391379@nvidia.com>
	<20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
	<mafs0ikh7dg54.fsf@kernel.org>
	<20250924140010.81305926b42d0223dcf3b818@linux-foundation.org>
Date: Thu, 25 Sep 2025 13:22:47 +0200
Message-ID: <mafs0a52idbeg.fsf@kernel.org>
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

On Wed, Sep 24 2025, Andrew Morton wrote:

> On Wed, 24 Sep 2025 17:28:07 +0200 Pratyush Yadav <pratyush@kernel.org> wrote:
>
>> >
>> > Not sure why this code works - I'll suspend the series from linux-next
>> > for now.
>> 
>> It only gets called in the error path and that didn't get hit during
>> testing I suppose. Until v3 the chunk was being allocated using
>> kzalloc() so I guess this got missed in the move to get_zeroed_page().
>> 
>> I think Mike is out of office this week. Do you think this series is
>> stable enough to land in the upcoming merge window? If so, I can send a
>> v6 with the fix today.
>
> A one-liner fiup would be preferred, if no other changes are required,
> thanks.

--- 8< ---
From f746718a99da3c670089a42f7c59660b455f265d Mon Sep 17 00:00:00 2001
From: Pratyush Yadav <pratyush@kernel.org>
Date: Thu, 25 Sep 2025 13:05:08 +0200
Subject: [PATCH] fixup! kho: add support for preserving vmalloc allocations

Chunks are allocated using get_zeroed_page() so they should be freed
using free_page() not kfree().

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e6380d8dce574..d06ca232683cd 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -885,7 +885,7 @@ static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
 		kho_vmalloc_unpreserve_chunk(chunk);
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		kfree(tmp);
+		free_page((unsigned long)tmp);
 	}
 }
 
-- 
2.47.3

