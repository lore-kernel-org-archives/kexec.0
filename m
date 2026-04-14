Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDA0ED7B9C
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tiXpPsYhGh6MoRWoIiTxJVjE11QXTdXK2KcUQC2gbGc=; b=P0H93UMQbxUQ8lSIF1Buw2YDTE
	XrQV4+V52WMz6BfvyodQBb8euswQ+cIqME/KHBwmp7o3cIR+ntilq+KkboOwkmrtjP8o4SoMM98Oi
	hpVuCbYoY8E0jrEQL/yyd0i6GSfigU62x6ZVkJHTLuhr17OFTMj5FBiFyQE/ZspyDHOXA5z0Pujdt
	be05JHRwTefO4+r2BeYNA+B1MNK6Kh4VxL/NUUQZYbCUdtroiSmLunXOh7ElVxetCzYW6QLEWatkG
	6Brgn1DYTBNOxzSHm6HQy7Q+386++YS4RyDzp43wbCZvkB8gj4SR8/iqEeXx07SY34GTRiiY0uY2q
	BfTZHRgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazf-0000000H8xY-0MUd;
	Tue, 14 Apr 2026 10:27:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazc-0000000H8vb-3NC7
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiXpPsYhGh6MoRWoIiTxJVjE11QXTdXK2KcUQC2gbGc=;
	b=iJeKmu9a+5DYZSMGrvaSuwE6Vkx7MQUvymBpINk8hDAvSDLW/YCtVpsPDNMdT7y1MmLKq9
	3AKV45lOQLDXGW0AsPXDTDjHSCuFMACNo++zGhc5oLfsn+haW888eAoMtsgN5Xwbz2ARt+
	P0/mDXWqO3HTUG4XgBYxW6FX8Au5IFk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-eHv3nZdHPBC5oKgsyYXNqA-1; Tue, 14 Apr 2026 06:27:38 -0400
X-MC-Unique: eHv3nZdHPBC5oKgsyYXNqA-1
X-Mimecast-MFC-AGG-ID: eHv3nZdHPBC5oKgsyYXNqA_1776162457
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24308165dso101292765ad.1
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162457; x=1776767257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiXpPsYhGh6MoRWoIiTxJVjE11QXTdXK2KcUQC2gbGc=;
        b=ovT0dww59Yh1X/zjE1zxOrgHChWI0z+uuScgNv2xUTv15rP52rNezKYKELsnKNsapM
         sgqjEulNhlfmwrLUZZZgUWCvp9CorfudW0Uv4L6gb/kOT+DaGKa1sQtPVMcon4Gt1yQi
         iYCLNPPuOYBCNE6Tmd0mvEvkXU1UmJWoeFjOWiVYg365t/boYX5pZcyvkZt1Zy4uKzOC
         1KwAfKJkBdizKUhLOLwwr4s9nV3+Z/XF3+dnvMh6qfg27iBZ99LQGCOckp6N0sfsoPMo
         rU7rZUNC4225TnOaXgh27avAOeppcAyAjbm+ZQ4qtkXSBbR3C8bU9GuTYzwmR2xwVr1w
         AmbA==
X-Forwarded-Encrypted: i=1; AFNElJ/p1O7qEKspAKJ5hAkn6M9kvDDkFS7dxpT76YmwN7qszu858ApWdleWjT5CmuiuAM6SP47PJA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzSw8/Zy9Kkk5D0BzrN/q+Yp8fyTxoThvXcO0dmsD4OIbX+SZb8
	HmMbJ+mXtoto5Z3s0NhuZXyd0md5fai/rnmeoTDubftxvwljPlJVNjWkFTjZy7MiFpcmxuJauM2
	F6miQxupgG2XCR3O1Wqn88FQNDvsKC9oeHLU6SZoTFDvcdWYeUJ7FFy5Xp06XpQ==
