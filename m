Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4219CD98EE
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5jT8elvdyMWGq75x6tF/+27d5IGwLqKotveeGDyIDM8=; b=1a63QmE+knua/okeoPxlfdA78h
	FCrRFL5XnvsS1RyfcbD1s8OC1mUN0tub2ooENfeUIt7UcSCxN4mAyWDj39NrucQGTlmK+Yenu1K2A
	ErtKBCmhZkAlFQhv3tdR6F5vtd4tAya7asqqkFDdCkbd35PuEgSP/8Lh2vwBnLecLKPnk7cddU/zl
	WGWoHDXmw9S9EqGlZ/29YirjfblpmGw1DWMX865eKVWCZ8HhLhAV0lahqNp+A+TnfQt+kQ352zBnO
	kdMjOcLUhevaUdqHtSAhzh5IwF2f+Mp48XIAfJqIEPWabrF0xspe9TZ7C6Q1edfizIRrpuPoKDLHn
	2ev9UAeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihn-0000000GeCb-3k8X;
	Wed, 17 Jun 2026 05:20:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihk-0000000GeBc-45dn
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jT8elvdyMWGq75x6tF/+27d5IGwLqKotveeGDyIDM8=;
	b=aaX2U7h5fRzt8d+u/UzgLRTPGMYXVNUR6bysiZVNiFqg2W0PgcL8gSdmMltGX0fOaBcqrX
	fFHyA4VozU7FIrLsizosLIDgGdFCdsmya1Ay6OZx4rtyBAdmyoJQJJczMm4I9JTrzxHR4j
	d3/N4/ANPcg+zlyvPy/N2CTwHfJ23DU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-V7-5HQpMPKCMWFeTTMjx7g-1; Wed, 17 Jun 2026 01:20:46 -0400
X-MC-Unique: V7-5HQpMPKCMWFeTTMjx7g-1
X-Mimecast-MFC-AGG-ID: V7-5HQpMPKCMWFeTTMjx7g_1781673645
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84238e83851so3499274b3a.1
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673645; x=1782278445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5jT8elvdyMWGq75x6tF/+27d5IGwLqKotveeGDyIDM8=;
        b=FU7Hfwhu53chgUrgvzkYCQ/mLoxn54CM+tFTjschitIz9T1DXYZBMj7n65dlkxb0go
         6La0Zz2IypLfVVLC+TJ8ryxpYJlPPlX/KSmj7KhgTKswebE4AHdF7ZELLSX+7Zb++rJv
         icHDXA0GVb9bWFZx5QqhcG0QZ1pTbu2Sr/rfjGnsTwV/Wqz635vrCb5YCftWaDPxvJzZ
         hi+GaEKzDtc//vU8p395qnffZqGjhMfLpMiyzg19KvM7OLYDTKU1xG7DswJhIcPmdDVe
         ccWNoDJ8XYLRHqtBJ8nhbUvKw1lN43l7Thtmqr2/b7cW5kDShm3nIzWeFhX7DVuC/ZGk
         QvbA==
X-Forwarded-Encrypted: i=1; AFNElJ9W+jG4BSfuPm8o6AoeZ493326sIKzCeJ84YbyfyEWARURva0ZV87IqkHcwgaPDaonfUveAqQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzk595i+G41MDb1RxSo4wwt3+QUrh3Jx9MxefEU1tn8YbGzq2db
	ObKl5d2eCHsKLJwWyEHyzRURpr//a9ENedTTpeM1lzDYqdytrFNhOSLdy9NMdQ8DVjSSruUyuHw
	5I45TyeUqUrDXPvqHEFHx8r/ocPNrgyHahfl7MnOtaCznvjML7WUReSE051XBtA==
X-Gm-Gg: AfdE7ckI9a0nUtOrita4xkBOKUM3V98lAv8YRk50OX3poFp+TPhrjLhbc9Kec8bn8wm
	6ht9TX9pmTSkTJqmq5xYSZO3riyG00dbzh1+9cR9IW1VkYcaMOtAGALPKeRbxLd53iLOgduw3iu
	TVIPrrj2w2ou2zP6PUK4n13ZClqJEFKzjLa7uBLXGz2ndC7P34t8zGjRPlmX9hSC/qOontPSMH0
	PeGqX1Vn5yWJbopyTl0hAKEw2mr6D7UwLd7gi4KIovdD1oTvlVkcZDHjbMuhqCiva9qgcTRAJcX
	AKMNbAwymcbj5qunDFr6IrJ3d4lM2MfxHzFymZmt6M15dewga5FZ7X2xFjpUJzT1rk9bETNsmCX
	ObxU+fw/QZsSQouDedy0NhszCrzS6TjopdbINYgvJuk+Da665CA==
