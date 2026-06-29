Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A65C43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7RS03/MmaY3cdQXKqXgtr66oQZe2dlZd/HdIJVZjY8=; b=gnPguv+PYKDIISafIvKpxaCZhu
	ylyycXgBwbDrwZGug30NkO+4gicHTd8JlZgMgi51CngR5OqVpEkFtORx+5/vh6V2oICEnOALxo77w
	OIvzt6SUC48V5LBtURZFPSzswYg9t4EXOQoHFoSh6hKp57XEdwF1ivlL0ZHUFWJaASSJujZAvZn2/
	nbr0e2V6H888KpmhwppEWuB2FeuwGCBI+ZSD7BtwQRdOl4Lz6ae1JwAjVAOAnu8JfMnmuU5SQk0K6
	YSO6FulbLBXjtUVU5O1sigdf2bfwOrS0Dl1G7T2HdIsrM7F5oI57Cl4RIn+j59OGNeFHAMTYOKO7G
	SfQoSdYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa8-0000000F12q-40wP;
	Mon, 29 Jun 2026 15:07:32 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa2-0000000F0xs-1Gz8;
	Mon, 29 Jun 2026 15:07:27 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C946EC016F;
	Mon, 29 Jun 2026 11:07:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 11:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782745645; x=
	1782832045; bh=S7RS03/MmaY3cdQXKqXgtr66oQZe2dlZd/HdIJVZjY8=; b=Y
	vsHyw5l8Ow0qSu4pk1slm2sEK5uf0eC6hKyK4N0v69IjbENw8f63jJD8aEx4U3GI
	WzRkaSY7PBgQwyWolgreJ7JjZGPG+V7UAWolvHGOEvLLYf7Px8QCui+l71MrURJX
	IvqiZvJ/j7tm+kshmRxQTFoaz8yMMxSsuvtS1u9j/fxO4+o6/rORxKHt688+kgLY
	XeDG5okNSKwgujRgPHFMvLWwYjynL7B9f8X4HZixmrUWH1a12IBbgjPcn6ywUgtu
	xH5K8OT98OXk/kafD8BsrMq+bxyMkMmViMpGF6L41mioXN090T6/WyFGIzbXLNyM
	4LUmLdZEx81Ln2rX3+jog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782745645; x=1782832045; bh=S
	7RS03/MmaY3cdQXKqXgtr66oQZe2dlZd/HdIJVZjY8=; b=dolS+w2NZUnpXQK12
	NWJsMy5HbjW1eie7+KneW8t0UYio1Bk+1nmdvcRkFvVMYYo4cLlIOyOhuQR2v53h
	bRKxPMI9YZw1fBEPUkcR523qBTp8yPje6qvO5JQils8u69a+sGWPyvCHNUTLg953
	8bfsYCOZQD/0QHyXH49p83TCTFj9X1+GaWez7cBXNhP8402prjBqW7ZI4BelwVJw
	azYpmO7ScLd/KgQiZ6w1qAyUSIGtZ3kR14qq3KjgBpETy+1/wuIGLUg7KfSmQWA3
	t0YMytbP3rl77NvuTWhw9OrCe/A2W8ze6RGs2Lwy6tk3HUh2GHTO6xmebcl+FxWM
	dmmug==
X-ME-Sender: <xms:LIpCaqE1ox9DeXYavkemrmgFHaG6b-HEDuTX0JUljSKd-Ue0S71AKQ>
    <xme:LIpCahyd4jKZ4E2eaK0lhhv5FHEVeOVIXJamvLOoboALXVcsZxulrl0PvlCO71hKp
    GYmrgEh3sL8hxIaQxL4dQPBwuvBedS-4p2Y2-8SvKrI191X2wPoL9cI>
X-ME-Received: <xmr:LIpCahrBgivTycFt0r2NFKmbeMIL11EsCEsI-9aRZCCPOm9zzFXBbvoDsnBLBw>
X-ME-Proxy-Cause: dmFkZTFOPz664UnxhPwbAXeUILB8R0nbIcKM33ML7sHDB9RxatB4JrIdzleRaRzSfozVR+
    jllYU43CguzmMbHa6rTo0GzXAayETLDZioqU4TzQQlMiW/C7TMHdcrx3m3Gozp10S511Rt
    6keOFeqI3JY9gNoUEG7RpfU6KWw+qp+T0I5trTPFeHsd/ctYvl+UHFjHAYuEJwEIExQw4K
    B2P8IMX6aUu4cp2HydhsZUrRrCe1YYCUnWbzaNuYS66EmnjxhjqUYFOYhaKvkn+yuQjAPk
    0SIcOPkOQqI0fMEe9NHJ8rK4I8O2chH+LxqGRPrO0yXZqVKI5myFx978Zr0IlEOBn/F9QU
    MHh9Xq+wBtiThYcMY9HkzHv4bq2lJLiUehAr/5CWBvthAs3C1cOE8OLJ4Ws3AjcK4sdrgg
    M1UoURV7JNVEFTnRp4kWTNjIl0pOWdezedfgFoe4ozwzxM1Tk0tYuEORwMumqwoL1dHXd1
    et6sVjKqrbXO264iKwKoHIaDV655buPgkoydZwY37cLqqu6U7uHOQbWLvwoSNdEE2dJ7zI
    jn2ZVJPtLcR+l6tLQrLOkidvhNncr01eJEZoPwf6pTXd1OnfKS9O1fE/qBcXFI7Bth7AY7
    0ZSGPgbnmH3+V+BY/6uwANd360LJo4PA++Ia73d8wWx8f1xLpQtAO8t0GzRQ
