Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9ADFED9E3
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RzLAyUBii/fjus56/enN0vt1y6UHsNO6huFb0Mz7exw=; b=AOkv6pzmIcONAuQ4YYicX0sTsk
	81Nb/MN7B1RxLhepJmoiE4hpyAtur9JoKiF53Qvv1Q23TOyY7rL2+dT+tLp6W9IzuspvVZxLuAWco
	WaG39lQ3NUzGr6p1v0RD/If8LMRds+sHDDLKiCMiC2jOpLshF953kEav8Y0+kSejSsL9eTps8w6yL
	35/zgEBcS+lw3t8mY2XF+hSZGFGmd8WUR3D4C5DihiSXcaR6Lw+PjnfcXMtkzetAq+VfREYZvHQB5
	k8NJ9VlD0JhnPPTugr670P7ScRXDxUP19PEj6lCw3StW+AyD+MGE2ecwROrvpboyxejS5c8bv1N3I
	p/tMkTFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2x-00000006h47-1HW0;
	Tue, 17 Mar 2026 15:09:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2v-00000006h2u-10Jp
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:09:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzLAyUBii/fjus56/enN0vt1y6UHsNO6huFb0Mz7exw=;
	b=SCb8/LO+5YUjxBjRalViLzpuEVwXjrDa5qmqQKX7NbK9U55Fk80c7Q2kqQy+v9iqxTsX2U
	8s4qQ7voZzMBAkarUwPctFBY5aUfGO3lRN0L7JACP4QQPN/TILvfrQ17rTxrSlyqnrD/wa
	khxMVJtwwt4heRU6G/pl6cG6etXTL7o=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-hX3yq_ygNU2ojBvpf-ua5A-1; Tue, 17 Mar 2026 11:09:21 -0400
X-MC-Unique: hX3yq_ygNU2ojBvpf-ua5A-1
X-Mimecast-MFC-AGG-ID: hX3yq_ygNU2ojBvpf-ua5A_1773760161
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829b20cc6faso914669b3a.1
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760160; x=1774364960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzLAyUBii/fjus56/enN0vt1y6UHsNO6huFb0Mz7exw=;
        b=qIqlkN+pvS4VpwIePGIdCJDPcLi0L2TvfQ8G5Qx2VxS2T2rSxbFWEUN9z25wDcWrxz
         ewcuyGAHvb5sAsnTSmy66NA7INCMBnixZgREYbfRNb3yHlsPPUaBCGUYOH9Ui8AubLNi
         KCHKLc7VTQ8qikh8iAMYGalF4WfBqZ2lZMohno1hJUYpjBCk+vQwDfB3eshq/Yrt5YUs
         0jawOZ8vLFWfOtYe2tZOulXnj/T7d6lywBhYM/RFdljaYtza02iUfYe5OmjsjfLiDbem
         hnuY+PF2Rur93nfoQOCrrlp9fw/AheLVs7XiAHm96CRRPpG44Q7XY3SR9iU7IcGXXc01
         I5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVLukVY8dr+w/dBR4UoqA2DL3RaTfGdDj4uKd6NXi5qTJ1cRiKnXligtv8n0O+UEM3BjUXWQw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+h48y4+GIkT0fdCi1MrD+BeEn8hpMopRrv9cIcQBEl6Wl1521
	Z7ctbSIOrJHG1+6lTANlzBcb1WYgOX+Ngt33C2rDsdTnpipnJmi2F9K3SD4itRcCHtvSs4sfqJ1
	OgdDQPqHG03whrJDpE12oKVWhyQgiYjR7+tHqTkc0YFrzeriJRpkg2CLJ2PjYEw==
X-Gm-Gg: ATEYQzxSKCaZUfR3LCR1zg750SJJDTOyEGCL1pYWC6ejXd9AE/HtvoHAMF4hpltch/f
	k57OBv6XM+EbsPyTBjQ7XTWem1KeWlFq4/9krqk2UPBq40/4mE9aLvQmUdYPRX9UACsTXJV2/GT
	sNXU5YrSYqQ4tqRDty2NNZDHZfmPI3a9eP8CxLKK5nK0/DX56463ydP7k1MsdtkvuUeNgUMIn6O
	3wEMl9Lfx5yIXMygyBCsKXQqSl/gC9CG/ZRpcnzJOzpfOWfgZBWxn3Oy2JaBFH/+o/zPCx9xpET
	RoFrTVLvN29mQOrN2Cmzfk6bl/AOvvAQq+ebS1k2w8Bx5uwhobc9HUi5DarBThgpwgX5XNcpVrL
	oWZBGJlCb3zCR6iZ42zm9h1pKZBKgyq6g+A==
