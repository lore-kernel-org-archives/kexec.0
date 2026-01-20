Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49CDD2ED11
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oaudPp54+ZdOHAMPVkS+/ZZZH9OJAfcYClrXQHAl9rI=; b=vXxM+GnfU4a1y1gzQyQd90xhlu
	bnQIIYBim5kif59dHKz7J3BTq6wDuz6JkNECXNNoQ9uygiRlBjoqrx8zkcTQ0rBPTzvZW4UNcgyNw
	mA3y1bJL77OOmyPgPnjyiK2x/SAwcO9vw7OOInVwIOcuyKFr5qb7uAYttUEyT8PnVfyrAi0ZuoDm4
	iUFaCkMpy5LhvKJdfL+yAvMXtFStMHVcxyQz95SxLTTZoscgyAYH9q4WQHqBt2b4cXK8R0rRwb3ya
	kschtChm6ofEPz0fNJNEsLmNI9xtLYfCZpqmRk6uWGUrvYXixuBuJ0jx7HhzbYmoV1D+1LkcvbqG9
	zFFhzHxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2al-000000038B7-3FJU;
	Tue, 20 Jan 2026 03:39:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aj-0000000388w-0SYl
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaudPp54+ZdOHAMPVkS+/ZZZH9OJAfcYClrXQHAl9rI=;
	b=YIAgwkEjb+h6XK4wH1Lih9zytBet3XJE+QtX2XLmOSUKMInnFsumpdTvDbyBS2ngL4SwJP
	oKCcoJdNG1+V5BD2oWcolOJfOwwLC/inBdZ/Du06J+CCAtgNghtNWR8ggSrgDhQlH1ec4O
	6X4wA1dF0qHcZZQRKYg06bVSBJd1t80=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-LthTw8qAO_SwkYEaCqq1ZQ-1; Mon, 19 Jan 2026 22:39:38 -0500
X-MC-Unique: LthTw8qAO_SwkYEaCqq1ZQ-1
X-Mimecast-MFC-AGG-ID: LthTw8qAO_SwkYEaCqq1ZQ_1768880378
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso4807479a91.3
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880378; x=1769485178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaudPp54+ZdOHAMPVkS+/ZZZH9OJAfcYClrXQHAl9rI=;
        b=YenFX4eeKxqBixccWTaQkV/WJg685N1+JdledVXBLSWogxArEz2fIKJlGQOWai3hoz
         hET1oLTn4ykmHwBPf1Swj1jPBnoZ9+Y31E2qiYHhUrE51f8ovYEcg85JbwcmcdbyGqN3
         d7U1on8Dcopq5Wn5E5XByQlu4Pn1ZmzHXHKPA+aH6jRjJ1wroToFvdZlh+ry5Jp29kNR
         xuaMHPJeqesV/urcy3fyEZSFfGjKMdC7sEIVrb3KBcmikhHtjI4zKQII0+G1RD9TJ8OJ
         MC7Pjbgd3b4GoyUPZKnodJRqhhS3becPFTLbaoJeGAqMVB4pT3yAf6ZZJFNSkxO3ttks
         H6xw==
X-Forwarded-Encrypted: i=1; AJvYcCVH470xEqOmQzXVrudDXxiQ+vVdmpdyYvm5mnOG7soPftJD8wYAca/nZCAPB+9JnUarX/BMgQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YybrolNkaqqsfmu5q7BKc3lu4GVb2DJpHNka2C6iPYZSLtZRaAg
	ywz+kO4BcUw4Lp58gxo+ReZyc+sU2UzfmOfslzKGfmk6adFNpFlksdGlLLEuws1V8mo5bC05adU
	WDQdONMDvY5C2yCFwnnssAYrCrNzLxtJ8nH20w1KeCpTkZwJzTy5AkcKchk7g9g==
