Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C61606A32C
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RoQXcDVz;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=luMnxL52
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=rNNVTnTy0cTlwSmGHiRKlZ2iEy2+6bJGyVdMK3sWxNI=; b=RoQXcDVzIhwYHJPI7RKcC9WuVB
	hY7d/lJ3mXvOxWN71zoyDZNgqgF7ZWgCsDAnj3w0jNR+9U+OlULlEiY/+6GQrvYKrpTeVyPgxF7iO
	hHf4bH3TuSmrzLOFXNQn6SJ1tCP3qVt3WDUz0tQYvwUJLau/MoVNUKxL5mGqw0xzh5FOBwnF1RZOp
	FwZbMnaVOpXMXTebYDZRRV+joK+0LFE30H0rvnzC+qOmcOJfEjFado+3sEviwKtLq35L2t5+882V6
	QCOdgXI2lcaCwUH4lZd8ptu1iBQZtRtOA9CHgTD/V7hH9V321X5r0eS4VscOwuSnO+Awm3lneC7oY
	44sj9EgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcPM-00000005hob-3Q8e;
	Wed, 04 Nov 2026 14:56:12 +0000
Received: from out-215.mta0.migadu.com ([2001:41d0:1004:224b::d7] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcPJ-00000005hnx-41vp
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 14:56:11 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=WiQsxdd6QhzAPp2ldpcECaeiN+cck/9lOboIQqVqld8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793804168; v=1; x=1794408968;
 b=luMnxL5285DUzIM2AnuE7vWel01YwA/GscQp5xVB+8cHNDMDiOZSJ1K2BKeLcoMm3HYtfixX
 PC2yI/o6bOXb/2ZmmM/rU7qTaqvh6WDG6BELEtTyoO1wlDlh+yhQfa0VhyGoHUarl54v1XDvkGY
 4P/osjJMqUFZVmeWRk762eWU=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id f8a97d86c29cc177;
	Wed, 04 Nov 2026 14:56:07 +0000
X-Mizu-Trace-ID: f8a97d86c29cc177
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	jbohac@suse.cz,
	david@kernel.org,
	hbathini@linux.ibm.com,
	leitao@debian.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] crash: keep crashkernel CMA pages reserved if activation fails
Date: Wed,  4 Nov 2026 06:56:00 -0800
Message-ID: <20261104145600.3708886-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_065610_357669_026BF2AF 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

reserve_crashkernel_cma() adds each crashkernel CMA area to
crashk_cma_ranges[] as soon as it is declared. If the area later fails
activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
inside it, cma_activate_area() releases the pages to the buddy allocator
as ordinary memory. The range is still handed to the crash kernel and
excluded from the vmcore, so kernel data that lands there is overwritten
by the crash kernel and missing from the dump.

Mark the areas with cma_reserve_pages_on_error(), so that a failed
activation leaves the pages reserved: lost to the first kernel, but safe
for the crash kernel to use.

Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/crash_reserve.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index a03f0a4305a4e..a4b616ed49482 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -498,6 +498,7 @@ void __init reserve_crashkernel_cma(unsigned long long cma_size)
 			continue;
 		}
 
+		cma_reserve_pages_on_error(res);
 		crashk_cma_ranges[crashk_cma_cnt].start = cma_get_base(res);
 		crashk_cma_ranges[crashk_cma_cnt].end =
 			crashk_cma_ranges[crashk_cma_cnt].start +
-- 
2.53.0-Meta


