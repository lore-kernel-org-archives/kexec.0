Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E2FFED9E3
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sMdLE0ZXHgsDcXzuYH/GnabZgskOOvtKexyq0NGhdt8=; b=mueEg0UmXuodaPtcmCozd3Ae5p
	oGNnY5ntnxS4l3cmprL2hIJMbSQjZxZWEglIQlQEb2xOqLJ8yiO1rpf2J47QO+vNleryrrZq8p3T6
	j32LVLfMZd+NpwLkLCq4+q6KHORR42XsBI6EwRzU6ygrnkpysdCy5gCinr51UtTes/6lr5C/EWav2
	dI6c5lssvhfTTbgXwiDtd4wBm0tmPn8jB2tqgcC9JvlAVSfsYFe7BbLPDqyuMdNvrWJai/YW7GU5a
	YpR6DHi7GOcIAO/NnTVjQ9JN8WR76iMLK1R+LhGqBhAuQUJTueTYkS+2fZO9QZ/ZpescHjYxFnyT4
	KNvqUUkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W4J-00000006hKu-1hft;
	Tue, 17 Mar 2026 15:10:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W4G-00000006hJI-4AJM
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMdLE0ZXHgsDcXzuYH/GnabZgskOOvtKexyq0NGhdt8=;
	b=cHVED6c974HKzZBJt3ko12NaQVrrfshFntXX36EVL6Bxmc6YOCdY59fvoaiNygnF0X2mm4
	qoFoW48LNWXu1bOng/BNtXmW2KW+8BgT4abY1saG9Dv6XZPOVeuINLbMWl7EH+VGQwx5e2
	pjDihXJ7tH+GHdND3SfK4ugUFyP+4ys=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-005OOBTrOtCAMLhJpmR21Q-1; Tue, 17 Mar 2026 11:09:13 -0400
X-MC-Unique: 005OOBTrOtCAMLhJpmR21Q-1
X-Mimecast-MFC-AGG-ID: 005OOBTrOtCAMLhJpmR21Q_1773760153
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8299499d582so20776439b3a.2
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760152; x=1774364952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sMdLE0ZXHgsDcXzuYH/GnabZgskOOvtKexyq0NGhdt8=;
        b=OkECTBux0w7lxXlJeLtbD1hhlvPVRevDnEJaTTl/+ZWo0k6huZGUGYRNXIJGtI+AzU
         YhrfmTp+wRn7HZLLCUfkOQfTWzBlP0RkzFwYxzA/oLz+YQn+MedGs50cHlXwDWu5C/pt
         ZTcsuJSVx90saxbjS2kA9kvbBBUGz6nS5bq119sbyYzur7ydv4lAPTZvZKdtVOHtjfqW
         xKssVyVbYJSbVqgRwP7QSC4p9cWEaqnV0m2B0Yc+zBLqobnm7ZAHKfvFj8D4VypmUz6v
         1sRV6X3XwEq5tAgk9fMusdAQHOa+8KdQK8nic8ntJYnOzW8UvavQs37KXCbX9Fh8JYG3
         FJrg==
X-Forwarded-Encrypted: i=1; AJvYcCU7s+yX7OIZ/dLrE0wykl0lb5zUxbx/eRSkA+IOgyhGO+s7N4cuOv+uFkwicuEim59c0NSh0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YysfxRCVEEpReLvIQuFBxALREHFYAgGJ/EdnIgeKBN0NKNiYlGE
	i9UPRg9i01peD3c5Z5xukOBq9vzj+241niAGliLvlEtliXX5W69Wbg77aM4qnspY4nZw2UpvotQ
	+9ryOLfbCd+mQj1Jcdgt2WU/tEcaeagEC1CTmnNlrZKhHEkW1g92SnVIzmwH9C53NW7T3zQ==
X-Gm-Gg: ATEYQzy0rRox+AxweiGgjML/BbgY5NkSbWyio3pfVXcp8aPDQ3Pu5qulvQwF7xx36pQ
	M17awmywXi0Oy8K+7HlJZ2SHf6/CKOfCIAT+YAeS3pqq5sVWAsLNUD4Imit9hgDrfDwXqEvnWRS
	IL4siDzmNJDn5sA1vk8/lf+weGkAUisKPy1pEGFdthEcoDuaFa7989Kty4PblZgfUnRkG0kSvqB
	6FlJHvoGmMvufQkYZyLeiSqrd9SYsDfh1dpSiBLMJRb9eKkusQswHv01C7gHc6As6TIjfawdR6f
	O5eObh3NK22/ZzNKdHWVxewxmMWbPWSVN7O1xlibKHr8stHizKmDxJLcVhEqnX3Y8/kY7x01zda
	m+S1qOrA2jbdw6mCGO5Vnyw7QTKowZmtDgg==
