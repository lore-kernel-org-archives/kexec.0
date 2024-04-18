Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5995C4345F
	for <kexec@archiver.kernel.org>; Thu, 18 Apr 2024 03:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1ZRs93/yMvfL/Zw6+FYVAAkIyfYYkhnvEfIf50CfZac=; b=WCo4o4srGT/gKn
	8G3mad5mXzPizRYFguDR998KRi3NQyG8MJrwIqq+NiHqP061KwNT2jr7b84bH9Sq5SEch9LbGVI0j
	EBqmfpQIjBnL3rY69ZBBbdoA9pJC8u4l0De+6Q7hXXJmHkicEsjuCyCKJhdSokaOOozIEaQAO+WfS
	Yn/gwdcGGlZLxwYUwVmxCNCWZMX4oScfr1ox9xJo1+OpkelTlTqPeqqNzW67n+qiL66maOuxrKylT
	4HwS/Ru5VCn6I42cO203KfEluBnJkrIXHrEJYyyRCIVO6y8H1YNSKefdiRalAXKpJPxwLicia8kse
	Q36XdQpSGaZ5qyfWf9ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxIvR-00000000qTB-3Hoa;
	Thu, 18 Apr 2024 03:59:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxIvN-00000000qSD-1dII
	for kexec@lists.infradead.org;
	Thu, 18 Apr 2024 03:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713412737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JS1SGcTse6pjiN2+J6B7+rqjRw6qi/Yc8vDjSdBa9+w=;
	b=cPaT2ncHvtuZVAVt4hRzAhiVbFP59y1FqM3T9Jep4NBhzhBxTnDTxcMgfIXKwxpPbYbhkW
	a15XYZNr/CVJmPnZhlFHI5tfUQkViTbHgaLy0OKn1UKMgMeplK9ITwFNRPzZpuN9qXfyFl
	HvKclsytCFJpZd+h/FSGijQ+EPPU7rI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-h6GhyD8hNFmltpO6lMHytw-1; Wed,
 17 Apr 2024 23:58:53 -0400
X-MC-Unique: h6GhyD8hNFmltpO6lMHytw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 859BD3C0FC90;
	Thu, 18 Apr 2024 03:58:53 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 532EC35430;
	Thu, 18 Apr 2024 03:58:47 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: akpm@linux-foundation.org,
	dyoung@redhat.com,
	jirislaby@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] crash: add prefix for crash dumping messages
Date: Thu, 18 Apr 2024 11:58:43 +0800
Message-ID: <20240418035843.1562887-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_205901_528371_F1693B7F 
X-CRM114-Status: GOOD (  10.57  )
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

Add pr_fmt() to kernel/crash_core.c to add the module name to debugging
message printed as prefix.

And also add prefix 'crashkernel:' to two lines of message printing code
in kernel/crash_reserve.c. In kernel/crash_reserve.c, almost all
debugging messages have 'crashkernel:' prefix or there's keyword
crashkernel at the beginning or in the middle, adding pr_fmt() makes it
redundant.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c    | 2 ++
 kernel/crash_reserve.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 78b5dc7cee3a..1e7ac977f7c0 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/buildid.h>
 #include <linux/init.h>
 #include <linux/utsname.h>
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 066668799f75..5b2722a93a48 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -109,7 +109,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
 
 		size = memparse(cur, &tmp);
 		if (cur == tmp) {
-			pr_warn("Memory value expected\n");
+			pr_warn("crashkernel: Memory value expected\n");
 			return -EINVAL;
 		}
 		cur = tmp;
@@ -132,7 +132,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			cur++;
 			*crash_base = memparse(cur, &tmp);
 			if (cur == tmp) {
-				pr_warn("Memory value expected after '@'\n");
+				pr_warn("crahskernel: Memory value expected after '@'\n");
 				return -EINVAL;
 			}
 		}
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
