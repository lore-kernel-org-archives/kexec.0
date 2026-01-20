Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AF8D2ED11
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bfwaqApQhA4xeVcOiQuNh0sa+3vd9R+IkOeExl6LGxg=; b=yerkDWZ6FHZL4y3O+N0ThIe3B8
	PkYpw5GsybYfWctaXZndSlJEvmnj+rCB0DEXZbgh29Let+Xx5XnfG9B2UEAnj+eOmhkW2wkBvH8uX
	SN/Qi8B9JjS5d67m4C/70IE1Iz3WWEZqGsF7xSLKo7a7dkhEcRhpTdD2Sth7uiu5aIQnR84ZnQtKs
	mMIM2unBV1o0dg1eXm4G2+R5pRfmak2pXTIjuzOh4BDY7V7tDXL/L7MM3Tixc6+VhVZCfWm/E/Kzx
	SOp4n82gmaVXhQPmJRSMyYBRHxUiWmqY7O0TvnQj6jObknUNPdSAF+FDbZeKrDBWjpUk0d0wfY29a
	k9bA+ztA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2ab-0000000385l-3f31;
	Tue, 20 Jan 2026 03:39:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aZ-0000000383h-1B7z
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfwaqApQhA4xeVcOiQuNh0sa+3vd9R+IkOeExl6LGxg=;
	b=Rj3glCwnBBOnZ3UArM44wLIvjghdIpogpqTSVlJ67ZDa8PUQNpyq6kntpNXCfzXtltKSyB
	GNyrhB+YWYa6K5FPv6rHz/4tKbvOwwaX1KxtRjkguAEu+A1zygpgWEALdSW4lOiggy/RI+
	IwvaaaP6bRNbN8WY3Chcz4BM0kwTwTs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-GDLenXlZONC0jqmJ4BbUHw-1; Mon, 19 Jan 2026 22:39:28 -0500
X-MC-Unique: GDLenXlZONC0jqmJ4BbUHw-1
X-Mimecast-MFC-AGG-ID: GDLenXlZONC0jqmJ4BbUHw_1768880367
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso5113006a91.3
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880367; x=1769485167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfwaqApQhA4xeVcOiQuNh0sa+3vd9R+IkOeExl6LGxg=;
        b=dwIGE713cvPUyuMq736y3Gg0imIJ8nVJnRsysyd26YnV4V4E9H+5ZLVt9QhdQ7nG1X
         2DC7ny5de8uvZkAok3G3ZsipOb0UIlYcidTY7EIWKhdhMHRRjzypyiXR2likEifcedPo
         zEothoWSgUaaNqww4Rz9kVrgqBqUCJx5bIlqRR0hmYOMKwAKJlUPhQZDbAeJ2qyWx5eW
         LNgP1z4aSxmfzyHxhNuR+nE+3fMlwQS1EArtwQg+XnM8a4jri5xoKR2LMBOqwkIGHhf7
         L7rygWwPl/iWlZ/a56XbKAjGg0hiKTQcmalndoG1vN2/GLC+Bl7LfsVH/k9zLzTMzIsG
         aTeg==
X-Forwarded-Encrypted: i=1; AJvYcCVI9Xgrmwk0vJE3rIw8jBL7fszcnustbxOazGjHmEl3NkLQ4klO+EzuKBqZsWTkBGWLUrF87Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxgo96m7hHQ32dvpmNX98veh7ABlM+Pp6kjo7kUzLl0bJyyW2PH
	oK6h1cblLqSrK1ejIHuHcGSUFcect55nOE892y/p0wsRVrN+uWqi4t2vj92NipWJjapqXAmarJ8
	w/I1qSTMjSkecQAkmGmLt91LHbto3ci88Rd7CSpTT47wCwsab7G9ez+8DheIarQ==
X-Gm-Gg: AZuq6aIK11nj0WyknUUTWqZGXxPo05wHUvBUEGOim06244tXSEFDxWpR2KOlE6ktWSD
	GbECaHtR0MdV+Dn7vUJQw3/qk0u/wVjFYM+5fqBXJbCHvxZ0Gtz8H1k9Pk5utHtXsKnhDNs77LS
	lDlATBNyGzNVOFpfjGxdT2L06fxWcFpWWtryS7cqD9zCfITJS46GzmKdLdZgmzkn8RmgNcMRpS6
	/IAE8f5+lB8zaWRXDODdDpkfPIFmy4o6zKjFE6dMpT9yQKa99mEJX9XtVxlziIGzzcspAPJcdlK
	EeloDqviiChmneFqSyIlcJKUJymJ+7/q3AO7/UnfHT26vIkwRuyMHJ/Y9KiqH6ijGeisf9uTVL9
	hCBOOBYoo8kHjT3DAXw==
