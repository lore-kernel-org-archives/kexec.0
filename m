Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31447C3ABBC
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/uG6GiCi+k4QeVIeYPGdrcHOaMWapGzdHMs1nMnrsrc=; b=k3ej/Iu+8mlww16rXVnP38NuUK
	J9iXOtDTVfa+dLCyE/ChODv8OWe96Vof9GV04ijf7Wf5K5TjGSbvBYGFcOGnte2mVaFnphaby35/M
	X/fJACBXC+/2T1WMZp9Y3m7c/CnLznlhLLJVR7DAsWko9lE98wS9J5a9cPqg10WzJDv2uNOu7lEsY
	oeMEaiBw9hshK3WtRFs2RkrQep0yYX6ckHcBAsMCL63ytbVaf5EKntB7iQn98J/REcrGvCeCslqfu
	2hVRukQyY1ZuwFb8/7FBZ5UqsJnqCVU0qBpUV+KA+ZgE8b/01K0YuoLw05Q1EA15IIqVMTbajS5/3
	oL8ONqRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIjg-00000002rRp-2nKs;
	Fri, 09 May 2025 08:05:36 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIS0-00000002nm0-09bc
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:47:21 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-22c31b55ac6so25324175ad.0
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776839; x=1747381639; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uG6GiCi+k4QeVIeYPGdrcHOaMWapGzdHMs1nMnrsrc=;
        b=0VxW7jO6oOdy90IZl/oN6P0RSLlulZxKlwhfvyDX6kqcxJ6KsMNLGPMjYvhUJ5xA33
         RCswHYZ8OwIJI5lZrviTjQLPzjzdEH66yQrWlKlO1daRs5erbbhnCMs3hLGNJd2V0VGm
         UDeMwzQ7VQMBFkxqFhOcqSSJdhhq4zXmGe8+TLrVZgr45ZzBPFrDDvlgiEcYtiqTn6tf
         6v86AFwWz3pOfNXeEZ1xe+0g0X9wVE5G0maMF0ANTQv5wid7o9ea22LPrL5h1blPth/S
         oT+JhXZn9btiUpbxzsgnJn5ibBOeYDV2lSYM5oDU8AuWMLrYxeTHWQskxPhw3XR0lVrr
         IF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776839; x=1747381639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uG6GiCi+k4QeVIeYPGdrcHOaMWapGzdHMs1nMnrsrc=;
        b=Dte2SEZbcboDuVMYMBLgyQ8A+PEqWpgwjzanszpVz0/OA4WoPcyvQWvO6SoN1hI7Wh
         OHamGLkFNrNW0PW1NRsjTUsh/vPHVd2e5LezkULl+PThqrNjjJ9JTVmJ1mMkl0DgVSLa
         6W+f9sg5dEmFfRvz/ViLuy+Pvh/ICdRM/A1/uZleaM6RXeL/LtkLDodZKTgi78w66d6K
         8VsxZlEtRc+Ebnc/H2JkzfAczHLLB245h/4kEqDrhDwfgIU45Lu9AHyhBMewP3jaRt+O
         pWdgrdplIbxTEnUg1e7SrgO2knDG93NT3LC5n8M08e+l6suo5CBQNNFiCSb56nhEi06e
         VDdw==
X-Forwarded-Encrypted: i=1; AJvYcCVimLtzIZiktjZ/oY4QktLuihyvEfp90E2UvxtlCJU1+x3TlXYIRUP0I4ejah5/B87kPpMB0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOkdbZWEoipxVE9up9dD+ly8AA6EfKYQM4p6OMLJED21L33eBK
	LqTaLJAof9338yBuin5i0ASjIagKzezcJGbLUBaUsMXeEmIz4ZK43fUczY/mSdojvo19RhA4QJK
	aTWFez9yeVcgYYySnZw==
X-Google-Smtp-Source: AGHT+IEtYvgMQD/fc6wFPgnt6KgYb8JeNInbNpZgGejD3McBZNxXkmne49Y8Hn9OW1r//Ao+vz75n4rLQVAMCRw5
X-Received: from plnr4.prod.google.com ([2002:a17:903:1904:b0:22e:4a61:5545])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3ba7:b0:224:c76:5e57 with SMTP id d9443c01a7336-22fc8e99d3fmr26734465ad.39.1746776839015;
 Fri, 09 May 2025 00:47:19 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:31 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-14-changyuanl@google.com>
Subject: [PATCH v8 13/17] x86/boot: make sure KASLR does not step over KHO
 preserved memory
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
X-CRM114-CacheID: sfid-20250509_004720_096601_1C3B421A 
X-CRM114-Status: GOOD (  20.64  )
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

During kexec handover (KHO) memory contains data that should be
preserved and this data would be consumed by kexec'ed kernel.

To make sure that the preserved memory is not overwritten, KHO uses
"scratch regions" to bootstrap kexec'ed kernel. These regions are
guaranteed to not have any memory that KHO would preserve and are used as
the only memory the kernel sees during the early boot.

The scratch regions are passed in the setup_data by the first kernel with
other KHO parameters. If the setup_data contains the KHO parameters, limit
randomization to scratch areas only to make sure preserved memory won't get
overwritten.

Since all the pointers in setup_data are represented by u64, they require
double casting (first to unsigned long and then to the actual pointer type)
to compile on 32-bits. This looks goofy out of context, but it is
unfortunately the way that this is handled across the tree. There are at
least a dozen instances of casting like this.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 arch/x86/boot/compressed/kaslr.c | 50 +++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index f03d59ea6e40f..3b0948ad449f9 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -760,6 +760,49 @@ static void process_e820_entries(unsigned long minimum,
 	}
 }
 
+/*
+ * If KHO is active, only process its scratch areas to ensure we are not
+ * stepping onto preserved memory.
+ */
+static bool process_kho_entries(unsigned long minimum, unsigned long image_size)
+{
+	struct kho_scratch *kho_scratch;
+	struct setup_data *ptr;
+	struct kho_data *kho;
+	int i, nr_areas = 0;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
+		return false;
+
+	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
+	while (ptr) {
+		if (ptr->type == SETUP_KEXEC_KHO) {
+			kho = (struct kho_data *)(unsigned long)ptr->data;
+			kho_scratch = (void *)(unsigned long)kho->scratch_addr;
+			nr_areas = kho->scratch_size / sizeof(*kho_scratch);
+			break;
+		}
+
+		ptr = (struct setup_data *)(unsigned long)ptr->next;
+	}
+
+	if (!nr_areas)
+		return false;
+
+	for (i = 0; i < nr_areas; i++) {
+		struct kho_scratch *area = &kho_scratch[i];
+		struct mem_vector region = {
+			.start = area->addr,
+			.size = area->size,
+		};
+
+		if (process_mem_region(&region, minimum, image_size))
+			break;
+	}
+
+	return true;
+}
+
 static unsigned long find_random_phys_addr(unsigned long minimum,
 					   unsigned long image_size)
 {
@@ -775,7 +818,12 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 		return 0;
 	}
 
-	if (!process_efi_entries(minimum, image_size))
+	/*
+	 * During kexec handover only process KHO scratch areas that are known
+	 * not to contain any data that must be preserved.
+	 */
+	if (!process_kho_entries(minimum, image_size) &&
+	    !process_efi_entries(minimum, image_size))
 		process_e820_entries(minimum, image_size);
 
 	phys_addr = slots_fetch_random();
-- 
2.49.0.1015.ga840276032-goog


