Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53EBD2ED11
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1hCjy+rrQXYNcDiiVca3zPxFAvCqQYQcYcxsTyDdlU=; b=yV8iUXbz3fMJNWvFO8JO/F+q+a
	qhgpBy3O8Z75DJx+ta+9ROurX2nYpg0xvkTwK9rf2cL1NuAbrl7hWUwjyhfLvIlLfyfkzHWCM4z3e
	+agUV9f8dXDSdjhOi2MM8l/JlM+yeDljGyiSVcGVaLgBwfXv3QvGZNGeOP9mLnOd00T/32eeIWs6W
	HTwsocDBonu7y+QBq7a4NaXHCYt59kpHX9zTCHl6rGqgnwV7qsSmnpURNhTr5VVq77MN5AKS6Vj7j
	3S2zttKoK9anmvDecwJhyUV8NTR4C90X35N9VzzCYJ5ihljN+eQ7IsbLPrWQoA6gf1iTBuCjFzaWn
	ZlA1Xesg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2ar-000000038EC-2BRZ;
	Tue, 20 Jan 2026 03:39:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2an-000000038Bq-19lW
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1hCjy+rrQXYNcDiiVca3zPxFAvCqQYQcYcxsTyDdlU=;
	b=fwhYQAT/jPJo8PVspptRLYivTc2Ls1XEdO/S9XDvulMdEZzeeL9H6FA/fS6VlLad0MglSR
	1Dn+9qeogw2wdieAKqhHzaGRKwvMJk3AbtdhzF+izAzA9/CRNlwC1lUd9i+RDcZZY8JNcS
	36m0DgsX6qRTOV1szREcgOkgKPrkn+g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-sDxyhdEqN7urT3ua3BsAKw-1; Mon, 19 Jan 2026 22:39:42 -0500
X-MC-Unique: sDxyhdEqN7urT3ua3BsAKw-1
X-Mimecast-MFC-AGG-ID: sDxyhdEqN7urT3ua3BsAKw_1768880381
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c337cde7e40so2520848a12.1
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880381; x=1769485181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1hCjy+rrQXYNcDiiVca3zPxFAvCqQYQcYcxsTyDdlU=;
        b=ecn/LW+oz5p/flZfB71A+VQYmVeo2wtoAzt9vBozqHDPkp+cI6l5X3/eGaP15kCaKI
         1Ttt992LgDNySH0R2UuN81S5i9sxH3S/UNzzA3IHob+l+lTHdATR8DB2II1CNhANPVlX
         272d0Z+vUHh+kFgrhokDYoz0eH25IJ3XU9K15GoXE+C79Wzp2EwPa9F5+YTWdglBh5XJ
         nIlhcj6Q0OqBLw8sTgBFQEpoAjh8CI5wnUwo4bDy43yCLRkQqSpQAWQRLm3E9cm4lcLB
         4rHqp/2aZnQ2eLkzaL1cRVzy2UJn0eY7Jygn+c7Lk+BVmzijFeuSxwd0zPC/pLtsV89D
         +NSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Av8fE+Jq9h33kZQHQm6QdDt/eSCTBuMjJ9gV9sDMaQzFUQK2ykNrEzqmObPidJDQYzqToQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzhKu+FFqldEn0QOsZgBGOjZ4qT3AFVtW6x0a9fbdnD7hvOWZXG
	2bXreMkgVDOr8nssNE/eqXrSptw7REJ/FHTtmgFVV01ktD+gcNdciyw5HvmESpKRyt7OpnuhDiv
	0FfrBgP45tlOiT51tEuZ0XH9XylGafVv0lLssiDBKQHA9ZuuQ89sQ712v1ceDow==
X-Gm-Gg: AY/fxX5ktTERBJd4KK93AsrHf6rltAoQ9GIkcMW+9cepl7v97H9fmJrL6+amY+5zPm7
	p7EaX58gMr+gxWdUDymJmfk9jMEQVLtY/AejxIRrtATxo7eaHzE3g5PyUFb32pAEIqgGyYLz+jC
	HpKnUOKSyGMrsBt1FLfEQYwQTIBvuIWZBljMhwsmtIdqXAhsG0yXNqlWL7Z3wyXmjRrP+HvM2WN
	QQbF2irl84ZGAXKDjyUetn98tkl6QhAemADXyrzcQk+cKxxdc2EUm+OhItZ4SaPzRRr4b4P22W2
	beL3J5MRAP5dvQD6wsgJWafFsXi0QJYL2HEQet3s76ed6nH5HHOjaTQUFzXsh6iZxSOTEWv5/XW
	I2qDIzQDRTXSYOsgEPQ==
X-Received: by 2002:a05:6a21:4592:b0:38c:4344:fc5 with SMTP id adf61e73a8af0-38e45d52aedmr590293637.30.1768880381251;
        Mon, 19 Jan 2026 19:39:41 -0800 (PST)
X-Received: by 2002:a05:6a21:4592:b0:38c:4344:fc5 with SMTP id adf61e73a8af0-38e45d52aedmr590276637.30.1768880380861;
        Mon, 19 Jan 2026 19:39:40 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:40 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 8/8] Filter amdgpu mm pages
