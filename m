Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A82C41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jXuYVsArJemVoI9j5GY6+wj8s1+wn3nhtq74dAnFj1Q=; b=z4NPjQNU3TFQbR
	FS8tywv3vlqc6F8sGbvSeN9OzYwOcZ8Sk6LsoeNu97ayoQiXyw4qxhXfOty0LfNLj2eHMPLouHH0P
	3yyQm3JDCcrxQqX3g/eRVv6IxVF8NY01a3afcj7n6ljD3Lg2+PI3zWQ/Bvb07htgtgHj2yuZ69yHS
	JakQWz9lYyV4xwi3A450qAK6VDcTGkqqEKkmtxN+guyIejiI4F5ewhKK8cJevL1y6IPtTO8gcR5OL
	I78x+cmK6e/QOJxak3CdDnEKYm50IjdjWv3h435fJaWeOLAnao29tD0snQwOH+ScOhkJi7LO6+zQP
	nAlCL3rxFHIRAtbO44Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFd3E-00EiRR-0o;
	Tue, 19 Dec 2023 16:34:36 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFd3B-00EiQU-1J
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 16:34:34 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6d7e67d31caso1495891b3a.1
        for <kexec@lists.infradead.org>; Tue, 19 Dec 2023 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703003671; x=1703608471; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTbe0FFkiWpC+TW0jPOJbtW/DMOk6SlTqa5fmcQzYNc=;
        b=eI+5uc+qnr+D7UVEwo0MP+sSDuMKJ9u8iDofozBKO0sYs9nUkVZ15abl8/rJNQqcny
         gpueUeEu+c0pD+P4uwaxdoR1xQv90/9HhOaqqFolFzsYerLPOGIHSkT8xMQQJeuN+Y4A
         h1Vp0DSjV+LQ8fg3nEJqGIzdgkCdoJLjI2tCSoBxTPUsAObmRS0gbN/+fdpYIJbQiKGG
         d/1k/v8jh383uLmT42ehet7vdt+pOo2nXkylZ7wIla02L2zrwgZZH/tWWm+ij6MFgzIX
         Z6Js1uXCFTWO/scyKgCR26IC6eaPM5yoGynqpij379kz+V1s4NPpg8wiHplqeSNQaJOE
         n2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003671; x=1703608471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTbe0FFkiWpC+TW0jPOJbtW/DMOk6SlTqa5fmcQzYNc=;
        b=AhWFXvgOnJ2Dg8GD975DLIt2Sl2HWR9u3uBjvvt92LzMEL6RZ/Kb/4YbmS+Se67s00
         Ldg/JZhQlWrN0pK1P7TE/kvv8qnYiBkmSgezhOYT4nZBX0jBOBYUqKgf4YyISkYmxs+/
         aWsb7VcEFCIMDYykYM1R08Evejr2/rJdnQSquaD4xHyxZqs288Fq9IjSW0Zvc1La5IJ1
         rrU50uuMfeWoxhIaOOZarSYgANRbGv8dAC51FXD4lnsc8CiiCvXTHjOhugqzsjBgzSX4
         UdyOj1CBjzr8jRddt/dcQAOCJYPhU8Yq84EmtUyn3rkMiQfuu3k0hFCKlAU4vUgekBOM
         DdOw==
X-Gm-Message-State: AOJu0YwMc0DMEN68xmj5aFyjMGAJP++p4JBSg+VbWiBobyP9iGDVstWq
	GgGnEnbOphaQpRAlN1jlLJc=
X-Google-Smtp-Source: AGHT+IFby3sDY/fW2pan071Ch5YMA1tZy5GS/12pC3aFAT/8648QVZ7U1Wryd5SoCYIo2/SN0J3ttg==
X-Received: by 2002:a05:6a20:9149:b0:18c:a9d3:4f96 with SMTP id x9-20020a056a20914900b0018ca9d34f96mr10624117pzc.32.1703003671264;
        Tue, 19 Dec 2023 08:34:31 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00178900b006ce789d8022sm20232551pfg.59.2023.12.19.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:34:30 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH] crash_core: optimize crash_exclude_mem_range()
Date: Wed, 20 Dec 2023 00:34:18 +0800
Message-ID: <20231219163418.108591-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
References: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_083433_440090_00C68DAA 
X-CRM114-Status: GOOD (  11.22  )
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

Because memory ranges in mem->ranges are stored in ascending order, when we
detect `p_end < start`, we can break the for loop early, as the subsequent
memory ranges must also be outside the range we are looking for.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
Hi Andrew,

Patch "[PATCH 2/2] crash_core: fix out-of-bounds access check in
crash_exclude_mem_range()" can be ignored, use this patch instead.

 kernel/crash_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9a219a918638..d425c4a106cd 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -575,9 +575,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		p_start = mstart;
 		p_end = mend;
 
-		if (p_start > end || p_end < start)
+		if (p_start > end)
 			continue;
 
+		if (p_end < start)
+			break;
+
 		/* Truncate any area outside of range */
 		if (p_start < start)
 			p_start = start;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
