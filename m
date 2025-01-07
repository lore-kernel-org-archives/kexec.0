Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9FDE7719B
	for <kexec@archiver.kernel.org>; Tue,  7 Jan 2025 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=; b=GIDW/JJrcu5PcR6XseRiPphqZw
	f2/8MUSDr9FGeVpYd9z87beOUC/Bo4gtvhKCwsfYE0Z1J1rdx2LPNLkbApSadPsBfKSNPbyScPorG
	W36Fe75i5O9G2rEisGVztyxOYG1JnbYoM7nWvLlGKeNeOeuWuxfGOjFFnXEPeu1Un4CJRd8yOzuSK
	fAyU+wsGNH5Q2UKazhZpsw9sPW5hjGDqXxCw84hA29evtp3yK0M/YwfP/G/6wYPbqY0DkzFxW6DZ3
	LhwS8H1pt5KxlApnHkbZfdRbaSM8ceVgLfi1VgSm1DKUPBQOunM5xibJh8fLDrwMTbHBtyc+y+aRm
	xRy5Bbdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV90z-00000004piE-33TX;
	Tue, 07 Jan 2025 12:48:57 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV90H-00000004pOx-1chh
	for kexec@lists.infradead.org;
	Tue, 07 Jan 2025 12:48:14 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so22991495a91.2
        for <kexec@lists.infradead.org>; Tue, 07 Jan 2025 04:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254092; x=1736858892; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=;
        b=OjelsiyFP4LmebrXGW1hH84Qo33DMCDNVfcF4dK+7RrxNfGcodVcCYXG9Mq1y4D8tZ
         5a0Dah+rhlUruWfhDMfBpNskh9ih4HyvhwYI5oCrURGTzZy468AtJ34K7rJlM+w5KALy
         G9CPg1upll1nWnJRwVQtGzQ0QC9+MsF4/ix4cO+X7Fy+VvAIJsJQxZAyF8GdB/PsGeHw
         CvH+SFo542xfgw70GT/G4tDlp6xCDmLmrBd1L94rLljLQwcFSGgU8g9dbcSozRnFiDoC
         C1DwJRFxgM8kAPXT77BynACXm4i0RbYYZjRkRktzWEix6qESAYCVVs6YdrX0PKCi3fY6
         Jxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254092; x=1736858892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=;
        b=Gli+jO8ySF8G52+CrlnFvTW8mT50I3qYhYA/oYG5FEesqL/+xlWXJnobLY1C12Bgj1
         UyyhFQvLMvbEC24NB7Gn4HLHi1new77hPFPAVPdybMyi91RLhy5WuFH4ZBdfJjAdbuML
         xfqQZzEJJ0nbqXPH6YBPBR7AI6dcwlfUc39NU7zDfIAdo3mF9Cb1QvMwWw55WzKqhMJM
         gKVYzGXpEVfuMbZkPIp9VAm6SKYhS/bMfYQvMSlWWgCloLevhOjzW7FcJoL+MySXMd4j
         HOtN7hLjUv+flwiTB3JU2+GUynJKWbK63zPQKWE46gpu4QJK9m3Mlib+ZkP8KhFfh2Py
         r7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXe2GZJ1By44a7u9T12V4XTwRUDe0JdyOnyVl0cDmeVCZMBQBQ15ms56f6VY1mAzZ/bgAS2GQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzlLC7yaLh0Cn9YS+rmipGj5f6DWZXfLgNpyg7trC0GJctl8/KW
	SKmpfhC5vGD5ZfSXVOUlU8sz3OV39R2/YhcPTaWNJO1XkXYlPXwUpzlyHPJd2Qw=
X-Gm-Gg: ASbGncsiOzVIErmwWvBv9zdj4v9O4ldY66yEfi94XceILOyVb+nnv/wtG2n9zeuevDV
	kM9AmgAvsjZ0nf2O86ReYZeL1rGi+xivcoYjMVBqykIps/1i7iC7z0KdKFksELYLkAtneiqus3w
	t4GZKHVmIzjA3fgNhsuBoDT81T3edzmhVS+TY9vzDjpa46EBfRPF71ZYEhO0Yz2InFXkCDwXhhA
	/DX+gdsUuq2Ef9IUlnG8CimNU68OJAzm0xkUu/QXcxH9iZ+xP81qBaqU7k=
X-Google-Smtp-Source: AGHT+IEVKBP005EvKmW5Tl+CNM3WgQ4gF7V3wiTUcNw/Hf4GbFW1YRz6KtZiTE3d5Nc2ByQmLcCTzA==
X-Received: by 2002:a05:6a00:240d:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-72abde04f6fmr85408908b3a.12.1736254092437;
        Tue, 07 Jan 2025 04:48:12 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad90c133sm34268685b3a.183.2025.01.07.04.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:12 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:54 +0900
Subject: [PATCH v3 3/6] powwerpc: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-3-99cb505b1ab2@daynix.com>
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
X-CRM114-CacheID: sfid-20250107_044813_435195_E9B35CC6 
X-CRM114-Status: GOOD (  13.23  )
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

Acked-by: Baoquan He <bhe@redhat.com>
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


