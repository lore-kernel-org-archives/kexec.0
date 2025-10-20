Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D537DCCD1A2
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w9a91kqEyCyW2acnUHqEDuVLNTFL/yFC5OWVwOnkays=; b=S+owPU/utdq7wu3PlYkiV5QIgd
	equedaVEJXJz5Ddb9AHNi8Euf88BM+COl4bCSSLsmr/JiUuEG/qjXWa7pc6XhFlfWURNg8cj5/5Hi
	OjI0APT2P9IYui69zLKVHN0RgAEdJ+uYQyBHheUANSW/9yKNA75cfhqzqomsxHEOdq8MGt6IS1A1l
	8tgdc/cEuoFGT6JrbkDyCC1JsP4mmpgrJl6/BBX6Mub75jfXI+hm0rRTLY4reB9kkXD3NL4IwQIka
	h80fSfBkhZMKlcoDuj2mpdhPAlYazjUl/nVb5h9rsh/+0YBEbcHW5Um7C9QXY8KtYaT1V1ccdIjIH
	8ozFjP0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyLC-0000000FBPO-1JM4;
	Mon, 20 Oct 2025 22:26:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyL9-0000000FBOt-3FdL
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:26:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9a91kqEyCyW2acnUHqEDuVLNTFL/yFC5OWVwOnkays=;
	b=eFf9Sax/JwHYmcQulEARnbTfmepvPFbWZAKk/G3jUbm/cxgcV2YLJaPRNDeuM7TFp1vVJa
	TibhwAyvTWgFAd0KM+VDLqaJcE1svjzD0PH4D36ahaIeFp2Gj3Kr6UtDKgOZ5CJN8QGkO7
	mKHv+Tl16SK0d4+f8itdw7/OhcXXKJM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-yQXE0TiSMemyw2-vfW6RGg-1; Mon, 20 Oct 2025 18:24:55 -0400
X-MC-Unique: yQXE0TiSMemyw2-vfW6RGg-1
X-Mimecast-MFC-AGG-ID: yQXE0TiSMemyw2-vfW6RGg_1760999094
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso9614597b3a.0
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999094; x=1761603894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9a91kqEyCyW2acnUHqEDuVLNTFL/yFC5OWVwOnkays=;
        b=ODZv9sUDfvYy+cblZ1pfQM+TQINN/q/dcVDoDZNphc4ns0TtgT76mEbzLlU41OYIBN
         5E3KIOzu3L1ZCgYV+QzyMW//Ke6rvOfCheFVI8uNoLt9ryumi2ds+bs6oSbrToACgJG9
         dQf9aVJiBUysRIzhNEY/x67VH/MJ2Tpr9ACe/pyah8unQPkV2cObyNbcZCYWz0z1PxQJ
         kxw0kXpdhNZok4Go2waUmpt/XOzf0apODvIC1kqseU19SLxFuaO4NvckDRCijj+WAWBG
         dwRaHnd02ypB7V5EClvqbMtgyOPYUuoLisiWWFTv/KMqopEkyzuVI9VAPHAUzjv/J4t0
         Tm5w==
X-Forwarded-Encrypted: i=1; AJvYcCUL8K//ekDRUOP4PKc9z7Xq1O0Su3AXk68KQ7mos2BK4wQr/695IMkDJ2kcS+3nH81BwyCsMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxyox6gBWj8NW4aZCFy+BfOhmhWlVGOdMKa0IqoRHXpzBYzEotl
	OOYE+Utaql68sNAUHVXTyHMn6yRaUgqI3yHmQqpPT/P0mTSpo4Vbh2wCO7IClv1BANNLhoj3rit
	Ru22mYjWxamo08OqYvItyjVxTcmBianwk+L9hcu+imheVvb3NAyTKNZGBkPqyFg==
X-Gm-Gg: ASbGncuyxjxlwku4yBheC97FX0iJgEg7CrhKEFf2tY7t4gXGtZKC4iPlaz2ZJzlLF3u
	Fxlej/qlQO8KSW3WqyZx+NitP7TXHdKg6F+f0MpyHtifgeiP4CTMqy6euTRoS5OKQWUHVQOOKVJ
	ZkglcmntFsjC0DxW0QZf8mgvAseoRKheTkNaRruHHB96ulVosGvA8Wb5RLf6zUubAfnrsON7b2A
	zjyzn3lc08yhgNQ8rMuOAmxAF3E2TH8I30KtYrAzdbmck1IxxozLo0tJEY3PHOWUmb5k10qBW0d
	6WWsQwYcIAD0JbrHDa8zqEZj/zDxbnuqSGJDt6jRm+BpgBfwHyMB6WplIWJ4UdI6gDirC8i+gdQ
	edgdbFuhB8C2PEpHetkLppKZlwg5pXsxAf9M5GIkrUpQ=
X-Received: by 2002:a05:6a20:7344:b0:262:4378:9df2 with SMTP id adf61e73a8af0-334a86384femr17816323637.44.1760999094472;
        Mon, 20 Oct 2025 15:24:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETVOoXnwwWkcSMrjIPa0clJXTr/XDm+u2J7602UkkcoQLOXW6g/coSCHxNdypWuBin3vbG9g==
X-Received: by 2002:a05:6a20:7344:b0:262:4378:9df2 with SMTP id adf61e73a8af0-334a86384femr17816308637.44.1760999094116;
        Mon, 20 Oct 2025 15:24:54 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:53 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 10/14] Implement kernel module's btf resolving
Date: Tue, 21 Oct 2025 11:24:06 +1300
Message-ID: <20251020222410.8235-11-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C8Ohfu-7PnBpCOvXrlbrJAL9yqetbblxaxVSAxoQeVk_1760999094
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152655_889207_9DDF3D3D 
X-CRM114-Status: GOOD (  16.93  )
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
 btf.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 btf.h |   2 +
 2 files changed, 123 insertions(+)