X-Received: by 2002:a05:6a00:856:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-82a560c3c4amr3430400b3a.21.1773760160225;
        Tue, 17 Mar 2026 08:09:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:856:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-82a560c3c4amr3430366b3a.21.1773760159619;
        Tue, 17 Mar 2026 08:09:19 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm16993404b3a.39.2026.03.17.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:09:18 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v4][makedumpfile 7/7] Filter amdgpu mm pages
Date: Wed, 18 Mar 2026 04:07:43 +1300
Message-ID: <20260317150743.69590-8-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260317150743.69590-1-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mqo3LYltTtSp_onb-unlsRgin8qGUCwHjOPpwmEq_pY_1773760161
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_080925_425626_36D3115E 
X-CRM114-Status: GOOD (  24.24  )
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
 extensions/amdgpu_filter.c | 190 +++++++++++++++++++++++
 extensions/maple_tree.c    | 307 +++++++++++++++++++++++++++++++++++++
 extensions/maple_tree.h    |   6 +
 4 files changed, 506 insertions(+), 1 deletion(-)
 create mode 100644 extensions/amdgpu_filter.c
 create mode 100644 extensions/maple_tree.c
 create mode 100644 extensions/maple_tree.h

diff --git a/extensions/Makefile b/extensions/Makefile
index b8bbfbc..55b789b 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,8 +1,10 @@
 CC ?= gcc
-CONTRIB_SO :=
+CONTRIB_SO := amdgpu_filter.so
 
 all: $(CONTRIB_SO)
 
