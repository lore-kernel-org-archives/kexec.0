Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BB6C02187
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 05:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gqxfn2Bh8pqSgpWAhYuCaH8o2BUeXgVOaRACTrcmMAY=; b=20HltWuWptC60Vi80x4mLMfdi4
	1ZGcXZyVV1gkX+o/0NmVWdQq69sLMyVtAqhpx3rDYcfXAIBVIx52TpicezXi7QlahNy0JOGS1sgFD
	alYkPmI+rk/vbnct3O+jcP+PQpSRumrdLp+mbjP41Y4xusHjsX5ZokTnY/9u7w5JWdcGDG71cNp1W
	wgc1wHHQApxX6nUHwRz/PpWDd1BJNbij9Mj0Hr8X2+qy6uFDDCm2dORU5EhOEL3zcSpfF+AUGnx8q
	itB4a17ZJyYajD+uWabGY5dtgdceaSferIZM37BYpqyeAkxkOBQXApEU4kXr5Y/hoWOfBzXRKuIrQ
	Mx7/GKKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwHC-0000000AjI3-3b3Q;
	Wed, 15 Jan 2025 05:49:14 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwH9-0000000AjFS-1ZtA
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 05:49:12 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-21636268e43so148571275ad.2
        for <kexec@lists.infradead.org>; Tue, 14 Jan 2025 21:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920151; x=1737524951; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqxfn2Bh8pqSgpWAhYuCaH8o2BUeXgVOaRACTrcmMAY=;
        b=tv5xYgO6OfC0yeoPI6dI1psXPjb2YAoSnwsCExNOWnQkR+ZypbRNeYYFISlI4rGXey
         KjN50q+VxayZsfsXoFfAjmxa2agpsEh7KGFwJnbucjKN+iDmu1KFSfrUGVdatjP6ZFiR
         dreXy7gDMnoORKUnI3hCnf0FVXJ9EDcV9JU5hE1GqHn8slHoIDmj8zAXZye+0dVfyWXt
         EnpytX/sgCbktEiIE9q/SF2xe0jievOV4vbyTN7Br/E8Wo9BlV16PE12b9W4BHXvnoFh
         KXbrEqFSnmapTcXfbezXMqU9Bi1HdhFPYzoWNPab5DNtp3L4HXHKrohDNXXqY5YOpTcw
         zHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920151; x=1737524951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqxfn2Bh8pqSgpWAhYuCaH8o2BUeXgVOaRACTrcmMAY=;
        b=oflZzRUJb6LjJvxYsUHMrf79UE0s6bEvB3EWGY2pC/8lBOJvNgFrbtXCK6BGz7Yn+m
         ry3XTNV2wuRbmh9tJz14v9FBxeDCVOthdkU9Hh6Jk7c0D24Lpv7Up3dQOZpIWvwJeUXY
         2+N3d8Zw5iw84FwA1yW/FcnX8D4ZXB2nurLe3un2ivVlq9Fm90/hq+zaUQRvEkMPCAEN
         ySQmRsViiRLmtAF+6rr8F5TX6y2+MHKd5BQ35om/FWgJzrsI4c9zLHunq3u/mAqcIeJZ
         6nKnhZ/98neMR4cuXqKXyM8cfTBwt9KDcVaGjnwmX1fZ6OQ3hsPCvdXJmb5AudinEKVK
         AR8A==
X-Forwarded-Encrypted: i=1; AJvYcCWxxvDwP2d0vmF9NREikGZceOM9QrFkaDbwlRJo/pkgCX0vsFnET5nOHk1Pjq6JoC1OVX/uOA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy74eVUaf9LVqIR/66bwquuupOIk3dlbK25l0BE1hRfyWyMuR6f
	M4Vm79xmbyPIarCzG+bBh3qIQPCrMGhfsGwlMKRcAVpaS4OFdBg6ybOkfPHL71I=
X-Gm-Gg: ASbGncsYkzoZwwbDbCsqY/GWS63H+VRISfD72oafm8m+t0v29Lq/O/pfJKeq42i6Ogq
	q9avjHb0L9roLWxqTciCoD4NUg2Dr9vJJRrOcGhGoaVwhzyGCi3R/Mu1b6k7wPayI0xjhjVe6+/
	aaaQQ7lfk+zw1lLNFgxR9/cdhPAd7OtW/xJxj8V47c+zb8Zik4YHZCDw+C0+cIwHDRr53YsYntP
	HnjT9ecunhm41UxwROFtG5304q9jplCf0jeeTTyBs/XvODwvsdiql2pX/8=
