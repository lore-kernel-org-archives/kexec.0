Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32A4C35FFC
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 02:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q4HakJ1xIrca+h2lsnqHQuPoA99HtUJXt7bntXeIsss=; b=FvKn4Z65F2KWoMSvIUr0WD6O2i
	SOu2H+2YMRP1rjCz7mpnku/d1z/iQDJN7rIEkPHiP58XJ3AiK/uv6sPUa3p+kaBrwhP60H4JLLb5W
	lEl+O4OnAaxgCVU3QTOPYmntO+5+kkexsodEBkwefF84iEXy6Nhb3fLT7BP2omI7z860+ukju+V56
	dk4K5xgKfb9/qLSKsq6HL2uDBXq/0TlTopHKpOzPLyepEgTcl9QAKJXkHWDTA2fxMkr/czI4p9X3t
	WoUvD7crm9Onyl8BEXGkkBGItEJmuJimcSsA3+V2yrgYove+2W7MUREbW9eRyTYBwstcb+tft3njR
	QwvnJVIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv5Sp-0000000Aqk2-0w7p;
	Thu, 20 Mar 2025 02:16:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv590-0000000Akks-1FeZ
	for kexec@bombadil.infradead.org;
	Thu, 20 Mar 2025 01:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q4HakJ1xIrca+h2lsnqHQuPoA99HtUJXt7bntXeIsss=; b=NLmSFfT6YY+cLUkj+qLuDECfqt
	oVuL+wy/oQ+yKZTzaRt5KcOzrHcQejXkQfjtXTP5wrB5MYnmgrheBRweu+khBJM/jiQlYzKgkp/q+
	AgQIO7wPXQ/JC68y9hOBkCnbfXfG1tBDXdHA8DmWvfIafH3+YIvjjI+aWHrhO/35vdnIYCC8maEIV
	AX/mRs3i2jigo0kOqRIkwGJQV9PwPv0UXKOtWVJEaBLZWmEsRvLZFS7kkWZiStMHpRVh1vd+2i7uA
	/wcq6IN1giXyE4kV/nMS6Yth1dnjA8XbCraiaRmCX9Db5RbTwYp90U12WozSl1NEBmUFubw5ohRC7
	oC9EEObQ==;
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58x-000000043eZ-1v31
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:25 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2254bdd4982so4818525ad.1
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435781; x=1743040581; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4HakJ1xIrca+h2lsnqHQuPoA99HtUJXt7bntXeIsss=;
        b=fyxmrUIYgX0Cq/IMAid+aoDCpUk1HA3gibS36h5wu0pBy5zbdo0u2fStw8KKfTP05N
         xdcjAERNDwynE1yxoATP68pWAmc3Bt8uAsaSFGvCvBlXSMgR/jSd7uPywNiqeRe+xxVE
         klTNJzlq4I5OvcxbZ81ELIsn24tm5qijw74pZUjY/GFR0bRAirK688Z6DbIG/l27zUsk
         ZKWY2Zyt/aZTXj73OfDiKFwmZpkQaOZJMAzasVnFWXZo8IcsG3S9AyLOvLwaHeN1jCxR
         Mgi4ti/0k/QGi+OUSdKdxHj5VCpFV1F44eyoWtomz1/MfZDtf3rP7hXgsuFfaulybmEU
         Xr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435781; x=1743040581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4HakJ1xIrca+h2lsnqHQuPoA99HtUJXt7bntXeIsss=;
        b=GINSA+EwB5JTt+Ttu+bDBl2DalLG8N7n7tMhW0hrAp2EQ5daeHjqqqolGfBRhYJWJl
         UidJwofsqTte+y3c8LafgWJH7JDytrpFt8eBlH0+aIgbTsYUEerCLc/NIiR2KeAmd3Pe
         H7aMaeTCNgAVbNZ4ORK6kd6bThjn8CuKKAbq1YlwqXDbLuZoqi0ZVZ8HDhc4QZzjTT1s
         E/GEUwxgVU02P0YHHIRpfA6qVs8Wh1mKL5caCaxm0aFWH5s+H6PEwZJsAEbWUCIRcpqf
         /Cd58m6JKyPJuAek5BsK4Ac0Z9OzI3m13iKg9lMvHwUbkr4ZXlKvR9GGCu67jMD695Sw
         eMjA==
