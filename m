Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCB3CD6E65
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6dIvXcFtnsq21AdbL6IuUE0knwOnoW1aNxCP2lCoxdM=; b=2qouLEoEaWH5JT6Ue768oaWELP
	5lXe2O8HoDjhZtm9+Lp+aov0IcdETaYwzOXq/X3ncrVsiPhU4w6S5NZEc8t4Ybndt2lT7Lv/6W1wk
	GVf7Qrs8uf2qc5g61L6v/D2HfMs4XiwFxmvCPEVHCsJLUmlygDPvuBFHcyc0KTJX3uqScaA7DNDYk
	dSLNzIOdy6mVIBWbPsDmuP7OKZeDKEcJ7YrJ5u9EIiSLnRNGMvWIy1uobRDkbJRJ8N4fTgW3mWrdN
	myZOvuZwVpIxfflWN8EYtD1VgIThmkXCEGWlet6MvrKgE4/f/j/00MctwBeCt2q8SyBtqDhUT2Mfa
	nNYf/31w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdA-0000000CDDm-1mkB;
	Tue, 02 Jun 2026 03:17:28 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFd7-0000000CDB7-2AyE
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:26 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-5176b9c476aso1447661cf.3
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370244; x=1780975044; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dIvXcFtnsq21AdbL6IuUE0knwOnoW1aNxCP2lCoxdM=;
        b=E924fLkSKKLuiKMX9aA6JdJbleSo9z5Z0vTtLH/ceUJfp3JrUUuFzoIfS+sNdY89KT
         3e17S9jpH+uqdP5Iv/RCD2YL2VZWOuRVJFnrbDLd0BWs2SuRip7ZnOQolVZdB9xLluyL
         b817DhWrS++r51sI8q261to/m2MqUcRWPZfaRTNppbopisciQN/yqFqRXK45a+Vk8w+o
         BhRGfkZ7H+aSujYHxHjuk/HFjshpRoomgkou94Fb+2wH53vzxN3PVVpcwcm8FQQ86HLf
         cpU+kFTVDjVX+vzchiKSzXw33wLg1SzL7BvYZOp1tURfg0VqAbN2bUl+leEop47+n3DE
         +W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370244; x=1780975044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6dIvXcFtnsq21AdbL6IuUE0knwOnoW1aNxCP2lCoxdM=;
        b=d50ddjDHXrSYSHyZ3TjOnzMRJYafv0KwNevbZVv1DJWtxY28JrNCSGOuibkV5w0MCA
         fpcRE0wyiKm8G+UUPzYeHt43Oa4SHGsbTct/JWzaz0UtdpALACyhwOYAYcBS7ZiBcU+D
         OXg7CND0HASp3Urb/yrK4WuIyaDXQ2yiljeha4KhQH/blMunrhCxeSZHG3I50FMKL0hB
         pRFpvJY0rPgtAkdLEJLl6z5k2uaGLfsjueNH/Zf8izz2nw/Sx5yqM1UNi66Sn6XUhZWx
         sY4/pGI344qz9bLFfIqi9/SrVOtM4Yesm2XW97o7d/kwZQpN/zInaPQRs9s1pcU9l1pC
         xHIg==
X-Forwarded-Encrypted: i=1; AFNElJ+a3KCu3A4vCm4Qmc64hHW1oqlYt1A+LBodg5ryP1ohc6FtG0AnzZE/kb0MIrWVeXwIjxFmFw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywwjd3z8nGeJObQxyCREB/33IUrhieumufWSFPjuXYxZclaCprC
	RqVWWz5WV6WmDTs+K5B3p899JIaXTWMfaw0OOZUnhvXtrfMPo/KYlN5Pv0h43qtr1qU=
