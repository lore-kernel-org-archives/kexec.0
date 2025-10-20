Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1278CCD1A2
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DzfBAF7gjvPFYQFppaI9Pl8x8HcU4s0maGL1iTbSkPI=; b=Re7wHkfHfRjvmad5jbW0QArCCf
	QCpuGud87YeUlOKSDotkRtXG3vSsiB20cttlfuyO63JzcvjJJA7xs6q5GVvB2VKox+X/1tAf7QjMA
	st9BtpH3S3aEWzrsKL8kq9nTnFKSNLNop0h11AKIzRGi0sU6rvpw4SZVGfjg6PGyrBQ8B/KsXI0Xl
	/jqNMu6YNTWj61KwCaa5u1qCvfOW8El+53u4IEejF+mjjrTHiVFqkwY7zDbuRHDTTI+rmpS0zLY+b
	Ff/P122pAClyw5HgksvpIRQO9tc1QINDFKvWpEDFOsePkpCidzejPtwutC7WZNa7StOBkyUGU63+3
	PP7ydbPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyKc-0000000FBIU-1t3V;
	Mon, 20 Oct 2025 22:26:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyKa-0000000FBHN-1HmU
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:26:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzfBAF7gjvPFYQFppaI9Pl8x8HcU4s0maGL1iTbSkPI=;
	b=IeRkknjOtVWuqHyAws4mBomo7HrnH/MbpIusemVv11Umuxtjk/2aahU063GoZ8+KaQ0nYF
	dNzQggOwgNeeY8PE9ShgbspQGHEAwtt2JwxAGTmx7Ltr1L0cGmWEKgeqIv1389tiZchU6c
	7692sZ400jd2lwbN28JO+4xPt2RvfAA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ZDLn8zf_P02KlUiZOm9DxA-1; Mon, 20 Oct 2025 18:25:02 -0400
X-MC-Unique: ZDLn8zf_P02KlUiZOm9DxA-1
X-Mimecast-MFC-AGG-ID: ZDLn8zf_P02KlUiZOm9DxA_1760999101
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781269a9049so8399639b3a.2
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999101; x=1761603901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzfBAF7gjvPFYQFppaI9Pl8x8HcU4s0maGL1iTbSkPI=;
        b=sxjUHrkkVGIROCwf1QSzxpg0J1OyrE4K2FRw9kbadNXZD0hngFQwgWH75KOQ4V3AO+
         snGBrvL4oagZAqyho89kJGxoGvqWVxoeaWbzHyHzwZ5jgGI5ffaE5WQqaLKMq8jcphx0
         HQON2oBdWqupIcCqF2v7ljA1yTgTMZ86enZ3S9utzjOgEiplkwG8HFectAexvL2ciDQh
         6Rn5FEN0Zxlc2uU4dHQCpJRSRLWBdc1I/dbDv0uD1Sy/GrDE82aMIHd14fkzSGlu4m6s
         3/3NsOgvpVIO0ZoTH8jAV0lRQhOhwHZNDUr2ZC4uqpIPa6yOC89MYcxbXi7d3Xa4zFQm
         JxAA==
X-Forwarded-Encrypted: i=1; AJvYcCUmo8NL/jdOmydU5FjS1CL4eyv2LeYdSFbQHrxPeVE6eh+ICvgnV98EJT9D1KY3egVw54JXDg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw37Sa1qvtZgBph+Uot6RBSp4QF6Ou+eUFTOBv3jFZveHQ5Sl/7
	9Yq7zQITShKIwoWDr40/kBGGBYIiEaxu3SMIAg2Fuo87sZ8ezp/nApI/ba4ed/pFJpwCV8ZmMDr
	fQCyKR7xiwvITUXcNTeyl/ywv483kQqAEA4NvzyYGg2xjlQdJy8czV4eKMRTbTA==
