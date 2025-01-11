Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA36E7719D
	for <kexec@archiver.kernel.org>; Sat, 11 Jan 2025 05:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2jKrk3bVYPr7k5YkzhCVfFSlyEMyT0et7JHsh9IpwE8=; b=kl3dg8cA8cTZ0Nu9vZKjuUhu0S
	sW8f6xfcM4r/WW89pG9dlkz6SpfXJwtaJj3F31aLW+Pz14yqJmz6fSvics/0dy+Zgk0AvX1tSQzsc
	sErmT8ECh7WPqBt4GqmUhFU6zfnmNY37aY6JFpST7SQoV6xWtdTedbTFc++7gcOMjueet7nbxTWnC
	JeHbitdj33Ykz1sSKbJn6ubNhyVO74LnWc+XA+IlhHNlZqlxt0c35idpxDkVV1wVBSz5P/k+i9UTL
	ScFVD1kQ0MHeE4yf7pcKV7GnZsddcbVBzMsyYIvzh6D7YHZt7LpIuidOC6kLGBl1RyLabqx+WaX0O
	wXakXajw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUNK-00000000Ev7-3WEd;
	Sat, 11 Jan 2025 05:49:34 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUNG-00000000Et5-2U58
	for kexec@lists.infradead.org;
	Sat, 11 Jan 2025 05:49:31 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2161eb94cceso33702985ad.2
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 21:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574570; x=1737179370; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jKrk3bVYPr7k5YkzhCVfFSlyEMyT0et7JHsh9IpwE8=;
        b=mG5ooxVu3o2gZNziMfra82N4J1TNgYrEgYBapF8z0U0RJdQAyJz2LkNmXtVHWRPfG9
         2yocii9Ui9SOzc0HeJ2EMwmcpDbhDLKWFy1amPi3rrEMT3JGfQLBA+K8SzjX1bgCjeYo
         eVPyeEUnBill/VYJB1ySJLe1Fwn6p2Ib4WZ/ybxUp/oCQUYdutHXdh/Oclsyw2Gu0Cj8
         8PyKlbvHLXvkFzHTpUcFwPeNsPgMk53SlH2q3m2TR+8kXSOoRqrfnlHkUbZQgnpfkogQ
         dEZyiHt7Ct9PHUUv67lK32zSnSDhU5nrOlmcz1LNYP6rpDR5BwnTuhdqdvCYtpbpVmQL
         vXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574570; x=1737179370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jKrk3bVYPr7k5YkzhCVfFSlyEMyT0et7JHsh9IpwE8=;
        b=bDxNY0sQm/0pWlAUedfD2U39jznE50sOVzFPLl8pZoL6zLlECgLcVhQ2syGik0R3Bd
         mgpIQLp1zJSsX3tJNzT1zfkb8CDG1KAt6oSxEOkZzfBNUYCMrWLkqm9hO8iEuCcCniIn
         G0rLyDw/ETtD7mJbzvbKY+WKdn+YBHuKr7SxdGvH2seZrqRruYpatZhQVI40ZFsQJWQu
         AyNaCRzPLMY/SrGK8Z/R0owDtmTB797/4mkG9Bv629Jv34Lpkvhtxkre8qyGL8ligwmV
         B9L5JvRxmjrZrtGICYyczc/bEFG/Kh4iydhCGC527D4bjS4XeybhC251S+bvnfPD6pWr
         oTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbexjBONorQP/jKKoVQ8ZSEeDKEQWjfD5mxPyTqcHzvNXjne4nMxKexyF899qdkfuJKjdoCA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwcyZZNWucIdEQ/3CneEpf7jUKRUQigjt7s+pdUWO2qbKlkXBZa
	lodxyfFYopX+zZ4TPxfkDfCtngxpSytooDKD6n0Cdz/LLtFq3N+lSiVtm44Q1Jc=
X-Gm-Gg: ASbGncshAgH+Y0QhzO9MstBP7zZ5z+d3EXiFDAdzLUbAG5/jLJAx869qycTpQmu0mMq
	zgjmRKp09zjJ0+GEgcXF06RGox1++RO09JyYBjoVF6QHHe128kAs/iueFSGzwr+jz+hQDUUq7sO
	RwwPpkjrWWjhcMoVSu5nc2PJcHEq7K/oVOeBMcruTG8Cv21xOY7yvcOflWsLrBAmVMzn6ATGPtG
	8RpQ9kb7TfmQ7RYU4RPAuFbPBVtSQmDCIq2CZldjAiaWRgljGyuQGTuzMM=
X-Google-Smtp-Source: AGHT+IF/DO7Xc25oCNYWji4iMt60P0/C5k2sp2lZQdBF9bk3Ar0+kFGVzpELgHH1uV8P5GY4v7KRrA==
X-Received: by 2002:a17:902:e84f:b0:216:410d:4c53 with SMTP id d9443c01a7336-21a83fc6db1mr183636355ad.41.1736574570100;
        Fri, 10 Jan 2025 21:49:30 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f217d56sm21372405ad.141.2025.01.10.21.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:48 +0900
Subject: [PATCH v4 5/6] s390/crash: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-5-b3841fa0dcd9@daynix.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
In-Reply-To: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
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
X-CRM114-CacheID: sfid-20250110_214930_637219_1297151B 
X-CRM114-Status: GOOD (  12.11  )
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


