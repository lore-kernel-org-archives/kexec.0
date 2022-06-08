Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57837C433EF
	for <kexec@archiver.kernel.org>; Wed,  8 Jun 2022 07:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jcwiDFleJ78YmoUPcS3mGXFf+Gc4s7lVPPJvNVb99yQ=; b=OZnZ019Gl2Iq2r
	J7e4wdXqkq91/n0K3lv233Y80mQ2ilYwb+OD7ftmW69UG2+OdFv05RhAW05XsB246Ch1PGyX6Jhfx
	UHGREuQHzmnLlUZKQmVict0+51G+UCk6paSTJclsi51f/uHTndqQAWJuTlxV4cyJPVFlYLSE6r7jA
	jlrxByneIQr6kJxgOyTz+pT23xerbISyghD/+X/L01AZ827DTuHOM0bL5/YMsyWuuBmS3eSCYtNKw
	fvpG4Gd+yeI2CMivikLKIirDoE4/q/vm4SGn44L1HYXqKlEHFemo8KMDHWwV7CyEsog4aLiMmPUXG
	YJ6JQqzLyaJZVUAo7gEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nypgM-00BNsj-4h; Wed, 08 Jun 2022 07:00:46 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nypgJ-00BNrN-2K
	for kexec@lists.infradead.org; Wed, 08 Jun 2022 07:00:44 +0000
Received: by mail-pg1-x530.google.com with SMTP id d129so18060811pgc.9
        for <kexec@lists.infradead.org>; Wed, 08 Jun 2022 00:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=RsEt277LJhdNT3xgMfY4gmplIMtfLCGqPexhdZhIrR0=;
        b=d6qBRChW8ulGWplHIzV46CI9b5RKkIJPp2HqlmEFqabpHl5NTecOeFQVHV20tjr67q
         fu7v7e96Z3OElFaKbcENm/q6Q6uk3AYgTZrMvk32XNCbRJX1r+NF1rr9LF9iA7TVULSm
         Wz4qoK560ZD9joKpd/xRhfDZe9iocv98u4/9+TxxbLdG56p0N77Rk1DDlMVc9c1SQsfY
         bVGHHxn5WDqEVNS9hZuqnCbHN37DDEzkNZTrBemRzBDasV3jXY086V0YHLwItlRkz0BV
         librgxUzv84dcxeNY/+k38jQspS/LnRXrszfdWWIjbuHEHtEVTWUsicUHt9iJRqkK/Eb
         J1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=RsEt277LJhdNT3xgMfY4gmplIMtfLCGqPexhdZhIrR0=;
        b=40I0WqKIUgGKVkw+JIwv6vvUzbZR3HEf3Bmv2bixe9SD1a21Sa73B8PjBzbmrmRi5o
         UkBc+xHz/GF2pSxYDM6NdTCrpaMfipSPEzMlh+SZnLnNn07fLAXEFTsQPcvBR9JXGXXz
         Nv5KG05Gbz+4ZyO1Wi9n7A4KMUlT08bHbjWGlWWPbLjQ0nPNf4bj1Nme7wtAfDB9MMUq
         6+GVZW5n8KdxGg+wt0JKkU5FhcpwDJY1acNLhOCKKx+bsaVC2VxTrDu+GmfrKuaH82U/
         8lQ/titLcGutaPqyjbrfTwGsiuKaFAEh1/yL/zD3PrT79efdYOCIO3udF5N3yNJgw3Gf
         CXOw==
X-Gm-Message-State: AOAM530aWyaxgRA5uZnc9DV2hXWHJWXuZjEySfNDB//VXn8bHdkc6764
	qlGaQ83yUavjzZIWbLn7pMU=
X-Google-Smtp-Source: ABdhPJwFNHuUrEjh3QfVOTfDQIGZtXmcqAi/MrpL6pTxDNf7qcGDbiGiFK559NNiaxMOz0OPhJJkqQ==
X-Received: by 2002:a63:551e:0:b0:3fe:3f58:7ffb with SMTP id j30-20020a63551e000000b003fe3f587ffbmr436507pgb.248.1654671641317;
        Wed, 08 Jun 2022 00:00:41 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b001675991fb7fsm8396425plj.55.2022.06.08.00.00.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 00:00:40 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/2] x86/apic: add a more generic early_probe
Date: Wed,  8 Jun 2022 14:43:47 +0800
Message-Id: <20220608064348.66402-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220608064348.66402-1-ryncsn@gmail.com>
References: <20220608064348.66402-1-ryncsn@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_000043_170633_12E8C2B2 
X-CRM114-Status: GOOD (  17.13  )
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
Reply-To: Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Kairui Song <kasong@tencent.com>

There is only one early apic driver probe method: acpi_madt_oem_check,
which is used by ACPI MADT init path only.

Some apic drivers' early probe doesn't need ACPI info. Even when probed
from ACPI subsystem, the ACPI info is simply ignored. So add a more generic
early_probe method, which can be used by MPTABLE parse later.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 arch/x86/include/asm/apic.h           |  6 ++++++
 arch/x86/kernel/apic/probe_64.c       | 16 ++++++++++++++++
 arch/x86/kernel/apic/x2apic_cluster.c |  8 +++++++-
 arch/x86/kernel/apic/x2apic_phys.c    |  8 +++++++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index bd8ae0a7010a..cd3266fbfa63 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -310,6 +310,7 @@ struct apic {
 
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
+	int	(*early_probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
 	int	(*apic_id_valid)(u32 apicid);
 	int	(*apic_id_registered)(void);
@@ -498,6 +499,11 @@ extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
 extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
+#ifdef CONFIG_X86_64
+extern void apic_early_probe(void);
+#else
+static inline void apic_early_probe(void) { }
+#endif
 
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index c46720f185c0..3f600c421f07 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -13,6 +13,22 @@
 
 #include "local.h"
 
+void __init apic_early_probe(void)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
+		if ((*drv)->early_probe && (*drv)->early_probe()) {
+			if (apic != *drv) {
+				apic = *drv;
+				pr_info("Switched to APIC driver %s.\n",
+					apic->name);
+			}
+			break;
+		}
+	}
+}
+
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
  */
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index e696e22d0531..02eb8ea9a5b5 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -26,11 +26,16 @@ static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
 static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
 static struct cluster_mask *cluster_hotplug_mask;
 
-static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static int x2apic_early_probe(void)
 {
 	return x2apic_enabled();
 }
 
+static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	return x2apic_early_probe();
+}
+
 static void x2apic_send_IPI(int cpu, int vector)
 {
 	u32 dest = x86_cpu_to_logical_apicid[cpu];
@@ -197,6 +202,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 
 	.name				= "cluster x2apic",
 	.probe				= x2apic_cluster_probe,
+	.early_probe			= x2apic_early_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4e..c4dd4ec0f1ac 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -34,11 +34,16 @@ static bool x2apic_fadt_phys(void)
 	return false;
 }
 
-static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static int x2apic_early_probe(void)
 {
 	return x2apic_enabled() && (x2apic_phys || x2apic_fadt_phys());
 }
 
+static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	return x2apic_early_probe();
+}
+
 static void x2apic_send_IPI(int cpu, int vector)
 {
 	u32 dest = per_cpu(x86_cpu_to_apicid, cpu);
@@ -156,6 +161,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
 	.probe				= x2apic_phys_probe,
+	.early_probe			= x2apic_early_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
-- 
2.35.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
