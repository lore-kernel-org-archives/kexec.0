Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E45C4332F
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y4TARhdXZduf1xLA7HXvErKw3MtXQFd70sSRN7UfsFk=; b=L7p1cftns/SyLE
	cmPfVTQtIagmJI0S28azLJXaggu1hg+Pmc64cxc9OxnTYq/S0LWs1m4IAFXtaNEwqky6dsuflHJNb
	YslpMqk1rTj6+2o423xfr+XaX+8dXzaU7gUebDm2gK5GM3Gb60y1uzWzrEWYaP/eiDi13NvkwGssa
	d5ZgLGMOFixxVkp01y99I/9Nl90+eLazr/TuM5fSGwZPoqoa+OCtveSS0i8pXb+yLvooJkPCpI6r8
	6Dv2s9pqff+XqE2H3GOhiNATTX4mrjtz7mbh3HXbQqrSwHGAgDLycw8bFmiiwU3Hi7bYISZUis8m0
	jgy/Gx2SQfV5Hh0181Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDolb-000pqS-2I;
	Thu, 14 Dec 2023 16:40:55 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDolY-000plk-2E
	for kexec@lists.infradead.org;
	Thu, 14 Dec 2023 16:40:54 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d098b87eeeso74925085ad.0
        for <kexec@lists.infradead.org>; Thu, 14 Dec 2023 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572046; x=1703176846; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti6fJ0q7IpNfuWyKxmP8PV98iLP1/8o/ewhA7a4SgUI=;
        b=mz9KKjOAM6FapCb/pPTskf2mbjfkNKbgE2k1AloAb6B+LSz/cCrmh+mUYiKwYsklW5
         yd2QCXwN0GnZuME1WbO0QAyL5BpnKjWHnRaLy8Uf4i/PKiZK19deBBxf3xxwfpKEVBTp
         jv1r/UQj4d1dER61wAgdb4177A7LjF/KBk40vnxdYNKz7nwmOg10rTDQoVSui7+X2t1M
         Tbu7ATBt9V0f2LcJhSWqHte/OgaJKOBr9EuzajewoqBDQ/yLH41H154JCGGabdXdSbMA
         PHDnS0acoNkbtj9F0pESxRreOmFeWEkG58pSuyFxIVdDx2oa5Bo8btzYu/12CFsFLuV/
         m14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572046; x=1703176846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti6fJ0q7IpNfuWyKxmP8PV98iLP1/8o/ewhA7a4SgUI=;
        b=tBSa9VA4YFMpbXND2irLHoxKNJKvAUy5cPtmZ+Lwvf091qLpsZx5zJFDxlBU2eJxNh
         aH1xj/L1ArpYyWVX2Nskp5dUmy6770E9KWtHMGRVrT7/H1FvT25h3FWg+HYUvM20HDWr
         oom9EKgpWKmvBFauhAlLwdXSKYLf7Iyvmf4GM7td7PM6Mg4AGC9KHLvsomU0Lwvt/n5p
         lp2ueh8NR5GVuyD5SxxF7QOU1T0a3MqThLU4PPgNr/TmUzxWA5KGl13JZuqxScp2Hdkb
         3PWbKUr8qrY6E2kcR6OBZ3p0w5rz486mcheDeNCO+Pk+DYUWyKjiSt9Y8VaudJWApDkb
         S96g==
X-Gm-Message-State: AOJu0Yz0RU6iPCrN67ywDQgaZjTy91w/SE5NAzmnQySssD/mCnUpW3pb
	jKZ+sPtWcjZBfqBQ21ivTrk=
X-Google-Smtp-Source: AGHT+IHQ4qZPIQ2nZd+rqHbw2B+B5GXKKrM1wuoCjHBF9nDKZgAuS+1Z+WxnRl2QvHLLFKAZWGBD/w==
X-Received: by 2002:a17:902:7ecf:b0:1d3:3c35:81b5 with SMTP id p15-20020a1709027ecf00b001d33c3581b5mr3669073plb.46.1702572046197;
        Thu, 14 Dec 2023 08:40:46 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm12595897plf.79.2023.12.14.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:45 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Lianbo Jiang <lijiang@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
Date: Fri, 15 Dec 2023 00:38:42 +0800
Message-ID: <20231214163842.129139-4-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214163842.129139-1-ytcoode@gmail.com>
References: <20231214163842.129139-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_084052_736440_0A753271 
X-CRM114-Status: GOOD (  19.27  )
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

The purpose of crash_exclude_mem_range() is to remove all memory ranges
that overlap with [mstart-mend]. However, the current logic only removes
the first overlapping memory range.

Commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range() to
handle overlapping ranges") attempted to address this issue, but it did not
fix all error cases.

Let's fix and simplify the logic of crash_exclude_mem_range().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/crash_core.c | 70 ++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 51 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..0292a4c8bb2f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -565,9 +565,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 int crash_exclude_mem_range(struct crash_mem *mem,
 			    unsigned long long mstart, unsigned long long mend)
 {
-	int i, j;
+	int i;
 	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
 
 	for (i = 0; i < mem->nr_ranges; i++) {
 		start = mem->ranges[i].start;
@@ -575,72 +574,41 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		p_start = mstart;
 		p_end = mend;
 
-		if (mstart > end || mend < start)
+		if (p_start > end || p_end < start)
 			continue;
 
 		/* Truncate any area outside of range */
-		if (mstart < start)
+		if (p_start < start)
 			p_start = start;
-		if (mend > end)
+		if (p_end > end)
 			p_end = end;
 
 		/* Found completely overlapping range */
 		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
+			memmove(&mem->ranges[i], &mem->ranges[i + 1],
+				(mem->nr_ranges - (i + 1)) * sizeof(mem->ranges[i]));
+			i--;
 			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
+		} else if (p_start > start && p_end < end) {
 			/* Split original range */
+			if (mem->nr_ranges >= mem->max_nr_ranges)
+				return -ENOMEM;
+
+			memmove(&mem->ranges[i + 2], &mem->ranges[i + 1],
+				(mem->nr_ranges - (i + 1)) * sizeof(mem->ranges[i]));
+
 			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
+			mem->ranges[i + 1].start = p_end + 1;
+			mem->ranges[i + 1].end = end;
+
+			i++;
+			mem->nr_ranges++;
 		} else if (p_start != start)
 			mem->ranges[i].end = p_start - 1;
 		else
 			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
 	}
 
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
 	return 0;
 }
 
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
