Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA22ECE8D76
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01MmDex2Pd6rSH6pN9DP4qcg9OhX2+hS8KGFIWtKr/Y=; b=1rFUvBemJ/RlKX6OBP3jhfrdHM
	nqOHSAtCi90UmZ3nQfmfhfy8M6AwsmJCNJY8GiVslDdUY1ZCiFhSRiBoVmDSpW72YiIbEDjBEg6jF
	QknOGDihXBPZ2/GciQcRUJZ/XmreG5+8DnzghAJHZuIUc7Saej3cRac9xBd3zMBZHMi/+VELt6Ny8
	ROCtSg7JzlPcp9WH/U/2/6D2e1kaImrmMBnbvnSvGq+6mpvr/dbxNWY5nNLJInUAAMmW/tr5+pdDg
	dsmxis1yKuwuZBhx5YuFsky8JAb42cNorW8Z5DEzgEtp4AhBWjJe9brRfYciVfxV0oIwIReetAveB
	QInZKtAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz22-0000000Czau-2qNE;
	Fri, 14 Nov 2025 19:00:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz21-0000000CzYi-2cGl
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 19:00:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=01MmDex2Pd6rSH6pN9DP4qcg9OhX2+hS8KGFIWtKr/Y=; b=pDCF0pZ5BugHMt1/l3cxHDWLYU
	vo5XIZNF7sCFNpDI9oJdPidLdRakA93OjA6Z1xNZhqVLePzQDfKTRF2jn+5aG4Qtj3ZgAnvFjXSVr
	t9ymb2jyIWQr7dQVGT6LDddc5bxmT8uCWleW4Cv06d0O8/zKXQ8VWZwjw4VfTGrcc0ossHGV2yIBT
	+6Uw+2Jg5IJHjgQuZc2h4SWZHke2n5kKFnTM7Enb8L+yVMiYfxObSwURE7OYeyESb4n2yxvAY53xl
	hkHpa/PwJzV3ALIDdbKrrdBRQX/MibHvKh7Z8Lh2d4H5X27+aq8gpUAW/1w5toiCh3FqRG4FvAahc
	PqWtwqbg==;
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJyAK-00000003Jqx-1120
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 18:04:57 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-640b4a05c1cso3068909d50.3
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146821; x=1763751621; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01MmDex2Pd6rSH6pN9DP4qcg9OhX2+hS8KGFIWtKr/Y=;
        b=JsWU5pLCHfB94+aA+kel3Zd8abhkO8kVNNBfnTX7GVwaZ5w7C5aIYdqPoP2gNBKKKo
         v23LMr9a0VW48HseZAQWG8tECTYnrewieL2CmC8QGEvi6n7J/zgOKEyY+pRAIum2Dbhq
         zdf4fC1fblleElGg9kthsj2gf3utPaHM96W91n6N061WFEpALveTUj86FSE+N3y9LPey
         hpAKgAw4hfILVRulqt4LSZmmpacDQxWrcSgyo0UbXfryAbOiPRwwf5H1yqfdrsRL/R3d
         YkoMfBndDt/4iTzxqp+lmoUVO/4tRYe55vtSaxA+S0gO7PU8bUsoMZ483HIr+X+ea6SF
         D65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146821; x=1763751621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=01MmDex2Pd6rSH6pN9DP4qcg9OhX2+hS8KGFIWtKr/Y=;
        b=cfOuqqIQZujYeM3V2f7TDitS5SUTQlBvpfMAKXXH71Fp8R/Lpo+4euiURQOau98Xak
         X4eHxtsdVv5wONzZXRksShs/oT+4nqLokBTzn1zJCErh46T69Apq1KBikG5UxDnc9knk
         X9Q9Ep1KsFiz+Gt2EoiiByqn+lM3upDK4dDp3k8AzLa85psceK8elwBkLqUgumr3rWFg
         Be1dJLa2yAwwbGvsM2NlYqnPqOLAZ5ESTBY02wbZlgpNb2SCB1vrO3qGhQhFqKI9mmU2
         ii0aiKljBllzV05hzSNMTgNjp6tTYtWPgVDDcbMFs5wnkW8M+3B2ZvkAQ6TiI8iUN39l
         eo4A==
