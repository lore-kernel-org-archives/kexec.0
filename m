Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5432FD5E14E
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5iGeiX4E1s5Zpw7ekJuj9LnluOt2w5YNk4ehhCKOiRE=; b=h0yKkTPp480TDi8L/b21HQUFz9
	OMWIDIYptraBxztBiN4Qjieq/ie+5dfK8jtQX5elJ9dQFj1NRtKdvFT6qaSiaFg+VzG8vKKZEUFiL
	jslwPX1tEiOhSRokk9WipYhAJvyT4a3U9yk/wt/S73PKcb6L204zB8t3p3dmL59Sc60q983Y3GyfI
	kJanaeCaDxKbaNH/O0AyehuNoGWMOOoMk+U5ABbkY4sw3lFgE4igb+NINREwmKOO+tPDP32Zg0AzN
	66nDkeYE+QQFeeMlLBrUY1Lc/Z/bgIk1/NMI19F7mFGHw5vQ4kqJ0aNDydNcReJVViUXefY5+zRJg
	DkU6THuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV6W-00000005Fmk-3S91;
	Tue, 16 Dec 2025 13:28:40 +0000
Received: from esa1.hc555-34.eu.iphmx.com ([23.90.104.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV6U-00000005Fkm-1WNY
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 13:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1765891718; x=1797427718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+k+9060VbjZlu9Xk37ggzq9agHSaf6TFpI6uV0BnxcM=;
  b=me/a1saDzmQa++LtPmZbdTJP31tYnffrc0AGlR1uYcU+poIHp0PWrNSi
   HPXMDwz0YrmM9YtMeIiqbM2bccTp2sBrbrlX0Tra/7geeFCGiwK4qASAv
   QpSCDHbjwCwwaCP7/Tqh5Bgb5MSAdoQ9OljpdidbaNqCo+4SMMPJyjJ0V
   gL4d9IH6Hx8A3ZwPGI8nSV9ka5pk0gqvC2K1C1ARCLTq0cWNyKTfxCkZ3
   njQGD66ThgIOlA9tcNqEgPwSCRQp9aaUURQCgb3ys1vUxbERCpu60c2PT
   gq2RqoCCcAFxFGjxlbUaLpzbxOb5eGyMmcAQXYH8pV6HTNlE4/WvWlcJI
   w==;
X-CSE-ConnectionGUID: bEc8fFZATzio54K2avTJug==
X-CSE-MsgGUID: oAufUdp8TNadW5+O/WWUvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 15:28:36 +0200
X-CSE-ConnectionGUID: qDu5oNm+RT+I2zFZyqnFsA==
X-CSE-MsgGUID: n5AbACJbStS91yR4szaKew==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.6])
  by ces01_data.me-corp.lan with SMTP; 16 Dec 2025 15:29:45 +0200
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 16 Dec 2025 15:28:34 +0200
From: Pnina Feder <pnina.feder@mobileye.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 1/2] kernel: vmcoreinfo: allocate vmcoreinfo_data based on VMCOREINFO_BYTES
Date: Tue, 16 Dec 2025 15:28:00 +0200
Message-ID: <20251216132801.807260-2-pnina.feder@mobileye.com>
In-Reply-To: <20251216132801.807260-1-pnina.feder@mobileye.com>
References: <20251216132801.807260-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_052838_710082_6023A138 
X-CRM114-Status: GOOD (  11.30  )
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

VMCOREINFO_BYTES defines the size of vmcoreinfo data, but the current
implementation assumes a single page allocation.

Allocate vmcoreinfo_data using get_order(VMCOREINFO_BYTES) so that
vmcoreinfo can safely grow beyond PAGE_SIZE.

This avoids hidden assumptions and keeps vmcoreinfo size consistent
across the kernel.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 kernel/vmcore_info.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index fe9bf8db1922..22b3205dd4dc 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -137,7 +137,9 @@ EXPORT_SYMBOL_GPL(hwerr_log_error_type);
 
 static int __init crash_save_vmcoreinfo_init(void)
 {
-	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+	int order;
+	order = get_order(VMCOREINFO_BYTES);
+	vmcoreinfo_data = (unsigned char *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!vmcoreinfo_data) {
 		pr_warn("Memory allocation for vmcoreinfo_data failed\n");
 		return -ENOMEM;
@@ -146,7 +148,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
 						GFP_KERNEL | __GFP_ZERO);
 	if (!vmcoreinfo_note) {
-		free_page((unsigned long)vmcoreinfo_data);
+		free_pages((unsigned long)vmcoreinfo_data, order);
 		vmcoreinfo_data = NULL;
 		pr_warn("Memory allocation for vmcoreinfo_note failed\n");
 		return -ENOMEM;
-- 
2.43.0


