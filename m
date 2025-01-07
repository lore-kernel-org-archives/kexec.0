Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1B1E7719D
	for <kexec@archiver.kernel.org>; Tue,  7 Jan 2025 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8B/uoyeuY57p4F5WrCZvdn0Td4esItXL4IJBDCfsGf4=; b=xYBZZiLAgWGU+k0nn+eEx8Njq7
	u+w9MSHILV/BQ2JLjTq1LQKqs231tkMLRoP98sYuoHF+aqfTmPYjpCiufeFyjfOexJmTuL2x3QrwE
	7H5ywusdsOxcWakJP+ST9VXIW6oCG+7mj1j1i+FYChMkbY7xBoxKMDDqMFvlSy9IhM3pKZz2zJsLC
	bvRQdQcgEhKO9SFOkkDttS//Rok22Vg97f4zEB6XS/qIXpwehlKidgEJq3WKzZoXPlxiSDBBuAGzf
	6fTfKBtAFOS73667caANWpzbg9rc4iI8jVBESZIYoY2SjUvdnUw+1U5L2mg5UBNk7DCZ+gI4dlGY4
	4P9fIkzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV910-00000004pk1-41rl;
	Tue, 07 Jan 2025 12:48:58 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV90U-00000004pW3-2X5m
	for kexec@lists.infradead.org;
	Tue, 07 Jan 2025 12:48:27 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so22629822a91.2
        for <kexec@lists.infradead.org>; Tue, 07 Jan 2025 04:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254105; x=1736858905; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B/uoyeuY57p4F5WrCZvdn0Td4esItXL4IJBDCfsGf4=;
        b=SyegTAX1aHKQ5Lnjj9OvcuWrnsDBcc+rpCrBtRQD+6b36fx/KBtjtYAXZM5NBcQR3f
         h0q/9ZpujXZgc5t7th0xQGIRhV/SHwGhuG+baXRvQTi6wU6r/Sko2FK6SI69AiOTn2xV
         mhIW3FwUE66zkCDt+GqiNkNpz1+eYFI6VWS7GcR4Fe7YzRS/RoTIOTMl5NnBsx1hvLzz
         MI0P/kcGk75C+0r00YCRZ7qsifhvolkGhPK4xtvxiO2ukg4n+ftP3KuslLxgTl8GEvU0
         cNJsGKaZ9mjfAd4ebFFE2zp6kX3j8ciVGL+wQgdkc82u+HWX+7qU8vAVau3QnXbr/lIx
         no0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254105; x=1736858905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B/uoyeuY57p4F5WrCZvdn0Td4esItXL4IJBDCfsGf4=;
        b=ZTrNBV9pPpYDPn+6Ww5U/snQDEGjW0txG/anlUo4bHyjxO4JGR9MuBUkQBxW3s98U8
         kZrR75gYmTQXjhna9HkUqJNhextiAsCFAgj/Sbq71txsXrMsENv6Wa7CSkR4TLC69lSQ
         ZufnvLrYCJXLMl3+VJKKu4kDNB+mJ3ixn0PfWmo31X79hHME9txdAdTOdamZ1QrrvjwM
         dysLXGuLBi3fTFnrD1nj13MXXnr8GMf132Soaxy89eqgDjUCVI0JM6BysqVGqxKY21qd
         sRGwHNQnGGPqkRU8pzgcrDxhx1cwi9Vc7fSq+oNqdh6OK/hVt68c9O998nuUXhKsdyjt
         LIqg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Zsa1blUEufk2h4gLwtje9Kl9bIeO/F5YEXGRZAyL4HI4ZFKUoaOiSK8ITQ6r64Q8arRe2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyou2gcRH7l5XE4oJwYVyjTWKQ40v46pjE6c1MzPtm5XKHgsNkY
	TNSdd1rul9MODSKleB536lSqPioEkJRzaFuR5W5AAo0BmuPuBLQmNR3wOc03I9Q=
X-Gm-Gg: ASbGncvzXToBhi7OHZeVp+sKyMrfIdlD/1sknlEvOlbFCkm7UT4RvcN+odhqQiOipxO
	DzNPMveq7r+uUIDgM5jqbRzbVgW8P6lR147cYLRTsHmWpvTIKJ6QX2Bpg1FR7vVN5HZd9KORU3J
	rh61ctY/gBaKJrGqS7bHwYYgvxayg5vP4WEl38sT+9o97bfAgfTPKN8s2j/vd7QCGzDVdLg3AC6
	IC8TpQkPQnEjIQQSQHckfr7yIiDB4IrGSC8/X2XnANski1dXgGfOavaDds=
X-Google-Smtp-Source: AGHT+IFrm4rj/MLEj5on8APad3buiaiqCoLZIEAZ2AeMT04ViEKVqkKOmnPzjy3rlA6C6aSb7vkHeg==
X-Received: by 2002:a05:6a00:f96:b0:724:ed8f:4d35 with SMTP id d2e1a72fcca58-72abdedda5fmr91700514b3a.26.1736254105569;
        Tue, 07 Jan 2025 04:48:25 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad8fd7b0sm22424647b3a.139.2025.01.07.04.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:25 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:56 +0900
Subject: [PATCH v3 5/6] s390/crash: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
In-Reply-To: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_044826_648189_B64C53D4 
X-CRM114-Status: GOOD (  12.59  )
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

Use note name macros to match with the userspace's expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..6359ce645756 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -248,15 +248,6 @@ bool is_kdump_kernel(void)
 }
 EXPORT_SYMBOL_GPL(is_kdump_kernel);
 
