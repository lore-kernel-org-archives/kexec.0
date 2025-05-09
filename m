Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8261EC3ABC3
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 08:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+m4Z3dP+tM6YZb4FwYg8AZfxdm/iv45+PxfK9MWhRlE=; b=D5P+vTu2YmoneJ2G3t4cJ2fswG
	TqtJ8PLoZMQ+EEZI9/iW2P5wpSyl1YJKBV11Qoa39okH8dTIi5EzcHJZv+DgXHk8NZjTYJDrDmBYS
	4Hh9Ga/QC2iNtGtZB8SU84lp36B3qdqj3xJR4nZsJqN7u6soZDGi3j6AwdDjFtkYWcsLjEAanMqfX
	VMyuqK6ooLL36PKh/8PZlbLc3iLfEVU5W8Cf99S5GC546bquWK4eyxzIQgIR5bzhlbi1h7gVnx7ZY
	0x47AueZbTH0EDOksIr9+h6ApIHHzGDUaYlDmmHVtiU6bZu4vLkIVNJVsV6bC745/4JvsjYN/exth
	E9dCLhDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDJ37-00000002vJf-014L;
	Fri, 09 May 2025 08:25:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIT5-00000002oGg-3MM2
	for kexec@bombadil.infradead.org;
	Fri, 09 May 2025 07:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+m4Z3dP+tM6YZb4FwYg8AZfxdm/iv45+PxfK9MWhRlE=; b=HkFquRNA6PtF/HvtULIRPHwZ3s
	WzTLzZXw5wqnlZXm3SI/eBt3I6VSelvJKbXVwhmcPFkTw77j+LzCSnSSyOFswqjJw1EItw4q5ZjYf
	0XeXh/2DSfQ1zdwF5bxhYP8kPurbi6hzxK7hUu7I6LyudjbQQZzOWI983Nr1jxMAp6uMokhFU0YF3
	7G0m8QcPulOnn3CY7LG7Ke2Z6cWhWsPNie7AZndJ3scqOhaUV8aUf168szihaSx42egp8nMarzdoo
	izOnb9MyI4L592hnu37etgcVdcLj0vWl64ywgsCkRtq1gkufIj9a1V2xlRZgXS5Icd9+7UFNlguY3
	Uh0MW0wA==;
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDIS4-0000000GEfz-3BL3
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:48:25 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-22c35bafdbdso30267655ad.1
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776837; x=1747381637; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+m4Z3dP+tM6YZb4FwYg8AZfxdm/iv45+PxfK9MWhRlE=;
        b=r4vNWlJ5V6OwCLukPxFX3FrYRUP4YGq3W/TDXsvMYRI/DZzLdZ0kcFq7GmqXsEX+17
         Du2S8r0RlNxFdmhCL4LMz8LwXmvkSfgzkFK8bBeh4VhZIQjeFKQyPNew9Nz7ON4oIMGB
         LWO61qeuWCvIxG1efL28cYCR12msgzxP1qyQsrz1wdDpAGqmgi7L1MOlNXxhWnyqRbAa
         lWjPjvl9UWv/aws+kZCACcz1WndX9vg8XxVL97Gy4GXT6hFiA/DkepvvqaWE7e5yNPCY
         a5P0Xe2TBwUFBiUcC7ioxW7ckc33DO3Av1cSZrXh12VRBIPttCLoYuaL6XiAp+h1XdHz
         QxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776837; x=1747381637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m4Z3dP+tM6YZb4FwYg8AZfxdm/iv45+PxfK9MWhRlE=;
        b=xTs78ECAV7zp57lfnrNNGAyknVSlBBj474+VLYnFv4XScDW0jEWsjZUPcujbntYBB8
         xXDTQnKmdBGW1HX1fxM0uBy+FwNy2YZBhDbwOdSOyzqEZCVWwc43rQ0Zh7uySA9RNJeB
         7ssUeIE6TW1ijGQRkfmifF2UMyn1fcpcJbR4t1ytZddxUqq8A9+thN8zRzl8PHqkON1L
         fNoo/rP/wF4VS2oApXnrRipxl970Soc45bf6hF5rVsGZdeFuBUsTb6XCc0U+KBjss2g+
         95IeRBDG0FZNC0gXFzdV+bZLeSpsyim3sgjJaoUF7RRVB9/J/vgTxKt6BO/Sc4Xhn+UO
         oeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyVAQcCK10/8/0qG+SLUxnEJlR9nlu5xEdm+O3zduMAao0Pc1NR9/rYlaa3eTM+31DkMdJag==@lists.infradead.org
X-Gm-Message-State: AOJu0YxhiG5pQVskEVFwlNkX/QoTTZAPCilYyT9R8VFbKfn3+S2EvrQt
	J3T3iUpdZRa8FY28WLeHeXOTOSdUAnYDDo4YMDeiXMq7LVPi1rKjCEkwTZxhJX35Qs/fzd+XMdU
	Zj7VFbfZX38xFKLd3ng==
X-Google-Smtp-Source: AGHT+IHfR2VcOxe89TQQkgMURCMNF7WAQ9A5nVl3ln2Y/iICrUYXCipTIhMpc5lhLO0v/RkcE3tO5H+jCjQrIWm3
X-Received: from pljs4.prod.google.com ([2002:a17:903:3ba4:b0:21f:40e5:a651])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:18c:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-22fc91a05e1mr34656295ad.37.1746776837245;
 Fri, 09 May 2025 00:47:17 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:30 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-13-changyuanl@google.com>
Subject: [PATCH v8 12/17] x86/e820: temporarily enable KHO scratch for memory
 below 1M
From: Changyuan Lyu <changyuanl@google.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_084734_621591_A5F9173B 
X-CRM114-Status: GOOD (  13.30  )
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
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
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
2.49.0.1015.ga840276032-goog


