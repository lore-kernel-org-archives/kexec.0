Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912DFCD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7xz1aX70qn9PI7ve+ARdDiOiusxyII7zIQ0VV5UGVp8=; b=Lj2ntif+CGK4oB+fGjex1A8AHk
	VpHLc/Z6jUpZN9g5dkjAo/h06WfHUL0U9nLubaEC6urua0tK7bL6yVhDH7CAvjV+F/eipR01IDW8R
	y5rpMBIDNB/U3I1etcuFapC7sveu+VDQuKJF8hsdgrEmV2UVsILEZQYZKQEsboKO5exPgYksKlnrV
	q3KgjOqviMgIXDK5hz3vCNDwYePXX/Z35HF6Hjhfe8kuA2jVs+NHkmcGJpEPUCRGUsZYKONlgaDwL
	CgqXmLV3d8sccLNkH3s/iLHqpfThKxcQ+lGYQcMarb5pQwaRJac4DrkWoPOOpwOTZstWIQh68vDkt
	4ALUCZlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmi7-0000000FGLy-0IfF;
	Wed, 03 Jun 2026 14:36:47 +0000
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmi4-0000000FGJT-0LHM;
	Wed, 03 Jun 2026 14:36:45 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A3EC14000CC;
	Wed,  3 Jun 2026 10:36:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 10:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780497401; x=
	1780583801; bh=7xz1aX70qn9PI7ve+ARdDiOiusxyII7zIQ0VV5UGVp8=; b=x
	pIDWgDakKPnOoL050NQ8/xbJ+zl2eU//r++7fa4cPBo8tWOz3JzyLQZjGrJ6x4rd
	8RJngSLDi9vJKtfAoXPbMI/9AHpFwRnkFjqkeu8/7Gatdg+clqThvMliQCEK017E
	MxRKgjizwg3f5a10JtbYwvZksXuX4PGwdfAHfybFrpoKGhK6wyB9H3EBTe+IC2R+
	Yl6NaZ1UTOIqZ+mVOifo4YRIFt1RnI2yafR9Q8NLpNLpOsgArqTKyEPQa+o4m/Wq
	NEiFPotX69DAFbEPgb8ltlQABvBysR49b3yDptmKkztak3bchDPznzIC1klAp4Pd
	IbYAxzTjnSg9QHMY0xPdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780497401; x=1780583801; bh=7
	xz1aX70qn9PI7ve+ARdDiOiusxyII7zIQ0VV5UGVp8=; b=Ttqyi4M9W7O9CHzMY
	EwzZh7JYsqZJUNMRXmYWI2nectSS8yjilBXOnEa8sPcb4ruZj7lohy5sBjTFVcFw
	CP4Ke1Dmk/hDquLcCtfY5PUY+JWgHcGkeSt9tppZKJOnKoUs6qKHkuC7kX5rNFLc
	ymz70zoAqB3UbP5W7Wdt9BFdzexFdgYh+zpqhz90TgsPLV6pwXCumtiQHYhMjgCR
	hBCZFd8jWVdhdcX6yO7XCpM1b25Rl3AG1tb/MGFwqX4ic6paJBJejNtWW+07NPYK
	s5IG7o8d9TFXUnNp170ShfXosP11uwB+aqRGCqqAUMHfGVIYEKCNoO/JbD/OwWYe
	68c0A==
X-ME-Sender: <xms:-TsgahjeTxhrrqMg4TnmSpsbFzZH-nBukQkK0qRnwOh2AujDhkxhhQ>
    <xme:-TsgatG2BmoUJ_F1dT0hXIGET_ivy9PllumfjvFgvDVKRSa36Mu6PaTDVO6h1731t
    47aMYXODy6s4QmkFCz30JNDHuLFysxPjvmHTJQvfVKjwK1OTqyzyEQ>
X-ME-Received: <xmr:-Tsgaoy-kf01oAn9AnBXb6CLtWnIDUlmtf2HLNcWQRN7jjlcitrZz4pJOfR3eA>
X-ME-Proxy-Cause: dmFkZTFVMaZNPrRvSfF6lMDYeRZ1GT+YvZmW7/XK/DI4veA79wFWZ3OTazeQfPnYwN97CC
    Cs7iG9lFDm4VwxgpNn+szFkMQ6p+sawghQpLMos458rKa6kqCjeLITn+xOFJRuLH44jdjC
    bYnKt60OIxUI0HzEiKQ/d/999Ki3O4KAWblGhTDaHqAwTlFtGQQ5XMSyzboPUJHYsMRxyM
    j/zwJItMy9TSzKSj2Y695qlb0/SVGvKOj9QbiUnxexRfYyaiNrFZ52yLjpFN+pCrTPE1BV
    zfeSjTVtTl0AdNVaDzT7MlIgVuikoL9aGaZH0Ygsy1IGcYaK7xBN9rEeaPK3HRSnq6UCLX
    7mx1vjl6T+Qg3Dkz6sCPmZZWdbsSp+4rrU2Qbo/UdG6OHiNBWjv3g0zCjx2c0QDnaRY/7u
    wX21gKqXPZ/zlcGiVQ878DzqL9dpNYIVwUYc2Ef2C8hygYd+rQXQHSGcGXlWM4oHb9cJpx
    jBq87hbpXCmIpC3zmnf8JtPVlf8FETS3oGcoBXYstAasJ7BzndZOnPApmJMQpq5Gq9590f
    +Z96L7n12f6GLORHRpuJyuUPTIuHsLxGRjO5KICo2yip8yrOr9Tcv4W9PeZ+gP2RTH8joY
    E4548RaYz4CmiiLyX8dytqOYkH7mxiXTmkXufYEQQ9XcDvKqYBgKzRS/zmRg
X-ME-Proxy: <xmx:-TsgasqdXsPgGria46GSKAndQIttInyddXfcK6cIZzYqCo4rdN_KLQ>
    <xmx:-Tsgare4_lFN_I94n4m-l-G_3d7sg-YRu539soLRRBLddk542IGdLg>
    <xmx:-TsgaijB7luPmjU9AsNcvffOjVSDn5aAqBZ-wWqzJNm7bEchJvdEOw>
    <xmx:-TsgapIyQQJa4hQxfIypGmLmLiYGTFdc_sgA18jHrTRvWPMfBOU9fQ>
    <xmx:-TsgajW7FKmCCo6Vs5OSBf9XpTzCpGzHUdUSU1iA8V18GaamSBgHMmG1>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 10:36:40 -0400 (EDT)
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
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	kernel-team@meta.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH 1/4] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
Date: Wed,  3 Jun 2026 15:36:32 +0100
Message-ID: <ba8074cdb9ca5a471162cbc15f775c1567a3992a.1780496779.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780496779.git.kas@kernel.org>
References: <cover.1780496779.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_073644_182183_87DD05D4 
X-CRM114-Status: GOOD (  11.83  )
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
---
 drivers/firmware/arm_sdei.c   | 12 ++++++++++++
 include/linux/arm_sdei.h      |  6 ++++++
 include/uapi/linux/arm_sdei.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index f39ed7ba3a38..e3fd604d9894 100644
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
 static void _ipi_private_reset(void *ignored)
 {
 	int err;
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index f652a5028b59..3f3ec01155e8 100644
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
 /* GHES register/unregister helpers */
 int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
 		       sdei_event_callback *critical_cb);
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


