Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C5FC47BD0
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZgrTjb26V9hHLjA734rJjLqTVSsFQ/64lxp+Kz3lkM=; b=DQbFtGH9/6n0/ZO8a93CGOPs5K
	glLbD0apJth5w2EpFpW3WBvxFs1khs//qErAk5kS5gIguehLQvNdE5uaxzcJRtAMaiVov4CzsfZMF
	Egk2DNygjpDxybDmnOrpkIcsn26RSuhK9gxvANT5//LENAHNdCaQDOT8wZp0icLdODtJQfdi6TKb1
	fINMCRqVghgoVR7D3zr1LPlrJaSzWh6bu3JdrqDAYRs3vju3iFogo1E+23eFbl9rJoaO0QaQHN67M
	Fx9tTL2M9jYBYQwxc8Yf6OPcxmPdNRCZSQxFdpgadON9PLymuhJ5ykQKm6ARm/l9658TQujuQ6Op0
	uXQMKOuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd3ij-0000000Ck1M-0EAa;
	Tue, 06 Jan 2026 09:51:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd3iZ-0000000Ck0D-2gMM
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 09:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767693070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZgrTjb26V9hHLjA734rJjLqTVSsFQ/64lxp+Kz3lkM=;
	b=B9ZkORU/pSObTviFZPEZmE7E7KdzuHSLf5ZYLPTnIpoa2gDpq6FHtByCIqZdcJ7Gk1JdOM
	NyfmGLjqWtrKPAaFO0Xg/bxrVtFwOpdyfTvPbiHlr/pqn+jI3PH9jx5zbw6wZdPwdBkYqH
	RUeDHwkLaymuxTtu2Rpr/8Vzyhe2Qys=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680--lVcNnvRM_qnKAzyvZAjDg-1; Tue, 06 Jan 2026 04:51:09 -0500
X-MC-Unique: -lVcNnvRM_qnKAzyvZAjDg-1
X-Mimecast-MFC-AGG-ID: -lVcNnvRM_qnKAzyvZAjDg_1767693069
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0fe4ade9eso10826885ad.0
        for <kexec@lists.infradead.org>; Tue, 06 Jan 2026 01:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693068; x=1768297868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZgrTjb26V9hHLjA734rJjLqTVSsFQ/64lxp+Kz3lkM=;
        b=wifTjSGakld+tjHy791ksIqBHteFqvPawOa5/d+GoJmxZp3E7rWqd9T1GzvFZQIZkB
         n/XS3QfCBEY5o5PyoF2R3qviGbTXmlLT4V31KJJLdjE9q/0BDVY+bFNHtcISgmXvvCq/
         Zyj6J9nAbhFKWrbPjDxMLLQxDyOxGk0sxx25OXTmczMkcQ3PZWn1TRquT5HUymDFixNX
         DZ3ysFlQKipkPczuQ/vr4ot/gpK52n/y5vULKoqe4Ih2ZsatpgDqKa/Ilq+jG0z1JQeQ
         KBNygLNOrGj1AtprfDJe0WyoGk+CeZENefDid5cFFxoo0NLVQfFSwkHIf/N33XUnM7xq
         kvuA==
X-Gm-Message-State: AOJu0YwqqwHhEKNZ96BjLw2JwFgfsUQSPpkClM7Ug3uwgN5sKpGVQ3E5
	KlBQkhh3x8Pv8XH+0d+OcLnpl/vrqJCII8/fL598xo7WtZLtYpRBaC6lpnYkw6A4I1Z1kdZ860g
	4XKX7V+1wz8duxwjWY7MgSUM5DuCtJfGFoxJ4z+uhtam8V9sV3DQS7YCoJGXEL3wX0EwDeyRS3+
	a5OyOlXz6ug/RysLUxqT6LBaVWbWPaCto8QZmHmcp1cu0=
X-Gm-Gg: AY/fxX4a2gLtndySbJBvtaujmf6hPsYyUIqJmWT/K/GOC8AC9H7+C/r3DEBUP5iJCaw
	r1vxnVLhHHGLSk+yG03poivN0Z+XlQidEeD2thzTapHb+ytSIaI54FIcvD9JtnU3Ch6fC5UOrXc
	wgLqzWuHDHvlRGiuy7CPqT9riabkzLa5658fSszPJow16iJlBy6yPPIglvdiwd5DCP6tSlvhiaJ
	bKfbqyRIFSmTBgJ7/FitFuWQnfWGeWua8vYNUmTGTF+Q7CBXcKRIrrcNtdjCYl3dYB3X8rChKON
	FkyF/3cnednrV+7m2cbHWFw8ZG9iA/nr4kp+jATrE/rH5g/ds+cGgU/SZ4igRvCn7+MInxN918S
	i
X-Received: by 2002:a17:902:f685:b0:2a0:d629:903f with SMTP id d9443c01a7336-2a3e2c8e298mr16968025ad.9.1767693068394;
        Tue, 06 Jan 2026 01:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8NbRx4BSQbdF0wpyEd4iUJI5Lk3MVNn58sSFSHtDOCxUKIVyXD4gxNvJ9dtols1xg/4FT+w==
X-Received: by 2002:a17:902:f685:b0:2a0:d629:903f with SMTP id d9443c01a7336-2a3e2c8e298mr16967745ad.9.1767693067731;
        Tue, 06 Jan 2026 01:51:07 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e755bsm1664799b3a.48.2026.01.06.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:51:07 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 2/2] Reapply "x86/mm: Remove unused __set_memory_prot()"
Date: Tue,  6 Jan 2026 17:50:59 +0800
Message-ID: <20260106095100.656292-2-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106095100.656292-1-coxu@redhat.com>
References: <20260106095100.656292-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WhRHsqocgt0l0X0-ACsWv4RVVE9v7rISQySQ3oN1tbw_1767693069
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_015113_444373_CD752946 
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

This reverts commit e1e6cd01d93359e22be84a23c8bb24ee4e04e142 as
__set_memory_prot is unsued (again) after set_memory_p is used instead
for x86_64 kdump LUKS support (CONFIG_CRASH_DM_CRYPT).

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/include/asm/set_memory.h |  2 --
 arch/x86/mm/pat/set_memory.c      | 13 -------------
 2 files changed, 15 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 61f56cdaccb5..8d9f1c9aaa4c 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -4,7 +4,6 @@
 
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
-#include <asm/pgtable.h>
 
 #define set_memory_rox set_memory_rox
 int set_memory_rox(unsigned long addr, int numpages);
@@ -38,7 +37,6 @@ int set_memory_rox(unsigned long addr, int numpages);
  * The caller is required to take care of these.
  */
 
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
 int _set_memory_uc(unsigned long addr, int numpages);
 int _set_memory_wc(unsigned long addr, int numpages);
 int _set_memory_wt(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6c6eb486f7a6..40581a720fe8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2145,19 +2145,6 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 		CPA_PAGES_ARRAY, pages);
 }
 
-/*
- * __set_memory_prot is an internal helper for callers that have been passed
- * a pgprot_t value from upper layers and a reservation has already been taken.
- * If you want to set the pgprot to a specific page protocol, use the
- * set_memory_xx() functions.
- */
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot)
-{
-	return change_page_attr_set_clr(&addr, numpages, prot,
-					__pgprot(~pgprot_val(prot)), 0, 0,
-					NULL);
-}
-
 int _set_memory_uc(unsigned long addr, int numpages)
 {
 	/*
-- 
2.52.0


