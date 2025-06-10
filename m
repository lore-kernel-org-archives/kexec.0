Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52960C7113D
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAD/gzuZhalW0VC72/jFzBsNO/FJni6iLuLqDt/wuek=; b=N6ie022GqmrB4glVtNoWjvwCk8
	0CtvDMyNEmoPhG2NkYLe1TWZcV/cGbE11mQpOzANZuW3XjNgfQ5WGkhvmcg5MGOwz2YG+tnRkMDQF
	VvozPCNbB1e/Gk6xQhhltw9CLykdxC9be4oe9w+quccsu6JT7Hhoz1PzOg2YRttt6/KitCa1nQmMq
	i+5d/U/PcDYpv1PQgNQ1snAzyfFab4uA3fK0ro1KZJtYPpP/t21LA0+eI3o+oqam4btUBNxaSsME/
	JJqqPLqYgK+QTmBgj2OIB+mXNcrxI1glu3MMm65bWzzA5FICkSJTL2EbGcg7nNg1kuADYKD+g4/6x
	v/GyADoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwf1-00000006YBB-3RRD;
	Tue, 10 Jun 2025 10:56:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvli-00000006Qg7-1J5s
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 09:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAD/gzuZhalW0VC72/jFzBsNO/FJni6iLuLqDt/wuek=;
	b=CHA0hTqZQQx3VdYOQvsVLAjr1cIMH9QOO4xWJKNg7VPEK56slUsVOD2TgnzdDeMTNPLYzf
	sWOG2l5Zz9X4Vxhdck8eo+JKd7PhTZve0CxFIadgXMzPK3IBl2nvg3RaS+G/XD2sLAyfH6
	HrHyqWcdZPtbl10v7dEjhFV2F0kHGWk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-gwkTQiUGNjysW1FG0Mln1Q-1; Tue, 10 Jun 2025 05:58:17 -0400
X-MC-Unique: gwkTQiUGNjysW1FG0Mln1Q-1
X-Mimecast-MFC-AGG-ID: gwkTQiUGNjysW1FG0Mln1Q_1749549496
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235f6b829cfso37726595ad.2
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549496; x=1750154296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAD/gzuZhalW0VC72/jFzBsNO/FJni6iLuLqDt/wuek=;
        b=ZpVPS8QkyjZC/zg9WULPq0fpw/HZWj42ZtcLc7e30fN4ae9xj4iSPTVN1CKf565u3Z
         EbSBaTwuwFE4vjVBDly5diBjtzJkFleCbFptQXKKxnzbDpjwxbUnjcb/lfDm/3DPsqfW
         Z5+wUoE+t1TOixra0G864oCat6v/4MgBWvm+nqe/5K4JmKTLaWel42qx83EOtczHf278
         HMMh1j5I7lxxgaQErRlcCqSdE6FxAXHNsDiDkni9LF4x5dqHj4yU9Ijj1B3iB6auyXpM
         cLTrkRrWyviLnMLBh2TF4ZSAufORJtsvezG91mIWOc0ZC8mlO3w/wOnvCYzhx+bho+qn
         6XOg==
X-Forwarded-Encrypted: i=1; AJvYcCXCWf4gUeHHyS/FFncAqOKubpX710IEY1AGdSCAJOLmU/sMQQGTFtc4BazgMnMnVm0iilZaTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyrHdg5IIqa5g3YD6MFYtBfa7/DcZBbf9ulFkUy4NYIwK5JbaYB
	TqdSl1aJoA6aAtDzJZwtrSJLcMBQ0lF+S+jlBGoGmkHYfYld3MPS8Ex+rOqL+PO710y24EHKKXp
	/u1/C73Zm6UY8YNT5Mic7pHaJZ30hTqAEjieI6dht7F6bM1VIFzyFhVcNJ1EluSnPxtcjAg==
X-Gm-Gg: ASbGncuw0HZt9LRQjk3S0NeAnOE2fCct9ehbgJEZMb7SoLS+0ce18aUNGg87F9GW1Fr
	NWuou6eVMuljN5U0eFulpnm39Xo5HgmGdhwQmpgoEh7qhQvfubR447vzRKYiBz/mVsy2+hYBy3i
	Ny/Flqy2SQN5uD6q95/SwQx0Xz9VU7/FGCSMSdut8wrVg9rBtB7qKaEEt0NtdmTOPucj30YEBZj
	ST+DzWztvjIgD2RY5frQC+p8xA0km5GX4tq2MwpuTDyx/XWnDHuoZm6PEzo+uhSG5f/7SEtKBGm
	H5tgdgd/cwexjrhzFA2TAjHGp0eRa18=
