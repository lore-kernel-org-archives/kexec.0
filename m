Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836B3ED7B9B
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wAJ0ISwkrI8XoJas3bVI7Fs6JEZyuokajDKsNtBis4E=; b=SuZJS0iH4TL1p8viLjqOK0rBUB
	exrnk64OHHEDhRJzF8UWAS7ZBpvHpYLvsXLxadNy5uWq0KHtl3kCaksHo0mNlWgVYD+bX37K8Dd8h
	qooN61I7gmqcluhPcwKFd+Y8K/gRwSpTiPlle5KEEpnnu3zsZmHSOtn91lywcGmy0kD+X5uHUGCoC
	cpMPwnf5zgviV7YGLBb5CnmYPHkeBaRjMAtxvX78iPDEXjdPHVNwn2Gpuf7+VJGgpkSYl2NwOeJDe
	nhFXKcLETwhKklAR7ZKSbF6UPZTgGr8WdOh8v9K0YWb2lbGDzo61LAwBsywbHmyZkAtwDop3LmZLl
	WcRGTX4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazx-0000000H99K-0Jx7;
	Tue, 14 Apr 2026 10:28:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazu-0000000H97k-3MBv
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:28:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wAJ0ISwkrI8XoJas3bVI7Fs6JEZyuokajDKsNtBis4E=;
	b=KecRlUbYp4FGQfpClOw09g8nH9FFej42IEUBP6V1p1EdKahE46EcGMThRRDZdcg8tKtTRX
	dQD48wpiU43TFQz2rvM1epiuFtTi5T6P4KvKy6YO41QCkEnxsAXH3SPptjX81vtso7jpTG
	VVauMOftEkRfq4C07lQgU6nCoqLLKOs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642--He-WnRdOEizAb6XVVjiiQ-1; Tue, 14 Apr 2026 06:27:56 -0400
X-MC-Unique: -He-WnRdOEizAb6XVVjiiQ-1
X-Mimecast-MFC-AGG-ID: -He-WnRdOEizAb6XVVjiiQ_1776162476
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2523e0299so131561255ad.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162476; x=1776767276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wAJ0ISwkrI8XoJas3bVI7Fs6JEZyuokajDKsNtBis4E=;
        b=kTDHISTYG58LcOr7YefRQIx4meFwBXQ109WnKn1bFQbkl2qfdSa99H2iMu7qnRXAI3
         csVzqN4oA9zYdy0kOwwutJrdKOMcf4mVRZdqfE1wSangXSNVBLaYSb1cFbutvdtf++8H
         hou23m1jO+qwn+czTYwsG9bokiqHbD4ehZlso+QFHF0qLcQ7IZ0BTbg62CwBgzoH7H42
         4FzZ3BjLPpvuoaNXq8xVyu6L6vszQAwHuP/vRDJQZvTgNWm82CVYkL1MVVkooCK16Unm
         QuME6FOw6bOiw2+/OLRRyJT3vIs77HwJ1jw2XSi+UJ0rMpLEXa3JlgqF9tcjOJW6xo8D
         kueg==
X-Forwarded-Encrypted: i=1; AFNElJ9VlXOTFRZu0VsqZPCN0sUF+uhrmHkqYu7L/dBCEIrtMANEPFVVrwZKwi6IXyZGI/KWfWi3lA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw62RxPgOoEN4HiOvHUIpM77hTBOrI+ZWzCWGoI/iWfIDN6P8JU
	KAh9ucaQu2sKt+0rSJpNlTb4p4gU5cBxo/L1C2u489eAqg3/5kGHMBKaTqxFHCDcouk7xP9ofSx
	X7JkpcmV45L6ghscRlhAOq1ZXLXc1rMSL/N2dUwv0WqOQgGrtItMTj6QjFey6sg==
