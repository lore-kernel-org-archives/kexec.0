Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60075E7719D
	for <kexec@archiver.kernel.org>; Sat, 11 Jan 2025 05:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=; b=SJ0amSwEearRh499zlCH3RA0DA
	R6+3PSFxq85gr6s3hXEEs4AJHa/JJLvM/mDQhf1uN3dPzFkvHEtahCLGMXPGGT7h9FeCEjZ0ew0bF
	Ps8yrDmF1pQ3O8QGREf++6zqG+zozperYDlfr2S25bzrhJkw5jcJThWQ3+OsVpE083SvALpDm8cnU
	b/GtEacAHQnoRY3PFmy740yPhCAp1Rk4j05y1qSEpOE0ziaX/vKCrnQN/xqCXsxWZ7zFX96gXNGcR
	OOqxpJldRPuv3XyiKe/6DV23LRLztr+sykbqzm/ftffLvxhx3SwyLVe6LiqA1c32XtZ42O9vrRhtU
	ZyI8NZEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUN6-00000000El9-04K0;
	Sat, 11 Jan 2025 05:49:20 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUN3-00000000EiC-1ggI
	for kexec@lists.infradead.org;
	Sat, 11 Jan 2025 05:49:18 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2162c0f6a39so67362565ad.0
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 21:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574556; x=1737179356; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=;
        b=xRY2yZaYMS6vJDouQkD0llgxhNEjhY7g5G9tE0MW1Y7GqnHYtagyzCZjGU5QwZa1LO
         2+g3rVkpaL/2rcisJXMNYgC4UKt4w7+YNYRbmA6Xck8eswAl2Ek5TdHHNE7arWWeAFU+
         WCF8P+TlFHnNd+DC8mcpjdNfBhRm6H1htSvI/VSbE6hALAktz4S1r9zB6ic4FRmGtbOX
         S0nW+Zxm01SlEVgbNhwSSF04y+IWuJuHP2yK4RTgwFMR+oGQTw/r6TiNblf7jrmx8akD
         lZIWv4Whm5qGvqqkYWlyTSX6b1XWDlKKdiyAdC7bPIDDZ5CPXJUBIC+ez4P4Joteuhm8
         WLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574556; x=1737179356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=;
        b=S2yLiJ8S4SvExtdQcO1ZSBxAkM5T/OflsN0G1uyI+1a2mW9iaqkw75zvjC9x/Pufz2
         +3/NZZRul+U5vTRUcXpnxVYmzrfbjIN4Tek4tq5Hw1Wyp9fP+wA6uP1Bhg4LMT0FbMwI
         Y2TYMwHfxeTkUgYndk4pNM3KCAdXLTvlZNaUMpx5+y6QzvhIwF2JOvRkboJNg7NDGZZ1
         BmXpuQKKIT/cCfDVzlDvT+zvbhz3tK0QqHwyq7NnA636SXCff0Hxs9e9eTo9qnSTVR4T
         NFD409cikxpoIX/9Aw7/FytXl/lSpNBeAaNSnB+Dr2tzXQBmcaMRc6Vstnhrtd+O4FPz
         soqw==
X-Forwarded-Encrypted: i=1; AJvYcCWApMtA6vjV5sJ/xCHH/9rpsQurCd/CAJyTRdhvkI3cUY46M2lo/u98H4hDrmCLTabCoK6KOg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzsXw6ORO041iiXAe2LZdzhmFjfaIJBTXA8nfS07Wr7DchTjc6e
	bRCOzJTprO65N7o80QFtjK2rdjAyTCWw+LhGlFp/vgPXxi5fS7G0L7kuhy6yBlA=
X-Gm-Gg: ASbGncv0pC3OlprM0voTBO6sZIj4iI16VPBIut3LnEO+cyrMqNxhqV6atnRJNGe8LhJ
	mNYnp0Bx3CK1JNcDc9YFDQ+Bgj2moHC5ct2bp/hk0B0QXGsa1ys47s7sDgBkNbJKEzA2+ZSbumf
	N9k+/DPqhekf8D9ryQGlden9BSFPgLiC8EYV5PA4O7lhhS+XShtpD3zk54tFW6N73+OB19WeP+P
	BQazO9ayKkohidx3mRc/OGRI4ysE1G+nJSQdTPdSIprlDUSDYbg/gjAPns=
X-Google-Smtp-Source: AGHT+IGYDl29OCGY4z1owZDP0XWbhTx09xSMaaJapB97QNqOQhHfEZ2TmztXqViOu57Hf/bAEePhOw==
X-Received: by 2002:a05:6a20:841d:b0:1d8:d5c0:ad74 with SMTP id adf61e73a8af0-1e89c89888cmr15576349637.1.1736574556053;
        Fri, 10 Jan 2025 21:49:16 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a31de806694sm3683573a12.69.2025.01.10.21.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:46 +0900
Subject: [PATCH v4 3/6] powerpc: Use note name macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-3-b3841fa0dcd9@daynix.com>
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
X-CRM114-CacheID: sfid-20250110_214917_498085_76A3C64F 
X-CRM114-Status: GOOD (  12.76  )
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


