Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBEFC02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 05:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7R1Z0m4AmDiEDGrwLKGXNpW3g69MQHysWRaDTZFxP4=; b=t14sHDq5M1RUiXV+nainZaT7xo
	VC1sxkNhKJ/cR6UMrdJXjNejFv8FNNfKLKiHZcHUIzXo2lKNkOuL0RiLScRuSK+lw4tWj4nsCAy8P
	jrpwJOZsfbODMifKfEApwG5m/gAbRJdwJ5e4sNNGviK3ANd9BejocNkDIIubYj0cbVbYEirZ/AOO9
	ANscNUt35/Cc5rvIZDDKTOzhcdFLXmp/6Tox4eO/WEfF9gLInLrOWl4kDvaWEpULQRXpU5f6sCxFW
	4RofDTQ8LQxOnLMqM2oAE1UwM2zo9b8ct0Y2RqtiignicfBgLxsZu8iCzCiGB4tbAWH8sirpIlfZj
	0ipDScgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwH5-0000000AjCM-1uha;
	Wed, 15 Jan 2025 05:49:07 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwH3-0000000AjAd-0Q18
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 05:49:06 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso7916961a91.2
        for <kexec@lists.infradead.org>; Tue, 14 Jan 2025 21:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920144; x=1737524944; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7R1Z0m4AmDiEDGrwLKGXNpW3g69MQHysWRaDTZFxP4=;
        b=rlQkoKp91eqGxPjNeE71Dg+F7Fp8qWaZtTs8wLx5/LrdrAN2ZYLb6L4YPKGDQizpP+
         m3HDGJxKat7r7G+n4fmykS5A5ob3arDGMvkZzhrbiahR+5m5qVqmTtVvbgxTSOVd8mgm
         AUfUnyFCKlSrqJ3TpaidbmaI8NFPKvfdizsR46SwOGB3PZkwFejEFepifVjVFyQEIxNB
         Ew0gj2q9/JGnZjkjzr8T1Ek6GzSyhtiJSYsaG8QVxR6DypLS0dDFajmyGP/ulL/YZWbi
         mut4WzgHLWTpzNliMCNwcC+RYkCdPmSqEMYh7xk897/qiQpLxddSMo3cuMC8kBfbbI3s
         Aong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920144; x=1737524944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7R1Z0m4AmDiEDGrwLKGXNpW3g69MQHysWRaDTZFxP4=;
        b=SE4O5Q5wS7GsjHjPNjMyIgRQgUAmfia6rf8GIioWey07I3QaiqkD7xFJD+C7xDEmt0
         X2RMvt8N+vKJ6g00A6VjwYkV47t3g6Ax49nFZE+LhYS9l77g6kouCzMXUOiscLU7ryvA
         IJUxv17qVmOBd187emqLl9McMxJZdnOEEpD34+m1snxc/3Hy1j2pXLuwtb5cnet88mNT
         EXERVfEJabwTdr0EEblcSNF1Tsw/YAdafGzzgs2CYPnxS2ObJx5hxvmC/GKAON55FqWN
         fqeaT70j2ra5c28m84fmcLvoIX+I0s3pyWaEvaFqZOtyBCarBiHc3d90jIcCBEsJPb32
         6usw==
X-Forwarded-Encrypted: i=1; AJvYcCViZ37HkfBDYWDaeHklO2FPQIdLUya7jo0hQJ1bwRYoI5WnS14vW4YAVatOI09BFiHMG5PidA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxbK+XSgtvI0fqaU2TjwDDyMqZD8mOpEf+gVhG4kdf0CUd+266/
	RZI0j161gK+/jKiy1R7bDhlblwl0s1aPrVwV7ilQkgI6HRX9p97SBlXtbYZeb5A=
X-Gm-Gg: ASbGncutzWh8To45THBT2K+vkLSiOA2Ft0yBqzI/QRCv8lki39ZOHO7pl7TVIwsuNyc
	ge9iVTWHAU+RgT8lezJEhMmSutZy/isqBVSZTtLnXMoi6iw9Q6m1S/XVB8DIZswprm+oIPOtrPP
	i5N/emwqCEeUtwGh6avuM8ZEcgpQ7s7PeNlTFkYrruPhnFFIO+hzMUF5SwnMX5b6IXpd2dOVdRc
	cDfGRBOlPnuYb3+I38ONgRaxAukN5hvnCZt43eA0uNX2rGHO5QqtWr/Y9s=
X-Google-Smtp-Source: AGHT+IF72SLq1My1g7dtb+6XlMl4Y+R7t/efbYmDZTCYwSHPEhtpwytSLWotlhp9pmcuYRJ5nSVCuw==
X-Received: by 2002:a17:90a:dfcc:b0:2ee:ad18:b30d with SMTP id 98e67ed59e1d1-2f548e98f31mr36439035a91.6.1736920144269;
        Tue, 14 Jan 2025 21:49:04 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f7085261dcsm1516002a91.0.2025.01.14.21.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:49:03 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:48:01 +0900
Subject: [PATCH v5 4/6] crash: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-4-0f9e55bbb2fc@daynix.com>
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
X-CRM114-CacheID: sfid-20250114_214905_140223_D19D560F 
X-CRM114-Status: GOOD (  12.34  )
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