X-Gm-Gg: AeBDieupXf0HlolQHceCwTy7iQN6VQHccjrB2syU1Ml1g/LneEXgT1Gznh2GVdv0BJm
	oEny6m9+awwWJE7iwzsI2vCL4hwlkXVb88RFyBOxjGcLLrnR05UIGn0IncFqPcyg/piaikDKi6i
	AtvyjYxSoaEid2LkQVw6MXbO+AE520689JUziyPD+hFRdySaBNBeBN4awr65T4pCYCMhlh5ucoP
	SJjezJsU+TM6B6E+3HEUpwi4P+EU4vOb/mgqJVdP3nRcfKPwX4AsUJgRCr8IbXjRD+ddoU+k/qI
	GpoDMCi9cR0PRdmTX2uLEvFD3fsK9OCsRUxEptEkTWD3CCyTfIp79Uo+ca/4NKuCH5Rt01TfuXx
	kOKy8eDAwUcIAc1xZpHjIYB8027FopPpl543oOtebQP9xCscJBso3xxHg9DQMKVlkXoVf
X-Received: by 2002:a17:903:2f08:b0:2b2:58c7:2cd2 with SMTP id d9443c01a7336-2b2d5a5dccbmr174823085ad.36.1776162475570;
        Tue, 14 Apr 2026 03:27:55 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2b2:58c7:2cd2 with SMTP id d9443c01a7336-2b2d5a5dccbmr174822675ad.36.1776162475004;
        Tue, 14 Apr 2026 03:27:55 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:54 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 9/9] Add amdgpu mm pages filtering extension
Date: Tue, 14 Apr 2026 22:26:56 +1200
Message-ID: <20260414102656.55200-10-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B1n5nLs1xQNdC7BEf7dxg8HTmHUnzG26IF_6mGKnbjw_1776162476
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032758_989209_712FFE3C 
X-CRM114-Status: GOOD (  23.68  )
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

This patch will introduce maple_tree & amdgpu mm page filtering extension,
those mm pages allocated to amdgpu will be discarded from vmcore, in order
to shrink vmcore size since mm pages allocated to amdgpu are useless to kernel
crash and may contain sensitive data.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 extensions/Makefile        |   4 +-
 extensions/amdgpu_filter.c | 221 +++++++++++++++++++++++++
 extensions/maple_tree.c    | 328 +++++++++++++++++++++++++++++++++++++
 extensions/maple_tree.h    |   7 +
 4 files changed, 559 insertions(+), 1 deletion(-)
 create mode 100644 extensions/amdgpu_filter.c
 create mode 100644 extensions/maple_tree.c
 create mode 100644 extensions/maple_tree.h

diff --git a/extensions/Makefile b/extensions/Makefile
index dbaec4e..c1dbc4f 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,8 +1,10 @@
 CC ?= gcc
-CONTRIB_SO := sample.so
+CONTRIB_SO := sample.so amdgpu_filter.so
 
 all: $(CONTRIB_SO)
 
