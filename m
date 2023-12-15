Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CCEC46CA2
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g83bUuwPNOw2J43aIJQvhqWHxb1Yh1wQT+AXyci7c6E=; b=blq7xULPEdQMre
	QsA2Ueq8L3lJNnia9BYiAWcUNjrxsJbvh4hS4wEvs0Mz/nLSVIKvDkcJncm2s70zOvYYx5afVWIq1
	uRpyEf2OyRY2ili7iUK7eAcO9GNr4jyl1z9p9YKvYQMvqwJ+eh1reEUmFEXoHX7LMR5Yha4YF16PQ
	WJ66uRm64zxff603XoGeTJHiQkXRpIP57PdF0T7YFS0AxsHLyHYiYkRfEGrr+nmvvUI8LA+LlRGKG
	TB/ElOVmiePC6kLB9lHlidcsvGDUTX0focfjoThTgCC7seA24W3ocxWLc0VVpuonvaf1rM++IDLwE
	plHdOClDvrATaqwvxDeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Gy-002PxG-1Y;
	Fri, 15 Dec 2023 08:10:16 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Gw-002PuN-05
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 08:10:15 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce7632b032so155706b3a.1
        for <kexec@lists.infradead.org>; Fri, 15 Dec 2023 00:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702627809; x=1703232609; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jscYpo84xIlTIrjQEZDT5YAVqLMOQqnP0eOYv7+MbRw=;
        b=W+0nDnyp/6yRXvO/RzYILzb68YUdCpaRp5zDXs4BMVWvMn/V+vdWk9amIyE3TNNsSh
         AbvWYAW+m5O52qP9xrfKh471T2VYX6leNJGHWqGFdykZncKHei6ytSxjcCAcqxUH6PxS
         QgdGXcP1FZ5TAvwnZj3fdHKZu+3DvfG/DAhunl8TUbxxiIY97FFI9Pr2e3KWUrR2Yu73
         6gRDDjDYYOS4L4/F1kC7hPkONYApZu9i8khdBRmKvIn0eeiIU1ooVAre+6bZbCRltkkO
         9sV7cj1WKIFnGVTDF9mcXDpEe9KmQ40Zw7O6eeFv0WcdAlY6en+rdFHWvjeYBzFMVsai
         g7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627809; x=1703232609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jscYpo84xIlTIrjQEZDT5YAVqLMOQqnP0eOYv7+MbRw=;
        b=Pwtljm840hbe5QnUMbwsFLz5MavegWclnAQHlkvZxwQIugWKVs8FclizlZLfGQ2NtO
         yAPhoo//IkKzMklzaOGNdwQxj472XhjMA9yzeBDDNIhwSdiSmaOEfK07axn+0nHBc4jt
         0vnj/oN4JRaUvRbFmImwxbITk9M2wXH3kpKg5qz5Ea3I0LWkT/awrzW9zsu3J3wLcIpt
         +h2bBbzujhoC+FY3EOfOgzHyU6/XneDi7awfUMyyD2IoeKRgBypy2y6w/KgKAeCvo4QS
         3GbLCufBAVyPkY9oOF91iqjVCgZ6u10Hf+Qfk7CD5d7/Z7dWL8ozjdaHToPP0l/dPOKq
         ko8Q==
X-Gm-Message-State: AOJu0Yym9kLdz1vGaH1kgXo70smHMjyws29PHGbRT/cWZslA6pqB9yMJ
	LgpYD0qXamy0/4Z5jiDrLi8=
X-Google-Smtp-Source: AGHT+IFvEn6WjjxL9AELNTiUvLF5ar5KlNxdVOf+PtdHoCcSbpAc03KyD4vE24Y4VgQbfpvos6DDnQ==
X-Received: by 2002:a05:6a00:4601:b0:6cb:6a27:ab57 with SMTP id ko1-20020a056a00460100b006cb6a27ab57mr5960984pfb.14.1702627809447;
        Fri, 15 Dec 2023 00:10:09 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm11783792pfl.156.2023.12.15.00.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:10:09 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 3/3] x86/kexec: use pr_err() instead of pr_debug() when an error occurs
Date: Fri, 15 Dec 2023 16:09:10 +0800
Message-ID: <20231215080910.173338-4-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215080910.173338-1-ytcoode@gmail.com>
References: <20231215080910.173338-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_001014_066761_34CAA98A 
X-CRM114-Status: GOOD (  13.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When an error is detected, use pr_err() instead of pr_debug() to output
log message.

In addition, remove the unnecessary return from set_page_address().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 mm/highmem.c                      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..472a45dbc79a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -424,7 +424,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * command line. Make sure it does not overflow
 	 */
 	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
-		pr_debug("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
+		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/mm/highmem.c b/mm/highmem.c
index e19269093a93..bd48ba445dd4 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -799,8 +799,6 @@ void set_page_address(struct page *page, void *virtual)
 		}
 		spin_unlock_irqrestore(&pas->lock, flags);
 	}
-
-	return;
 }
 
 void __init page_address_init(void)
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
