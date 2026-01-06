Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52014C47BD5
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1VAthTqfFeFGWMBFAfA704DCQEXxs1WMWSw2j401xyA=; b=W4/H9iP8Pmy+I4nCcBfOi/BGbZ
	FekfvCZVhPNL00sEF1EZ8V5LZrZZGzsbEP2X/8BVNWM/8Cf32WT9pLTCcUxlTOR559H4LWw28rUmg
	2aoTh2UHExCmqQE22r2VHWrErj+e15yTIPkXJpi56yKZLuqbTuiLS/QIJAexg5WoSsHiiAMxGM3jM
	Xqva1fDmWkEssToGhfa7yAbFACMyK+aXcFgwttUwx2+uB5+ftCc7gN3lE7rdiYxTEUOewQ5PejAeB
	fPjCYoB6GulA0SGMCCe42moIPrM1jUWSa4adD4Qu77Hd4p1jMZVkfseiaOB3+aIVTaBxghNmCxMbc
	HUjnXFvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd3ii-0000000Ck0V-3K8m;
	Tue, 06 Jan 2026 09:51:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd3iW-0000000Cjzj-0giC
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 09:51:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767693066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1VAthTqfFeFGWMBFAfA704DCQEXxs1WMWSw2j401xyA=;
	b=SSym4jk5e2hqTbXU2sRnex29Z8DDeoTK7jo7xx+cnOURbvWN9u8Cn2bMmk1JpqH63r/Oi0
	siuzQv322Xssb2ZPO9SBPV+vnYl2l+8cideIwqXrO8iaQUgFEg7Npt1jkkWBBG9XcNjrkt
	Q66tTf2xAkS/TwpbLkZT6zC4e9rNo/o=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-imf8gJbuPUa4JntysOE-Ow-1; Tue, 06 Jan 2026 04:51:05 -0500
X-MC-Unique: imf8gJbuPUa4JntysOE-Ow-1
X-Mimecast-MFC-AGG-ID: imf8gJbuPUa4JntysOE-Ow_1767693065
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7dd05696910so1229417b3a.2
        for <kexec@lists.infradead.org>; Tue, 06 Jan 2026 01:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693064; x=1768297864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VAthTqfFeFGWMBFAfA704DCQEXxs1WMWSw2j401xyA=;
        b=dGU6kn4UKxeW8ZZLI0tLYvwFBeAw1fdG8eozwzyOGFK+CU0NuVrQ59bzr5/V3s3dcB
         lgX3gTGC7aot42JJSG7yBZyeJLdojvN2jFSYKUxOjmyQ+bm9DPpsTF7AFRmnqiMYsXUt
         bKdG6HvEf7U2tSyYDX7hvr89RE/xKZ7+bGB5resdqI8g5l08uGtp/Hh4RcgtpjLOYJY4
         WeUAOyu9LTTptAjW0Rx1MBRwJWg1zYGeuh8TNbG6aa804dbZy7xd+YFcF/aLQ4e8uAf2
         RFNNAyznLKMHxLL7Ey+J6lfZV9xf/fgai725tvL1y0fF47aKJc0Ma4YKpkPmj3vq/L21
         Pu+Q==
X-Gm-Message-State: AOJu0YzqFtmlI6yVAEF6U9D8XN8lFPGptzdNojG3YQcZRqTtZa0xXgLF
	duWvrOTSWgUjnmlHHMyBu3akvM8rMOa54ZknPwPRTYWRa1/zfCkJMXuHmlaVCBJ0Opy2mIBx+Vs
	js+dF2RTsPDucLh1hILkM11cRD7sHOZdwmCAeiVVKS3aD+yGFplD/mP49vK79HOTSlhZv3L8Sqj
	y9FLfSn9oliwyXOVUtzWsTIvM24aKOLjC/LzpnIDK+S4s=
X-Gm-Gg: AY/fxX6RpVoSN7bY89CnselK1uviz2Kfmn8bCDPht66bW3/TqPVzcVoA83JWDBhuP1F
	7u3TZH7suSuwb1gGzFQ82VqKJsRWeAW09z2WTbA0x933Yoz2VcWBZQToBQWcAQPS+ivr612A8yP
	2+QTSfjo1IkquagCWa2nKkIhWvz9PULNC3ztNV/CiB9w7ceB14xFY1wDRe2rUZj4slGCH05Nuzx
	te5WDZGgRfsxwKlkG+oLG8o8c64i7vXNr1TXeMej8mZoiPd4MfJi5ljlD4qu1618jScorIWc+dz
	/IV70HjeaUeBDR904MztBVjTWB9gDPF7BBda0q/+FbzRFjdLBEayXISeAq8w3L9EVVHMBa/O021
	C
X-Received: by 2002:a05:6a21:99a9:b0:341:9db0:61f1 with SMTP id adf61e73a8af0-38982240e0emr1899660637.16.1767693064292;
        Tue, 06 Jan 2026 01:51:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW6UciVCI9w9mQUigR54W6222QfqtLANzt59XYt+mRd6KxY8zOI3U/iWfxx4J5aahqo2YANQ==
X-Received: by 2002:a05:6a21:99a9:b0:341:9db0:61f1 with SMTP id adf61e73a8af0-38982240e0emr1899640637.16.1767693063637;
        Tue, 06 Jan 2026 01:51:03 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc9e7e8afsm1868963a12.29.2026.01.06.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:51:03 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 1/2] x86/crash: Use set_memory_p instead of __set_memory_prot
Date: Tue,  6 Jan 2026 17:50:58 +0800
Message-ID: <20260106095100.656292-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fYBGt7CtAf1ZAXS9SfAUxkPZWXNWcOyB2rbzXTzcUaM_1767693065
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_015109_333289_3684C7D7 
X-CRM114-Status: GOOD (  10.65  )
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

set_memory_p has been introduced since commit 030ad7af9437 ("x86/mm:
Regularize set_memory_p() parameters and make non-static"). There is no
need to use __set_memory_prot.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 201137b98fb8..0590d399d4f1 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -673,10 +673,7 @@ static void kexec_mark_dm_crypt_keys(bool protect)
 		if (protect)
 			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
 		else
-			__set_memory_prot(
-				(unsigned long)phys_to_virt(start_paddr),
-				nr_pages,
-				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+			set_memory_p((unsigned long)phys_to_virt(start_paddr), nr_pages);
 	}
 }
 

base-commit: 7f98ab9da046865d57c102fd3ca9669a29845f67
-- 
2.52.0


