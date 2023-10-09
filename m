Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608B5E95A8E
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VgOzjV3YM3nYb8JU0wIkCfFzuzWuNnCnoXt0wHqqbEw=; b=WoXkkIYYYPbuxY
	VAMeT/P2yq5KNiY89ut4INa3uNNQqG5ufHyuY7CfRv6ES2I6esdtOzTBvP/xaId4QvN9isPd869qF
	2lbrYGEder/UGTHaSz/PzpzqiYOhM9skimAFWyhKjh0c36hSilZggcJ0c5amvlQ2g4OT3WBgMfdu/
	tVCAY2FwSQ8CG9AiS9ZLX0x+uj8DY2lQGt02v5OrUbusEmZJLBjgxpX02QSZt8rT85AzRPiVrvevd
	i/XDhQ3f7Gb6HHKTv1C2xrc9v2IUSs/vDzeiOuPqbvb+fABF9e/7D9LQjac4zEGJjJXj3HCcxES/m
	dMMltYnb3Op1Mk1TRAYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpoTo-00ATLM-2z;
	Mon, 09 Oct 2023 11:31:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpoTj-00ATId-2b
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 11:31:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696851075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66tr9t3o5B+YlI8Z0Ko9wOOYI/+Cp0wW5QZRg/7Co00=;
	b=YXgZaRPSpA/b2MuFpxAkcsABpKzF/qvKKFin8MqJnVRSPQF0LgPeTQs63pvXswClOH98m2
	mS56QlNRdxtoLNP0XbyDmO/AeY7a1lkyIctsCmWzgemtQMS1SdR2dltH66AZUv6A9wiLvM
	pMccVJnDwzXEzndu7TbgHF9HlxJpW2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-NqwxN9HnN0-iUnRLafhCJQ-1; Mon, 09 Oct 2023 07:31:10 -0400
X-MC-Unique: NqwxN9HnN0-iUnRLafhCJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0115918162C4;
	Mon,  9 Oct 2023 11:31:10 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0626B215670B;
	Mon,  9 Oct 2023 11:31:05 +0000 (UTC)
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
Subject: [PATCHv8 4/5] powerpc/cpu: Skip impossible cpu during iteration on a core
Date: Mon,  9 Oct 2023 19:30:35 +0800
Message-Id: <20231009113036.45988-5-piliu@redhat.com>
In-Reply-To: <20231009113036.45988-1-piliu@redhat.com>
References: <20231009113036.45988-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_043115_917395_A7A2ABEB 
X-CRM114-Status: GOOD (  19.32  )
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

The threads in a core have equal status, so the code introduces a for
loop pattern to execute the same task on each thread:
    for (i = first_thread; i < first_thread + threads_per_core; i++)

Now that some threads may not be in the cpu_possible_mask, the iteration
skips those threads by checking the mask. In this way, the unpopulated
pcpu struct can be skipped and left unaccessed.

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
 arch/powerpc/include/asm/cputhreads.h    |  6 +++++
 arch/powerpc/kernel/smp.c                |  2 +-
 arch/powerpc/kvm/book3s_hv.c             |  7 ++----
 arch/powerpc/platforms/powernv/idle.c    | 32 ++++++++++++------------
 arch/powerpc/platforms/powernv/subcore.c |  5 +++-
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index f26c430f3982..fdb71ff7f6a9 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -65,6 +65,12 @@ static inline int cpu_last_thread_sibling(int cpu)
 	return cpu | (threads_per_core - 1);
 }
 
