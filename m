Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BCFCAC5A7
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 22:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tZ1awk6SoUQIOVQF3O5Wg32Zi3pcSNXGfmdT++muNE=; b=RjyhfqBj71DfnO3NOBDyUjHvqK
	Q1caRR1u8pnwEaXKraYtpKo+Q/BaQ2fDh8H3/Ka67Mu/L+xW8TWwvtSihutmVPBLizRQTKYHL+Rq4
	P8svJBx+WsmQ/zxwLWWvHyGdYoltijZztsOUqTJf67DYAKyNdL2tlYGnPQ9c8doXWcV+JzDwgoXEe
	pEc2///0JhQYs22sJ/Np8U2reFxH5PseAkIoaUVSGuYEHEFWZiyUEAJvk+vA0qaMoQ8sgAUuMJ/ML
	y2CCoWwL/gVW6DwVORC9XcIqQ9RIyochu+7TQDgLOe6+TV8WIz/LpsWYx7GoXUhTAiAG1ITrF1FXz
	KK7a+WlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5E-00000001KNQ-1HGX;
	Thu, 18 Sep 2025 22:26:32 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5B-00000001KKw-3nMM
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 22:26:31 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-77d64726e47so1043764b3a.3
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234389; x=1758839189; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tZ1awk6SoUQIOVQF3O5Wg32Zi3pcSNXGfmdT++muNE=;
        b=P5OxzQY5N0tEw56zL84bW4VKbsMoQf5aPg5ITPfhS++OIFxzPN2kI9JjXD1hAKL4nO
         0bnfRGaqxya4aQu4joiq2mRkeUFB31WhY44Kcm9cFETnOjEWoxi6SfB8G3t9CK5O96yU
         NRT8D86OzZOmiScZdC3oDLTEzs4SHtCoRsG1M8rAZ0OxIDcgJ8fFpoV+1pRFnLwz6J0X
         d+Yy93BZprHtUVzwr6/YMlHUZZX/Vs4Nb68SHMk3IgzUyPA4M8EP+amr6DLnorWFuGle
         Ie2TuGAbQrSR/G62qMXo2E3YafoQY8JfNU1xrgao/AMyToGHfSF8rZOiQummWIsTocfd
         qPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234389; x=1758839189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tZ1awk6SoUQIOVQF3O5Wg32Zi3pcSNXGfmdT++muNE=;
        b=mISsfQbIrK6tfJywraXYYn8RTPc9Q9RxicjCQHKAIKECEX2WumFyG9NTrvyvk00bZg
         7ZM+DNnPj97a/j10hpPPa0tsYdls7t/dHWFMwKUvU2H+Z056boxvauQGBk7OkWjFrWOi
         9BuEyBZxkFdY3HkposDpsaXCWUR9tKor7MZoYttOJXCXgNox/ONw0j9Sm6qewCgjSi+m
         eIwto9bVCXek5F192ZbJ6/hOcE0GZAZdc4ciOT+ZdCX23WCNsppt7kh1pyhzvWbvGymv
         QuQ9P1VYQ10X8hYCFbzcI5aG21YbZ3villGwJWm+7XsettJG8dnF3n/nksVKQM4n1OBX
         8L7g==
X-Forwarded-Encrypted: i=1; AJvYcCXuVwFZ827k1bX4nkfmgyjrLnoPoFIwG1BAP7t2721LpfOFW4a907Iq1vFoGOpejdsAavfo3A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaXMD4HsPFr+ihvgvusi4GdDf2xpqh8SpjmYAs2+5h3spMLFDK
	5zenbYOHvYFa6awmtQqixpS/7CRShA0YfnHoinxSR5XPSyyuBVWBVYhM
X-Gm-Gg: ASbGnct4nc9ZtCDD/xEjEsmcR7Txe38LQDk6cTPps5xoG3mTqbnvzJdN11Jd8N77DIi
	yFqlcuCp2KBl1m/CYUXPrBEbtkXU1pCOj48fhaEIaGV0eupo/xm/kTErlNLHlBcYjBaTMBHf721
	gJnbc8IW/03Qr+orZ1uNzZNkarGJ85q3XSkN+T60qAMU+wIVlF8ZVPpNTIqBbOFbl0ogBTcSDQP
	U+EyliDj3IfQrSv3EzoLJNAoUteYxO4ztxeifDckRN6Ru1yxWpZQRXNYEdFTf0MB5EjMHKQ1xiS
	XZmaoJCkclBogtdLFxLY6BWqSo50VlwuWyPT4eexx6VB0J9dqMj2s1CoNb6/3lZ1WZpcOgEMx5F
	FMSqlrJKOyS3NKgrawmDfm70w681vJklpa7P65FlV9j+yx2Y=
