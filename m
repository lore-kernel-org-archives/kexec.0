Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2FECE8D7B
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vhwkZEBEr5WhXa61Cp+OEzgGPmuzFUzbgIvGt1K8dx0=; b=q47jzqkAibeZ54H43NDJrXQi4+
	A6HpmRGPVOqw/9AWBOy8QMeXks0tLuDh7gGkFdxVu5lcF6qXpf4EOz5Tt9LfXFJ5ZQ7sRdkmEgp04
	iJUliexDaOKC5xqMd+rUSom4pLV/pnWx4V6cIAsJhNuJr21kFJ0tmQfSkGCcA1i967YtcXYOqIvJN
	IrEbeMO8y4trtVdA679zg/w6WVpyS8Ag8WKV9y4lcPsHKaAOmyWHk66Wo77lhGOj2r1ku3pxIH80+
	0PuOBRCkNujJSAg2dSQL0gN3eUHBqOZtTeD2RNN8zrdVxFbKcb9/izQ0JUqZN3IUBUIJvFxOZc2/l
	h7ulEjFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1x-0000000CzUO-4Bpg;
	Fri, 14 Nov 2025 19:00:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1w-0000000CzR0-1H6n
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 19:00:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=vhwkZEBEr5WhXa61Cp+OEzgGPmuzFUzbgIvGt1K8dx0=; b=JpT3CDe9GuQ78mIpmIu9mC73xQ
	d/IyTkCmWtf8QNNi1tBTZfpz3veqo+1Z/ZHR3l+fQaFQ6jJra9tmL1eya7flFcgp8E9bw4SpP67ZU
	vMQVqjehCOuVorIbmgvv2c1yyLeVaEZc9iJF5L8yxaCHJwfnxeGEzDtJ2EkFX45mDEzlwXlOVV5Z9
	w3eshXbwkxqAdocfTP0U7oaHY6vRn5tVRls3U39k256iEPEjjeuHUCWjKVYZ9PklqAIKJQmw3DRxv
	Z+PxdNzFiYYhCOhLgBEP+f8I5GrWq1EQg5s8hWsXx0EUKZ78EbDkiMJFTxdOT8M75sl4F/oqeus1j
	qQYpMzZQ==;
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJyAE-00000003JoS-3dOQ
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 18:04:52 +0000
Received: by mail-yx1-xb130.google.com with SMTP id 956f58d0204a3-640c857ce02so2221017d50.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146816; x=1763751616; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhwkZEBEr5WhXa61Cp+OEzgGPmuzFUzbgIvGt1K8dx0=;
        b=jyLmr47WZFFd/OdqYLQ6dBtj7uP5Dmc6Tv/sJAJ/s/nOm82ZdKtQuJmZFjmTJUBxFM
         4yxgC2We/1qv/CMlpK+lddive/5sGMpmRlFXkPTR6JewNC05I5/PdRhSP7sqAvYFk+DG
         isCXFswvHV+5KjVuD1HElkF08Ul6yuDnc6jTVtDRHMvOFioDZqDV9Rwm+fD+TnzV59zR
         zGsk88GYjS8o5WyA9qQeWv9NOMgGsPoYg9AWeiS801pQL+1ZIAhKj3wMpks1OSTEqt3K
         zGECvU9Cd0QKsQys++Y8keVR7DyDXiQfZU7yd+pGXlOsHgKXEbL4BhKWsJ94umSnu6Fn
         xuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146816; x=1763751616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vhwkZEBEr5WhXa61Cp+OEzgGPmuzFUzbgIvGt1K8dx0=;
        b=ui9szuIoDs7GAV2bEC0TLHNXYSEKBR2NRB6/2n9yAOsLRMB5aXlMQ3vRZIo+rJwQ2Q
         ffSU5MGjYixCDo++xRFdjVcC2I4rC5LyTexA4AA+ZffLKUq3HOdZRInfkxTzN7OilaJA
         kkztVWembyWNtf/A54b7Deo6Kgh4li0FYCNZPdiaiW9G85MUZ9Y8Ks9tGxH4VqQSJjfP
         TEkv6EzZW/VFDuLpw/JCzg6FeFp/ETOu+aUeSwTcDefYoYFF6nhxYoPy8PWZVr9L8/xb
         hIeZ8QWJxU6wSeqQ7akGkllWiJlIU1UFrerOEr0wWDcPw4c2dCbPZnNJ03upUXQmDI/L
         xd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy9GynhYwyoxdTofgCUNBCYXT00xJ0U/GJVd9fVQnTQNUmg+hdeQKNJZgh/DhYmne47QlTcw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxVx6TdWwD0OMVvCcPnZ451awlRILt2mRnkKE72U9JSIg/48lNp
	BlLxopSTGsvcvHkbrGrYS8VWqyok7/TqRNv1jRp+W0w2uwQMNr3bA0sjtq9eeNo79aE=
