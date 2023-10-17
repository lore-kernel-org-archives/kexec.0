Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73780CDB465
	for <kexec@archiver.kernel.org>; Tue, 17 Oct 2023 02:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qFzklNUiycZd7UUAfJBp9Z7uh+pxF3iRln4faPrcXU0=; b=Tk20kT/yCHPJv6
	vL55SWus493GshyX3dw2wICHT3J6Rwqf7NBAH424oxtDR5gNtl26hn8PwLaMPZo7RIievviPwi79X
	HowQ16Nbs4ChUuQ2unmAQ3LQSBlzY2Vxz6cCYMn33+DMqGBkuq4tC8t+UfaGdE8n8CyNvgX+bZnoX
	CHlc4xxug3s5QnPOlagM6KIsLICCM9Pj8X52w/jjcn2I9tou87D4xx/6CPaxs5FXQPAnJNdPLM8/3
	IQZ5UDi8WDN0RKLv3SgLZXmEtuGsq+cqdTmgYt/RvifQMDgtKoNA0UhDyEmnVLupZAkDQRySr9yt6
	QvTXSHS1azNwUjV/hmTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsZp1-00B44K-2Q;
	Tue, 17 Oct 2023 02:28:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsZoz-00B43h-0V
	for kexec@lists.infradead.org;
	Tue, 17 Oct 2023 02:28:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697509716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bwvv8Ug5LWet0NjqBwU0T2Z/P57OXSB0kNMnVbkLTNM=;
	b=D4M9b0VjZtbB2oLlL+k1CJHd990nSw7Ja2gA/4oTGotN/BNvdIMK3XDJn3TPOozwkJsppp
	6TPm+z7ZOdk7/UvZ/AEZeT9Yv1cLj86U5KR8KQ3TzaRgrPeP7yjP98Mrz9trcFDHMfAzfM
	Pg9x/dBusK0slTck6UvN1MGWtv4z+SQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-82nT8_LsNCS-kYbFxQ-pwQ-1; Mon, 16 Oct 2023 22:28:31 -0400
X-MC-Unique: 82nT8_LsNCS-kYbFxQ-pwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 401101C068C0;
	Tue, 17 Oct 2023 02:28:31 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FB5C1C060AE;
	Tue, 17 Oct 2023 02:28:23 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
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
Subject: [PATCHv9 1/2] powerpc/setup : Enable boot_cpu_hwid for PPC32
Date: Tue, 17 Oct 2023 10:28:05 +0800
Message-Id: <20231017022806.4523-2-piliu@redhat.com>
In-Reply-To: <20231017022806.4523-1-piliu@redhat.com>
References: <20231017022806.4523-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_192837_263514_32588477 
X-CRM114-Status: GOOD (  15.39  )
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

In order to identify the boot cpu, its intserv[] should be recorded and
checked in smp_setup_cpu_maps().

smp_setup_cpu_maps() is shared between PPC64 and PPC32. Since PPC64 has
already used boot_cpu_hwid to carry that information, enabling this
variable on PPC32 so later it can also be used to carry that information
for PPC32 in the coming patch.

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
 arch/powerpc/include/asm/smp.h     | 2 +-
 arch/powerpc/kernel/prom.c         | 3 +--
 arch/powerpc/kernel/setup-common.c | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index aaaa576d0e15..5db9178cc800 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -26,7 +26,7 @@
 #include <asm/percpu.h>
 
 extern int boot_cpuid;
-extern int boot_cpu_hwid; /* PPC64 only */
+extern int boot_cpu_hwid;
 extern int spinning_secondaries;
 extern u32 *cpu_to_phys_id;
 extern bool coregroup_enabled;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b..ec82f5bda908 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -372,8 +372,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	    be32_to_cpu(intserv[found_thread]));
 	boot_cpuid = found;
 
-	if (IS_ENABLED(CONFIG_PPC64))
-		boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
+	boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
 
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2f1026fba00d..707f0490639d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -87,9 +87,7 @@ EXPORT_SYMBOL(machine_id);
 int boot_cpuid = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid);
 
-#ifdef CONFIG_PPC64
 int boot_cpu_hwid = -1;
-#endif
 
 /*
  * These are used in binfmt_elf.c to put aux entries on the stack
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
