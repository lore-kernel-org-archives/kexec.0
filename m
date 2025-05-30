Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAF3C5AD49
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 20:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uMbqOq33x3vOJ68EATwmEk6cpgBWsvmpKngMdwH5CO0=; b=gXa7O9ZGGifaTXQUQ2dnayu3V5
	v916dpQlY7gdtKH8tOF5ZcSzBetIPD9lbrZejeg7WAoDFyESgE7IhfGMJllXTal016QbFMdIdgbEv
	c4JHFQZFRawMiy2k4D5NTaDwZLKGr0IngCJ3/Rky01+MHLQ1oDTwmdsBGrsOcqrt/So5pXWmAzGmG
	LBGqPHSo1tdPCNGgJOrvLF1pnsq9mCNDj0Z/yjvOPrjp9oVXZdcpmhKiOJz7cTV0QMtzM8ql73Ss5
	l9UF7e/Bs48oUL9uO82EspJcfWboT/6hO6xwVrLDc6SyYktYqfiuuA7jAs8+ZJBZZ6uY9vmhRQEoA
	yqKA6qFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL6Nc-00000001nqb-3Z5N;
	Fri, 30 May 2025 20:31:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL6NZ-00000001nq4-39nj
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 20:31:03 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id 44E9C1F7CB;
	Fri, 30 May 2025 20:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748637060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMbqOq33x3vOJ68EATwmEk6cpgBWsvmpKngMdwH5CO0=;
	b=ePfUupjwTN7LL0VVuBpKf4c0zfX99Za1aknzt3Qjr4+Cov5fta6IAHsAXBsdroVFGkSMqC
	fnWYCCN0s4VGUdtH2kaeF6FkYaXhPTrWk/f9FQFvwF9HfYrooQbtL4jVZi9NQIYP3CWhaZ
	tjBS93Y4ZwUpgFk7Io94H8cNUZE/GOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748637060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMbqOq33x3vOJ68EATwmEk6cpgBWsvmpKngMdwH5CO0=;
	b=cfCQ3PEstVarIP2TXGuAumWOibgzrj8BspXQwC032aUp0QnIWuQQg/fleBnoMT+SokMdNH
	8KupftJkFqbu4RBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748637060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMbqOq33x3vOJ68EATwmEk6cpgBWsvmpKngMdwH5CO0=;
	b=ePfUupjwTN7LL0VVuBpKf4c0zfX99Za1aknzt3Qjr4+Cov5fta6IAHsAXBsdroVFGkSMqC
	fnWYCCN0s4VGUdtH2kaeF6FkYaXhPTrWk/f9FQFvwF9HfYrooQbtL4jVZi9NQIYP3CWhaZ
	tjBS93Y4ZwUpgFk7Io94H8cNUZE/GOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748637060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMbqOq33x3vOJ68EATwmEk6cpgBWsvmpKngMdwH5CO0=;
	b=cfCQ3PEstVarIP2TXGuAumWOibgzrj8BspXQwC032aUp0QnIWuQQg/fleBnoMT+SokMdNH
	8KupftJkFqbu4RBg==
Date: Fri, 30 May 2025 22:31:00 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v4 5/5] x86: implement crashkernel cma reservation
Message-ID: <aDoVhDc11ZcJyHm2@dwarf.suse.cz>
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
X-CRM114-CacheID: sfid-20250530_133101_939799_96C2C637 
X-CRM114-Status: GOOD (  17.91  )
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
index 0be61c45400c..670aa9b8b0f8 100644
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
index 870b06571b2e..dcbeba344825 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -573,7 +573,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size, low_size = 0;
+	unsigned long long crash_base, crash_size, low_size = 0, cma_size = 0;
 	bool high = false;
 	int ret;
 
@@ -582,7 +582,7 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, NULL, &high);
+				&low_size, &cma_size, &high);
 	if (ret)
 		return;
 
@@ -592,6 +592,7 @@ static void __init arch_reserve_crashkernel(void)
 	}
 
 	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
+	reserve_crashkernel_cma(cma_size);
 }
 
 static struct resource standard_io_resources[] = {


-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


