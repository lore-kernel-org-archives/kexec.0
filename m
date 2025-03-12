Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61596C28B28
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 21:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=; b=W4Uft3O2r+ffVoF00m+LHA/7o5
	1BjWN5ezhw1pUQp8jwjPL6vBXPjIdWR3lJ2VfISmWN335oq3RFL97Zb/RThyL5Qg1JOR6YkZxBWvd
	XhDFG0BSVssHiVwcu7M0D5D8yetvT4bzqRKtH4Ap70fHt/Wyd/uCKzg9LI5GfAR+ZRtmOvdp9AK1w
	LvPRuqZhh7GX89OYYIOCbwnMey8NxZCVUOQuiFoSzw6XVuUFNd1pdl07izgf7lt8z0JuZo3UAKjj7
	ymEjb9+PTaLV9+TdeYB+j8tAtzKZP7hisUBksqJfvEVKXNHdfR4BpfQI1Fm9O92ejTbT88MRlBcWt
	hggvhslg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsTLm-00000009VyG-0Zev;
	Wed, 12 Mar 2025 21:10:50 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsTLk-00000009Vxg-0jiG
	for kexec@lists.infradead.org;
	Wed, 12 Mar 2025 21:10:49 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id A381E21188;
	Wed, 12 Mar 2025 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=;
	b=EUG4ooiJzmLFhsxqLk5IfpT3zhYGrDIYMHjKo+KQDkpKV8B+cUxFdoB3PUyE6fcaO4/cBT
	pgRzJtBCjIKP48JQhiACiOje8Y62bv8045BgzZ+5DVOfZbHYgp+LfNKxLzPL3vN6uP4h7g
	kewNofBNLwARLwbU1+Xzvbo6uouUS5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=;
	b=6F2/uq17vUtb13lJ9QPrT49se5eI7CNvCecQPaSK3ykdNkU6wdGbJFu61uxDvO84EORj0+
	EENnbeQ2j2ejzzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=;
	b=EUG4ooiJzmLFhsxqLk5IfpT3zhYGrDIYMHjKo+KQDkpKV8B+cUxFdoB3PUyE6fcaO4/cBT
	pgRzJtBCjIKP48JQhiACiOje8Y62bv8045BgzZ+5DVOfZbHYgp+LfNKxLzPL3vN6uP4h7g
	kewNofBNLwARLwbU1+Xzvbo6uouUS5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVAkE5ITz3xbVBTsELj7FWN8tR4JCna6Us6nfaQKMwE=;
	b=6F2/uq17vUtb13lJ9QPrT49se5eI7CNvCecQPaSK3ykdNkU6wdGbJFu61uxDvO84EORj0+
	EENnbeQ2j2ejzzBw==
Date: Wed, 12 Mar 2025 22:10:46 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v3 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <Z9H4VjqqriDNIaFA@dwarf.suse.cz>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[localhost:helo,dwarf.suse.cz:mid,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_141048_361751_0B68FFC4 
X-CRM114-Status: GOOD (  16.06  )
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

Add a delay of CMA_DMA_TIMEOUT_MSEC milliseconds before starting the kdump
kernel, giving such short-lived DMA transfers time to finish before the CMA
memory is re-used by the kdump kernel.

Set CMA_DMA_TIMEOUT_MSEC to 1000 (one second) - chosen arbitrarily as both
a huge margin for a DMA transfer, yet not increasing the kdump time
significantly.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 include/linux/crash_core.h |  5 +++++
 kernel/crash_core.c        | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 44305336314e..543e4a71f13c 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -56,6 +56,11 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
+/* Time to wait for possible DMA to finish before starting the kdump kernel
+ * when a CMA reservation is used
+ */
+#define CMA_DMA_TIMEOUT_MSEC 1000
+
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 078fe5bc5a74..ed152af08d1e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -21,6 +21,7 @@
 #include <linux/reboot.h>
 #include <linux/btf.h>
 #include <linux/objtool.h>
+#include <linux/delay.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -97,6 +98,14 @@ int kexec_crash_loaded(void)
 }
 EXPORT_SYMBOL_GPL(kexec_crash_loaded);
 
+static void crash_cma_clear_pending_dma(void)
+{
+	if (!crashk_cma_cnt)
+		return;
+
+	mdelay(CMA_DMA_TIMEOUT_MSEC);
+}
+
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
  * only when panic_cpu holds the current CPU number; this is the only CPU
@@ -119,6 +128,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
+			crash_cma_clear_pending_dma();
 			machine_kexec(kexec_crash_image);
 		}
 		kexec_unlock();
-- 
2.46.0

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


