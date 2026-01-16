Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1263C982D7
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWaLEplWq59uIHotHJ6qgSbmWWLE1NGtyoDG+TZxz50=; b=Xwm1ysZEKa/ctVXj1yUBSeC3H7
	CcGnR5ZnMzcTfmmA2vPWXTaJmqJIU+ISz+8F2VFEEjADhtZiEN2/wVWsGyRWnv8bKsGFbghgBviDn
	0o20Qfmdk/SGXgAkpzdN4kpgukkI91s0rEj8b/SZZcMcwU2TE9G4hWGYQpo4lvHgTKz81OedM6iSC
	eiZzwD2OHR5JHPa+9pEk7pOEE6tLhmSgvKDt8wifDeUzsXJdIkUPv+ScOT4WnRp56v8OZNTlFXWk1
	b+GyJqScHNRqi1W3QkaMcpjf77bkj9qT9VAuFrMYv5rMfHyOKHo4ZyDDWg3ZmRU0vBP1oMoK9VxJH
	pBzst4xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgm5s-0000000EOfK-2by5;
	Fri, 16 Jan 2026 15:50:36 +0000
Received: from mail-oo1-f47.google.com ([209.85.161.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgm5q-0000000EOeT-2Cg8
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 15:50:35 +0000
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-66109b09b53so773268eaf.1
        for <kexec@lists.infradead.org>; Fri, 16 Jan 2026 07:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578632; x=1769183432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWaLEplWq59uIHotHJ6qgSbmWWLE1NGtyoDG+TZxz50=;
        b=ehKR0hwi00yMyUiTHqDRT8IL+BiTxbnNdc7AZAUtDzszSXFEhFcmqPklXoiaQ4IJYT
         5zDGKTX3Mbqhz9jh6LA4CCnZ8b+TWtBCd9Et44JOH2/I2S9LrVQNGlxGdsylnRgBqith
         noUpFwuZPGdtibBjrok+eoQ/yKy9SSBjLSBKklfc6ytNUs2zbJ8mu+gZsgbjOFGGNOMf
         Yos0EK8GMdVAdTFDQL84e8TKVydAH1Hul3h9WSV9MeknOhG6iyXXMxBV22jRmAUd1VBQ
         0XcyL/CGGCKCydW6+yVjSpx28dkFQv5Q2l8pKymc2GV3Jaf1RsS03Qe4EFdwCIisZS9w
         rtww==
X-Forwarded-Encrypted: i=1; AJvYcCXKyXAosojsCwJqgm6FWFe2AYObPFn7Fqq0EgDI1CGad/wFEZVuHFVIUPCXSmA6D++zDl63BA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywy59U9GjZnF6+VSttsteVeABVlpHzyiRSfBy1ZLm+rG1l9U/wJ
	b9iD3rc73BPRUVoVy2l1bOF1qGCPyZNk/vwRqaqm9wCj0ZK5ARlqZrEy
X-Gm-Gg: AY/fxX6PtfRpWM5PP+oPu2P/vMyBXoQTOdDUkDt1vr1od+DiizhaUm316l6lbZEHtWo
	EoB1YsRPwalckjzYy1cvtmeSuPwzTsJ4gn2ONFGZP2FSHCkeepbideHMfUMx4eGC4aKAZP+Xhhw
	E2zkBiJgSKPna4fg6HUc6yRgDD4rl9RAtj6QAQKDzNyfWXDX4HdPyPQ6lrntsDCTO4d2SK/4oNI
	hu3NWugAteYztmb0UndfmDlDfn3SGHS6TBbM25c8xks9gwvvjMD5X/iyq8GU/3+XX+TS7d3jzzi
	/17Jt20Mcg5rBEPSKVcKOmj859Axn1+mbJpCf+3kdUk5S8emUFm98basdDbZHYkbmIkYeg3ZAqG
	MtH8n6e7ovEkE3VrSroOW4dhzVOFRWnJU5hZmOJ9XrbyD/hpWg3eWTB2K3+Lvo+lZvm87uk9Bj7
	F5ykZdCs3xHG2j
X-Received: by 2002:a4a:ec41:0:b0:65f:64eb:8ff5 with SMTP id 006d021491bc7-66117a392c9mr1173720eaf.81.1768578632024;
        Fri, 16 Jan 2026 07:50:32 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6611a78b02fsm902856eaf.9.2026.01.16.07.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:50:31 -0800 (PST)
Date: Fri, 16 Jan 2026 07:50:29 -0800
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
	riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] kho: history: track previous kernel version
Message-ID: <v7g7nmd3jif6vftvnmucvpluevufcdxmefcgqq3yfpnzyb7mql@ojpotuu4hgxm>
References: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
 <20260108-kho-v3-1-b1d6b7a89342@debian.org>
 <2vxzy0m0gfyo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzy0m0gfyo.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260116_075034_578534_245DBCC3 
X-CRM114-Status: GOOD (  46.16  )
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

Hello Pratyush,

On Wed, Jan 14, 2026 at 07:19:11PM +0000, Pratyush Yadav wrote:
> On Thu, Jan 08 2026, Breno Leitao wrote:
> 
> > Store and display the kernel version from the previous kexec boot.
> >
> > The current kernel's release string is saved to the "previous-release"
> > property in the KHO FDT before kexec. On the next boot, if this property
> > exists, the previous kernel version is retrieved and printed during
> > early boot.
> >
> > This helps diagnose bugs that only manifest when kexecing from specific
> > kernel versions, making it easier to correlate crashes with the kernel
> > that initiated the kexec.
> 
> The KHO FDT is ABI. So you should be bumping the version number when you
> make changes to it.
> 
> But honestly, adding this "optional" stuff to the core KHO ABI makes me
> uneasy. I say optional since it is not needed for the main functionality
> of KHO. Making this a part of the ABI increases the surface area we
> have. The more things we stuff in the ABI, the more inflexible it gets
> over time.
> 
> Any changes to the KHO ABI means all consumers also need a version bump.
> This includes LUO and all its users for example. So I would really like
> to avoid adding optional things in core KHO FDT.
> 
> The easy fix is to add a separate subtree for the optional metadata. You
> would still need to create an ABI for the data format, but being
> independent of core KHO, it will make it more flexible and easier to
> change in the future. You can keep the code in kexec_handover.c.

Thanks for the feedback and guidance!

I was able to hack this a bit and I came up with something like the
follow. Is this what you have in mind?

Author: Breno Leitao <leitao@debian.org>
Date:   Fri Jan 16 06:42:56 2026 -0800

    kho: history: track previous kernel version and kexec count
    
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
    
    Recent examples include:
    
     * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
     * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
     * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")
    
    As kexec-based reboots become more common, these version-dependent bugs
    are appearing more frequently. At scale, correlating crashes to the
    previous kernel version is challenging, especially when issues only
    occur in specific transition scenarios.
    
    Implementation
    ==============
    
    The history metadata is stored in a separate FDT subtree registered via
    kho_add_subtree(), rather than being embedded directly in the root KHO
    FDT. This design choice:
    
     - Keeps the core KHO ABI minimal and stable
     - Allows the history format to evolve independently
     - Avoids requiring version bumps for all KHO consumers (LUO, etc.)
       when the history format changes
    
    The history subtree uses its own compatible string "kho-history-v1" and
    contains two properties:
     - previous-release: The kernel version that initiated the kexec
     - kexec-count: Number of kexec boots since last cold boot
    
    On cold boot, kexec-count starts at 0 and increments with each kexec.
    The count helps identify issues that only manifest after multiple
    consecutive kexec reboots.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 285eda8a36e4..da19d6029815 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -84,6 +84,29 @@
 /* The FDT property for sub-FDTs. */
 #define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
 
+/*
+ * The "history" subtree stores optional metadata about the kexec chain.
+ * It is registered as a separate FDT via kho_add_subtree(), keeping it
+ * independent from the core KHO ABI. This allows the history format to
+ * evolve without affecting other KHO consumers.
+ *
+ * The history FDT structure:
+ *
+ *   / {
+ *       compatible = "kho-history-v1";
+ *       previous-release = "6.x.y-...";
+ *       kexec-count = <N>;
+ *   };
+ */
+#define KHO_HISTORY_NODE_NAME "history"
+#define KHO_HISTORY_COMPATIBLE "kho-history-v1"
+
+/* The FDT property to track previous kernel (kexec caller) */
+#define KHO_PROP_PREVIOUS_RELEASE "previous-release"
+
+/* The FDT property to track number of kexec counts so far */
+#define KHO_PROP_KEXEC_COUNT "kexec-count"
+
 /**
  * DOC: Kexec Handover ABI for vmalloc Preservation
  *
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 3cf2dc6840c9..fd22b0947587 100644
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
 
@@ -1331,6 +1334,48 @@ static __init int kho_out_fdt_setup(void)
 	return err;
 }
 
+/*
+ * Create a separate FDT subtree for optional history metadata.
+ * This keeps the core KHO ABI minimal and allows the history format
+ * to evolve independently.
+ */
+static __init int kho_history_init(void)
+{
+	u32 kexec_count;
+	void *fdt;
+	int err;
+
+	fdt = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(fdt))
+		return PTR_ERR(fdt);
+
+	err = fdt_create(fdt, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property_string(fdt, "compatible", KHO_HISTORY_COMPATIBLE);
+	err |= fdt_property_string(fdt, KHO_PROP_PREVIOUS_RELEASE,
+				   init_uts_ns.name.release);
+	/* kho_in.kexec_count is set to 0 on cold boot */
+	kexec_count = kho_in.kexec_count + 1;
+	err |= fdt_property(fdt, KHO_PROP_KEXEC_COUNT, &kexec_count,
+			    sizeof(kexec_count));
+	err |= fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
+
+	if (err) {
+		kho_unpreserve_free(fdt);
+		return err;
+	}
+
+	err = kho_add_subtree(KHO_HISTORY_NODE_NAME, fdt);
+	if (err) {
+		kho_unpreserve_free(fdt);
+		return err;
+	}
+
+	return 0;
+}
+
 static __init int kho_init(void)
 {
 	const void *fdt = kho_get_fdt();
@@ -1357,6 +1402,10 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
+	err = kho_history_init();
+	if (err)
+		pr_warn("failed to initialize history subtree: %d\n", err);
+
 	if (fdt) {
 		kho_in_debugfs_init(&kho_in.dbg, fdt);
 		return 0;
@@ -1425,6 +1474,61 @@ static void __init kho_release_scratch(void)
 	}
 }
 
+static int __init kho_print_previous_kernel(const void *fdt)
+{
+	const char *prev_release;
+	const u64 *history_phys;
+	const u32 *count_ptr;
+	void *history_fdt;
+	int history_node;
+	int len;
+	int ret;
+
+	/* Find the history subtree reference in root FDT */
+	history_node = fdt_subnode_offset(fdt, 0, KHO_HISTORY_NODE_NAME);
+	if (history_node < 0)
+		/* This is fine, previous kernel didn't export history */
+		return -ENOENT;
+
+	/* Get the physical address of the history FDT */
+	history_phys = fdt_getprop(fdt, history_node, KHO_FDT_SUB_TREE_PROP_NAME, &len);
+	if (!history_phys || len != sizeof(*history_phys))
+		return -ENOENT;
+
+	/* Map the history FDT */
+	history_fdt = early_memremap(*history_phys, PAGE_SIZE);
+	if (!history_fdt)
+		return -ENOMEM;
+
+	prev_release = fdt_getprop(history_fdt, 0, KHO_PROP_PREVIOUS_RELEASE, &len);
+	if (!prev_release || len <= 0) {
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	/* Read the kexec count from the previous kernel */
+	count_ptr = fdt_getprop(history_fdt, 0, KHO_PROP_KEXEC_COUNT, &len);
+	if (WARN_ON(!count_ptr || len != sizeof(u32))) {
+		ret = -ENOENT;
+		goto exit;
+	}
+	/*
+	 * This populate the kernel structure that will be persisted during
+	 * kernel life time, and the fdt will be unmapped
+	 */
+	kho_in.kexec_count = *count_ptr;
+
+	strscpy(kho_in.previous_release, prev_release,
+		sizeof(kho_in.previous_release));
+	pr_info("exec from: %s (count %u)\n", kho_in.previous_release,
+					      kho_in.kexec_count);
+
+	ret = 0;
+exit:
+	early_memunmap(history_fdt, PAGE_SIZE);
+	return ret;
+}
+
 void __init kho_memory_init(void)
 {
 	if (kho_in.mem_map_phys) {
@@ -1513,7 +1617,10 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.scratch_phys = scratch_phys;
 	kho_in.mem_map_phys = mem_map_phys;
 	kho_scratch_cnt = scratch_cnt;
-	pr_info("found kexec handover data.\n");
+
+	if (kho_print_previous_kernel(fdt))
+		/* Fallback message when previous kernel info unavailable */
+		pr_info("found kexec handover data.\n");
 
 out:
 	if (fdt)

