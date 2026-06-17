Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9265ECD98F2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7RS03/MmaY3cdQXKqXgtr66oQZe2dlZd/HdIJVZjY8=; b=Gg58bg9UHfaqkYMXruCKY7/gB9
	UxCEs66PZeF1SdMCCvV/K+s57zjNLeKWZrd6Z3CX6uHhotpyrc6CrEI7xrKicJgN9ImVVAWNCMIzy
	k3NWbJnod+COS3PzYM8/fSeb+cLhEJP43kqz76WkqcAGmziUhnwR8kI+/oVUD6LTJhxpfsaMSrrBx
	6t4C1V7XNEbybT19DXcVEnpa7e5JtPfpj+3DXpLuYsfw9MG5NVz2p1IArYK5GXinPNTdIKK0qRdeb
	vLcwGk1CgW4gkz9nxDYcJXC0g7NNEDtm83je42Xq/ZcydF2nAnCtBMjw/zDiDK5WYcQC7ODvmM5Xq
	1f4pknEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvoD-00000000FUm-2KRL;
	Wed, 17 Jun 2026 19:20:21 +0000
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvoA-00000000FSB-2cUg;
	Wed, 17 Jun 2026 19:20:20 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A66B1D00028;
	Wed, 17 Jun 2026 15:20:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 17 Jun 2026 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781724017; x=
	1781810417; bh=S7RS03/MmaY3cdQXKqXgtr66oQZe2dlZd/HdIJVZjY8=; b=g
	1Gn/USLuUvDbrD75+Mu6huFWndN+ouuBKgzWyolom0kbV6lBIrLkdwaePhyco5Tk
	di0nh4f1kWEgIYGrX07L4uVAw+Vue0fbylcQJiTf0LX5FgnUgzeCdiI1o8tWEUYM
	HyMaRquKqOIs1fBjn3+kTrpWnbW4EJMK2j3tvFA9glmdGWwiv+PZp0e+c9Fuwzan
	tq4sIAGBX6qkRNVLUOvbc/wpclZfBAi9cFD3MfIlZs1n3RXhhOovuFTdq3LN0Oy2
	E0L1kyp7+YfOm9MX9YEqTFp/Lo75hT1Tsc65G8Ny6l3zpFFJeAsoRQswzwzo0nvw
	ZabS5YXP0FfRoN/vB+RKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781724017; x=1781810417; bh=S
	7RS03/MmaY3cdQXKqXgtr66oQZe2dlZd/HdIJVZjY8=; b=X1VjRLxircwA2mPO5
	mKUoSK0OFA5px7m6sZ4N0bEf3Jeo4jCaKpIWBzK/kuf2hbgkZ/K+qN37Kkzeq09N
	2UJ8EDzstJnIFnPZV932m+KFZ2gVhm2U6AtEZgrM2G2IcRaZ8jmQGy27LM2QWJvi
	NcvOZlbBrN63AfTwlUqt/lRwbejM8QDz/XiIEIV2dwDqQqQj6XmAbmgDC+IDOhJd
	Z6h1mrWWYXk+9HwPxfsU3SiRFqT1zYT87LACeVDa7svSAFAImAw6BRBotkaSo7gY
	zkEYr+TgrpPhFdhysUt7DaEH/MzYOSQiE2BRVyIYHliWji+JOj7K0/sn+MSJZM0K
	FZutA==
X-ME-Sender: <xms:cPMyaot28uYs3bX4iW4Pul0lrchgjSlZBVbblQv2YSm3nq4kAFAPJg>
    <xme:cPMyasjxPL7fplyRNUw6NsR7QbakQ8xu-SPotlfvvcfEMJ5vcbwFlN4jVTWuo9UqX
    _UU-KcqmDCRc6fFk5SYQO5lWGrMz2Me1IaG5ZdE2ZDZR8s-0tCWsA>
X-ME-Received: <xmr:cPMyarfDVh9xCem7oGo43OtDS7sFyEtqiATd2ycE_MyjfZQhb9HL_ePm-pFDsQ>
X-ME-Proxy-Cause: dmFkZTEGc1cCggI/FTMXCThQMoUsi+STagEgvDbTiaOx8lidkfShu9CsgNhNtxybperlSh
    wYaeV61DjWKAW2ZDUDqHrbShp9jqKB6/x0skOmcC8DEJ3f/o2eC9W6bOIrSc/INaK22aIk
    IbflIhJuf03G1llb3yUJ0Nxxv1o0P97QmqJfK8swgT5Kv4JfH1KHqzf5nUMZRkmudlGTXj
    +dUDb1Ng5eMd5XdZ+EIP9BjvMkuOGaArezM30dBLvwSBZlBigLMmcDp+96Lrfrt1P5uaa+
    axRUvc/FMxejiroOZbXEvIo66OfTMIX7BLDCfqbV1pUgnY23e+uL1L42S5XHrJoFp2Uwf2
    Mh/wMeKNo2LvDGkdzd8R5jKUkPO5Pb/tL9QRZLm9i4f6JWpWqFk+YL80nk5VySrnXmmO05
    DSjsJjShBq7XCiJPdpnW5e3hpQbbEcumwnTLyvr6YMiDZpEndphv7+fADDORkoe88tYAee
    YBcBGQExrOOEnaNKeMjVTNPcrKhsvfmx7E370SIDjSKQk0WofxkQQm0qgGwWylEDbIs7Oq
    uSJltFxbvU8fSHpf8xovObAI/I6x5EMB1T4HXmKKHO24OKQELf1iK/HxNR0ILMYy7qCk1a
    sIrXBc/HfsuYOOSHxptNSHELhNZFXj+8EA7sbJGJQH5OSrtH8gdAqzKdzWLw
X-ME-Proxy: <xmx:cPMyahlzijTRqSvpmx8l9XKXKDEPUz518ED0AK8NA_opdjLOjs3iZA>
    <xmx:cPMyalqFIQo6TTx3zdE75TYc9LblOlbxUMirFKv4ZesTdzGP8az-7Q>
    <xmx:cPMyao9U3gZxvffhysxpKpoO3GJQf6IlRELFZ4dVbi2bL61wqrvF1w>
    <xmx:cPMyam1_pT32YjKLeKej5M-1I6oF6VB6xQ6odWZ6gmJOLxAkd_n_WA>
    <xmx:cfMyamoy5ZqXN_nOEQXdAFRpPEkORLM3qxJY0TDkNXybjkLUor1pq68B>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 15:20:16 -0400 (EDT)
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
Subject: [PATCH v4 2/4] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
Date: Wed, 17 Jun 2026 20:20:03 +0100
Message-ID: <f03b3921f7f0b795d8b25f9688a94ea910d8a5e7.1781709543.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781709543.git.kas@kernel.org>
References: <cover.1781709543.git.kas@kernel.org> <cover.1781709543.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_122018_997165_C1E8568F 
X-CRM114-Status: GOOD (  11.66  )
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


