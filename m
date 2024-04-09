Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCA4C67861
	for <kexec@archiver.kernel.org>; Tue,  9 Apr 2024 04:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=H2z87YSftIiEPnRAINOY8TT8UUw9mNJSLDNVuppuzjc=; b=wH3r+6T6u+An+G
	KpGeV9rlEBAhCaxi11UIJOGNFPPMasf5gdRSuaEkWD6aGJ/1zDCbwrIaVBrRPHntkyLF1YhjtdYyh
	83d6Fb9tNTT5lXbE65RnEPxMueiMWeWZ96vAH7NhmGI2TjAko8F5v/9/F53PTTlt7XSc8QW1w21uq
	VDscKfucbwZ2DLUZYd9588AyVAee3wosbYe+EMutVGjiqUY1FMRauskycJLpOq8n3sqsJTYa9/bdj
	Y5e3pPRPKSo2sCSgLbuTZXaJX30pCbABVVLSRuG0J1tCMQGLtifblHQ8H2F1ETcTlPqXLI7dYOL49
	vqlF46WvLyIgCkG0S3Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru30g-00000000Hwy-0zdL;
	Tue, 09 Apr 2024 04:23:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru30b-00000000Hvl-0tkc
	for kexec@lists.infradead.org;
	Tue, 09 Apr 2024 04:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712636573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6KAPtGBew3LOOWgs/rnupaUNsltQxJ2vjmJVi4Tpsck=;
	b=YIX6odZSjYyeyrrkLy8XQ161szI73sPA+2+xPChqJpKLxRfkREFztgrL1O7rM4ZIpQtrMw
	xVaAJ63ewcch7zHNNlS3udqfjsUfErwz0RCxzJgg6cW8oiOhqm7jBeXUYCSdxh3bdvHdbt
	AtR4cBGyOoyqYNftWDO2BIFO/fwb7cM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-K6JynX3JObK_P15MTvSksg-1; Tue,
 09 Apr 2024 00:22:49 -0400
X-MC-Unique: K6JynX3JObK_P15MTvSksg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 664E51C03163;
	Tue,  9 Apr 2024 04:22:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2451D1C060A6;
	Tue,  9 Apr 2024 04:22:46 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	jirislaby@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
Date: Tue,  9 Apr 2024 12:22:38 +0800
Message-ID: <20240409042238.1240462-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_212257_357862_1BA1CE9B 
X-CRM114-Status: GOOD (  12.75  )
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

Jiri reported that the current kexec_dprintk() always prints out
debugging message whenever kexec/kdmmp loading is triggered. That is
not wanted. The debugging message is supposed to be printed out when
'kexec -s -d' is specified for kexec/kdump loading.

After investigating, the reason is the current kexec_dprintk() takes
printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
specified. However, distros usually have defaulg log level like below:

 [~]# cat /proc/sys/kernel/printk
 7       4      1       7

So, even though '-d' is not specified, printk(KERN_DEBUG) also always
prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
not.

Fix it by changing to use pr_info() instead which are expected to work.

Fixes: cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control debug printing")
Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
---
v1->v2:
- Change to use pr_info() only when "kexec -s -d" is specified. With
  this change, those debugging message for "kexec -c -d" of kexec_load
  will be missed. We'll see if we need add them for kexec_load too, if
  someone explicitly requests it.

 include/linux/kexec.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 060835bb82d5..f31bd304df45 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -461,10 +461,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 
 extern bool kexec_file_dbg_print;
 
-#define kexec_dprintk(fmt, ...)					\
-	printk("%s" fmt,					\
-	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
-	       ##__VA_ARGS__)
+#define kexec_dprintk(fmt, arg...) \
+        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
