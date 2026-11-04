Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD4606D821
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bK4mw/Zi;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=gzTXmkeW;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=vj1HCCKS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Unsubscribe-Post:
	List-Owner; bh=q9RBWwFn63CofyiYGd/4lZu+7oEXCckEZxKnFr8wcCE=; b=bK4mw/ZiKbRr7N
	6jqfpfdrLPdHHqy1B9PTTspx/FmCoepikmIJQixUKxzds2+5aZNoFNJHFauldYx2KeRQgazVykvlV
	FP5uI9uCtfi9SO5Uf5hUdDQjy409ibxgFsUAl4z49J1dZFYOM1KlaSpzUMP1/1pWIzDWKxvM0aWD9
	Lp5j4VMUShZP/mvuuipW4N3mmDssnNHNkV0pxIIP5WG5SxPumUkct4nTzcYZ2v33yZ02tdgRUSfRj
	CEy5+hyMP9xe+c/s7NCUhpVyMiIbjeVsf93tDklpbc2N1Sjgi0MEWClP/YGWH6+51kRvndimj/PZw
	/7rtDBaCrGikNvkncVwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgUU-00000006Y9O-32Yu;
	Wed, 04 Nov 2026 19:17:46 +0000
Received: from mail.mainlining.org ([5.75.144.95])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgUR-00000006Y74-3Lf5
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 19:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793819801; bh=q9RBWwFn63CofyiYGd/4lZu
	+7oEXCckEZxKnFr8wcCE=; b=gzTXmkeWedj7jRMbeoQJEsmjhBNYW0Lz0whmZZ73mqb7xJZGUK
	Pe3GeqEi0YHA8IMGoQjJ6VQ9UKvEL4/euRcCjSWuqeS/jTZ7JIhiFfebuUdX9Un2iagtAm68SZt
	g7ZhuBIynlrhXulbo9J3JRKsx9wxWsYU2x2BPzgdTE7MCCK6YCDWhgQ920TUXS6NRsOiNvdButH
	WgYg8ppX9lCVITHtxFrJ1HqUx3Dpy4To8lAiVPJ3qLIb++DPgaNIj2jhB8RUpLAl2tl2RpRTkbK
	8rDrIqoPH2r4wAGVZ7MjTghGFhAfoGgFd9BVRTBklEbCN2TikRBZ6m/m/dTgkHFODqA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793819801; bh=q9RBWwFn63CofyiYGd/4lZu
	+7oEXCckEZxKnFr8wcCE=; b=vj1HCCKSlnZcl02DJs+dAIAwPBQk/jfbwXDewIbV+HhF7idwxm
	6+RapBxR5/PdGjgGbwAAC8XvAfJkeOLtMbBA==;
Date: Wed, 04 Nov 2026 19:16:42 +0000
From: Bradley Morgan <brads@mainlining.org>
To: usama.arif@linux.dev
CC: akpm@linux-foundation.org, baoquan.he@linux.dev, david@kernel.org,
 hannes@cmpxchg.org, hbathini@linux.ibm.com, jbohac@suse.cz, kas@kernel.org,
 kernel-team@meta.com, kexec@lists.infradead.org, leitao@debian.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, pasha.tatashin@soleen.com,
 pratyush@kernel.org, riel@surriel.com, rppt@kernel.org,
 ruirui.yang@linux.dev, shakeel.butt@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_crash=3A_keep_crashkernel_C?=
 =?US-ASCII?Q?MA_pages_reserved_if_activation_fails?=
In-Reply-To: <20261104145600.3708886-1-usama.arif@linux.dev>
Message-ID: <661AFDEC-B8DF-4A5B-8C58-1D39F518F068@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_111743_990577_CE2F3E01 
X-CRM114-Status: UNSURE (   8.17  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4 November 2026 14:56:00 GMT, Usama Arif <usama.arif@linux.dev> wrote:
>reserve_crashkernel_cma() adds each crashkernel CMA area to
>crashk_cma_ranges[] as soon as it is declared. If the area later fails
>activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
>inside it, cma_activate_area() releases the pages to the buddy allocator
>as ordinary memory. The range is still handed to the crash kernel and
>excluded from the vmcore, so kernel data that lands there is overwritten
>by the crash kernel and missing from the dump.
>
>Mark the areas with cma_reserve_pages_on_error(), so that a failed
>activation leaves the pages reserved: lost to the first kernel, but safe
>for the crash kernel to use.
>
>Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
>Signed-off-by: Usama Arif <usama.arif@linux.dev>
>---
> kernel/crash_reserve.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
>index a03f0a4305a4e..a4b616ed49482 100644
>--- a/kernel/crash_reserve.c
>+++ b/kernel/crash_reserve.c
>@@ -498,6 +498,7 @@ void __init reserve_crashkernel_cma(unsigned long long cma_size)
> 			continue;
> 		}
> 
>+		cma_reserve_pages_on_error(res);

You do know that this will activate under every bitmap_zalloc() failure,
right? Is that accounted for?

> 		crashk_cma_ranges[crashk_cma_cnt].start = cma_get_base(res);
> 		crashk_cma_ranges[crashk_cma_cnt].end =
> 			crashk_cma_ranges[crashk_cma_cnt].start +
>

--- Thanks!

