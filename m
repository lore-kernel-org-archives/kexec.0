Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC4BCE79A1
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jjIZwDkeRaIatCGUH3Is0PX0bSWnFFYBxtfZ2dNWDpc=; b=I3eW1mzOhwLZev
	qpxo6bD4NZk1XywnF02ttQifKALsx3S/To105XQ+MHXHExceHtFtITES+LukLfTjBunJrCrCIW1yN
	rT59rqof9Vw7g2JEZWYn6CRoWVZI/lcNyXpPIKyZe8oz9VXSPmuH4glZ1nbHp+VNlFvqbepgW9G67
	J5aC4Ov/r5PcWP1eowH3jCTIi/ACxLXfPdIxKlVfxF8K93LUetE+jza+ra2CgjV308m0qyprU0m9j
	bUQ5hVlpJN1Qyqalxa1uqQHaOh47lY23PmAEbYxou5FlJ4ISYFGAdnaomdfdu4z0/2A3oVG74lBOK
	WObJA1QuUxfAGjFq8EKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt85-00F3cr-12;
	Mon, 25 Sep 2023 21:28:33 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt82-00F3ah-1G
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 21:28:31 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 688C3212C81A;
	Mon, 25 Sep 2023 14:28:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 688C3212C81A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695677310;
	bh=cAGeMcIZ4Qy0IHeYwlwP8jAIbqxHmBYRtqsMcKGODxQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=eeABRksv2rgxphiy5aAtajUIWfiwgwwfYye3Vr4ps/z99Y0+or0qxklh853TE4TY7
	 37qcOwLdLDeWd4gY4i3IdH+xQgGH95kd88lWQDlYrNDpxte+COS/ViuYl5cpC/wXp5
	 sZ43Xtu3jonbzYFtmMPptwgvVzMMky9ZnIYc1jwA=
Subject: [RFC PATCH v2 7/7] Drivers: hv: Allocate persistent pages for root
 partition
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
Date: Mon, 25 Sep 2023 14:28:28 -0700
Message-ID: <169567730882.19708.11955721929072363659.stgit@skinsburskii.>
In-Reply-To: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
References: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_142830_452701_D4F5643C 
X-CRM114-Status: GOOD (  11.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Deposited pages are owned by the hypervisor. Accessing them can trigger a
kernel panic due to a general protection fault.

This patch ensures that pages for the root partition are allocated from the
persistent memory pool. This allocation guarantees stability post-kexec,
protecting hypervisor-deposited pages from unintended reuse by the new
kernel.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_common.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 335aec5ec504..a81c5613e745 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -426,7 +426,10 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 		order = 31 - __builtin_clz(num_pages);
 
 		while (1) {
-			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
+			if (paritition_id == hv_current_partition_id)
+				pages[i] = pmpool_alloc(1 << order);
+			else
+				pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
 			if (pages[i])
 				break;
 			if (!order) {
@@ -471,8 +474,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 err_free_allocations:
 	for (i = 0; i < num_allocations; ++i) {
 		base_pfn = page_to_pfn(pages[i]);
-		for (j = 0; j < counts[i]; ++j)
-			__free_page(pfn_to_page(base_pfn + j));
+		for (j = 0; j < counts[i]; ++j) {
+			if (paritition_id == hv_current_partition_id)
+				pmpool_release(pages[i], counts[i]);
+			else
+				__free_page(pfn_to_page(base_pfn + j));
+		}
 	}
 
 free_buf:



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
