Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53878D1624A
	for <kexec@archiver.kernel.org>; Mon, 14 Oct 2024 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q8B5ylFDnf0XnS7ov2mzggfYSzNFLEZCyYwVfJGiS0w=; b=jM4zHO8IW3K9E1
	D1u4oQxCv2c81Uwg3uyUuo4Q/ZJT3OsYDeLmA1sMk4r3lmWYxGly9eP8/2vAukfKV+xCEaHi/JKTC
	dkogb9DvXQVXZHqSRjQhb7rfFXmRRiOJh8xwQ0/3gMlLecCs8BB8XlNMl6KPCzK7ntyIFUlVnQJxv
	Ke0K/3UArnTOpXwvWiWN6UlLf9bMU0fUgmzu1KKnhMIJ9Hy55FgCPOixrEOvuQzZPj/v4P5UujrJ8
	bYLGx/IkYGUMGVlzxmcHQss36ml38LVeimCxOONeJXJ3Dft7DUzw7FfnJj2rTJRyg/EeaFaFLmQD5
	wHCmmC/yj3XTDZVcklhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0JZN-00000004z0U-02pS;
	Mon, 14 Oct 2024 11:49:01 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0IoM-00000004npi-06qx;
	Mon, 14 Oct 2024 11:00:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5428F1684;
	Mon, 14 Oct 2024 04:00:55 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F953F51B;
	Mon, 14 Oct 2024 04:00:22 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 19/57] crash: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:26 +0100
Message-ID: <20241014105912.3207374-19-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_040026_127702_2457ED95 
X-CRM114-Status: GOOD (  10.64  )
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

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Updated BUILD_BUG_ON() to test against limit.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6eb..978c600a47ac8 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -465,7 +465,7 @@ static int __init crash_notes_memory_init(void)
 	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
 	 * definitely will be in 2 pages with that.
 	 */
-	BUILD_BUG_ON(size > PAGE_SIZE);
+	BUILD_BUG_ON(size > PAGE_SIZE_MIN);
 
 	crash_notes = __alloc_percpu(size, align);
 	if (!crash_notes) {
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
