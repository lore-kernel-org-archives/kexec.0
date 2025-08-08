Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E920CA0EC0
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yc1Ft/b3qye0Nn2AQUyZWguJ2koiO3eAJtJCginIFUo=; b=2rYRFE9Te2UF5quR/1spyzPyz/
	XFqrUC+a2oyTMhXP00QtkJ0VJMpi2MMsXD7gCJ1Vmj08fjXzz07DNId9bV8fN+0lXN2cRmDm5d9hz
	clL2BQGM6wKx/WpF/07qGPux5DSopDB3+ddC50GJ8Fn9+2+QTJrZnWEBE9dw932oato9P0aqxq1FY
	pWw2oPL9caUTi2HK1JVG8eibpGilJhWOWDbeWo+nZ90MwkFpukeSnYyeQH4TziOI8v+T/J9sYHLD/
	Qnt+Zel30+szAtott3UObGDEceNJMyDTKX7ObMwINaM2hZwHAHF0NkSuyrnTKHYBrtXwG08khvoZy
	pCab3etg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukTqL-00000003e1T-0Gtx;
	Fri, 08 Aug 2025 20:37:37 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukTXY-00000003bla-21mS
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 20:18:14 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4b0848b5191so25161641cf.0
        for <kexec@lists.infradead.org>; Fri, 08 Aug 2025 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684291; x=1755289091; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc1Ft/b3qye0Nn2AQUyZWguJ2koiO3eAJtJCginIFUo=;
        b=jvtr836QT7GsaYkXothAEjsX4npJvDaucAlXzC+DdMEpO2BNj1owBGPHZuEBPLzFsr
         WpTRNrNrPJf3+49zGbjkMAAuvmMK4IUnXTqa0ya7zDBTdBNNN5xvrMsBf5sbWLcWMqa0
         QEYUAU4CvLpCOSjUZ3fEg384KVKSl7tZ1+PKoIaWemf96OuFCzc26OV3KXp6fAj0eiml
         bsO7TzuEZ6d+8jFJEdRt1o2Pj/G2l0R7YLO0ehMk8hjjCv2jN+BOA6AsUkpCaUptWnGf
         IVq1R9PgmW4I28wJ4U6JWJAkp89kV+BPkrtCeaLWoQbTW2H30sJMVcaEViBL8R5cw/U3
         Qh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684291; x=1755289091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc1Ft/b3qye0Nn2AQUyZWguJ2koiO3eAJtJCginIFUo=;
        b=tczKTTlitdFO5WPiTFXT8bUjRMyoKZ72g+nCDsDj/JhUs7WiosSnab7tT9rQu+mqBU
         NUURlPGzTwm5fR3JyO73Y9yq7am4s/7FEfTUsY5E6ttTqd/YbQXI9ZSDp0z4aXqqlMwf
         /6bQaOjILvX0ksUPUuAHclT1ByrGmGeiyH2W5IWOALpE/p/ZWd1LA3GrFPAa0amdkDhm
         m53qdptIK2yWMbi6dDEdbONJtMiObbhRMhC43Uvznoya6yYuWDYPEVOjZtmhbksjqEYS
         ja2KUA/Ptnp/QZdPog31NkSQhk1TRy1jXhvlgwnqw3SkLhlH/tpijyrFczIavwoGT2wX
         6fdg==
X-Forwarded-Encrypted: i=1; AJvYcCW2KKZFdHcBpMR7hLGeKVSuvPe/n8xqLSshFuEDs0tfMnJn/BAtpbbKJGb3qdBt8v7E1UOmFg==@lists.infradead.org
X-Gm-Message-State: AOJu0YycGZhfw1YgCLoCmRIo9AaBtdUGKZvGEg/2yhqNdPiplgAhMY9A
	ltsSjCH4TAap+j4W6PUjT7+YorNIkm8rHZev1FyrMxSS4XZOKcGY6TiuJgwbkPh+kVY=
X-Gm-Gg: ASbGnct29EppOO/KYMALBSOiZHV0QxWg/eTBITkLtKQ7nExG0IVDm2gyrEq8i9FbDik
	LfeJWB6+lCv6Q/slG890MolciLMhOQdYStQNnYzJ8nEs0uJbHCdtqHB1dbfZrd+7SPGQ3XvuQM/
	kgZfHoF+BmlhatOe8t6p9AsRpcFWU/7m8nlHsLh+RV5Lkvqo5H5pJ9XZl10kf5mxkH9nKJk8sR5
	ZzUyJ3MEpo7a1I2Cv4HTNDfHmuWDN67nEWWCRtwXnfLSCGu9O08X7+BaNNih5dlKKIQbxPuup2D
	tgnaiwFESbrUb36qH8F5lxuLWVPFGcRWAONM4+LOwAZ2QjP3PRoCItQ87P7O1pKFqYvnlY3H6Px
	0Xa3lVHQhzdBJ3s3j97896ZEyxwBLuDQ5xS2rxIXs9JiukAsCIp5L7D5YGJhmeLMOVuieNOqufa
	tLkadR+KI5GHfe4oNY1e1L9AQ=
X-Google-Smtp-Source: AGHT+IEe17+1VnFzVVxjjjvnJD4w9EO7qMdCyqSXThf7XuoxHsa6VF4qQAx4towsxC8CogahdlN4Jw==
X-Received: by 2002:ac8:58c5:0:b0:4b0:8773:9b0f with SMTP id d75a77b69052e-4b0aed0f079mr63563811cf.10.1754684291399;
        Fri, 08 Aug 2025 13:18:11 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm59490131cf.57.2025.08.08.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:18:10 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v3 3/3] kho: warn if KHO is disabled due to an error
Date: Fri,  8 Aug 2025 20:18:04 +0000
Message-ID: <20250808201804.772010-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250808201804.772010-1-pasha.tatashin@soleen.com>
References: <20250808201804.772010-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_131812_520596_3219C4EC 
X-CRM114-Status: GOOD (  11.27  )
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

During boot scratch area is allocated based on command line
parameters or auto calculated. However, scratch area may fail
to allocate, and in that case KHO is disabled. Currently,
no warning is printed that KHO is disabled, which makes it
confusing for the end user to figure out why KHO is not
available. Add the missing warning message.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/kexec_handover.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 65145972d6d6..ecd1ac210dbd 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -564,6 +564,7 @@ static void __init kho_reserve_scratch(void)
 err_free_scratch_desc:
 	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
 err_disable_kho:
+	pr_warn("Failed to reserve scratch area, disabling kexec handover\n");
 	kho_enable = false;
 }
 
-- 
2.50.1.703.g449372360f-goog


