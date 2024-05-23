Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BB2C25B75
	for <kexec@archiver.kernel.org>; Thu, 23 May 2024 05:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rOFJW0LZoLlcXw3wTFYqMKG3Yr9acrHyHD9DiYgVaPY=; b=0THLF2NWb6ULon
	8jSt6r4fMenGrXN6PkqRUIZz3ApV7hbfGlQFzytDKVLYT6GnzJsxCkNgIjRvVjfcSFKB+ccIuhttF
	CgknVqpmo2kWDtv5kchTmVM9qQMNUC7bSw9JN4BoVxQtQkFy7qQrt0wv9LZjNaXzGiLRkl/cg+wFX
	LxPHlwDcgS3k8+3jwEN/BamziEaE9iS12cEV4Llgdrxh2rrdq/l5Yrm+spwbH35XUiRAl5G7j2kLj
	DlLZjo4gC31AcYv59rUPBD0t+2Py/TbMkXXlHwoiwTLgUIjNnSxJ1yaAOCoVCGCYyKEd4kvmlsue9
	IivB786xJazDXhHVdetQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0db-000000053mQ-32Ve;
	Thu, 23 May 2024 05:05:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dW-000000053jb-1xDQ
	for kexec@lists.infradead.org;
	Thu, 23 May 2024 05:05:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZynSKfZ+ldOQ3kMeJNfuvuSvRX+IwHDcGck7Xj2nRU=;
	b=I6k6Lrc5epPHX5JXxTrohWOO49xjY8cWX6YE3yCZfE7DQOPDb9D+96YQKsFeZWizfhISnE
	2detPojC+0gLcdeRqogUXhkrPhGuw/7iAPSlEzRNzM9QXP3s3j19JeuJ2FTiesIGjZS253
	8KjnW+/K5K8YWfXLMG4ClIZaV6WGFEI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-WwgkiLocMRajN8kEUOFJdw-1; Thu, 23 May 2024 01:05:01 -0400
X-MC-Unique: WwgkiLocMRajN8kEUOFJdw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ec48e36217so125144535ad.3
        for <kexec@lists.infradead.org>; Wed, 22 May 2024 22:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440699; x=1717045499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZynSKfZ+ldOQ3kMeJNfuvuSvRX+IwHDcGck7Xj2nRU=;
        b=AWhVcWYvugUQY2rCpvUXJe/5SQW1DISAErYD67Gz5jQYRaWY7JxaQTUfMN2yK+30gu
         R8K4ZjvG5OXuK6B+TlJ3JPzcf5M/FIR7xlxJzARphBLqkVIZH4bgcT3PXvc6Aygl3Upg
         HWN/HHVKwHJHrDJLNijra61BD2MitKhDqVBCFfk+Yt+tz/s3gZnG8scnVsyHqmxtLaKO
         wDtoJA95m8cTzDY4EOYsAJzYWc5vYeH1gMo9hVfCIRpOylQBMjIIWP8Oh82qXcrnqMnw
         p8B6VeKfB/qscpx/9cA1hLsfDSU10iAgubm63UZKvkbJ+Ervg5Ytd/ShFVX0IbvHgWIO
         z8lA==
X-Gm-Message-State: AOJu0YyqBKjRuh1Dyx3iKGK7cJ65zuWHVmuiO8mueLHrZCe/VVNAlH50
	HUdcpw86NkRP/XpxTV5zr79a/nmB7lvDtvDz96G+qQbWDZPmWmIhvdtIBHcZuFThz/0Imw4vqI0
	Rh1kKKFVlYOT/TVmjqf7x4/4D4uaQq8buqaYpb/gJJkm1NZ6BcR75jghhkFhE/2WFHz2e7t/gZK
	m8tmfnN3eHu/godotDn2w8k7Cibsp3smw3aS3KVrvyTA==
X-Received: by 2002:a17:902:cf04:b0:1f3:2fa7:6d7b with SMTP id d9443c01a7336-1f32fa76e61mr33104485ad.19.1716440699118;
        Wed, 22 May 2024 22:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw+CHnj/MZBKIkFFsXHEy8x5jL+NWT0WhFWjdQIsn/ck9Po7lLmmL2jkJ496RIELn9298gCA==
X-Received: by 2002:a17:902:cf04:b0:1f3:2fa7:6d7b with SMTP id d9443c01a7336-1f32fa76e61mr33104035ad.19.1716440698265;
        Wed, 22 May 2024 22:04:58 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f32d91cd9asm15943535ad.267.2024.05.22.22.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:04:57 -0700 (PDT)
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
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v4 1/7] kexec_file: allow to place kexec_buf randomly
Date: Thu, 23 May 2024 13:04:42 +0800
Message-ID: <20240523050451.788754-2-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_220507_188349_DF228134 
X-CRM114-Status: GOOD (  14.51  )
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
 include/linux/kexec.h |  2 ++
 kernel/kexec_file.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..cc81b8a903ab 100644
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
@@ -182,6 +183,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3d64290d24c9..06b77f9ac4cc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,7 @@
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/prandom.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -437,6 +438,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	return ret;
 }
 
+static unsigned long kexec_random_start(unsigned long start, unsigned long end)
+{
+	unsigned long temp_start;
+	unsigned short i;
+
+	get_random_bytes(&i, sizeof(unsigned short));
+	temp_start = start + (end - start) / USHRT_MAX * i;
+	return temp_start;
+}
+
 static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 				    struct kexec_buf *kbuf)
 {
@@ -445,6 +456,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -482,6 +495,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.45.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
