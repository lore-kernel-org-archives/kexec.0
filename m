Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5510AC61D97
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FLtKDfSw18UALrtTWfHDvSUeuw1XByOj8EFgnqcJQ10=; b=dcm4KylZEVAeBs
	N61HjS/LYUYBxEl/ekCA7gdz4/mAJ3v6EMhGbnnhbK869oETukvbBn76puU+GzKcYlGpuyI70LgXs
	O9Y8EAHth28ozwTXgcYDhr+GkCw278OxhU1NZZoPo8XUkywMTtSpLi52Mlvi53pzgVjCp16egWh04
	prCTzCRfVHTE+ufBqJMh3ViNk8xoKw9U3EbP2mA5jXlL65/b6jUZc/ON0Eo69Cuw+H+cu7D/R0dfe
	OylGQXjxmaf3R4KvIJLndTb8doA+WUAENJ5wpGGaVJyMdr0zqh8RWr6B3ORKqNKZ4QDn5bWBAyn1G
	qY8hPDdHkpmkp89MqxZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r64H4-0043Qc-03;
	Thu, 23 Nov 2023 07:37:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Gw-0043ME-0o
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 07:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700725028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXRKoO9zAkgm8b+Bxr4SCC+gEy3bcdHacUdRqCwlROA=;
	b=iyBUz+wgbIRz2j/EePnivMNVRO+sKHsCwPQWMbzAINqG83QPsGOyDnFT5ERJJWQPCWvjp2
	67yN4bBvtu3BkxOjrJm/wtnhmbrf1CtqFVwu18CeF1079QpG0uk35S1vPt+KunGSm7zc23
	T+dcZrQSCUMrrhdEvJnwXaeSj0uPVuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-25x3cXZyO_GiQ874kgA9UQ-1; Thu, 23 Nov 2023 02:37:03 -0500
X-MC-Unique: 25x3cXZyO_GiQ874kgA9UQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A890F82DFE8;
	Thu, 23 Nov 2023 07:37:02 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 893CA492BFA;
	Thu, 23 Nov 2023 07:36:59 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	akpm@linux-foundation.org,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/3] kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
Date: Thu, 23 Nov 2023 15:36:50 +0800
Message-ID: <20231123073652.507034-2-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-1-bhe@redhat.com>
References: <20231123073652.507034-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_233714_360316_0A8EA950 
X-CRM114-Status: GOOD (  10.85  )
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

Ignat Korchagin complained that a potential config regression was
introduced by commit 89cde455915f ("kexec: consolidate kexec and
crash options into kernel/Kconfig.kexec"). Before the commit,
CONFIG_CRASH_DUMP has no dependency on CONFIG_KEXEC. After the commit,
CRASH_DUMP selects KEXEC. That enforces system to have CONFIG_KEXEC=y
as long as CONFIG_CRASH_DUMP=Y which people may not want.

In Ignat's case, he sets CONFIG_CRASH_DUMP=y, CONFIG_KEXEC_FILE=y and
CONFIG_KEXEC=n because kexec_load interface could have security issue if
kernel/initrd has no chance to be signed and verified.

CRASH_DUMP has select of KEXEC because Eric, author of above commit,
met a LKP report of build failure when posting patch of earlier version.
Please see below link to get detail of the LKP report:

    https://lore.kernel.org/all/3e8eecd1-a277-2cfb-690e-5de2eb7b988e@oracle.com/T/#u

In fact, that LKP report is triggered because arm's <asm/kexec.h> is
wrapped in CONFIG_KEXEC ifdeffery scope. That is wrong. CONFIG_KEXEC
controls the enabling/disabling of kexec_load interface, but not kexec
feature. Removing the wrongly added CONFIG_KEXEC ifdeffery scope in
<asm/kexec.h> of arm allows us to drop the select KEXEC for CRASH_DUMP.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/include/asm/kexec.h | 4 ----
 kernel/Kconfig.kexec         | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index e62832dcba76..a8287e7ab9d4 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -2,8 +2,6 @@
 #ifndef _ARM_KEXEC_H
 #define _ARM_KEXEC_H
 
-#ifdef CONFIG_KEXEC
-
 /* Maximum physical address we can use pages from */
 #define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
 /* Maximum address we can reach in physical address mode */
@@ -82,6 +80,4 @@ static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* CONFIG_KEXEC */
-
 #endif /* _ARM_KEXEC_H */
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 7aff28ded2f4..1cc3b1c595d7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -97,7 +97,6 @@ config CRASH_DUMP
 	depends on ARCH_SUPPORTS_KEXEC
 	select CRASH_CORE
 	select KEXEC_CORE
-	select KEXEC
 	help
 	  Generate crash dump after being started by kexec.
 	  This should be normally only set in special crash dump kernels
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