X-Gm-Gg: AZuq6aI3G/eQI1XFhRutKcBOj+EeuY7HZhUMKpAdC2NRTMI7aL7QhxGzxTzTo1aat3f
	oRvZ9G2opVAOw2hB2eh6M/g7SM8ypSeRa3sP6282KZ+38Dpx0p7w9h0PVE1183SRwkTIYSQyeCf
	jQasdNAr8m2gsG5wayQjOXctunzSPVC/K5UpDOYI6r0KQj4DlbmAZNTEIQlh1fyIf0GzQqtF2lW
	qAkzIfhTjFoB+xUJeL9Q1S8iWjE/sgjoROWACQdvjHKOYQVygk8H+UQ3rAib8H4L3I5yWup75lB
	KkfpV361BSdwKanO+sq1nL4E/bAsDxbQpjlEPNQcEVVUUQXrJUajAKrFCr/iE6X6IYaTyt80Qr1
	eKt90uIV+8N9Soc3/6g==
X-Received: by 2002:a17:90b:4a81:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-35272f19878mr10997848a91.13.1768880377652;
        Mon, 19 Jan 2026 19:39:37 -0800 (PST)
X-Received: by 2002:a17:90b:4a81:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-35272f19878mr10997836a91.13.1768880377228;
        Mon, 19 Jan 2026 19:39:37 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:36 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 7/8] Add maple tree support to makedumpfile extension
Date: Tue, 20 Jan 2026 15:54:59 +1300
Message-ID: <20260120025500.25095-8-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TChZMrlOy1zB5NzIpCJU1bwsdd9IScFVGqlwAzYj-Yw_1768880378
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193941_409322_B98EC6A5 
X-CRM114-Status: GOOD (  22.86  )
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

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 extensions/maple_tree.c | 336 ++++++++++++++++++++++++++++++++++++++++
 extensions/maple_tree.h |   6 +
 2 files changed, 342 insertions(+)
 create mode 100644 extensions/maple_tree.c
 create mode 100644 extensions/maple_tree.h

