Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF08606A31D
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wkiZK35k;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N6pJvN7j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3G8QhvNEpQ3sy+r1BDzvVBq/AXAxP3+qa6H4bl6GlDI=; b=wkiZK35kd5GCSAQPxzsAeDABUw
	+Ic6c6I98JpqGEdhA7XeKBTQM+o+EnfnMZgTy+MEOUVNqJYpooUiwR5iGTiRNEGoSEyzqc/3bXE9Y
	njXJBPFMrtpCGYVbwcAQ2rhd7UEnxyes+KQD/1VgbM616s0M7xszCImhGbUeMOGSdJb2A/mnTnrqi
	2m92ScSAgQdahpRvu9vPUQ1hvSKxoqotkf09qoYHkCxEdZwZKouwi3VS7xIhnvRhXy71TPj/yTet8
	Vgagq041RPdeMXPtYG8S/J727KgXzc5en1pMdi8LEAEKaEHx+pWn+xObyMPz4pTDHwDKJP8dGGykx
	DEFRI40Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOiN-000000030Yx-3erD;
	Mon, 26 Oct 2026 17:42:31 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOiH-000000030W9-1a07
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 17:42:27 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c40aa03ded8so345297966b.2
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793036543; x=1793641343; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3G8QhvNEpQ3sy+r1BDzvVBq/AXAxP3+qa6H4bl6GlDI=;
        b=N6pJvN7jsPUpTzRPBRnou6av08xZ/v5BBdVvBQCr/5IsVTmupecejdzcSH0WMCFaQM
         OHIjlIgeZ/Kz1DAWGEiVUjFYSFqbxBYXHhKjAnvr7NFvtZfzCXbeq+XWOgIeeAoFd033
         FYgPiWyfDrFv3GOButbX2LoGwWabcqtWpIe6U8c72fF63qxBrhFaLcgFZlE3xjaedFM7
         +hCJspHrDHvM3REroo7YstVf61SzdrxoZJkO66dp9jP66Ac+0PMrAl1AoTVNzqXZR53n
         ORUsXRw8SfZiL0MGq0oLoySc6cfDTLMazw/OrWtFiuMC06nDjJqvZlyiujIV9fwKIl6w
         +qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036543; x=1793641343;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3G8QhvNEpQ3sy+r1BDzvVBq/AXAxP3+qa6H4bl6GlDI=;
        b=ijY77LbwhE2AdHGShMqhPaZoGmmZ29DmdtIektB/l9GHSFijj/xAbzCAoXCQpVIGY8
         yZrx5+zq8tWiOoSiqXcbdLdANKk8g3jep9SrLjwvfKjDQAU5ZPNwfrwInbjECDNA6m+g
         e2PsrERMfPxbnFQxqY6+/+ZewX07s7WurVwjDZLxcpf8bwMPK7qOIaWX3nv9pn/f2kTY
         jHi45JULyRbJtD1Sowl/mkRnExLj6AeAz3tPfp71G/jLD+2cDjfDZqImTyB5o8ljpq5I
         YL1f3nAvqNptWBxaC4jc5IYJwjAx23zgBbhj7FgEqMVTIdFGc2q+GUYWO3Eze229CRwj
         G7gQ==
X-Forwarded-Encrypted: i=1; AKwUvByP9KK+VCP0LDO255V8BsKjbtgNysc+k5ae3zGl85mfzkmSd0KDx22HkmWhDx1K5fFNbkrmNA==@lists.infradead.org
X-Gm-Message-State: AFq9FYL3ROHauH4zztACscbdxVez+N0ebnIR7z1p6AU93yJFeEPk19pM
	U3grM8eclUZLVRIgrLTRs7pSPXSO3FuGUXoY9zeJGc9Zfyy8XHwfcOKofNJuNlhKuutUE+8Qj6w
	JGcfwQfBuVrSgXhNSCQ==
X-Received: from ejaw11.prod.google.com ([2002:a17:906:33cb:b0:c35:60c7:1880])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d18:b0:c3f:c856:fb7a with SMTP id a640c23a62f3a-c46bdaf85d7mr817347766b.3.1793036540600;
 Mon, 26 Oct 2026 10:42:20 -0700 (PDT)