X-Gm-Gg: AeBDievwABtI1JqN+xAqbqg11kRvuhVcr4VVItU9RtYVdAv6SVK3iipBlhWGoi0JleA
	DWakSkKRcJsTrh42eeAJk0Ad+DkPIVuhr8MvHgWT0146B/0yeT+azHRKrs0lEC3RHjtqhnZwkCt
	Ur/CrwJUtHmRIQknN2N7PzMpgoTkjdbohYdy7r6TAbu6S74TIEpPUarNHss1h2zpRjXPkKG8zKH
	xrw40/X9egI2qD+Ym8NiUnQMxD5tmWjbDyWqtBZ1zSLW+Se/6MGQbmFDl+DhBnA+iWNVS4rj9H0
	qhqG2CMlT5hRnViEvhWlve2fByYvLpFPmziNzxKeInETsV8zHxUcJ40fhj0SeL98Jon2DeELdmC
	jz5YyOkuL8yrMt135s24FBTkNWqRURDZK8zqN42h0kJ3zzGKgfktBzo6gxXBsrFN6Wyc3
X-Received: by 2002:a17:902:768b:b0:2b2:4a9a:b168 with SMTP id d9443c01a7336-2b2d59780aamr127298225ad.11.1776162457227;
        Tue, 14 Apr 2026 03:27:37 -0700 (PDT)
X-Received: by 2002:a17:902:768b:b0:2b2:4a9a:b168 with SMTP id d9443c01a7336-2b2d59780aamr127298055ad.11.1776162456805;
        Tue, 14 Apr 2026 03:27:36 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:36 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 5/9] Implement kernel module's btf resolving
Date: Tue, 14 Apr 2026 22:26:52 +1200
Message-ID: <20260414102656.55200-6-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EJPQ2DywSm5R-h3hunGTP_WvmUWxo37AH_B5BQ15q1w_1776162457
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032740_915397_438816EF 
X-CRM114-Status: GOOD (  15.37  )
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

Same as the previous patch, with kernel's kallsyms and btf ready,
we can locate and iterate all kernel modules' btf data. So kernel
modules' types specified within .init_ksyms section will be resolved.

Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 btf_info.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_info.h |   2 +
 2 files changed, 135 insertions(+)

diff --git a/btf_info.c b/btf_info.c
index 7243674..1506152 100644
--- a/btf_info.c
+++ b/btf_info.c
@@ -238,5 +238,138 @@ out:
 		free(buf);
 	return ret;
 }
