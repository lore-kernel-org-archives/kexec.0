Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7E9C4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 00:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=50Gi5vq/M0Uos141HbTZddiJoqWc2tDVg0WcWL+FpBk=; b=4J4j+0sPhvXClD
	Y5REAUAIB6/1VJsAL/FXoO+76HP2FEAaQXlbx6411aZuNgijkl6VI8a/B8xLyGZ8DfLe5BSNCOd5d
	b/s66K6sHdk+KdkMgYjTnY5zMpI6Lqy78ul/VwICY5bRXbeMYkVyOx0A+ycY2Si0gvjyB63dFsrdP
	0duJj1ZKPHYKN6KZ9HbLoZvWAxAQ0UU7wmj9l1Y9iGf1Fe+jrhIUWoWWSQJXDpWUgvzv8Bmu0/o/b
	IxCMbUi4yj73G5seKwFL85/3w0l4EnToU0XsahNThYv5xh//j2ALVL5rs16Ma9gbOSRVGLrH0vE3X
	wePwyoj6e0auKFP4IYcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZV-005tyv-0Y;
	Tue, 05 Dec 2023 00:45:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZQ-005ttu-04
	for kexec@bombadil.infradead.org;
	Tue, 05 Dec 2023 00:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OGa5Sb5Yd3bKocaXY/zr64R6NWyKjWK7l9b5pyL/EV0=; b=rNDXlJb1SYDcFJKXGHQTsblDkZ
	Kvv+ordiq544XwISXCj4n1pHjB36TTNHDw0vvFrMsJAZgUjnYNeC4LPCakEhe3+xyyO+yB+dufi16
	Rv/IC9HGZ5jzQaQigAnFVTCOmUJE+L+gU/5UEH6ZD7/n2Qz0cp9SughntzYXy5ufB/6wpu23xRcp9
	35kgHwq8oLi87Tynw0Psp4zCT9uLE8AqNz4WFvZucqRyUlj+2P8wBe6dqsZCwvur//1Gt2w5L6lWM
	M+mhqU0YXJrrqJ32QIZ/rPQYRnsWFfAPwx1Adu41LrlFgbj5VLn0mUGOC10D5EODHmcU3BSKQhhXQ
	Q3/lDD8w==;
Received: from mgamail.intel.com ([192.55.52.120])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZM-004V3I-0R
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 00:45:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737148; x=1733273148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YaJcwdfsbT/u6tJs5uRbj4NUFmy4HkVgm/EwY5jjC6U=;
  b=YB+Ci6/pQ1ToRQ8s5gmW6mE/ryS/0OAn8bUqMb+esvpeOO9/bIkQqZnl
   UCdRto/dbSmZCjsmrGF48PAFIYe9SUCFTT7DaJc7TCVbt6brHdPZBko2z
   OUDKHL90RGb4Y71xPuNnzlRa6JjfmgIDBYxfsxsF7jxyoE3KiTs3rXfsW
   8Blc4MFc6kUlMKeBvKuWHC9FkRY8WDV+mu939ud1RRQkWphtlgF0A22sO
   DffF/Nar23UCR7rEIYRZR8Fm4VYpMVmyH5d4DYQo8/OIRRB+OkYEKRdzm
   DO7oxyZNevviyl8/E9MbgRNcqQyCng9qjOyGc8s4w6txNhKmy7SZ3AWl9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392688747"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="392688747"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944067956"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="944067956"
Received: from abijaz-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.240])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 9FC0810A44E; Tue,  5 Dec 2023 03:45:20 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 11/14] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
Date: Tue,  5 Dec 2023 03:45:07 +0300
Message-ID: <20231205004510.27164-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_004548_721284_F6AB1ECC 
X-CRM114-Status: GOOD (  13.50  )
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

e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
things, guides where direct mapping ends. Any memory above max_pfn is
not going to be present in the direct mapping.

e820__end_of_ram_pfn() finds the end of the ram based on the highest
E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
calculation.

Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
tables and might be required by kernel to function properly.

Usually the problem is hidden because there is some E820_TYPE_RAM memory
above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
can fit under the last E820_TYPE_ACPI range.

Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
E820_TYPE_ACPI memory.

The problem was discovered during debugging kexec for TDX guest. TDX
guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
it between the kernels on kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/e820.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index fb8cf953380d..99c80680dc9e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -827,7 +827,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
 /*
  * Find the highest page frame number we have available
  */
-static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type type)
+static unsigned long __init e820_end_ram_pfn(unsigned long limit_pfn)
 {
 	int i;
 	unsigned long last_pfn = 0;
@@ -838,7 +838,8 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 
-		if (entry->type != type)
+		if (entry->type != E820_TYPE_RAM &&
+		    entry->type != E820_TYPE_ACPI)
 			continue;
 
 		start_pfn = entry->addr >> PAGE_SHIFT;
@@ -864,12 +865,12 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 
 unsigned long __init e820__end_of_ram_pfn(void)
 {
-	return e820_end_pfn(MAX_ARCH_PFN, E820_TYPE_RAM);
+	return e820_end_ram_pfn(MAX_ARCH_PFN);
 }
 
 unsigned long __init e820__end_of_low_ram_pfn(void)
 {
-	return e820_end_pfn(1UL << (32 - PAGE_SHIFT), E820_TYPE_RAM);
+	return e820_end_ram_pfn(1UL << (32 - PAGE_SHIFT));
 }
 
 static void __init early_panic(char *msg)
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
