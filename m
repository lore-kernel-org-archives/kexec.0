Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2B5CCD1A2
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CZuIVA/NmX+X5f0bZLt3zzvvOjW1oAg7s1Y+9B4m94=; b=OvuGSIKApL6KrGTKLlBB0xnwFS
	rCAdattozoXhJSSY4ogL2i6kDDDgmyABiDlyRRpxJXlEb4LkT9zisUU3orpcIbCEgp3O8eysEiobK
	uePDqBnPmT8S+NFub1GXB0z4wktCyjh8ohu+JWT7Vj6mw6MZr/rlL2uuC42xkFBEjXJC1AMWFh4uP
	noi7tvjVYs06Wy6YsLCepn0nAHHOMKCJJGZ6JGG5vVj7J0AComMl3RthA/geiYWd4ls1j0ss7UAPy
	7JhNtjKvmH21V+6ums06/RRy5dGTw68FUc8rmYMvKJvIl0Vlzh9JAJxv3n0AgMbwDAx43Qju86Epy
	IoULq6uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyJW-0000000FB7t-2Mhk;
	Mon, 20 Oct 2025 22:25:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyJT-0000000FB6n-44B6
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:25:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CZuIVA/NmX+X5f0bZLt3zzvvOjW1oAg7s1Y+9B4m94=;
	b=D6LBDxZfX6h9KeipaZIsJYixiLGRUnOuKRh5j29Jadppps2TmVHsZ8Jw/d+hCb80I/1dGb
	Q++OnBNRIfjICV2Ao30e/fx7aUJmQWefmOxJyBcwZMUwFow1kiDwl6QUq6UHP2AxRpHAXl
	1iNRdBBQI/ovBAshQhDrJrm5qav9w0Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-IowNOCXwPWaqVa2OJt7pEg-1; Mon, 20 Oct 2025 18:25:09 -0400
X-MC-Unique: IowNOCXwPWaqVa2OJt7pEg-1
X-Mimecast-MFC-AGG-ID: IowNOCXwPWaqVa2OJt7pEg_1760999108
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-780fb254938so4059517b3a.0
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999108; x=1761603908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CZuIVA/NmX+X5f0bZLt3zzvvOjW1oAg7s1Y+9B4m94=;
        b=BkF7PHhcKjTViSl8BxLkepYLwLwEHwuPBXlUfReOkO9pS2VAlD0hzTKysXVKvMDA/L
         tI/fk+H5Ibfk/FM4HztxPK4JvwG5s5FDOb97Vkgb9FLx+M9u8VxFuWeWdSzqMxawKOto
         jxVLNQeozdRP/+Az2eXzmmVhRlU/dG33rJxK2R1LVtFrXThJTYI3UfEbRWk3TZVe5o1q
         rTCIBgyHuIoUvUe46bCNVyZUFJwGtngVS8G6b2drx7fnHUCzqfM4cjbAFBY7bxGBETJE
         XhOaiL7emgxa7tvh8aKSb5RApN4KjPvMPxQzUVKWD6AxnLyHuu8+wpJg7r4bru3J7ODg
         2ocw==
X-Forwarded-Encrypted: i=1; AJvYcCVh9OaLFU90JsrNdxUuDrfEowQncInDDR/ym4IbZbZgikMA6fM6dzMrBm78MksGYoZEqjMvOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxm6pxDYxuIhfVwpoas7wPK3Ya1Y155txheqePjuBG7CknsjLUC
	KOA7oXtqgQw65ACnuPEt3zChBZF8qlt/FMOcbiFWnTUQTprQ6F1DnGN5kYLPXl2hGiAgbPDSmF4
	FJh/oGB9U06sy+WHtU9SI0Mp17nEVJXL4zAkIAi5f1epgakJRkDgq2bEQ37Yery+oLK1TJA==
