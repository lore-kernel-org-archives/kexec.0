Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFBCE77197
	for <kexec@archiver.kernel.org>; Sat,  4 Jan 2025 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffgGfa1tRdbMu1hKTw9Yyv/ZhjBJNeWsWiWpVjLRBnw=; b=m8M+ezEpJxX168TuvmdHxMDSCR
	KHK+lDCl5sJ44hqS2iDvmj5GhzNqnwudTGPX3z+n7fuBQ96xEumY9pw2yqKv9gA15RmYaSmT382yJ
	QaZIsqCix//t8cecRrKbxDCnYlHICPT0uKt7gw4d2v6BsvJgcMM4NhKFZgXxb6206Korj5BIOs08G
	AmE5LcfTFQI7rhsf0IrqQT3G9hM64kAG6jY7gtPXOgLnAnYbL6MVghOOfOznRSBzn8wtPKP3nzc59
	rI10fuF0w00/M8tVtbgi0SpRCm25JUZ/VrKPe4R+FmTyWpCiPYYZjhwyVTn+k1n6tguF6d1PVD0fF
	NHxm1czg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5Iv-0000000F7j9-1NKP;
	Sat, 04 Jan 2025 14:39:05 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5It-0000000F7iD-16QK
	for kexec@lists.infradead.org;
	Sat, 04 Jan 2025 14:39:04 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-218c8aca5f1so232646045ad.0
        for <kexec@lists.infradead.org>; Sat, 04 Jan 2025 06:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001542; x=1736606342; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffgGfa1tRdbMu1hKTw9Yyv/ZhjBJNeWsWiWpVjLRBnw=;
        b=JPMfEKKKTmegKtC5Yp9PdkoJUqMtwr8q/bdQ4LiBjRiHNYVG4N9s539ipk4X3B7u6z
         EKfdsa0N6Xg5dYmi7pOjMqULU5m+bBt+eSSZ1V9wa0dgRp48g4xBTGlq31M914XrQfPd
         60/9B4lMrwSOVJc96BI5hHDDyXmamr6nRp4L4NcXUl4Xtxep9W6YBHuEz72J4eSN82ju
         wFF0H2com+ExgdjMPhc0iaKvnRx+Wqc9B3wvgtVY+2dDwwocW0Czeobkk+ssb2yU5pQq
         QxFw344heYGVKRF7Efvk1Rlcp98S3W5ucJnxOkxyY1UfnDivmkBvzzRbhrJP2fI/cE5v
         JzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001542; x=1736606342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffgGfa1tRdbMu1hKTw9Yyv/ZhjBJNeWsWiWpVjLRBnw=;
        b=Ny5Ichbxb3/Cef0mQu11vnEMUJ2aVHVSQbkMFdC5k3EtJj/eugnMc9oLWbQSTztS8n
         ns0MB5+BB5fOwf8DfDov8VUBZgI/dOBn9V0wv5EEZlici2t/qykZ0RgnSZ+xDB3OwjPF
         H2u3RCvXXGjJeqEsyEMiqArS9reho4ANXgo7YJ19IU9H126QuFrpEn5F+B3Iii2j+laa
         dHl2+HrS4oJQIKMVlm32VZqszqCUgh2ZasUWEN4C7YAwkjDW5ZmqKEGaDorcehc+Xyy6
         hNLyBPhDq++0Hc5B3V86vtTigoWC9lArfQqgQnvmmb5w2q4jiJ+tKoWQvcCIgQUR96uI
         JxRg==
X-Forwarded-Encrypted: i=1; AJvYcCVFutajtfaDCHjwXxivXoEJ/pw2gWnyMNlsuCw2dgVuehyidiZxZMokc/g789D1f9+4yrSIOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfevZuaHLeZ3zw3148Dc8XAM915NMKys62IlX0oBZBsa5L16OQ
	sH2vvUOKUcLyt3uGmqhZea0WE1CkyKWh/5sH3Dm8+aPVwrLFqXA5MTHq/f0Xd/s=
