Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399E2E77197
	for <kexec@archiver.kernel.org>; Sat,  4 Jan 2025 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYIrxPsAVLm9525H8KmJlUUcKlEHI39WEeyICf7u0AY=; b=Zy1mDPzLam2zTxgWdTYHxHGK2d
	mwP/ZibGYoJXyXD1HfqRCp59Xz++0c/yJR1p12sbhdOMV2WfL82NKLnchrFUQZMGzuBa5XVr9PpDB
	aWBgigpCVRmChBBDGI+le0TgJeY8lug9fNr7lFLHTDl7qSMHQ1+BZUvwBDD6rW34UJp8cQwzIEufJ
	QC59wktpwIHh1FT5l7WBozIEVYhIS4gb457ToA5xp0CNouA2hlIBWcBVXtuRcn66AkhWvLWslK443
	YTDIj/6p/ZVfWLqa8QhuFRhqO1ZT6bbpGdGZwPcp1UssXoaooUodDOkGN58eQhtMJ4gikepXZ+8nz
	8CHw6sig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5J0-0000000F7nU-461d;
	Sat, 04 Jan 2025 14:39:10 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5Iz-0000000F7ml-1jzl
	for kexec@lists.infradead.org;
	Sat, 04 Jan 2025 14:39:10 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-21675fd60feso242682885ad.2
        for <kexec@lists.infradead.org>; Sat, 04 Jan 2025 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001549; x=1736606349; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYIrxPsAVLm9525H8KmJlUUcKlEHI39WEeyICf7u0AY=;
        b=P4Rljoodf9BWxza5fW0qI3ifxCM2XfJAB66WfwaD4s9gNIey3QsDXQSloEMZr0BWpv
         /2lK2SC/Y/GXlIkvnGqcie0vTIKoOOIVawtH9hcDjM6jbTOhdGOXbWyzxWj7R0BVjnKe
         HsPBCs94Jmy7fie7/+bnyOYAafWMKhQnZwobS72T39g+xBwh3iLre6+Tbkgp1AIqrzSQ
         O79pXNArM3Lf1KydIVvCFZFLiXCFDxg4DQ3hhwK3EOLj0L8n68Rqsjm/hh7VAGcmeatz
         72X4mJJA7CWNJEzu1zeWgAxUXZX2WJdWc6BhrUtk5/m+Id8dE57c26gN72UaPnM4cYxl
         kxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001549; x=1736606349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYIrxPsAVLm9525H8KmJlUUcKlEHI39WEeyICf7u0AY=;
        b=MkVRKit/dPiLNkVqsYtivhSgyKXm2mVkF1Qm4zOCpkz0mu4Ad5NpLBrh5cSYO4QSMu
         ifGoiwPNQ0qBdVbZoIjnoR/ss0u8+96YQBucgdAz01Rw1UFIe/f14j7vER7SsKD1R3Z9
         ofY4hory9HHMUgOZ3R/e8NdKsZs1N3sGMaCepHhJWz3qPgZeLhKddQ5ky727+OUXzBlc
         CFzgyuuPOR07ofYzEV598DTJcg6l84RUM8LqiGaoh3c1PoJ23I5ugzJPsG9rKsUhWNS4
         5XsdcTY05qksKUx+vefC2y8kJG8MYvgy2DJfqDIVVBGsbhU8bBh1ODuJq2KBaiSBajh0
         cxSg==
X-Forwarded-Encrypted: i=1; AJvYcCVCXfELR8JilRiOYumCwb9E2+KdRl2uxNKQLh7rxt0+Ess14RlGFg+3Iw+oUfPBfPPJZrnmxg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5C30nz1jQfJWnZ6TQvdAY46c4mugEGdoT0zYA23BiYyZCq+3i
	aD+wDQTh8oElJ5j7nnmydfw/28Ss63PJ7ozVxQ8IqWSO0nMdtwB4tXNz8K8eXNWhPNJUsKsW44w
	H6hE=