X-Gm-Gg: ASbGncsGE6A5Gf2+0aU2yg1D0C4q94GhkantqFTHFVwmUCdmwtx7aiz+d9ZQaa4nW3c
	CaWKTRmlQOzZERCn07FooyZb4f5d/rnYWL3pJ4YcYmcNgF/5JL9FRJyTmRVut7VVRobdn3Ry0SA
	OPl7KkXdFYGNYx7p0xwGp9LXZxqDi7rDXGPFpfKMxC1u81aihvInbMqHUVGuwrxnnE2QeG17Mpp
	L9kbPqupI+a20wRlDFsfbVu2eqjABWt7vgqepz5SrGNGQHKcplWJN89GUubexpN81UwN31lVWTQ
	wvwc/PeWw8wIh3d1kV7I9jAawGl46oNZ4CQBp5vCQPPy3KMnDyF49wI/vl2FGGjODL6D4rtu10g
	f0jpuMYhIvMiykp/XhraW+ZTBSPccbw1uMP0rswoaytA=
X-Received: by 2002:a05:6a00:228a:b0:780:fb3f:9127 with SMTP id d2e1a72fcca58-7a220accee8mr15822700b3a.19.1760999107963;
        Mon, 20 Oct 2025 15:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhJnxOTPf3+/axjXskFrPgLcF6BBQsVdvYEAwbfAzHOzH+AEbmym1OTVUT9TuPTC1M2Kkl9w==
X-Received: by 2002:a05:6a00:228a:b0:780:fb3f:9127 with SMTP id d2e1a72fcca58-7a220accee8mr15822679b3a.19.1760999107487;
        Mon, 20 Oct 2025 15:25:07 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:07 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 14/14] Introducing 2 eppic scripts to test the dwarf/btf eppic extension
Date: Tue, 21 Oct 2025 11:24:10 +1300
Message-ID: <20251020222410.8235-15-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b50G-VBsTb_Rvl0UEBaHW8gNQZA2uTb97pFCzS_ITbs_1760999108
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152512_195284_2572822D 
X-CRM114-Status: GOOD (  21.14  )
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

This patch will introduce 2 eppic scripts. One is for filtering out amdgpu
mm pages, the other is for printing all tasks VMAs. dwarf & btf eppic
extension should produce the same result for every eppic script, mainly
for test use.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 eppic_scripts/filter_amdgpu_mm_pages.c | 255 +++++++++++++++++++++++++
 eppic_scripts/print_all_vma.c          | 244 +++++++++++++++++++++++
 2 files changed, 499 insertions(+)
 create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
 create mode 100644 eppic_scripts/print_all_vma.c

