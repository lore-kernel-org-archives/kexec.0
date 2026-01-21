Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE44AC44536
	for <kexec@archiver.kernel.org>; Wed, 21 Jan 2026 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8K6PyvxGfU1AMGKy34QhFpjB02JAayEePw3faIpbm3c=; b=N4LNhhVeSg5oyBj6gqI9oIwQet
	XBSeoe7MxSGbFpqT9xfXiH/uTptBXIkcUN1nXj+w9r5iGskaL9aKSO/TvqIm1e62yUuaL9VqiM3k+
	Q6nQ6oi7RpapTrIQamX8kEbhn8Ax+33R1DKY9olYHE4fhVxVmITYQceKMBJbZMRqJG757tbLaCpNu
	B6O+/dCT3GbJTlykU8YGgYeA7ESFjFaNtRYOqqd9wIcSZK0jYA8NP0+aorluULDwqmflaPMJ6ffxq
	rdBc8i5ui+41F7m85svf6R//jrKiqrJhcjwdxKvQcDPokV8f/EQEuW+Ua+OV6RdnXePO54WJFZ8O7
	U+sADppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vibHG-00000005oYS-0nGN;
	Wed, 21 Jan 2026 16:41:54 +0000
Received: from mail-qt1-f179.google.com ([209.85.160.179])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vibHC-00000005oXy-2vVB
	for kexec@lists.infradead.org;
	Wed, 21 Jan 2026 16:41:52 +0000
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5029fb0b977so23781cf.0
        for <kexec@lists.infradead.org>; Wed, 21 Jan 2026 08:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769013708; x=1769618508;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K6PyvxGfU1AMGKy34QhFpjB02JAayEePw3faIpbm3c=;
        b=q9DWAIMR24Madb6pG1cDuWu6LP4WKTC9w01fcTHzdcHSs2+IxzsPB6JPQIvpI4RrxG
         UqHbKjsqz+YR8RMXDBvPyGokt51D35Fy8rvrlVJdN/CUrXX1btR+vnvy3GOVYDtiaHmw
         oA4Eq6IG70hKL/vrWV0F12B3Wn7WkAtQBzTCZ97xa7QvbP9sLPN8gqlo7sSjFEZEVIDr
         +LHSAmvxcOoHZrGWQWXT4qhzfsoRJXu1EIjpMpYHE4T+zY/ldh9fA5WjnTpwqgX0U5pq
         Hl0dNqNef5YSLMQfnVmG394B1UHxIp642otXfx4ia1lnzp0MKHJDKm9YAsgUfWzRyLb/
         3Xqg==
X-Forwarded-Encrypted: i=1; AJvYcCVr/TWPGxPUQf591ezIpBSb2dZxUZzrRc3fMZXtDlGtnvA7VuGjkPxwG3/rd5DgykYTT1i4Nw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwdbqQGybOlnAKsF0dayGjp8gultk8Rmx5tPixHrRAKe6NezflI
	djcm62Aj5zGcq67ML8xcHqtNXZPLDoTy4ghV0QZPbfqKZfSyJgYhG+u+IhMpGA==
X-Gm-Gg: AZuq6aKrK/xTQ7bK5MJjbbmAY8O6DuMJFBI9TNC9+UMWWHHPvb1il0N7/rifW9cxbmb
	xjd248GGKQ1PGaKnxnxE6VOJg/qmbmL3AhYd+2I2xtwEnfz044cMl2e9OgChjzy2axuqBbclJSF
	fx2w2fwS3InMeGt4y6WMERjbmejQf37Bj9kfHpFW+lT9GqG5icpl9c3w0lczdvgSO8cUtHHY6xt
	q3CQ8j8ZdGN4T91V2EIogcPrJYObpSNZF2obHIMh0qYskDV4+a77CtQUbRLObiPTGxRSe/bdAXE
	OBPbeW+nFtZJFzAUVO+kUU8ifKHxA7a/H86o1BUMh/hOlxW4SR95kHohHhCfTc7ADeoiGxMikSl
	bONMbLe8lIjjIO3YmEFqYBCb1TJNnr7ETJdERdZahMOsD2GfStziehP/Nr1KYqhhYer5ZMxOdI4
	O5HA==
X-Received: by 2002:a05:6820:1798:b0:659:9a49:8fef with SMTP id 006d021491bc7-6611796ece0mr9284384eaf.28.1769007054264;
        Wed, 21 Jan 2026 06:50:54 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662b6c3ec82sm1497158eaf.17.2026.01.21.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:50:53 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 06:50:38 -0800
