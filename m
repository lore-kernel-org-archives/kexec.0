Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA130C10DC1
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vfkdz5ZqKitN8ezPZCLLEisH7OfNH0rqwKjl/FOr/3k=; b=ZSjQSSgcgc6gQ+
	jPmV//7RxsPtrg6sBqFOYdX9ekhOvxyjdnIw5h3khIckmWauS8LyFfIccLklCeS4xlmwtqAIc2VpG
	p1yIjClHWD1wwjtNJiQBCcoBb/cqmGpvUufTIBP9e9xKC+E2DNnqfz4yTfueWfA/2VbhPJayRub7p
	2wWF9ye9Y5PhlXLvNu+Aj6t5aKk3Gz029eVy/MlDDADbYblSbVDHKNZHc1ly5XIFAXEH7aQAuaFpv
	2e/dMUEPb+CFdhJx+Kn/fL0TQHoTz8JmaRn1xzZEV4bU6gtN2voW+wx0N/mB7kylNReCmCfXMmwvq
	BMZxiu6wJNLpg19oBfSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZQ-005tv6-2w;
	Tue, 05 Dec 2023 00:45:52 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZI-005tYa-2V
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 00:45:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737144; x=1733273144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hDA/+p+nxM87pJNv9Ukdh1cz+IjWMOLujDQdnMnWdrA=;
  b=Nb53jVYXduNwJ7YtJYRPyXHDo9vYtxvCeADZaZAB7Zr+eJTzuhwPGInc
   2CELBc3vXHIRiV2ODDNVqc4NU/1R4jdj3cdMUXunQOHfT2OacCudMxJ6F
   sOQs17WSDuX6D5oNmiKsYEI2fB9Sg7e5gBNUMpDed/h3TYXLQsq2MMptx
   Fc4ADRQu8otMjwpZtEN0B/13wkiFSm1pncAMteqjB8U8prAtNHUP09yk0
   XcEL0fqzPnlod5/IMfbvHNj685tk041lKMVzxgzyHKK3FKlqQAfNR7OdN
   eM3Y06H/LvtQw678tDChKvZzVw31FNgDqWwPFHpAJ3V//Hdi7gOwXMpVk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392688736"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="392688736"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944067953"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="944067953"
Received: from abijaz-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.240])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id AB59210A44F; Tue,  5 Dec 2023 03:45:20 +0300 (+03)
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
Subject: [PATCHv4 12/14] x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
Date: Tue,  5 Dec 2023 03:45:08 +0300
Message-ID: <20231205004510.27164-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_164544_868527_B767E09C 
X-CRM114-Status: GOOD (  12.03  )
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

To prepare for the addition of support for MADT wakeup structure version
1, it is necessary to provide more appropriate names for the fields in
the structure.

The field 'mailbox_version' renamed as 'version'. This field signifies
the version of the structure and the related protocols, rather than the
version of the mailbox. This field has not been utilized in the code
thus far.

The field 'base_address' renamed as 'mailbox_address' to clarify the
kind of address it represents. In version 1, the structure includes the
reset vector address. Clear and distinct naming helps to prevent any
confusion.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
 include/acpi/actbl2.h              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index f7e33cea1be5..386adbb03094 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -74,7 +74,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
 	cpu_hotplug_disable_offlining();
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3751ae69432f..23b4cfb640fc 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1109,9 +1109,9 @@ struct acpi_madt_generic_translator {
 
 struct acpi_madt_multiproc_wakeup {
 	struct acpi_subtable_header header;
-	u16 mailbox_version;
+	u16 version;
 	u32 reserved;		/* reserved - must be zero */
-	u64 base_address;
+	u64 mailbox_address;
 };
 
 #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