X-Gm-Gg: ASbGncsFJ7zTSAqL78qgsAqDV2/LmZeBmqjSoh/oSEkcL5gT6wNA6dB0xYYozwBfwGR
	xutjcy1PVybh4iVeoPswhBJXujTMU+fTpy+B58E835WCACsdbdXiDn3aTfOyUUxuNAGva5Y9+ws
	3aGYBPwHG3afBmctJHK3vJ1IY7szxVurLvHw8P1W9O7yxww3nYaF+gxhSimVpzJmW5TbKu3/9uq
	jhp5D2mvCPSkXoyDynf8VeVQNkvH2S4GglPsfUMtufnrv/86wsYCSOPhueYSjOzAv0WuoYT577Q
	2tZTQkNpBPTU5gbU1QS4EuEy23W18JWCS/1UXSnlSK1AtGlU4vcquJWCktEtYsrB9XA+7EelMES
	kHjaGXgGh5o9SDHqk7TPzuPe3amWT0e7fh6xJ6vZoPVzFlMPdB0YjcsFTAKI7cdpBBhiAkIoDyD
	N4NmEISst9S+kdW4KJrowWGSs2moGhJQyRoXxUG/IXGEKgwRY0KFCHO8CVDkUJdzcMz7MYmKkUM
	22/j6M=
X-Google-Smtp-Source: AGHT+IHftz04artgctWkQtgZIqMhYzNUfbd5DWlI95J4Cany7ZO/gJCBBXAhqFr39ej1tMVzPCYDjg==
X-Received: by 2002:a53:acc3:0:10b0:63f:ba88:e905 with SMTP id 956f58d0204a3-641e757cfa3mr2955979d50.30.1763146815780;
        Fri, 14 Nov 2025 11:00:15 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:15 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 08/13] kho: Remove global preserved_mem_map and store state in FDT
Date: Fri, 14 Nov 2025 13:59:57 -0500
Message-ID: <20251114190002.3311679-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_180450_979282_3DD7D7AB 
X-CRM114-Status: GOOD (  16.16  )
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

Currently, the serialized memory map is tracked via
kho_out.preserved_mem_map and copied to the FDT during finalization.
This double tracking is redundant.

Remove preserved_mem_map from kho_out. Instead, maintain the physical
address of the head chunk directly in the preserved-memory-map FDT
property.

Introduce kho_update_memory_map() to manage this property. This function
handles:
1. Retrieving and freeing any existing serialized map (handling the
   abort/retry case).
2. Updating the FDT property with the new chunk address.

This establishes the FDT as the single source of truth for the handover
state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 43 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 297136054f75..63800f63551f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -119,9 +119,6 @@ struct kho_out {
 	struct mutex fdts_lock;
 
 	struct kho_mem_track track;
-	/* First chunk of serialized preserved memory map */
-	struct khoser_mem_chunk *preserved_mem_map;
-
 	struct kho_debugfs dbg;
 };
 
@@ -382,6 +379,27 @@ static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
 	}
 }
 
+/*
+ *  Update memory map property, if old one is found discard it via
+ *  kho_mem_ser_free().
+ */
+static void kho_update_memory_map(struct khoser_mem_chunk *first_chunk)
+{
+	void *ptr;
+	u64 phys;
+
+	ptr = fdt_getprop_w(kho_out.fdt, 0, PROP_PRESERVED_MEMORY_MAP, NULL);
+
+	/* Check and discard previous memory map */
+	phys = get_unaligned((u64 *)ptr);
+	if (phys)
+		kho_mem_ser_free((struct khoser_mem_chunk *)phys_to_virt(phys));
+
+	/* Update with the new value */
+	phys = first_chunk ? (u64)virt_to_phys(first_chunk) : 0;
+	put_unaligned(phys, (u64 *)ptr);
+}
+
 static int kho_mem_serialize(struct kho_out *kho_out)
 {
 	struct khoser_mem_chunk *first_chunk = NULL;
@@ -422,7 +440,7 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 		}
 	}
 
-	kho_out->preserved_mem_map = first_chunk;
+	kho_update_memory_map(first_chunk);
 
 	return 0;
 
@@ -1223,8 +1241,7 @@ int kho_abort(void)
 	if (!kho_out.finalized)
 		return -ENOENT;
 
-	kho_mem_ser_free(kho_out.preserved_mem_map);
-	kho_out.preserved_mem_map = NULL;
+	kho_update_memory_map(NULL);
 	kho_out.finalized = false;
 
 	return 0;
@@ -1234,21 +1251,15 @@ static int __kho_finalize(void)
 {
 	void *root = kho_out.fdt;
 	struct kho_sub_fdt *fdt;
-	u64 *preserved_mem_map;
+	u64 empty_mem_map = 0;
 	int err;
 
 	err = fdt_create(root, PAGE_SIZE);
 	err |= fdt_finish_reservemap(root);
 	err |= fdt_begin_node(root, "");
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
-	/**
-	 * Reserve the preserved-memory-map property in the root FDT, so
-	 * that all property definitions will precede subnodes created by
-	 * KHO callers.
-	 */
-	err |= fdt_property_placeholder(root, PROP_PRESERVED_MEMORY_MAP,
-					sizeof(*preserved_mem_map),
-					(void **)&preserved_mem_map);
+	err |= fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem_map,
+			    sizeof(empty_mem_map));
 	if (err)
 		goto err_exit;
 
@@ -1271,8 +1282,6 @@ static int __kho_finalize(void)
 	if (err)
 		goto err_exit;
 
-	*preserved_mem_map = (u64)virt_to_phys(kho_out.preserved_mem_map);
-
 	return 0;
 
 err_exit:
-- 
2.52.0.rc1.455.g30608eb744-goog


