Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3560A263F
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gYjUjeoA;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lPam8Dk4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KlBTWBMpEbDIIvafpldBklRCZ2ctie9uKxzA73glXH4=; b=gYjUjeoAMr+vtysjnhHaHqmMHW
	BppAdsUXTHA+Qd6JVfTp09ZUt9DRF5S014ywzv2uqT70ssJx0R5abjFd8t1Ejr7AIRd8eLPaw7oon
	0eSn2bJ3meIj2P5hR5tOKyr2aTf2P4Cq8UWi6VVD92DwTj8jhiaLsMCmLfrL1E4utNMp/4JuMvq3m
	v2El/F/fZ1y8YS+I/RRnlCedaXKV1bKBzIbVPGdvdvtl4FuYXfTbau5M+6/CRT96p1mQcv+h58DUn
	4X/JPqPWuGaF+OBmg1vxICPSFx6z3T1jVsnU/cOvPdXfVF7S4gty3SkwoYYTZ7LNeeqNYg8jDJKhq
	y5dmWYFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe06-00000002Rkk-0eNa;
	Tue, 10 Nov 2026 05:02:30 +0000
Received: from mail-ed1-x546.google.com ([2a00:1450:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzt-00000002RMX-3cr0
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:21 +0000
Received: by mail-ed1-x546.google.com with SMTP id 4fb4d7f45d1cf-6a615ab0c06so1441578a12.2
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286935; x=1794891735; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlBTWBMpEbDIIvafpldBklRCZ2ctie9uKxzA73glXH4=;
        b=lPam8Dk4SBoWQr1V8saXqjHZ5ahFXYYtrYNMxe9ArJv+dRbQkQsei5rV5jyUqfdKeh
         +rTaW3+xr4KslP6ln6IRjHUmxlmREz5QmMIw2CAC+Sgl6oqfRA8IJv874cKahr2JHNBS
         fnJo3F7j56NK4/UxLNvVNcwCfQ+Jfge4qLlyNizCKPVrVNfUEynLUcZd1dmXy6nq8E/k
         lNnrYJGNh3kRqSZsLMRzihcBRCJdMDozXJ5odbcDZMtlbztBSirVmUNdBirIIADhyiTQ
         VAGYP/OBRq7pCYXaTupPLN7Qqo3FL7mBCd+IK6uyYV2JqBAEcQv49ilGD+klGsh6VK/Y
         hR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286935; x=1794891735;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KlBTWBMpEbDIIvafpldBklRCZ2ctie9uKxzA73glXH4=;
        b=iL71FaL58j80tqyNMh01e5Tfnh6cqRKhnU7bvn65pRjMB9NMQSEQ+16DjsA6INDLnj
         Yh/x48sN/QL4JySCoSJAVb9qbJIi+ldIQAMcR4uyYZQt48n1sUAVC7DDHZsR0800khZX
         DcfPNuu83RJNaLncRfG3qcTOyiLzkwBf3+kgT4o1kQXKV4gkn+f12wWGCnOj0eTKIZd1
         CTtMsuOk/Dg2Y+tZJ05xpnQfd9yLK6MZ1kL1BCCjGlROS5cuYMBp7oThGw2bo2j3jt4c
         WA/AU0xyAeqVLNQWubdGW8tdeiaYgQjkOgYp7Xp6b9hjkVev1Vz1yS9h7JagI1osfixf
         r88g==
X-Forwarded-Encrypted: i=1; AL+hErE1YcSnN7UANwgBxx+0aBa27QeMdxVtqBSQLmZ9pEzNe17ft5F5VS8REP6OCIbADRvj3myeyA==@lists.infradead.org
X-Gm-Message-State: APuU4Z8qXe8PnJ4aRil8KnN3FumH3gxhYNL6NSr3Ca4NjmEw70BsoQir
	huOb5eAIKHKYtv0j2aYMbYX8PDy6mgmpnPDIXo+6FBPrDlcVLRjkeiUdOfxyQJPSOa7EyqJncOr
	jiyBSjAOCQSGiDwbgCw==
X-Received: from ejpg24.prod.google.com ([2002:a17:906:7c58:b0:c3f:eea3:d5e9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d8f:b0:c44:9a32:b27 with SMTP id a640c23a62f3a-c5049623935mr98305266b.25.1794286935134;
 Mon, 09 Nov 2026 21:02:15 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:52 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-10-tarunsahu@google.com>
Subject: [PATCH v4 09/19] liveupdate: Add feature header to struct luo_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_210217_983648_8A1DAEAF 
X-CRM114-Status: GOOD (  29.05  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LUO and its file handlers currently rely solely on coarse-grained
compatibility strings (such as luo-v6 and memfd-v3) to validate
handed-over state across kexec. Because compatibility is checked only
at the whole-structure level, any change to a serialized structure,
even an optional additive field, requires bumping the compatibility
string and breaks live update between adjacent kernels.

Precede the centralized struct luo_ser with struct kho_ser_hdr using
DECLARE_KHO_SER. Subsystems can now evolve their serialized state at
per-feature granularity. Each subsystem groups the fields of its
serialized structure under feature indices, starting with index 0 for the
base fields. When a subsystem adds a new capability, it appends any new
fields to the end of its payload structure under a new feature index.
Retired fields are kept in place so existing field offsets never shift;
if the type or format of a field needs to change, the existing field and
feature are kept intact until retired and a new feature index with an
appended field of the new type is added. Only when a change requires a
complete break in the serialized layout or semantics that feature flags
cannot handle, a new handler can be introduced with an incremented version
number in its compatibility string.

Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h  | 64 +++++++++++++++---------------------
 kernel/liveupdate/luo_core.c | 39 +++++++++++++---------
 2 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index f1152470f71a..dfa7ea434d0d 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -9,29 +9,26 @@
  * DOC: Live Update Orchestrator ABI
  *
  * Live Update Orchestrator uses the stable Application Binary Interface
- * defined below to pass state from a pre-update kernel to a post-update
- * kernel. The ABI is built upon the Kexec HandOver framework and registers
- * the central `struct luo_ser` via the KHO raw subtree API.
+ * defined below to pass state from a source kernel to a target kernel.
+ * The ABI is built upon the Kexec HandOver framework and registers the
+ * central `struct luo_ser` via the KHO raw subtree API.
  *
- * This interface is a contract. Any modification to the structure fields,
- * compatible strings, or the layout of the `__packed` serialization
- * structures defined here constitutes a breaking change. Such changes require
- * incrementing the version number in the relevant `_COMPATIBLE` string to
- * prevent a new kernel from misinterpreting data from an old kernel.
- *
- * Changes are allowed provided the compatibility version is incremented;
- * however, backward/forward compatibility is only guaranteed for kernels
- * supporting the same ABI version.
+ * This interface is a contract. `struct luo_ser`, and the serialized state
+ * of each file handler that uses it, are preceded by `struct kho_ser_hdr`.
+ * See the KHO Serialization Feature Header ABI documentation in
+ * include/linux/kho/abi/feature.h for the header layout, the feature rules
+ * and validation.
  *
  * KHO Structure Overview:
  *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
- *   This entry contains the `struct luo_ser` structure.
+ *   This entry contains a `struct kho_ser_hdr` followed by the
+ *   `struct luo_ser` payload.
  *
  * Serialization Structures:
  *   - struct luo_ser:
- *     The central ABI structure that contains the overall state of the LUO.
- *     It includes the compatibility string, the liveupdate-number, and pointers
- *     to sessions and FLBs.
+ *     The central ABI payload structure that contains the overall state of
+ *     the LUO (the liveupdate-number and physical pointers to sessions and
+ *     FLBs), preceded by `struct kho_ser_hdr`.
  *
  *   - struct luo_session_ser:
  *     Metadata for a single session, including its name and a physical pointer
@@ -40,7 +37,7 @@
  *
  *   - struct luo_file_ser:
  *     Metadata for a single preserved file. Contains the `compatible` string to
- *     find the correct handler in the new kernel, a user-provided `token` for
+ *     find the correct handler in the target kernel, a user-provided `token` for
  *     identification, and an opaque `data` handle for the handler to use.
  *
  *   - struct luo_flb_header_ser:
@@ -57,39 +54,36 @@
 #ifndef _LINUX_KHO_ABI_LUO_H
 #define _LINUX_KHO_ABI_LUO_H
 
-#include <linux/align.h>
 #include <linux/build_bug.h>
 #include <linux/kconfig.h>
 #include <linux/kho/abi/block.h>
+#include <linux/kho/abi/feature.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/types.h>
 #include <uapi/linux/liveupdate.h>
 
 /*
  * The LUO state is registered under this KHO entry name.
  */
 #define LUO_KHO_ENTRY_NAME	"LUO"
-#define LUO_ABI_COMPATIBLE	"luo-v6"
-#define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
 
 /**
- * struct luo_ser - Centralized LUO ABI header.
- * @compatible:     Compatibility string identifying the LUO ABI version.
+ * struct luo_ser - Centralized LUO ABI payload.
  * @liveupdate_num: A counter tracking the number of successful live updates.
  * @sessions_pa:    Physical address of the first session block header.
  * @flbs_pa:        Physical address of the FLB header.
  *
- * This structure is the root of all preserved LUO state.
+ * This structure is the root payload of all preserved LUO state, preceded by
+ * &struct kho_ser_hdr.
  */
 struct luo_ser {
-	char compatible[LUO_ABI_COMPAT_LEN];
 	u64 liveupdate_num;
 	u64 sessions_pa;
 	u64 flbs_pa;
 };
 
-static_assert(sizeof(struct luo_ser) == 32);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_ser) == 8);
+/* Register luo_ser with KHO serialization accessors */
+DECLARE_KHO_SER(luo_ser, 24, 0, 0);
 
 #define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
 
@@ -98,8 +92,6 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  * @compatible:  File handler compatible string.
  * @data:        Private data
  * @token:       User provided token for this file
- *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
  */
 struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
@@ -138,10 +130,8 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  *
  * This structure is used to package session-specific metadata for transfer
  * between kernels via Kexec Handover. An array of these structures (one per
- * session) is created and passed to the new kernel, allowing it to reconstruct
- * the session context.
- *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * session) is created and passed to the target kernel, allowing it to
+ * reconstruct the session context.
  */
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
@@ -180,13 +170,13 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
 /**
  * struct luo_flb_ser - Represents the serialized state of a single FLB object.
  * @name:    The unique compatibility string of the FLB object, used to find the
- *           corresponding &struct liveupdate_flb handler in the new kernel.
+ *           corresponding &struct liveupdate_flb in the target kernel.
  * @data:    The opaque u64 handle returned by the FLB's .preserve() operation
- *           in the old kernel. This handle encapsulates the entire state needed
- *           for restoration.
+ *           in the source kernel. This handle encapsulates the entire state
+ *           needed for restoration.
  * @count:   The reference count at the time of serialization; i.e., the number
  *           of preserved files that depended on this FLB. This is used by the
- *           new kernel to correctly manage the FLB's lifecycle.
+ *           target kernel to correctly manage the FLB's lifecycle.
  *
  * An array of these structures is created in a preserved memory region and
  * passed to the new kernel. Each entry allows the LUO core to restore one
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..d0f72f27001d 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -66,7 +66,7 @@
 
 static struct {
 	bool enabled;
-	struct luo_ser *luo_ser_out;
+	DECLARE_KHO_SER_HDR(luo_ser, *luo_ser_out);
 	u64 liveupdate_num;
 } luo_global;
 
@@ -83,6 +83,7 @@ early_param("liveupdate", early_liveupdate_param);
 
 static int __init luo_early_startup(void)
 {
+	DECLARE_KHO_SER_HDR(luo_ser, *fhdr);
 	phys_addr_t luo_ser_phys;
 	struct luo_ser *luo_ser;
 	size_t len;
@@ -107,17 +108,21 @@ static int __init luo_early_startup(void)
 		return 0;
 	}
 
-	if (len < sizeof(*luo_ser)) {
-		pr_err("LUO state is too small (%zu < %zu)\n", len, sizeof(*luo_ser));
-		return -EINVAL;
+	fhdr = phys_to_virt(luo_ser_phys);
+	if (len < sizeof(*fhdr) || fhdr->size > len) {
+		pr_err("LUO state size invalid (source kernel header size=%u, KHO len=%zu)\n",
+		       len >= sizeof(*fhdr) ? fhdr->size : 0, len);
+		err = -EINVAL;
+		goto out_free_ser;
 	}
 
-	luo_ser = phys_to_virt(luo_ser_phys);
-	if (strncmp(luo_ser->compatible, LUO_ABI_COMPATIBLE, LUO_ABI_COMPAT_LEN)) {
-		pr_err("LUO state is incompatible with '%s'\n", LUO_ABI_COMPATIBLE);
-		return -EINVAL;
+	err = kho_ser_validate(fhdr, luo_ser);
+	if (err) {
+		pr_err("LUO state feature validation failed: %pe\n", ERR_PTR(err));
+		goto out_free_ser;
 	}
 
+	luo_ser = kho_ser_payload(fhdr, luo_ser);
 	luo_global.liveupdate_num = luo_ser->liveupdate_num;
 	pr_info("Retrieved live update data, liveupdate number: %lld\n",
 		luo_global.liveupdate_num);
@@ -131,7 +136,7 @@ static int __init luo_early_startup(void)
 	err = 0;
 
 out_free_ser:
-	kho_restore_free(luo_ser);
+	kho_restore_free(fhdr);
 	return err;
 }
 
@@ -153,16 +158,18 @@ early_initcall(liveupdate_early_init);
 /* Called during boot to create outgoing LUO state */
 static int __init luo_state_setup(void)
 {
+	DECLARE_KHO_SER_HDR(luo_ser, *fhdr);
 	struct luo_ser *luo_ser;
 	int err;
 
-	luo_ser = kho_alloc_preserve(sizeof(*luo_ser));
-	if (IS_ERR(luo_ser)) {
+	fhdr = kho_alloc_preserve(kho_ser_size(luo_ser));
+	if (IS_ERR(fhdr)) {
 		pr_err("failed to allocate/preserve LUO state memory\n");
-		return PTR_ERR(luo_ser);
+		return PTR_ERR(fhdr);
 	}
+	kho_ser_init(fhdr, luo_ser);
 
-	strscpy(luo_ser->compatible, LUO_ABI_COMPATIBLE, sizeof(luo_ser->compatible));
+	luo_ser = kho_ser_payload(fhdr, luo_ser);
 	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
 
 	luo_session_setup_outgoing(&luo_ser->sessions_pa);
@@ -171,16 +178,16 @@ static int __init luo_state_setup(void)
 	if (err)
 		goto exit_free_luo_ser;
 
-	err = kho_add_subtree(LUO_KHO_ENTRY_NAME, luo_ser, sizeof(*luo_ser));
+	err = kho_add_subtree(LUO_KHO_ENTRY_NAME, fhdr, fhdr->size);
 	if (err)
 		goto exit_free_luo_ser;
 
-	luo_global.luo_ser_out = luo_ser;
+	luo_global.luo_ser_out = fhdr;
 
 	return 0;
 
 exit_free_luo_ser:
-	kho_unpreserve_free(luo_ser);
+	kho_unpreserve_free(fhdr);
 	pr_err("failed to prepare LUO state: %d\n", err);
 
 	return err;
-- 
2.56.0.506.g506a7eabc5-goog