+
+INIT_MOD_SYM(vmlinux, btf_modules);
+
+INIT_MOD_STRUCT_MEMBER(vmlinux, btf_module, list);
+INIT_MOD_STRUCT_MEMBER(vmlinux, btf_module, btf);
+INIT_MOD_STRUCT_MEMBER(vmlinux, btf_module, module);
+DECLARE_MOD_STRUCT_MEMBER(vmlinux, module, name);
+INIT_MOD_STRUCT_MEMBER(vmlinux, btf, data);
+INIT_MOD_STRUCT_MEMBER(vmlinux, btf, data_size);
+
+#define KERN_STRUCT_MEMBER_EXIST(S, M) MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M)
+#define MEMBER_OFF(S, M) GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8
+#define GET_KERN_STRUCT_MEMBER_MSIZE(S, M) GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, S, M)
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+
+bool init_module_btf(void)
+{
+	struct btf *btf_mod;
+	uint64_t btf_modules, list;
+	uint64_t btf = 0, data = 0, module = 0;
+	int data_size = 0;
+	bool ret = false;
+	char *btf_buf = NULL;
+	char *modname = NULL;
+	struct ktype_info **p;
+
+	btf_modules = GET_KERN_SYM(btf_modules);
+	if (!KERN_SYM_EXIST(btf_modules))
+		/* Maybe module is not enabled, this is not an error */
+		return true;
+
+	if (!KERN_STRUCT_MEMBER_EXIST(btf_module, list) ||
+	    !KERN_STRUCT_MEMBER_EXIST(btf_module, btf) ||
+	    !KERN_STRUCT_MEMBER_EXIST(btf_module, module) ||
+	    !KERN_STRUCT_MEMBER_EXIST(btf, data) ||
+	    !KERN_STRUCT_MEMBER_EXIST(btf, data_size)) {
+		/* Fail when module enabled but any required types not found */
+		ERRMSG("Missing required btf syms/types!\n");
+		goto out;
+	}
+
+	modname = (char *)malloc(GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
+	if (!modname)
+		goto no_mem;
+
+	for (list = next_list(btf_modules); list != btf_modules; list = next_list(list)) {
+		if (!readmem(VADDR, list - MEMBER_OFF(btf_module, list) +
+				MEMBER_OFF(btf_module, btf),
+			&btf, GET_KERN_STRUCT_MEMBER_MSIZE(btf_module, btf))) {
+			ERRMSG("Can't get btf_module member btf!\n");
+			goto out;
+		}
+		if (!readmem(VADDR, list - MEMBER_OFF(btf_module, list) +
+				MEMBER_OFF(btf_module, module),
+			&module, GET_KERN_STRUCT_MEMBER_MSIZE(btf_module, module))) {
+			ERRMSG("Can't get btf_module member module!\n");
+			goto out;
+		}
+		if (!readmem(VADDR, module + MEMBER_OFF(module, name),
+			modname, GET_KERN_STRUCT_MEMBER_MSIZE(module, name))) {
+			ERRMSG("Can't get module modname!\n");
+			goto out;
+		}
+		if (!check_ktypes_require_modname(modname, NULL)) {
+			continue;
+		}
+		if (!readmem(VADDR, btf + MEMBER_OFF(btf, data),
+			&data, GET_KERN_STRUCT_MEMBER_MSIZE(btf, data))) {
+			ERRMSG("Can't get module btf address!\n");
+			goto out;
+		}
+		if (!readmem(VADDR, btf + MEMBER_OFF(btf, data_size),
+			&data_size, GET_KERN_STRUCT_MEMBER_MSIZE(btf, data_size))) {
+			ERRMSG("Can't get module btf data size!\n");
+			goto out;
+		}
+		btf_buf = (char *)malloc(data_size);
+		if (!btf_buf)
+			goto no_mem;
+		if (!readmem(VADDR, data, btf_buf, data_size)) {
+			ERRMSG("Can't get module btf data!\n");
+			goto out;
+		}
+		btf_mod = btf__new_split(btf_buf, data_size, btf_arr[0]->btf);
+		free(btf_buf);
+		if (libbpf_get_error(btf_mod) != 0 ||
+		    add_to_btf_arr(btf_mod, strdup(modname)) == false) {
+			ERRMSG("init %s btf fail\n", modname);
+			goto out;
+		}
+	}
+
+	/* OK, we have loaded all needed modules's btf, now resolve the types */
+	for (int i = 0; i < sr_len; i++) {
+		for (p = (struct ktype_info **)(sr[i]->start);
+		     p < (struct ktype_info **)(sr[i]->stop);
+		     p++)
+			get_ktype_info(*p, NULL);
+	}
+
+	ret = true;
+	goto out;
+
+no_mem:
+	ERRMSG("Not enough memory!\n");
+out:
+	if (modname)
+		free(modname);
+	return ret;
+}
+
+static void cleanup_btf_arr(void)
+{
+	for (int i = 0; i < btf_arr_len; i++) {
+		free(btf_arr[i]->module);
+		btf__free(btf_arr[i]->btf);
+		free(btf_arr[i]);
+	}
+	if (btf_arr) {
+		free(btf_arr);
+		btf_arr = NULL;
+	}
+	btf_arr_len = 0;
+	btf_arr_cap = 0;
+}
+
+void cleanup_btf(void)
+{
+	cleanup_btf_arr();
+	cleanup_ktypes_section_range();
+	cleanup_ktypes_modname();
+}
+
 #endif /* EXTENSION */
 
diff --git a/btf_info.h b/btf_info.h
index 8eace67..a6c3bba 100644
--- a/btf_info.h
+++ b/btf_info.h
@@ -22,6 +22,8 @@ struct ktype_info {
 bool check_ktypes_require_modname(char *modname, int *total);
 bool register_ktype_section(char *start, char *stop);
 bool init_kernel_btf(void);
+bool init_module_btf(void);
+void cleanup_btf(void);
 
 #define _GEN_NAME_PTR_IMPL(PTR, NAME)		PTR##NAME
 #define _GEN_NAME_PTR(PTR, NAME)		_GEN_NAME_PTR_IMPL(PTR, NAME)
-- 
2.47.0