diff --git a/extensions/maple_tree.c b/extensions/maple_tree.c
new file mode 100644
index 0000000..0cc65bc
--- /dev/null
+++ b/extensions/maple_tree.c
@@ -0,0 +1,336 @@
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
+static int maple_tree_size;
+static int maple_node_size;
+static int maple_tree_ma_root;
+static int maple_tree_ma_flags;
+static int maple_node_parent;
+static int maple_node_ma64;
+static int maple_node_mr64;
+static int maple_node_slot;
+static int maple_arange_64_pivot;
+static int maple_arange_64_slot;
+static int maple_arange_64_gap;
+static int maple_arange_64_meta;
+static int maple_range_64_pivot;
+static int maple_range_64_slot;
+static int maple_metadata_end;
+static int maple_metadata_gap;
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
+	unsigned long *tmp;
+	int new_cap = 0;
+
+	if (entry == 0)
+		return;
+	if (*array_out == NULL) {
+		*array_len = 0;
+		new_cap = 4;
+	} else if (*array_len >= *array_cap) {
+		new_cap = *array_cap + (*array_cap >> 1);
+	}
+
+	if (new_cap) {
+		tmp = reallocarray(*array_out, new_cap, sizeof(unsigned long));
+		if (!tmp)
+			goto no_mem;
+		*array_out = tmp;
+		*array_cap = new_cap;
+	}
+
+	(*array_out)[(*array_len)++] = entry;
+	return;
+
+no_mem:
+	printf("%s: Not enough memory!\n", __func__);
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
+	readmem(VADDR, maple_node_m_node, node_buf, maple_node_size);
+	mr64_buf = node_buf + maple_node_mr64;
+
+	for (i = 0; i < mt_slots[maple_range_64_enum]; i++) {
+		last = max;
+
+		if (i < (mt_slots[maple_range_64_enum] - 1))
+			last = ULONG(mr64_buf + maple_range_64_pivot +
+				     sizeof(ulong) * i);
+
+		else if (!VOID_PTR(mr64_buf + maple_range_64_slot +
+			  sizeof(void *) * i) &&
+			 max != mt_max[mte_node_type(entry)])
+			break;
+		if (last == 0 && i > 0)
+			break;
+		if (leaf)
+			mt_dump_entry(mt_slot((void **)(mr64_buf +
+						      maple_range_64_slot), i),
+				first, last, depth + 1, array_out, array_len, array_cap);
+		else if (VOID_PTR(mr64_buf + maple_range_64_slot +
+				  sizeof(void *) * i)) {
+			mt_dump_node(mt_slot((void **)(mr64_buf +
+						     maple_range_64_slot), i),
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
+	readmem(VADDR, maple_node_m_node, node_buf, maple_node_size);
+	ma64_buf = node_buf + maple_node_ma64;
+
+	for (i = 0; i < mt_slots[maple_arange_64_enum]; i++) {
+		last = max;
+
+		if (i < (mt_slots[maple_arange_64_enum] - 1))
+			last = ULONG(ma64_buf + maple_arange_64_pivot +
+				     sizeof(void *) * i);
+		else if (!VOID_PTR(ma64_buf + maple_arange_64_slot +
+				   sizeof(void *) * i))
+			break;
+		if (last == 0 && i > 0)
+			break;
+
+		if (ULONG(ma64_buf + maple_arange_64_slot + sizeof(void *) * i))
+			mt_dump_node(mt_slot((void **)(ma64_buf +
+						      maple_arange_64_slot), i),
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
+	readmem(VADDR, maple_node, node_buf, maple_node_size);
+
+	switch (type) {
+	case maple_dense_enum:
+		for (i = 0; i < mt_slots[maple_dense_enum]; i++) {
+			if (min + i > max)
+				printf("OUT OF RANGE: ");
+			mt_dump_entry(mt_slot((void **)(node_buf + maple_node_slot), i),
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
+	readmem(VADDR, mt, tree_buf, maple_tree_size);
+	entry = ULONG(tree_buf + maple_tree_ma_root);
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
+#define MAPLE_STRUCT_SIZE(S) \
+	({INIT_STRUCT(S); GET_STRUCT_SSIZE(S);})
+#define MAPLE_STRUCT_MEMBER_OFFSET(S, M) \
+	({INIT_STRUCT_MEMBER(S, M); GET_STRUCT_MEMBER_MOFF(S, M) / 8;})
+
+bool maple_init(void)
+{
+	unsigned long mt_slots_ptr;
+	unsigned long mt_pivots_ptr;
+	struct struct_member_info smi;
+
+	maple_tree_size = MAPLE_STRUCT_SIZE(maple_tree);
+	maple_node_size = MAPLE_STRUCT_SIZE(maple_node);
+	maple_tree_ma_root = MAPLE_STRUCT_MEMBER_OFFSET(maple_tree, ma_root);
+	maple_tree_ma_flags = MAPLE_STRUCT_MEMBER_OFFSET(maple_tree, ma_flags);
+	maple_node_parent = MAPLE_STRUCT_MEMBER_OFFSET(maple_node, parent);
+	maple_node_ma64 = MAPLE_STRUCT_MEMBER_OFFSET(maple_node, ma64);
+	maple_node_mr64 = MAPLE_STRUCT_MEMBER_OFFSET(maple_node, mr64);
+	maple_node_slot = MAPLE_STRUCT_MEMBER_OFFSET(maple_node, slot);
+	maple_arange_64_pivot = MAPLE_STRUCT_MEMBER_OFFSET(maple_arange_64, pivot);
+	maple_arange_64_slot = MAPLE_STRUCT_MEMBER_OFFSET(maple_arange_64, slot);
+	maple_arange_64_gap = MAPLE_STRUCT_MEMBER_OFFSET(maple_arange_64, gap);
+	maple_arange_64_meta = MAPLE_STRUCT_MEMBER_OFFSET(maple_arange_64, meta);
+	maple_range_64_pivot = MAPLE_STRUCT_MEMBER_OFFSET(maple_range_64, pivot);
+	maple_range_64_slot = MAPLE_STRUCT_MEMBER_OFFSET(maple_range_64, slot);
+	maple_metadata_end = MAPLE_STRUCT_MEMBER_OFFSET(maple_metadata, end);
+	maple_metadata_gap = MAPLE_STRUCT_MEMBER_OFFSET(maple_metadata, gap);
+
+	mt_slots_ptr = get_kallsyms_value_by_name("mt_slots");
+	mt_pivots_ptr = get_kallsyms_value_by_name("mt_pivots");
+	if (mt_slots_ptr == 0 || mt_pivots_ptr == 0) {
+		printf("Invalid mt_slots/mt_pivots address\n");
+		return false;
+	}
+	if (maple_tree_size > MAPLE_BUFSIZE ||
+	    maple_node_size > MAPLE_BUFSIZE) {
+		printf("MAPLE_BUFSIZE should be larger than maple_node/tree struct\n");
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


