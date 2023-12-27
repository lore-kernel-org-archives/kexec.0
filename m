Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7CBC46CD3
	for <kexec@archiver.kernel.org>; Wed, 27 Dec 2023 02:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t7xQmzcuTuFQeG34WQr2Ju0QUKk2dYyGqE6r82/LpPY=; b=RzVW7Spv4ZHD+j
	YCqb3EGsqo4nlpU5HufQtqvhKPQfT0xutKbFoemvlKmb6gXmlwPcmjHzpfHnONZpc8EedLjpEilEo
	a1rI0UrrSOj0eT1uRlb/GN2gjwws+B10SGlOiQJropGT5VTRDpJfT5Axz6FoVJ5GBcJ5Db5dFxHQo
	6yRE6WIwTtwQCvACuDObqK4dZCPWgl5qMVwi3tHIsrKj75S9vchtxuW6HKZXxClXKs8FidC9fpZdP
	7s3UzW1Z4M59KRQD5QRAlM9bQp/hn6SZfR+5F5KA0HbYlZvMAxr1TAP9fnp8XiDhcjFm0GXToAspW
	WnpW/Lels1DEE4nvT0cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJrs-00DqI9-0a;
	Wed, 27 Dec 2023 02:42:00 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJrp-00DqHQ-0X
	for kexec@lists.infradead.org;
	Wed, 27 Dec 2023 02:41:58 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d3fc184b6dso17504085ad.2
        for <kexec@lists.infradead.org>; Tue, 26 Dec 2023 18:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703644915; x=1704249715; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT7htYeDjY4vTdy1fPJWLnQt0GHG3z7MAu24V6teBIw=;
        b=QADQwwv2XOCe3murPV6kgBIyXuDBn08GC86feA231OSkahjFE9hOJ+b+GNW3k0FrSX
         tYGQk8WexCEvw5X5sJCskpBL7Dq6T62cs0rnwoifDYTGjl9HP4qrjaJWfT3xlptJk0Gf
         xJeFOQLwhKUJ66/N0wotSkz5dwgRzRwxxrVS0L5PriXRcagvyYHhJQR86N1stqnZY3uF
         cyLrF+JkNWDef2pr/eyKhi74A5WJN6TwrkmzqBpQQz4qfP3bItLJZ/Qx5HWapwb40Q7q
         J8llg+XV/XQX1Fzht+Mbb199x9LbpdUZtIuVSAaqLEqMZ5Mb29XJBMmVayJ08NMhDWzf
         f1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703644915; x=1704249715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT7htYeDjY4vTdy1fPJWLnQt0GHG3z7MAu24V6teBIw=;
        b=pZXzYK3GOP2rqcBNyRatrvP0SypLtzU0djOsvqeINiq189jkIWwQLhckYadUyAs1Fp
         hmMYk6n3hMLdL29BdDDqH5lOF9mXqP2uk2SfIiZXSbCOM/yLpPeQtWD4Fr60kqYkG8zz
         VnmlhOuFpyS6QltAjTYHHKftwtJGxZI9GkS3lxKY8tRy6Tamn6EK9DzwyuB6FIX4/83o
         V9qY8UqtniO0UoSVBAZaHKL32O+BRu+zNr4/DqD3xcqF/EnhnTgpuZapEFTB1HRlZcuJ
         UeSojsJ0S56WgXKwNaoJgpdfuSUPiDVImVEYWqHrNggOctV/ODfF6yG6qdGtXMp0FDm9
         39qA==
X-Gm-Message-State: AOJu0YxYT+k8DgGKVJmESVISQ1jQiZ4EKHFPx+M3/WEhJetfgVnMXZY5
	A0YPM1EVgMoTKnr+rMjqUw==
X-Google-Smtp-Source: AGHT+IHCsge0Pwx3Fk+jrn3t8Mdnc4E5lcxUmO+ET7NbuD+U2d5OqeN9CRJcKSbmZQ7LgIFhpLQ4VQ==
X-Received: by 2002:a17:902:d584:b0:1d0:6ffd:8367 with SMTP id k4-20020a170902d58400b001d06ffd8367mr2747235plh.114.1703644915441;
        Tue, 26 Dec 2023 18:41:55 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b001c61073b076sm10775062plb.144.2023.12.26.18.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 18:41:54 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Wen Xiong <wenxiong@us.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	kexec@lists.infradead.org
Subject: [PATCHv10 3/3] powerpc/smp: Allow hole in paca_ptrs to accommodate boot_cpu
Date: Wed, 27 Dec 2023 10:41:47 +0800
Message-Id: <20231227024147.12485-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231227023934.12299-1-kernelfans@gmail.com>
References: <20231227023934.12299-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231226_184157_201584_98F8AF8B 
X-CRM114-Status: GOOD (  19.42  )
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