X-Forwarded-Encrypted: i=1; AJvYcCW7VI0hQJQEl93+IwSscXt9jGCtgFvJ5G8QmKbv0uU5mRcLgvMeeQpW9hBquU4cQJt5Az2uIw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyoPPQeuFoIsSjm9tMjUYz47axVFZYL5hKpUlmw65hDgE8J4xuj
	9S2DczbHZ0d6tUFXodsNlsssZDYjLC7D4wYfGExaqWsIE1YTNEn+aNe8KbSzRqKTwyo=
X-Gm-Gg: ASbGncvcF742SLbSN35L/3AJUnkmz3+NGMW8zCZHxIYu9npt03tewHsZHytHV81yKAx
	IIN6YvQYhmNxRsh8+T8jNLwghqaGcVUoG31mk4DtOI/IbZqfDLeLPYFCkhx+TKfsv9ZVfoHSCXb
	5Wdhpyp1JVlCDf+9ybORcwwi+i3aATc81qDsoQix14khIGznTCm5hAEFn5tyqOunazFWvDL0c9d
	StmZ5dJahOUtZms6/D9UwlKNU9ak9CGcoa9PlOC6U137JcuZsW+ziuL971q/7Vtg8z0JeJE9Uid
	brr9BG9eNpNHakTTeUcWPu1ElmdEjN967IF5Upvi3pnYwE1TThgWtdgz3S/wY5GlnwZOOQw/x9x
	EqwY0reIEI4kwpJzSmlsEa9KepdC71LVJjdkWK0RthPWiKN/8EWHQv9fl6MmM4DBh88fz6P4mKz
	sn1fs1EVCOHuTDTOa9KHEYJ1ntft9gCvUzeOK4hkXw/mbdO3C/K9FOlacCRXQ8JTM4vAb+z/4k9
	aDcmzo=
X-Google-Smtp-Source: AGHT+IEh8QcCgJsbND6ZreOs/yM1aLmQLxoU8QELH1/e0TqxBuMxcDBXrCAfWHESdHhM0I5QjIMNCg==
X-Received: by 2002:a05:690e:1581:10b0:63f:b366:98e3 with SMTP id 956f58d0204a3-641e75052bdmr3181860d50.23.1763146821080;
        Fri, 14 Nov 2025 11:00:21 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:20 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 13/13] kho: Add Kconfig option to enable KHO by default
Date: Fri, 14 Nov 2025 14:00:02 -0500
Message-ID: <20251114190002.3311679-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_180456_385439_6A1E8608 
X-CRM114-Status: GOOD (  10.78  )
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

Currently, Kexec Handover must be explicitly enabled via the kernel
command line parameter `kho=on`.

For workloads that rely on KHO as a foundational requirement (such as
the upcoming Live Update Orchestrator), requiring an explicit boot
parameter adds redundant configuration steps.

Introduce CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT. When selected, KHO
defaults to enabled. This is equivalent to passing kho=on at boot.
The behavior can still be disabled at runtime by passing kho=off.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/Kconfig          | 14 ++++++++++++++
 kernel/liveupdate/kexec_handover.c |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index eae428309332..a973a54447de 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -37,4 +37,18 @@ config KEXEC_HANDOVER_DEBUGFS
 	  Also, enables inspecting the KHO fdt trees with the debugfs binary
 	  blobs.
 
+config KEXEC_HANDOVER_ENABLE_DEFAULT
+	bool "Enable kexec handover by default"
+	depends on KEXEC_HANDOVER
+	help
+	  Enable Kexec Handover by default. This avoids the need to
+	  explicitly pass 'kho=on' on the kernel command line.
+
+	  This is useful for systems where KHO is a prerequisite for other
+	  features, such as Live Update, ensuring the mechanism is always
+	  active.
+
+	  The default behavior can still be overridden at boot time by
+	  passing 'kho=off'.
+
 endmenu
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index a7f876ece445..224bdf5becb6 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -52,7 +52,7 @@ union kho_page_info {
 
 static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
 
-static bool kho_enable __ro_after_init;
+static bool kho_enable __ro_after_init = IS_ENABLED(CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT);
 
 bool kho_is_enabled(void)
 {
-- 
2.52.0.rc1.455.g30608eb744-goog


