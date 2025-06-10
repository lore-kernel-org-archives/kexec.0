Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697D6C71133
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnvvyP7dCHsR831/wdjfM06oCMly+UIpE3b1dFgZYy0=; b=Quqk+oByhq4hht402dvrGfNd/t
	I9eEYC0oGEE0vj87tvjFcBazxDs0b/fYDBvPM6Otg0KPQSYF/kESy1TPBK+MuGHJ50IVZDjw+rVbD
	ijLrkQR+aAadiPu1Tz4s5eHYZtQwTYVZ94osClSiHqusXXhR3UnGFaXq4P1Jv7TtER9gOwooKzA/H
	rTaA3TdpTiV8554LHZHxMIRC9J1oZlu/QgeP+wNco0Bmd983wb8guAyuCi1TL1wy0Q44m0X/Aqddh
	f53VuZKD6/iCYvahEPGyQEjcWsjNzpKwSv8oZmN+t5wqCCpkmBIK0QNPrb95A0qPPVbiZ/MdRHmIW
	U303hJIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwf5-00000006YIR-2lgD;
	Tue, 10 Jun 2025 10:56:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvlz-00000006QmA-2qRZ
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 10:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnvvyP7dCHsR831/wdjfM06oCMly+UIpE3b1dFgZYy0=;
	b=KY0UdUShlnKjmFRNLzhcNw9KTIz5A1g5dDzCIaBFZ3BZWjEY3s9WBqpyBeoh4iiUWh7SeT
	sxADm6hK4bt9FcncXqSQW1AhwawAwClFgZBTvjUWcbBjdIBkQFvb1k/358TlLzOvZ2Y1MY
	qtjp8Qb8owh2VIwWA/gHuNXKJaKSZR0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-z_uyqtLMNqeILOHoYoqOOw-1; Tue, 10 Jun 2025 05:58:32 -0400
X-MC-Unique: z_uyqtLMNqeILOHoYoqOOw-1
X-Mimecast-MFC-AGG-ID: z_uyqtLMNqeILOHoYoqOOw_1749549511
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235c897d378so49957895ad.1
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549511; x=1750154311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnvvyP7dCHsR831/wdjfM06oCMly+UIpE3b1dFgZYy0=;
        b=q4oaIN9ijwf1d/xHe/v5xkJ6O6Is1ezzjxJUDchBaun4SYaW64Jh8l9Boppi+bPFT2
         TxEwA51M4ROUIlM48JiDq8UHsKZrqOfNwbobA9Y5SwncNz4qkvzQ8sQ40FN8mQN4IcFN
         fmFRDuGgdnjMA5td0mf0wpn3lVRYyTISJRDvB9WW9pXQpK7YkQ4WKGbGfcxqGJT7YCVN
         jLI+4khrhkf92GHWwJiBBpGWnbkmEN1S2vSBvaPiBPOla0mAdaJIPkKR0nP16riP8Gjw
         DVdNG5y3KGFjVbpWE7VqXA4WW5rmIniekEw6yjqIwEsh8iCfD75GkrDyzItOVdL79+qu
         /Lgw==
X-Forwarded-Encrypted: i=1; AJvYcCU8/74O38Zt0v/yXsOduExCciJPsiRjtLQQ7ZJKiHUDkcr0j098hwX7AQ9RKo9EThemVnbnOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDw2XguY9NvjExGqedXQ7IxATbTeY8S9nuRt/8g1KDvTz5L5Lr
	tkLJM25UvlYZDcmBWOzBz/HdOJC0Ylt4g61967oc8/vgC3R/N845JC2o+ti/aWqm/41caJGXsQh
	0B/pMDZ9WpR1qmihj8P2UAths8NbXNUcOmoELmZeLCWBLwF9Zn2xw7HYlk4diiexevnSvYg==
X-Gm-Gg: ASbGncvJMwgEZ9tYY+xRffCYajUwiMj2Fyi2OtLY/4jSsDhQTCpdz43xixNUfpVP+JV
	knvtL5hHAIduZtRvgtHjqTBYQmd02CUM8U1hJllV3DXPnlngnPlL2qsMYlsjEwEushdGFUKf4Fu
	By5Jdbivs5c0aqn+dH9FvkrUf8amBwnssAFVBkPEXQ3PfEvzMbPO6F9++t2VCGLmWZ9gdbIk/6s
	cilO4WVyQnOKR5rVk2AhSMcESdur89nGtlsOc/GmbGyAjm+hQSF4JbaGUq/RJbMuvXpt4im+Mlq
	XhqF0IBQDuRKuUcav2BEpdwz3kttP0Q=