X-Received: by 2002:a05:6a00:410d:b0:842:670d:f6ff with SMTP id d2e1a72fcca58-845247bdd19mr2124476b3a.44.1781673645338;
        Tue, 16 Jun 2026 22:20:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:410d:b0:842:670d:f6ff with SMTP id d2e1a72fcca58-845247bdd19mr2124447b3a.44.1781673644902;
        Tue, 16 Jun 2026 22:20:44 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:44 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 08/10] Add erase_sample extension as an data erase reference
Date: Wed, 17 Jun 2026 17:18:32 +1200
Message-ID: <20260617051834.95404-9-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617051834.95404-1-ltao@redhat.com>
References: <20260617051834.95404-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i0khvzoK8Kp9O_R9ei0AZgi5RDLM83UdEadIunKOnQs_1781673645
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222049_089863_E9998CB4 
X-CRM114-Status: GOOD (  15.65  )
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

This patch will add a erase_sample.c as a data erase reference. It will
erase all tasks & threads's comm[] member within their task_struct, as
a result, you will see the ps info outputted by crash utility similiar
as follows:

crash> ps
 ...
 1       0  10  ffff96b7c0980000  IN   0.0    25504    15704  XXXXXXXXXXXXXXX
 2       0  15  ffff96b7c0982f40  IN   0.0        0        0  [XXXXXXXXXXXXXXX]
 3       2   2  ffff96b7c09a0000  IN   0.0        0        0  [XXXXXXXXXXXXXXX]
 4       2   0  ffff96b7c09a2f40  ID   0.0        0        0  [XXXXXXXXXXXXXXX]
 5       2   0  ffff96b7c09a8000  ID   0.0        0        0  [XXXXXXXXXXXXXXX]

The comm[] erasure doesn't cause critical info loss and has slight
impact on vmcore analyze, so it is safe to take it as an example for
developers.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 extensions/Makefile       |  2 +-
 extensions/erase_sample.c | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 extensions/erase_sample.c

diff --git a/extensions/Makefile b/extensions/Makefile
index dbaec4e..c112d56 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,5 +1,5 @@
 CC ?= gcc
-CONTRIB_SO := sample.so
+CONTRIB_SO := sample.so erase_sample.so
 
 all: $(CONTRIB_SO)
 
diff --git a/extensions/erase_sample.c b/extensions/erase_sample.c
new file mode 100644
index 0000000..7c935d1
--- /dev/null
+++ b/extensions/erase_sample.c
@@ -0,0 +1,78 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "../extension.h"
+#include "../erase_info.h"
+
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, tasks);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, thread_node);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, signal);
+INIT_MOD_STRUCT_MEMBER(vmlinux, signal_struct, thread_head);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, comm);
+INIT_MOD_SYM(vmlinux, init_task);
+
+#define MOD_MEMBER_OFF(MOD, S, M) \
+	GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M) / 8
+#define KERN_MEMBER_OFF(S, M) MOD_MEMBER_OFF(vmlinux, S, M)
+#define GET_KERN_STRUCT_MEMBER_MSIZE(S, M) \
+	GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, S, M)
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+
+/* task_struct.comm eraser */
+static bool erase_task_struct_comm(void)
+{
+	uint64_t task_list, init_task, comm, signal, thread_head, thread_list;
+	uint32_t size;
+
+	init_task = GET_KERN_SYM(init_task);
+	size = GET_KERN_STRUCT_MEMBER_MSIZE(task_struct, comm);
+	task_list = init_task + KERN_MEMBER_OFF(task_struct, tasks);
+
+	/* Iterate all tasks */
+	do {
+		thread_list = task_list - KERN_MEMBER_OFF(task_struct, tasks) +
+			KERN_MEMBER_OFF(task_struct, thread_node);
+		if (!readmem(VADDR, task_list - KERN_MEMBER_OFF(task_struct, tasks) +
+			KERN_MEMBER_OFF(task_struct, signal), &signal, sizeof(uint64_t))) {
+			ERRMSG("Can't get task_struct member signal!\n");
+			goto out;
+		}
+		thread_head = signal + KERN_MEMBER_OFF(signal_struct, thread_head);
+
+		/* Iterate all threads of the task */
+		do {
+			comm = thread_list - KERN_MEMBER_OFF(task_struct, thread_node) +
+				KERN_MEMBER_OFF(task_struct, comm);
+
+			if (!update_filter_info_raw(comm, 'X', size)) {
+				ERRMSG("Failed update filter info!\n");
+				goto out;
+			}
+
+			thread_list = next_list(thread_list);
+		} while (thread_list != thread_head);
+
+		task_list = next_list(task_list);
+	} while (task_list != init_task + KERN_MEMBER_OFF(task_struct, tasks));
+
+	return true;
+out:
+	return false;
+}
+
+void extension_init(void)
+{
+	if (!erase_task_struct_comm()) {
+		ERRMSG("erase_sample.so: erase fail!\n");
+		goto out;
+	}
+	MSG("erase_sample.so: erase success!\n");
+out:
+	return;
+}
+
+__attribute__((destructor))
+void extension_cleanup(void) { }
+
-- 
2.54.0


