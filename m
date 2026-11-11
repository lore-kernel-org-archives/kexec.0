Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6660A260C
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gxRVFJyL;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=cVrdZ0bW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+8ppAZ4kI36SkHC2JSY1XPhx8Cnr7U+W7X/gURi12I4=; b=gxRVFJyLSRbF0quy0mf0gpZAzu
	NFF47jD2xhiqCrNhDXK6DotI+Siyriw/adgrmKAjAY2Ttq4ItmRGNttkKU8UunzjX3j2MXHeof3mz
	5efGzQi6CrpI+gyIsgpp5FuGyHAe9J12KtI9zYBTKIAkhwrjEPbh6JKTkapejJzo1YTVOHuVJ1n3m
	nH8nhNG+M2As+7XKE4/nJ3IYW7uWz0oRIcPifEUWvpeTLXOO9jz2n+LgMNPqbYAhs2UtrWt+8XpNE
	tfIo6tnfeAuA9ZWioV4KiF9TaqwJ7Xh9bDPJoglcxFGyNQrNhqT8jDfGnOuUiL3jQGwzKQodKVUIs
	GCJkWoPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39F-00000005y15-3fEE;
	Wed, 11 Nov 2026 07:53:37 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39D-00000005xzM-0XGH
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:36 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e9eb579c0eso16360785ad.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383614; x=1794988414; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+8ppAZ4kI36SkHC2JSY1XPhx8Cnr7U+W7X/gURi12I4=;
        b=cVrdZ0bWABI2ek8fAWGNyeY/NCEjpolqUN12eQwwt7EBtvSGXCowfsTJT/XHsPoyhI
         2HIIiwvWzgdTHVvNyTHFNm8WizyDpmvpNN9m1faK0UGrRiYehEtpXddWpRf99rSrmszc
         RRA5E7tE9Sh0hISlBUf6fkEv4KV86gJJJV5cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383614; x=1794988414;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8ppAZ4kI36SkHC2JSY1XPhx8Cnr7U+W7X/gURi12I4=;
        b=EdK+1QnwFK274PT92upORzxSlR+t1x0rXx81mx0Aezjds5IpSk6d5lverPrdhsM6X/
         xle4gg7FenVGFBY7iIzQ2GzoI4RdStHY2WbsRHcM3HrDbLRrJRMWcrE1sTx4w5CQS9iB
         eI+u9vqM0eQhfYg7Vhm8x0LToKAN9HBAfplVKAGyBS4Wqq5h7m9yiGrniim2BaBwNyaR
         oHisvs/+xK9C6f5njNggp2I9iwfwwstutDFvWnRb9iCDLS3naSzYf1j7GrWCNG0uheHO
         BQ1vWT5J0fGjQpoomYEwl3IyYTRB1zq6uDbrUoJRwFB5r0WIBY5cIKSLiz/RQFVN7cJA
         K32Q==
X-Forwarded-Encrypted: i=1; AL+hErGCrc+9z8f6JqNF/DmBjhvWxfNYAfYw7WJdUauLmDnMeR5zBoKS3yuxFitHEB4XFm3uS4INpg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+KPR/nEzxvdF8U6v9xSgcocULuGYTy/REQoI+YDq1QdElEagyj
	jCS27VtDhY76yA6wcLDzGQ4Y40bGmVCVWAu2TGJDbG4LD6zGXg71HPFr0ltdBzxJYN0=