+amdgpu_filter.so: maple_tree.c
+
 $(CONTRIB_SO): %.so: %.c
 	$(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
 
diff --git a/extensions/amdgpu_filter.c b/extensions/amdgpu_filter.c
new file mode 100644
index 0000000..3a1e9f2
--- /dev/null
+++ b/extensions/amdgpu_filter.c
@@ -0,0 +1,190 @@
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
+INIT_KERN_STRUCT_MEMBER(task_struct, tasks);
+INIT_KERN_STRUCT_MEMBER(task_struct, mm);
+INIT_KERN_STRUCT_MEMBER(mm_struct, mm_mt);
+INIT_KERN_STRUCT_MEMBER(vm_area_struct, vm_ops);
+INIT_KERN_STRUCT_MEMBER(vm_area_struct, vm_private_data);
+INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_buffer_object, ttm);
+INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, pages);
+INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, num_pages);
+INIT_KERN_STRUCT(page);
+
+INIT_KERN_SYM(init_task);
+INIT_KERN_SYM(vmemmap_base);
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
+		fprintf(stderr, "%s: Can't allocate memory for ft_page_info\n",
+			__func__);
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
+#define KERN_MEMBER_OFF(S, M) \
+	GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
+#define MOD_MEMBER_OFF(MOD, S, M) \
+	GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M) / 8
+
+static void gather_amdgpu_mm_range_info(void)
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
+		readmem(VADDR, list - KERN_MEMBER_OFF(task_struct, tasks) + 
+				KERN_MEMBER_OFF(task_struct, mm),
+			&mm, sizeof(uint64_t));
+		if (!mm) {
+			list = next_list(list);
+			continue;
+		}
+
+		array_out = mt_dump(mm + KERN_MEMBER_OFF(mm_struct, mm_mt), &array_len);
+		if (!array_out)
+			return;
+
+		for (int i = 0; i < array_len; i++) {
+			num_pages = 0;
+			readmem(VADDR, array_out[i] + KERN_MEMBER_OFF(vm_area_struct, vm_ops),
+				&vm_ops, GET_KERN_STRUCT_MEMBER_MSIZE(vm_area_struct, vm_ops));
+			if (vm_ops == amdgpu_gem_vm_ops) {
+				readmem(VADDR, array_out[i] +
+					KERN_MEMBER_OFF(vm_area_struct, vm_private_data),
+					&tbo, GET_KERN_STRUCT_MEMBER_MSIZE(vm_area_struct, vm_private_data));
+				readmem(VADDR, tbo + MOD_MEMBER_OFF(amdgpu, ttm_buffer_object, ttm),
+					&ttm, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_buffer_object, ttm));
+				if (ttm) {
+					readmem(VADDR, ttm + MOD_MEMBER_OFF(amdgpu, ttm_tt, num_pages),
+						&num_pages, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_tt, num_pages));
+					readmem(VADDR, ttm + MOD_MEMBER_OFF(amdgpu, ttm_tt, pages),
+						&pages, GET_MOD_STRUCT_MEMBER_MSIZE(amdgpu, ttm_tt, pages));
+					readmem(VADDR, pages, &pages, sizeof(unsigned long));
+					readmem(VADDR, GET_KERN_SYM(vmemmap_base),
+						&vmemmap_base, sizeof(unsigned long));
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
+	return;
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
+	if (!maple_init()) {
+		goto out;
+	}
+	gather_amdgpu_mm_range_info();
+out:
+	return;
+}
+
+__attribute__((destructor))
+void extension_cleanup(void)
+{
+	do_cleanup(&ft_head_discard);
+}
diff --git a/extensions/maple_tree.c b/extensions/maple_tree.c
new file mode 100644
index 0000000..e367940
--- /dev/null
+++ b/extensions/maple_tree.c
@@ -0,0 +1,307 @@
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
+INIT_OPT_KERN_SYM(mt_slots);
+INIT_OPT_KERN_SYM(mt_pivots);
+
+INIT_OPT_KERN_STRUCT(maple_tree);
+INIT_OPT_KERN_STRUCT(maple_node);
+INIT_OPT_KERN_STRUCT_MEMBER(maple_tree, ma_root);
+INIT_OPT_KERN_STRUCT_MEMBER(maple_node, ma64);
+INIT_OPT_KERN_STRUCT_MEMBER(maple_node, mr64);
+INIT_OPT_KERN_STRUCT_MEMBER(maple_node, slot);
+INIT_OPT_KERN_STRUCT_MEMBER(maple_arange_64, pivot);
+INIT_OPT_KERN_STRUCT_MEMBER(maple_arange_64, slot);
+INIT_OPT_KERN_STRUCT_MEMBER(maple_range_64, pivot);
+INIT_OPT_KERN_STRUCT_MEMBER(maple_range_64, slot);
+
+#define MEMBER_OFF(S, M) \
+	GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
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
+	readmem(VADDR, maple_node_m_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node));
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
+			printf("node %p last (%lu) > max (%lu) at pivot %d!\n",
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
+	readmem(VADDR, maple_node_m_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node));
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
+			printf("node %p last (%lu) > max (%lu) at pivot %d!\n",
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
+	readmem(VADDR, maple_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_node));
+
+	switch (type) {
+	case maple_dense_enum:
+		for (i = 0; i < mt_slots[maple_dense_enum]; i++) {
+			if (min + i > max)
+				printf("OUT OF RANGE: ");
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
+		printf(" UNKNOWN TYPE\n");
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
+	readmem(VADDR, mt, tree_buf, GET_KERN_STRUCT_SSIZE(maple_tree));
+	entry = ULONG(tree_buf + MEMBER_OFF(maple_tree, ma_root));
+
+	if (xa_is_node(entry))
+		mt_dump_node(entry, 0, mt_max[mte_node_type(entry)], 0,
+				&array_out, array_len, &array_cap);
+	else if (entry)
+		mt_dump_entry(entry, 0, 0, 0, &array_out, array_len, &array_cap);
+	else
+		printf("(empty)\n");
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
+		printf("%s: Missing required maple tree syms/types\n",
+			__func__);
+		return false;
+	}
+
+	mt_slots_ptr = GET_KERN_SYM(mt_slots);
+	mt_pivots_ptr = GET_KERN_SYM(mt_pivots);
+
+	if (GET_KERN_STRUCT_SSIZE(maple_tree) > MAPLE_BUFSIZE ||
+	    GET_KERN_STRUCT_SSIZE(maple_node) > MAPLE_BUFSIZE) {
+		printf("%s: MAPLE_BUFSIZE should be larger than maple_node/tree struct\n",
+			__func__);
+		return false;
+	}
+
+	readmem(VADDR, mt_slots_ptr, mt_slots, sizeof(mt_slots));
+	readmem(VADDR, mt_pivots_ptr, mt_pivots, sizeof(mt_pivots));
+
+	mt_max[maple_dense_enum]           = mt_slots[maple_dense_enum];
+	mt_max[maple_leaf_64_enum]         = ULONG_MAX;
+	mt_max[maple_range_64_enum]        = ULONG_MAX;
+	mt_max[maple_arange_64_enum]       = ULONG_MAX;
+
+	return true;
+}
\ No newline at end of file
diff --git a/extensions/maple_tree.h b/extensions/maple_tree.h
new file mode 100644
index 0000000..c96624c
--- /dev/null
+++ b/extensions/maple_tree.h
@@ -0,0 +1,6 @@
+#ifndef _MAPLE_TREE_H
+#define _MAPLE_TREE_H
+#include <stdbool.h>
+unsigned long *mt_dump(unsigned long mt, int *array_len);
+bool maple_init(void);
+#endif /* _MAPLE_TREE_H */
\ No newline at end of file
-- 
2.47.0


