Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3EDE7719C
	for <kexec@archiver.kernel.org>; Tue,  7 Jan 2025 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=; b=zDUtbm0J0kM2d7JYKiIqyFcXYz
	V+FJCklHsvRcWwux/wWlINu1hApKnnUrzgmbMiZuCU99KmR9XQs3O53fv5dpTwGlCHQwCTC2l9ugC
	QfLe/FEo9XovtSJqV01KO5/JWv0UDrezO/X6qtco96SPglU9WtlxAw4BDc4AoneZODx4nKBfBraTG
	hGf9sU8QXuZT1vkWXP7b46eFbT+mfYL1R+QpZSc0k9aYdbnQgNcTlY4Kuo8C/86wPX/FS3JVW+HPh
	kAjMbR66J7DHgMWNg0fDEHxWKqQKvj78wPLK9PoY7BqG1yP4Wezrxr4Iy8vxuuxUkhbHpPapcpoYv
	zTDDOftA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV910-00000004pjE-1so0;
	Tue, 07 Jan 2025 12:48:58 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV90N-00000004pSC-1dDE
	for kexec@lists.infradead.org;
	Tue, 07 Jan 2025 12:48:20 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so18415835a91.2
        for <kexec@lists.infradead.org>; Tue, 07 Jan 2025 04:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254099; x=1736858899; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=;
        b=V7vjEIhhF5axiyYlRdeqyMBr2rZukgCSo1In8iYqo0nwL2QseE3VvaZLcnKz9GplDQ
         Xb0QjQLSb1PwEW3UXlQnLwQ09f+KZnkcMgqRntTTlqzxv+qKTOeLGpZnXi/8EDqMUnqD
         WSNWQJdrBeNvUNk4v7YqI6Fj2UILZcgyJcx4BaLBUVwoYgBWmy5p9L9Dicdrs0QUYKXR
         1Fw9cMGWF/wJ6//tMJPd166x7myvPTZH4veo1R2eKOCiwtkCqQRPHiq/HPc7hhSdZJ3b
         jqAM9W2SCI4fQJr5LaXyId+bmQAUxkw2WscGQ3bsamLMgOORgpxz2pYbA36pIt/dkhAs
         7Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254099; x=1736858899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=;
        b=I3jsxuRQdQhVH/v6SwwMJ8DBop0PRPkFKi6suMk83hF5IeS4ykDAewGqpSIAUhiRkL
         CZme8jxBaq6yggPCkA/NnmCnjbmpldCoZGH5dsUGLsrVhfZ0jzKEB0J3HH8T8HrCI2Si
         qaNuBsnuoPpjY4mgRxdKQ9y6j9toQ0UBmiUYFmjos8BMNH+a5eBM7gPxNxO8wGzpHzN1
         SerH0rk9zs+bDD+CRjV5jAeSwuOKtRRj6uAkGyMOP+OUxhbnphaFHk4AIQuv30AnX2ft
         8UkK0NrS+EJiQ4llPOIBfS+JxQsMWW82bZHbDsvFp2U+6A7ejTxqxm3MTe5p+ZbdYeIw
         z5tA==
X-Forwarded-Encrypted: i=1; AJvYcCXWnasZ/njKgvvD0Plnh7NKMCIL04CeNc3j0LLuKT7pIG/yK6rDI07azBsRAzNyWHhp+j7siA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yydoqrgu44QDnoFfgvIDphPqhlQCm5ZA+CVvHVP9xj316L/VQCG
	7t9HAF9Ic7bxlelsB+BYgL1X6WWK1C97sTMX1Ya4QCCJhM10qnZKfuiXQuLQpZ0=
X-Gm-Gg: ASbGncvWxt35Ta09XFsbtI3rg3mbC4Ffo4Pt6Faa8osxDCGSFoxkRECu4zy3L4dyfC2
	Z1Q+LR5xRXENLYJgifVIdIJD18HF2uRlA5yTnJxe/1EdqFePZynigAG+7b91TwHJgr9eC578r6A
	M7ltb6rxST0i1RnwBnqismJvdzlXYMD5R86ySI3Dp4BU+U1zzCKMDDdbAy54is8APdPZjLP1MCm
	8LomOC6AwGVaZhb1FiKsVQwwXoJNI4AifIvPo63UiBGVPPdUF1ol1Nv6Fk=
X-Google-Smtp-Source: AGHT+IF4unLvSG3ozl/K+xZg50qJ9RhkOXYw+z5VR9QTjd55CxK7F8LQeDMLqnNt5CS4t8mxmL2QoA==
X-Received: by 2002:a17:90b:534b:b0:2ee:a127:ba96 with SMTP id 98e67ed59e1d1-2f452ec6d35mr81063623a91.23.1736254098937;
        Tue, 07 Jan 2025 04:48:18 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f2ee06dd46sm41574100a91.36.2025.01.07.04.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:18 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:55 +0900
Subject: [PATCH v3 4/6] crash: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-4-99cb505b1ab2@daynix.com>
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
X-CRM114-CacheID: sfid-20250107_044819_435323_D95FD75D 
X-CRM114-Status: GOOD (  12.61  )
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