X-ME-Proxy: <xmx:LIpCaseh2w7APfdTYkGWVQGC_hyyIpZfU1fTo3f-0-jmiPujokJq-A>
    <xmx:LIpCavhcIvoh9QjT1MVAWSN7ofq3qbs3G4sum3MY252pVwz888Zlxg>
    <xmx:LIpCaiJq979kIfAnqCYK0IELFmCV1c6BwdhNIriAj7TSyoV8ep8O2g>
    <xmx:LIpCakpkxgOVMEPEvuT3x1oHnrpQz1EHSQy4Vl0HAfFmycBz7DZjKw>
    <xmx:LYpCauzGJuHJZUyGmi8U6lKE4V9--gJadpVZ_GfgvsFOPNH-8AuzgvHs>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 11:07:24 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	kernel-team@meta.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v5 2/4] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
Date: Mon, 29 Jun 2026 16:07:16 +0100
Message-ID: <def2f1a87ea36a5c3817ca5fbed8a01b7422e4c7.1782744912.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782744912.git.kas@kernel.org>
References: <cover.1782744912.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_080726_407420_C7D6293B 
X-CRM114-Status: GOOD (  11.97  )
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Add sdei_event_signal(), a thin wrapper over the SDEI_EVENT_SIGNAL call
(DEN0054) that makes the software-signalled event (event 0) pending on a
target PE -- delivered NMI-like even when that PE has interrupts masked.
It takes no locks, so it is safe to call from NMI / crash context.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/firmware/arm_sdei.c   | 12 ++++++++++++
 include/linux/arm_sdei.h      |  6 ++++++
 include/uapi/linux/arm_sdei.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index c161cf263547..e8dd2f0f3919 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -339,6 +339,18 @@ static void _ipi_unmask_cpu(void *ignored)
 	sdei_unmask_local_cpu();
 }
 
+/*
+ * Signal the software-signalled event (event 0) to @mpidr. Does nothing
+ * but the SMC -- no locks, no event lookup -- so it is safe from NMI /
+ * crash context (e.g. the cross-CPU NMI service).
+ */
+int sdei_event_signal(u32 event_num, u64 mpidr)
+{
+	return invoke_sdei_fn(SDEI_1_0_FN_SDEI_EVENT_SIGNAL, event_num,
+			      mpidr, 0, 0, 0, NULL);
+}
+NOKPROBE_SYMBOL(sdei_event_signal);
+
 /*
  * Was SDEI firmware probed and is it usable?  Lets optional consumers skip
  * registering an event -- and the warning a failed registration emits -- on
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index b07113eeeff7..b9dc21c241be 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -37,6 +37,12 @@ int sdei_event_unregister(u32 event_num);
 int sdei_event_enable(u32 event_num);
 int sdei_event_disable(u32 event_num);
 
+/*
+ * Signal the software-signalled event (event 0) to another PE, NMI-like.
+ * @mpidr is the target's MPIDR affinity.
+ */
+int sdei_event_signal(u32 event_num, u64 mpidr);
+
 /* Was SDEI firmware probed and usable? */
 bool sdei_is_present(void);
 
diff --git a/include/uapi/linux/arm_sdei.h b/include/uapi/linux/arm_sdei.h
index af0630ba5437..22eb61612673 100644
--- a/include/uapi/linux/arm_sdei.h
+++ b/include/uapi/linux/arm_sdei.h
@@ -22,6 +22,7 @@
 #define SDEI_1_0_FN_SDEI_PE_UNMASK			SDEI_1_0_FN(0x0C)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
+#define SDEI_1_0_FN_SDEI_EVENT_SIGNAL			SDEI_1_0_FN(0x0F)
 #define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
 #define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
 
-- 
2.54.0


