Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A64C021B2
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=; b=HiqtxWgoxQz+t/oK/G8sDAGShD
	wNVzZ1sB+EfKZEIpFquway51SaLHeoEMP4H0Z9pTe+d8sodL0J8MBP9txET9d25+i3VTtDklr+ZQs
	HsYsUQazXLY2HGZdILWZXPeSJ/rrUftajydK7QddEe6qNa/tK3Eg64kQcnysgc9b9+zSilTK70RAS
	cNRN+vOEK/yJzS2oaO8ILATC4GsuWe0TjPE9obCBtDmXmqOOZUa5HLPfBaijxsrIonFTQzFifQlX0
	9VdjqMh7sf1eLhJ8dYTrscBjab0sLY+20XUSbvfJFVLikKNfQMRNakPB+mOzwXqz1npk2E/Zg+f3b
	CG6/F8Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9mx-00000001ydN-216K;
	Thu, 20 Feb 2025 16:52:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9mv-00000001ybI-0JRS
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 16:52:38 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id B9A6221186;
	Thu, 20 Feb 2025 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=;
	b=vR7l+TDFHoQkJcuzxpxWN12po112UZHuh6/OAATx4v9jBC9K9qy6mIAmm+LWAuBAK82iFZ
	SwDNsyO4jC7Rk/W89RhamlC+MXPERH2UtMnj23slI8py9ZKNqSDanS1JQYb68bY82WOuHp
	dTaoB8ckoNaLpJYYbytYXiuFO+N8hpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=;
	b=7zjXn4G4ZCuWjVS5/GJCXpVdrmZ3Aa1fUFf1swFrLtFv7JmkHLXPMd9XuUUBr1+M8LQeKn
	DjLfbLTdD0epgKCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=;
	b=vR7l+TDFHoQkJcuzxpxWN12po112UZHuh6/OAATx4v9jBC9K9qy6mIAmm+LWAuBAK82iFZ
	SwDNsyO4jC7Rk/W89RhamlC+MXPERH2UtMnj23slI8py9ZKNqSDanS1JQYb68bY82WOuHp
	dTaoB8ckoNaLpJYYbytYXiuFO+N8hpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=;
	b=7zjXn4G4ZCuWjVS5/GJCXpVdrmZ3Aa1fUFf1swFrLtFv7JmkHLXPMd9XuUUBr1+M8LQeKn
	DjLfbLTdD0epgKCA==
Date: Thu, 20 Feb 2025 17:52:35 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v2 2/5] kdump: implement reserve_crashkernel_cma
Message-ID: <Z7dd0_XLzmb1tBUk@dwarf.suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.776];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,localhost:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_085237_415076_3A84A3E7 
X-CRM114-Status: GOOD (  12.21  )
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

reserve_crashkernel_cma() reserves CMA ranges for the
crash kernel. If allocating the requested size fails,
try to reserve in smaller blocks.

Store the reserved ranges in the crashk_cma_ranges array
and the number of ranges in crashk_cma_cnt.
---
 include/linux/crash_reserve.h | 12 +++++++++
 kernel/crash_reserve.c        | 49 +++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
index a681f265a361..97964f2a583d 100644
--- a/include/linux/crash_reserve.h
+++ b/include/linux/crash_reserve.h
@@ -13,12 +13,24 @@
  */
 extern struct resource crashk_res;
 extern struct resource crashk_low_res;
+extern struct range crashk_cma_ranges[];
+#if defined(CONFIG_CMA) && defined(CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION)
+#define CRASHKERNEL_CMA
+#define CRASHKERNEL_CMA_RANGES_MAX 4
+extern int crashk_cma_cnt;
+#else
+#define crashk_cma_cnt 0
+#define CRASHKERNEL_CMA_RANGES_MAX 0
+#endif
+
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, unsigned long long *cma_size,
 		bool *high);
 
+void __init reserve_crashkernel_cma(unsigned long long cma_size);
+
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index e72a9c897694..d71aff19a28d 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -14,6 +14,8 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/cma.h>
+#include <linux/crash_reserve.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -470,6 +472,53 @@ void __init reserve_crashkernel_generic(char *cmdline,
 #endif
 }
 
+struct range crashk_cma_ranges[CRASHKERNEL_CMA_RANGES_MAX];
+#ifdef CRASHKERNEL_CMA
+int crashk_cma_cnt = 0;
+void __init reserve_crashkernel_cma(unsigned long long cma_size)
+{
+	unsigned long long request_size = roundup(cma_size, PAGE_SIZE);
+	unsigned long long reserved_size = 0;
+
+	while (cma_size > reserved_size &&
+	       crashk_cma_cnt < CRASHKERNEL_CMA_RANGES_MAX) {
+
+		struct cma *res;
+
+		if (cma_declare_contiguous(0, request_size, 0, 0, 0, false,
+				       "crashkernel", &res)) {
+			/* reservation failed, try half-sized blocks */
+			if (request_size <= PAGE_SIZE)
+				break;
+
+			request_size = roundup(request_size / 2, PAGE_SIZE);
+			continue;
+		}
+
+		crashk_cma_ranges[crashk_cma_cnt].start = cma_get_base(res);
+		crashk_cma_ranges[crashk_cma_cnt].end =
+			crashk_cma_ranges[crashk_cma_cnt].start +
+			cma_get_size(res) - 1;
+		++crashk_cma_cnt;
+		reserved_size += request_size;
+	}
+
+	if (cma_size > reserved_size)
+		pr_warn("crashkernel CMA reservation failed: %lld MB requested, %lld MB reserved in %d ranges\n",
+			cma_size >> 20, reserved_size >> 20, crashk_cma_cnt);
+	else
+		pr_info("crashkernel CMA reserved: %lld MB in %d ranges\n",
+			reserved_size >> 20, crashk_cma_cnt);
+}
+
+#else /* CRASHKERNEL_CMA */
+void __init reserve_crashkernel_cma(unsigned long long cma_size)
+{
+	if (cma_size)
+		pr_warn("crashkernel CMA reservation not supported\n");
+}
+#endif
+
 #ifndef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 static __init int insert_crashkernel_resources(void)
 {

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


