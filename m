Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3ADE95A8E
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oQWzEdRsAfLpgbS5FQAYNs4AOKijBmQZNJlBhzzNtbw=; b=ZTUVgHUME7H8UO
	2htXQEM37UpTsT0yCrJMS5P2JOr57xjAIy/JtGdppAzWVlqrkSWVN5/+kDfGAnxF5ScGI/GQ5rPZO
	3x7Pf2LJVTv7IlssoIsiYvOQXBZr/Y0hH2ywDeQy/bfR2BQk0iUYopAVwNNTyY9Yva2uK8Z+eiRA/
	LoHzpQG7fYPjpwJfZiiKgn/Tprh2VyR+xaQCDDMj5IJO9xQdstiMBlWdhujJmVhA09pwLIrIajoP/
	6lVvGLu0TbCsK3SwcfNNNQo+xxjxU41kyB3nm9kCR5J3GAEwNYS0G8MqKznsuIG/voihC4Dya2vU8
	bk6f5NSH1dRJIkwhZ4Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpoU0-00ATPU-2P;
	Mon, 09 Oct 2023 11:31:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpoTy-00ATOI-0E
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 11:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696851089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ln7pY+wr2qQD2ScMy6ex68H7bIVNwsO6jnYm/CoN2CQ=;
	b=HMNfsEkYJxeXjSlo1pT9itOybwiDJLecKFe4Ul4yB5PPip7zJeRSG2x9lBBWIolIwqfi8o
	v+G6tYJBFg263PoyOcgjYWBDY+u604OcG4NI45AuWeaCk9NZZhCrb7QpAxOOJkm9SIJFEh
	vUCeZ/m3IsU0Km7zdinUPIDDKz/+BTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-685-bGOoXTBWNBWO2o2YKQeI3w-1; Mon, 09 Oct 2023 07:31:15 -0400
X-MC-Unique: bGOoXTBWNBWO2o2YKQeI3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96A61811E97;
	Mon,  9 Oct 2023 11:31:14 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9780F215671F;
	Mon,  9 Oct 2023 11:31:10 +0000 (UTC)
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
Subject: [PATCHv8 5/5] powerpc/setup: alloc extra paca_ptrs to hold boot_cpuid
Date: Mon,  9 Oct 2023 19:30:36 +0800
Message-Id: <20231009113036.45988-6-piliu@redhat.com>
In-Reply-To: <20231009113036.45988-1-piliu@redhat.com>
References: <20231009113036.45988-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_043130_174584_1CA69F11 
X-CRM114-Status: GOOD (  16.62  )
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

paca_ptrs should be large enough to hold the boot_cpuid, hence, its
lower boundary is set to the bigger one between boot_cpuid+1 and
nr_cpus.

On the other hand, some kernel component: -1. the timer assumes cpu0
online since the timer_list->flags subfield 'TIMER_CPUMASK' is zero if
not initialized to a proper present cpu.  -2. power9_idle_stop() assumes
the primary thread's paca is allocated.

Hence lift nr_cpu_ids from one to two to ensure cpu0 is onlined, if the
boot cpu is not cpu0.

Result:
When nr_cpus=1, taskset -c 14 bash -c 'echo c > /proc/sysrq-trigger'
the kdump kernel brings up two cpus.
While when taskset -c 4 bash -c 'echo c > /proc/sysrq-trigger',
the kdump kernel brings up one cpu.

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
 arch/powerpc/kernel/paca.c | 10 ++++++----
 arch/powerpc/kernel/prom.c |  9 ++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index cda4e00b67c1..91e2401de1bd 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -242,9 +242,10 @@ static int __initdata paca_struct_size;
 
 void __init allocate_paca_ptrs(void)
 {
-	paca_nr_cpu_ids = nr_cpu_ids;
+	int n = (boot_cpuid + 1) > nr_cpu_ids ? (boot_cpuid + 1) : nr_cpu_ids;
 
-	paca_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
+	paca_nr_cpu_ids = n;
+	paca_ptrs_size = sizeof(struct paca_struct *) * n;
 	paca_ptrs = memblock_alloc_raw(paca_ptrs_size, SMP_CACHE_BYTES);
 	if (!paca_ptrs)
 		panic("Failed to allocate %d bytes for paca pointers\n",
@@ -287,13 +288,14 @@ void __init allocate_paca(int cpu)
 void __init free_unused_pacas(void)
 {
 	int new_ptrs_size;
+	int n = (boot_cpuid + 1) > nr_cpu_ids ? (boot_cpuid + 1) : nr_cpu_ids;
 
-	new_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
+	new_ptrs_size = sizeof(struct paca_struct *) * n;
 	if (new_ptrs_size < paca_ptrs_size)
 		memblock_phys_free(__pa(paca_ptrs) + new_ptrs_size,
 				   paca_ptrs_size - new_ptrs_size);
 
-	paca_nr_cpu_ids = nr_cpu_ids;
+	paca_nr_cpu_ids = n;
 	paca_ptrs_size = new_ptrs_size;
 
 #ifdef CONFIG_PPC_64S_HASH_MMU
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 87272a2d8c10..15c994f54bf9 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -362,9 +362,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 			 */
 			boot_cpuid = i;
 			found = true;
-			/* This works around the hole in paca_ptrs[]. */
-			if (nr_cpu_ids < nthreads)
-				set_nr_cpu_ids(nthreads);
+			/*
+			 * Ideally, nr_cpus=1 can be achieved if each kernel
+			 * component does not assume cpu0 is onlined.
+			 */
+			if (boot_cpuid != 0 && nr_cpu_ids < 2)
+				set_nr_cpu_ids(2);
 		}
 #ifdef CONFIG_SMP
 		/* logical cpu id is always 0 on UP kernels */
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
