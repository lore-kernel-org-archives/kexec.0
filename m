Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A54CCD98EE
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=++lBgCYGuiirlIgVmHSgovY9B0PahoM55tYjW8LWfgE=; b=ZKaP7RHdloXZqa3Bwwx+jihTnv
	z+3We3AGx7z5xISnbGqVbIP10bWMUIFt3Ea+UpX1VGk83dyfvbyJkg+NEbkPORvafh5yjjdhGoB7N
	wdNG4mBgCOxQ4ELyupnVUMvFDEdtHBHX9zKAcxXug5ojvBnuDwak2ZErA7jiZYPL89fuQR2Q5Apie
	7qZXoX0y02WYdEO8rf+9f823Br7zgq+LKoXOp+1xWbLWsD0K0uhmwfDho/XclqVxeXMtqifm6BRjM
	5ddrS8MOozEZD8NgERBtOKIuZjtnILAY+FcSGM2javhgHfqHVhgC5uKCMx83KdUjigie+QJCOmgBt
	TVWUMduQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihY-0000000Ge61-1jgH;
	Wed, 17 Jun 2026 05:20:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihW-0000000Ge4f-10UT
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++lBgCYGuiirlIgVmHSgovY9B0PahoM55tYjW8LWfgE=;
	b=UsbrhYQjxP0DozHptCWqYmTArpf1o4bJdHpksnEk2buUzeJ18PSCMWw/s3WD1hfvzXxKPN
	WOqMxOZVEyCOixCL1Cw/rLozGuuET+Ug7r9Wgq7hkLftXpZTVyYhhz4btEpyyIgOeBrHpp
	N5/oDrztU69E4VjDVysgZZQ4808NrZQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-nafffynsNz2uszikf35xpg-1; Wed, 17 Jun 2026 01:20:31 -0400
X-MC-Unique: nafffynsNz2uszikf35xpg-1
X-Mimecast-MFC-AGG-ID: nafffynsNz2uszikf35xpg_1781673631
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8422b1354edso6566494b3a.2
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673631; x=1782278431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++lBgCYGuiirlIgVmHSgovY9B0PahoM55tYjW8LWfgE=;
        b=I1Jyl1X6TpPDb3Zx6/Uqx2sEkzLNFUFWfj5XAoP9BdoL5N7zsYdbMeWbqbMbWo8mI2
         3Q4TSKDhmM7uTkj+amg1m7RgDCNB72pwcIpkbqp7RfgpSFskEUYQgC0B39lg3N2K7zPC
         tieEmW+upqnXGbU71O03Orll87yc/WlZKJRCvJkhYY1yHwVci/uDHd3xu6HYNa1kIRwJ
         oetX7A00lClqFaG98sawMN4+JS0RpvBKT5yWf3mS3EHg39ybepxf80uSPtiuLA+2E9kx
         zWZ6MhJrrHwM6gMTXdV5RrGGBujlpP0Bu1rzKhGZ+ZoK6s0+zuUcadV+vEQ0i+X7aTNX
         ga9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+u61jxZdSJl2n1r+zd//OQf7jZ5RdfrlKz+m1OVZ/ADlS5cGIIur4F8qp2T13y7ECy08MiHA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLGNVnHrWPum5tnaELAXY+8B2qUVrD25Ic6oAhBJA5KrUsqBIn
	wXdW2mRAyTXcsbc/Ujc/hs9ojhESr/9wXE4ZyRxzw55BZfbe8Y2OncDkJY5oARxwTdVgY6M3X4X
	bVtJPn/UsQ0tgiugWDFMiC00Sq0eHtQZ3tmNcf1YaClIa7bX1rY5VKMTjhSSE5w==
X-Gm-Gg: Acq92OH90tlr7MncwSGcuOoOAkygZ0oax4kA+DD1tn+qzVZ5yrFfJQjSzjuz86JZbB+
	PGs+zWm0ECm2cO2GrScBuh7TyMDSnJLNRTomCTnKorIlFUJ3mzxK9P+EMTWUCc7WvZqZZc2+arX
	4wR3DjjumtnOK1qqLRybudwFJpYh2WVAjdgaUniDGpOA9HtTsE4axuIgi6sI6JTM+iAEjK+LKLL
	/FhVOyVlgwW3Vc2zUUfJ7zxNtbtYBslIR62WGc/tb7zTrf9UmhdNNLBY/BM9vrO++KR5OvtMRla
	8suJVqMnq1ay0hVZhfdp7D6Fz8dTJuWcu9i3GCyXVQknRSffffqquTI6RTrlqVUmA0FMiLOLgH2
	dGXQPoKhvj0V5awBLzi59K3gpm8UFLuWPdXTb8qqIK3TmDOH2Tw==
X-Received: by 2002:a05:6a00:3313:b0:842:459b:d62a with SMTP id d2e1a72fcca58-84524464807mr2330999b3a.17.1781673630666;
        Tue, 16 Jun 2026 22:20:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:3313:b0:842:459b:d62a with SMTP id d2e1a72fcca58-84524464807mr2330974b3a.17.1781673630189;
        Tue, 16 Jun 2026 22:20:30 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:29 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 05/10] Implement kernel module's btf resolving
Date: Wed, 17 Jun 2026 17:18:29 +1200
Message-ID: <20260617051834.95404-6-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617051834.95404-1-ltao@redhat.com>
References: <20260617051834.95404-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8cVtxLZNWMOfqzIa5THzj_znOKfyGPJlvtX__1zDWWs_1781673631
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222034_364132_C6ECD19D 
X-CRM114-Status: GOOD (  15.01  )
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

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 btf_info.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_info.h |   2 +
 2 files changed, 135 insertions(+)

diff --git a/btf_info.c b/btf_info.c
index 8d907f6..fbb487b 100644
--- a/btf_info.c
+++ b/btf_info.c
@@ -234,5 +234,138 @@ out:
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
2.54.0