X-Google-Smtp-Source: AGHT+IGEE8Fm6k+e43goXL9XR3kNG0Qk7QvIMeGK5viYe25EF4qO0xqHuY9x+AzGWdKmvE+R7dTOXQ==
X-Received: by 2002:a05:6a21:1087:b0:1e1:b727:181a with SMTP id adf61e73a8af0-1e88cfd3cb1mr47297876637.24.1736920150754;
        Tue, 14 Jan 2025 21:49:10 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d406a94b8sm8295174b3a.167.2025.01.14.21.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:49:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:48:02 +0900
Subject: [PATCH v5 5/6] s390/crash: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-5-0f9e55bbb2fc@daynix.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
In-Reply-To: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Heiko Carstens <hca@linux.ibm.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_214911_417436_00E00ED7 
X-CRM114-Status: GOOD (  12.32  )
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
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..022f4f198edf 100644
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
+#define nt_init(buf, type, desc) \
+	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type)
 
 /*
  * Calculate the size of ELF note
@@ -300,10 +289,7 @@ static size_t nt_size_name(int d_len, const char *name)
 	return size;
 }
 
-static inline size_t nt_size(Elf64_Word type, int d_len)
-{
-	return nt_size_name(d_len, nt_name(type));
-}
+#define nt_size(type, desc) nt_size_name(sizeof(desc), NN_ ## type)
 
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
+	ptr = nt_init(ptr, PRSTATUS, nt_prstatus);
+	ptr = nt_init(ptr, PRFPREG, nt_fpregset);
+	ptr = nt_init(ptr, S390_TIMER, sa->timer);
+	ptr = nt_init(ptr, S390_TODCMP, sa->todcmp);
+	ptr = nt_init(ptr, S390_TODPREG, sa->todpreg);
+	ptr = nt_init(ptr, S390_CTRS, sa->ctrs);
+	ptr = nt_init(ptr, S390_PREFIX, sa->prefix);
 	if (cpu_has_vx()) {
-		ptr = nt_init(ptr, NT_S390_VXRS_HIGH,
-			      &sa->vxrs_high, sizeof(sa->vxrs_high));
-		ptr = nt_init(ptr, NT_S390_VXRS_LOW,
-			      &sa->vxrs_low, sizeof(sa->vxrs_low));
+		ptr = nt_init(ptr, S390_VXRS_HIGH, sa->vxrs_high);
+		ptr = nt_init(ptr, S390_VXRS_LOW, sa->vxrs_low);
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
+	size =	nt_size(PRSTATUS, struct elf_prstatus);
+	size += nt_size(PRFPREG, elf_fpregset_t);
+	size += nt_size(S390_TIMER, sa->timer);
+	size += nt_size(S390_TODCMP, sa->todcmp);
+	size += nt_size(S390_TODPREG, sa->todpreg);
+	size += nt_size(S390_CTRS, sa->ctrs);
+	size += nt_size(S390_PREFIX, sa->prefix);
 	if (cpu_has_vx()) {
-		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
-		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
+		size += nt_size(S390_VXRS_HIGH, sa->vxrs_high);
+		size += nt_size(S390_VXRS_LOW, sa->vxrs_low);
 	}
 
 	return size;
@@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
 	memset(&prpsinfo, 0, sizeof(prpsinfo));
 	prpsinfo.pr_sname = 'R';
 	strcpy(prpsinfo.pr_fname, "vmlinux");
-	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
+	return nt_init(ptr, PRPSINFO, prpsinfo);
 }
 
 /*
@@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
 	/* PT_NOTES */
 	size += sizeof(Elf64_Phdr);
 	/* nt_prpsinfo */
-	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
+	size += nt_size(PRPSINFO, struct elf_prpsinfo);
 	/* regsets */
 	size += get_cpu_cnt() * get_cpu_elf_notes_size();
 	/* nt_vmcoreinfo */

-- 
2.47.1