X-Forwarded-Encrypted: i=1; AJvYcCVj7BbaQa2r/AxV65yXb7ojz29EIg1gSRRZgsp1hWeF04okQaQpvvXwW7cKzK4wfCIn340NYg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6/Zb90OKRfs/nKsUOzd3SmW84li3MtHzZ10ywY71rzl21qHzU
	vtVXUpFt6oPLbZtBTMuWdLDxuFU8sAJgr8UvncFG1XXeB3IhDPnSl+u+7KLtudu3Y0hMjETzgPl
	J3Y9H4vKZpJrSHX66bw==
X-Google-Smtp-Source: AGHT+IGeUFjJTWpK4QjhVVj4506qhZmgM6+vP3bTkcGXoNreK6tGzf61M1Gbm1yeqL/C/F63sl0IwvGvOY21BMKy
X-Received: from plof5.prod.google.com ([2002:a17:902:8605:b0:21f:56e1:c515])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f548:b0:21f:b483:2ad5 with SMTP id d9443c01a7336-2264993273bmr61032515ad.20.1742435781232;
 Wed, 19 Mar 2025 18:56:21 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:48 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-14-changyuanl@google.com>
Subject: [PATCH v5 13/16] x86/setup: use memblock_reserve_kern for memory used
 by kernel
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_015623_570465_EF064A41 
X-CRM114-Status: GOOD (  13.80  )
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
---
 arch/x86/kernel/setup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..ead370570eb2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -220,8 +220,8 @@ static void __init cleanup_highmap(void)
 static void __init reserve_brk(void)
 {
 	if (_brk_end > _brk_start)
-		memblock_reserve(__pa_symbol(_brk_start),
-				 _brk_end - _brk_start);
+		memblock_reserve_kern(__pa_symbol(_brk_start),
+				      _brk_end - _brk_start);
 
 	/* Mark brk area as locked down and no longer taking any
 	   new allocations */
@@ -294,7 +294,7 @@ static void __init early_reserve_initrd(void)
 	    !ramdisk_image || !ramdisk_size)
 		return;		/* No initrd provided by bootloader */
 
-	memblock_reserve(ramdisk_image, ramdisk_end - ramdisk_image);
+	memblock_reserve_kern(ramdisk_image, ramdisk_end - ramdisk_image);
 }
 
 static void __init reserve_initrd(void)
@@ -347,7 +347,7 @@ static void __init add_early_ima_buffer(u64 phys_addr)
 	}
 
 	if (data->size) {
-		memblock_reserve(data->addr, data->size);
+		memblock_reserve_kern(data->addr, data->size);
 		ima_kexec_buffer_phys = data->addr;
 		ima_kexec_buffer_size = data->size;
 	}
@@ -447,7 +447,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 		len = sizeof(*data);
 		pa_next = data->next;
 
-		memblock_reserve(pa_data, sizeof(*data) + data->len);
+		memblock_reserve_kern(pa_data, sizeof(*data) + data->len);
 
 		if (data->type == SETUP_INDIRECT) {
 			len += data->len;
@@ -461,7 +461,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 			indirect = (struct setup_indirect *)data->data;
 
 			if (indirect->type != SETUP_INDIRECT)
-				memblock_reserve(indirect->addr, indirect->len);
+				memblock_reserve_kern(indirect->addr, indirect->len);
 		}
 
 		pa_data = pa_next;
@@ -649,8 +649,8 @@ static void __init early_reserve_memory(void)
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
2.48.1.711.g2feabab25a-goog