Date: Tue, 20 Jan 2026 15:55:00 +1300
Message-ID: <20260120025500.25095-9-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Nz1zPbGbrb4fsCDZqXs8Yox5YEsUX_a1HL1tTFjBo8_1768880381
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193945_391895_C0F1606C 
X-CRM114-Status: GOOD (  16.98  )
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

This patch will introduce amdgpu mm page filtering extension, those mm pages
allocated to amdgpu will be discarded from vmcore, in order to shrink
vmcore size since mm pages allocated to amdgpu are useless to kernel
crash and may contain sensitive data.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 extensions/Makefile        |  4 +-
 extensions/amdgpu_filter.c | 90 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 extensions/amdgpu_filter.c

diff --git a/extensions/Makefile b/extensions/Makefile
index afbc61e..81dda31 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,9 +1,9 @@
 CC ?= gcc
-CONTRIB_SO :=
+CONTRIB_SO := amdgpu_filter.so
 
 all: $(CONTRIB_SO)
 
-$(CONTRIB_SO): %.so: %.c
+$(CONTRIB_SO): %.so: %.c maple_tree.c
 	$(CC) -O2 -g -fPIC -shared -o $@ $^
 
 clean:
diff --git a/extensions/amdgpu_filter.c b/extensions/amdgpu_filter.c
new file mode 100644
index 0000000..433cc0b
--- /dev/null
+++ b/extensions/amdgpu_filter.c
@@ -0,0 +1,90 @@
+#include <stdio.h>
+#include "maple_tree.h"
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "../erase_info.h"
+
+#define MEMBER_OFF(S, M) \
+	GET_STRUCT_MEMBER_MOFF(S, M) / 8
+#define MOD_MEMBER_OFF(MOD, S, M) \
+	GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M) / 8
+
+static void do_filter(void)
+{
+	uint64_t init_task, list, list_offset, amdgpu_gem_vm_ops;
+	uint64_t mm, vm_ops, tbo, ttm, num_pages, pages, pfn, vmemmap_base;
+	struct struct_member_info smi;
+	int array_len;
+	unsigned long *array_out;
+	init_task = get_kallsyms_value_by_name("init_task");
+	amdgpu_gem_vm_ops = get_kallsyms_value_by_name("amdgpu_gem_vm_ops");
+
+	INIT_STRUCT_MEMBER(task_struct, tasks);
+	INIT_STRUCT_MEMBER(task_struct, mm);
+	INIT_STRUCT_MEMBER(mm_struct, mm_mt);
+	INIT_STRUCT_MEMBER(vm_area_struct, vm_ops);
+	INIT_STRUCT_MEMBER(vm_area_struct, vm_private_data);
+	INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_buffer_object, ttm);
+	INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, pages);
+	INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, num_pages);
+	INIT_STRUCT(page);
+
+	list = init_task + MEMBER_OFF(task_struct, tasks);
+
+	do {
+		readmem(VADDR, list - MEMBER_OFF(task_struct, tasks) + 
+				MEMBER_OFF(task_struct, mm),
+			&mm, sizeof(uint64_t));
+		if (!mm) {
+			list = next_list(list);
+			continue;
+		}
+
+		array_out = mt_dump(mm + MEMBER_OFF(mm_struct, mm_mt), &array_len);
+		if (!array_out)
+			return;
+
+		for (int i = 0; i < array_len; i++) {
+			num_pages = 0;
+			readmem(VADDR, array_out[i] + MEMBER_OFF(vm_area_struct, vm_ops),
+				&vm_ops, GET_STRUCT_MEMBER_MSIZE(vm_area_struct, vm_ops));
+			if (vm_ops == amdgpu_gem_vm_ops) {
+				readmem(VADDR, array_out[i] +
+					MEMBER_OFF(vm_area_struct, vm_private_data),
+					&tbo, GET_STRUCT_MEMBER_MSIZE(vm_area_struct, vm_private_data));
+				readmem(VADDR, tbo + MOD_MEMBER_OFF(amdgpu, ttm_buffer_object, ttm),
+					&ttm, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_buffer_object, ttm));
+				if (ttm) {
+					readmem(VADDR, ttm + MOD_MEMBER_OFF(amdgpu, ttm_tt, num_pages),
+						&num_pages, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_tt, num_pages));
+					readmem(VADDR, ttm + MOD_MEMBER_OFF(amdgpu, ttm_tt, pages),
+						&pages, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_tt, pages));
+					readmem(VADDR, pages, &pages, sizeof(unsigned long));
+					readmem(VADDR, get_kallsyms_value_by_name("vmemmap_base"),
+						&vmemmap_base, sizeof(unsigned long));
+					pfn = (pages - vmemmap_base) / GET_STRUCT_SSIZE(page);
+					update_filter_pages_info(pfn, num_pages, true);
+				}
+			}
+		}
+
+		free(array_out);
+		list = next_list(list);
+	} while (list != init_task + MEMBER_OFF(task_struct, tasks));
+
+	return;
+}
+
+__attribute__((constructor))
+static void amdgpu_mmpage_filter_constructor(void)
+{
+	if (!maple_init())
+		goto out;
+	do_filter();
+out:
+	return;
+}
+
+__attribute__((destructor))
+static void amdgpu_mmpage_filter_destructor(void) {}
\ No newline at end of file
-- 
2.47.0


