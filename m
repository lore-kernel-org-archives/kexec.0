Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E85DCE8D4B
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbmkCSy3WV97Khy2XyctXrcV9Slv19pvozAVxgLjLY0=; b=N//Qk+2hq1JZ/lVBS/pwi0VeBP
	c2iyfjQU5RxMTuwp9QkHO2UrP++uuAzXKXXLAsnEOSTPagldes/XpAQc46RyJFEVHhRtQja2jxyed
	GFey1B3An4cfQGCDK0DsphHJvtfrC4v8avIc3SnALtjixRUHQsU6vMyotQOpa1IJn282XpSOAHxLG
	EJYBCrR0Nt75/VFlwHFDTC/KGC5TkH35C/Q+ZBr55cW224vfnOB94d1vps6RKUnxrz7BmaEOoyaEj
	hRNzggygxrOYiP5mwj6wSOx1s62FrPYTOtyYoAYuR7wlYATPHLXisM0mLoPSULSBfZyFJuGJUvG3K
	SUSk68rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7j-0000000Cci8-1mIm;
	Fri, 14 Nov 2025 15:54:07 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7h-0000000Cch9-0XPV
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:06 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7866aca9ff4so22227867b3.3
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135644; x=1763740444; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbmkCSy3WV97Khy2XyctXrcV9Slv19pvozAVxgLjLY0=;
        b=ci66VH8vWCRj79Cn063ueKpSuN4M5Apy7flmIogbOTRlm91L7Px5EtY228Qi2V3/k0
         8jPsSRfhdgpE9uApEeLdc0KIvbosW66nBRzk57fDZBIgCpScRqD6tT42pAofSgqjQaZ5
         zEF+mT2TqCDFOOxLs1LhwFGwPPORijQpWOGiohe+WVLdzGkDWI9uDNG8AbzlZKdkAA/B
         RE6V3cWhK+g4RmwKuoLuSOOx7y0vTJkKK0VkOJch+HQQuuTXqz9RcLaHqgmZ/ZeFYWcK
         ApjHKFvJ0FPYTljlda4q/snycN7ipj8U9PhVNmo+0XufQWpIP7TzRitLXEh+kq9Qzziu
         t5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135644; x=1763740444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nbmkCSy3WV97Khy2XyctXrcV9Slv19pvozAVxgLjLY0=;
        b=Qgi60/jJVzdDDjegDtXNZfRwsS7GjBIGgLQjJtcbid+ugDEJGNTPhucnILN3EZLxGP
         wTLcQ2Dx/QRHvEuYM8IzpX8jmF5KS8v/jUyVLP8b1lJglY06K95QTEWJ/t/aRrIo3F/Q
         RASjDra+k63SRC7Ju15eu+G1oBB1SvyRfXGYU7/HA17hlgGs/uAKSlycvEve8RCkuqNY
         tO6/jSZk5itzvU04uvFwMKjAb29AF6mU0/o52ST29kG4oKRyqNT7V6B4IBb+v7GDolJc
         MeGppNJ+rP10O1K1ASZbf46D+vQshubE7ZpyYUpWyZNfG+IUY1tmQX5p2CUQU+6uEmcs
         P0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWo+Z/04cm0NuAjTSHfFTgDJZw5v2/W7i2e1bRe2INvIevuKj5C3K2UV5c7XFK5lAJ3g4dUDw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxTS89HN9mPHQMP/80B5lldQ9daCWlGH5SPVLSM5Zdlf2oJFfzD
	lc0rOylGqxsjucM69B3IbwK8f3/c9yWXWHDxWgFJd4tEpgND1c7/ElHjJdyG+ZYViQk=
X-Gm-Gg: ASbGnctQ5BtE1WcMV3gY7k2YJ45Guj7kC1bASAJYEkKAPyY2tOoDFfHg4sUm29JAac+
	nsKqUwsQiHfUQgx7QGjqsOhtjW2gFNOlplcd76O/4Fvq1zSO6DUwAm/YAGUwUxtB5204UembZxT
	1ZXi9Ec2ZlvceBfDQqPvy6McHDdI+oZqEonF8khnFJ6x7pvin1RFUZuMFjAbRjX+CWjm2WfYiFG
	UCxB10gyKJL4INh11DYizWX0h2kUxn1oYpOnJTtZYqXwIxObO9zeE0XMOnqdnJiVaMoxonPyjV4
	EJBJdKDPWJf0XD5dMZfUPdTYP2SpvNFXQRG+43Ywnvjx3B51RyctM/NgFffFeFwXajFN5lW6vHa
	WXcK9U2nlxNAeSP2t/EkiH2sM8/y+mBZ+IvydH7gXw6JEMWCCRwEOfYQRZsYbwBQ1a9vqsBg1TY
	VXb/DISCecpDPgbogqm4YKKC9HmF0A+D0VoCXtBwigywbycOg+sfVUGDGWeGg7WEAwVj4h
X-Google-Smtp-Source: AGHT+IGXdgJBU9rOthXQn3qIN5f0W9bnIxb8QN9M+K/3J2nID5vEHLVPpJIeqX35ivPrktOa6aleug==
X-Received: by 2002:a05:690c:380e:b0:787:b5ac:68e4 with SMTP id 00721157ae682-78929ef765amr35233197b3.48.1763135643981;
        Fri, 14 Nov 2025 07:54:03 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:03 -0800 (PST)
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
Subject: [PATCH v1 01/13] kho: Fix misleading log message in kho_populate()
Date: Fri, 14 Nov 2025 10:53:46 -0500
Message-ID: <20251114155358.2884014-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075405_170910_76A816DF 
X-CRM114-Status: GOOD (  10.29  )
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

The log message in kho_populate() currently states "Will skip init for
some devices". This implies that Kexec Handover always involves
skipping device initialization.

However, KHO is a generic mechanism used to preserve kernel memory across
reboot for various purposes, such as memfd, telemetry, or reserve_mem.
Skipping device initialization is a specific property of live update
drivers using KHO, not a property of the mechanism itself.

Remove the misleading suffix to accurately reflect the generic nature of
KHO discovery.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9f0913e101be..6ad45e12f53b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1470,7 +1470,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.fdt_phys = fdt_phys;
 	kho_in.scratch_phys = scratch_phys;
 	kho_scratch_cnt = scratch_cnt;
-	pr_info("found kexec handover data. Will skip init for some devices\n");
+	pr_info("found kexec handover data.\n");
 
 out:
 	if (fdt)
-- 
2.52.0.rc1.455.g30608eb744-goog


