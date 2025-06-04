Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37B8C5B543
	for <kexec@archiver.kernel.org>; Wed,  4 Jun 2025 07:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=56cQPDkweYJVMIO8Oci9vsmGNfnHiTtULArO7sVXI0E=; b=wEoqbPbIeHOqI1cFjYWxYR0rgf
	9PGU3yNpCYz48CXZG+eFGT6wuftO83sPnUrpZtKDlT0Ih/Mb18nA3RN+AOXDwk9aF0FubX10s2l0N
	Qrt9FG7hDpJQEvGmck7FsXZn5IhB4WvMBFudLLP2YtdBDI+E+AfuMmKMaiPYTUH2M534kmoZPNxNL
	jBQtT6IlCHsY5x7++wMsJcTuzlNRqyvdIKJQXolzHI9RyS8vIGIGt8mv72+mzaVg28eYpW0Zmm75o
	MvdtnXNQWVAEd2djBBkcSNBGTFW9gFpBV75g5hhUz7itJkwN+3oNYMeaQ2K0OPkNisxdpE8VGCUIT
	Pi67/hEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMijj-0000000CmjJ-31YP;
	Wed, 04 Jun 2025 07:40:35 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMijg-0000000Cmic-1sLA
	for kexec@lists.infradead.org;
	Wed, 04 Jun 2025 07:40:33 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id C0D1E203E5;
	Wed,  4 Jun 2025 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749022829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56cQPDkweYJVMIO8Oci9vsmGNfnHiTtULArO7sVXI0E=;
	b=OxVEDYUsfzYZ8xLXAyKnAep5+KO8k1PveIDBEEmCWHTQ4eS8oThZT0+ho+B5Wb1NmHnGW/
	MH6K6tJXSf730OJJUAsmL1esZW6+iYIjlDSn1Gb0NBGikfEClqbPI8KDiECcHXFoLYIeGN
	RenGbSrvnINQqRQdV9GAd3eCOvFhYEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749022829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56cQPDkweYJVMIO8Oci9vsmGNfnHiTtULArO7sVXI0E=;
	b=UZIaHJ3RHQIdgYLYuU4/PIRCCWguUqwjEreL+bp2SSgkwji2YmH80JvHeYeKO8HT6ILLiv
	wndEVd0nFMHoSfDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749022829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56cQPDkweYJVMIO8Oci9vsmGNfnHiTtULArO7sVXI0E=;
	b=OxVEDYUsfzYZ8xLXAyKnAep5+KO8k1PveIDBEEmCWHTQ4eS8oThZT0+ho+B5Wb1NmHnGW/
	MH6K6tJXSf730OJJUAsmL1esZW6+iYIjlDSn1Gb0NBGikfEClqbPI8KDiECcHXFoLYIeGN
	RenGbSrvnINQqRQdV9GAd3eCOvFhYEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749022829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56cQPDkweYJVMIO8Oci9vsmGNfnHiTtULArO7sVXI0E=;
	b=UZIaHJ3RHQIdgYLYuU4/PIRCCWguUqwjEreL+bp2SSgkwji2YmH80JvHeYeKO8HT6ILLiv
	wndEVd0nFMHoSfDg==
Date: Wed, 4 Jun 2025 09:40:29 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v4 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <aD_4bT1AJv7aKhxy@dwarf.suse.cz>
References: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
 <aDoVO4H4CpXPjAdI@dwarf.suse.cz>
 <da52a835-6a4b-4f11-acac-f4ef995da7e1@redhat.com>
 <aD8b7Q8Z9sC8meGU@dwarf.suse.cz>
 <d7cbbab2-8fe0-4a10-8b06-e47da955865e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cbbab2-8fe0-4a10-8b06-e47da955865e@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_004032_916162_E39892B7 
X-CRM114-Status: GOOD (  24.96  )
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

On Tue, Jun 03, 2025 at 06:25:57PM +0200, David Hildenbrand wrote:
> On 03.06.25 17:59, Jiri Bohac wrote:
> I'd phrase it more like "Pages residing in CMA areas can usually not get
> long-term pinned, so long-term pinning is typically not a concern. BUGs in
> the kernel might still lead to long-term pinning of such pages if everything
> goes wrong."

...

> > If you want, I have no problem changing this to:
> > +	mdelay(cma_dma_timeout_sec * 1000);
> 
> Probably good enough. Or just hard-code 10s and call it a day. :)

Thanks for your comments, David. This would be the v5 of this
patch:

Subject: [PATCH v5 4/5] kdump: wait for DMA to finish when using CMA

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

---
Changes since v4:
- reworded the paragraph about long-term pinning
- simplified crash_cma_clear_pending_dma()

---
Changes since v3:
- renamed CMA_DMA_TIMEOUT_SEC to CMA_DMA_TIMEOUT_MSEC, change delay to 10 seconds
- introduce a cma_dma_timeout_sec initialized to CMA_DMA_TIMEOUT_SEC
  to make the timeout trivially tunable if needed in the future

---
 include/linux/crash_core.h |  3 +++
 kernel/crash_core.c        | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

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
index 335b8425dd4b..540fd75a4a0d 100644
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
@@ -97,6 +103,14 @@ int kexec_crash_loaded(void)
 }
 EXPORT_SYMBOL_GPL(kexec_crash_loaded);
 
+static void crash_cma_clear_pending_dma(void)
+{
+	if (!crashk_cma_cnt)
+		return;
+
+	mdelay(cma_dma_timeout_sec * 1000);
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


