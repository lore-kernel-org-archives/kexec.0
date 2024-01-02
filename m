Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDE2C46CD2
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j+v7LxkZQK264wzC77lRVBJTpc5CnGhmm9WIsDlSvYo=; b=PNZeGuEuk+CaXZ
	aYPqScOQtxHFmNLo7TBa5rQ3X8gR0/A6OGBrHXlVJ4XLLdt4qfSYxydOB3raFrxF3P7mQE0nnT33z
	gW7MisYqtb8+YJTumXratdVzuxfOHc+eITRiZ946g+QkESH29jJmkrqGYFm+lgoOxjRUUUo8U+sKd
	V1ehqo/O06tUHVv8aEvpChAyevNycqVZvprZs23EZZH3LDLq18sPeLHuEsL1TFBZu7v6Evq0XSzRT
	GFp4sI1+gukEgLS7q17fsjROaY5iJdc1f0L6YQ4sh+PIVu/ynpZxrPAXBYQiahifIufEhksmtWhtS
	BW1erMjDZwY8hBryAyOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg6D-008I40-1t;
	Tue, 02 Jan 2024 14:50:33 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg6A-008I1i-1K
	for kexec@lists.infradead.org;
	Tue, 02 Jan 2024 14:50:32 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso6802787a12.3
        for <kexec@lists.infradead.org>; Tue, 02 Jan 2024 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207027; x=1704811827; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCgO/9ttUPkNH7K3G/yJnpUY2imlxWqPy44q0o7/7cg=;
        b=lmBGHFk+0mh5CShORmulm3d4J8JRtk8RJlQyvcydMMC8wYF2SsFM1KZyHcf5sEHWTs
         FIDH+2iSzXSqmPF1ZhBNqXNznOKClWJOmW/+Q027jTH6gOiTKIILKcwUXKUcZbDaipLs
         MemNoM4z9BfzeVLtihuw0+wkqeJEZEXsWrlaJleoLW0+aWqkOEyqgdpvKTNJqcY70lR3
         tzV1eDkNiKu7Xrh1SLNKxjM1uFmz3huH9f1lDaDfN8J5anRRC81Npfq1WsLZ4/AI9BSR
         BGE/1iIEjvXW1QwF+2/Fef8UfjPMJbUSZg4X2+PTe/Ta5eDpIiAMGzTgQs7HGwEcbzts
         tTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207027; x=1704811827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCgO/9ttUPkNH7K3G/yJnpUY2imlxWqPy44q0o7/7cg=;
        b=EDEWehZReaq8PD3eDAOixuZ2HaYzndwBKTCnwljHvOegHuTZBcrK53xvb6ajrMRGjK
         Ih9ItNm9hXBi8s2j1b3EmVUsuxIuAXRfjwr8g+7DPGiYPRfPHmzF5tR5aw7c0OyQv1aD
         WzBikwM3glURHgboKCBa+Z1HNUdM9YCSTCeawisvd+uIFOxUrtjGqjYOfdYyTvD1e0wu
         VVl2y95zI4OJKJoFFM86B01J4RWCO7Rn19OaOTPPLumqYcpFErhChKYQGquGJgGgq9/7
         6RqntH25D5BYQVy9NFfsyIRo3e+ht54ml2bJE5Y2LinZT+osL4rd9Sd2uk1UruVS212B
         3tUQ==
X-Gm-Message-State: AOJu0YwNrc+uu3pxIBwSu6XwP0oSgKCRMxodBUxyG855piNcxMuHLobf
	7q66/o92JJ50IIdxnxMDiEs=
X-Google-Smtp-Source: AGHT+IEp/OYVuT1KyjbMk8HhRA8LrmsYNrUwPzBctDSGWxhQxggYuqj7FbqKq9gKzAV7mA4P8VLVlA==
X-Received: by 2002:a17:90b:4b52:b0:28b:e79e:f8d9 with SMTP id mi18-20020a17090b4b5200b0028be79ef8d9mr8228754pjb.84.1704207027515;
        Tue, 02 Jan 2024 06:50:27 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0028be216595csm25836878pjb.4.2024.01.02.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:50:27 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
Date: Tue,  2 Jan 2024 22:49:05 +0800
Message-ID: <20240102144905.110047-4-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102144905.110047-1-ytcoode@gmail.com>
References: <20240102144905.110047-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_065030_448174_F2CAF3EB 
X-CRM114-Status: GOOD (  22.14  )
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
 kernel/crash_core.c | 80 ++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..c51d0a54296b 100644
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
@@ -575,72 +574,51 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		p_start = mstart;
 		p_end = mend;
 
-		if (mstart > end || mend < start)
+		if (p_start > end)
 			continue;
 
+		/*
+		 * Because the memory ranges in mem->ranges are stored in
+		 * ascending order, when we detect `p_end < start`, we can
+		 * immediately exit the for loop, as the subsequent memory
+		 * ranges will definitely be outside the range we are looking
+		 * for.
+		 */
+		if (p_end < start)
+			break;
+
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