X-Gm-Gg: ASbGnctHQq6osIM3AMihmHXg5QByUTEdsWk5iBsfYqHlQr7MFumgldTQY/2oEfy+0Up
	j6lhf0OWaL3BE0T2NKtbVBWOivx1TKEKSES5CZNs32A/L8jvsycqIA8k9jgFvaJNFjJX2gnurpr
	feGt6wcCu8XaIDSAdSzLzgwVPJwz3TlxVAGL3SpYgLT57vrCi+2YVCyj3XOCLpTxRFWkBaVXar4
	GJCybUsJ8DHR1OqhQCiIuCDbkWbjVHkEYTq6BpOAdhFzp6cAYB29j+BwXJpJ/Q=
X-Google-Smtp-Source: AGHT+IEy84cJ3h5ytJvCxSHHyFyZN9d/gzxb3RlphGjioGS1LvEPzNOYZA2OsynrQSHDV4AjG+98tg==
X-Received: by 2002:a17:902:db0f:b0:215:4362:bc76 with SMTP id d9443c01a7336-219e6f29827mr814402335ad.54.1736001548953;
        Sat, 04 Jan 2025 06:39:08 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc963103sm262510765ad.52.2025.01.04.06.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:39:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 23:38:37 +0900
Subject: [PATCH v2 4/5] crash: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-elf-v2-4-77dc2e06db4e@daynix.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
In-Reply-To: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_063909_459541_CB0EA90A 
X-CRM114-Status: GOOD (  12.26  )
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
 fs/proc/kcore.c             | 12 ++++++------
 include/linux/vmcore_info.h |  2 +-
 kernel/crash_core.c         |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e376f48c4b8b..e5612313b8b4 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -34,8 +34,6 @@
 #include <asm/sections.h>
 #include "internal.h"
 
-#define CORE_STR "CORE"
-
 #ifndef ELF_CORE_EFLAGS
 #define ELF_CORE_EFLAGS	0
 #endif
@@ -119,7 +117,9 @@ static size_t get_kcore_size(int *nphdr, size_t *phdrs_len, size_t *notes_len,
 
 	*phdrs_len = *nphdr * sizeof(struct elf_phdr);
 	*notes_len = (4 * sizeof(struct elf_note) +
-		      3 * ALIGN(sizeof(CORE_STR), 4) +
+		      ALIGN(sizeof(NN_PRSTATUS), 4) +
+		      ALIGN(sizeof(NN_PRPSINFO), 4) +
+		      ALIGN(sizeof(NN_TASKSTRUCT), 4) +
 		      VMCOREINFO_NOTE_NAME_BYTES +
 		      ALIGN(sizeof(struct elf_prstatus), 4) +
 		      ALIGN(sizeof(struct elf_prpsinfo), 4) +
@@ -444,11 +444,11 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto out;
 		}
 
-		append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
+		append_kcore_note(notes, &i, NN_PRSTATUS, NT_PRSTATUS, &prstatus,
 				  sizeof(prstatus));
-		append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
+		append_kcore_note(notes, &i, NN_PRPSINFO, NT_PRPSINFO, &prpsinfo,
 				  sizeof(prpsinfo));
-		append_kcore_note(notes, &i, CORE_STR, NT_TASKSTRUCT, current,
+		append_kcore_note(notes, &i, NN_TASKSTRUCT, NT_TASKSTRUCT, current,
 				  arch_task_struct_size);
 		/*
 		 * vmcoreinfo_size is mostly constant after init time, but it
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index e1dec1a6a749..1672801fd98c 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -8,7 +8,7 @@
 
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
-#define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
+#define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
 
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 078fe5bc5a74..335b8425dd4b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -436,7 +436,7 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 	memset(&prstatus, 0, sizeof(prstatus));
 	prstatus.common.pr_pid = current->pid;
 	elf_core_copy_regs(&prstatus.pr_reg, regs);
-	buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
+	buf = append_elf_note(buf, NN_PRSTATUS, NT_PRSTATUS,
 			      &prstatus, sizeof(prstatus));
 	final_note(buf);
 }

-- 
2.47.1