X-Received: by 2002:a17:90b:5905:b0:34c:aba2:dd95 with SMTP id 98e67ed59e1d1-352c4078229mr548611a91.26.1768880367228;
        Mon, 19 Jan 2026 19:39:27 -0800 (PST)
X-Received: by 2002:a17:90b:5905:b0:34c:aba2:dd95 with SMTP id 98e67ed59e1d1-352c4078229mr548603a91.26.1768880366825;
        Mon, 19 Jan 2026 19:39:26 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:26 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 4/8] Implement kernel modules' btf resolving
Date: Tue, 20 Jan 2026 15:54:56 +1300
Message-ID: <20260120025500.25095-5-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XIrkV7FLa-XMm_NOnRJD-A409MbNH2JXGWeihe4hyXc_1768880367
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193931_588985_1AF4B054 
X-CRM114-Status: GOOD (  14.78  )
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
we can locate and iterate all kernel modules' btf data.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 btf_info.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_info.h |  2 ++
 2 files changed, 76 insertions(+)

diff --git a/btf_info.c b/btf_info.c
index e7f8d9a..752661c 100644
--- a/btf_info.c
+++ b/btf_info.c
@@ -184,3 +184,77 @@ out:
 		free(buf);
 	return ret;
 }
+
+#define MEMBER_OFF(S, M) \
+	GET_STRUCT_MEMBER_MOFF(S, M) / 8
+
+bool init_module_btf(void)
+{
+	struct btf *btf_mod;
+	uint64_t btf_modules, list;
+	struct struct_member_info smi;
+	uint64_t btf = 0, data = 0, module = 0;
+	int data_size = 0;
+	bool ret = false;
+	char *btf_buf = NULL;
+	char *modname = NULL;
+
+	btf_modules = get_kallsyms_value_by_name("btf_modules");
+	if (!btf_modules)
+		/* Maybe module is not enabled, this is not an error */
+		return true;
+
+	INIT_STRUCT_MEMBER(btf_module, list);
+	INIT_STRUCT_MEMBER(btf_module, btf);
+	INIT_STRUCT_MEMBER(btf_module, module);
+	INIT_STRUCT_MEMBER(module, name);
+	INIT_STRUCT_MEMBER(btf, data);
+	INIT_STRUCT_MEMBER(btf, data_size);
+	modname = (char *)malloc(GET_STRUCT_MEMBER_MSIZE(module, name));
+	if (!modname)
+		goto no_mem;
+
+	for (list = next_list(btf_modules); list != btf_modules; list = next_list(list)) {
+		readmem(VADDR, list - MEMBER_OFF(btf_module, list) +
+				MEMBER_OFF(btf_module, btf),
+			&btf, GET_STRUCT_MEMBER_MSIZE(btf_module, btf));
+		readmem(VADDR, list - MEMBER_OFF(btf_module, list) +
+				MEMBER_OFF(btf_module, module),
+			&module, GET_STRUCT_MEMBER_MSIZE(btf_module, module));
+		readmem(VADDR, module + MEMBER_OFF(module, name),
+			modname, GET_STRUCT_MEMBER_MSIZE(module, name));
+		readmem(VADDR, btf + MEMBER_OFF(btf, data),
+			&data, GET_STRUCT_MEMBER_MSIZE(btf, data));
+		readmem(VADDR, btf + MEMBER_OFF(btf, data_size),
+			&data_size, GET_STRUCT_MEMBER_MSIZE(btf, data_size));
+		btf_buf = (char *)malloc(data_size);
+		if (!btf_buf)
+			goto no_mem;
+		readmem(VADDR, data, btf_buf, data_size);
+		btf_mod = btf__new_split(btf_buf, data_size, btf_arr[0].btf);
+		free(btf_buf);
+		if (libbpf_get_error(btf_mod) != 0 ||
+		    add_to_btf_arr(btf_mod, strdup(modname)) == false) {
+			fprintf(stderr, "%s: init %s btf fail\n", __func__, modname);
+			goto out;
+		}
+	}
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
+void cleanup_btf(void)
+{
+	for (int i = 0; i < btf_arr_len; i++) {
+		free(btf_arr[i].module);
+		btf__free(btf_arr[i].btf);
+	}
+	free(btf_arr);
+}
diff --git a/btf_info.h b/btf_info.h
index 1fc6829..d4408c3 100644
--- a/btf_info.h
+++ b/btf_info.h
@@ -16,7 +16,9 @@ struct struct_member_info {
 };
 
 bool init_kernel_btf(void);
+bool init_module_btf(void);
 bool get_struct_member_by_name(struct struct_member_info *smi);
+void cleanup_btf(void);
 
 struct member_off_size {
 	int m_off;
-- 
2.47.0


