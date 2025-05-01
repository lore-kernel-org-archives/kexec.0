Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0522C369DC
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VphvviRpGC2WLkYAjqaiyvIFs0ocuEHMIPdUSqAExnk=; b=V2l746Re4HTIXHPS7R2MGaA/NW
	hjJqpR31gyi09djX9UK70HKED4n2tlRECHmPknW9WbP8BTCt9sEb1BojHWyCQhX+0WVk2HWFs+GHk
	0yKDHb6GjOy1U7dHlQzPXaUQOs/0X1+f/k2fdCCIDDO0roHxKGshHMjc1rDms55ncXUNcUkQ1+u97
	4BwL+Y4+gz6nlrJjkaONK5Qq14bq9bLNHfqObMstLPJunH55oepgVsZx55lmhlxnxEyge2X45Aeab
	Oh+PXd8M0bM+xdZGsPGPwkjxZbNu1kcZeto07qBUiFHHmQamPTROE5Jp/k3IKyfm0j0kaVetV4MP0
	rMpDg5Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAd93-00000000EWH-1iTP;
	Thu, 01 May 2025 23:16:45 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcoa-000000007Qo-02im
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:55:37 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-227ed471999so12448705ad.3
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140135; x=1746744935; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VphvviRpGC2WLkYAjqaiyvIFs0ocuEHMIPdUSqAExnk=;
        b=iyO7uoF5dAoMAZNEjNXVfGsVFhM3Gg6scCxUpi3V7QE5ZHfxSwta3/uhZPmTaihAOb
         eKKxIZo0R1s7+aEGqglR/jybF6kyHVmWBaqVUdgYTWMQkI0WXOZkgLMpy23vCXTaonif
         r/wso2Nl1h3fKobeuPMywHzLtboObdUlx4dnFnwQYDZA1g2/4Ucb+v6HKVKHVcuxXXvs
         x6EbDZrGpSQcuA8/LMV90ksOGxEXgdl25BfGl+FMioVjJq5oCsL63DjUHCcaZsds93eS
         5yi/OECrbZ2Gi1VnUEho1PAYLs8MY7yEbw/pe42xF9rTmugD3ubpi+IMm5sJylzW75eX
         q70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140135; x=1746744935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VphvviRpGC2WLkYAjqaiyvIFs0ocuEHMIPdUSqAExnk=;
        b=kngk6yWCht1rNUR8S1JKX5ve469sQcj0P8LGCwVqPyz5TnFUbyCy8j+G/vQ6Nyc2O7
         TIVKwRNR9R0760vv6byAKuJrYX+ooLeKTYHSnrkFvTMhrg73xSHnNPlzeOPEiZ3Kcswl
         0qYiLE9fr26VnEP6oXkvwERyVXj5wrdEIKYn7zeFox1o0Wz8FFKMQ2gCgJGJsU9nqCu8
         eCocWzs5qKvqgbOK4BC5drylFEQvFIWl7uLF0n8N22o32UXY4BreHl1ZbkRApdfhZIPj
         k7x+D8nj3Xd3q+wPmF2//zLdv9wAbZtqKWMGZD4RojVwHWBC19MpuoiQ4K/Eggcp8fJW
         nOEw==
X-Forwarded-Encrypted: i=1; AJvYcCVf9kepv6n4VkMamSC245o6H5DSgvL7lBDS51oTI5bNQVFW2lnqw8aAf5iCuoh/YwdafwA9uQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyhSO+lKJX6TziG5zs+kfxX1URIdeXUgeXgFAN1gJl3xjdiY/P7
	e2H6nfVl8EpY9I7m1EqUcDFGLdIE/cdofq9VjbBVJSG97s6xLf3Nm0Vv9lKxt37bKKk/euXtJgl
	ep8qTy4IOZgQmXySFyA==
X-Google-Smtp-Source: AGHT+IEUBELohUIuBjZuX1t4KvZ63Sn972imtSEYrAK4n9xeHQS/vygxbNUhLnD35SKxrJi1vU9ISpeHFRO3BtsZ
X-Received: from plou8.prod.google.com ([2002:a17:903:1ae8:b0:220:da6b:5d08])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1ab0:b0:224:24d3:60f4 with SMTP id d9443c01a7336-22e102d05f6mr12139545ad.15.1746140134934;
 Thu, 01 May 2025 15:55:34 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:20 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-14-changyuanl@google.com>
Subject: [PATCH v7 13/18] x86/e820: temporarily enable KHO scratch for memory
 below 1M
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: changyuanl@google.com, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_155536_051312_9EACFD0D 
X-CRM114-Status: GOOD (  13.53  )
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

From: Alexander Graf <graf@amazon.com>

KHO kernels are special and use only scratch memory for memblock
allocations, but memory below 1M is ignored by kernel after early boot
and cannot be naturally marked as scratch.

To allow allocation of the real-mode trampoline and a few (if any) other
very early allocations from below 1M forcibly mark the memory below 1M
as scratch.

After real mode trampoline is allocated, clear that scratch marking.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 arch/x86/kernel/e820.c   | 18 ++++++++++++++++++
 arch/x86/realmode/init.c |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 9920122018a0b..c3acbd26408ba 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1299,6 +1299,24 @@ void __init e820__memblock_setup(void)
 		memblock_add(entry->addr, entry->size);
 	}
 
+	/*
+	 * At this point memblock is only allowed to allocate from memory
+	 * below 1M (aka ISA_END_ADDRESS) up until direct map is completely set
+	 * up in init_mem_mapping().
+	 *
+	 * KHO kernels are special and use only scratch memory for memblock
+	 * allocations, but memory below 1M is ignored by kernel after early
+	 * boot and cannot be naturally marked as scratch.
+	 *
+	 * To allow allocation of the real-mode trampoline and a few (if any)
+	 * other very early allocations from below 1M forcibly mark the memory
+	 * below 1M as scratch.
+	 *
+	 * After real mode trampoline is allocated, we clear that scratch
+	 * marking.
+	 */
+	memblock_mark_kho_scratch(0, SZ_1M);
+
 	/*
 	 * 32-bit systems are limited to 4BG of memory even with HIGHMEM and
 	 * to even less without it.
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index f9bc444a3064d..9b9f4534086d2 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -65,6 +65,8 @@ void __init reserve_real_mode(void)
 	 * setup_arch().
 	 */
 	memblock_reserve(0, SZ_1M);
+
+	memblock_clear_kho_scratch(0, SZ_1M);
 }
 
 static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
-- 
2.49.0.906.g1f30a19c02-goog


