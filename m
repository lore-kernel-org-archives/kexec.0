Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017C2C678DA
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zazbs7Ek/EktGb4r6ARZ6ZZC9U26yMgQAxem+kroQk=; b=o2PEX/vVMRLmubdaxZD21aEzJE
	jAGM7j8VCqT3EU+mN2cZfPfo7GE9V6QWFnR+DVMs6bsLxUvrhhuTHGuQx6/YgsNmWVjMQaguecuZV
	MUNjGxprrur6ghxhLXGLNHJA+B1zqPrKCdhKT6jZjYh8vUkJ41XdyswPi1Y2ijSN82EedO43PdzSI
	NnTppseieJTV0aKBmLzRsQo6qt28JUlJn0NlS2QExg8G4CPV5fpAvh9VkFeBMovGxRsxcpAMFC61Q
	QbC3gVqOaA1/F7CSzphyklbYgZa4Z+yc4AY0HUKMgw2cNQ+yIC//Nz2ChGrupFDfhI9wEJCdhJitu
	D8FbANig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwf4-00000006YGW-1uLG;
	Tue, 10 Jun 2025 10:56:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvly-00000006QlO-0pj4
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 10:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zazbs7Ek/EktGb4r6ARZ6ZZC9U26yMgQAxem+kroQk=;
	b=PZZTs9ueXpGADrmsEps6ZLs5F8OMlM55q+hcc2Ax6K12nGE+TAQOtKX5uCMxmXP9FB8iPB
	bP6QdVXqwnp8hdu1ACZOm6FvL6caH+dKp6XC1g1Z1Eiy4nS5xaQdhMXHvjCTVOrGt4NadA
	aUbE38tMpD/T5li5vxHK/cmZKjSRxew=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-ZkcsWxrbNEiBXkBFOPmxnQ-1; Tue, 10 Jun 2025 05:58:28 -0400
X-MC-Unique: ZkcsWxrbNEiBXkBFOPmxnQ-1
X-Mimecast-MFC-AGG-ID: ZkcsWxrbNEiBXkBFOPmxnQ_1749549508
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2356ce55d33so59245135ad.0
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549508; x=1750154308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zazbs7Ek/EktGb4r6ARZ6ZZC9U26yMgQAxem+kroQk=;
        b=fiClvHy2ADeBlfgX94m0ac2B3CjDmNSUGfw91AoVAG8hmstyWJlZCBDloxdcxM/TfB
         CUkrOzgoQzjsv1AdmwByGNXAT/FHdMWQQDk/LAcSNEll5RSR1XWux6kx2bZgYB//kB35
         rFubcURgQw/hPC42APqtAsQoxITjSXTyAvwYIfCqxEhGfSM9sQuWoffIBjZ1TQ0S0RBm
         L6kB7w2vM3EycY0qDqTN/kW1W+bM0gwgtXqc8SP4fplxIsddnkdY4kzEq5WxMuHtJR9I
         aRSIqNQ8e59E3VKH3UqyVuWzFQgdzogQEV/lNZY5eN+qgqTWqGl4dTpBj/LZiRAHa2xB
         jWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHG6jaZa2/sNiU548uPkN2h2lQicYXwXNKg9reTck8wO8GskWsFvX1kHuhKXx8u1LnPAZ1IQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzdi3gBePjce4zczRtkhbE/OyXm16O4S0f8ZPo45/A3HHnLvdz7
	gWVWjHN2PzfnUc/HWIwWO8BbsdmcIULDyPIReal4GOVt5A+etdPO0s4ONQsxjOKFRxNnHvCxJe/
	Az4M+yuTx0l2hn0upROTz2T0Ws9J0he3z1jJqp5qU9F0CbDZrBHKcAAYJc/5Shw==