X-Google-Smtp-Source: AGHT+IEWFbh2aOOMKw7ejiTJRJw8lOcG5jy15DL2xMCbkrQw2DZczjpxb6lHP6fuCOtxt7Ts0n9cBA==
X-Received: by 2002:a05:6a00:1250:b0:77d:6a00:1cd1 with SMTP id d2e1a72fcca58-77e4d031e97mr1237987b3a.12.1758234389331;
        Thu, 18 Sep 2025 15:26:29 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:28 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 5/7] x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
Date: Thu, 18 Sep 2025 15:26:04 -0700
Message-Id: <20250918222607.186488-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_152629_956268_3EDB915A 
X-CRM114-Status: GOOD (  17.41  )
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

From: Cong Wang <cwang@multikernel.io>

The tranditional smp_processor_id() is a software-defined CPU ID which
is only unique within the same kernel. With Multikernel architecture, we
run multiple Linux kernels on different CPU's, hence the host kernel
needs a globally unique CPU ID to manage the CPU's. The physical CPU ID
is perfect for this case.

This API will be used to globally distinguish CPU's among different
multikernels.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/include/asm/smp.h | 6 ++++++
 arch/x86/kernel/smp.c      | 6 ++++++
 kernel/multikernel.c       | 9 +++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 1a59fd0de759..378be65ceafa 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -40,6 +40,7 @@ struct smp_ops {
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
+	int (*cpu_physical_id)(int cpu);
 };
 
 /* Globals due to paravirt */
@@ -100,6 +101,11 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 	smp_ops.send_call_func_ipi(mask);
 }
 
+static inline int arch_cpu_physical_id(int cpu)
+{
+	return smp_ops.cpu_physical_id(cpu);
+}
+
 void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
 void smp_prepare_cpus_common(void);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 3ee515e32383..face9f80e05c 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -289,6 +289,11 @@ static int __init nonmi_ipi_setup(char *str)
 
 __setup("nonmi_ipi", nonmi_ipi_setup);
 
+static int native_cpu_physical_id(int cpu)
+{
+	return cpu_physical_id(cpu);
+}
+
 struct smp_ops smp_ops = {
 	.smp_prepare_boot_cpu	= native_smp_prepare_boot_cpu,
 	.smp_prepare_cpus	= native_smp_prepare_cpus,
@@ -306,6 +311,7 @@ struct smp_ops smp_ops = {
 
 	.send_call_func_ipi	= native_send_call_func_ipi,
 	.send_call_func_single_ipi = native_send_call_func_single_ipi,
+	.cpu_physical_id	= native_cpu_physical_id,
 };
 EXPORT_SYMBOL_GPL(smp_ops);
 
diff --git a/kernel/multikernel.c b/kernel/multikernel.c
index 74e2f84b7914..7f6f90485876 100644
--- a/kernel/multikernel.c
+++ b/kernel/multikernel.c
@@ -150,7 +150,7 @@ int multikernel_send_ipi_data(int cpu, void *data, size_t data_size, unsigned lo
 
 	/* Set header information */
 	target->data_size = data_size;
-	target->sender_cpu = smp_processor_id();
+	target->sender_cpu = arch_cpu_physical_id(smp_processor_id());
 	target->type = type;
 
 	/* Copy the actual data into the buffer */
@@ -175,6 +175,7 @@ static void multikernel_interrupt_handler(void)
 	struct mk_ipi_data *data;
 	struct mk_ipi_handler *handler;
 	int current_cpu = smp_processor_id();
+	int current_physical_id = arch_cpu_physical_id(current_cpu);
 
 	/* Ensure shared memory is initialized */
 	if (!mk_shared_mem) {
@@ -183,10 +184,10 @@ static void multikernel_interrupt_handler(void)
 	}
 
 	/* Get this CPU's data area from shared memory */
-	data = &mk_shared_mem->cpu_data[current_cpu];
+	data = &mk_shared_mem->cpu_data[current_physical_id];
 
-	pr_debug("Multikernel IPI received on CPU %d from CPU %d, type=%u\n",
-		 current_cpu, data->sender_cpu, data->type);
+	pr_info("Multikernel IPI received on CPU %d (physical id %d) from CPU %d type=%u\n",
+		 current_cpu, current_physical_id, data->sender_cpu, data->type);
 
     raw_spin_lock(&mk_handlers_lock);
     for (handler = mk_handlers; handler; handler = handler->next) {
-- 
2.34.1


