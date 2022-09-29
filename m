Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0924CC6FA83
	for <kexec@archiver.kernel.org>; Thu, 29 Sep 2022 04:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gCzYHDzy87fOEdpztqZRSEow8xwqqGUt2glm7pku/Fw=; b=bI6/IJsN54Idku
	FYrvTogAasm0EwL+Twl5xf/cwDEcXAdlegseh709tQgoH179+cjW0E4BkCQHZqTBafupoEtHTlS3A
	sd7MjZwh3vsT8DVlZmnoVmJJZwiUpBq4fIyKjRlFOQsmutn51evuILXryiZie9y1H9CVpxsQOGpiX
	rAWzglwLvp7hidYb8fcqxWQDun4oe5Zw0y+ybjnDv/ZW2c9dfdDTY2+M3BCZghjX+S9yEa+nAvDb+
	jTfLCqa+RE2AS2MhByCbUPf9TJoqetVtglpuXWHYuI/Io253zEDH4yqqya+eVgfWQBtLl9AWlSYo6
	t6aHp+OaI6BnrVTHz7Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBL-0019v7-Qb; Thu, 29 Sep 2022 04:29:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBJ-0019uF-7q
	for kexec@lists.infradead.org; Thu, 29 Sep 2022 04:29:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664425792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ6eVGHIuPCxsfzLZ7r6f4XtIMBx2hQBbA300A4TTy0=;
	b=g0UqEmbRi9RUgg02zyZxJdSYmd0FEGEdIJFFY9kPSrWgBBIJ/97RZHiEF+sc6RY7D1zcSn
	Lis4kxNrh+1BsSePo3GgcxQu1EWmd9l9TlbJz+OWxe+HrHQkm3U5500qlzoHV+XD92mL1r
	qQxaswg0mpET9wnQrY3wCzILsqIUzsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-x6xpR9HsPlutFSmX5-z1XQ-1; Thu, 29 Sep 2022 00:29:48 -0400
X-MC-Unique: x6xpR9HsPlutFSmX5-z1XQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3071981172A;
	Thu, 29 Sep 2022 04:29:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-179.pek2.redhat.com [10.72.13.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 206E87AE5;
	Thu, 29 Sep 2022 04:29:44 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	ebiederm@xmission.com,
	Jianglei Nie <niejianglei2021@163.com>,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 1/4] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Thu, 29 Sep 2022 12:29:33 +0800
Message-Id: <20220929042936.22012-2-bhe@redhat.com>
In-Reply-To: <20220929042936.22012-1-bhe@redhat.com>
References: <20220929042936.22012-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_212953_365515_6D7203D1 
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

From: Jianglei Nie <niejianglei2021@163.com>

elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
predefined value. If parse_crash_elf_headers() gets some error and
returns a negetive value, the elfcorehdr_addr should be released with
elfcorehdr_free().

Fix it by calling elfcorehdr_free() when parse_crash_elf_headers() fails.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 fs/proc/vmcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f2aa86c421f2..74747571d58e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1567,6 +1567,7 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
+		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
 		return rc;
 	}
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