X-Gm-Gg: ASbGncudrlUZjRTWZ2OoOt9zke36PcJBVvHpNngW3TiapIrKtEzp3vWURZzmufVd2Pw
	dJL9A5NspWiPEp4cqxtNykdE5J2RZUsseB1sLAyfoSrDm79A/xSEF6EyWi/1q/aCEk1j3tkUKK+
	HWXy8+L+ZXCFgzZB41akiSpON+STRplVF11adwu68NwxfcDcaEqZGm9/P8orDE38Jda/PtahBGR
	aBP0pfAlBImMhLEvjjbCK4IEI04Sb22jZkWdPPdhgqQaW0crxB1z7bn9rWjyAwZLzhJiBmQBAmE
	AP46yGI1EKc/ptWDLvNOyqmaypLUuUowHIoCzlFOJS5FHD09UlNgBAPDoPo8enK1vB3G2QgxRXl
	OUcmvZRbwSTqn9Vo3Q4moFO6K6mcnIhLqV/NYtLcm57Y=
X-Received: by 2002:a05:6a00:21c5:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7a220d232a7mr20826233b3a.15.1760999101076;
        Mon, 20 Oct 2025 15:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4f7nRPBySzvydWLHstrDazjIgKb8KIACPSeDAaYNBUuMqVOI65QLUGEoJDbzWZAQcW3Y6mg==
X-Received: by 2002:a05:6a00:21c5:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7a220d232a7mr20826199b3a.15.1760999100613;
        Mon, 20 Oct 2025 15:25:00 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:00 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 12/14] Enable page filtering for btf/kallsyms eppic
Date: Tue, 21 Oct 2025 11:24:08 +1300
Message-ID: <20251020222410.8235-13-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L7shMu_2CHor5XACTI6H6qj8BSOyK8W0X-qM8hno82w_1760999101
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152620_438197_67AE35F5 
X-CRM114-Status: GOOD (  23.86  )
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

This patch mainly replicate extension_eppic.c, implements the eppic interfaces
using btf/kallsyms functions rather than dwarf functions.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile          |   4 +-
 erase_info.c      |  22 ++++
 extension_btf.c   | 258 ++++++++++++++++++++++++++++++++++++++++++++++
 extension_eppic.c |   2 +-
 4 files changed, 283 insertions(+), 3 deletions(-)
 create mode 100644 extension_btf.c

diff --git a/Makefile b/Makefile
index fbc9f5b..8201bde 100644
--- a/Makefile
+++ b/Makefile
@@ -121,8 +121,8 @@ makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
 	     -e "s/@VERSION@/$(VERSION)/" \
 	     $(VPATH)makedumpfile.conf.5.in > $(VPATH)makedumpfile.conf.5
 
-eppic_makedumpfile.so: extension_eppic.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -rdynamic -o $@ extension_eppic.c -fPIC -leppic -ltinfo
+eppic_makedumpfile.so: extension_eppic.c extension_btf.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -rdynamic -o $@ $^ -fPIC -leppic -ltinfo
 
 clean:
 	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
