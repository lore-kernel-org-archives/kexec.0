Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE352C4345F
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cVXDRf12SuDOnABW5+XzMwA5d/xZgBq9nni1M71uiA0=; b=hi4C1dH446Wuzc
	MFAGJvtHJV8x0eho/c80dqBkIqD+FbvOdfdf0mFjX3IfXCrh+b0wQdinGEnw2e4L+MRqhx1exnBK7
	RADqw+1yjnnTTAcJu+bbPbD/eFUE6Fl6qDZc3G6/zEsvBLFiXh41wCfppKxEzDZ/Hpk7N0GhMKRrZ
	9VszAy6KSiU325Sj54AQKgkWUYCl04/f0jwkyHXjIeWrM/CRKk31WnClgOiGKD7fWa9Xgj4LMt4Yu
	iolvsUrX/9dGI5EadzmQEQDbrIP0aUXadOF0uXFZGLP73bM8fqyKRspmn6WRSWXINRT/Dn4wPkkJb
	FkOy4pCmkD6HVgp9XXDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyD-00000007kaT-2JAF;
	Thu, 25 Apr 2024 10:04:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyA-00000007kZ2-3Cey
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 10:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7YJePHmU0xnd5mm75PGlWk6ufheCOsZkTtpzDbbBcI=;
	b=EbyuyiN32W4xSg9jL3HJT1jyqfOG9EPkHBAw0hTAsdqyzLuXEQrwURvqS6G3vFDBXeIm6o
	6MgAnghVYXVADRhbLjuLgr5ya2zSDRi4OAA8G0W6GYVnmX9/iEIulpBa4IezGlSuSdAmhw
	jXEopX8v9gcr4M58GtYHhV7M7WYdCjY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-ognI57fdMwmBPFgPnmgweA-1; Thu, 25 Apr 2024 06:04:43 -0400
X-MC-Unique: ognI57fdMwmBPFgPnmgweA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e2c1ce5d14so10401215ad.3
        for <kexec@lists.infradead.org>; Thu, 25 Apr 2024 03:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039482; x=1714644282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7YJePHmU0xnd5mm75PGlWk6ufheCOsZkTtpzDbbBcI=;
        b=ed7wpJC6ydue3eIedjjAKLj2n6EeBqLvcmGuXtezWMHoqqC2tr5EJf+5E9kxUaUkYL
         5PveSiMjxVsjNI22yMVopceT+ldpaPMYxP0z/x81rFUqZEEaRKJqiwBfX7e1HPMzjJnV
         OnR3NgytXqa2o6odpCpUJBOdycCxrMlOKw0sRs6/I35pXovxtwJorCEm0m7BoDqL62Ho
         Qi435ywpvXZfrRP7Li7nWy3RhsoTqxXJLJ23zeyP1yz0xNQ95ULp2nPRntWSKHy3aMjx
         Se0yXjhsiPnNrfJwK39yIVnD/GuLzRQRilAPnDL7XS4k4FBTK816em8z+7HBMLecpSfS
         +x0Q==
X-Gm-Message-State: AOJu0YyG2TpEMyFqWmm4YFjgH7HdMfAVc3vqxbsK4ki1AN5GXJ6e9kf0
	8/aGzCwdVP24vTzg0AS595K+YS87rKZZ7vtrYK4Qx0RD7U2CFPNwqgsNjdlaBa/besr3q21lWyN
	h+c9LF5k2MHBo438op2AdnxO2p5I6g6jX86pj5vvBw3BgoxmvxB8R1D85sQ3RfPaDzZWnKzkWsu
	AufuMLeQNbiMiatum4GtH3WDm3Q3pfOD7uBHxbZKyvbQ==
X-Received: by 2002:a17:902:ce8b:b0:1ea:d979:d778 with SMTP id f11-20020a170902ce8b00b001ead979d778mr224453plg.5.1714039481325;
        Thu, 25 Apr 2024 03:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN0TZp8wDqekae9LssrRvMGxaiGtqZMmDqIbLmVRxKgwD9CaWsKIbQrIIuSnXcFnS4B8UqqA==
X-Received: by 2002:a17:902:ce8b:b0:1ea:d979:d778 with SMTP id f11-20020a170902ce8b00b001ead979d778mr224381plg.5.1714039480577;
        Thu, 25 Apr 2024 03:04:40 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ab38d00b0029c49ed3974sm12575962pjr.37.2024.04.25.03.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:40 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Date: Thu, 25 Apr 2024 18:04:25 +0800
Message-ID: <20240425100434.198925-2-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_030446_902314_3B70D2DD 
X-CRM114-Status: GOOD (  14.55  )
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
index 060835bb82d5..fc1e20d565d5 100644
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
index 2d1db05fbf04..e0630fe30d43 100644
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
@@ -432,6 +433,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
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
@@ -440,6 +451,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -477,6 +490,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