X-Gm-Gg: ASbGncuuvnRvtOM7Bx1nwUJajEo0hOZEhMoe2/FOsH5gfvVa/2SzPLKg9fYLgk8l4QH
	aoy1YqO/f6gpNHPhGe29Nt8mv9ReLSNeh6x8vAcTWAxK47KExtif3LKz3rDDm0Ix4dI8s6fYolW
	e+euGbDJnokIO7vMAIYWfCg2OdnST5A9AIs7O1nkvLfIjrWzODJepY5DKYl9xViAExgo5UZa0iR
	DwYGQa2z9eiyIh+WOES8EeeCOwTXXI53fgUsnpNHGw+LQWvfXmfjYkz9nEAZqQ=
X-Google-Smtp-Source: AGHT+IFOWxSlU7LboQeYrGu1ZapBf19hzzItaS6bjgdVpBMRFBzVa4lgIENsB6ZfRDlcb/evlyTHrw==
X-Received: by 2002:a05:6a20:2d1f:b0:1e1:b1e4:e750 with SMTP id adf61e73a8af0-1e5e04717a2mr77843013637.18.1736001542441;
        Sat, 04 Jan 2025 06:39:02 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad8fd7b0sm17288107b3a.139.2025.01.04.06.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:39:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 23:38:36 +0900
Subject: [PATCH v2 3/5] powwerpc: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-elf-v2-3-77dc2e06db4e@daynix.com>
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
X-CRM114-CacheID: sfid-20250104_063903_305679_DE278F5D 
X-CRM114-Status: GOOD (  12.88  )
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
 arch/powerpc/kernel/fadump.c               | 2 +-
 arch/powerpc/platforms/powernv/opal-core.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4b371c738213..d44349fe8e2b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -751,7 +751,7 @@ u32 *__init fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
 	 * prstatus.pr_pid = ????
 	 */
 	elf_core_copy_regs(&prstatus.pr_reg, regs);
-	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+	buf = append_elf_note(buf, NN_PRSTATUS, NT_PRSTATUS,
 			      &prstatus, sizeof(prstatus));
 	return buf;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index c9a9b759cc92..a379ff86c120 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -149,7 +149,7 @@ static Elf64_Word *__init auxv_to_elf64_notes(Elf64_Word *buf,
 	/* end of vector */
 	bufp[idx++] = cpu_to_be64(AT_NULL);
 
-	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_AUXV,
+	buf = append_elf64_note(buf, NN_AUXV, NT_AUXV,
 				oc_conf->auxv_buf, AUXV_DESC_SZ);
 	return buf;
 }
@@ -252,7 +252,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
 	 * crashing CPU's prstatus.
 	 */
 	first_cpu_note = buf;
-	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+	buf = append_elf64_note(buf, NN_PRSTATUS, NT_PRSTATUS,
 				&prstatus, sizeof(prstatus));
 
 	for (i = 0; i < oc_conf->num_cpus; i++, bufp += size_per_thread) {
@@ -279,7 +279,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
 		fill_prstatus(&prstatus, thread_pir, &regs);
 
 		if (thread_pir != oc_conf->crashing_cpu) {
-			buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME,
+			buf = append_elf64_note(buf, NN_PRSTATUS,
 						NT_PRSTATUS, &prstatus,
 						sizeof(prstatus));
 		} else {
@@ -287,7 +287,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
 			 * Add crashing CPU as the first NT_PRSTATUS note for
 			 * GDB to process the core file appropriately.
 			 */
-			append_elf64_note(first_cpu_note, CRASH_CORE_NOTE_NAME,
+			append_elf64_note(first_cpu_note, NN_PRSTATUS,
 					  NT_PRSTATUS, &prstatus,
 					  sizeof(prstatus));
 		}

-- 
2.47.1