-static const char *nt_name(Elf64_Word type)
-{
-	const char *name = "LINUX";
-
-	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
-		name = KEXEC_CORE_NOTE_NAME;
-	return name;
-}
-
 /*
  * Initialize ELF note
  */
@@ -281,10 +272,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
 	return PTR_ADD(buf, len);
 }
 
-static inline void *nt_init(void *buf, Elf64_Word type, void *desc, int d_len)
-{
-	return nt_init_name(buf, type, desc, d_len, nt_name(type));
-}
+#define NT_INIT(buf, type, desc) \
+	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
 
 /*
  * Calculate the size of ELF note
@@ -300,10 +289,7 @@ static size_t nt_size_name(int d_len, const char *name)
 	return size;
 }
 
-static inline size_t nt_size(Elf64_Word type, int d_len)
-{
-	return nt_size_name(d_len, nt_name(type));
-}
+#define NT_SIZE(type, desc) (nt_size_name(sizeof(desc), NN_ ## type))
 
 /*
  * Fill ELF notes for one CPU with save area registers
@@ -324,18 +310,16 @@ static void *fill_cpu_elf_notes(void *ptr, int cpu, struct save_area *sa)
 	memcpy(&nt_fpregset.fpc, &sa->fpc, sizeof(sa->fpc));
 	memcpy(&nt_fpregset.fprs, &sa->fprs, sizeof(sa->fprs));
 	/* Create ELF notes for the CPU */
-	ptr = nt_init(ptr, NT_PRSTATUS, &nt_prstatus, sizeof(nt_prstatus));
-	ptr = nt_init(ptr, NT_PRFPREG, &nt_fpregset, sizeof(nt_fpregset));
-	ptr = nt_init(ptr, NT_S390_TIMER, &sa->timer, sizeof(sa->timer));
-	ptr = nt_init(ptr, NT_S390_TODCMP, &sa->todcmp, sizeof(sa->todcmp));
-	ptr = nt_init(ptr, NT_S390_TODPREG, &sa->todpreg, sizeof(sa->todpreg));
-	ptr = nt_init(ptr, NT_S390_CTRS, &sa->ctrs, sizeof(sa->ctrs));
-	ptr = nt_init(ptr, NT_S390_PREFIX, &sa->prefix, sizeof(sa->prefix));
+	ptr = NT_INIT(ptr, PRSTATUS, nt_prstatus);
+	ptr = NT_INIT(ptr, PRFPREG, nt_fpregset);
+	ptr = NT_INIT(ptr, S390_TIMER, sa->timer);
+	ptr = NT_INIT(ptr, S390_TODCMP, sa->todcmp);
+	ptr = NT_INIT(ptr, S390_TODPREG, sa->todpreg);
+	ptr = NT_INIT(ptr, S390_CTRS, sa->ctrs);
+	ptr = NT_INIT(ptr, S390_PREFIX, sa->prefix);
 	if (cpu_has_vx()) {
-		ptr = nt_init(ptr, NT_S390_VXRS_HIGH,
-			      &sa->vxrs_high, sizeof(sa->vxrs_high));
-		ptr = nt_init(ptr, NT_S390_VXRS_LOW,
-			      &sa->vxrs_low, sizeof(sa->vxrs_low));
+		ptr = NT_INIT(ptr, S390_VXRS_HIGH, sa->vxrs_high);
+		ptr = NT_INIT(ptr, S390_VXRS_LOW, sa->vxrs_low);
 	}
 	return ptr;
 }
@@ -348,16 +332,16 @@ static size_t get_cpu_elf_notes_size(void)
 	struct save_area *sa = NULL;
 	size_t size;
 
-	size =	nt_size(NT_PRSTATUS, sizeof(struct elf_prstatus));
-	size +=  nt_size(NT_PRFPREG, sizeof(elf_fpregset_t));
-	size +=  nt_size(NT_S390_TIMER, sizeof(sa->timer));
-	size +=  nt_size(NT_S390_TODCMP, sizeof(sa->todcmp));
-	size +=  nt_size(NT_S390_TODPREG, sizeof(sa->todpreg));
-	size +=  nt_size(NT_S390_CTRS, sizeof(sa->ctrs));
-	size +=  nt_size(NT_S390_PREFIX, sizeof(sa->prefix));
+	size =	NT_SIZE(PRSTATUS, struct elf_prstatus);
+	size +=  NT_SIZE(PRFPREG, elf_fpregset_t);
+	size +=  NT_SIZE(S390_TIMER, sa->timer);
+	size +=  NT_SIZE(S390_TODCMP, sa->todcmp);
+	size +=  NT_SIZE(S390_TODPREG, sa->todpreg);
+	size +=  NT_SIZE(S390_CTRS, sa->ctrs);
+	size +=  NT_SIZE(S390_PREFIX, sa->prefix);
 	if (cpu_has_vx()) {
-		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
-		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
+		size += NT_SIZE(S390_VXRS_HIGH, sa->vxrs_high);
+		size += NT_SIZE(S390_VXRS_LOW, sa->vxrs_low);
 	}
 
 	return size;
@@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
 	memset(&prpsinfo, 0, sizeof(prpsinfo));
 	prpsinfo.pr_sname = 'R';
 	strcpy(prpsinfo.pr_fname, "vmlinux");
-	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
+	return NT_INIT(ptr, PRPSINFO, prpsinfo);
 }
 
 /*
@@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
 	/* PT_NOTES */
 	size += sizeof(Elf64_Phdr);
 	/* nt_prpsinfo */
-	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
+	size += NT_SIZE(PRPSINFO, struct elf_prpsinfo);
 	/* regsets */
 	size += get_cpu_cnt() * get_cpu_elf_notes_size();
 	/* nt_vmcoreinfo */

-- 
2.47.1


