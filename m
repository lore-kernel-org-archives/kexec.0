Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBB3C5475B
	for <kexec@archiver.kernel.org>; Thu, 14 Mar 2024 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+lGAjUzLfDTu52OyzxBNkRqjzt5kC+NOtoK4OBD3p+s=; b=W4OCQjTFKuu/lk
	PZJq5eEnPw+qhdBaSEPcgR2i98wdkTanWgbCgU930O+kZgCcGuupCAQChDW9MWuAovtYK3o0JKRT1
	ix76YFmwNoJvfbN9vqufRs7P91PdddKPNr8FB3hE2bTFZ2wer0WAzd9TeAyKJhXvmoWw6nz6kATBO
	zdExXeVMONtBtS3bDZb6QD4J4dL/9Xfbh0zVeyY9e+3Lr0+CGwqsaIK56UvKYAiA/8CqB/TAAeGf7
	k3UBzGtFeMgZXnlrMuwJ290ZzyAQ9OJr44yFSTQkSLgLhIKawuGzywJYDSG5x9tVwxYfmkm2x0J9/
	9/053lYxJ54D5gVWh0LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkiVI-0000000DwXn-0aML;
	Thu, 14 Mar 2024 10:40:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkiVF-0000000DwWf-0xDI
	for kexec@lists.infradead.org;
	Thu, 14 Mar 2024 10:40:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710412799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h1t6v9xZW/pkiF5v9nyuhZFPcP+Pb9Nu3++MFe0FI4s=;
	b=UOQ8Sxs8TxnLebzuqBgWh8VyxnxSNWTqttWVmM5A8CIVhxFTngbasIEFQun4XgvTwORYe8
	XEQ/lPzTa6zuQuItc1NXbtE83lEc/D9ikhDhxGPXKNhaJj1scnu/BLdJHbpCxiBWwDz5+1
	kZRoBxS4etNjQdE3hR4KYHQ2wHq416U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Nvm8_iUWOYO1Tcub9tdI1Q-1; Thu, 14 Mar 2024 06:39:55 -0400
X-MC-Unique: Nvm8_iUWOYO1Tcub9tdI1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03F2784B061;
	Thu, 14 Mar 2024 10:39:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 459FF16A9C;
	Thu, 14 Mar 2024 10:39:50 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	jirislaby@kernel.org,
	akpm@linux-foundation.org,
	joe@perches.com,
	dyoung@redhat.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] kexec: fix the unexpected kexec_dprintk() macro
Date: Thu, 14 Mar 2024 18:39:47 +0800
Message-ID: <20240314103947.717991-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240314_034001_366337_36C9FE91 
X-CRM114-Status: GOOD (  11.28  )
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
 7	 4	1	7

So, even though '-d' is not specified, printk(KERN_DEBUG) also always
prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
not.

Fix it by changing to use pr_info() and pr_debug() instead which are
expected to work.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
---
 include/linux/kexec.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 400cb6c02176..09688e681bf7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -502,10 +502,13 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 
 extern bool kexec_file_dbg_print;
 
-#define kexec_dprintk(fmt, ...)					\
-	printk("%s" fmt,					\
-	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
-	       ##__VA_ARGS__)
+#define kexec_dprintk(fmt, args...)				\
+	do {							\
+		if (kexec_file_dbg_print)			\
+			pr_info(fmt, ##args);			\
+		else						\
+			pr_debug(fmt, ##args);			\
+	} while (0)
 
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
