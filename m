Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CB6C021B3
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=; b=dOE7zJAQrAkXMZ1Zaaxr1t5clH
	7ZjyhVQNJsfYAohqj31iXUxGw4BDaKwaih0Dw61VSltLxhb2fXFKoBlDLcm61sYDri04GVnwvmy36
	kBD3M9PjyiGE3D9eZBnMRkohuhyiOagLJUfvThi19vz/AEMPEfv2OE1p25cglaxCZVLuAxRc9TmJR
	I/KpUQqYwluyagngt+J/AcjR8KFndMj3/M732ruWW/+Y9UUdNs4BA6wEha7e3s/VmBldbT9DE6wrC
	Hwqm3gu9rOG6yI9/ivX+xrJaPeOTqXoSSBh+J6rRfC0D+owamfu2fVzBK7t8IJhIbnoa7Ove6Qhdk
	3AfpqPLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9ro-000000020FT-1qbK;
	Thu, 20 Feb 2025 16:57:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9rl-000000020EE-3axJ
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 16:57:39 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 45FF721174;
	Thu, 20 Feb 2025 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=;
	b=WRAG8TLSypGQ5C466jsiybvF2rx1BbQ4YXGiULc5T1WjBBMQMMS52pS4+K2TNj/zsPM2sn
	JuR6P5Qp3ib3PiWZf+v9N2AknxrG6LY+d9zj+cYuUNA8nul5lVGymKdByh3HwYuZtqhCwQ
	mRPI/hNfy6iyTcAa49pm0LCISTL8XAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=;
	b=3qcjb+yB67/aGGYDFCnH2i57/Z4h7UfX8KLx9GCpinpge687TQPf0+n8Khrc12fdlN1TK7
	tO/2SgvjOlBWMcBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=;
	b=WRAG8TLSypGQ5C466jsiybvF2rx1BbQ4YXGiULc5T1WjBBMQMMS52pS4+K2TNj/zsPM2sn
	JuR6P5Qp3ib3PiWZf+v9N2AknxrG6LY+d9zj+cYuUNA8nul5lVGymKdByh3HwYuZtqhCwQ
	mRPI/hNfy6iyTcAa49pm0LCISTL8XAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAje/oszgqXSx3kWAldq5HwVj5OdtILzxGPWJh8nXcM=;
	b=3qcjb+yB67/aGGYDFCnH2i57/Z4h7UfX8KLx9GCpinpge687TQPf0+n8Khrc12fdlN1TK7
	tO/2SgvjOlBWMcBg==
Date: Thu, 20 Feb 2025 17:57:36 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v2 5/5] x86: implement crashkernel cma reservation
Message-ID: <Z7dfAFIP2Ne0QFOy@dwarf.suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.782];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,localhost:helo,dwarf.suse.cz:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_085738_039891_2A63C044 
X-CRM114-Status: GOOD (  17.66  )
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

Implement the crashkernel CMA reservation for x86:
- enable parsing of the cma suffix by parse_crashkernel()
- reserve memory with reserve_crashkernel_cma()
- add the CMA-reserved ranges to the e820 map for the crash kernel
- exclude the CMA-reserved ranges from vmcore

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++----
 arch/x86/kernel/setup.c |  5 +++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 340af8155658..70823fa9abea 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -163,10 +163,10 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 		return NULL;
 
 	/*
-	 * Exclusion of crash region and/or crashk_low_res may cause
-	 * another range split. So add extra two slots here.
+	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
+	 * may cause range splits. So add extra slots here.
 	 */
-	nr_ranges += 2;
+	nr_ranges += 2 + crashk_cma_cnt;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -184,6 +184,7 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 static int elf_header_exclude_ranges(struct crash_mem *cmem)
 {
 	int ret = 0;
+	int i;
 
 	/* Exclude the low 1M because it is always reserved */
 	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
@@ -198,8 +199,17 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	if (crashk_low_res.end)
 		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
 					      crashk_low_res.end);
+	if (ret)
+		return ret;
 
-	return ret;
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
+					      crashk_cma_ranges[i].end);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
@@ -352,6 +362,14 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 		add_e820_entry(params, &ei);
 	}
 
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ei.addr = crashk_cma_ranges[i].start;
+		ei.size = crashk_cma_ranges[i].end -
+			  crashk_cma_ranges[i].start + 1;
+		ei.type = E820_TYPE_RAM;
+		add_e820_entry(params, &ei);
+	}
+
 out:
 	vfree(cmem);
 	return ret;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 853afde761a7..90e10a18f0c9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -471,7 +471,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size, low_size = 0;
+	unsigned long long crash_base, crash_size, low_size = 0, cma_size = 0;
 	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
@@ -481,7 +481,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, NULL, &high);
+				&low_size, &cma_size, &high);
 	if (ret)
 		return;
 
@@ -492,6 +492,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
 				    low_size, high);
+	reserve_crashkernel_cma(cma_size);
 }
 
 static struct resource standard_io_resources[] = {

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


