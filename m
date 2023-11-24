Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5B8C61D97
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=s5005BSkxArKq/21tLCrNGSFxWIEGQdqNUg+/m2pOrQ=; b=xWPHM6MMK/a9Ng
	8gIHQaIN5Iw1toprJCZgQB4i6U+hs/+RqKN44qKmS+09/Zc6dYJpKUg/ucJBs2+DAcnXEwTNTh3GR
	KoGm6wAcZKxxtz7cN7d9SCBeX3MlZKl66Jw5Fq8dbZI62+FcVsVBGmZUyktjPyLBn4j3s+PYNeUNL
	Ogn46R0SYuQWEy3nRBIR0C37LNwCpM5HPrBfM5XMLUMPL/AOVaL1B+xDEWy5Xh6zTp92wWdnhO6JU
	aOAPIo8y6nlOgbxQPDaThi/qHimc2Q/EI0zpEhQu3AVypOJSk/oW9JS+jxXGPtilLPXA9j9nwc1L7
	OBwlHOYe+ddlkc6avD3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6cJS-007zDw-1T;
	Fri, 24 Nov 2023 19:58:06 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6cJQ-007zDO-0r
	for kexec@lists.infradead.org;
	Fri, 24 Nov 2023 19:58:05 +0000
Received: from relay2.suse.de (unknown [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id CF9B21FE90;
	Fri, 24 Nov 2023 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700855882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
	bh=rL7u06+WD+aE2+8equGsGoE7y/tVOqmNf5x3nllorEI=;
	b=KjB4L2sXfNur0f/FabkZEkw3kNGcXvWSv11EpyAEscgbnt7t+V11Up9d4mybmigCfOdWmZ
	jzcbAdjYNx62MzhKVTCJo/ms7tY0yuWDSJcCC4wPEbZEJ3D2+o8UqSNWyZvzEghXELnb20
	cl4eUyNKIuxgFdHPU0spXJtUiaGD128=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700855882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to;
	bh=rL7u06+WD+aE2+8equGsGoE7y/tVOqmNf5x3nllorEI=;
	b=Cw40MhUyvssBlKCwj8rHAwDqF5hVptjseRaftR9uOGzG+83CzXWkyqoVKylaTxMxO0BzjZ
	vSPKUofr9NpUDxCQ==
Received: from localhost (dwarf.suse.cz [10.100.12.32])
	by relay2.suse.de (Postfix) with ESMTP id 103522C145;
	Fri, 24 Nov 2023 19:58:01 +0000 (UTC)
Date: Fri, 24 Nov 2023 20:58:00 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: [PATCH 2/4] kdump: implement reserve_crashkernel_cma
Message-ID: <ZWEASEz37xE2Cmb5@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
X-Spamd-Bar: +++++++++++++
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: CF9B21FE90
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=pass (smtp-out2.suse.de: domain of jbohac@suse.cz designates 149.44.160.134 as permitted sender) smtp.mailfrom=jbohac@suse.cz
X-Spamd-Result: default: False [13.49 / 50.00];
	 RDNS_NONE(1.00)[];
	 SPAMHAUS_XBL(0.00)[149.44.160.134:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_ALLOW(-0.20)[+ip4:149.44.0.0/16:c];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
	 HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
	 RCPT_COUNT_FIVE(0.00)[6];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 MX_GOOD(-0.01)[];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RDNS_DNSFAIL(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_115804_469789_4DB120A0 
X-CRM114-Status: GOOD (  12.64  )
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

reserve_crashkernel_cma() reserves CMA ranges for the
crash kernel. If allocating the requested size fails, 
try to reserve in smaller pieces.

Store the reserved ranges in the crashk_cma_ranges array
and the number of ranges in crashk_cma_cnt.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>

---
 include/linux/crash_core.h |  9 +++++++
 kernel/crash_core.c        | 52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index f1edefcf7377..5afe3866d35a 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -14,6 +14,13 @@
 extern struct resource crashk_res;
 extern struct resource crashk_low_res;
 
+extern struct range crashk_cma_ranges[];
+#ifdef CONFIG_CMA
+extern int crashk_cma_cnt;
+#else
+#define crashk_cma_cnt 0
+#endif
+
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
@@ -98,6 +105,8 @@ int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *low_size, unsigned long long *cma_size,
 		bool *high);
 
+void __init reserve_crashkernel_cma(unsigned long long cma_size);
+
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 1e952d2e451b..d71ecd59f16b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -15,6 +15,7 @@
 #include <linux/memblock.h>
 #include <linux/kexec.h>
 #include <linux/kmemleak.h>
+#include <linux/cma.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -475,6 +476,57 @@ void __init reserve_crashkernel_generic(char *cmdline,
 }
 #endif
 
+#ifdef CONFIG_CMA
+#define CRASHKERNEL_CMA_RANGES_MAX 4
+
+struct range crashk_cma_ranges[CRASHKERNEL_CMA_RANGES_MAX];
+int crashk_cma_cnt = 0;
+
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
+#else /* CONFIG_CMA */
+struct range crashk_cma_ranges[0];
+void __init reserve_crashkernel_cma(unsigned long long cma_size)
+{
+	if (cma_size)
+		pr_warn("crashkernel CMA reservation failed: CMA disabled\n");
+}
+#endif
+
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
