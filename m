Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE23BC02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 05:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sHzEFJeIZDo3f5k/3U0rvOC8rXQluzySCipEOCSBJIE=; b=00zksJWfmer5BIKkFdnrpyGIKw
	Fh2tWgibFKvdAF8VsqzPauHxjz+aL6r8Ko+S9tRM7tcDjip/dkSiDqQyt4diwMH1GXmxxbOscANPA
	tr9Yal+cRDVPfnFgOQpAQsdwN4f4f9k7JaLgzMlfRCWvI/JTN6Oj477D4toR4NquNDDeAZmkm8tjO
	6Bebbn5tvhdQH1NOXaeXxSlv4G6GVdO09EvLw/DiTidlV03n5qFXjm8G5TYHWXg/4hVEuwOuwOMgI
	3rN1eEwE6JLDH+PR1TP4VIg0o9KFj8LswiLHEVJpScwdoYoq4b3r3s2iQDvVj+jNnNUu+B2JRBW+i
	3TUQJZSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwGs-0000000Aj4d-2lKT;
	Wed, 15 Jan 2025 05:48:54 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwGp-0000000Aj2f-3iBT
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 05:48:53 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2163bd70069so115030415ad.0
        for <kexec@lists.infradead.org>; Tue, 14 Jan 2025 21:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920131; x=1737524931; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHzEFJeIZDo3f5k/3U0rvOC8rXQluzySCipEOCSBJIE=;
        b=bw9sk8L1pA2YfE58heBre5D/KruzUJwhX/YZN61J+4Uhl4XmZrKDpzJtk9RbK3rPQB
         YcTWklSU3WtNXI7zMZs1LS+/DaVH+g8xI2nyOeyqxWFEYMfkR/zhF23yRsOswHiLTYE3
         epOaKFTdqVp7ItCFLsSKojub3F1xwDua6USitX7VYMk+agvI//O6gke+eq0x4eWaZJKY
         sFzxKFxg2ZeeXHe2sXQIr98p9SEBzYZziND3imMpRvs2TJXSVznqfIl/h9D9DNBZfpeT
         HPcbbCoIGAJ/ox4cvpFBCwNHB1Lr58x420mOb9ANqQJshaSftCGF3ACltLtT7X/tpRf5
         PluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920131; x=1737524931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHzEFJeIZDo3f5k/3U0rvOC8rXQluzySCipEOCSBJIE=;
        b=qIZx5puaNwyKQ+JJJnXaV5vaZ2K2WIgKFHDuQCsJ9MRUrKecA1fSqxt4cLOl+sK2aO
         +77tIEf6F+DsYsiRkJ98xVVX36BOm3AA68jc2PNQvh7iFqhOJrJ78uFmziDhqNA9+H50
         s2v3ocYmeKp9jz5Sfe1a3dFs90+DLGKDA4oNp7cIc9SY0YU5hMsyvIUvEvn/TVh8l1yk
         G1eM6cY+jcjpeYUiT8yUR+HeZG6oqcZXjEjKq+CMlRpnRIhdNmTmpR9y+XYP+WrbVtem
         UzisrniPv8djz9Mlwx58/wu3nAz8XCHQP1yMwHJyBRXN5A+cRR5Jcwmrkf+aZ37bPGGz
         mp8A==
X-Forwarded-Encrypted: i=1; AJvYcCUo805KngIt14D7AMg3YY24+dvnaf6d/mQaN5yExw6Arb62dlbPS1rySQREKP7lzABiy6mkBg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyp5wejdIm91ElXVYPcrv5azF5WKv9soEEJSU0aBzFu86nqPUun
	mWVVMc6tWU+2xjzPDyOVOQcR+mx27rqOSMsSw93LUbUcQ7cR4G8tjX0eRcCo1Ro=
X-Gm-Gg: ASbGncuYRAzaEAHAc52odoB0jcDYtiGLBy0nYjLSL8PiLcYq4u8JBaOYYYiJABYvsRz
	zrQo8Aq984mnJQSLjNZqRsTSwLITdUlg/LUp3VP/Zl+SptsM35KDHa45ieOaigvYpTLYFVmVEDH
	W1GL5YpLCbwdD3TpBosfNIkyVZLzJZ5iJRJQh4c3QO2uFhYPVhEfheF0po1fQ/b3Gkt039Rzbkl
	y0blKm5SbqvUY7HGZ6yAlOWJnDif5CucUZhyb/I9KzFJS3Ktn99Wg+SWQQ=
X-Google-Smtp-Source: AGHT+IE4WOueDadHkE/pTRlVlFsVpAiJG9FV/RBFhyadWkGkb4TxZaWQPSECPYbRg96If6idldoCOw==
X-Received: by 2002:a05:6a00:9a3:b0:725:eacf:cfdb with SMTP id d2e1a72fcca58-72d22033ef6mr42478714b3a.24.1736920131167;
        Tue, 14 Jan 2025 21:48:51 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d8bda6e9asm691573b3a.51.2025.01.14.21.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:48:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:47:59 +0900
