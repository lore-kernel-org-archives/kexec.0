Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8CBC46CD3
	for <kexec@archiver.kernel.org>; Wed, 27 Dec 2023 02:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6L0f3B6aH9iQred1BOgcId1IGvKiprJ/6MxJDY87/9I=; b=GkQHNWcLshgxRB
	58PNKil6p4C8lEqRrRhnOFgS0QXiSPSaX0vmGmrOeU5Yh7lccQ7CdPIFSUn4hOBlCL/JVoDf4q5oI
	jKtAfou3lkHbuYvEz0FKwpF4AyklOtyS3Vlb4mwo8sjHzXGekSuZbIlxDc1pgCI6rEmcLKriDXi2d
	vQDo4gB3xI+les8f0D0fgV7H8G7nLo54sOHf5bRsjPrE5+Mgc5FoZLdgRfsrBKazt1BqOj06ipD+o
	OWbopmL1OKCk5TDj/jRy1Iv/i9UtcJSefrjV/s/gl3pt5WjHSSXBcIXHnwR+7h6/fVguU+imV7AOE
	WL/THAsFudUYLGxeM6Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJrY-00DqFL-0l;
	Wed, 27 Dec 2023 02:41:40 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJrV-00DqEx-23
	for kexec@lists.infradead.org;
	Wed, 27 Dec 2023 02:41:38 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4553372b3a.0
        for <kexec@lists.infradead.org>; Tue, 26 Dec 2023 18:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703644896; x=1704249696; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRAGnS9n7iZLPN3fzUPBIgeCsqk3wHeryWyE4pqZfzg=;
        b=ZD6Cof4BK8ZambUtntUvroUpedspnLXkK6WNBEJvC85/5piL+br0WU4Shiw+v6Wuwn
         /QOcdNyFnRa/aDTLzmFGbWmpmazzc7lbpxYGPLUmzUn2SDGJSkxSibqT8s5BHGska04J
         wU3jglKD5cYCVXChIH2/V75cTXNFZE9ClBhoZF3+QKj8tDseoZAVs0gE1K0R8kmWSuEM
         hV/z/uOorWcu3F9THfpyW+kT/TYaXyozNTWjouUl6aQByenQPLSZA5kg5xM1/qzlSddz
         vMSaKZRKWoj/rMZlZhqPe5PgSpwlcdj5uHIwveK6TfDfH9bzZoB+7TvjokCRlFCR1s/W
         wvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703644896; x=1704249696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRAGnS9n7iZLPN3fzUPBIgeCsqk3wHeryWyE4pqZfzg=;
        b=ophYzqRuy/POf+w79c9OEr3C0jQoTE6ArMtFRI6NsJaC4BD8buVp7/JHR3THhe0E4o
         iLLbHF7jr62voplu6t4uL+iBHxi9m4au280lreVh01JPmbL2ZEI+PIkKThq+3PUNusgi
         6frMifo7DkNYVlDLMzQMXBHfQDC49LU/4j87T6VkMOW6MLTB01aa/Y0BPOWGPwBqCjGV
         DLbOlauGG7wPXtHp5DgeeTJlBtcNGrP7W2NxFargCCPDi/+JFjgrw+k5CTk9cy0Sz0aB
         9NmYLZmnwP/wycD1yXQNOMzolja/VvhbU0O/zuDfXld06+LrqCmVDOHY3surkflBrdi3
         GTqQ==
X-Gm-Message-State: AOJu0YxApMvfo4XrMtO0ijAuB06tBsHtoX9OpNenuxITFxSAX5i/0j7b
	/z/OVMEmPIO13sV+IGkLGw==
X-Google-Smtp-Source: AGHT+IHjk3AA3JcUV9M8k0oIpnUVqTmwmZDYX45WozIhC7j5KkqBhbvaKT0XP5lHWjRaKq44NwhggA==
X-Received: by 2002:a05:6a00:b20:b0:6d9:b5ce:f17e with SMTP id f32-20020a056a000b2000b006d9b5cef17emr4195836pfu.5.1703644895865;
        Tue, 26 Dec 2023 18:41:35 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78745000000b006d9af8c25easm5449200pfo.84.2023.12.26.18.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 18:41:35 -0800 (PST)
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
Subject: [PATCHv10 2/3] powerpc/kernel: Extend arrays' size to make room for a hole in cpu_possible_mask
Date: Wed, 27 Dec 2023 10:41:26 +0800
Message-Id: <20231227024126.12424-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231227023934.12299-1-kernelfans@gmail.com>
References: <20231227023934.12299-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231226_184137_678857_1FDE5DB0 
X-CRM114-Status: GOOD (  14.39  )
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

This patch aims to mark all the arrays which size is decided by
nr_cpu_ids or num_possible_cpus().  Later if a hole is allowed in
cpu_possible_mask, the corresponding array should extend to hold the
last bit number in cpu_possible_mask.

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
 arch/powerpc/include/asm/paca.h    | 2 ++
 arch/powerpc/kernel/paca.c         | 8 ++++----
 arch/powerpc/kernel/setup-common.c | 2 +-
 arch/powerpc/kernel/smp.c          | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e667d455ecb4..a577d98dd0d8 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -299,5 +299,7 @@ static inline void free_unused_pacas(void) { }
 
 #endif /* CONFIG_PPC64 */
 
+extern int paca_last_cpu_num;
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PACA_H */
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 760f371cf096..840c74dd17d6 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -236,15 +236,15 @@ void setup_paca(struct paca_struct *new_paca)
 
 }
 
-static int __initdata paca_nr_cpu_ids;
+int __initdata paca_last_cpu_num;
 static int __initdata paca_ptrs_size;
 static int __initdata paca_struct_size;
 
 void __init allocate_paca_ptrs(void)
 {
-	paca_nr_cpu_ids = nr_cpu_ids;
+	paca_last_cpu_num = nr_cpu_ids;
 
-	paca_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
+	paca_ptrs_size = sizeof(struct paca_struct *) * paca_last_cpu_num;
 	paca_ptrs = memblock_alloc_raw(paca_ptrs_size, SMP_CACHE_BYTES);
 	if (!paca_ptrs)
 		panic("Failed to allocate %d bytes for paca pointers\n",
@@ -258,7 +258,7 @@ void __init allocate_paca(int cpu)
 	u64 limit;
 	struct paca_struct *paca;
 
-	BUG_ON(cpu >= paca_nr_cpu_ids);
+	BUG_ON(cpu >= paca_last_cpu_num);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	/*
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2f1026fba00d..f9f5f313abf0 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -453,7 +453,7 @@ void __init smp_setup_cpu_maps(void)
 
 	DBG("smp_setup_cpu_maps()\n");
 
-	cpu_to_phys_id = memblock_alloc(nr_cpu_ids * sizeof(u32),
+	cpu_to_phys_id = memblock_alloc(paca_last_cpu_num * sizeof(u32),
 					__alignof__(u32));
 	if (!cpu_to_phys_id)
 		panic("%s: Failed to allocate %zu bytes align=0x%zx\n",
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5826f5108a12..6fefe22fd118 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1140,7 +1140,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	if (cpu_to_chip_id(boot_cpuid) != -1) {
-		int idx = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
+		int idx = DIV_ROUND_UP(cpumask_last(cpu_possible_mask),
+				threads_per_core);
 
 		/*
 		 * All threads of a core will all belong to the same core,
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