Subject: [PATCH v4] kho: kexec-metadata: track previous kernel chain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
X-B4-Tracking: v=1; b=H4sIAL7ncGkC/2XNwarCMBCF4VcJs3YkM4lN25XvIS4SM9rcC60kW
 hTpu0stguJy4Hz/PKBITlKgVQ/IMqaShh5aZVcKDp3vT4IpQquANW+Ijcb/bkDntJPasxxJYKX
 gnOWYbq/Kbr/c5Rr+5HCZ6bzoUrkM+f56M9K8+y6OhIQ2umbj2UbfyDZKSL5fD/kEc3LkN6o0a
 V4Qo0Zy1gXyxlOsfpD5RPWCDGoMFKvgfN0Yy19omqYngDDDgBMBAAA=
X-Change-ID: 20251230-kho-7707e8a2ef1e
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=7440; i=leitao@debian.org;
 h=from:subject:message-id; bh=hUYPRcba9zfyDjZaQs2u9sw+0GVuFqBCoC/amy5CRqs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcOfNxE5Gja7tEx8/C45TJeRXvSRq4Q5AukReO
 pNqlM55YuSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXDnzQAKCRA1o5Of/Hh3
 bZ87D/9s8Zqi9foS429xPJJzR8//2drUdxcbvNbh85j9cvjJxmV1E9CFsRUC/Y/udMVEFTqkgxl
 YCkEPWKpnhFsbIdCKyabGr/EdbLYtPc9tlvgU3ruuCi/iApEAOvrouuiKVDCi2nOvdeWfnrAOKR
 NvmUZBmCj3VCoT1n+u6LmG7JlSTVN9o233+ZIG6W6mwt/hIabdYCKiOPE+NN5cU5sz4vmQJdryE
 CxTzXPkIAdcN9y9mj2Cnj7tGXmBZSy5zF8bxoEI7QllAPGtX48AiwPdqrtC+wg9gkDqWqBq8qZH
 MQLof7I8jy+GBF9gXXER6XYpDOnd4xlhgQmw6I4jl5m7vGBMCq2VLcqBY1OuiZEfJI9mOTgdhqN
 TzCoJKJOZlqJ6QJUy0Xj/Ia6vykQQ0skSF2t05ho71PrqktUDwfrb6L+mPWqYQz8I0NCLz5jyGK
 p5wJfDl4SSUj70wwSy6Ysw6GbKKyiedImTix1Pv/aqpMQ5aorwvdqWCTvEjcTEJ5FaKwd9y02fe
 bzKaZ8Nvoil2ZOdKd9I0miNiImNk2YBtI0iLSzrpPqyhE3jL7Y3vEzDlVLwHO/a4v08tcq3V6Ha
 HjAHVlGE/tHS5RrNR6r17nTHSh6V5S5D4ftTu9Gms4jTo/JDmJy2XMQ5tBqyfON+VxNqI7a8pkG
 yE73YjhXdQx6OEA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_084150_768655_64D231AD 
X-CRM114-Status: GOOD (  27.14  )
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

Use Kexec Handover (KHO) to pass the previous kernel's version string
and the number of kexec reboots since the last cold boot to the next
kernel, and print it at boot time.

Example output:
    [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)

Motivation
==========

Bugs that only reproduce when kexecing from specific kernel versions
are difficult to diagnose. These issues occur when a buggy kernel
kexecs into a new kernel, with the bug manifesting only in the second
kernel.

Recent examples include the following commits:

 * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
 * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
 * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")

As kexec-based reboots become more common, these version-dependent bugs
are appearing more frequently. At scale, correlating crashes to the
previous kernel version is challenging, especially when issues only
occur in specific transition scenarios.

Implementation
==============

The kexec metadata is stored as a plain C struct (struct kho_kexec_metadata)
rather than FDT format, for simplicity and direct field access. It is
registered via kho_add_subtree() as a separate subtree, keeping it
independent from the core KHO ABI. This design choice:

 - Keeps the core KHO ABI minimal and stable
 - Allows the metadata format to evolve independently
 - Avoids requiring version bumps for all KHO consumers (LUO, etc.)
   when the metadata format changes

The struct kho_metadata contains two fields:
 - previous_release: The kernel version that initiated the kexec
 - kexec_count: Number of kexec boots since last cold boot

On cold boot, kexec_count starts at 0 and increments with each kexec.
The count helps identify issues that only manifest after multiple
consecutive kexec reboots.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: SeongJae Park <sj@kernel.org>
---
Changes in v4:
- Squashed everything in a single commit
- Moved from FDT to C structs (Pratyush)
- Usage of subtress intead of FDT directly (Pratyush)
- Renamed a bunch of variables and functions.
- Link to v3: https://patch.msgid.link/20260108-kho-v3-0-b1d6b7a89342@debian.org

Changes in v3:
- Remove the extra CONFIG for this feature.
- Reworded some identifiers, properties and printks.
- Better documented the questions raised during v2.
- Link to v2: https://patch.msgid.link/20260102-kho-v2-0-1747b1a3a1d6@debian.org

