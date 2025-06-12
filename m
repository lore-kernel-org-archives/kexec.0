Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DF9C71141
	for <kexec@archiver.kernel.org>; Thu, 12 Jun 2025 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1sbQj5PaZtpmNrKn+KyxsA3+QUNkgR2OaWn0POMIpmM=; b=0QetMstmC6uo9dSiBD7/Z6G6cD
	QjYYfxBE2VyvTjeiN1BlpMUdy+NDD6X6m+MhzgFF/jVaRgF5Kjtkmnl964OOAFZg3FoP8S6AlrqV8
	1pef812Xp1joSbYDThv0kimlU1GvW7hkv8rxFRNNWYECpTKOaWZbwWxPsSJwGQeLm9wD+DvzQ9+1h
	+TaD4C2E1D5ZsCzSk3/aETGzTaafGRl7fNh/xUqeieetaJXduunTXtOlNJP7VrHH9bKPQC2DE5VNH
	SzM1wqGhs2iZ0G5T6wMPNASZcenSK/jEhuR/s/FlqQ52XecSSg52c3m668BOj6fYNx38HUzaTNlj9
	MdJHcaNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPhpT-0000000DML9-0YJe;
	Thu, 12 Jun 2025 13:18:51 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPf18-0000000CxCQ-1s4q
	for kexec@lists.infradead.org;
	Thu, 12 Jun 2025 10:18:43 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id 067EC1F78E;
	Thu, 12 Jun 2025 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749723521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sbQj5PaZtpmNrKn+KyxsA3+QUNkgR2OaWn0POMIpmM=;
	b=mfEWIO+9pRR0fr0UwJ3AOpdjt1kF+uz0K1plh8Jz1EHciLtpqsgUiQseZCBybDOCfn7Jzj
	WO1C6wD2qw6Vv3wMCAoIAYdItCQb1frYIm/WTfAHu8H3zFfkJ8XEnbSvM55vz8JtLhmBoD
	Y2KytekB7lT6K9vQhxY6DEQUEX/yV7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749723521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sbQj5PaZtpmNrKn+KyxsA3+QUNkgR2OaWn0POMIpmM=;
	b=9EssITg47xLzey9iQ1XkMQueuhMaePHLbiI2cZ7JS6Btg1f01FbPOIoYKNS+kOnci/jh3c
	K2zzUVuwSqOR+sDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749723521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sbQj5PaZtpmNrKn+KyxsA3+QUNkgR2OaWn0POMIpmM=;
	b=mfEWIO+9pRR0fr0UwJ3AOpdjt1kF+uz0K1plh8Jz1EHciLtpqsgUiQseZCBybDOCfn7Jzj
	WO1C6wD2qw6Vv3wMCAoIAYdItCQb1frYIm/WTfAHu8H3zFfkJ8XEnbSvM55vz8JtLhmBoD
	Y2KytekB7lT6K9vQhxY6DEQUEX/yV7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749723521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sbQj5PaZtpmNrKn+KyxsA3+QUNkgR2OaWn0POMIpmM=;
	b=9EssITg47xLzey9iQ1XkMQueuhMaePHLbiI2cZ7JS6Btg1f01FbPOIoYKNS+kOnci/jh3c
	K2zzUVuwSqOR+sDg==
Date: Thu, 12 Jun 2025 12:18:40 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	akpm@linux-foundation.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v5 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <aEqpgDIBndZ5LXSo@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dwarf.suse.cz:mid,localhost:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_031842_630917_E57B0CB5 
X-CRM114-Status: GOOD (  16.92  )
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

When re-using the CMA area for kdump there is a risk of pending DMA
into pinned user pages in the CMA area.

Pages residing in CMA areas can usually not get long-term pinned and
are instead migrated away from the CMA area, so long-term pinning is
typically not a concern. (BUGs in the kernel might still lead to
long-term pinning of such pages if everything goes wrong.)

Pages pinned without FOLL_LONGTERM remain in the CMA and may possibly
be the source or destination of a pending DMA transfer.

Although there is no clear specification how long a page may be pinned
without FOLL_LONGTERM, pinning without the flag shows an intent of the
caller to only use the memory for short-lived DMA transfers, not a transfer
initiated by a device asynchronously at a random time in the future.

Add a delay of CMA_DMA_TIMEOUT_SEC seconds before starting the kdump
kernel, giving such short-lived DMA transfers time to finish before
the CMA memory is re-used by the kdump kernel.

Set CMA_DMA_TIMEOUT_SEC to 10 seconds - chosen arbitrarily as both
a huge margin for a DMA transfer, yet not increasing the kdump time
too significantly.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>

---
Changes since v4:
- reworded the paragraph about long-term pinning
- simplified crash_cma_clear_pending_dma()
- dropped cma_dma_timeout_sec variable

---
Changes since v3:
- renamed CMA_DMA_TIMEOUT_SEC to CMA_DMA_TIMEOUT_MSEC, change delay to 10 seconds
- introduce a cma_dma_timeout_sec initialized to CMA_DMA_TIMEOUT_SEC
  to make the timeout trivially tunable if needed in the future

---
 kernel/crash_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 335b8425dd4b..a4ef79591eb2 100644
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
+#define CMA_DMA_TIMEOUT_SEC 10
+
 #ifdef CONFIG_CRASH_DUMP
 
 int kimage_crash_copy_vmcoreinfo(struct kimage *image)
@@ -97,6 +103,14 @@ int kexec_crash_loaded(void)
 }
 EXPORT_SYMBOL_GPL(kexec_crash_loaded);
 
+static void crash_cma_clear_pending_dma(void)
+{
+	if (!crashk_cma_cnt)
+		return;
+
+	mdelay(CMA_DMA_TIMEOUT_SEC * 1000);
+}
+
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
  * only when panic_cpu holds the current CPU number; this is the only CPU
@@ -119,6 +133,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
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