X-Gm-Gg: AYBFou104HClBEdlCYwznzfAhDTgh78PXAlj7EUy/SRMZCoBKoQU8rPZ81S0Aq6UzOP
	y4VvjVXTV5bt7WGcNCW7NT3DYj+dQp81gONH0Rwmmup8w+bKPezXo+C6MQE4MdKdIA0TACqDiFW
	TYiZU7RfmDey6JutCbtHEgewMNOJpdFW9RcuPHsxwGOIbUNzfrflE/YZMerPgzLWhoS2M8zfnbM
	Ry11qvuazZJWcY8ckmxH3Q9sgn7tD0tFcPiqUoqrYjZJEJlTkDNRMne+txjdgwknTETfwLeNYOS
	gg3FzsMe+ORu/wM4N1TG06xF0wMTbBnv7lRhu0rxeO/mvqkaNpZcGhEaSwwy8sASOUhxvMyxFpD
	GKl+P9nGNy6Ko8QorshdUKeeGhclgJw3g65N4zVf09VaOx85BRTsuq96REKMLhoaSU126yH+Y0m
	bFQTltBllSod6p6wtXhiNZC98obHdRrakuFla9zEZa7uXb/jAGffKq8cckHiKXhO7HgQYyROVHX
	B6LPrt6Bf+2tVr5wkZlDXFtJAxjtelaj97/XGjH+YHsIH61juAVU+/EGDMArfoKX4g4yEnoFA8R
	/Q+fBDrcDwK7TtC8loj0j2zApYQwHX0/igh5MwGpcNukahmiWUF3BjseVrv7YZd/N+St2+gdFii
	MNOtsoY0xgOkwqQhLL9TyafmkzwOdwG31KwkDOT+1sPcgc+ybOmtfPohY7fj4oxwM/d3Mdi5ihA
	34xrZhUuhKqaKqzZ799IuN3tzOg2zzFyaFrz3OaaJwcpL70gk5XdsJ
X-Received: by 2002:a17:902:da87:b0:2ed:294c:2b9c with SMTP id d9443c01a7336-2edd7ac1ea6mr21231125ad.51.1794383614325;
        Tue, 10 Nov 2026 23:53:34 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3f730sm18051095ad.5.2026.11.10.23.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:53:33 -0800 (PST)
Date: Tue, 10 Nov 2026 23:53:30 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 6/9] kho: Expose rejected handovers that look like cold boots
Message-ID: <abfe907e8da92802cd5e0c843d8013e4d229aab3.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235335_181072_50119B2B 
X-CRM114-Status: GOOD (  20.79  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At Meta, our rollout needs to stop if the new kernel rejects the KHO
handover. For example, if it doesn't recognise the handover FDT's
compatible string, it can boot normally with all the preserved state
lost. LUO's incoming/state reads "none", as on a cold boot. We log
"disabling KHO revival", but our fleet collector reads procfs and sysfs
and can't rely on kernel logs from every host.

Let's add /sys/kernel/kexec/kho_incoming/state so the collector can tell
a rejected handover from an ordinary boot. "revived" means the kernel
accepted the handover and completed the preserved memory map walk. LUO
reports the outcome of restoring sessions separately.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../ABI/testing/sysfs-class-misc-liveupdate   |  3 ++
 .../ABI/testing/sysfs-kernel-kexec-kdump      | 12 +++++++
 Documentation/admin-guide/mm/kho.rst          |  3 ++
 include/linux/kexec_handover.h                |  2 ++
 kernel/kexec_core.c                           | 13 ++++++-
 kernel/liveupdate/kexec_handover.c            | 34 +++++++++++++++++++
 6 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-misc-liveupdate b/Documentation/ABI/testing/sysfs-class-misc-liveupdate
index 25e3b49d7aeb..608f788ef0fa 100644
--- a/Documentation/ABI/testing/sysfs-class-misc-liveupdate
+++ b/Documentation/ABI/testing/sysfs-class-misc-liveupdate
@@ -19,6 +19,9 @@ Description:	read only
 		"deserialized"  The sessions can be retrieved.
 		"failed"        Deserialization failed. Opening
 		                /dev/liveupdate returns -EIO.
+
+		See /sys/kernel/kexec/kho_incoming/state for the status of
+		the underlying KHO handover.
 Users:		system monitoring
 
 What:		/sys/class/misc/liveupdate/incoming/sessions
diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
index 80941a7d8a7c..5636cd060cb2 100644
--- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
+++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
@@ -67,3 +67,15 @@ Description:	read only
 		Total size of the KHO bootmem regions in bytes. Returns 0
 		when KHO is disabled.
 User:		system monitoring
+
+What:		/sys/kernel/kexec/kho_incoming/state
+Date:		Nov 2026
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Status of the incoming KHO handover:
+
+		"none"     No handover was passed to this kernel.
+		"revived"  The kernel accepted the handover and completed
+		           the walk of its preserved memory map.
+		"failed"   The kernel rejected the handover.
+User:		system monitoring
diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index c329d720bf25..9d74d4ce18b5 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -88,6 +88,9 @@ sysfs Interfaces
     Total size of the KHO bootmem regions in bytes, or 0 when KHO is
     disabled.
 
+``/sys/kernel/kexec/kho_incoming/state``
+    Status of the incoming KHO handover.
+
 See Documentation/ABI/testing/sysfs-kernel-kexec-kdump for the sysfs ABI.
 
 debugfs Interfaces
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 736d51e79fd2..1f37d2300e26 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -42,6 +42,8 @@ void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t bootmem_phys,
 bool kho_bootmem_overlap(phys_addr_t phys, size_t size);
 phys_addr_t kho_bootmem_size(void);
 
+extern const struct attribute_group kho_incoming_attr_group;
+
 static inline enum migratetype kho_bootmem_migratetype(unsigned long pfn,
 						       enum migratetype mt)
 {
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ed105e6351eb..c1085a53b7f4 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1372,7 +1372,18 @@ static struct kexec_link_entry kexec_links[] = {
 };
 
 static struct kobject *kexec_kobj;
-ATTRIBUTE_GROUPS(kexec);
+
+static const struct attribute_group kexec_group = {
+	.attrs = kexec_attrs,
+};
+
+static const struct attribute_group *kexec_groups[] = {
+	&kexec_group,
+#ifdef CONFIG_KEXEC_HANDOVER
+	&kho_incoming_attr_group,
+#endif
+	NULL
+};
 
 static int __init init_kexec_sysctl(void)
 {
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 21d77e29d2bb..dfd6fa7e4a71 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -19,6 +19,7 @@
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho_radix_tree.h>
+#include <linux/kobject.h>
 #include <linux/utsname.h>
 #include <linux/kho/abi/kexec_handover.h>
 #include <linux/kho/abi/kexec_metadata.h>
@@ -97,11 +98,18 @@ static struct kho_out kho_out = {
 	},
 };
 
+enum kho_incoming_state {
+	KHO_INCOMING_NONE,
+	KHO_INCOMING_REVIVED,
+	KHO_INCOMING_FAILED,
+};
+
 struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t bootmem_phys;
 	char previous_release[__NEW_UTS_LEN + 1];
 	u32 kexec_count;
+	enum kho_incoming_state state;
 	struct kho_debugfs dbg;
 	struct kho_radix_tree radix_tree;
 };
@@ -957,6 +965,29 @@ phys_addr_t kho_bootmem_size(void)
 	return size;
 }
 