Date: Mon, 26 Oct 2026 17:42:14 +0000
In-Reply-To: <20261026174217.603114-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026174217.603114-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026174217.603114-2-tarunsahu@google.com>
Subject: [RFC PATCH v3 1/4] liveupdate: Remove __packed from LUO and memfd ABI structures
From: Tarun Sahu <tarunsahu@google.com>
To: loganodell@google.com, alex@shazbot.org, dwmw2@infradead.org, 
	seanjc@google.com, Mike Rapoport <rppt@kernel.org>, will@kernel.org, pbonzini@redhat.com, 
	jgg@nvidia.com, Pasha Tatashin <pasha.tatashin@soleen.com>, arnd@arndb.de, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, oupton@kernel.org, 
	baolu.lu@linux.intel.com, David Matlack <dmatlack@google.com>, robin.murphy@arm.com, 
	maz@kernel.org, Alexander Graf <graf@amazon.com>, joro@8bytes.org, 
	Bjorn Helgaas <bhelgaas@google.com>, kevin.tian@intel.com, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_104225_445641_572A90C5 
X-CRM114-Status: GOOD (  15.02  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All structures in include/linux/kho/abi/luo.h (struct luo_ser, struct
luo_file_ser, struct luo_file_set_ser, struct luo_session_ser, struct
luo_flb_header_ser, struct luo_flb_ser) and include/linux/kho/abi/memfd.h
(struct memfd_luo_folio_ser, struct memfd_luo_ser) have naturally aligned
fields on 64-bit architectures, with no padding holes between fields or
tail padding. Any future unaligned field addition should come with
reserved field to keep the structure aligned.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h   | 25 +++++++++++++++++++------
 include/linux/kho/abi/memfd.h | 11 ++++++++---
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 288076de6d4a..899943877e41 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -58,6 +58,7 @@
 #define _LINUX_KHO_ABI_LUO_H
 
 #include <linux/align.h>
+#include <linux/build_bug.h>
 #include <linux/kho/abi/block.h>
 #include <uapi/linux/liveupdate.h>
 
@@ -82,7 +83,9 @@ struct luo_ser {
 	u64 liveupdate_num;
 	u64 sessions_pa;
 	u64 flbs_pa;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_ser) == 32);
 
 #define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
 
@@ -98,7 +101,9 @@ struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
 	u64 data;
 	u64 token;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_file_ser) == 64);
 
 /**
  * struct luo_file_set_ser - Represents the serialized metadata for file set
@@ -113,7 +118,9 @@ struct luo_file_ser {
 struct luo_file_set_ser {
 	u64 files;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_file_set_ser) == 16);
 
 /**
  * struct luo_session_ser - Represents the serialized metadata for a LUO session.
@@ -131,7 +138,9 @@ struct luo_file_set_ser {
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
 	struct luo_file_set_ser file_set_ser;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_session_ser) == 80);
 
 /* The max size is set so it can be reliably used during in serialization */
 #define LIVEUPDATE_FLB_COMPAT_LENGTH	48
@@ -152,7 +161,9 @@ struct luo_session_ser {
 struct luo_flb_header_ser {
 	u64 pgcnt;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_flb_header_ser) == 16);
 
 /**
  * struct luo_flb_ser - Represents the serialized state of a single FLB object.
@@ -175,7 +186,9 @@ struct luo_flb_ser {
 	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
 	u64 data;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_flb_ser) == 64);
 
 /* Kernel Live Update Test ABI */
 #ifdef CONFIG_LIVEUPDATE_TEST
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 08b10fea2afc..7115a8a77cfd 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_KHO_ABI_MEMFD_H
 #define _LINUX_KHO_ABI_MEMFD_H
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
 
@@ -20,7 +21,7 @@
  * memfd uses the ABI defined below for preserving its state across a kexec
  * reboot using the LUO.
  *
- * The state is serialized into a packed structure `struct memfd_luo_ser`
+ * The state is serialized into `struct memfd_luo_ser`
  * which is handed over to the next kernel via the KHO mechanism.
  *
  * This interface is a contract. Any modification to the structure layout
@@ -54,7 +55,9 @@ struct memfd_luo_folio_ser {
 	u64 pfn:52;
 	u64 flags:12;
 	u64 index;
-} __packed;
+};
+
+static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
 
 /*
  * The set of seals this version supports preserving. If support for any new
@@ -85,7 +88,9 @@ struct memfd_luo_ser {
 	u32 flags;
 	u64 nr_folios;
 	struct kho_vmalloc folios;
-} __packed;
+};
+
+static_assert(sizeof(struct memfd_luo_ser) == 48);
 
 /* The compatibility string for memfd file handler */
 #define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
-- 
2.56.0.307.g5fe7bd680c-goog