X-Gm-Gg: ASbGncuvXiOjx+X2cvXD/Xmvfqo3RvDcWUndAXLpA2ZqgnXEZ91Ka0Q3cofALtLcy94
	Fl7sNEn18uK7FMo3uYhQgCTAGs5d2uwNzGGAnXshoeFv0OazljtIOblEpsjNrVq+8rDLnJvRvkG
	zholKoqMTE2SCesD+qQLW9rUor0z1IBCcdGTpuikqZi80+a+7H6UHbcg/h2ic0InS30FBkSofW1
	0xXm2WAfOCPyDLUjc4nhrCIc1EwdUQeBFEcbHzFp91avUW9rzb76y1Kxe6+OJ9oSpWxIjA6po7o
	JPbYTMMa3/V+1uFriLn0h5jNQ03W4Ps=
X-Received: by 2002:a17:902:cec6:b0:234:8a16:d62b with SMTP id d9443c01a7336-2363829c5e2mr28550355ad.12.1749549507621;
        Tue, 10 Jun 2025 02:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0lFK6BxzigRzD1ChnFlNJUyXUNZ8idugQEWsvq3HcPgKHOWvHS60aUJQZ2TcwlP8zqtc7og==
X-Received: by 2002:a17:902:cec6:b0:234:8a16:d62b with SMTP id d9443c01a7336-2363829c5e2mr28550165ad.12.1749549507223;
        Tue, 10 Jun 2025 02:58:27 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:26 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 09/10] Enable page filtering for btf/kallsyms eppic
Date: Tue, 10 Jun 2025 21:57:42 +1200
Message-ID: <20250610095743.18073-10-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6R5SnnYbXsPhFRVO-GrIsbvw2qKMC61uPlVkl2bJfio_1749549508
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_030002_313070_0B0F590C 
X-CRM114-Status: GOOD (  18.74  )
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

This patch mainly implements the eppic interfaces using btf/kallsyms functions.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile        |   2 +-
 erase_info.c    |  22 +++++
 extension_btf.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100644 extension_btf.c

diff --git a/Makefile b/Makefile
index 216749f..a2d37b1 100644
--- a/Makefile
+++ b/Makefile
@@ -121,7 +121,7 @@ makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
 	     -e "s/@VERSION@/$(VERSION)/" \
 	     $(VPATH)makedumpfile.conf.5.in > $(VPATH)makedumpfile.conf.5
 
-eppic_makedumpfile.so: extension_eppic.c eppic_maple.c
+eppic_makedumpfile.so: extension_eppic.c eppic_maple.c extension_btf.c
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -rdynamic -o $@ $^ -fPIC -leppic -ltinfo
 
 clean:
diff --git a/erase_info.c b/erase_info.c
index eeb2c3b..e0fed6b 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -2223,6 +2223,8 @@ process_eppic_file(char *name_config, bool is_btf)
 
 	if (!is_btf) {
 		eppic_init = dlsym(handle, "eppic_dwarf_init");
+	} else {
+		eppic_init = dlsym(handle, "eppic_btf_init");
 	}
 	if (!eppic_init) {
 		ERRMSG("Could not find eppic_init function\n");
@@ -2351,6 +2353,26 @@ gather_filter_info(void)
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
index 0000000..c09625f
--- /dev/null
+++ b/extension_btf.c
@@ -0,0 +1,218 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include "btf.h"
+#include "kallsyms.h"
+
+#include "makedumpfile.h"
+#include "extension_eppic.h"
+#include "eppic_maple.h"
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
+static char *drilldown(ull idx, type_t *t)
+{
+	struct btf_type bt, sub_bt;
+	struct name_entry *en, *sub_en;
+	int ref = 0;
+	int tmp = idx;
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
+	} else {
+		printf("%s: Drilldown unsupported btf kind %d\n",
+			en->name, btf_kind(bt.info));
+	}
+	return eppic_strdup("");
+}
+
+int eppic_btf_init(void *fun_ptr)
+{
+	return eppic_init(fun_ptr, &btf_icops, true);
+}
\ No newline at end of file
-- 
2.47.0