+static const char * const kho_incoming_state_names[] = {
+	[KHO_INCOMING_NONE]	= "none",
+	[KHO_INCOMING_REVIVED]	= "revived",
+	[KHO_INCOMING_FAILED]	= "failed",
+};
+
+static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
+			  char *buf)
+{
+	return sysfs_emit(buf, "%s\n", kho_incoming_state_names[kho_in.state]);
+}
+static struct kobj_attribute state_attr = __ATTR_RO(state);
+
+static struct attribute *kho_incoming_attrs[] = {
+	&state_attr.attr,
+	NULL
+};
+
+const struct attribute_group kho_incoming_attr_group = {
+	.name	= "kho_incoming",
+	.attrs	= kho_incoming_attrs,
+};
+
 /*
  * Look for free blocks of 1G. This is a heuristic chosen to work efficiently
  * with large systems with hundreds of gigabytes of memory. It will work poorly
@@ -1753,6 +1784,7 @@ static void __init kho_mem_retrieve(void)
 	 */
 	kho_in.fdt_phys = 0;
 	kho_in.radix_tree.root = NULL;
+	kho_in.state = KHO_INCOMING_FAILED;
 }
 
 static __init int kho_out_fdt_setup(void)
@@ -1992,6 +2024,7 @@ void __init kho_memory_init_early(void)
 	 */
 	kho_in.fdt_phys = 0;
 	kho_in.bootmem_phys = 0;
+	kho_in.state = KHO_INCOMING_FAILED;
 }
 
 void __init kho_memory_init(void)
@@ -2090,6 +2123,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 unmap_fdt:
 	early_memunmap(fdt, fdt_len);
 report:
+	kho_in.state = populated ? KHO_INCOMING_REVIVED : KHO_INCOMING_FAILED;
 	if (!populated)
 		pr_warn("disabling KHO revival\n");
 }
-- 
2.54.0