diff --git a/btf.c b/btf.c
index ba376cf..5dd2047 100644
--- a/btf.c
+++ b/btf.c
@@ -796,3 +796,124 @@ int init_kernel_btf(void)
 	return ret;
 }
 
+int init_module_btf(void)
+{
+	uint64_t btf_modules, list;
+	struct member_info mi;
+	uint64_t btf = 0, data = 0, module = 0;
+	int data_size = 0;
+	char *btf_buf = NULL;
+	char *modname = NULL;
+
+	btf_modules = get_kallsyms_value_by_name("btf_modules");
+	if (!btf_modules)
+		/* Maybe module is not enabled, this is not an error */
+		return 0;
+
+	INIT_MEMBER_OFF_SIZE(btf_module, list);
+	INIT_MEMBER_OFF_SIZE(btf_module, btf);
+	INIT_MEMBER_OFF_SIZE(btf_module, module);
+	INIT_MEMBER_OFF_SIZE(module, name);
+	INIT_MEMBER_OFF_SIZE(btf, data);
+	INIT_MEMBER_OFF_SIZE(btf, data_size);
+	modname = (char *)malloc(GET_MEMBER_SIZE(module, name));
+	if (!modname) {
+		fprintf(stderr, "%s: Not enough memory!\n", __func__);
+		goto out;
+	}
+
+	for (list = next_list(btf_modules); list != btf_modules; list = next_list(list)) {
+		readmem(VADDR, list - GET_MEMBER_OFF(btf_module, list) +
+				GET_MEMBER_OFF(btf_module, btf),
+			&btf, GET_MEMBER_SIZE(btf_module, btf));
+		readmem(VADDR, list - GET_MEMBER_OFF(btf_module, list) +
+				GET_MEMBER_OFF(btf_module, module),
+			&module, GET_MEMBER_SIZE(btf_module, module));
+		readmem(VADDR, module + GET_MEMBER_OFF(module, name),
+			modname, GET_MEMBER_SIZE(module, name));
+		readmem(VADDR, btf + GET_MEMBER_OFF(btf, data),
+			&data, GET_MEMBER_SIZE(btf, data));
+		readmem(VADDR, btf + GET_MEMBER_OFF(btf, data_size),
+			&data_size, GET_MEMBER_SIZE(btf, data_size));
+		btf_buf = (char *)malloc(data_size);
+		if (!btf_buf) {
+			fprintf(stderr, "%s: Not enough memory!\n", __func__);
+			goto out;
+		}
+		readmem(VADDR, data, btf_buf, data_size);
+		if (init_btf_from_buf(modname, btf_buf, data_size))
+			goto out;
+		free(btf_buf);
+	}
+	return 0;
+out:
+	if (modname)
+		free(modname);
+	if (btf_buf)
+		free(btf_buf);
+	return -1;
+}
+
+void cleanup_btf(void)
+{
+	int bf_index, i;
+	struct btf_file *bf;
+	struct name_entry *en, *en_tmp;
+	DIR *temp_dir;
+	struct dirent *entry;
+	char path[512];
+
+	/* Free no-hashtable-installed elements */
+	for (bf_index = 0; bf_index < btf_files_array_index; bf_index++) {
+		bf = btf_files_array[bf_index];
+		if (bf && bf->array) {
+			for (i = 0; i < bf->array_len; i++) {
+				if (!bf->array[i]->name || !bf->array[i]->name[0])
+					free(bf->array[i]);
+			}
+		}
+	}
+
+	/* Free the hashtable-installed elements */
+	for (i = 0; i < NAME_HASH; i++) {
+		for (en = name_hash_table[i]; en;) {
+			en_tmp = en;
+			en = en->name_hash_next;
+			free(en_tmp);
+		}
+	}
+
+	/* Cleanup anything else */
+	for (bf_index = 0; bf_index < btf_files_array_index; bf_index++) {
+		bf = btf_files_array[bf_index];
+		if (bf && bf->array) {
+			free(bf->array);
+		}
+		if (bf && bf->file_name)
+			free(bf->file_name);
+		if (bf && bf->str_cache)
+			free(bf->str_cache);
+		if (bf)
+			free(bf);
+	}
+
+	if (btf_files_array)
+		free(btf_files_array);
+
+	/* Cleanup the dir /tmp/btf_XXXXXX */
+	temp_dir = opendir(temp);
+	if (!temp_dir)
+		return;
+	while ((entry = readdir(temp_dir)) != NULL) {
+		if (!strcmp(entry->d_name, ".") || !strcmp(entry->d_name, ".."))
+			continue;
+		snprintf(path, sizeof(path), "%s/%s", temp, entry->d_name);
+		if (remove(path)) {
+			fprintf(stderr, "%s: fail del %s!\n", __func__, path);
+			/* In case too many fail messages of files in the dir */
+			return;
+		}
+	}
+	closedir(temp_dir);
+	rmdir(temp);
+}
\ No newline at end of file
diff --git a/btf.h b/btf.h
index 424e9e0..2fcdfe1 100644
--- a/btf.h
+++ b/btf.h
@@ -166,6 +166,8 @@ void resolve_typedef(struct name_entry *, struct name_entry **, struct btf_type
 int get_btf_type_by_type_id(struct btf_file *, uint32_t,
 			    struct btf_type *, struct name_entry **);
 uint32_t id_to_uniq_id(uint32_t, struct btf_file *);
+int init_module_btf(void);
+void cleanup_btf(void);
 
 static inline uint32_t btf_kind(uint32_t info)
 {
-- 
2.47.0