X-Received: by 2002:a05:6a00:1c9c:b0:827:3b1b:43e8 with SMTP id d2e1a72fcca58-82a19700b9emr15260123b3a.15.1773760152300;
        Tue, 17 Mar 2026 08:09:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c9c:b0:827:3b1b:43e8 with SMTP id d2e1a72fcca58-82a19700b9emr15260097b3a.15.1773760151908;
        Tue, 17 Mar 2026 08:09:11 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm16993404b3a.39.2026.03.17.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:09:11 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v4][makedumpfile 5/7] Implement kernel module's btf resolving
Date: Wed, 18 Mar 2026 04:07:41 +1300
Message-ID: <20260317150743.69590-6-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260317150743.69590-1-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ElzNSKrulwJNAvpOotws8QYmHcKbmxfgDFxOQKM7scQ_1773760153
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_081049_105050_77730533 
X-CRM114-Status: GOOD (  16.21  )
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
 btf_info.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 btf_info.h |   2 +
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/btf_info.c b/btf_info.c
index 1cb66e2..7682a82 100644
--- a/btf_info.c
+++ b/btf_info.c
@@ -230,4 +230,116 @@ out:
 	if (buf)
 		free(buf);
 	return ret;
-}
\ No newline at end of file
+}
+
+INIT_KERN_SYM(btf_modules);
+
+INIT_KERN_STRUCT_MEMBER(btf_module, list);
+INIT_KERN_STRUCT_MEMBER(btf_module, btf);
+INIT_KERN_STRUCT_MEMBER(btf_module, module);
+DECLARE_KERN_STRUCT_MEMBER(module, name);
+INIT_KERN_STRUCT_MEMBER(btf, data);
+INIT_KERN_STRUCT_MEMBER(btf, data_size);
+
+#define MEMBER_OFF(S, M) \
+	GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
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
+		fprintf(stderr, "%s: Missing required btf syms/types!", __func__);
+		goto out;
+	}
+
+	modname = (char *)malloc(GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
+	if (!modname)
+		goto no_mem;
+
+	for (list = next_list(btf_modules); list != btf_modules; list = next_list(list)) {
+		readmem(VADDR, list - MEMBER_OFF(btf_module, list) +
+				MEMBER_OFF(btf_module, btf),
+			&btf, GET_KERN_STRUCT_MEMBER_MSIZE(btf_module, btf));
+		readmem(VADDR, list - MEMBER_OFF(btf_module, list) +
+				MEMBER_OFF(btf_module, module),
+			&module, GET_KERN_STRUCT_MEMBER_MSIZE(btf_module, module));
+		readmem(VADDR, module + MEMBER_OFF(module, name),
+			modname, GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
+		if (!check_ktypes_require_modname(modname, NULL)) {
+			continue;
+		}
+		readmem(VADDR, btf + MEMBER_OFF(btf, data),
+			&data, GET_KERN_STRUCT_MEMBER_MSIZE(btf, data));
+		readmem(VADDR, btf + MEMBER_OFF(btf, data_size),
+			&data_size, GET_KERN_STRUCT_MEMBER_MSIZE(btf, data_size));
+		btf_buf = (char *)malloc(data_size);
+		if (!btf_buf)
+			goto no_mem;
+		readmem(VADDR, data, btf_buf, data_size);
+		btf_mod = btf__new_split(btf_buf, data_size, btf_arr[0]->btf);
+		free(btf_buf);
+		if (libbpf_get_error(btf_mod) != 0 ||
+		    add_to_btf_arr(btf_mod, strdup(modname)) == false) {
+			fprintf(stderr, "%s: init %s btf fail\n", __func__, modname);
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
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
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
diff --git a/btf_info.h b/btf_info.h
index 2cf6b07..b7f6810 100644
--- a/btf_info.h
+++ b/btf_info.h
@@ -22,6 +22,8 @@ struct ktype_info {
 bool check_ktypes_require_modname(char *modname, int *total);
 bool register_ktype_section(char *start, char *stop);
 bool init_kernel_btf(void);
+bool init_module_btf(void);
+void cleanup_btf(void);
 
 #define QUATE(x) #x
 #define INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, R)			\
-- 
2.47.0