X-Received: by 2002:a17:903:41d1:b0:234:e8db:431d with SMTP id d9443c01a7336-2363830aaacmr25632385ad.20.1749549511274;
        Tue, 10 Jun 2025 02:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsjlzfkkIZxefQiCXu8WYIgI6AZeZlBQxQwVBHR1uo93ATWwEoNI3Wsg6V6PWskKdNYHXn0A==
X-Received: by 2002:a17:903:41d1:b0:234:e8db:431d with SMTP id d9443c01a7336-2363830aaacmr25632165ad.20.1749549510924;
        Tue, 10 Jun 2025 02:58:30 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:30 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 10/10] Introducing 2 eppic scripts to test the dwarf/btf eppic extension
Date: Tue, 10 Jun 2025 21:57:43 +1200
Message-ID: <20250610095743.18073-11-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s4cbdAd3E25mpWQYqG2zUO0bqBjd2EO5XPn9iYyPfQs_1749549511
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_030003_787530_C0BED503 
X-CRM114-Status: GOOD (  14.91  )
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

This patch will introduce 2 eppic scripts. One is for filtering out amdgpu
mm pages, the other is for printing all tasks VMAs. dwarf & btf eppic
extension should produce the same result for every eppic script, mainly
for test use.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 eppic_scripts/filter_amdgpu_mm_pages.c | 36 ++++++++++++++++++++++++++
 eppic_scripts/print_all_vma.c          | 29 +++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
 create mode 100644 eppic_scripts/print_all_vma.c

diff --git a/eppic_scripts/filter_amdgpu_mm_pages.c b/eppic_scripts/filter_amdgpu_mm_pages.c
new file mode 100644
index 0000000..2936a54
--- /dev/null
+++ b/eppic_scripts/filter_amdgpu_mm_pages.c
@@ -0,0 +1,36 @@
+int main()
+{
+	struct task_struct *p;
+	unsigned long p_off;
+	int i, c;
+	struct vm_area_struct *vma;
+	struct ttm_buffer_object *tbo;
+	unsigned long pfn, num, mt;
+
+	p = (struct task_struct *)&init_task;
+	p_off = (unsigned long)&(p->tasks) - (unsigned long)p;
+
+	do {
+		if (!(p->mm)) {
+			p = (struct task_struct *)((unsigned long)(p->tasks.next) - p_off);
+			continue;
+		}
+		mt = (unsigned long)&(p->mm->mm_mt);
+
+		c = maple_count((char *)mt);
+		for (i = 0; i < c; i++) {
+			vma = (struct vm_area_struct *)maple_elem((char *)mt, i);
+			if (vma->vm_ops == &amdgpu_gem_vm_ops) {
+				tbo = (struct ttm_buffer_object *)(vma->vm_private_data);
+                                if (tbo->ttm) {                                  
+					num = (unsigned long)(tbo->ttm->num_pages);
+                                        pfn = ((unsigned long)(tbo->ttm->pages[0]) - *(unsigned long *)&vmemmap_base) / sizeof(struct page);
+					filter_pages(pfn, num);
+                                } 
+			}
+		}
+		p = (struct task_struct *)((unsigned long)(p->tasks.next) - p_off);
+	} while(p != &init_task);
+
+	return 1;
+}
diff --git a/eppic_scripts/print_all_vma.c b/eppic_scripts/print_all_vma.c
new file mode 100644
index 0000000..e8e49c2
--- /dev/null
+++ b/eppic_scripts/print_all_vma.c
@@ -0,0 +1,29 @@
+int main()
+{
+	struct task_struct *p;
+	unsigned long p_off;
+	int i, c;
+	struct vm_area_struct *vma;
+	unsigned long mt;
+
+	p = (struct task_struct *)&init_task;
+	p_off = (unsigned long)&(p->tasks) - (unsigned long)p;
+
+	do {
+		if (!(p->mm)) {
+			p = (struct task_struct *)((unsigned long)(p->tasks.next) - p_off);
+			continue;
+		}
+		printf("PID: %d\n", (int)(p->pid));
+		mt = (unsigned long)&(p->mm->mm_mt);
+
+		c = maple_count((char *)mt);
+		for (i = 0; i < c; i++) {
+			vma = (struct vm_area_struct *)maple_elem((char *)mt, i);
+			printf("%lx\n", vma);
+		}
+		p = (struct task_struct *)((unsigned long)(p->tasks.next) - p_off);
+	} while(p != &init_task);
+
+	return 1;
+}
-- 
2.47.0


