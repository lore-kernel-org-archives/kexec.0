Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFBEC83F12
	for <kexec@archiver.kernel.org>; Tue, 29 Aug 2023 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vUQAauNjkyS3CuufQ6eq2nXrnQ8wraWwrquSgcbs6QE=; b=Gw7cIqbRT2PR12
	EkdhVj+c4SuNuRAVFAwE3KVBdU6mobUSK5q3NlqCBnzTw4ksP06Ztk4D5duBBBxMzmMBxXprurxqm
	vrXKwBfFbFGAlnh035oI+QAl4ES2jIsnTMqMtxn3V3Y8PFd8ewe8U5uRQjIKuktEnQs5aQ097QqBe
	rDCd49Cb1TltJp6SYBMD2zPL2i+xThfOeyvbagmTuyBJooBa2zqxtoVgG2gk62m3mcau63qpesuEV
	Ny9n8pMcwDFYS7UQcDoLaCz4n+QB4N0kLFPRrXnlLFto8yPTqiS0ewvK8n+4ZAxURKblJnDBioMeS
	JO+lDqvxWAQHGKaSlu7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxed-00BTp2-0Z;
	Tue, 29 Aug 2023 12:17:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaxeK-00BTed-21
	for kexec@lists.infradead.org;
	Tue, 29 Aug 2023 12:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693311407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qjf2vgpZvAbuO/fyNcy9/C3Rx0kevn2I1wz9DuGab2c=;
	b=bzsJ9lQesBefbfLRn7sPuU9vVoJUq/2h6xfOjEO29mZQmRfjVJf2qGMSrMkC30GD0EoTaD
	dNUGO2peI1zdRn+qHB9tX9qvuSg4o+nuzdJLDjrHNlRu1y+vyfUIX7zOF8kyyDYAo+CMIj
	jGQqAv6P14tvGTkoM5KSjPpewlC8TiM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-wvbW7TOFNgO-DwvFv2n-kQ-1; Tue, 29 Aug 2023 08:16:44 -0400
X-MC-Unique: wvbW7TOFNgO-DwvFv2n-kQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 496DE384F3C2;
	Tue, 29 Aug 2023 12:16:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C21896B2AD;
	Tue, 29 Aug 2023 12:16:38 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	thunder.leizhen@huawei.com,
	dyoung@redhat.com,
	prudo@redhat.com,
	samuel.holland@sifive.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 5/8] crash_core.h: include <asm/crash_core.h> if generic reservation is needed
Date: Tue, 29 Aug 2023 20:16:07 +0800
Message-ID: <20230829121610.138107-6-bhe@redhat.com>
In-Reply-To: <20230829121610.138107-1-bhe@redhat.com>
References: <20230829121610.138107-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_051648_734973_4F10C29E 
X-CRM114-Status: UNSURE (   9.54  )
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

In asm/crash_core.h, ARCH can provide its own macro definitions to
override DEFAULT_CRASH_KERNEL_LOW_SIZE, CRASH_ALIGN, CRASH_ADDR_LOW_MAX,
CRASH_ADDR_HIGH_MAX in <linux/crash_core.h> if needed.

Later, x86 and arm64 wil support the generic reservaton, so wrap the
including into CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery
scope to avoid compiling error in other ARCH-es which doesn't take the
generic reservation.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 2f732493e922..86e22e6a039f 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -5,6 +5,9 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#include <asm/crash_core.h>
+#endif
 
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