diff --git a/erase_info.c b/erase_info.c
index 7c637c2..786f603 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -2220,6 +2220,8 @@ process_eppic_file(char *name_config, bool is_btf)
 
 	if (!is_btf) {
 		eppic_init = dlsym(handle, "eppic_dwarf_init");
+	} else {
+		eppic_init = dlsym(handle, "eppic_btf_init");
 	}
 	if (!eppic_init) {
 		ERRMSG("Could not find eppic_init function\n");
@@ -2348,6 +2350,26 @@ gather_filter_info(void)
 {
 	int ret = TRUE;
 
+	if (!info->name_vmlinux && info->name_eppic_config) {
+		/* No vmlinux is present, use btf & kallsyms instead. */
+		if (init_kernel_kallsyms())
+			goto fail;
+		if (init_kernel_btf())
+			goto fail;
+		if (init_module_kallsyms())
+			goto fail;
+		if (init_module_btf())
+			goto fail;
+		ret = process_eppic_file(info->name_eppic_config, true);
+		goto out;
+fail:
+		ret = FALSE;
+out:
+		cleanup_btf();
+		cleanup_kallsyms();
+		return ret;
+	}
+
 	/*
 	 * Before processing filter config file, load the symbol data of
 	 * loaded modules from vmcore.
diff --git a/extension_btf.c b/extension_btf.c
new file mode 100644
index 0000000..aee2ad8
--- /dev/null
+++ b/extension_btf.c
@@ -0,0 +1,258 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include "btf.h"
+#include "kallsyms.h"
+
+#include "makedumpfile.h"
+#include "extension_eppic.h"
+
+static def_t *
+apigetdefs(void)
+{
+	return 0;
+}
+
+static int
+apigetval(char *name, ull *val, VALUE_S *value)
+{
+	uint64_t v = cb->get_kallsyms_value_by_name(name);
+	if (!v)
+		return 0;
+	*val = v;
+	if (!value)
+		return 1;
+	eppic_setmemaddr(value, *val);
+	return 1;
+}
+
+static char *drilldown(ull, type_t *);
+static char *
+apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
+{
+	struct member_info mi = {0};
+
+	if (cb->get_type_member_by_index(idx, ++(*last_index), &mi) == false)
+		return NULL;
+	eppic_member_soffset(m, mi.bit_pos / 8);
+	eppic_member_ssize(m, mi.size);
+	eppic_member_snbits(m, mi.bits);
+	eppic_member_sfbit(m, mi.bit_pos % 8);
+	eppic_member_sname(m, mi.sname);
+
+	return drilldown(mi.uniq_id, tm);
+}
+
+static int
+apigetmem(ull iaddr, void *p, int nbytes)
+{
+	return cb->readmem(VADDR, iaddr, p, nbytes);
+}
+
+static int
+apigetctype(int ctype, char *name, type_t *tout)
+{
+	long size = 0;
+	uint32_t idx = 0;
+
+	switch (ctype) {
+	case V_STRUCT:
+		size = cb->get_type_size_by_name(name, BTF_KIND_STRUCT, &idx);
+		break;
+	case V_UNION:
+		size = cb->get_type_size_by_name(name, BTF_KIND_UNION, &idx);
+		break;
+	}
+
+	if (size <= 0 || !idx)
+		return 0;
+
+	/* populate */
+	eppic_type_settype(tout, ctype);
+	eppic_type_setsize(tout, size);
+	eppic_type_setidx(tout, (ull)idx);
+	eppic_pushref(tout, 0);
+	return 1;
+}
+
+static char *
+apigetrtype(ull idx, TYPE_S *t)
+{
+	return 0;
+}
+
+static uint8_t
+apigetuint8(void *ptr)
+{
+	uint8_t val;
+	if (!READMEM(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+		return (uint8_t) -1;
+	return val;
+}
+
+static uint16_t
+apigetuint16(void *ptr)
+{
+	uint16_t val;
+	if (!READMEM(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+		return (uint16_t) -1;
+	return val;
+}
+
+static uint32_t
+apigetuint32(void *ptr)
+{
+	uint32_t val;
+	if (!READMEM(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+		return (uint32_t) -1;
+	return val;
+}
+
+static uint64_t
+apigetuint64(void *ptr)
+{
+	uint64_t val;
+	if (!READMEM(VADDR, (unsigned long)ptr, (char *)&val, sizeof(val)))
+		return (uint64_t) -1;
+	return val;
+}
+
+static char *
+apifindsym(char *p)
+{
+	return NULL;
+}
+
+static enum_t *
+apigetenum(char *name)
+{
+	return 0;
+}
+
+static int
+apialignment(ull idx)
+{
+	return 0;
+}
+
+static int
+apiputmem(ull iaddr, void *p, int nbytes)
+{
+	return 1;
+}
+
+static apiops btf_icops = {
+	apigetmem, 
+	apiputmem,
+	apimember,
+	apigetctype,
+	apigetrtype,
+	apialignment,
+	apigetval,
+	apigetenum,
+	apigetdefs,
+	apigetuint8,
+	apigetuint16,
+	apigetuint32,
+	apigetuint64,
+	apifindsym,
+};
+
+void
+eppic_setupidx(TYPE_S *, int, int, int *);
+
+static char *drilldown(ull idx, type_t *t)
+{
+	struct btf_type bt, sub_bt;
+	struct name_entry *en, *sub_en;
+	int ref = 0;
+	int tmp = idx;
+	/* Following 2 are for array */
+	struct btf_array ba;
+	int nidx = 0, *idxlst = NULL;
+
+dive_ptr:
+	en = cb->get_en_by_uniq_id(tmp, &bt);
+	if (btf_kind(bt.info) == BTF_KIND_PTR) {
+		ref++;
+		if (!bt.type)
+			eppic_parsetype("char", t, ref);
+		else {
+			cb->get_btf_type_by_type_id(en->bf, bt.type, &sub_bt, &sub_en);
+			tmp = cb->id_to_uniq_id(sub_en->id, sub_en->bf);
+			goto dive_ptr;
+		}
+	} else if (btf_kind(bt.info) == BTF_KIND_INT) {
+		eppic_parsetype("int", t, ref);
+		eppic_type_setsize(t, bt.size);
+	} else if (btf_kind(bt.info) == BTF_KIND_STRUCT) {
+		eppic_type_mkstruct(t);
+		eppic_type_setsize(t, bt.size);
+		eppic_type_setidx(t, (ull)idx);
+		if (en->name && en->name[0])
+			apigetctype(V_STRUCT, en->name, t);
+		eppic_pushref(t, ref);
+	} else if (btf_kind(bt.info) == BTF_KIND_UNION) {
+		eppic_type_mkunion(t);
+		eppic_type_setsize(t, bt.size);
+		eppic_type_setidx(t, (ull)idx);
+		if (en->name && en->name[0])
+			apigetctype(V_UNION, en->name, t);
+		eppic_pushref(t, ref);
+	} else if (btf_kind(bt.info) == BTF_KIND_ENUM) {
+		eppic_type_mkenum(t);
+		eppic_type_setsize(t, bt.size);
+		eppic_type_setidx(t, (ull)idx);
+		if (en->name && en->name[0])
+			apigetctype(V_UNION, en->name, t);
+		eppic_pushref(t, ref);
+	} else if (btf_kind(bt.info) == BTF_KIND_CONST) {
+		cb->get_btf_type_by_type_id(en->bf, bt.type, &sub_bt, &sub_en);
+		tmp = cb->id_to_uniq_id(sub_en->id, sub_en->bf);
+		goto dive_ptr;
+	} else if (btf_kind(bt.info) == BTF_KIND_TYPE_TAG) {
+		if (bt.type != 0) {
+			cb->get_btf_type_by_type_id(en->bf, bt.type, &sub_bt, &sub_en);
+			tmp = cb->id_to_uniq_id(sub_en->id, sub_en->bf);
+			goto dive_ptr;
+		} else {
+			printf("%s: kind %d pointing to type 0\n", en->name,
+				btf_kind(bt.info));
+			if (ref)
+				/* Finish up with pointer type */
+				eppic_parsetype("char", t, ref);
+		}
+	} else if (btf_kind(bt.info) == BTF_KIND_ARRAY) {
+		if (!idxlst) {
+			idxlst = eppic_calloc(sizeof(int) * (MAXIDX + 1));
+			if (!idxlst) {
+				printf("Out of memory for eppic array\n");
+				goto out;
+			}
+		}
+		cb->read_file_at_offset(en->bf->file_name,
+			en->btf_type_offset + en->bf->types_data_offset + sizeof(bt),
+			sizeof(struct btf_array), &ba);
+		idxlst[nidx++] = ba.nelems;
+		/* Dive and resolve array's elements */
+		cb->get_btf_type_by_type_id(en->bf, ba.type, &sub_bt, &sub_en);
+		tmp = cb->id_to_uniq_id(sub_en->id, sub_en->bf);
+		goto dive_ptr;
+	} else {
+		printf("%s: Drilldown unsupported btf kind %d\n",
+			en->name, btf_kind(bt.info));
+	}
+
+	if (nidx > 0) {
+		/* Finish up array */
+		eppic_setupidx(t, ref, nidx, idxlst);
+		eppic_pushref(t, ref + 1);
+	}
+out:
+	return eppic_strdup("");
+}
+
+int eppic_btf_init(void *fun_ptr)
+{
+	return eppic_init(fun_ptr, &btf_icops, true);
+}
\ No newline at end of file
diff --git a/extension_eppic.c b/extension_eppic.c
index 00d19fa..17bed17 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -83,7 +83,7 @@ reg_callback(char *name, int load)
  *
  * set idx value to actual array indexes from specified size
  */
-static void
+void
 eppic_setupidx(TYPE_S *t, int ref, int nidx, int *idxlst)
 {
 	/* put the idxlst in index size format */
-- 
2.47.0


