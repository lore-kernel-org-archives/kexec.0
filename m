Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825ECCD8CA8
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 02:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HY2zpnwZZNY051yToxH8sI7FMWsbf7HGeJ1SpUT1rro=; b=IjSCfSTsq6YfTBQ2lqd6jB9p88
	1RS1CHvIc4FqHQhdoz3RnGiInMhGYTpRSXi5Q6a6dMnWdkowN9gHTANtxwtOA1oivUQ/IxFd19y1D
	smpylGrohm1cEkk5N5fHJ+RphDkiNM+0KZiAGPuSq/sZSqlrE6usMtdQONV8yKIGrcTRdTHCXYrle
	swjy9a3LUu2MLIJqjCtPVPjZL17SwB26J+M4AccMOed37XNWF4ifig8hQNDByVcmD+kJsfjVhTGuZ
	kRv9YoMmfMbARGBf9fY4cX9Y39gwkXqMv1LIBu/Nsv6Otqy6fFeMRKFa2tOiar4y1GFCgP/xlMDdp
	rumgKCwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYxB1-0000000DTSH-2zSz;
	Mon, 15 Jun 2026 02:35:51 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYxAz-0000000DTRR-0zLh;
	Mon, 15 Jun 2026 02:35:50 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 78C44EC0076;
	Sun, 14 Jun 2026 22:35:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 14 Jun 2026 22:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781490948; x=
	1781577348; bh=HY2zpnwZZNY051yToxH8sI7FMWsbf7HGeJ1SpUT1rro=; b=Q
	5mga/APtg63/nU0jRAvWCJQToKXZwQUgKS+UK7HoFrogiiKNPBWOduqqSCZLOHKP
	Wz0JOCSnYe99Jfb1+VBzklU1C7AOPTIWugvH1SSiccC3giJMltNEYkYnigEmfloB
	ENrptU95Rdc0ig18w9VD9xd03eMREc6yKKwB1hmRPUBrd8OpjaQDkt3AnAJcx6S0
	xaNBaw9a6PVt+oZuGLcF6rMb+O+IKNsz0l4tZKOfFItZJTI0e3XjsqrUH61CFyln
	lVsUjCcbrMqfmSTdyebh/koMHSDKw5vTxSJ1EUnZECNrpmJz4U/rZs89NBPhMKSe
	WjdOd7+nBFjpatGbCI7/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781490948; x=1781577348; bh=H
	Y2zpnwZZNY051yToxH8sI7FMWsbf7HGeJ1SpUT1rro=; b=dSJJ5hUrAI2aMG6Vh
	aifuek9y2ofG4aYNsNgszHmwuZePLVIK+iM4/tihFaUYEXcKPGI0PQQx9np+WnF0
	BZWl/tuGNOuyC6YlXnY1GgSVItXecPu10pdO9kfsegX1GP3Uuc1Kw4iMZazKmE/n
	cRxt9eI5TPqU2KrbaBhI/ELGcu74LXvRaUkhS2EAZvvPoMCeLkLcVhJKwddyS/mY
	jCzo3sStkFQtipQ7ls3zEO8vGAgHthpSSKJuymCAW1+ucYkyU5RPdW/vo5xSQEO7
	+Qedd5ga0kU2floggvJ+o93VreHF+Hv8QRCcJYqXs+7jzrCbwVUfhK9NsFJCcaca
	5j+MA==
X-ME-Sender: <xms:A2UvatoNc_2R3F--dErf3NiNkvaRdvPpeb2luylCgT3AU9_siK92cA>
    <xme:A2UvamtYwtlI0pqGPGFPZohe7AMkygHk9ywBFX1aJr1_aOy9w0ID0Z5Z4UatoWkAx
    ZlwKBMFS23ynthDWkJy3hbPvhkeW4mUAgMuk4VL7bcfaE11WSM7NA>
X-ME-Received: <xmr:A2Uvah7pnalvnuyFPvA1B6kyRe2us852CZNKTS_7qkfvr8jhNSAX8IqQMtiUog>
X-ME-Proxy-Cause: dmFkZTFXYugtQbnZlNN2/o/zzlSDubhnwqvVPBmmfic41l0ZizTFXUexiJG5sx/3COCTIP
    1pgfgPxMi0BmG9L4jpykbNXuWVID5KcBrejVtrUAw7dSCn8e1k9lTHepIy+fb0ZeKwuh54
    ZE5HAI3pRKZI22mJFH+m3CPUX52OKhdR8SKh4O/2QL6ezZx0UKtA8K0IuzHXF+hs7Nn+th
    Zmvb2e+t7XuI2DC5QvXlXWpK4nfyblolCP5BEVTjbIDglDpThlDQS+OwJfIwK2SrN2aVc2
    CnvSrsaRWozGICn5Uvhels5VDHffedDRdP+aeoF7XvVghlffZHMCjZhZTkdLX3MsjSKshp
    2jbk6fYpbZHMGG8JiF750NpDnP18s6GuxQ0pXH5p/fTNMF+srcmg6Tn1eE/B9Y/tfi+Pwe
    hVZwXiskQAe7OUG2mYRJsK7BANPIgSZbEtbKsjaRyTIC5oIFjHfp39i3vsKD4c4Vco4ApY
    svUOCU/xQz5NyhXwPc10fLBpYLcwwQHWg24Laqyr8mO8nC6TotB62CgLs83rt9oipyCxEB
    fd8h0WK8FZOVtMrCPB35nbhj991ExjZNpGHGONtBV2GLfU3KxUU+5hg91RZpChAfPw4UtG
    FP9xoi3LASNggKBPMDfH+OQ3jZstfuTu4fhFUu2rfDFJnx+ZNYqxCN+2gzhA
X-ME-Proxy: <xmx:A2UvavTpY80193K5xxz49ZJy2OhO_3MNZU9mi-oFTXsAukqSaOL0aA>
    <xmx:A2UvapniZftU5_6DhnMpeIQT8GOJIkgabdO7V7knMnqt-rNdY6fLUQ>
    <xmx:A2UvamKi1MSOAXBpwf20xKe-nUBoJgvbItj9S1G_CE-0SadsIxZJwg>
    <xmx:A2UvakQ09CFpVf5HdXuRBZxzH74WKPvJ6WQpqNK4LtNpzR0VY11YOQ>
    <xmx:BGUvagVimmCPprHEAVFDXVqPtgAqBEOYwxYa3mnzMxPWtD9d-LvmnbEm>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jun 2026 22:35:46 -0400 (EDT)
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
Subject: [PATCH v3 1/3] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
Date: Mon, 15 Jun 2026 03:35:32 +0100
Message-ID: <42135d6d25f77afef980e99e83aebf169ff6bf9f.1781490440.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781490440.git.kas@kernel.org>
References: <cover.1781490440.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_193549_700972_B091DE21 
X-CRM114-Status: GOOD (  11.55  )
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


