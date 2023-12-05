Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CC7C10DC1
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 00:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MScplBDpY2iN6TyDMVt8jUFbI/VWEm30YW6CfXDGnIo=; b=uRbeDJAMau74lk
	2q4J9Ynhp0Wl+zmr7TQCQD+/wRfEy02H/UP+wT5ACk9IryycoqRHaJr+Aj8onMRJqaQUwnwzBdcB2
	HRUqKawVB3G1xwcH7XOgtxYk0wlpUkUYmQeTySoqhIKiCngQiMNEDAs8ySSDFxIlPplo8XwSy97rt
	QV+mMPGWDpJJEfavhQCZHBiJ/7KooYRxWwtveqzBr5DfyEeA8ih4NA+mHIPVqX/zf8ddhgKoIeVZ+
	YBH1K7Ku5e4Ok5SaQf1lrY8NwSGmki283uQAAH2rmEdnrkKk/0MDaIwKfNkYOKJyhv8ZiXUaUIchz
	TgSmG8CHcWPV0q1MTpzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZD-005tg0-0r;
	Tue, 05 Dec 2023 00:45:39 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZ5-005tYa-0d
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 00:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737131; x=1733273131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rRqk8Me3Mc+00KtmumlNI0KQ6itAlytBjh04y1PXAoM=;
  b=atTeV75Qj0+OKnaE+JDZfaFX/WYO0lP5xw6ncL7VLTuJx11EHsg0499C
   SAlZM7lTpmcZjfCus7U8YzXxYnWAJD2BX2N3MmsHKg98BaCgXZqzaQN4N
   jYygB+crbNL2MuvdA2WUVw4k7qsNe00N1bgxCoVIde5eNnOVm0VlXD2T9
   IBW8B/ytMhwhIgjoXxLAoEGrXIFcoP7dNC4bla/4GH2w/EozlYQxw4Xkz
   eUw5p1onwYgkWEZpHWyE2L0y+9sb1AgttVDKS6VqO3umYu0VxZq7wT3hi
   JfTzzmVt9RsEQyF5cmTDGFg54HUQ7BhRmG35GHJ264rZ0yj38ZulAmwk/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392688653"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="392688653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944067918"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="944067918"
Received: from abijaz-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.240])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:23 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 42E3810A440; Tue,  5 Dec 2023 03:45:20 +0300 (+03)
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
Subject: [PATCHv4 02/14] x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
Date: Tue,  5 Dec 2023 03:44:58 +0300
Message-ID: <20231205004510.27164-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_164531_284561_78CCC4CE 
X-CRM114-Status: UNSURE (   9.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox initialized once
during ACPI MADT init and never changed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index f4be492b7e4c..38ffd4524e44 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -5,10 +5,10 @@
 #include <asm/processor.h>
 
 /* Physical address of the Multiprocessor Wakeup Structure mailbox */
-static u64 acpi_mp_wake_mailbox_paddr;
+static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
 
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
