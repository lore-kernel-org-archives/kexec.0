Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CAECD98C7
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 23:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6U/8h58hOQ0KU4AswNbQiD48SWNA4TQRDe0FWqtz3Wk=; b=NOjcYKcZ9qil7XSzU+iiDlC7MI
	MK4/ZKVZKV7loig2ietF/NtRd9yX4Q6kuoG4VhXJij1HxzvZLKkczDuBLwfnb2OsoT5W5PsWfcWzI
	UdDV5ZaDyJFSDE0Zrb83UlIH1UUAmDSdTetgr+jGKp7V7dRrYEtrMromO2dBS67I+KE9+OJoesoqu
	6V8XGPJMZ3qAkj+Fy0HQUvDSxclJPdr+GTVuowGGsUkvzrEsYKbRq6ja+n0EstpKbfzNqGXN3rVlH
	Ru68yOUFyiNLHof08Bi+Ixg09aAYtrrPV+nJ0uOyUbs9pBmRp04mz1bDZOUd2J48pvcBODLB8ZO7T
	TVfOv5jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXSjc-00000008TYO-44Yu;
	Wed, 10 Jun 2026 23:53:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXSjZ-00000008TXe-0e6S
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 23:53:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781135598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U/8h58hOQ0KU4AswNbQiD48SWNA4TQRDe0FWqtz3Wk=;
	b=I9nH5+bSYpNfogoN30fhVGinfrhYXv6czJTv0h0iFiXPNdt8XttzeDmB7vW0BBUEmiduI9
	3p5xarDB5EfrUP0tNfKMdLzIqhcwSZaPdlXXIyz29uKNjcMGxOgHcnruT6aDyJCtQLjd+h
	lCp3BqyupvCg8MV5c28MOQuQp5fhJek=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-mLg88_6NMjm_WSeMMlqBjg-1; Wed, 10 Jun 2026 19:53:14 -0400
X-MC-Unique: mLg88_6NMjm_WSeMMlqBjg-1
X-Mimecast-MFC-AGG-ID: mLg88_6NMjm_WSeMMlqBjg_1781135594
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso12518911a91.2
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 16:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781135593; x=1781740393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6U/8h58hOQ0KU4AswNbQiD48SWNA4TQRDe0FWqtz3Wk=;
        b=EgsnTqVOoiJvlFfnvWBCj8+lT5me8eG7++Nxhg6mDKOcwCmBnCHK7pe6M2PLd9Lxxd
         UylmFra5Gt/M1pwcRd2qUVLgNCzpN9ap6fU6oPrHwHaS1W9m6FLCadCAIBxuM+WRCefO
         kfHUi2FX8TuPrKRhfcjX4KZQ6RXnOfN2+vGNjyWq5GNumOjlmxwuZmzps9D0V4+lrK4d
         KmU+mxg80wR5X+mTM5Qi0YMZ9evEV0bI3eNo961eY6ZiDyyR/chH9MzSf5wqMeDRr3EZ
         RMBNmnbqjxSI00ZO/+wmg7nQu6VVZ2y/hdmRFHa43nsatpHrGzO+YZvkCUPqjkeCl+vO
         Ixrg==
X-Forwarded-Encrypted: i=1; AFNElJ9mw4zyWEqg2LMTR+7X2OAZkv1OlRaGPh2PWj4P4NP1/aoZzlMXYOaqvEIhFO09Llw5wCTriA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzkx7LqgofPTagIgklQahkODTWAOaEH8fEMVv4Bi99VH55gkGZC
	0PNb+B8suSkoYR3B7g7UXoUronSJJBO6VqhT+w3v2ghywJ0Y3b+yS3uaDPiLFcLFsoAneade9sK
	W2fJItsmmBeME4Z3Knc7i0Or1sGTn9Gs2jVEZv4nGvPuDHFdL+aZEW8weixHTgw==
X-Gm-Gg: Acq92OHMtzg9wqZ22JczqBTVv/ZOKYpAQgvxGU+jW5wGCf69bRfalxuhOs5+GpAXPFD
	pI5pGEyheaHvzMODZINXbZWRYJsnf6ayEVyVTElxDR6tNrOgXIs+vDcJXfGr07pBxmwR98Tl95l
	BcrafqE44arqcYNTLSjOsJKK5xt9lP1IwmC59hucaK932B/RF1b8XnoEJE+34NAIHRjTmZ8Ld2k
	ke8MZ19Hy9jVpl4moNptXHyf2Vbphm2Ofu2rNC1D11puzkzUyH1tpRIRa3jW/bkUjScy3dNxKWi
	HX64MmJIFbGCaRvOZD+rSk9OUP3tY4fptlNS8yt6FnqkRQPklbmm8buKxULOJbqwkJpSqIxM8zf
	SMvzp4l/IOcM1Ftb7Q/TwNFWZldOQIikdMvHZ8u+bq9jfRW2zk53S8VGytXU2EKUgj0dEA4daew
	==
X-Received: by 2002:a17:90b:48cd:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-377a73e273dmr444887a91.15.1781135593535;
        Wed, 10 Jun 2026 16:53:13 -0700 (PDT)
X-Received: by 2002:a17:90b:48cd:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-377a73e273dmr444868a91.15.1781135593111;
        Wed, 10 Jun 2026 16:53:13 -0700 (PDT)
Received: from localhost.localdomain (122-63-81-176.mobile.spark.co.nz. [122.63.81.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282915fe8sm25978204b3a.54.2026.06.10.16.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:53:12 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH] Add erase_sample extension as an data erase reference
Date: Thu, 11 Jun 2026 11:42:50 +1200
Message-ID: <20260610234249.10993-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WP_4p712INh0XjKq811wKIktl4S1SuiunuRtMqvGgSo_1781135594
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_165321_270858_F9A2D80B 
X-CRM114-Status: GOOD (  17.55  )
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

Hi maintainers,

This patch should be applied upon "[PATCH v5][makedumpfile 9/9] Add amdgpu mm
pages filtering extension". Since this patch doesn't do 
modifications on any previous patches, and you are reviewing v5, so I
post appended to v5. If this causes any confusing, I'm happy to post a
v6 with a cleaner format. Thanks!

---
 extensions/Makefile       |  2 +-
 extensions/erase_sample.c | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 extensions/erase_sample.c

diff --git a/extensions/Makefile b/extensions/Makefile
index c1dbc4f..9dd4f8e 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,5 +1,5 @@
 CC ?= gcc
-CONTRIB_SO := sample.so amdgpu_filter.so
+CONTRIB_SO := sample.so erase_sample.so amdgpu_filter.so
 
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
2.47.0


