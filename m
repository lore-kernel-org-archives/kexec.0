Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70826C3DA6E
	for <kexec@archiver.kernel.org>; Wed, 10 Jan 2024 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=19SQIKyflprLSNg1HfZO/FdJb4Qwv28b4gZyrqqT0BQ=; b=efrcwVRJPsrUBw
	IEehQLLTlUH65CajLUn8P9w4QR76MuQVaTVeAKuliZvIdDuFjxpyYc3KYv0ieJ5/Di5FCWwI3UgCW
	/LMosWloX3p3jsxcdgwDmx3+a9XOLyXu1J4OdowlbQmtYkqIVEilMbpv0+6EijJCZFrexLmZ+W9+M
	OxwjJjdsznTJ55QWR3qmv9QYTDF2GOJ85G5XbdLiI4cU0Q6h2vDN3daWCZPrMZzJAQoXJ/BXWF+OO
	3E22UxKpe5ecmaHMAWM2zU95bK8DgHK/bSdl7c/JtveSjRktK+YUp+QRqfZyoHKfsUiRkLQeXftS+
	Nc9CeUoMLQBM8Krp4ECQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSr3-00AaZ7-2T;
	Wed, 10 Jan 2024 07:18:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSr0-00AaYA-2m
	for kexec@lists.infradead.org;
	Wed, 10 Jan 2024 07:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704871101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pq0F4aFw6g681LkvfPcovxOw7gCCC2AmnjI1JKPUo/g=;
	b=XtmQMznKy86RpqLjBkq+IboO1eQqkyB4NEX9VHzLi1HwKKJgTwoOmdGLIXTDT7EeBuaG+e
	YXgvS4VH7oa8zpSdVxc2k2reJILW0hOh0HZxFS/kHNqyArkW6AE0yTGxlwN/KWe2n6CYDM
	UlT7gHWbPpXa9XAcFfjqDEPMxfZ5Hp4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-PrGNJPibO9i_OSB4SRHHqg-1; Wed, 10 Jan 2024 02:15:31 -0500
X-MC-Unique: PrGNJPibO9i_OSB4SRHHqg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bd3bdcd87fso2336756b6e.3
        for <kexec@lists.infradead.org>; Tue, 09 Jan 2024 23:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870929; x=1705475729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq0F4aFw6g681LkvfPcovxOw7gCCC2AmnjI1JKPUo/g=;
        b=KOg4ZyJT7gUCBFmwz5wCsBJeXk8yH7+gcYQO+U4vAXUJ3PWzaKk5iDeQee9HbQzjKI
         1NVuXYvBwhQO7NjWdjBACjnF02me2fbSH0UPisGr1bC66nUr+HXvZdr7RlQ6NAz+VmJG
         ixdgeVXtUXPiy/xs9IdTKZ33EvsHXw9l8la0MDra3T4pbNPM3c8BZa+adtuq9kde+cA9
         tpzsZHWbrB2UVGoKubIpiWhegdztTonRA0c0c6ecbONnIjeMNWsLg0cajd4eT5dYOUAX
         fHnPhErBfjwYrUjD5H1VsZbmEWPNdghtpVbdS47RObUbSYxzYZqd6JSp7E3bh257oCwC
         R4kg==
X-Gm-Message-State: AOJu0YxDHelUu1e4/bz9I63uf0EQZ/b1K0Gpsr26zrkVDc66IvaDl6mJ
	PAEEQV/L0unGCmwHcQd2WzMnMU0qQExL9SagTDG6554n2jH3Foi6O17AoeSIzpOFUN41ZGV/T5u
	6L6Po74xWkkeEA27pz6Qug+ddry/fKa81Iiovrh4TE84WC9+efPXAO41XIKVuCpsBj7WLvDG5Nb
	xXta1IDtfWJFm1yGE=
X-Received: by 2002:a05:6808:1827:b0:3bc:4f4b:2876 with SMTP id bh39-20020a056808182700b003bc4f4b2876mr836102oib.85.1704870929508;
        Tue, 09 Jan 2024 23:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAh30PQjEcO5UsWPrWFGKjGa/q7fyVdh5HckMBNYLKlvjstQEK5unXc4t5sinSV02Bz4i0yQ==
X-Received: by 2002:a05:6808:1827:b0:3bc:4f4b:2876 with SMTP id bh39-20020a056808182700b003bc4f4b2876mr836080oib.85.1704870929172;
        Tue, 09 Jan 2024 23:15:29 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 5-20020a631245000000b005b92e60cf57sm2628739pgs.56.2024.01.09.23.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:28 -0800 (PST)
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
Subject: [PATCH v2 1/5] kexec_file: allow to place kexec_buf randomly
Date: Wed, 10 Jan 2024 15:15:16 +0800
Message-ID: <20240110071522.1308935-2-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_231822_972739_C763EE7C 
X-CRM114-Status: GOOD (  15.33  )
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
index 8227455192b7..6f4626490ebf 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -169,6 +169,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -180,6 +181,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..7abcfc3c8491 100644
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
@@ -419,6 +420,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
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
@@ -427,6 +438,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -464,6 +477,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