+amdgpu_filter.so: maple_tree.c
+
 $(CONTRIB_SO): %.so: %.c
 	$(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
 
diff --git a/extensions/amdgpu_filter.c b/extensions/amdgpu_filter.c
new file mode 100644
index 0000000..0ad0fb5
--- /dev/null
+++ b/extensions/amdgpu_filter.c
@@ -0,0 +1,221 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include "maple_tree.h"
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "../extension.h"
+
+/*
+ * These syms/types are must-have for the extension.
+*/
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, tasks);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, mm);
+INIT_MOD_STRUCT_MEMBER(vmlinux, mm_struct, mm_mt);
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_ops);
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_private_data);
+INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_buffer_object, ttm);
+INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, pages);
+INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, num_pages);
+INIT_MOD_STRUCT(vmlinux, page);
+
+INIT_MOD_SYM(vmlinux, init_task);
+INIT_MOD_SYM(vmlinux, vmemmap_base);
+INIT_MOD_SYM(amdgpu, amdgpu_gem_vm_ops);
+
+struct ft_page_info {
+	unsigned long pfn;
+	unsigned long num;
+	struct ft_page_info *next;
+};
+
+static struct ft_page_info *ft_head_discard = NULL;
+
+static void update_filter_pages_info(unsigned long pfn, unsigned long num)
+{
+	struct ft_page_info *p, **ft_head;
+	struct ft_page_info *new_p = malloc(sizeof(struct ft_page_info));
+
+	ft_head = &ft_head_discard;
+
+	if (!new_p) {
+		ERRMSG("Can't allocate memory for ft_page_info\n");
+		return;
+	}
+	new_p->pfn = pfn;
+	new_p->num = num;
+	new_p->next = NULL;
+
+	if (!(*ft_head) || (*ft_head)->pfn > new_p->pfn) {
+		new_p->next = (*ft_head);
+		(*ft_head) = new_p;
+		return;
+	}
+
+	p = (*ft_head);
+	while (p->next != NULL && p->next->pfn < new_p->pfn) {
+		p = p->next;
+	}
+
+	new_p->next = p->next;
+	p->next = new_p;
+}
+
+static int filter_page(unsigned long pfn, struct ft_page_info **p)
+{
+	struct ft_page_info *ft_head = ft_head_discard;
+
+	if (ft_head == NULL)
+		return PG_UNDECID;
+
+	if (*p == NULL)
+		*p = ft_head;
+
+	/* The gap before 1st block */
+	if (pfn >= 0 && pfn < ft_head->pfn)
+		return PG_UNDECID;
+
+	/* Handle 1~(n-1) blocks and following gaps */
+	while ((*p)->next) {
+		if (pfn >= (*p)->pfn && pfn < (*p)->pfn + (*p)->num)
+			return PG_EXCLUDE; // hit the block
+		if (pfn >= (*p)->pfn + (*p)->num && pfn < (*p)->next->pfn)
+			return PG_UNDECID; // the gap after the block
+		*p = (*p)->next;
+	}
+
+	/* The last block and gap */
+	if (pfn >= (*p)->pfn + (*p)->num)
+		return PG_UNDECID;
+	else
+		return PG_EXCLUDE;
+}
+
+static void do_cleanup(struct ft_page_info **ft_head)
+{
+	struct ft_page_info *p, *p_tmp;
+
+	for (p = *ft_head; p;) {
+		p_tmp = p;
+		p = p->next;
+		free(p_tmp);
+	}
+	*ft_head = NULL;
+}
+
+#define MOD_MEMBER_OFF(MOD, S, M) \
+	GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M) / 8
+#define KERN_MEMBER_OFF(S, M) MOD_MEMBER_OFF(vmlinux, S, M)
+#define GET_KERN_STRUCT_MEMBER_MSIZE(S, M) \
+	GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, S, M)
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+#define GET_KERN_STRUCT_SSIZE(S) GET_MOD_STRUCT_SSIZE(vmlinux, S)
+
+static bool gather_amdgpu_mm_range_info(void)
+{
+	uint64_t init_task, list, list_offset, amdgpu_gem_vm_ops;
+	uint64_t mm, vm_ops, tbo, ttm, num_pages, pages, pfn, vmemmap_base;
+	int array_len;
+	unsigned long *array_out;
+	init_task = GET_KERN_SYM(init_task);
+	amdgpu_gem_vm_ops = GET_MOD_SYM(amdgpu, amdgpu_gem_vm_ops);
+
+	list = init_task + KERN_MEMBER_OFF(task_struct, tasks);
+
+	do {
+		if (!readmem(VADDR, list - KERN_MEMBER_OFF(task_struct, tasks) + 
+				KERN_MEMBER_OFF(task_struct, mm),
+			&mm, sizeof(uint64_t))) {
+			ERRMSG("Can't get task_struct member mm!\n");
+			goto out;
+		}
+		if (!mm) {
+			list = next_list(list);
+			continue;
+		}
+
+		array_out = mt_dump(mm + KERN_MEMBER_OFF(mm_struct, mm_mt), &array_len);
+		if (!array_out)
+			goto out;
+
+		for (int i = 0; i < array_len; i++) {
+			num_pages = 0;
+			if (!readmem(VADDR, array_out[i] + KERN_MEMBER_OFF(vm_area_struct, vm_ops),
+				&vm_ops, GET_KERN_STRUCT_MEMBER_MSIZE(vm_area_struct, vm_ops))) {
+				ERRMSG("Can't get vm_area_struct member vm_ops!\n");
+				goto out;
+			}
+			if (vm_ops == amdgpu_gem_vm_ops) {
+				if (!readmem(VADDR, array_out[i] +
+					KERN_MEMBER_OFF(vm_area_struct, vm_private_data),
+					&tbo, GET_KERN_STRUCT_MEMBER_MSIZE(vm_area_struct, vm_private_data))) {
+					ERRMSG("Can't get vm_area_struct member vm_private_data!\n");
+					goto out;
+				}
+				if (!readmem(VADDR, tbo + MOD_MEMBER_OFF(amdgpu, ttm_buffer_object, ttm),
+					&ttm, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_buffer_object, ttm))) {
+					ERRMSG("Can't get ttm_buffer_object member ttm!\n");
+					goto out;
+				}
+				if (ttm) {
+					if (!readmem(VADDR, ttm + MOD_MEMBER_OFF(amdgpu, ttm_tt, num_pages),
+						&num_pages, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_tt, num_pages))) {
+						ERRMSG("Can't get ttm_tt member num_pages!\n");
+						goto out;
+					}
+					if (!readmem(VADDR, ttm + MOD_MEMBER_OFF(amdgpu, ttm_tt, pages),
+						&pages, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_tt, pages))) {
+						ERRMSG("Can't get ttm_tt member pages!\n");
+						goto out;
+					}
+					if (!readmem(VADDR, pages, &pages, sizeof(unsigned long))) {
+						ERRMSG("Can't get pages!\n");
+						goto out;
+					}
+					if (!readmem(VADDR, GET_KERN_SYM(vmemmap_base),
+						&vmemmap_base, sizeof(unsigned long))) {
+						ERRMSG("Can't get vmemmap_base!\n");
+						goto out;
+					}
+					pfn = (pages - vmemmap_base) / GET_KERN_STRUCT_SSIZE(page);
+					update_filter_pages_info(pfn, num_pages);
+				}
+			}
+		}
+
+		free(array_out);
+		list = next_list(list);
+	} while (list != init_task + KERN_MEMBER_OFF(task_struct, tasks));
+
+	return true;
+out:
+	return false;
+}
+
+/* Extension callback when makedumpfile do page filtering */
+int extension_callback(unsigned long pfn, const void *pcache)
+{
+	struct ft_page_info *cur = NULL;
+
+	return filter_page(pfn, &cur);
+}
+
+/* Entry of extension */
+void extension_init(void)
+{
+	if (!maple_init() || !gather_amdgpu_mm_range_info()) {
+		ERRMSG("amdgpu_filter.so: init fail!\n");
+		goto out;
+	}
+	MSG("amdgpu_filter.so: init success!\n");
+out:
+	return;
+}
+
+__attribute__((destructor))
+void extension_cleanup(void)
+{
+	do_cleanup(&ft_head_discard);
+}
+
+
diff --git a/extensions/maple_tree.c b/extensions/maple_tree.c
new file mode 100644
index 0000000..9cc067f
--- /dev/null
+++ b/extensions/maple_tree.c
@@ -0,0 +1,328 @@
+#include <stdio.h>
+#include <stdbool.h>
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "../makedumpfile.h"
+
+static unsigned char mt_slots[4] = {0};
+static unsigned char mt_pivots[4] = {0};
+static unsigned long mt_max[4] = {0};
+
+INIT_OPT_MOD_SYM(vmlinux, mt_slots);
+INIT_OPT_MOD_SYM(vmlinux, mt_pivots);
+
+INIT_OPT_MOD_STRUCT(vmlinux, maple_tree);
+INIT_OPT_MOD_STRUCT(vmlinux, maple_node);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_tree, ma_root);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_node, ma64);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_node, mr64);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_node, slot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_arange_64, pivot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_arange_64, slot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_range_64, pivot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_range_64, slot);
+
+#define MEMBER_OFF(S, M) \
+	GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8
+#define KERN_STRUCT_MEMBER_EXIST(S, M) \
+	MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M)
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+#define KERN_SYM_EXIST(SYM) MOD_SYM_EXIST(vmlinux, SYM)
+#define GET_KERN_STRUCT_SSIZE(S) \
+	GET_MOD_STRUCT_SSIZE(vmlinux, S)
+#define KERN_STRUCT_EXIST(SYM) MOD_STRUCT_EXIST(vmlinux, SYM)
+
+#define MAPLE_BUFSIZE			512
+
+enum {
+	maple_dense_enum,
+	maple_leaf_64_enum,
+	maple_range_64_enum,
+	maple_arange_64_enum,
+};
+
+#define MAPLE_NODE_MASK			255UL
+#define MAPLE_NODE_TYPE_MASK		0x0F
+#define MAPLE_NODE_TYPE_SHIFT		0x03
+#define XA_ZERO_ENTRY			xa_mk_internal(257)
+
+static unsigned long xa_mk_internal(unsigned long v)
+{
+	return (v << 2) | 2;
+}
+
+static bool xa_is_internal(unsigned long entry)
+{
+	return (entry & 3) == 2;
+}
+
+static bool xa_is_node(unsigned long entry)
+{
+	return xa_is_internal(entry) && entry > 4096;
+}
+
+static bool xa_is_value(unsigned long entry)
+{
+	return entry & 1;
+}
+
+static bool xa_is_zero(unsigned long entry)
+{
+	return entry == XA_ZERO_ENTRY;
+}
+
+static unsigned long xa_to_internal(unsigned long entry)
+{
+	return entry >> 2;
+}
+
+static unsigned long xa_to_value(unsigned long entry)
+{
+	return entry >> 1;
+}
+
+static unsigned long mte_to_node(unsigned long entry)
+{
+        return entry & ~MAPLE_NODE_MASK;
+}
+
+static unsigned long mte_node_type(unsigned long maple_enode_entry)
+{
+	return (maple_enode_entry >> MAPLE_NODE_TYPE_SHIFT) &
+		MAPLE_NODE_TYPE_MASK;
+}
+
+static unsigned long mt_slot(void **slots, unsigned char offset)
+{
+       return (unsigned long)slots[offset];
+}
+
+static bool ma_is_leaf(unsigned long type)
+{
+	return type < maple_range_64_enum;
+}
+
+static bool mte_is_leaf(unsigned long maple_enode_entry)
+{
+       return ma_is_leaf(mte_node_type(maple_enode_entry));
+}
+
+static void mt_dump_entry(unsigned long entry, unsigned long min,
+			unsigned long max, unsigned int depth,
+			unsigned long **array_out, int *array_len,
+			int *array_cap)
+{
+	if (entry == 0)
+		return;
+
+	add_to_arr((void ***)array_out, array_len, array_cap, (void *)entry);
+}
+
+static void mt_dump_node(unsigned long entry, unsigned long min,
+			unsigned long max, unsigned int depth,
+			unsigned long **array_out, int *array_len,
+			int *array_cap);
+
+static void mt_dump_range64(unsigned long entry, unsigned long min,
+			unsigned long max, unsigned int depth,
+			unsigned long **array_out, int *array_len,
+			int *array_cap)
+{
+	unsigned long maple_node_m_node = mte_to_node(entry);
+	char node_buf[MAPLE_BUFSIZE];
+	bool leaf = mte_is_leaf(entry);
+	unsigned long first = min, last;
+	int i;
+	char *mr64_buf;
+
+	if (!readmem(VADDR, maple_node_m_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node))) {
+		ERRMSG("Can't get maple_node_m_node!\n");
+	}
+	mr64_buf = node_buf + MEMBER_OFF(maple_node, mr64);
+
+	for (i = 0; i < mt_slots[maple_range_64_enum]; i++) {
+		last = max;
+
+		if (i < (mt_slots[maple_range_64_enum] - 1))
+			last = ULONG(mr64_buf + MEMBER_OFF(maple_range_64, pivot) +
+				     sizeof(ulong) * i);
+
+		else if (!VOID_PTR(mr64_buf + MEMBER_OFF(maple_range_64, slot) +
+			  sizeof(void *) * i) &&
+			 max != mt_max[mte_node_type(entry)])
+			break;
+		if (last == 0 && i > 0)
+			break;
+		if (leaf)
+			mt_dump_entry(mt_slot((void **)(mr64_buf +
+						      MEMBER_OFF(maple_range_64, slot)), i),
+				first, last, depth + 1, array_out, array_len, array_cap);
+		else if (VOID_PTR(mr64_buf + MEMBER_OFF(maple_range_64, slot) +
+				  sizeof(void *) * i)) {
+			mt_dump_node(mt_slot((void **)(mr64_buf +
+						     MEMBER_OFF(maple_range_64, slot)), i),
+				first, last, depth + 1, array_out, array_len, array_cap);
+		}
+
+		if (last == max)
+			break;
+		if (last > max) {
+			MSG("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				mr64_buf, last, max, i);
+			break;
+		}
+		first = last + 1;
+	}
+}
+
+static void mt_dump_arange64(unsigned long entry, unsigned long min,
+			unsigned long max, unsigned int depth,
+			unsigned long **array_out, int *array_len,
+			int *array_cap)
+{
+	unsigned long maple_node_m_node = mte_to_node(entry);
+	char node_buf[MAPLE_BUFSIZE];
+	unsigned long first = min, last;
+	int i;
+	char *ma64_buf;
+
+	if (!readmem(VADDR, maple_node_m_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node))) {
+		ERRMSG("Can't get maple_node_m_node!\n");
+	}
+	ma64_buf = node_buf + MEMBER_OFF(maple_node, ma64);
+
+	for (i = 0; i < mt_slots[maple_arange_64_enum]; i++) {
+		last = max;
+
+		if (i < (mt_slots[maple_arange_64_enum] - 1))
+			last = ULONG(ma64_buf + MEMBER_OFF(maple_arange_64, pivot) +
+				     sizeof(void *) * i);
+		else if (!VOID_PTR(ma64_buf + MEMBER_OFF(maple_arange_64, slot) +
+				   sizeof(void *) * i))
+			break;
+		if (last == 0 && i > 0)
+			break;
+
+		if (ULONG(ma64_buf + MEMBER_OFF(maple_arange_64, slot) + sizeof(void *) * i))
+			mt_dump_node(mt_slot((void **)(ma64_buf +
+						      MEMBER_OFF(maple_arange_64, slot)), i),
+				first, last, depth + 1, array_out, array_len, array_cap);
+
+		if (last == max)
+			break;
+		if (last > max) {
+			MSG("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				ma64_buf, last, max, i);
+			break;
+		}
+		first = last + 1;
+	}
+}
+
+static void mt_dump_node(unsigned long entry, unsigned long min,
+			unsigned long max, unsigned int depth,
+			unsigned long **array_out, int *array_len,
+			int *array_cap)
+{
+	unsigned long maple_node = mte_to_node(entry);
+	unsigned long type = mte_node_type(entry);
+	int i;
+	char node_buf[MAPLE_BUFSIZE];
+
+	if (!readmem(VADDR, maple_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node))) {
+		ERRMSG("Can't get maple_node!\n");
+	}
+
+	switch (type) {
+	case maple_dense_enum:
+		for (i = 0; i < mt_slots[maple_dense_enum]; i++) {
+			if (min + i > max)
+				MSG("OUT OF RANGE: ");
+			mt_dump_entry(mt_slot((void **)(node_buf + MEMBER_OFF(maple_node, slot)), i),
+				min + i, min + i, depth, array_out, array_len, array_cap);
+		}
+		break;
+	case maple_leaf_64_enum:
+	case maple_range_64_enum:
+		mt_dump_range64(entry, min, max, depth, array_out, array_len, array_cap);
+		break;
+	case maple_arange_64_enum:
+		mt_dump_arange64(entry, min, max, depth, array_out, array_len, array_cap);
+		break;
+	default:
+		MSG(" UNKNOWN TYPE\n");
+	}	
+}
+
+unsigned long *mt_dump(unsigned long mt, int *array_len)
+{
+	char tree_buf[MAPLE_BUFSIZE];
+	unsigned long entry;
+	unsigned long *array_out = NULL;
+	int array_cap = 0;
+	*array_len = 0;
+
+	if (!readmem(VADDR, mt, tree_buf, GET_KERN_STRUCT_SSIZE(maple_tree))) {
+		ERRMSG("Can't get maple_tree!\n");
+	}
+	entry = ULONG(tree_buf + MEMBER_OFF(maple_tree, ma_root));
+
+	if (xa_is_node(entry))
+		mt_dump_node(entry, 0, mt_max[mte_node_type(entry)], 0,
+				&array_out, array_len, &array_cap);
+	else if (entry)
+		mt_dump_entry(entry, 0, 0, 0, &array_out, array_len, &array_cap);
+	else
+		MSG("(empty)\n");
+
+	return array_out;
+}
+
+bool maple_init(void)
+{
+	unsigned long mt_slots_ptr;
+	unsigned long mt_pivots_ptr;
+
+	if (!KERN_SYM_EXIST(mt_slots) ||
+	    !KERN_SYM_EXIST(mt_pivots) ||
+	    !KERN_STRUCT_EXIST(maple_tree) ||
+	    !KERN_STRUCT_EXIST(maple_node) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_tree, ma_root) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_node, ma64) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_node, mr64) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_node, slot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, pivot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, slot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, pivot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, slot)) {
+		ERRMSG("Missing required maple tree syms/types\n");
+		return false;
+	}
+
+	mt_slots_ptr = GET_KERN_SYM(mt_slots);
+	mt_pivots_ptr = GET_KERN_SYM(mt_pivots);
+
+	if (GET_KERN_STRUCT_SSIZE(maple_tree) > MAPLE_BUFSIZE ||
+	    GET_KERN_STRUCT_SSIZE(maple_node) > MAPLE_BUFSIZE) {
+		ERRMSG("MAPLE_BUFSIZE should be larger than maple_node/tree struct\n");
+		return false;
+	}
+
+	if (!readmem(VADDR, mt_slots_ptr, mt_slots, sizeof(mt_slots))) {
+		ERRMSG("Can't get mt_slots!\n");
+		return false;
+	}
+	if (!readmem(VADDR, mt_pivots_ptr, mt_pivots, sizeof(mt_pivots))) {
+		ERRMSG("Can't get mt_pivots!\n");
+		return false;
+	}
+
+	mt_max[maple_dense_enum]           = mt_slots[maple_dense_enum];
+	mt_max[maple_leaf_64_enum]         = ULONG_MAX;
+	mt_max[maple_range_64_enum]        = ULONG_MAX;
+	mt_max[maple_arange_64_enum]       = ULONG_MAX;
+
+	return true;
+}
+
+
diff --git a/extensions/maple_tree.h b/extensions/maple_tree.h
new file mode 100644
index 0000000..2e8d029
--- /dev/null
+++ b/extensions/maple_tree.h
@@ -0,0 +1,7 @@
+#ifndef _MAPLE_TREE_H
+#define _MAPLE_TREE_H
+#include <stdbool.h>
+unsigned long *mt_dump(unsigned long mt, int *array_len);
+bool maple_init(void);
+#endif /* _MAPLE_TREE_H */
+
-- 
2.47.0


