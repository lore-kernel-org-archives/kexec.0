Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276CEFED9E4
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEUQCJqT1ZWbvxn49UTxpKl45Cm6yPdEfigJuT9xQdc=; b=sSMzx2VqFKyQfbZVa7Lp8UvSEe
	n2bP9PtpjoKZdHwKsBidDCa+8IgxY1HMWJOJYTXDDcUQ5dcfP2tU4kl90LK8lBKQx9d4laUHqDtoh
	YM51klJE1feheSe7ifejyzdkIIdW2QEexkbDePCLK3R+BFDwOXXn8Y0wiG7iF9A8fXV9c2fJvoAVA
	XzZ+X9L6QjyPpsyZzonqf4etgNv82CwVrHGfsB7M8RQPhlUmMpqkvQRcXnwKDV/s3j8JqXOp4xOQZ
	xyz01GeCfH6gFn9TCJPNAfvqyV/JwXDIZtK06PLG+/nwtFY/8Kj3fFpIBojPyLVtrBcIxR2wCbit1
	mIHV+Vyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2Z-00000006gsF-0hRT;
	Tue, 17 Mar 2026 15:09:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2W-00000006gqo-1GBT
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEUQCJqT1ZWbvxn49UTxpKl45Cm6yPdEfigJuT9xQdc=;
	b=YN9HlhpcT5OrF+ZJIfuBBrhEIk+wF1U5ddWjCzXeqT7EiFAxxROgsCAIWc8uVujVoRjcXz
	HVtxAklLofg3H49On/NAIfYPnu1owDXghhHqb1UjM8k6bqxyZJwGb9zppPbdqrNjqTNLuU
	Vy4Et9Z7GpOOB7ZE9MaCl9+SCxbgm6s=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-uShUD_dkN2uuLDsgUydjnQ-1; Tue, 17 Mar 2026 11:08:57 -0400
X-MC-Unique: uShUD_dkN2uuLDsgUydjnQ-1
X-Mimecast-MFC-AGG-ID: uShUD_dkN2uuLDsgUydjnQ_1773760137
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7414179cceso367835a12.0
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760137; x=1774364937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEUQCJqT1ZWbvxn49UTxpKl45Cm6yPdEfigJuT9xQdc=;
        b=Ejb/QYdejDXtbqEefdHgqXrNhjnAQVu+ZqSwDEI65zG5/se2GpzexqmfxwLciwyO14
         MUlLoOg6tQysUsZmRy1KvQnuwvGuWl+oom+I6Ht7nmN6950012JLjkPgNX1EZgNUOYIG
         i0vr5aZsp6GJYga942JJwDqU2DXSCbjbJEvqQO1rVMrAR2zTAumilTHs/FZfykUp3gJ7
         jsZ9aiHKhmgASzhlVnPj324b0z7h74yQe+k81/1kX9ZKjoZps3PpTBM4rM1JIbp366TA
         g7ONlmm75LqORjML9w7YgCMLVqtDgf8AuRZVd/jQk/H0n5FkidDJfgjcI4Ix/1mtHBEB
         kM6w==
X-Forwarded-Encrypted: i=1; AJvYcCUKTsQOxgeXjyWtAXgTfjaMB3C3pieZTF+9ZHXkWbLUjjimO6TeNJGdFrZeH0jW6MTrFJ7ErA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzazcjBXsP9UG/BfYmAltzIp90FFimVJNjGPzd/35qSdcV7hn4e
	tsFBvoxT6h3UvvwJbexdzlJ6H4Ivk7FsDTPWoOxXNd5qU0kszWbg2da0f5jwZd1NYefHrOOlfMv
	o8C9a3m9+ML08p2RUKazzBuD7eiOaKbPaW4Z9RD9wtofcYjxym8/EVuEfk9CcCw==
X-Gm-Gg: ATEYQzxLDHd8x74B2cgaVHtwRmGdG/bhTJdtbkZCjHHNGcCZhRyxPeFnhZwiKocnsp7
	IkoyeA2tvFD6+K8dXna8CIGyVpngyC9Z8i1xQCQdyKh83M4eGqwLAaMmwx6BtDRPvs1UChw9v+/
	PgZ5nIJC1S57/tiBcCoAyoqXu50ldTMls8NfLYGPxEkhOl5UrTNJH8ZSf8E84f3fYjzdULEHVDk
	04ZW/tKzCXNWHzMyfkDtRTKZ19qJBKpWwr3UY+BrbU3BMFqlTfgOc1t08622mAT0CzTGktzso0E
	3jmliMGxrUld5+nsUS2Qe/rq7DRIGMvvSagH2SkeB1zJwu/bhmDeenUlLqIR6Ejq/wlsp6JuxhB
	NGCO0NusxRXSrnubUDJKdScKIrEyj2SGJYQ==
X-Received: by 2002:a05:6a00:4197:b0:829:8aa3:2ec6 with SMTP id d2e1a72fcca58-82a196b55c5mr15250306b3a.10.1773760136588;
        Tue, 17 Mar 2026 08:08:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:4197:b0:829:8aa3:2ec6 with SMTP id d2e1a72fcca58-82a196b55c5mr15250283b3a.10.1773760136182;
        Tue, 17 Mar 2026 08:08:56 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm16993404b3a.39.2026.03.17.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:08:55 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v4][makedumpfile 1/7] Reserve sections for makedumpfile and extenions
Date: Wed, 18 Mar 2026 04:07:37 +1300
Message-ID: <20260317150743.69590-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260317150743.69590-1-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1ja4TZBd1uw7I78S2Jnl9u1UsnAV6LoMoyARYM2_LxM_1773760137
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_080900_408134_2D4DAC24 
X-CRM114-Status: GOOD (  13.10  )
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

This patch makes preparation for btf/kallsyms support of
makedumpfile and extensions. Any needed kernel symbols/types
will be reserved within a special section, .init_ksyms for
kallsyms symbols and .init_ktypes for kernel types. During
makedumpfile kallsyms/btf initialization, those missing info
will be resolved. A makedumpfile.ld script is introduced for the
purpose.

Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile        |  2 +-
 makedumpfile.ld | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 makedumpfile.ld

diff --git a/Makefile b/Makefile
index 05ab5f2..15a4ba0 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
 	$(CC) $(CFLAGS_ARCH) -c -o ./$@ $(VPATH)$(@:.o=.c)
 
 makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
-	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -Wl,-T,makedumpfile.ld -o $@ $< $(LIBS)
 	@sed -e "s/@DATE@/$(DATE)/" \
 	     -e "s/@VERSION@/$(VERSION)/" \
 	     $(VPATH)makedumpfile.8.in > $(VPATH)makedumpfile.8
diff --git a/makedumpfile.ld b/makedumpfile.ld
new file mode 100644
index 0000000..231a162
--- /dev/null
+++ b/makedumpfile.ld
@@ -0,0 +1,15 @@
+SECTIONS
+{
+	.init_ksyms ALIGN(8) : {
+		__start_init_ksyms = .;
+		KEEP(*(.init_ksyms*))
+		__stop_init_ksyms = .;
+	}
+
+	.init_ktypes ALIGN(8) : {
+		__start_init_ktypes = .;
+		KEEP(*(.init_ktypes*))
+		__stop_init_ktypes = .;
+	}
+}
+INSERT AFTER .data;
\ No newline at end of file
-- 
2.47.0


