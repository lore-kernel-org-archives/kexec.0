Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B040FE7719A
	for <kexec@archiver.kernel.org>; Sat, 11 Jan 2025 05:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=; b=D3yD7pFsXIKm2ex8ljFVp+dzmZ
	E80ohBYuKvRsJW0WjwauBckXrbCGgqcBHQJ1ILRFs11XW3yWmJs4E9JIWPWNFG0lAoZDp9ISNW3A1
	lOMZwabLUF/YP6Kb2A2BjYdcHEDqcSEkm1kuShzCHYNWPobRYlH5xeIxyagiPjtZz3qwyYNS9cUYC
	fIvEyLfL/Rub8Dnd5W1QwLR6+wYy8n6WX6GMryp8WU2L0uoI+kBWksXlG/WTK+0ntJQdhnXaEVHGh
	AuJgEw9YhlrrqLsloc5tl2feIxotxfp6RCiUj3+hOsl9gXLRp86oJ39PyZ0HZxYK6oVRujdX3BeYr
	LhI9EdCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUNC-00000000EqU-1jq9;
	Sat, 11 Jan 2025 05:49:26 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUNA-00000000Eon-1JwI
	for kexec@lists.infradead.org;
	Sat, 11 Jan 2025 05:49:25 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2164b1f05caso47690105ad.3
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 21:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574563; x=1737179363; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=;
        b=iPFx0j6T6gdB30bwCXGHWszBOuDakWcxFozI7Qbek0xa8rwQArswZvdlS6qe/oxhNc
         v5T0gUoktRsgCU9cY16tmpH1kxOZi5IGtiqWKkJ3rBxAriBtnTmFvkBI62Mt0oNAmGdO
         n/f8vj4dUp+13+t4lM6lDtf725HyUZ0W0+u3Rngt6t09Rs8FBmjLyaE2817qBCBkj22o
         +tCmF1eMew31kmXU80BlOHQ1H1HPdKMLQMtpzPxxGN7tLk6d1Eg47duJ7dNcZies5xc9
         yWH2VcroEu46C0qKV4suiMjPx1eAY8gpwyLUsiijP6zj7+S8I9ZPuuDub8vsOZilvkTu
         iKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574563; x=1737179363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=;
        b=bmfgY4gJ65BXXo/KTAyTQHloTadhjJogJ7/IXoAKlI1NMa0BH/m/jX+pcYSjs6U0ZY
         miC3wb4sVjWK50PWnfJ3D57274rgNs49GmE5S4L/K5HJeasepVhfIY4ocRLn0sOCJHZP
         43qttCuuQmd4c+fNi+XgQ+T7PoPUgCIrE3LR2/RXI9seJ5H4D6XfJtv6Baygq4wot8cj
         VZrsnz8s0NAXQy3ql0xwmQDOi/BbAFTAEprmeneVSchmInl7tkJ7NMZbevsCWeoiJ3xK
         GEp278KFBJ9RUC46/gt8fdpjCUqteLKGldU3D551BewbF7rMUE07+QgwSr43ujhozypy
         eUtw==
X-Forwarded-Encrypted: i=1; AJvYcCU9TH+HKPvT2125SYdkgDxPcWXk+CoFjFRM/Hywtlns8BDUGbwusak3t9FgopuU74D3dEyEmg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxxYM0DRxg3ELRCOnL5hLoGcw5NyYYbX3MUG5Aey9P2G40hZK1b
	sFyLbdDym4fPnt+kl7MFF30UUW1pL5FYNHuY5f7FvAXmB/6EGzBRBr+pV93e144=
X-Gm-Gg: ASbGncuhL03Xb/e3mNrOUd45uwzPA6nVbHgt0zdBcLcf2wRAYoH2AxiqJ0PbuqWok/F
	/NhGlCoEU+dW9qQGS5ZwyMw5MeorBu4BAXj5uesS21bnO4t+DXgty63cdj3rUWp8VjVRGhggkQm
	scLQznNNyY+s5kd2Vug/MtdDhoCk0QeoPV5ufflua2l/lBSv5zU4A4XRGnTPD9VqaVQK2FSD5+B
	gxgj4pa5LgI5oJuaFc5CN+atMrNonJ1e94iNSwguieXntcR7rs4m0Xe+uc=
X-Google-Smtp-Source: AGHT+IEOaK6BOPAe/MUGiXyl+EyGiYmhbaq4qeXiFxMDU90Px7X9OtnxNRV5Ifu8FHX6K2PPpo86xQ==
X-Received: by 2002:a17:902:d4cf:b0:216:3466:7414 with SMTP id d9443c01a7336-21a83fcaafdmr208931985ad.44.1736574563492;
        Fri, 10 Jan 2025 21:49:23 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f22d0fcsm21166295ad.161.2025.01.10.21.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:47 +0900
Subject: [PATCH v4 4/6] crash: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-4-b3841fa0dcd9@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_214924_358872_3B8A4C3A 
X-CRM114-Status: GOOD (  12.13  )
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


