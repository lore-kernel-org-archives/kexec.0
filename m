Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B07C27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zYgIbjQGVzSJTo8qyjXciZX6UZ1nc8XIXjfF4GV9O5E=; b=kZdkWwKfKhnMDL
	XtHcr3YYAihnz2yVb5oeSZNTEE22UOnMtOeoylsmMTXFxfOzKiK9U0T87cHVubpmgk7IVGEkM/aaa
	H0cOgvnyV8YzKHVeGu80VZV7LSGWKizptWKRS0AF8F2udLHNq1xlkpWL9rWpwHUuiddwu4FRJqZ95
	nVSUq+3ujnh595lhcSjAHufzjw+wpXgTjoe7iugCxwv0STU7Hliy75/m1wwmTwsXPfVLYJs9MGbiB
	3oJOtwi9P7Jh+yD36YtwOtUNiF8u5UfdrR0c5IXQG+XtdptRj9ZQyoIzZ5lV3SbSOIYbcsmKinIag
	PBm2u+nC2Z+eNKu7eZhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYg7-0000000DuSo-2VMa;
	Fri, 07 Jun 2024 12:26:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYg4-0000000DuRB-36QP
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:26:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2P/UHfuOg4ehNZSVTesGfCNw2riSEHvP0JbrY+cOcU=;
	b=diMi3MZLtYcvq7+klUD6ZX/wDIoUaYtTeT586o1Jc1lgPuO5GY8CLYMKixiaUkRKr7t12w
	3rPTmfHkX3cbSGbhSVCR4g1Wb5iTAFFQSUQ3gYBXFA7gOgOV+qiuCkoFNQFiUsk1nI2GEa
	FuSAqWfr7kzVNAte2ujAnxyN4v+0OLs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-OK7C83xZMf2vdDMfD-w3OQ-1; Fri, 07 Jun 2024 08:26:37 -0400
X-MC-Unique: OK7C83xZMf2vdDMfD-w3OQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f682e70799so16713495ad.1
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763194; x=1718367994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2P/UHfuOg4ehNZSVTesGfCNw2riSEHvP0JbrY+cOcU=;
        b=kJj1t/jCHiJt1M68i0bqQv+ayXe0XtD+mwKlSpeefd21RcruasBfJct0AsWJis58kA
         oWnO9hT/PYNMvWIthvwod/YW4J+8UK1E0E+a/JkiHsPOZgvq7M2kla8DWZZQTfk9+mhD
         4IX+oWqjvn82xfvrBua+rInH8GJLl/7Cx9L/m66CX7cTJF5ZaJnpI7v2Q4jFVt9lf6ci
         bCblGJ/gcDGe354CW4pxuFvBZzhUiJM8Hb0uipnzaWrOzgbb2J/VDDqbWEZ7QdC8RaKx
         tNZPEXhu2LekYB9vZc2OBqbMEoyhOUMrxl/rxCSMZHn36ReP0v9XkXADjdB1R8pNIa1/
         CVdA==
X-Gm-Message-State: AOJu0Yx4W8eRR1Tmkuz/8X65xeHsfzSljMLrcayRVOZYK/jFidSJVl+b
	kCEh+fwRP9f5PUYJdUvMdDZS6qGiCuUCw3NUYnkWZszFtaKwdcPvBwzfaMEWZpjWvXGZkSVSwMi
	ZM/begcHCHTumYK6lCh+WLeQC8i5GJaUv59Hn166qtq0FDc+VmzLsylrbQOk0AZrt0cf4SgivkK
	8Ib7Y0aO/1+j3Ai+jTvSPGDqfNWFDC0sZvmxnzXtQjuA==
X-Received: by 2002:a17:902:e54c:b0:1f6:5869:df53 with SMTP id d9443c01a7336-1f6d02e647amr28703925ad.20.1717763194100;
        Fri, 07 Jun 2024 05:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxwy+yOhlJ8TSNGn0kZKxDg2jLx7D4xuuGL3ibcgvt+PHeSDr3Kf0fwtpAOyE6i5wHI+pohA==
X-Received: by 2002:a17:902:e54c:b0:1f6:5869:df53 with SMTP id d9443c01a7336-1f6d02e647amr28703345ad.20.1717763193274;
        Fri, 07 Jun 2024 05:26:33 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f45bsm33029905ad.35.2024.06.07.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:32 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
Date: Fri,  7 Jun 2024 20:26:11 +0800
Message-ID: <20240607122622.167228-2-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052640_939846_0E4DDFF7 
X-CRM114-Status: GOOD (  14.12  )
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

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  4 ++++
 kernel/kexec_file.c   | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..c45bfc727737 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -182,6 +183,9 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+#ifdef CONFIG_CRASH_DUMP
+	bool random;
+#endif
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3d64290d24c9..f7538d8f67e0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,9 @@
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#ifdef CONFIG_CRASH_DUMP
+#include <linux/prandom.h>
+#endif
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -437,6 +440,18 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	return ret;
 }
 
+#ifdef CONFIG_CRASH_DUMP
+static unsigned long kexec_random_start(unsigned long start, unsigned long end)
+{
+	unsigned long temp_start;
+	unsigned short i;
+
+	get_random_bytes(&i, sizeof(unsigned short));
+	temp_start = start + (end - start) / USHRT_MAX * i;
+	return temp_start;
+}
+#endif
+
 static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 				    struct kexec_buf *kbuf)
 {
@@ -445,6 +460,10 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+#ifdef CONFIG_CRASH_DUMP
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
+#endif
 
 	do {
 		/* align down start */
@@ -482,6 +501,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