X-Gm-Gg: Acq92OFOJI2pk7CcAl+ZM35slAANeXclykM1vZf+tnB4kz8ZzTGz63cN5rq5YsyD4eM
	3U0OUW9ImwVGlYJj3kmMaeVgR+z+65ZmqWnY4MIidEuUGaCM6LvI1/7BUCBh1geiDYEO8fynxPw
	wpiNN76TFgAWG28ZLaUdwcO1m6k9BClWOaoRXwDKxRkFfeQVTFQsFihi0HM5oWgqdZrnMKbea0z
	0oBGb6ZCeoJVGnbMTiqk9kL1fa7UW5RCGYqBQDfaPCq8pzgW8IrtRm6pXxNlwKzNeUI7o/Regrh
	Jxm58Z+r6dvUCFfocWRN25F3TmTgSffFPqm8CZtmt95lxIxvC/5O7VLjfNOU9FbLcHgdJdtieOu
	cJc+ssEXWGFV0wA6Q1eq/sgj5HnilKQ05d5PQezUtwVwA0lcz2AOmMTm/7vxwLUM/a0x2BesWDT
	kz/Il7cjS0cJ8/pq647fkgNxEqSPZr0G4MgWOzupWXZUFMAvDHU/Itky9FeeHxFQ==
X-Received: by 2002:a05:622a:1882:b0:517:6c96:8f1a with SMTP id d75a77b69052e-5176c968ff0mr8717501cf.10.1780370244108;
        Mon, 01 Jun 2026 20:17:24 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:23 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v5 04/13] liveupdate: register luo_ser as KHO subtree
Date: Tue,  2 Jun 2026 03:17:08 +0000
Message-ID: <20260602031717.197696-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201725_666379_654D6643 
X-CRM114-Status: GOOD (  25.43  )
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

Entirely remove the LUO FDT wrapper since the FDT only carries the
compatible string and the pointer to the centralized struct luo_ser.
Instead, register the struct luo_ser via the KHO raw subtree
API, placing the compatibility string inside the structure itself.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/luo.h  | 57 +++++++++---------------
 kernel/liveupdate/luo_core.c | 85 +++++++++++-------------------------
 2 files changed, 46 insertions(+), 96 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 1b2f865a771a..9a4fe491812b 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -10,11 +10,11 @@
  *
  * Live Update Orchestrator uses the stable Application Binary Interface
  * defined below to pass state from a pre-update kernel to a post-update
- * kernel. The ABI is built upon the Kexec HandOver framework and uses a
- * Flattened Device Tree to describe the preserved data.
+ * kernel. The ABI is built upon the Kexec HandOver framework and registers
+ * the central `struct luo_ser` via the KHO raw subtree API.
  *
- * This interface is a contract. Any modification to the FDT structure, node
- * properties, compatible strings, or the layout of the `__packed` serialization
+ * This interface is a contract. Any modification to the structure fields,
+ * compatible strings, or the layout of the `__packed` serialization
  * structures defined here constitutes a breaking change. Such changes require
  * incrementing the version number in the relevant `_COMPATIBLE` string to
  * prevent a new kernel from misinterpreting data from an old kernel.
@@ -23,31 +23,15 @@
  * however, backward/forward compatibility is only guaranteed for kernels
  * supporting the same ABI version.
  *
- * FDT Structure Overview:
+ * KHO Structure Overview:
  *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
- *   This entry contains an FDT with the following layout:
- *
- *   .. code-block:: none
- *
- *     / {
- *         compatible = "luo-v2";
- *         luo-abi-header = <phys_addr_of_luo_ser>;
- *     };
- *
- * Main LUO Node (/):
- *
- *   - compatible: "luo-v2"
- *     Identifies the overall LUO ABI version.
- *   - luo-abi-header: u64
- *     The physical address of `struct luo_ser`.
+ *   This entry contains the `struct luo_ser` structure.
  *
  * Serialization Structures:
- *   The FDT properties point to memory regions containing arrays of simple,
- *   `__packed` structures. These structures contain the actual preserved state.
- *
  *   - struct luo_ser:
  *     The central ABI structure that contains the overall state of the LUO.
- *     It includes the liveupdate-number and pointers to sessions and FLBs.
+ *     It includes the compatibility string, the liveupdate-number, and pointers
+ *     to sessions and FLBs.
  *
  *   - struct luo_session_header_ser:
  *     Header for the session array. Contains the total page count of the
@@ -78,26 +62,27 @@
 #ifndef _LINUX_KHO_ABI_LUO_H
 #define _LINUX_KHO_ABI_LUO_H
 
+#include <linux/align.h>
 #include <uapi/linux/liveupdate.h>
 
 /*
- * The LUO FDT hooks all LUO state for sessions, fds, etc.
+ * The LUO state is registered under this KHO entry name.
  */
