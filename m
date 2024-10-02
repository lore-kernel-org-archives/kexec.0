Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF52BCF6D41
	for <kexec@archiver.kernel.org>; Wed,  2 Oct 2024 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3FAKBUCcHRuzsrhhJ6xWVy2LxGc46m3WuVrLIvfVsCs=; b=N/YT/vGL9eLM+d
	euCGDhKCn2eX0kCS/WcUD7AyEg5EiMMDAH0MniV6r70wIvz0kNvo0M37YXcDRtzfxHcd2TpLFdSIZ
	KFglEM7SGwYaoTwUHbfK7/JxPEJ4ReD6xMoXzw6odeKVkhcnIihAY/rukJnPMcSKz3PVvVxmVyynn
	H59N55N6Uw4n4HJAW6UWH9J81J+B3U5FxFwZkRAJT2zZQKK9oVqpHm0h1+gB5BvWsy7ZcyNbMk5Av
	+8CNGzy5wrnEzqdIAiRYOX6SiaHnNR+sL0YW9JsOUqjwYmmRuRDNU1WGDleKfFpD/O4/lF6XAIbNF
	5W7h2sXHnpaG0mzuCakw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1uU-00000006rX1-1lEj;
	Wed, 02 Oct 2024 16:09:06 +0000
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1uR-00000006rSQ-28Wg
	for kexec@lists.infradead.org;
	Wed, 02 Oct 2024 16:09:05 +0000
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CC29E60A0A;
	Wed,  2 Oct 2024 19:09:00 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-zn4PxY97;
	Wed, 02 Oct 2024 19:08:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885340;
	bh=Buw6OtY4vaTEiLfE/rpef765HwG5RsoTmBzPC5wm+WI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=r7jyfNdcu/K1YYJQ5x6knMx5Nl49ROZZsg0QUwcs8pAkjxACaAuyrBlPZogqCEB6V
	 9NxYNkSHpbUIL/TAjsx2WCSnmAbHSj6ctGbfnRoo8DUx7sJv137cKVrtUwnBzmFt0M
	 LJnhETmwa6hxGje8tRERsspaQJi5H+2Gj2LROC2E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	valesini@yandex-team.com,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 4/7] mm/memblock: Add MEMBLOCK_PRSRV flag
Date: Wed,  2 Oct 2024 18:07:19 +0200
Message-ID: <20241002160722.20025-5-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002160722.20025-1-arbn@yandex-team.com>
References: <20241002160722.20025-1-arbn@yandex-team.com>
MIME-Version: 1.0
X-Yandex-Filter: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_090903_843095_43F22046 
X-CRM114-Status: GOOD (  17.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Add MEMBLOCK_PRSRV flag indicating that we don't need to initialize
'struct page' at all. The flag will be used in the following patches
to mark memory intended to be kept intact across kexec.
The 'struct page' for such region assumed to be initialized by the old
kernel, so the new one shouldn't touch it.

This is only initial RFC sketch, in which we assume that 'struct page'
layout doens't change between old and new kernel. The proper solution
would require some form of migration from old 'struct page' to the new
one if layout did change.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/memblock.h |  7 +++++++
 mm/memblock.c            |  9 ++++++++-
 mm/mm_init.c             | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 673d5cae7c813..b3c6029b03624 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -50,6 +50,7 @@ enum memblock_flags {
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
+	MEMBLOCK_PRSRV		= 0x20, /* struct page presreved during kexec, don't initialize */
 };
 
 /**
@@ -132,6 +133,7 @@ int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
+int memblock_reserved_mark_preserved(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
@@ -271,6 +273,11 @@ static inline bool memblock_is_reserved_noinit(struct memblock_region *m)
 	return m->flags & MEMBLOCK_RSRV_NOINIT;
 }
 
+static inline bool memblock_is_preserved(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_PRSRV;
+}
+
 static inline bool memblock_is_driver_managed(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
diff --git a/mm/memblock.c b/mm/memblock.c
index 0389ce5cd281e..20ab3272cc166 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1048,6 +1048,12 @@ int __init_memblock memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t
 				    MEMBLOCK_RSRV_NOINIT);
 }
 
+int __init_memblock memblock_reserved_mark_preserved(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.reserved, base, size, 1,
+				    MEMBLOCK_PRSRV);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2181,7 +2187,8 @@ static void __init memmap_init_reserved_pages(void)
 	 * the MEMBLOCK_RSRV_NOINIT flag set
 	 */
 	for_each_reserved_mem_region(region) {
-		if (!memblock_is_reserved_noinit(region)) {
+		if (!memblock_is_reserved_noinit(region) &&
+			!memblock_is_preserved(region)) {
 			nid = memblock_get_region_node(region);
 			start = region->base;
 			end = start + region->size;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf194..b82c13077928f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -837,6 +837,22 @@ static void __init init_unavailable_range(unsigned long spfn,
 			node, zone_names[zone], pgcnt);
 }
 
+static bool pfn_preserved(unsigned long *pfn)
+{
+	struct memblock_region *r;
+
+	for_each_reserved_mem_region(r) {
+		if (memblock_is_preserved(r)) {
+			if (*pfn >= memblock_region_memory_base_pfn(r) &&
+				*pfn < memblock_region_memory_end_pfn(r)) {
+				*pfn = memblock_region_memory_end_pfn(r);
+				return true;
+			}
+		}
+	}
+	return false;
+}
+
 /*
  * Initially all pages are reserved - free ones are freed
  * up by memblock_free_all() once the early boot process is
@@ -889,6 +905,9 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 			}
 		}
 
+		if (pfn_preserved(&pfn))
+			continue;
+
 		page = pfn_to_page(pfn);
 		__init_single_page(page, pfn, zone, nid);
 		if (context == MEMINIT_HOTPLUG) {
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
