Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0A3C54764
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/E3HvWQGAhs8g3rgSAUYEtVpi4wGLGvgcL6NxTEogzs=; b=dgCrg1fdUdzRDG
	++O8AhLlP6piOtb62wwfWPyZCzxcTb42nC9OMSZk8DN30BmAOfbiTm75cnubvqaNgr03uHL0et6yA
	/XEfxDRaEz2bpKZT2glrg788KPjG6puaL0oM246C/NagI9Xnc7tKO5gWXNxX+fssCOL2ewbpPn8og
	aDbJpWx10NDVLG8E64PzNEcIXtoEA3j+9LRLEypNMEcSPKLigBYdPLV5AYylDqo2idZOkCPAro31j
	ToE1pIRzJT+PweM2FtWUX/ejNfAiJHTJ5F+3awU7bhD/26MJJFmjMavrWcpVZ3jFEZ2eKU3fpn9dp
	Ab9gMKswR4yMNK5fn/EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc0Zg-00000009xwd-3O6X;
	Mon, 19 Feb 2024 10:08:36 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc0Ze-00000009xw1-1G5U
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 10:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708337314; x=1739873314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TR8HS0OFrh9aNH4iX7ntd6fP5lH5BPlQhF5iDC7RPM0=;
  b=b9rCvui9mMy3/SUy3MOYbOSpqNp/hPSLsEPrvaNQnXFH5sEDsnh1z//t
   1tZpfg5Seb8IXmCJtjjBHQtXsHkzS7iRzddBNrX4zjnLVkoCX5O+j8sKx
   P0DucdqSjl5lBQe6fxqaux/zS2mTJLiB/fxZ6bN3boKv9oFuK94HmBH1M
   eW4CIcrzkDizeHaJ7iv5wWhzUpGME8Tqg4xHXXPwysSEx9y3gUk/MKL8a
   wYGbYcTwgGac87JX/qVLTEolgp10wOSSvge9NOlLXJQNMzWC7g7DWd5Xn
   34pC4NA+hXWae6XaFVUYjje6EK93dLlPAi5GRnXOVlqBMXrRFs2gRndD3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2532838"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2532838"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936268601"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936268601"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 02:08:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 96E9B34B; Mon, 19 Feb 2024 12:08:26 +0200 (EET)
Date: Mon, 19 Feb 2024 12:08:26 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 01/16] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <a2cmua3qhbmhgzdxl5mszuvatnkyf4nwxjciurguhgbulrhin4@gvswvfats5er>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
 <ZdLc61QMLu3L0Eqv@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdLc61QMLu3L0Eqv@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_020834_436810_7E6E9C90 
X-CRM114-Status: GOOD (  17.10  )
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

On Mon, Feb 19, 2024 at 12:45:31PM +0800, Baoquan He wrote:
> Do we need add the entry printing for ACPI_MADT_TYPE_MULTIPROC_WAKEUP
> now in acpi_table_print_madt_entry()? Surely it's not related to this
> patch.

Good catch. See patch below. Does it look okay?

> FWIW, 
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks!

From 23b7f9856a3d6b91c702def1e03872a60ae07d0e Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 19 Feb 2024 11:58:19 +0200
Subject: [PATCH] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parse

When MADT is parsed, print MULTIPROC_WAKEUP information:

ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])

This debug information will be very helpful during bring up.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/acpi/tables.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b07f7d091d13..c59a3617bca7 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
+		{
+			struct acpi_madt_multiproc_wakeup *p =
+				(struct acpi_madt_multiproc_wakeup *)header;
+			u64 reset_vector = 0;
+
+			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
+				reset_vector = p->reset_vector;
+
+			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
+				 p->version, p->mailbox_address, reset_vector);
+		}
+		break;
+
 	case ACPI_MADT_TYPE_CORE_PIC:
 		{
 			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;
-- 
2.43.0

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