Subject: [PATCH v5 2/6] binfmt_elf: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-2-0f9e55bbb2fc@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_214851_931680_65C08E5D 
X-CRM114-Status: GOOD (  12.24  )
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
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 fs/binfmt_elf.c       | 21 ++++++++++-----------
 fs/binfmt_elf_fdpic.c |  8 ++++----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 106f0e8af177..5b4a92e5e508 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -762,8 +762,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 }
 
 #define NOTE_DATA_SZ SZ_1K
-#define GNU_PROPERTY_TYPE_0_NAME "GNU"
-#define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
+#define NOTE_NAME_SZ (sizeof(NN_GNU_PROPERTY_TYPE_0))
 
 static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 				struct arch_elf_state *arch)
@@ -800,7 +799,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 	if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
 	    note.nhdr.n_namesz != NOTE_NAME_SZ ||
 	    strncmp(note.data + sizeof(note.nhdr),
-		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr)))
+		    NN_GNU_PROPERTY_TYPE_0, n - sizeof(note.nhdr)))
 		return -ENOEXEC;
 
 	off = round_up(sizeof(note.nhdr) + NOTE_NAME_SZ,
@@ -1603,14 +1602,14 @@ static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
 	do
 		i += 2;
 	while (auxv[i - 2] != AT_NULL);
-	fill_note(note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
+	fill_note(note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
 }
 
 static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
 		const kernel_siginfo_t *siginfo)
 {
 	copy_siginfo_to_external(csigdata, siginfo);
-	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
+	fill_note(note, NN_SIGINFO, NT_SIGINFO, sizeof(*csigdata), csigdata);
 }
 
 /*
@@ -1706,7 +1705,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 	}
 
 	size = name_curpos - (char *)data;
-	fill_note(note, "CORE", NT_FILE, size, data);
+	fill_note(note, NN_FILE, NT_FILE, size, data);
 	return 0;
 }
 
@@ -1767,7 +1766,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	regset_get(t->task, &view->regsets[0],
 		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
 
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS,
+	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS,
 		  PRSTATUS_SIZE, &t->prstatus);
 	info->size += notesize(&t->notes[0]);
 
@@ -1801,7 +1800,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		if (is_fpreg)
 			SET_PR_FPVALID(&t->prstatus);
 
-		fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
+		fill_note(&t->notes[note_iter], is_fpreg ? NN_PRFPREG : "LINUX",
 			  note_type, ret, data);
 
 		info->size += notesize(&t->notes[note_iter]);
@@ -1821,7 +1820,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	fill_prstatus(&t->prstatus.common, p, signr);
 	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
 
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
+	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS, sizeof(t->prstatus),
 		  &(t->prstatus));
 	info->size += notesize(&t->notes[0]);
 
@@ -1832,7 +1831,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	}
 
 	t->prstatus.pr_fpvalid = 1;
-	fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
+	fill_note(&t->notes[1], NN_PRFPREG, NT_PRFPREG, sizeof(*fpu), fpu);
 	info->size += notesize(&t->notes[1]);
 
 	return 1;
@@ -1852,7 +1851,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
 	if (!psinfo)
 		return 0;
-	fill_note(&info->psinfo, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
+	fill_note(&info->psinfo, NN_PRPSINFO, NT_PRPSINFO, sizeof(*psinfo), psinfo);
 
 #ifdef CORE_DUMP_USE_REGSET
 	view = task_user_regset_view(dump_task);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index f1a7c4875c4a..96bd9d2f23d7 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1397,7 +1397,7 @@ static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_
 	regset_get(p, &view->regsets[0],
 		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
 
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
+	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS, sizeof(t->prstatus),
 		  &t->prstatus);
 	t->num_notes++;
 	*sz += notesize(&t->notes[0]);
@@ -1415,7 +1415,7 @@ static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_
 	}
 
 	if (t->prstatus.pr_fpvalid) {
-		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
+		fill_note(&t->notes[1], NN_PRFPREG, NT_PRFPREG, sizeof(t->fpu),
 			  &t->fpu);
 		t->num_notes++;
 		*sz += notesize(&t->notes[1]);
@@ -1530,7 +1530,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	 */
 
 	fill_psinfo(psinfo, current->group_leader, current->mm);
-	fill_note(&psinfo_note, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
+	fill_note(&psinfo_note, NN_PRPSINFO, NT_PRPSINFO, sizeof(*psinfo), psinfo);
 	thread_status_size += notesize(&psinfo_note);
 
 	auxv = (elf_addr_t *) current->mm->saved_auxv;
@@ -1538,7 +1538,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	do
 		i += 2;
 	while (auxv[i - 2] != AT_NULL);
-	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
+	fill_note(&auxv_note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
 	thread_status_size += notesize(&auxv_note);
 
 	offset = sizeof(*elf);				/* ELF header */

-- 
2.47.1