+#define for_each_possible_cpu_in_core(start, iter)			\
+	for (iter = start; iter < start + threads_per_core; iter++)	\
+		if (unlikely(!cpu_possible(iter)))			\
+			continue;					\
+		else
+
 /*
  * tlb_thread_siblings are siblings which share a TLB. This is not
  * architected, is not something a hypervisor could emulate and a future
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index fbbb695bae3d..2936f7a2240d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -933,7 +933,7 @@ static int __init update_mask_from_threadgroup(cpumask_var_t *mask, struct threa
 
 	zalloc_cpumask_var_node(mask, GFP_KERNEL, cpu_to_node(cpu));
 
-	for (i = first_thread; i < first_thread + threads_per_core; i++) {
+	for_each_possible_cpu_in_core(first_thread, i) {
 		int i_group_start = get_cpu_thread_group_start(i, tg);
 
 		if (unlikely(i_group_start == -1)) {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 130bafdb1430..ff4b3f8affba 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6235,12 +6235,9 @@ static int kvm_init_subcore_bitmap(void)
 			return -ENOMEM;
 
 
-		for (j = 0; j < threads_per_core; j++) {
-			int cpu = first_cpu + j;
-
-			paca_ptrs[cpu]->sibling_subcore_state =
+		for_each_possible_cpu_in_core(first_cpu, j)
+			paca_ptrs[j]->sibling_subcore_state =
 						sibling_subcore_state;
-		}
 	}
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index ad41dffe4d92..79d81ce5cf4c 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -823,36 +823,36 @@ void pnv_power9_force_smt4_catch(void)
 
 	cpu = smp_processor_id();
 	cpu0 = cpu & ~(threads_per_core - 1);
-	for (thr = 0; thr < threads_per_core; ++thr) {
-		if (cpu != cpu0 + thr)
-			atomic_inc(&paca_ptrs[cpu0+thr]->dont_stop);
+	for_each_possible_cpu_in_core(cpu0, thr) {
+		if (cpu != thr)
+			atomic_inc(&paca_ptrs[thr]->dont_stop);
 	}
 	/* order setting dont_stop vs testing requested_psscr */
 	smp_mb();
-	for (thr = 0; thr < threads_per_core; ++thr) {
-		if (!paca_ptrs[cpu0+thr]->requested_psscr)
+	for_each_possible_cpu_in_core(cpu0, thr) {
+		if (!paca_ptrs[thr]->requested_psscr)
 			++awake_threads;
 		else
-			poke_threads |= (1 << thr);
+			poke_threads |= (1 << (thr - cpu0));
 	}
 
 	/* If at least 3 threads are awake, the core is in SMT4 already */
 	if (awake_threads < need_awake) {
 		/* We have to wake some threads; we'll use msgsnd */
-		for (thr = 0; thr < threads_per_core; ++thr) {
-			if (poke_threads & (1 << thr)) {
+		for_each_possible_cpu_in_core(cpu0, thr) {
+			if (poke_threads & (1 << (thr - cpu0))) {
 				ppc_msgsnd_sync();
 				ppc_msgsnd(PPC_DBELL_MSGTYPE, 0,
-					   paca_ptrs[cpu0+thr]->hw_cpu_id);
+					   paca_ptrs[thr]->hw_cpu_id);
 			}
 		}
 		/* now spin until at least 3 threads are awake */
 		do {
-			for (thr = 0; thr < threads_per_core; ++thr) {
-				if ((poke_threads & (1 << thr)) &&
-				    !paca_ptrs[cpu0+thr]->requested_psscr) {
+			for_each_possible_cpu_in_core(cpu0, thr) {
+				if ((poke_threads & (1 << (thr - cpu0))) &&
+				    !paca_ptrs[thr]->requested_psscr) {
 					++awake_threads;
-					poke_threads &= ~(1 << thr);
+					poke_threads &= ~(1 << (thr - cpu0));
 				}
 			}
 		} while (awake_threads < need_awake);
@@ -868,9 +868,9 @@ void pnv_power9_force_smt4_release(void)
 	cpu0 = cpu & ~(threads_per_core - 1);
 
 	/* clear all the dont_stop flags */
-	for (thr = 0; thr < threads_per_core; ++thr) {
-		if (cpu != cpu0 + thr)
-			atomic_dec(&paca_ptrs[cpu0+thr]->dont_stop);
+	for_each_possible_cpu_in_core(cpu0, thr) {
+		if (cpu != thr)
+			atomic_dec(&paca_ptrs[thr]->dont_stop);
 	}
 }
 EXPORT_SYMBOL_GPL(pnv_power9_force_smt4_release);
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 191424468f10..b229115c8c0f 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -151,9 +151,12 @@ static void wait_for_sync_step(int step)
 {
 	int i, cpu = smp_processor_id();
 
-	for (i = cpu + 1; i < cpu + threads_per_core; i++)
+	for_each_possible_cpu_in_core(cpu, i) {
+		if (i == cpu)
+			continue;
 		while(per_cpu(split_state, i).step < step)
 			barrier();
+	}
 
 	/* Order the wait loop vs any subsequent loads/stores. */
 	mb();
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