X-Received: by 2002:a17:902:d48d:b0:234:a139:120d with SMTP id d9443c01a7336-23601cf1e13mr212328195ad.7.1749549496157;
        Tue, 10 Jun 2025 02:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVyU3VIGl1MuMaf9lKZu2CRVO1+kvcAQZy5UryMxv+vvMYrriDOSWTChEwtFhkp1NCdNOEJw==
X-Received: by 2002:a17:902:d48d:b0:234:a139:120d with SMTP id d9443c01a7336-23601cf1e13mr212327895ad.7.1749549495693;
        Tue, 10 Jun 2025 02:58:15 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:15 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 06/10] Port the maple tree data structures and functions
Date: Tue, 10 Jun 2025 21:57:39 +1200
Message-ID: <20250610095743.18073-7-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oU_2bOrYp7IHr_qF_HQLNu3Ro7IDC1QSV76Hvej2A1U_1749549496
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_025946_517431_E699DCC1 
X-CRM114-Status: GOOD (  25.67  )
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

The majority of maple tree code is copied from crash utility. Since currenty
it is not needed by makedumpfile, maple tree is integrated with eppic
extension only.

The minor change of maple tree code are:
1) a cache buffer for maple tree data because eppic script cannot allocate
   a buffer currently;
2) an interface for eppic script.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile      |   4 +-
 eppic_maple.c | 431 ++++++++++++++++++++++++++++++++++++++++++++++++++
 eppic_maple.h |   8 +
 3 files changed, 441 insertions(+), 2 deletions(-)
 create mode 100644 eppic_maple.c
 create mode 100644 eppic_maple.h

diff --git a/Makefile b/Makefile
index fbc9f5b..216749f 100644
--- a/Makefile
+++ b/Makefile
@@ -121,8 +121,8 @@ makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
 	     -e "s/@VERSION@/$(VERSION)/" \
 	     $(VPATH)makedumpfile.conf.5.in > $(VPATH)makedumpfile.conf.5
 
-eppic_makedumpfile.so: extension_eppic.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -rdynamic -o $@ extension_eppic.c -fPIC -leppic -ltinfo
+eppic_makedumpfile.so: extension_eppic.c eppic_maple.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -rdynamic -o $@ $^ -fPIC -leppic -ltinfo
 
 clean:
 	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
