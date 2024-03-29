Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85366C6FD1F
	for <kexec@archiver.kernel.org>; Fri, 29 Mar 2024 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7qO+/OFH7NhvlG06IAU87nqPQ/5N4NQha2fl6fMMSjg=; b=Ig9lmVu/lzOdSB
	S8ijnoVqtQUczBeol39A98ilRZ/lL7xR8F/2BQ87c+XN1ym+++Np6REe5oR1NvtbSjOe/qteBMvXV
	deQ2SJc31GwFObi5YCIPXuLnx39pdtj4Md+1YkTkEF70AwmumRDYFZv9aSWegOt4iaJtC9sQHyEvr
	wSpTVe9Ckum/QElu7Ar0g/5/jAXIZixflR5WTOycH3MtNn0wo6pdhR+TFcPI9FZ2d4radtDdCLJjW
	1gG1V3jIgkjtzg/7wgTF/BxV90ndMfhp79uRMPmmdpprijtxYC94+IQZ99aFNKJqUjcTL8j52EeFF
	4Y/3zo4sGUVwjmyHvSTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqCHx-00000000exg-0AR2;
	Fri, 29 Mar 2024 13:28:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqCHu-00000000ewZ-20VC
	for kexec@lists.infradead.org;
	Fri, 29 Mar 2024 13:28:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711718933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOucn97knmz5KeV+tnCRyRHFYI4yUR4aztmQradjENc=;
	b=bmnu0kZ9jyB97/ErEeaXDCFtynK6c8UH7bFY+c1BXpIqvD2BsDgLg49qHltx57yxVHWgUs
	JHYF9vhE6fswP4x7pBtFH4n07qj67S6GMMmH0eqZAt3IzLXYWnBc2Vssh8okAT59RLHk0M
	LPSKOFFbDXyKf7oXzOLxfO3hGfLVJCM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-rntMc4ipOtGlwuHZwLZGbg-1; Fri,
 29 Mar 2024 09:28:49 -0400
X-MC-Unique: rntMc4ipOtGlwuHZwLZGbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E34C22802E30;
	Fri, 29 Mar 2024 13:28:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE561C06543;
	Fri, 29 Mar 2024 13:28:34 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: akpm@linux-foundation.org,
	geert@linux-m68k.org,
	chenhuacai@kernel.org,
	Baoquan He <bhe@redhat.com>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: [PATCH 1/2] arch/loongarch: clean up the left code and Kconfig item related to CRASH_CORE
Date: Fri, 29 Mar 2024 21:28:24 +0800
Message-ID: <20240329132825.1102459-2-bhe@redhat.com>
In-Reply-To: <20240329132825.1102459-1-bhe@redhat.com>
References: <20240329132825.1102459-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_062854_632688_2F770F50 
X-CRM114-Status: UNSURE (   8.34  )
X-CRM114-Notice: Please train this message.
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

In commit 85fcde402db1 ("kexec: split crashkernel reservation code
out from crash_core.c"), crashkernel reservation code is split out from
crash_core.c, and add CRASH_RESERVE to control it. And also rename each
ARCH's <asm/crash_core.h> to <asm/crash_reserve.h> accordingly.

But the relevant part in loongarch is missed. Do it now.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/Kconfig                                       | 2 +-
 arch/loongarch/include/asm/{crash_core.h => crash_reserve.h} | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/loongarch/include/asm/{crash_core.h => crash_reserve.h} (75%)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a5f300ec6f28..54ad04dacdee 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -595,7 +595,7 @@ config ARCH_SELECTS_CRASH_DUMP
 	select RELOCATABLE
 
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-	def_bool CRASH_CORE
+	def_bool CRASH_RESERVE
 
 config RELOCATABLE
 	bool "Relocatable kernel"
diff --git a/arch/loongarch/include/asm/crash_core.h b/arch/loongarch/include/asm/crash_reserve.h
similarity index 75%
rename from arch/loongarch/include/asm/crash_core.h
rename to arch/loongarch/include/asm/crash_reserve.h
index 218bdbfa527b..a1d9b84b1c7d 100644
--- a/arch/loongarch/include/asm/crash_core.h
+++ b/arch/loongarch/include/asm/crash_reserve.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _LOONGARCH_CRASH_CORE_H
-#define _LOONGARCH_CRASH_CORE_H
+#ifndef _LOONGARCH_CRASH_RESERVE_H
+#define _LOONGARCH_CRASH_RESERVE_H
 
 #define CRASH_ALIGN			SZ_2M
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