-#define LUO_FDT_SIZE		PAGE_SIZE
-#define LUO_FDT_KHO_ENTRY_NAME	"LUO"
-#define LUO_FDT_COMPATIBLE	"luo-v2"
-#define LUO_FDT_ABI_HEADER	"luo-abi-header"
+#define LUO_KHO_ENTRY_NAME	"LUO"
+#define LUO_ABI_COMPATIBLE	"luo-v3"
+#define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
 
 /**
  * struct luo_ser - Centralized LUO ABI header.
+ * @compatible:     Compatibility string identifying the LUO ABI version.
  * @liveupdate_num: A counter tracking the number of successful live updates.
  * @sessions_pa:    Physical address of the first session block header.
  * @flbs_pa:        Physical address of the FLB header.
  *
- * This structure is the root of all preserved LUO state. It is pointed to by
- * the "luo-abi-header" property in the LUO FDT.
+ * This structure is the root of all preserved LUO state.
  */
 struct luo_ser {
+	char compatible[LUO_ABI_COMPAT_LEN];
 	u64 liveupdate_num;
 	u64 sessions_pa;
 	u64 flbs_pa;
@@ -111,7 +96,7 @@ struct luo_ser {
  * @data:        Private data
  * @token:       User provided token for this file
  *
- * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
+ * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
  */
 struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
@@ -142,7 +127,7 @@ struct luo_file_set_ser {
  * physical memory preserved across the kexec. It provides the necessary
  * metadata to interpret the array of session entries that follow.
  *
- * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
+ * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
  */
 struct luo_session_header_ser {
 	u64 count;
@@ -159,7 +144,7 @@ struct luo_session_header_ser {
  * session) is created and passed to the new kernel, allowing it to reconstruct
  * the session context.
  *
- * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
+ * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
  */
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
@@ -180,7 +165,7 @@ struct luo_session_ser {
  * This structure is located at the physical address specified by the
  * flbs_pa in luo_ser.
  *
- * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
+ * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
  */
 struct luo_flb_header_ser {
 	u64 pgcnt;
@@ -202,7 +187,7 @@ struct luo_flb_header_ser {
  * passed to the new kernel. Each entry allows the LUO core to restore one
  * global, shared object.
  *
- * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
+ * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
  */
 struct luo_flb_ser {
 	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 085c0dfc1ef1..69b00e7d0f8f 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -54,7 +54,6 @@
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/luo.h>
 #include <linux/kobject.h>
-#include <linux/libfdt.h>
 #include <linux/liveupdate.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
@@ -67,8 +66,7 @@
 
 static struct {
 	bool enabled;
-	void *fdt_out;
-	void *fdt_in;
+	struct luo_ser *luo_ser_out;
 	u64 liveupdate_num;
 } luo_global;
 
@@ -85,11 +83,10 @@ early_param("liveupdate", early_liveupdate_param);
 
 static int __init luo_early_startup(void)
 {
+	phys_addr_t luo_ser_phys;
 	struct luo_ser *luo_ser;
-	int err, header_size;
-	phys_addr_t fdt_phys;
-	const void *ptr;
-	u64 luo_ser_pa;
+	size_t len;
+	int err;
 
 	if (!kho_is_enabled()) {
 		if (liveupdate_enabled())
@@ -98,40 +95,29 @@ static int __init luo_early_startup(void)
 		return 0;
 	}
 
-	/* Retrieve LUO subtree, and verify its format. */
-	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys, NULL);
+	/* Retrieve LUO state from KHO. */
+	err = kho_retrieve_subtree(LUO_KHO_ENTRY_NAME, &luo_ser_phys, &len);
 	if (err) {
 		if (err != -ENOENT) {
-			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
-			       LUO_FDT_KHO_ENTRY_NAME, ERR_PTR(err));
+			pr_err("failed to retrieve LUO state '%s' from KHO: %pe\n",
+			       LUO_KHO_ENTRY_NAME, ERR_PTR(err));
 			return err;
 		}
 
 		return 0;
 	}
 
-	luo_global.fdt_in = phys_to_virt(fdt_phys);
-	err = fdt_node_check_compatible(luo_global.fdt_in, 0,
-					LUO_FDT_COMPATIBLE);
-	if (err) {
-		pr_err("FDT '%s' is incompatible with '%s' [%d]\n",
-		       LUO_FDT_KHO_ENTRY_NAME, LUO_FDT_COMPATIBLE, err);
-
+	if (len < sizeof(*luo_ser)) {
+		pr_err("LUO state is too small (%zu < %zu)\n", len, sizeof(*luo_ser));
 		return -EINVAL;
 	}
 
-	header_size = 0;
-	ptr = fdt_getprop(luo_global.fdt_in, 0, LUO_FDT_ABI_HEADER, &header_size);
-	if (!ptr || header_size != sizeof(u64)) {
-		pr_err("Unable to get ABI header '%s' [%d]\n",
-		       LUO_FDT_ABI_HEADER, header_size);
-
+	luo_ser = phys_to_virt(luo_ser_phys);
+	if (strncmp(luo_ser->compatible, LUO_ABI_COMPATIBLE, LUO_ABI_COMPAT_LEN)) {
+		pr_err("LUO state is incompatible with '%s'\n", LUO_ABI_COMPATIBLE);
 		return -EINVAL;
 	}
 
-	luo_ser_pa = get_unaligned((u64 *)ptr);
-	luo_ser = phys_to_virt(luo_ser_pa);
-
 	luo_global.liveupdate_num = luo_ser->liveupdate_num;
 	pr_info("Retrieved live update data, liveupdate number: %lld\n",
 		luo_global.liveupdate_num);
@@ -164,37 +150,20 @@ static int __init liveupdate_early_init(void)
 }
 early_initcall(liveupdate_early_init);
 
-/* Called during boot to create outgoing LUO fdt tree */
-static int __init luo_fdt_setup(void)
+/* Called during boot to create outgoing LUO state */
+static int __init luo_state_setup(void)
 {
 	struct luo_ser *luo_ser;
-	u64 luo_ser_pa;
-	void *fdt_out;
 	int err;
 
-	fdt_out = kho_alloc_preserve(LUO_FDT_SIZE);
-	if (IS_ERR(fdt_out)) {
-		pr_err("failed to allocate/preserve FDT memory\n");
-		return PTR_ERR(fdt_out);
-	}
-
 	luo_ser = kho_alloc_preserve(sizeof(*luo_ser));
 	if (IS_ERR(luo_ser)) {
-		err = PTR_ERR(luo_ser);
-		goto exit_free_fdt;
+		pr_err("failed to allocate/preserve LUO state memory\n");
+		return PTR_ERR(luo_ser);
 	}
-	luo_ser_pa = virt_to_phys(luo_ser);
-
-	err = fdt_create(fdt_out, LUO_FDT_SIZE);
-	err |= fdt_finish_reservemap(fdt_out);
-	err |= fdt_begin_node(fdt_out, "");
-	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
-	err |= fdt_property(fdt_out, LUO_FDT_ABI_HEADER, &luo_ser_pa,
-			    sizeof(luo_ser_pa));
-	err |= fdt_end_node(fdt_out);
-	err |= fdt_finish(fdt_out);
-	if (err)
-		goto exit_free_luo_ser;
+
+	strscpy(luo_ser->compatible, LUO_ABI_COMPATIBLE, sizeof(luo_ser->compatible));
+	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
 
 	err = luo_session_setup_outgoing(&luo_ser->sessions_pa);
 	if (err)
@@ -204,21 +173,17 @@ static int __init luo_fdt_setup(void)
 	if (err)
 		goto exit_free_luo_ser;
 
-	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
-
-	err = kho_add_subtree(LUO_FDT_KHO_ENTRY_NAME, fdt_out,
-			      fdt_totalsize(fdt_out));
+	err = kho_add_subtree(LUO_KHO_ENTRY_NAME, luo_ser, sizeof(*luo_ser));
 	if (err)
 		goto exit_free_luo_ser;
-	luo_global.fdt_out = fdt_out;
+
+	luo_global.luo_ser_out = luo_ser;
 
 	return 0;
 
 exit_free_luo_ser:
 	kho_unpreserve_free(luo_ser);
-exit_free_fdt:
-	kho_unpreserve_free(fdt_out);
-	pr_err("failed to prepare LUO FDT: %d\n", err);
+	pr_err("failed to prepare LUO state: %d\n", err);
 
 	return err;
 }
@@ -234,7 +199,7 @@ static int __init luo_late_startup(void)
 	if (!liveupdate_enabled())
 		return 0;
 
-	err = luo_fdt_setup();
+	err = luo_state_setup();
 	if (err)
 		luo_global.enabled = false;
 
-- 
2.53.0


