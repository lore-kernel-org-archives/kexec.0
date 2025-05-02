Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2067C3ABAA
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1fPDWAlkRpZFD9IGtL8ncnibi+0RTZDXokax1ZHMC4M=; b=Kz1CnPC1V2LB46t+E+HrqPL3Y7
	83uyyHwmm+FSoI4K++eSrfdr0YdP6KjakWUVKVbD2BFV4aGfUyckZpxjc4Pmru0JU0G87+YAg5HhC
	zkIit+BgTfUp2Z9xuN7ccyL5c6gZvJAJjH20XDkf4+eu5po6sY2XfYFPC5CVyKJzsjzuz4uJ14ZoB
	UrKgwB6ISBA1XtTySIg3KCpuS6cEP6DchVBs5cyuddc21RMKnyx9ZIKd7G+DjSR4lPlJZwtIR3P22
	SAkEuRB+y61UZuPngNWfCYia0o0zdY93v4Dkjkl6me5QuIXJ2efihCKpgPBqr6aTkG6TBHFTDeKd4
	lgjEWXxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAf0P-00000000UJs-2Vll;
	Fri, 02 May 2025 01:15:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAey2-00000000TkA-16SD
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 01:13:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746148409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fPDWAlkRpZFD9IGtL8ncnibi+0RTZDXokax1ZHMC4M=;
	b=c/Akr2Xyq+9D1Mdt5jPfPHX3uqDo571JGUZoW+W7VC3Jr4FqgiOwRQUSpfZrfMo4eA3rWK
	NkBEUqGJ0HAgnxdhRUai+EGjC+tXRbP3CpwrqR3BqIPgbZBjQi+gqEuWwQJnz6BleDfVs7
	3vz92a2ynKIJus9LRI42u/FIBKs7ySU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-3wEjnM-2Nq2bKTaDyCN3kw-1; Thu, 01 May 2025 21:13:28 -0400
X-MC-Unique: 3wEjnM-2Nq2bKTaDyCN3kw-1
X-Mimecast-MFC-AGG-ID: 3wEjnM-2Nq2bKTaDyCN3kw_1746148408
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227ed471999so13439755ad.3
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 18:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148407; x=1746753207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fPDWAlkRpZFD9IGtL8ncnibi+0RTZDXokax1ZHMC4M=;
        b=DArKRsG5qjNR7/PlUdQ5biLBYfR1qPMQFUwUYv8rxAxds4RBeH5UVfkZDjJeLojtEx
         nZ83Wuv2Gby35ohqaIaNWMmHNjM8MZkHoQuxK+ywk7B0Uajr8fIhVTkW/dheJaa8AdNm
         lGEwWmiB+puwk+otF5wkblch2VpepJUfM1rqh+KO5aPa9iCIfG5dAv1VsTSNVUkuMpah
         VePPi2Svr7UzGgzLG7x+rzd4nekphcpljBDX8xSf7n7jyO+L3qBnys0WqkthSjLB2zsE
         yCMsArBtAfLOwL284JjK0gWjWfXhEDOWeMY2Ad9OGMuCln8T5h6kLsyYrS5NmXxLvjOL
         adjQ==
X-Gm-Message-State: AOJu0Ywxo4G+6OGhp+mfa6wFjDoCMt9UB3yYzAPQZE7HTqwrioKVwubi
	Qe114zZ946vtsnRGBnkRhJ2TbougZqlwwZExTfde/iN/ih1aRJIZktF4+203dHnFsOlU6HXVggj
	msLfDSVa1TZaEQpIC0Xl0BMfsc544/iIzIxRcu0mofx8db6YrTW1kMRUg/YCRfixM84IQCbAFeH
	u+4zQnTdrrIFrVufxR/CjUEeOJdRjVDTOgvZDF9k3XTg==
X-Gm-Gg: ASbGncuKK3LQaBKMN3ZaRYzJSPsxXroWk6vQ79EUt7q8XO2eenv+Mjb0H8YW0kGr5fq
	DVScD38Bqgd2XaaJJX+VT+Sli3/4ec9efyHdfzCGWfPtbauLxNYNZhsFdDqgZMaX2qME3famPDa
	V7PGIFg7GG3BG4dEOEbtN7b8AGpEhGCs5D5ZpyZBLEaDepqoZofdYFmugyoxK4NRqi8dV/wdCgF
	kjg5pd9LwS+c25cmsHn9gJ4Ozg9TdnctsCg3XQgjNw+JR/iZxoMIytEl5x4dUHePLuY/PcGEHO6
	UTc=
X-Received: by 2002:a17:903:1aa3:b0:224:76f:9e4a with SMTP id d9443c01a7336-22e102d01ebmr17984595ad.14.1746148407501;
        Thu, 01 May 2025 18:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvqxKF7gk97Lr8Vh32QR8SR5Scmsb6rcwbgFjb7HlkZaRVa8Vb6z2gCQMwaiziz7TBRlXfgw==
X-Received: by 2002:a17:903:1aa3:b0:224:76f:9e4a with SMTP id d9443c01a7336-22e102d01ebmr17984105ad.14.1746148407121;
        Thu, 01 May 2025 18:13:27 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a476267e0sm1603716a91.39.2025.05.01.18.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 18:13:26 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v9 8/8] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Fri,  2 May 2025 09:12:42 +0800
Message-ID: <20250502011246.99238-9-coxu@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502011246.99238-1-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t3yiBh5Y7IM0vFs_pmFfGJtVjz89VwVq5QkNZ74y2JU_1746148408
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_181330_372185_1484BED1 
X-CRM114-Status: GOOD (  12.26  )
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

This adds an addition layer of protection for the saved copy of dm
crypt key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a68f5a0a9f37..f615fcb6d35d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -598,13 +598,35 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+/* make the memory storing dm crypt keys in/accessible */
+static void kexec_mark_dm_crypt_keys(bool protect)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->dm_crypt_keys_addr) {
+		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
+		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		if (protect)
+			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+		else
+			__set_memory_prot(
+				(unsigned long)phys_to_virt(start_paddr),
+				nr_pages,
+				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_dm_crypt_keys(true);
 }
 
 void arch_kexec_unprotect_crashkres(void)
 {
+	kexec_mark_dm_crypt_keys(false);
 	kexec_mark_crashkres(false);
 }
 #endif
-- 
2.49.0


