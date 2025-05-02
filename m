Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9998C3ABB5
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 01:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Pn26aT5bRv7h7/lzXPUF6z8FjJ6lnc7HN2JWKay0EY=; b=0E+jvqYm20luggqn5A9nhejfYe
	4ckyZowo6fYrWBH3rzqkJypXAL/1w/RgEhmNCHyV2W5Bhog23U+7yT8uzN1gfTzx60WdbU8fVsb9K
	omRdZXaN9GTWST1m7J5Q9M/6jZaSrlWpppXh453++YKNh+WfQ03jpdXgUl2XxPRKHk7XqEQzrQUSj
	drQIbJC7bSPxabsMxccQhXJGIZP/RigLYM11ITSFlbd5OvPXQRUeTYd39FixojzNre/WCRRWu3/pc
	WgeYDhr80148LbMyv0irisaJPGeoCzXbbActFouZt/Z11fV7rpTaM72f7xiCnSO9xjOp8MD4Y7I0W
	xnTxiRKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAf0O-00000000UIf-2jcl;
	Fri, 02 May 2025 01:15:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAexu-00000000Tgv-1gfZ
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 01:13:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746148401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Pn26aT5bRv7h7/lzXPUF6z8FjJ6lnc7HN2JWKay0EY=;
	b=LpVQZ+CEvDXqJrpP1u5k8WZqy7mgrFsh2ycEh8OGkV/RT+QuNZE95amJkB6U5vc4cMFJBt
	ZIzDvWL5y3FysN1FOHyF18unBiF62/Cq5y9SG+8Kos22S+SlgJrGUOJj0gS2wm/T3PeSB2
	+ve4+kxan4CtDcBHTxrCSIR5PaXA2Cg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-ZBaInkCmMRa2pzABZSQnyA-1; Thu, 01 May 2025 21:13:20 -0400
X-MC-Unique: ZBaInkCmMRa2pzABZSQnyA-1
X-Mimecast-MFC-AGG-ID: ZBaInkCmMRa2pzABZSQnyA_1746148400
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af5310c1ac1so954141a12.2
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 18:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148399; x=1746753199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Pn26aT5bRv7h7/lzXPUF6z8FjJ6lnc7HN2JWKay0EY=;
        b=Rw3o82b7C50ZLZjGh1XFhSqMV1QvvGF423SlKhUJfSIjtYaWAI+huEJIqIPI2HSwVf
         r1D0cM7UEqOC1jdNcY6JBX+8kH+L3mBqeFVCNiJqvwWd9Bw3PMwqwZKTggIj1w6twPWI
         9G8ztu3BzWAob6E+BVfSu457A3GKhCChQnIHpgiJweZj3+d3np6JFlIlUSYAgoOxfL0o
         gqAmg+OHIk5d0Otc5lmyFUiEn9Yl5goBhNzez+DDtGijzYgGU6oOKcCV3X9pSmyKILpb
         3+BGCEXEamtEI28dUl3a9hkrwVLgbjeY7dm+snD2gEQaEK3qQWz8qqdEl/hxoyN61rar
         wgxw==
X-Gm-Message-State: AOJu0YzE9kVp4MZhDcHz6XrvVCDSHOncKBHsLgG58ywzykByEldJZieP
	grSpn4XV+DZ7qZ3ol8DySAfxiA90EMjyjYWN0K90divQVJQAkeQ8d8H0oL8BPcMfHvBFFswRips
	/CLgv9iokQ1oOPtFcLTQQp4LiO7gTjDCYUFjDQ6dvhGg35NEb8ofHwQl+0CVHV9wAVOp2MMCTSv
	yRdWW+XC/hLFl00AGVbhlNHlWfBGE3OQQiXbzCyPlYqw==
X-Gm-Gg: ASbGnct68HWEmjrWfN2qTFZ07o7EAVa1exQEFftBPva3GZO+FI5mrlWptUHMmDYZBp5
	M6qJUqylHgSaRm154sBgV46VwXnIt97cM3DtqDqQvZc/X99oCfN5XvkG1Xyi1S5yWnedPzLJk2B
	89QFMGpdysGnsHuDlhciMEoCmsQaGw6TFFOVugX9ZPBY9dBvzsb7r1CEgunlZPUbyPV+tGpw1q1
	lM8ElttsRly6Fy55FAjaB4FmGxr7SgKINjJnxxv2p/MJsF4RHS5MWOXjYj5Syt909tXRSO8lrAp
	Ds8=
X-Received: by 2002:a05:6a20:9f90:b0:1f5:7c6f:6c8a with SMTP id adf61e73a8af0-20ce03eda59mr1482263637.35.1746148399546;
        Thu, 01 May 2025 18:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5/p3+2eDOQ1WtTewaJNj1PvUOiUHyS/8lpdnWABtDfZb0/NmxZiqOwhxRTW3nf4iHj2YNpQ==
X-Received: by 2002:a05:6a20:9f90:b0:1f5:7c6f:6c8a with SMTP id adf61e73a8af0-20ce03eda59mr1482208637.35.1746148399137;
        Thu, 01 May 2025 18:13:19 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa82422ebsm309280a12.10.2025.05.01.18.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 18:13:18 -0700 (PDT)
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v9 6/8] Revert "x86/mm: Remove unused __set_memory_prot()"
Date: Fri,  2 May 2025 09:12:40 +0800
Message-ID: <20250502011246.99238-7-coxu@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502011246.99238-1-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9y4Hp_R4Sq47oegMyO_c6-veU-uJfrUVNc1k-QUWyRg_1746148400
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_181322_507711_63386E43 
X-CRM114-Status: GOOD (  11.20  )
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

This reverts commit 693bbf2a50447353c6a47961e6a7240a823ace02 as kdump
LUKS support (CONFIG_CRASH_DM_CRYPT) depends on __set_memory_prot.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/include/asm/set_memory.h |  1 +
 arch/x86/mm/pat/set_memory.c      | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 8d9f1c9aaa4c..023994fe6115 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -37,6 +37,7 @@ int set_memory_rox(unsigned long addr, int numpages);
  * The caller is required to take care of these.
  */
 
+int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
 int _set_memory_uc(unsigned long addr, int numpages);
 int _set_memory_wc(unsigned long addr, int numpages);
 int _set_memory_wt(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index def3d9284254..df7502ad165c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2148,6 +2148,19 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 		CPA_PAGES_ARRAY, pages);
 }
 
+/*
+ * __set_memory_prot is an internal helper for callers that have been passed
+ * a pgprot_t value from upper layers and a reservation has already been taken.
+ * If you want to set the pgprot to a specific page protocol, use the
+ * set_memory_xx() functions.
+ */
+int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot)
+{
+	return change_page_attr_set_clr(&addr, numpages, prot,
+					__pgprot(~pgprot_val(prot)), 0, 0,
+					NULL);
+}
+
 int _set_memory_uc(unsigned long addr, int numpages)
 {
 	/*
-- 
2.49.0


