Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8E8CA0EE4
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lS0KhibryFMyN1QylEfnZ945a0b2l+vbar/NBul3um8=; b=gN8wjm11Y1Yf5rUVuxp3bk8mDP
	b5lofSi7L469a+vtb5GoHVylXjC1AZ+DuY4/6CTNz6nEpxZCwIBAh/kTFEcuyJaOkhbNc6qhfLtwv
	aewOoEOoU555tGRlK9FyhuIFUOm5JUwJ95QeaLAgYxeMoPr4hvfBZlWiVde5ifQVTVMFurgwjX4py
	G5A9OG5ZtWTZZezMvGZwIZl1d9Pab3huz3zD/sdiDkz19255ctuWNpNonJFzyFW7vRJRDWvfsHeNt
	rQiD7GfFPLWZxE7c+Rp9qItR8hziHJ2WeRXwR2gFT+vZksg4ZG0BgDTsMD72s/jn7VsVV+wEOrB1/
	Q0mT03pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoB8F-000000095XP-29gn;
	Tue, 19 Aug 2025 01:27:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoB7n-000000095L9-39CR
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 01:26:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lS0KhibryFMyN1QylEfnZ945a0b2l+vbar/NBul3um8=;
	b=gDEV67KX9YLPfRtmZ45uDIhjJPssG9jFs5Q6Q+4D9z7tNB5mbQa5QrYnh106w0JwNzdhTM
	zoPtQDAYpdzS6XxARsibqMPc4ExsPYTVDbcgtMcUJ7F1DpgQRNkOfD0CNNw7dFekyyCdey
	nrcV9tOr1OO/MVTqrfvd3N8tofl+siY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-vg9rBuIwMUW17YqGsEL8lw-1; Mon,
 18 Aug 2025 21:26:50 -0400
X-MC-Unique: vg9rBuIwMUW17YqGsEL8lw-1
X-Mimecast-MFC-AGG-ID: vg9rBuIwMUW17YqGsEL8lw_1755566808
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B39180048E;
	Tue, 19 Aug 2025 01:26:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EF94180028A;
	Tue, 19 Aug 2025 01:26:36 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv5 08/12] kexec: Factor out routine to find a symbol in ELF
Date: Tue, 19 Aug 2025 09:24:24 +0800
Message-ID: <20250819012428.6217-9-piliu@redhat.com>
In-Reply-To: <20250819012428.6217-1-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_182655_858536_3747D5C3 
X-CRM114-Status: GOOD (  17.43  )
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

The routine to search a symbol in ELF can be shared, so split it out.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 include/linux/kexec.h |  8 ++++
 kernel/kexec_file.c   | 86 +++++++++++++++++++++++--------------------
 2 files changed, 54 insertions(+), 40 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8f7322c932fb5..2998d8da09d86 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -23,6 +23,10 @@
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
 
+#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
+#include <linux/module.h>
+#endif
+
 extern note_buf_t __percpu *crash_notes;
 
 #ifdef CONFIG_CRASH_DUMP
@@ -550,6 +554,10 @@ void set_kexec_sig_enforced(void);
 static inline void set_kexec_sig_enforced(void) {}
 #endif
 
+#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
+const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
+#endif
+
 #endif /* !defined(__ASSEBMLY__) */
 
 #endif /* LINUX_KEXEC_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 4780d8aae24e7..137049e7e2410 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -880,6 +880,51 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
+#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
+const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name)
+{
+	const Elf_Shdr *sechdrs;
+	const Elf_Sym *syms;
+	const char *strtab;
+	int i, k;
+
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type != SHT_SYMTAB)
+			continue;
+
+		if (sechdrs[i].sh_link >= ehdr->e_shnum)
+			/* Invalid strtab section number */
+			continue;
+		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
+		syms = (void *)ehdr + sechdrs[i].sh_offset;
+
+		/* Go through symbols for a match */
+		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
+			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
+				continue;
+
+			if (strcmp(strtab + syms[k].st_name, name) != 0)
+				continue;
+
+			if (syms[k].st_shndx == SHN_UNDEF ||
+			    syms[k].st_shndx >= ehdr->e_shnum) {
+				pr_debug("Symbol: %s has bad section index %d.\n",
+						name, syms[k].st_shndx);
+				return NULL;
+			}
+
+			/* Found the symbol we are looking for */
+			return &syms[k];
+		}
+	}
+
+	return NULL;
+}
+
+#endif
+
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
 /*
  * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
@@ -1137,49 +1182,10 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 						  const char *name)
 {
-	const Elf_Shdr *sechdrs;
-	const Elf_Ehdr *ehdr;
-	const Elf_Sym *syms;
-	const char *strtab;
-	int i, k;
-
 	if (!pi->ehdr)
 		return NULL;
 
-	ehdr = pi->ehdr;
-	sechdrs = (void *)ehdr + ehdr->e_shoff;
-
-	for (i = 0; i < ehdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type != SHT_SYMTAB)
-			continue;
-
-		if (sechdrs[i].sh_link >= ehdr->e_shnum)
-			/* Invalid strtab section number */
-			continue;
-		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
-		syms = (void *)ehdr + sechdrs[i].sh_offset;
-
-		/* Go through symbols for a match */
-		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
-			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
-				continue;
-
-			if (strcmp(strtab + syms[k].st_name, name) != 0)
-				continue;
-
-			if (syms[k].st_shndx == SHN_UNDEF ||
-			    syms[k].st_shndx >= ehdr->e_shnum) {
-				pr_debug("Symbol: %s has bad section index %d.\n",
-						name, syms[k].st_shndx);
-				return NULL;
-			}
-
-			/* Found the symbol we are looking for */
-			return &syms[k];
-		}
-	}
-
-	return NULL;
+	return elf_find_symbol(pi->ehdr, name);
 }
 
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
-- 
2.49.0


