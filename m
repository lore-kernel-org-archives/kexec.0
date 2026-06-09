Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BA3CD8CB9
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HY2zpnwZZNY051yToxH8sI7FMWsbf7HGeJ1SpUT1rro=; b=KcodDVTi6reh9INo4dsiNhTF+M
	YIH0t1PiaSV/ip79aDDPsEU5mJyqIrxpb73I3iCPa1QfUS4/3wLt+4cVM8A33kugB2etMG+r8PAE7
	8tKYfNHq7tm8ZqlaTiB9sV5c7znsSphUMZ8YbU2fmWxo/OEfO975uI7+3+b19nXQdVBCQJUPE9Jv0
	fcfnagvsdH27PPXSQWis5qLF9XHHXp4xdiItRVFx4+eSoa79G5Tjey45zlHFZDW9uFUQdwnwhckOg
	gpKUJ4mvwiFMqljUuQvMz7p2+MOhhcUKPbpnLlmGsn262NgS9mnc/z75b1IKrWs1udwPXIvkkurOB
	ycHZCsbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwye-00000005ipw-3Kik;
	Tue, 09 Jun 2026 13:58:48 +0000
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwyZ-00000005ins-1uwe;
	Tue, 09 Jun 2026 13:58:44 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC1C87A0126;
	Tue,  9 Jun 2026 09:58:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 09:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781013521; x=
	1781099921; bh=HY2zpnwZZNY051yToxH8sI7FMWsbf7HGeJ1SpUT1rro=; b=S
	yLLvWGsF8USrb7t4GM+e+EbsdZ37zNxllPZqKgH2JSluBa97QWc8faKhbPdqoBuW
	LbNKnHn6qWjNVMdZwpDoRrFrSAtKuDLU298zPUA8FOjStuOjoWIrT2KpPyKX+Yvi
	bXFVLJ0x6RLhYPc2AwPziEB1ohzox7FZcNTu0MQT+MZXYqfD6j2xOKeGtVK6jUn1
	n7A7R+EHdgrtPiuVTtRWIp9XY58eEUIRlHV5OJogAOWbShEp1+n1wO4kmDuRS0Lf
	msZdPbwpCywUWBVUSosiSwLTS3+Br5FOzK4QuBa7O67mJJtFJMN0pVP/PRKr7WsL
	1tK8r0ENa2kFjEaSzGO8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781013521; x=1781099921; bh=H
	Y2zpnwZZNY051yToxH8sI7FMWsbf7HGeJ1SpUT1rro=; b=NvkT/Fl0ezzRoQfqi
	ETNpEw3IsPXHO+6ovWfV7gp2eKN2JgPc3e/5ZEdfIgyoexQYeoS+iOu4PTb6OAnm
	zmN4aHogJRPgwy7DGXslwOUPnsc51w4NWly46ZVlPDkqFH6nRHDVnLJ1Dw3k8Ifv
	Oe1qOccpp3gJ8gAWsKLdfT4CGscCmYrc+adrlAyKF6VUrQRXHMyDYsk9mqJcrVX2
	eQPzSd1vm87hvG8fjn3oGpFoZXgr/FIKOYzSF3U3KzQVDMrK7Cg1j/ZjzZ/LNXq5
	xJdROyqakVzGBevGCHm816fLIuon9BwyG8qxkkktaBtI9R7X8LOY6Sb9ilSogog2
	XvmEQ==
X-ME-Sender: <xms:ERwoaiRAg5OIy8TZcbx-6Hfm0s3WLX9KkctXFo6o1OhoMDBxnv6slA>
    <xme:ERwoau09DtTiTVKQh4kMsgGJtzvceuYhLPTkdA4klSXO4I5eMQfS4eMNsZ5O3h_yT
    llNldt9QRla9Jq2bQF5XnRCCZT7Vt-hC6ceznrOkInRUje7QXkucsU>
X-ME-Received: <xmr:ERwoanht-bsj6pkqdhOqzi5MU08VIZnOn5nLk0SifyFdA-5Y8xyBokRN1c6ntA>
X-ME-Proxy-Cause: dmFkZTFPkE6jOKWInc2nF8fviBkQiZaTOYIo8vpzqwY44In7ByGMFyG9o0Izi+uycfr09S
    kUoPpugTUFjj2EFh51WLnnKnt0BxwjK9xBt9UQFibFjm3YgkqxYgHwrxfIkgTGFaeZNbOm
    9Q3Cc0o8sYYPUNdRDwveAaOZYsgovgsagWFcRUBRDvxGySWeXhBNOmtdpPskPKrZ6ICIZo
    vhV/3K356ayQa6OjkxMOJ4bSL8/742I/tppoLNsDN4x5wHtcd1dRRoMlHtYUwFyJynJkmM
    gFzgNeiOPid6Zo5/YgvRV1AjNBRcvC9CpLFSsBnElAWwsAy3lYP7Jmzv+uZzppNuldyzEm
    1zE9rR4ZvzmHOfcjLEdyGw9ROcYKHxzKdoODJCwkGTp4VDEY66Rs+PglXH0SQpyS+iyR6p
    EUenoMX0pI5pnnnq6PaeSjkNq3QcTsEUr2Js0Vs9/ruRayN8VMxUSyiZX3mKj+dNQK86YO
    XbVLEfL1zv3os1beH+ew2FnE44IIgyuX9CHPOMTZ8CrD2Bb4H3/Vl1FVUZzSjRNHI/7EHp
    Kf+GWXjhXY8M7rjXHmCQcM+Cjwu5gT9BS/QZoktMPPRkwj5P2JvHatb5gW2M3fpa8FgsPi
    fJNvattOd9AmhbGeVhhUlnzy8zK+U94LRA3dPw9HeLXjm4uyAcIg9SHzJ5Xg
X-ME-Proxy: <xmx:ERwoakYgPObdUXIsKnNPVj0wdjtghd6uoU_qrn2aCJhlSg9Ovxrr-Q>
    <xmx:ERwoaoOv2v_FVL5b3xdXeaEBvTpqpyVZMP4MjutdTD4WzuHOjz9W5g>
    <xmx:ERwoagQeYm5xECWMrC52HAUyfNTlmN3U3Ydx1XRWxOgw9s5qF_ei6A>
    <xmx:ERwoaj5kneVZbEDn9lzRg8Fmh1bdnJEXQnH07LHu0iqte8d-JTUS5w>
    <xmx:ERwoatdYAcz-CAhydTlobnwpe9ulvi_knF52Pvwy6G5CzpaYlfiuiyjd>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 09:58:40 -0400 (EDT)
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
Subject: [PATCH v2 1/3] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
Date: Tue,  9 Jun 2026 14:58:33 +0100
Message-ID: <6208c0e54427b2e3ac43eede70af29bc3f38e17f.1781013134.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781013134.git.kas@kernel.org>
References: <cover.1780496779.git.kas@kernel.org> <cover.1781013134.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_065843_591024_C0CDA991 
X-CRM114-Status: GOOD (  11.45  )
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