diff --git a/eppic_scripts/filter_amdgpu_mm_pages.c b/eppic_scripts/filter_amdgpu_mm_pages.c
new file mode 100644
index 0000000..8fe6d52
--- /dev/null
+++ b/eppic_scripts/filter_amdgpu_mm_pages.c
@@ -0,0 +1,255 @@
+enum {
+	maple_dense_enum,
+	maple_leaf_64_enum,
+	maple_range_64_enum,
+	maple_arange_64_enum,
+};
+
+#define MAPLE_NODE_MASK		255UL
+#define MAPLE_NODE_TYPE_MASK	0x0F
+#define MAPLE_NODE_TYPE_SHIFT	0x03
+#define XA_ZERO_ENTRY		xa_mk_internal(257)
+#define bool			int
+
+unsigned long mt_max;
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
+static struct maple_node *mte_to_node(void *entry)
+{
+        return (struct maple_node *)((unsigned long)entry & ~MAPLE_NODE_MASK);
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
+	return *((unsigned long *)slots + offset);
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
+			unsigned long max, unsigned int depth, unsigned long array_out)
+{
+	int i;
+	if (entry == 0)
+		return;
+	for (i in array_out) {
+		if (array_out[i] == 0) {
+			array_out[i] = entry;
+			return;
+		}
+	}
+	array_out[i + 1] = entry;
+}
+
+static void mt_dump_range64(void *entry, unsigned long min,
+			unsigned long max, unsigned int depth, unsigned long array_out)
+{
+	struct maple_range_64 *node = &mte_to_node(entry)->mr64;
+
+	bool leaf = mte_is_leaf((unsigned long)entry);
+	unsigned long first = min;
+	int i;
+
+	for (i = 0; i < *((char *)(&mt_slots) + maple_range_64_enum); i++) {
+		unsigned long last = max;
+
+		if (i < (*((char *)(&mt_slots) + maple_range_64_enum) - 1))
+			last  = *((unsigned long *)&(node->pivot) + i);
+		else if (!*((unsigned long *)&(node->slot) + i) &&
+			max != mt_max[mte_node_type((unsigned long)entry)])
+			break;
+		if (last == 0 && i > 0)
+			break;
+		if (leaf)
+			mt_dump_entry(mt_slot(&(node->slot), i),
+					first, last, depth + 1, array_out);
+		else if (*((unsigned long *)&(node->slot) + i))
+			mt_dump_node(mt_slot(&(node->slot), i),
+					first, last, depth + 1, array_out);
+
+		if (last == max)
+			break;
+		if (last > max) {
+			printf("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				node, last, max, i);
+			break;
+		}
+		first = last + 1;
+	}
+}
+
+static void mt_dump_arange64(void *entry, unsigned long min,
+				unsigned long max, unsigned int depth, unsigned long array_out)
+{
+	struct maple_arange_64 *node = &mte_to_node(entry)->ma64;
+	unsigned long first = min;
+	int i;
+
+	for (i = 0; i < *((char *)(&mt_slots) + maple_arange_64_enum); i++) {
+		unsigned long last = max;
+		if (i < (*((char *)(&mt_slots) + maple_arange_64_enum) - 1))
+			last  = *((unsigned long *)&(node->pivot) + i);
+		else if (!*((unsigned long *)&(node->slot) + i))
+			break;
+		if (last == 0 && i > 0)
+			break;
+		if (*((unsigned long *)&(node->slot) + i))
+			mt_dump_node((void *)mt_slot(&(node->slot), i),
+					first, last, depth + 1, array_out);
+
+		if (last == max)
+			break;
+		if (last > max) {
+			printf("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				node, last, max, i);
+			break;
+		}
+		first = last + 1;
+	}
+}
+
+static void mt_dump_node(void *entry, unsigned long min,
+			unsigned long max, unsigned int depth, unsigned long array_out)
+{
+	struct maple_node *node = mte_to_node(entry);
+	unsigned int type = mte_node_type((unsigned long)entry);
+	unsigned int i;
+
+	switch (type) {
+	case maple_dense_enum:
+		for (i = 0; i < *((char *)(&mt_slots) + maple_dense_enum); i++) {
+			if (min + i > max)
+				printf("OUT OF RANGE: ");
+			mt_dump_entry(mt_slot(&(node->slot), i),
+					min + i, min + i, depth, array_out);
+		}
+		break;
+	case maple_leaf_64_enum:
+	case maple_range_64_enum:
+		mt_dump_range64(entry, min, max, depth, array_out);
+		break;
+	case maple_arange_64_enum:
+		mt_dump_arange64(entry, min, max, depth, array_out);
+		break;
+
+	default:
+		printf(" UNKNOWN TYPE\n");
+	}
+}
+
+void mt_dump(const struct maple_tree *mt, unsigned long array_out)
+{
+	unsigned long entry = (unsigned long)(mt->ma_root);
+
+	/* init mt_max array */
+	mt_max[maple_dense_enum]           = *((char *)(&mt_slots) + maple_dense_enum);
+	mt_max[maple_leaf_64_enum]         = (unsigned long)(-1);
+	mt_max[maple_range_64_enum]        = (unsigned long)(-1);
+	mt_max[maple_arange_64_enum]       = (unsigned long)(-1);
+	/* done */
+
+	if (xa_is_node(entry))
+		mt_dump_node((void *)entry, 0, mt_max[mte_node_type(entry)], 0, array_out);
+	else if (entry)
+		mt_dump_entry((void *)entry, 0, 0, 0, array_out);
+	else
+		printf("(empty)\n");
+}
+
+int main()
+{
+	struct task_struct *p;
+	unsigned long p_off;
+	int i, c;
+	struct vm_area_struct *vma;
+	struct ttm_buffer_object *tbo;
+	unsigned long pfn, num;
+	struct maple_tree *mt;
+	unsigned long tmp;
+
+	p = (struct task_struct *)&init_task;
+	p_off = (unsigned long)&(p->tasks) - (unsigned long)p;
+
+	do {
+		unsigned long array_out;
+		array_out[0] = 0;
+
+		if (!(p->mm)) {
+			p = (struct task_struct *)
+				((unsigned long)(p->tasks.next) - p_off);
+			continue;
+		}
+
+		mt = &(p->mm->mm_mt);
+
+		mt_dump(mt, array_out);
+
+		for (i in array_out) {
+			if (((struct vm_area_struct *)array_out[i])->vm_ops ==
+			    &amdgpu_gem_vm_ops) {
+				    tbo = (struct ttm_buffer_object *)
+				    (((struct vm_area_struct *)array_out[i])->
+				    vm_private_data);
+				if (tbo->ttm) {
+					num = (unsigned long)(tbo->ttm->num_pages);
+					pfn = ((unsigned long)(tbo->ttm->pages[0]) -
+						*(unsigned long *)&vmemmap_base) /
+					      sizeof(struct page);
+					filter_pages(pfn, num);
+				}
+			}
+		}
+		p = (struct task_struct *)
+			((unsigned long)(p->tasks.next) - p_off);
+	} while(p != &init_task);
+
+	return 0;
+}
diff --git a/eppic_scripts/print_all_vma.c b/eppic_scripts/print_all_vma.c
new file mode 100644
index 0000000..f100c78
--- /dev/null
+++ b/eppic_scripts/print_all_vma.c
@@ -0,0 +1,244 @@
+enum {
+	maple_dense_enum,
+	maple_leaf_64_enum,
+	maple_range_64_enum,
+	maple_arange_64_enum,
+};
+
+#define MAPLE_NODE_MASK		255UL
+#define MAPLE_NODE_TYPE_MASK	0x0F
+#define MAPLE_NODE_TYPE_SHIFT	0x03
+#define XA_ZERO_ENTRY		xa_mk_internal(257)
+#define bool			int
+
+unsigned long mt_max;
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
+static struct maple_node *mte_to_node(void *entry)
+{
+        return (struct maple_node *)((unsigned long)entry & ~MAPLE_NODE_MASK);
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
+	return *((unsigned long *)slots + offset);
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
+			unsigned long max, unsigned int depth, unsigned long array_out)
+{
+	int i;
+	if (entry == 0)
+		return;
+	for (i in array_out) {
+		if (array_out[i] == 0) {
+			array_out[i] = entry;
+			return;
+		}
+	}
+	array_out[i + 1] = entry;
+}
+
+static void mt_dump_range64(void *entry, unsigned long min,
+			unsigned long max, unsigned int depth, unsigned long array_out)
+{
+	struct maple_range_64 *node = &mte_to_node(entry)->mr64;
+
+	bool leaf = mte_is_leaf((unsigned long)entry);
+	unsigned long first = min;
+	int i;
+
+	for (i = 0; i < *((char *)(&mt_slots) + maple_range_64_enum); i++) {
+		unsigned long last = max;
+
+		if (i < (*((char *)(&mt_slots) + maple_range_64_enum) - 1))
+			last  = *((unsigned long *)&(node->pivot) + i);
+		else if (!*((unsigned long *)&(node->slot) + i) &&
+			max != mt_max[mte_node_type((unsigned long)entry)])
+			break;
+		if (last == 0 && i > 0)
+			break;
+		if (leaf)
+			mt_dump_entry(mt_slot(&(node->slot), i),
+					first, last, depth + 1, array_out);
+		else if (*((unsigned long *)&(node->slot) + i))
+			mt_dump_node(mt_slot(&(node->slot), i),
+					first, last, depth + 1, array_out);
+
+		if (last == max)
+			break;
+		if (last > max) {
+			printf("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				node, last, max, i);
+			break;
+		}
+		first = last + 1;
+	}
+}
+
+static void mt_dump_arange64(void *entry, unsigned long min,
+				unsigned long max, unsigned int depth, unsigned long array_out)
+{
+	struct maple_arange_64 *node = &mte_to_node(entry)->ma64;
+	unsigned long first = min;
+	int i;
+
+	for (i = 0; i < *((char *)(&mt_slots) + maple_arange_64_enum); i++) {
+		unsigned long last = max;
+		if (i < (*((char *)(&mt_slots) + maple_arange_64_enum) - 1))
+			last  = *((unsigned long *)&(node->pivot) + i);
+		else if (!*((unsigned long *)&(node->slot) + i))
+			break;
+		if (last == 0 && i > 0)
+			break;
+		if (*((unsigned long *)&(node->slot) + i))
+			mt_dump_node((void *)mt_slot(&(node->slot), i),
+					first, last, depth + 1, array_out);
+
+		if (last == max)
+			break;
+		if (last > max) {
+			printf("node %p last (%lu) > max (%lu) at pivot %d!\n",
+				node, last, max, i);
+			break;
+		}
+		first = last + 1;
+	}
+}
+
+static void mt_dump_node(void *entry, unsigned long min,
+			unsigned long max, unsigned int depth, unsigned long array_out)
+{
+	struct maple_node *node = mte_to_node(entry);
+	unsigned int type = mte_node_type((unsigned long)entry);
+	unsigned int i;
+
+	switch (type) {
+	case maple_dense_enum:
+		for (i = 0; i < *((char *)(&mt_slots) + maple_dense_enum); i++) {
+			if (min + i > max)
+				printf("OUT OF RANGE: ");
+			mt_dump_entry(mt_slot(&(node->slot), i),
+					min + i, min + i, depth, array_out);
+		}
+		break;
+	case maple_leaf_64_enum:
+	case maple_range_64_enum:
+		mt_dump_range64(entry, min, max, depth, array_out);
+		break;
+	case maple_arange_64_enum:
+		mt_dump_arange64(entry, min, max, depth, array_out);
+		break;
+
+	default:
+		printf(" UNKNOWN TYPE\n");
+	}
+}
+
+void mt_dump(const struct maple_tree *mt, unsigned long array_out)
+{
+	unsigned long entry = (unsigned long)(mt->ma_root);
+
+	/* init mt_max array */
+	mt_max[maple_dense_enum]           = *((char *)(&mt_slots) + maple_dense_enum);
+	mt_max[maple_leaf_64_enum]         = (unsigned long)(-1);
+	mt_max[maple_range_64_enum]        = (unsigned long)(-1);
+	mt_max[maple_arange_64_enum]       = (unsigned long)(-1);
+	/* done */
+
+	if (xa_is_node(entry))
+		mt_dump_node((void *)entry, 0, mt_max[mte_node_type(entry)], 0, array_out);
+	else if (entry)
+		mt_dump_entry((void *)entry, 0, 0, 0, array_out);
+	else
+		printf("(empty)\n");
+}
+
+int main()
+{
+	struct task_struct *p;
+	unsigned long p_off;
+	int i, c;
+	struct vm_area_struct *vma;
+	struct ttm_buffer_object *tbo;
+	unsigned long pfn, num;
+	struct maple_tree *mt;
+	unsigned long tmp;
+
+	p = (struct task_struct *)&init_task;
+	p_off = (unsigned long)&(p->tasks) - (unsigned long)p;
+
+	do {
+		unsigned long array_out;
+		array_out[0] = 0;
+
+		if (!(p->mm)) {
+			p = (struct task_struct *)
+				((unsigned long)(p->tasks.next) - p_off);
+			continue;
+		}
+
+		mt = &(p->mm->mm_mt);
+
+		mt_dump(mt, array_out);
+		printf("PID: %d\n", (int)(p->pid));
+
+		for (i in array_out) {
+			printf("%lx\n", array_out[i]);
+		}
+		p = (struct task_struct *)
+			((unsigned long)(p->tasks.next) - p_off);
+	} while(p != &init_task);
+
+	return 0;
+}
-- 
2.47.0


