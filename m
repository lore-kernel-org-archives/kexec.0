Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE0FC46CD2
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 23:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bvA/VGn6RXt0+UkQpEc4Y7w3GoCpVEfUXJa06IAdw3w=; b=r5aYgDs2Ibr7aW
	GhoOL1P6Othp/EfMQFV4iq2mjZ2hQxmNC7IOFmX+HkBS1Huyy+2c/rn6CSuVO/oyMpsirKWXK9tOt
	KHXqyiOdkXUSGBuyqnJtywUeaO2FNGIN0cdRFoy+BYRRBgvOGtfSX+4OzdcqB85mROctZKv2JqVwa
	S4Swb8MXW7WAArWIsflkcXChRr6MO2/0vu8Pf3zFJK3uG3tcc5lT+IzuBpj+E1vl2RqO3PvtgwQJs
	cZXguJlWUu8e+QuiMNMaTFSqSOajjNlMwwD25RjMdz+W0BaG9LXpQ8IB3JJTjp02tPUQuQysUkDNE
	v5vs5vk7PMgTIPwb/egQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJf-0072ot-1P;
	Fri, 22 Dec 2023 23:52:31 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJc-0072mS-1O
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 23:52:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703289148; x=1734825148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmHTzPhpj3spFr7sD+uYe+dYLZez9U51K7ihV5uRElk=;
  b=M1A3ifBdAYRgveAUrqQHyVKkzNGMLExhSHJLd3uDvnq5kaCzHDQ6HUjO
   qv7BUWqjBpcKK6tZcuopmlBuN2Rxrm3Mq77B+REzLhsLUtj84BLobKj8V
   u/Pe1MPrxZK7yiSuU6xtjEtJHj3dH4tlWSuOTJ8QSMfmMYGtRCRthatGn
   p0NAUqjp0YDYnR/p2Z5YKFROi4c6hpM8/ehaUHods3hy1cz7YMMe06jXH
   pjqvV48SYvFABfWecA8v/oxjMST+LahcDYC9Vuz1o19cydsT6zFfnYqnf
   8iebEAcRw+UrwkH2q7qLGUHfkhw+X6pwgSMSK8hSAmJGdJyHkVOKFqxum
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395063281"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="395063281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="900622983"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="900622983"
Received: from jeroenke-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.35.180])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:14 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id E1CBA10A465; Sat, 23 Dec 2023 02:52:11 +0300 (+03)
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
Subject: [PATCHv5 02/16] x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
Date: Sat, 23 Dec 2023 02:51:54 +0300
Message-ID: <20231222235209.32143-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_155228_490539_7FBE69BF 
X-CRM114-Status: UNSURE (   9.82  )
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
index 7f164d38bd0b..cf79ea6f3007 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -6,10 +6,10 @@
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
