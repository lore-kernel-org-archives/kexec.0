Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C83CEE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qdHmKz17tLuEyvHEcZHlU4vVUkHOI2jZjxCRjo/05HI=; b=a8ht247cB1Te26
	xEQQ3auBoETyTr2/OSHfpz5fyRcXls56huUw2YIiq+BWavBiBgDPCluT4WEZnq/t9tYQAhwKexOGI
	22SF1UdyMVKOd7VoPWgJEUZgaJ6EKq5ysQKCUM4FZFHpsTDdEU60az4+BnRntpnLr+VydHeFt/Jiw
	7/m2mNFWKGxbO/9Od6c5M4GWqU4kHV0i0all8/9g1dMQ/rwUvngFHiZSvbjnK1SJL7PtGq0f5JO4+
	5l9Z0dVyQ783rbjEe+vN4avUirV65rENJp7EMS+HVx7GRrN6CCT7KOLq0wMfWyYSoH0HfXxz+iPFz
	E9yGsOoOyUhJd5BZoquQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfgp3-000amW-2d;
	Mon, 11 Sep 2023 13:19:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfgp0-000alY-1j
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 13:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694438359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hbw5LcVAhn/MF5vOS6EegrWEmv1/qJLDPF4qVdxgL4s=;
	b=bHHZyfYgR+beSFNUnkeqcLUDaegdgq4Xo6uSjFMdSh+COl2ZFwhUyUlI9FvYHNmedl7YBy
	kTFZs/E6p3vkESdufKRaUy8bxyGCLvkWbsU9kBFtc3SxQ2ZtoZG+fzk8Z9s5c1qbLlrf++
	sVQgW+qbbGksYeRyNhNKs4wH43k2PR8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-XQhtsyerOp25TxNVgyqOQg-1; Mon, 11 Sep 2023 09:19:16 -0400
X-MC-Unique: XQhtsyerOp25TxNVgyqOQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1D0E38117E9;
	Mon, 11 Sep 2023 13:19:15 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 617D12156701;
	Mon, 11 Sep 2023 13:19:11 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	kexec@lists.infradead.org
Subject: [PATCHv6 2/3] powerpc/setup: Handle the case when boot_cpuid greater than nr_cpus
Date: Mon, 11 Sep 2023 21:18:54 +0800
Message-Id: <20230911131855.40738-3-piliu@redhat.com>
In-Reply-To: <20230911131855.40738-1-piliu@redhat.com>
References: <20230911131855.40738-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_061922_704372_1375814E 
X-CRM114-Status: GOOD (  17.14  )
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

If the boot_cpuid is smaller than nr_cpus, it requires extra effort to
ensure the boot_cpu is in cpu_present_mask. This can be achieved by
reserving the last quota for the boot cpu.

Note: the restriction on nr_cpus will be lifted with more effort in the
next patch

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Wen Xiong <wenxiong@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/setup-common.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index a07af8de6674..58a988c64dd2 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -456,8 +456,8 @@ struct interrupt_server_node {
 void __init smp_setup_cpu_maps(void)
 {
 	struct device_node *dn;
-	int shift = 0, cpu = 0;
-	int j, nthreads = 1;
+	int terminate, shift = 0, cpu = 0;
+	int j, bt_thread = 0, nthreads = 1;
 	int len;
 	struct interrupt_server_node *intserv_node, *n;
 	struct list_head *bt_node, head;
@@ -520,6 +520,7 @@ void __init smp_setup_cpu_maps(void)
 			for (j = 0 ; j < nthreads; j++) {
 				if (be32_to_cpu(intserv[j]) == boot_cpu_hwid) {
 					bt_node = &intserv_node->node;
+					bt_thread = j;
 					found_boot_cpu = true;
 					/*
 					 * Record the round-shift between dt
@@ -539,11 +540,21 @@ void __init smp_setup_cpu_maps(void)
 	/* Select the primary thread, the boot cpu's slibing, as the logic 0 */
 	list_add_tail(&head, bt_node);
 	pr_info("the round shift between dt seq and the cpu logic number: %d\n", shift);
+	terminate = nr_cpu_ids;
 	list_for_each_entry(intserv_node, &head, node) {
 
+		j = 0;
+		/* Choose a start point to cover the boot cpu */
+		if (nr_cpu_ids - 1 < bt_thread) {
+			/*
+			 * The processor core puts assumption on the thread id,
+			 * not to breach the assumption.
+			 */
+			terminate = nr_cpu_ids - 1;
+		}
 		avail = intserv_node->avail;
 		nthreads = intserv_node->len / sizeof(int);
-		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
+		for (; j < nthreads && cpu < terminate; j++) {
 			set_cpu_present(cpu, avail);
 			set_cpu_possible(cpu, true);
 			cpu_to_phys_id[cpu] = be32_to_cpu(intserv_node->intserv[j]);
@@ -551,6 +562,14 @@ void __init smp_setup_cpu_maps(void)
 			    j, cpu, be32_to_cpu(intserv[j]));
 			cpu++;
 		}
+		/* Online the boot cpu */
+		if (nr_cpu_ids - 1 < bt_thread) {
+			set_cpu_present(bt_thread, avail);
+			set_cpu_possible(bt_thread, true);
+			cpu_to_phys_id[bt_thread] = be32_to_cpu(intserv_node->intserv[bt_thread]);
+			DBG("    thread %d -> cpu %d (hard id %d)\n",
+			    bt_thread, bt_thread, be32_to_cpu(intserv[bt_thread]));
+		}
 	}
 
 	list_for_each_entry_safe(intserv_node, n, &head, node) {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