diff --git a/eppic_maple.c b/eppic_maple.c
new file mode 100644
index 0000000..ee8d23d
--- /dev/null
+++ b/eppic_maple.c
@@ -0,0 +1,431 @@
+
+#include <stdbool.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <assert.h>
+#include "makedumpfile.h"
+#include "extension_eppic.h"
+#include "btf.h"
+#include "kallsyms.h"
+#include "erase_info.h"
+
+enum maple_type {
+	maple_dense,
+	maple_leaf_64,
+	maple_range_64,
+	maple_arange_64,
+};
+
+#define MAPLE_TREE_COUNT   (1)
+#define MAPLE_TREE_SEARCH  (2)
+#define MAPLE_TREE_DUMP    (3)
+#define MAPLE_TREE_GATHER  (4)
+#define MAPLE_TREE_DUMP_CB (5)
+
+#define MAPLE_NODE_MASK		255UL
+#define MT_FLAGS_HEIGHT_OFFSET	0x02
+#define MT_FLAGS_HEIGHT_MASK	0x7C
+#define MAPLE_NODE_TYPE_MASK	0x0F
+#define MAPLE_NODE_TYPE_SHIFT	0x03
+#define MAPLE_BUFSIZE		512
+
+static unsigned char *mt_slots = NULL;
+
+static ulong mt_max[4] = {0};
+
+static long g_maple_tree;
+static long g_maple_node;
+static long g_maple_tree_ma_root;
+static long g_maple_node_ma64;
+static long g_maple_node_mr64;
+static long g_maple_node_slot;
+static long g_maple_arange_64_pivot;
+static long g_maple_arange_64_slot;
+static long g_maple_range_64_pivot;
+static long g_maple_range_64_slot;
+
+/********************maple tree internal**************************/
+
+static inline bool xa_is_internal(ulong entry)
+{
+	return (entry & 3) == 2;
+}
+
+static inline bool xa_is_node(ulong entry)
+{
+	return xa_is_internal(entry) && entry > 4096;
+}
+
+static inline ulong mte_to_node(ulong maple_enode_entry)
+{
+	return maple_enode_entry & ~MAPLE_NODE_MASK;
+}
+
+static inline enum maple_type mte_node_type(ulong maple_enode_entry)
+{
+	return (maple_enode_entry >> MAPLE_NODE_TYPE_SHIFT) &
+		MAPLE_NODE_TYPE_MASK;
+}
+
+static inline ulong mt_slot(void **slots, unsigned char offset)
+{
+	return (ulong)slots[offset];
+}
+
+static inline bool ma_is_leaf(const enum maple_type type)
+{
+	return type < maple_range_64;
+}
+
+struct do_maple_tree_info {
+	ulong count;
+	void *data;
+};
+
+struct maple_tree_ops {
+	void (*entry)(ulong node, void *private);
+	void *private;
+};
+
+static void do_mt_range64(ulong, ulong, ulong,
+			  struct maple_tree_ops *);
+static void do_mt_arange64(ulong, ulong, ulong,
+			   struct maple_tree_ops *);
+static void do_mt_entry(ulong, struct maple_tree_ops *);
+static void do_mt_node(ulong, ulong, ulong,
+		       struct maple_tree_ops *);
+
+static inline bool mte_is_leaf(ulong maple_enode_entry)
+{
+       return ma_is_leaf(mte_node_type(maple_enode_entry));
+}
+
+static void do_mt_range64(ulong entry, ulong min, ulong max,
+			  struct maple_tree_ops *ops)
+{
+	ulong maple_node_m_node = mte_to_node(entry);
+	char node_buf[MAPLE_BUFSIZE];
+	bool leaf = mte_is_leaf(entry);
+	ulong first = min, last;
+	int i;
+	char *mr64_buf;
+
+	READMEM(VADDR, maple_node_m_node, node_buf, g_maple_node);
+
+	mr64_buf = node_buf + g_maple_node_mr64;
+
+	for (i = 0; i < mt_slots[maple_range_64]; i++) {
+		last = max;
+
+		if (i < (mt_slots[maple_range_64] - 1))
+			last = ULONG(mr64_buf + g_maple_range_64_pivot +
+				     sizeof(ulong) * i);
+
+		else if (!VOID_PTR(mr64_buf + g_maple_range_64_slot +
+			  sizeof(void *) * i) &&
+			 max != mt_max[mte_node_type(entry)])
+			break;
+		if (last == 0 && i > 0)
+			break;
+		if (leaf)
+			do_mt_entry(mt_slot((void **)(mr64_buf +
+						      g_maple_range_64_slot), i),
+				    ops);
+		else if (VOID_PTR(mr64_buf + g_maple_range_64_slot +
+				  sizeof(void *) * i)) {
+			do_mt_node(mt_slot((void **)(mr64_buf +
+						     g_maple_range_64_slot), i),
+				   first, last, ops);
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
+static void do_mt_arange64(ulong entry, ulong min, ulong max,
+			   struct maple_tree_ops *ops)
+{
+	ulong maple_node_m_node = mte_to_node(entry);
+	char node_buf[MAPLE_BUFSIZE];
+	bool leaf = mte_is_leaf(entry);
+	ulong first = min, last;
+	int i;
+	char *ma64_buf;
+
+	READMEM(VADDR, maple_node_m_node, node_buf, g_maple_node);
+
+	ma64_buf = node_buf + g_maple_node_ma64;
+
+	for (i = 0; i < mt_slots[maple_arange_64]; i++) {
+		last = max;
+
+		if (i < (mt_slots[maple_arange_64] - 1))
+			last = ULONG(ma64_buf + g_maple_arange_64_pivot +
+				     sizeof(ulong) * i);
+		else if (!VOID_PTR(ma64_buf + g_maple_arange_64_slot +
+				   sizeof(void *) * i))
+			break;
+		if (last == 0 && i > 0)
+			break;
+
+		if (leaf)
+			do_mt_entry(mt_slot((void **)(ma64_buf +
+						      g_maple_arange_64_slot), i),
+				    ops);
+		else if (VOID_PTR(ma64_buf + g_maple_arange_64_slot +
+				  sizeof(void *) * i)) {
+			do_mt_node(mt_slot((void **)(ma64_buf +
+						     g_maple_arange_64_slot), i),
+				   first, last, ops);
+		}
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
+static void do_mt_entry(ulong entry, struct maple_tree_ops *ops)
+{
+	if (ops->entry && entry)
+		ops->entry(entry, ops->private);
+}
+
+static void do_mt_node(ulong entry, ulong min, ulong max,
+		       struct maple_tree_ops *ops)
+{
+	ulong maple_node = mte_to_node(entry);
+	int i, type = mte_node_type(entry);
+	char node_buf[MAPLE_BUFSIZE];
+
+	READMEM(VADDR, maple_node, node_buf, g_maple_node);
+
+	switch (type) {
+	case maple_dense:
+		for (i = 0; i < mt_slots[maple_dense]; i++) {
+			if (min + i > max)
+				printf("OUT OF RANGE: ");
+			do_mt_entry(mt_slot((void **)(node_buf + 
+				g_maple_node_slot), i), ops);
+		}
+		break;
+	case maple_leaf_64:
+	case maple_range_64:
+		do_mt_range64(entry, min, max, ops);
+		break;
+	case maple_arange_64:
+		do_mt_arange64(entry, min, max, ops);
+		break;
+	default:
+		printf(" UNKNOWN TYPE\n");
+	}
+}
+
+static int do_maple_tree_traverse(ulong ptr, struct maple_tree_ops *ops)
+{
+	char tree_buf[MAPLE_BUFSIZE];
+	ulong entry;
+
+	assert(MAPLE_BUFSIZE >= g_maple_tree);
+
+	READMEM(VADDR, ptr, tree_buf, g_maple_tree);
+	entry = ULONG(tree_buf + g_maple_tree_ma_root);
+
+	if (!xa_is_node(entry))
+		do_mt_entry(entry, ops);
+	else if (entry) {
+		do_mt_node(entry, 0, mt_max[mte_node_type(entry)], ops);
+	}
+
+	return 0;
+}
+
+static void do_maple_tree_count(ulong node, void *private)
+{
+	struct do_maple_tree_info *info = private;
+	info->count++;
+}
+
+static void do_maple_tree_gather(ulong node, void *private)
+{
+	struct do_maple_tree_info *info = private;
+	ulong *buf = info->data;
+
+	buf[info->count] = node;
+	info->count++;
+}
+
+static ulong do_maple_tree(ulong root, int flag, ulong *buf)
+{
+	struct do_maple_tree_info info = {
+		.count		= 0,
+		.data		= buf,
+	};
+	struct maple_tree_ops ops = {
+		.private	= &info,
+	};
+
+	switch (flag)
+	{
+	case MAPLE_TREE_COUNT:
+		ops.entry = do_maple_tree_count;
+		break;
+
+	case MAPLE_TREE_GATHER:
+		ops.entry = do_maple_tree_gather;
+		break;
+
+	default:
+		fprintf(stderr, "do_maple_tree: invalid flag: %x\n", flag);
+		return 0;
+	}
+
+	do_maple_tree_traverse(root, &ops);
+	return info.count;
+}
+
+#define MAPLE_SIZE_INIT(X, Y) \
+do { \
+	if (is_btf) { \
+		if ((X = cb->get_type_size_by_name(Y, BTF_KIND_STRUCT, NULL)) \
+			== 0) \
+			return FALSE; \
+	} else { \
+		if ((X = cb->get_structure_size(Y, DWARF_INFO_GET_STRUCT_SIZE)) \
+			== FAILED_DWARFINFO) \
+			return FALSE; \
+	} \
+} while (0)
+
+#define MAPLE_OFFSET_INIT(X, Y, Z) \
+do { \
+	if (is_btf) { \
+		struct member_info mi; \
+		memset(&mi, 0, sizeof(mi)); \
+		if (cb->get_struct_member_by_name(Y, Z, &mi) == 0) \
+			return FALSE; \
+		X = mi.bit_pos / 8; \
+	} else { \
+		if ((X = cb->get_member_offset(Y, Z, DWARF_INFO_GET_MEMBER_OFFSET)) \
+		== FAILED_DWARFINFO) \
+			return FALSE; \
+	} \
+} while (0)
+
+/*******************maple tree api***************************/
+
+int maple_init(bool is_btf)
+{
+	int array_len = 16;
+
+	MAPLE_SIZE_INIT(g_maple_tree, "maple_tree");
+	MAPLE_SIZE_INIT(g_maple_node, "maple_node");
+	MAPLE_OFFSET_INIT(g_maple_tree_ma_root, "maple_tree", "ma_root");
+	MAPLE_OFFSET_INIT(g_maple_node_ma64, "maple_node", "ma64");
+	MAPLE_OFFSET_INIT(g_maple_node_mr64, "maple_node", "mr64");
+	MAPLE_OFFSET_INIT(g_maple_node_slot, "maple_node", "slot");
+	MAPLE_OFFSET_INIT(g_maple_arange_64_pivot, "maple_arange_64", "pivot");
+	MAPLE_OFFSET_INIT(g_maple_arange_64_slot, "maple_arange_64", "slot");
+	MAPLE_OFFSET_INIT(g_maple_range_64_pivot, "maple_range_64", "pivot");
+	MAPLE_OFFSET_INIT(g_maple_range_64_slot, "maple_range_64", "slot");
+	mt_slots = calloc(array_len, sizeof(char));
+	if (!mt_slots) {
+		fprintf(stderr, "%s: Not enough memory!\n", __func__);
+		return FALSE;
+	}
+	if (is_btf) {
+		READMEM(VADDR, cb->get_kallsyms_value_by_name("mt_slots"),
+			mt_slots, array_len * sizeof(char));
+	} else {
+		READMEM(VADDR, cb->get_symbol_addr_all("mt_slots"),
+			mt_slots, array_len * sizeof(char));	
+	}
+
+	mt_max[maple_dense]           = mt_slots[maple_dense];
+	mt_max[maple_leaf_64]         = ULONG_MAX;
+	mt_max[maple_range_64]        = ULONG_MAX;
+	mt_max[maple_arange_64]       = ULONG_MAX;
+	return TRUE;
+}
+
+#define MAPLE_CACHE 16
+
+static struct maple_cache {
+	uint64_t tree;
+	uint64_t hits;
+	int elems_count;
+	uint64_t *elems;
+} maple_cache[MAPLE_CACHE] = {0};
+
+static VALUE_S *maple_tree(VALUE_S *ep_tree, int cmd, VALUE_S *ep_index)
+{
+	uint64_t tree = eppic_getval(ep_tree);
+	int index = eppic_getval(ep_index);
+	int found = -1, target = -1;
+	int min_hits = 0;
+	for (int i = 0; i < MAPLE_CACHE; i++) {
+		min_hits = maple_cache[i].hits < maple_cache[min_hits].hits ?
+				i : min_hits;
+		if (tree == maple_cache[i].tree) {
+			found = i;
+		}
+	}
+
+	if (found >= 0) {
+		maple_cache[found].hits++;
+		target = found;
+	} else {
+		target = min_hits;
+	}
+
+	switch (cmd)
+	{
+	case MAPLE_TREE_COUNT:
+		if (found < 0) {
+			if (maple_cache[target].elems) {
+				free(maple_cache[target].elems);
+				memset(&maple_cache[target], 0, sizeof(struct maple_cache));
+			}
+			found = do_maple_tree(tree, MAPLE_TREE_COUNT, NULL);
+			maple_cache[target].elems = malloc(found * sizeof(u_int64_t));
+			do_maple_tree(tree, MAPLE_TREE_GATHER, maple_cache[target].elems);
+			maple_cache[target].elems_count = found;
+			return eppic_makebtype(found);
+		} else {
+			return eppic_makebtype(maple_cache[target].elems_count);
+		}
+	case MAPLE_TREE_GATHER:
+		if (index > maple_cache[target].elems_count) {
+			printf("Invalid maple index %d(> %d) for tree %lx\n",
+				index, maple_cache[target].elems_count, tree);
+			return eppic_makebtype(0);
+		}
+		return eppic_makebtype(maple_cache[target].elems[index]);
+	default:
+		return eppic_makebtype(0);
+	}
+}
+
+VALUE_S *
+maple_count(VALUE_S *ep_tree)
+{
+	return maple_tree(ep_tree, MAPLE_TREE_COUNT, NULL);
+}
+
+VALUE_S *
+maple_elem(VALUE_S *ep_tree, VALUE_S *ep_index)
+{
+	return maple_tree(ep_tree, MAPLE_TREE_GATHER, ep_index);
+}
diff --git a/eppic_maple.h b/eppic_maple.h
new file mode 100644
index 0000000..61bb32f
--- /dev/null
+++ b/eppic_maple.h
@@ -0,0 +1,8 @@
+#ifndef _EPPIC_MAPLE_H
+#define _EPPIC_MAPLE_H
+#include "makedumpfile.h"
+int maple_init(bool);
+VALUE_S *maple_count(VALUE_S *);
+VALUE_S *maple_elem(VALUE_S *, VALUE_S *);
+#endif /*_EPPIC_MAPLE_H*/
+
-- 
2.47.0


