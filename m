Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF54C369DC
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 23:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9pq7cOlD4UMnBbr7MdoylLenI3n1hFTN7/xVF2jk4Gs=; b=La3kiw9hGraPkIA+9NHeyax6bt
	rWxW1am13Jxa/M6qGESF+4e0fEzwRc3WpPFOxaZQFxo9aBSFVQtEGiYeH71b5E/snJ7nxzUmnWblr
	JdfE8Crc+xILjPWW9UcBCjcHxUYBGOWvvTi87ntE4RhJhGpWXeVflgFG+t9uYCQX9+1dsyQxbO+BR
	s8i/IgS0RExaxm3ttILP/I00/2OwyroGSDcaI4FnUujASgmSzn+bqImYROo4I7uC8X2vCo6IRmuhi
	z76TsO/z4RvR2qxKeGUyEJh7AJGtN/hM/RmRg2s/aFzcgDTjVAv5vR0EKEf5vPlkIkpxQIdRyYuo8
	SbQXutKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAd7A-00000000E7Z-13UW;
	Thu, 01 May 2025 23:14:48 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcoV-000000007Me-3XzX
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:55:34 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b00e4358a34so826807a12.0
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140131; x=1746744931; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pq7cOlD4UMnBbr7MdoylLenI3n1hFTN7/xVF2jk4Gs=;
        b=WfFTkGdzuIEnnclfbf9OkjYZ4N3hGuh0D76cosIW6iVRplO/xnTqj8wWNq99YUZmyx
         5n+SwXZeIwiuwTX5wiCpfyLiLSDVMFiNEMobsf0AJUapgkTpDOW+huc/ZPpnh/BR5MLX
         CL2wuSxmrF3lpSCQAHIGNARPoyi5jNwSJqIa7sZxjFfbCk3TicY7V4EszjP5iBCSZ3dv
         5KnztGyLMoirRuuYczBRotSuK/gBXYpYQVutL861Mn9zP9LVM/fnE69l5PVGyPvCBmF6
         JMPWc1VWue/9/V7FijA2xTck6gy9kEClYIYL5OJ8nir6t4BLZRDctwXQ5PX4TyTFewV1
         X96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140131; x=1746744931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pq7cOlD4UMnBbr7MdoylLenI3n1hFTN7/xVF2jk4Gs=;
        b=NNYYCB67Gi32xL7/CWRM60QVfB0dZxv+8R+izX56CIe9NE8UoG4FJ02MIs0gaYmJhc
         YBN3kBA7/YOj/z3Gdgi8Y+Bb7++xBiobgIhxiFSPgMh2OAWs1LQDbSYD3vwInAe2oT6W
         JpWdmdtADyTfyW6kwLsP5A0KGL2RMw63H/oka2XITF7a0ylfcQ5FLt+s8l60x3vTnBS3
         xDqZa9eZQbQ+j3fa4ndyOxazGE8lzxLiQC8sYLLc8wO+qgOgqg0ouvHdegoQ9NjSmZym
         HSNC7R7TY7wYvMW4/a7JEbTqrLl97f6bP0/teenVQK8B9sCrz9wUBaptBwdVPRyGblbg
         Danw==
X-Forwarded-Encrypted: i=1; AJvYcCXePXj5AAjpvLjiDWPGjXcq5I20LX/SLNg6Li+4Ktme9DEWQ3C2mnqIFTtpBtar2uIGWFVuWA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzbZ+Hs583bmtAjuNJTfjWd+eapXYGKrTSXBeMhZYerJQ3obvX+
	irSWgn4ijI7exArF/csFC7nQ7JcMZnLvlPaf319evz3+BVr5APy5K1P8er2WqFTR+M+0fR8l/qc
	8nlaVtssWNCNq7d3dOQ==
X-Google-Smtp-Source: AGHT+IFQu5I4jmdQMtq8hCC1f3Z0zQU0SpvNDrnLFxyAAjKycN5vHSclb6UlAZsA+ljFPMEbEBhOmIJO9x7kjnX2
X-Received: from pfbgo18.prod.google.com ([2002:a05:6a00:3b12:b0:73d:65cb:b18b])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1805:b0:1f5:81bc:c72e with SMTP id adf61e73a8af0-20cdfdf4736mr892168637.33.1746140130873;
 Thu, 01 May 2025 15:55:30 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:18 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-12-changyuanl@google.com>
Subject: [PATCH v7 11/18] x86/setup: use memblock_reserve_kern for memory used
 by kernel
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
X-CRM114-CacheID: sfid-20250501_155531_884693_CB5C7C1B 
X-CRM114-Status: GOOD (  14.07  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

memblock_reserve() does not distinguish memory used by firmware from memory
used by kernel.

The distinction is nice to have for accounting of early memory allocations
and reservations, but it is essential for kexec handover (kho) to know how
much memory kernel consumes during boot.

Use memblock_reserve_kern() to reserve kernel memory, such as kernel image,
initrd and setup data.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/setup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9d2a13b37833c..766176c4f5ee8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -286,8 +286,8 @@ static void __init cleanup_highmap(void)
 static void __init reserve_brk(void)
 {
 	if (_brk_end > _brk_start)
-		memblock_reserve(__pa_symbol(_brk_start),
-				 _brk_end - _brk_start);
+		memblock_reserve_kern(__pa_symbol(_brk_start),
+				      _brk_end - _brk_start);
 
 	/* Mark brk area as locked down and no longer taking any
 	   new allocations */
@@ -360,7 +360,7 @@ static void __init early_reserve_initrd(void)
 	    !ramdisk_image || !ramdisk_size)
 		return;		/* No initrd provided by bootloader */
 
-	memblock_reserve(ramdisk_image, ramdisk_end - ramdisk_image);
+	memblock_reserve_kern(ramdisk_image, ramdisk_end - ramdisk_image);
 }
 
 static void __init reserve_initrd(void)
@@ -413,7 +413,7 @@ static void __init add_early_ima_buffer(u64 phys_addr)
 	}
 
 	if (data->size) {
-		memblock_reserve(data->addr, data->size);
+		memblock_reserve_kern(data->addr, data->size);
 		ima_kexec_buffer_phys = data->addr;
 		ima_kexec_buffer_size = data->size;
 	}
@@ -553,7 +553,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 		len = sizeof(*data);
 		pa_next = data->next;
 
-		memblock_reserve(pa_data, sizeof(*data) + data->len);
+		memblock_reserve_kern(pa_data, sizeof(*data) + data->len);
 
 		if (data->type == SETUP_INDIRECT) {
 			len += data->len;
@@ -567,7 +567,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 			indirect = (struct setup_indirect *)data->data;
 
 			if (indirect->type != SETUP_INDIRECT)
-				memblock_reserve(indirect->addr, indirect->len);
+				memblock_reserve_kern(indirect->addr, indirect->len);
 		}
 
 		pa_data = pa_next;
@@ -770,8 +770,8 @@ static void __init early_reserve_memory(void)
 	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
 	 * separate memblock_reserve() or they will be discarded.
 	 */
-	memblock_reserve(__pa_symbol(_text),
-			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
+	memblock_reserve_kern(__pa_symbol(_text),
+			      (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
 
 	/*
 	 * The first 4Kb of memory is a BIOS owned area, but generally it is
-- 
2.49.0.906.g1f30a19c02-goog


