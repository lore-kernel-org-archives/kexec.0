Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F31C83F15
	for <kexec@archiver.kernel.org>; Sun, 27 Aug 2023 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AxZHK4Mxa9/1ci4N5w2bhDd26Li9TvakPkTjEm1iFqs=; b=gOE20o+QqbGToh
	rFNJqZI778nGPR6zMYCEZWouhrNH4sJ6dCrYdmcRZKt47XHnu83WmlhgFFlHuOBerlTPnP2qERqWx
	P5PzYVxzCG6V8KCPTLI40nBrXNhjvu6BuXe/VYEmhgSLIEN9bXy/U2e9mzQBG2oz+Eb+y1RugSt+F
	nktr4gQjEI5cLNoWadR/4oakdiF6cm1WxEm2IudZdpiDawDPjlBx4cPoObtJZJuRSDDfUvF8e0CFY
	tQb1Rw2ZxV562umbGk0zpHVRcSm/4p9Xl35Ye9qCkfdU3Ter6faEWbYjw5rIHhjw4Nhrn4WIaXexh
	T+8vGuPz4yxPZxX65mKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaCkg-007oog-1n;
	Sun, 27 Aug 2023 10:12:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaCkN-007oUQ-0D
	for kexec@lists.infradead.org;
	Sun, 27 Aug 2023 10:11:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693131114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV2wLAfcAl+D7MYwEotIMI/hG+PsohPBamGW1ll7QSU=;
	b=N3FtUGM2rPddRz1lFpCZuAHTeM6Wd6pdyLsA4DeIM70B3Fed6/foTkmRTAHbOjFaS/eiEr
	JwU/ZFxOde/ql+FXE4eKeaLeezmZhljT7iPbbM2x+3KUz+yVkGoo6+MMweu5Cr/ugZ+rwF
	euVaiE/iJ9DaK65aYwsJu+luLFV5xdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-dcQi-t8wMe-jYcKP77Qj1Q-1; Sun, 27 Aug 2023 06:11:50 -0400
X-MC-Unique: dcQi-t8wMe-jYcKP77Qj1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E1C185CBE0;
	Sun, 27 Aug 2023 10:11:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2624C2166B25;
	Sun, 27 Aug 2023 10:11:45 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	thunder.leizhen@huawei.com,
	dyoung@redhat.com,
	prudo@redhat.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/8] include/linux/kexec.h: move down crash_core.h including
Date: Sun, 27 Aug 2023 18:11:22 +0800
Message-ID: <20230827101128.70931-4-bhe@redhat.com>
In-Reply-To: <20230827101128.70931-1-bhe@redhat.com>
References: <20230827101128.70931-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230827_031155_211355_A9FC8ABB 
X-CRM114-Status: UNSURE (   9.98  )
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

Later generic macros related to crash_core will be added into
<linux/crash_core.h>, and the corresponding arch specific macros will be
added to override them if needed. And Kconfig option KEXEC_CORE selects
CRASH_CORE. So move <linux/crash_core.h> including after <asm/kexec.h>.

And also move the crash_res|low_res and crash_notes delcarations after
<linux/crash_core.h> including because they are all defined in
kernel/kexec_core.c, and note_buf_t is definied in crash_core.h.

This is a preparation patch.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..8768fd9e2a66 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -15,25 +15,25 @@
 
 #if !defined(__ASSEMBLY__)
 
-#include <linux/crash_core.h>
 #include <asm/io.h>
 #include <linux/range.h>
 
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
 
-/* Location of a reserved region to hold the crash kernel.
- */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
-extern note_buf_t __percpu *crash_notes;
-
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <asm/kexec.h>
+#include <linux/crash_core.h>
+
+/* Location of a reserved region to hold the crash kernel.
+ */
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
+extern note_buf_t __percpu *crash_notes;
 
 /* Verify architecture specific macros are defined */
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
