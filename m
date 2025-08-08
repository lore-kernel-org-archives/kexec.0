Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147B4C87FCB
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/EURho8HdzYkRlNQqj4Jp25lWoftNvoIKLrAmtRbxc=; b=Ag6OBwxf3dayE/p4nabNYMpmii
	qKb/VQQ+qBMEQSbvupdSjFWYKFhxzzK1K6K6+3VhR7pRfUeQkY5DRG/mlehsAxaHfrtOlPNQqWMzP
	gXr6wcZ9P0XQBv0CnPiBbIouK9TZpKyv8ia1oQlE3qlgc5iBGPjchjEUdCF37nY1yOZ94PwTIlB82
	r4wZuK9KwtCqugp8csCge9cba7wsEb6YsVDtkuL8gEIV5aW5/uc0ojGBCJF1LRYeyd1HDFQIjmRz8
	gJaPnAkhS/afPgaOUBlJqTVvxoGrt7uIG7mHcogeFozkxB3uCJdtQrPq392gV3MuChEnbv/UE7PCV
	8furGSpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukTqK-00000003e1M-2zhc;
	Fri, 08 Aug 2025 20:37:36 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukTXY-00000003blZ-21im
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 20:18:13 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4b0a27ebf01so14009491cf.1
        for <kexec@lists.infradead.org>; Fri, 08 Aug 2025 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684291; x=1755289091; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/EURho8HdzYkRlNQqj4Jp25lWoftNvoIKLrAmtRbxc=;
        b=EmIrNdPyKTQSBZGNOIgKNGZjuuuqWPFhLBzvEIczzohxwLsiywUAb4KgANvAyoZehn
         EZkKbvrDdpN1GNL8WlMHXqWyeUfjBwoLvuMU+wNqynbUqIKmQZXpj0kn5Mg9vuVJThNs
         32wcmlxCJZdKVeKxmxgnp4XOh5/7AQ8EoDIhfgb4a0RnVwBN9rhSc9VrIr3FVOz6a2x4
         0koEoRpVG3SnN48PvdPwzqDIoot7iBXyTIJMN+qoYcJ+b2Gt/6NB/KwRb0ZM0R+BVqOu
         5t6M8ePgPdou0hPd3GUkHpFyIqLcr06B/b1qtkmMNXmKj6BaK7Yn+ieYFT+0lC57mpCd
         8Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684291; x=1755289091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/EURho8HdzYkRlNQqj4Jp25lWoftNvoIKLrAmtRbxc=;
        b=Fpn3LOySPwRI6KHDgLsdZayTFnXTe9/0cqr4ZBlFW1D5O+pH7tnKiBgtSxS8qDHV31
         PtMiEZ9Aj9EJOgvIRqcggrYwNjr+0cYWK9SpfhuS/VARC31awB4xfjuS7pML5c8qCYig
         pUD2GkQ0KM2G8KoxJHTF7pKxtYhyEvDptk0FiJ6FY0PKF8wvjz8bmi2LPmr/+BuWeez+
         zuzh4PDEd90re0i9S0lC7iJGF9NT6kIElrRNe8CkpHgKuZLUQWSKDDwkKbEXeqwmm4gi
         5lrvgcNB9pggucJ9Z44KPpnW6yCjS6f8wvN8QWydaGUhoQlPRL6oEohwWugUQDSce/s6
         /eCw==
X-Forwarded-Encrypted: i=1; AJvYcCWfMEt0jNfOV7CcLkldrHRkwo4k0xPCpH+PwSp3k9JzRWAAqhpixVfOHlBGdG9FB4WsurybpA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxbzXtPv+5PHDWCPuZbYF77zeOjPxEL3qsHxuXMfisQnc4LpUCd
	I80UWmxLzR7j47u+VSaQoJ2dSbiufNRW76OJEu5BdIRysC6nIBFI0fkxzeYH09WR0xU=
X-Gm-Gg: ASbGnctoUejiNVpv9QlAjhGukCFhkXfbi/tP+6p/J0dtqvwevqMar0sWucX1yl43H31
	RlFDEo6nd/GSXMgmyLi+j6M8lX4bqFrKTeMqAeCrt/BDuwD/bILwMQYKRMFn3YgnwmEMp63x+NH
	VImNuxQSsLUCvDQk2BU9i/O+Kyoy04rN2daQBYzZz1b5/ENLVqvNZ2mEv+0eVm5hLzviLvUaJkJ
	9VcRN4hhO9Ah5Vp1U3CpqEY724zqZN2kSesJMMMss48dsBtj/9nDQ8ZHTWaG4UQzHi4I0Pb18fg
	zCwqMcTHCLEnMcvu1V5563w1CTcwtgR9tBySXeFmJ+mhgfBBnBZFMqYaQ/4Fmm8XWjsTU987QTb
	zXClNxaiD2AWBWGeEA2EWliCI2HRxH6HwzT+iqYmwBddLbF/fStdZpPUYgYs6DYejp/RE5mq5UH
	s6nPA3d82oyL6E
X-Google-Smtp-Source: AGHT+IGRsYIjYMDPHPWyETlwLlG2Zy30jh5DmGcJISmzXiHxweHbcXx7yy5GDLFSE/EbxlmscbGNTQ==
X-Received: by 2002:ac8:5701:0:b0:4b0:695d:9ad0 with SMTP id d75a77b69052e-4b0aed0ba35mr50986991cf.3.1754684290662;
        Fri, 08 Aug 2025 13:18:10 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm59490131cf.57.2025.08.08.13.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:18:09 -0700 (PDT)
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
Subject: [PATCH v3 2/3] kho: mm: Don't allow deferred struct page with KHO
Date: Fri,  8 Aug 2025 20:18:03 +0000
Message-ID: <20250808201804.772010-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250808201804.772010-1-pasha.tatashin@soleen.com>
References: <20250808201804.772010-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_131812_519091_D2B4745B 
X-CRM114-Status: UNSURE (   8.91  )
X-CRM114-Notice: Please train this message.
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

KHO uses struct pages for the preserved memory early in boot, however,
with deferred struct page initialization, only a small portion of
memory has properly initialized struct pages.

This problem was detected where vmemmap is poisoned, and illegal flag
combinations are detected.

Don't allow them to be enabled together, and later we will have to
teach KHO to work properly with deferred struct page init kernel
feature.

Fixes: 990a950fe8fd ("kexec: add config option for KHO")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/Kconfig.kexec | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 2ee603a98813..1224dd937df0 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -97,6 +97,7 @@ config KEXEC_JUMP
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	depends on !DEFERRED_STRUCT_PAGE_INIT
 	select MEMBLOCK_KHO_SCRATCH
 	select KEXEC_FILE
 	select DEBUG_FS
-- 
2.50.1.703.g449372360f-goog


