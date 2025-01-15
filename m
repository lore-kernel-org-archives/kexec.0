Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB2BC02183
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 05:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I4SRmWOkQdk58NJ10wmqwv5TrRHdqCAxdQV3fT7eobo=; b=id+INd8+LD/BJEThhdHYVRojaf
	bztjcvqaMJvwSMe8VzWh3cEypOD8wyE/joR/QVhlXB+rom9LPB0YWgGHbI5dZegtsE94rPHkHRNCz
	7/xzxBsr84cjEzFxCtSOhgcH8VmSxTW89POPGtfp3U7zbPCqcxqen9K6+z3EX/QBT4D2ZC1sGxdud
	q43WqsZ21gPaNxN2HdoTKA3ow0IdVi7wTq+vILY8sLKyr7BjnCRpEKqHI56duqfMaNe+vx1r4dGCR
	pQCVKxrTMPhe6ZZt3/A8uiZe/yASjVHVK2jr0BnJL0Dm+vv+cfnsB7uXbWBdfbYwvAfAY5UFTPkAO
	9sml6GtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwGy-0000000Aj7l-0E8V;
	Wed, 15 Jan 2025 05:49:00 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwGw-0000000Aj6N-0mkL
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 05:48:59 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2165448243fso137570025ad.1
        for <kexec@lists.infradead.org>; Tue, 14 Jan 2025 21:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920137; x=1737524937; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4SRmWOkQdk58NJ10wmqwv5TrRHdqCAxdQV3fT7eobo=;
        b=u9O/mqdhO1GED4dEjlnL1W9UXRGSrFTB7JZQ77EKByQpHgu2EeVQDUceATGVrOAM4V
         xb+cwrS/I8Rcvzj3L8Tt2VLgqBupJ7KVa3dyev4d5SR3pJvchrkbxGEYEt7Jfzak7iKP
         V4sl2YZnbsUyAwOhFIG+RFuDiT1/wBt6FfWW7LLqo3g2koQUD5uT0OONrRug3vHWKxk/
         pdsdHksWl9dMPbTUjEUlqGU0Mi6z15mSO54sC/w9vJOShNBbpupfOiCpXDgD7kG7IULy
         x+Mb00LWkzFUTvakqYVDEqDgU4ETTAlr7urguGQFfH4+B2NNGQPN6DpRA17JfzIOTtD1
         5M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920137; x=1737524937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4SRmWOkQdk58NJ10wmqwv5TrRHdqCAxdQV3fT7eobo=;
        b=d1K2bY9cC43+810epmXGtjrjDUtDjsalJb3T7Opkalol6vv2C8ALDUtAgjXet/IQEz
         c0gZOWKTVJpraQhCWhELOu4LGhNF1v3xL4CIMJ77uglVtLOACql6RsGwqAXJ4Mrk71jZ
         vC3eww5NYwsU1j0vWam0FdrxDjy8eGNxGJIi8tnK45ujrAJANG4/RU+O9P13YT+i0yDK
         08VJkkWCI12R95tnQqoVR0GBq4DhjQYO20YMpFRqfmZSCw3qLrI8junvzc26hdRp180/
         wK6iZQ6WjYTB6CZ1flMH3pcH6R676wJlxoTxbQGR5Ncks4ha5LBJApmLQQ1KPGjD6Mym
         WqWg==
X-Forwarded-Encrypted: i=1; AJvYcCU/8LWeDHQ74LFSdGTrGzuEBIw+AyO0ZRzYMPP4SUR5z+9ginWzE2oK7rYG1koU34q0YVrUjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxpHFESzVWh8jN2QG98kT2laP9+fo36g6ris+dUl59ePKwQs/Wl
	UVX53cusLX4HEwUAyWG3hzkfPu2jmJN3mDB0qYHVwfwez+9fDHzU1fZIm3X2XCc=
X-Gm-Gg: ASbGncsHXdpWMMbwe2PHsBBB203LkwWMyaK2W36CBFKtZwnvTQJgSQYLY5US1TWtHxb
	laXJ5WzDuVJXNj5N8vhd+ZU/vErD78FwU3fuDaymdzYisfPObvyIWzXGZtMcweYWpCVOVnJLUuX
	bkyqmQEUI3Ee9g4i3wXWcwi7ihyubmwLLYgxf+PP1Oi8Toc/CI3H9tAQ2YzNSI/aHJb9ikFWjqh
	9wTeRKSjYFcHafnY8cFoVGXBLOfncYtZ1X9Nhc308jLPgckOV7IBtNFncE=
X-Google-Smtp-Source: AGHT+IELo9CjdL+yrG4BCg5jbLzJxkebkveFvc3aZpHyweclYXLk3OeSuIMKxGoccunx18mtoTdJlQ==
X-Received: by 2002:a17:902:f644:b0:216:48f4:4f3d with SMTP id d9443c01a7336-21a83f56bdfmr398040455ad.13.1736920137397;
        Tue, 14 Jan 2025 21:48:57 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f111b82sm75035235ad.35.2025.01.14.21.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:48:57 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:48:00 +0900
Subject: [PATCH v5 3/6] powerpc: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-3-0f9e55bbb2fc@daynix.com>
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
X-CRM114-CacheID: sfid-20250114_214858_230158_E658918B 
X-CRM114-Status: GOOD (  12.96  )
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


