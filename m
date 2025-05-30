Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073B5C5AD49
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8NQd5gasV9yRZqY5QWuXoZowjL9igfGI29jVx4p+xA=; b=zbvizG9DShpUnUJhoN1ihseLhG
	2s3n2jmqQBE8byf3HRVz9Dm37JGiDEoapDIH3j+YUROQQ1VVuVJzt3FpNGUYWvDbNuoVtTdTnIiMk
	fIBs2GgLAMUTFoVzAA+PUB6GzHsPPfiBsH8McH1Wv6QpU1yAr8VWZX6euIPNRCw33duK3DEd13DbX
	bOjEzSLp6teFXmYPy3S1j95sYQeo8BCdpKGoH48sjLmct7QNrPNyat4cypsGo91JlJzKVBa9u+b1q
	dTs3q4s3pza2gfJ6azvnl8L3Mmrg8LdMCLS1N8+uQ4TayxxOnYfPcfkNU5l0T84uDx/EGjoCTyLFR
	GR5HC5IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL6MS-00000001njl-1cyO;
	Fri, 30 May 2025 20:29:52 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL6MQ-00000001njP-1Rue
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 20:29:51 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 706A421D73;
	Fri, 30 May 2025 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748636988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8NQd5gasV9yRZqY5QWuXoZowjL9igfGI29jVx4p+xA=;
	b=sPCe0juk2gRzEjKs/wIkQrlwja1m4lH6TcAx9qF2PXnGd7QRQSYKMJHQXd5rxNz5df3MKW
	9y+YNkgEmqaD4xxksrkXTKg33CVpvG1Shqee0sjFbtoPj8Cbw3Rc5iqa/QR0hFgKkhCk8t
	nExLP4UXCkyJS6xoymP0/bb6SS3clEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748636988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8NQd5gasV9yRZqY5QWuXoZowjL9igfGI29jVx4p+xA=;
	b=L5cIR7yPIxp+QWjYotUGRaK2tUT3rpneVdr9c3XW79sPu8fMPosHmdgxF9LgW8f2eYR4CY
	Qg37mxitiBx9MNAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748636987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8NQd5gasV9yRZqY5QWuXoZowjL9igfGI29jVx4p+xA=;
	b=VuzI0KDa2nd8/KkZK/0HKK3UkJ23SsQOpTxrrWpUyeG4Fia2ynyW2tfxxF5KuZnPpu8KO0
	snYfDUCybBrfpRw0nr4T6S9j4J/rcrx8cRzPEBNvtCtm9DRZq+QMPmGRYvKP6CpVx4n2Jw
	cFCaNwMABb+EIkAgiAWj7toKiBkbhuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748636987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8NQd5gasV9yRZqY5QWuXoZowjL9igfGI29jVx4p+xA=;
	b=KTvd80OBspms3JDqJKanOM2Sb6RLhJ/7dfDKmaKOLSWpvjj5ihlBESa6yiyDJ9jlcO3ybR
	+j1uwCryUjL4ByCQ==
Date: Fri, 30 May 2025 22:29:47 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v4 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <aDoVO4H4CpXPjAdI@dwarf.suse.cz>
References: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dwarf.suse.cz:mid,suse.cz:email,localhost:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_132950_537110_8ED4078D 
X-CRM114-Status: GOOD (  18.12  )
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

When re-using the CMA area for kdump there is a risk of pending DMA into
pinned user pages in the CMA area.

Pages that are pinned long-term are migrated away from CMA, so these are
not a concern. Pages pinned without FOLL_LONGTERM remain in the CMA and may
possibly be the source or destination of a pending DMA transfer.

Although there is no clear specification how long a page may be pinned
without FOLL_LONGTERM, pinning without the flag shows an intent of the
caller to only use the memory for short-lived DMA transfers, not a transfer
initiated by a device asynchronously at a random time in the future.

Add a delay of CMA_DMA_TIMEOUT_SEC seconds before starting the kdump
kernel, giving such short-lived DMA transfers time to finish before the CMA
memory is re-used by the kdump kernel.

Set CMA_DMA_TIMEOUT_SEC to 10 seconds - chosen arbitrarily as both
a huge margin for a DMA transfer, yet not increasing the kdump time
too significantly.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>

---
Changes since v3:
- renamed CMA_DMA_TIMEOUT_SEC to CMA_DMA_TIMEOUT_MSEC, change delay to 10 seconds
- introduce a cma_dma_timeout_sec initialized to CMA_DMA_TIMEOUT_SEC
  to make the timeout trivially tunable if needed in the future

---
 include/linux/crash_core.h |  3 +++
 kernel/crash_core.c        | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 44305336314e..805a07042c96 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -56,6 +56,9 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
+/* Default value for cma_dma_timeout_sec */
+#define CMA_DMA_TIMEOUT_SEC 10
+
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 335b8425dd4b..a255c9e2ef29 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -21,6 +21,7 @@
 #include <linux/reboot.h>
 #include <linux/btf.h>
 #include <linux/objtool.h>
+#include <linux/delay.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -33,6 +34,11 @@
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
+/* time to wait for possible DMA to finish before starting the kdump kernel
+ * when a CMA reservation is used
+ */
+unsigned int cma_dma_timeout_sec = CMA_DMA_TIMEOUT_SEC;
+
 #ifdef CONFIG_CRASH_DUMP
 
 int kimage_crash_copy_vmcoreinfo(struct kimage *image)
@@ -97,6 +103,17 @@ int kexec_crash_loaded(void)
 }
 EXPORT_SYMBOL_GPL(kexec_crash_loaded);
 
+static void crash_cma_clear_pending_dma(void)
+{
+	unsigned int s = cma_dma_timeout_sec;
+
+	if (!crashk_cma_cnt)
+		return;
+
+	while (s--)
+		mdelay(1000);
+}
+
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
  * only when panic_cpu holds the current CPU number; this is the only CPU
@@ -119,6 +135,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
+			crash_cma_clear_pending_dma();
 			machine_kexec(kexec_crash_image);
 		}
 		kexec_unlock();

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