From: Pingfan Liu <piliu@redhat.com>

This patch always forces the first core onlined due to some subsystem
needs cpu0. After core0, a hole may follow, then comes the crashed core.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/smp.h     |  1 +
 arch/powerpc/kernel/paca.c         |  7 +++++--
 arch/powerpc/kernel/prom.c         |  6 ++++++
 arch/powerpc/kernel/setup-common.c | 24 ++++++++++++++++++++----
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index aaaa576d0e15..f01c7891b0d7 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -27,6 +27,7 @@
 
 extern int boot_cpuid;
 extern int boot_cpu_hwid; /* PPC64 only */
+extern int threads_in_core;
 extern int spinning_secondaries;
 extern u32 *cpu_to_phys_id;
 extern bool coregroup_enabled;
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 840c74dd17d6..1fe0fd2a6021 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -242,9 +242,12 @@ static int __initdata paca_struct_size;
 
 void __init allocate_paca_ptrs(void)
 {
-	paca_last_cpu_num = nr_cpu_ids;
+	unsigned int cnt;
 
-	paca_ptrs_size = sizeof(struct paca_struct *) * paca_last_cpu_num;
+	/* paca_ptrs should be big enough to hold boot cpu */
+	cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
+	paca_last_cpu_num = cnt;
+	paca_ptrs_size = sizeof(struct paca_struct *) * cnt;
 	paca_ptrs = memblock_alloc_raw(paca_ptrs_size, SMP_CACHE_BYTES);
 	if (!paca_ptrs)
 		panic("Failed to allocate %d bytes for paca pointers\n",
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b..e1a671156941 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -371,9 +371,15 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	DBG("boot cpu: logical %d physical %d\n", found,
 	    be32_to_cpu(intserv[found_thread]));
 	boot_cpuid = found;
+	/* This forces all threads in a core to be onlined */
+	set_nr_cpu_ids(ALIGN(nr_cpu_ids, nthreads));
+	/* Core 0 is always onlined and assure enough room for boot core */
+	if (nthreads -1 < boot_cpuid && nr_cpu_ids < 2 * nthreads)
+		set_nr_cpu_ids(2 * nthreads);
 
 	if (IS_ENABLED(CONFIG_PPC64))
 		boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
+	threads_in_core = nthreads;
 
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index f9f5f313abf0..b70474e1b5fe 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -86,6 +86,7 @@ EXPORT_SYMBOL(machine_id);
 
 int boot_cpuid = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid);
+int __initdata threads_in_core = 1;
 
 #ifdef CONFIG_PPC64
 int boot_cpu_hwid = -1;
@@ -448,8 +449,9 @@ u32 *cpu_to_phys_id = NULL;
 void __init smp_setup_cpu_maps(void)
 {
 	struct device_node *dn;
-	int cpu = 0;
+	int cpu_onlined = 0, cpu = 0;
 	int nthreads = 1;
+	bool bootcpu_covered = false;
 
 	DBG("smp_setup_cpu_maps()\n");
 
@@ -484,7 +486,19 @@ void __init smp_setup_cpu_maps(void)
 
 		nthreads = len / sizeof(int);
 
-		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
+		if (!bootcpu_covered) {
+			if (cpu == ALIGN_DOWN(boot_cpuid, nthreads)) {
+				bootcpu_covered = true;
+				goto scan;
+
+			/* Reserve the last online slot for boot core */
+			} else if (cpu >= nr_cpu_ids - nthreads && !bootcpu_covered) {
+				cpu += nthreads;
+				continue;
+			}
+		}
+scan:
+		for (j = 0; j < nthreads && cpu_onlined < nr_cpu_ids; j++) {
 			bool avail;
 
 			DBG("    thread %d -> cpu %d (hard id %d)\n",
@@ -499,9 +513,10 @@ void __init smp_setup_cpu_maps(void)
 			set_cpu_possible(cpu, true);
 			cpu_to_phys_id[cpu] = be32_to_cpu(intserv[j]);
 			cpu++;
+			cpu_onlined++;
 		}
 
-		if (cpu >= nr_cpu_ids) {
+		if (cpu_onlined >= nr_cpu_ids) {
 			of_node_put(dn);
 			break;
 		}
@@ -547,7 +562,8 @@ void __init smp_setup_cpu_maps(void)
 			printk(KERN_INFO "Partition configured for %d cpus.\n",
 			       maxcpus);
 
-		for (cpu = 0; cpu < maxcpus; cpu++)
+		/* Bits below #cpu have been set */
+		for (; cpu < maxcpus; cpu++)
 			set_cpu_possible(cpu, true);
 	out:
 		of_node_put(dn);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