Changes from v2 to v1 (RFC)
- Track the number of kexecs since cold boot (Pasha)
- Change the printk() order compared to KHO
- Rewording of the commit summary
- Link to RFC: https://patch.msgid.link/20251230-kho-v1-1-4d795a24da9e@debian.org
---
 include/linux/kho/abi/kexec_handover.h | 29 +++++++++++++++
 kernel/liveupdate/kexec_handover.c     | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 285eda8a36e45..e18022a4e664d 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -11,6 +11,7 @@
 #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
 
 #include <linux/types.h>
+#include <linux/utsname.h>
 
 /**
  * DOC: Kexec Handover ABI
@@ -84,6 +85,34 @@
 /* The FDT property for sub-FDTs. */
 #define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
 
+/**
+ * DOC: Kexec Metadata ABI
+ *
+ * The "kexec-metadata" subtree stores optional metadata about the kexec chain.
+ * It is registered via kho_add_subtree(), keeping it independent from the core
+ * KHO ABI. This allows the metadata format to evolve without affecting other
+ * KHO consumers.
+ *
+ * The metadata is stored as a plain C struct rather than FDT format for
+ * simplicity and direct field access.
+ */
+
+/**
+ * struct kho_kexec_metadata - Kexec metadata passed between kernels
+ * @previous_release: Kernel version string that initiated the kexec
+ * @kexec_count: Number of kexec boots since last cold boot
+ *
+ * This structure is preserved across kexec and allows the new kernel to
+ * identify which kernel it was booted from and how many kexec reboots
+ * have occurred.
+ */
+struct kho_kexec_metadata {
+	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
+} __packed;
+
+#define KHO_METADATA_NODE_NAME "kexec-metadata"
+
 /**
  * DOC: Kexec Handover ABI for vmalloc Preservation
  *
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 3cf2dc6840c92..3130444e183b3 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -15,6 +15,7 @@
 #include <linux/count_zeros.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
+#include <linux/utsname.h>
 #include <linux/kho/abi/kexec_handover.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
@@ -1246,6 +1247,8 @@ struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
 	phys_addr_t mem_map_phys;
+	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
 	struct kho_debugfs dbg;
 };
 
@@ -1331,6 +1334,59 @@ static __init int kho_out_fdt_setup(void)
 	return err;
 }
 
+static void __init kho_process_kexec_metadata(void)
+{
+	struct kho_kexec_metadata *metadata;
+	phys_addr_t metadata_phys;
+	int err;
+
+	err = kho_retrieve_subtree(KHO_METADATA_NODE_NAME, &metadata_phys);
+	if (err)
+		/* This is fine, previous kernel didn't export metadata */
+		return;
+
+	metadata = phys_to_virt(metadata_phys);
+
+	/*
+	 * Copy data to the kernel structure that will persist during
+	 * kernel lifetime.
+	 */
+	kho_in.kexec_count = metadata->kexec_count;
+	strscpy(kho_in.previous_release, metadata->previous_release,
+		sizeof(kho_in.previous_release));
+
+	pr_info("exec from: %s (count %u)\n", kho_in.previous_release,
+					      kho_in.kexec_count);
+}
+
+/*
+ * Create kexec metadata to pass kernel version and boot count to the
+ * next kernel. This keeps the core KHO ABI minimal and allows the
+ * metadata format to evolve independently.
+ */
+static __init int kho_populate_kexec_metadata(void)
+{
+	struct kho_kexec_metadata *metadata;
+	int err;
+
+	metadata = kho_alloc_preserve(sizeof(*metadata));
+	if (IS_ERR(metadata))
+		return PTR_ERR(metadata);
+
+	strscpy(metadata->previous_release, init_uts_ns.name.release,
+		sizeof(metadata->previous_release));
+	/* kho_in.kexec_count is set to 0 on cold boot */
+	metadata->kexec_count = kho_in.kexec_count + 1;
+
+	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata);
+	if (err) {
+		kho_unpreserve_free(metadata);
+		return err;
+	}
+
+	return 0;
+}
+
 static __init int kho_init(void)
 {
 	const void *fdt = kho_get_fdt();
@@ -1357,6 +1413,15 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
+	if (fdt)
+		kho_process_kexec_metadata();
+
+	/* Populate kexec metadata for the possible next kexec */
+	err = kho_populate_kexec_metadata();
+	if (err)
+		pr_warn("failed to initialize kexec-metadata subtree: %d\n",
+			err);
+
 	if (fdt) {
 		kho_in_debugfs_init(&kho_in.dbg, fdt);
 		return 0;

---
base-commit: 5eec2b2e1f37acff8b926d2494eadaeef59be279
change-id: 20251230-kho-7707e8a2ef1e

Best regards,
--  
Breno Leitao <leitao@debian.org>


