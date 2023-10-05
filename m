Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6464E9370E
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q2f9EgKJiiPE/8RkPW9SKafUdXUbyMzPOVH0hOUewnA=; b=vcB4i48NMyDPHG
	IQfH93oC9e8cqdQ/1W8sDkWCLCaayz6Uq7tNTtPy9BOMJ3pW6+3cKnsUc8VCCSUJmk25yOhfsChq4
	nNE8488XqUr+HsR7+zHCUqF9BYAzqQoZKeBY4YkKgEco+HStJNyuExbhCcnmNvhjtPr5tRmejCw/+
	tl5SwWOSb7CMV+LNUYNF3+PCemnlfA+qc4mwBPjjg2u9KRF+TVX74YvPR+88XNU2D4dru4gG3rX1Q
	tgqG/L3Budqh9enYyucpf4dugXGlpHmfgTmfZUqQL2hcbFOYbYMAWd6cxfv+yXYUb8dxD7fmdCYuK
	DoSm2tkPx2OjdqpPsPAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoODl-003Gqp-15;
	Thu, 05 Oct 2023 13:16:53 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoODh-003Gkh-2T
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 13:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696511809; x=1728047809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsB0LfqQYj2RZjcPwh1MZGMdJcZ9TNW2jF9KJqnidVg=;
  b=YHNeZIN9F/5dLSirXoA8qSpmIwuxT+web0TJH1FE83kXXP/xBeNCl2Nf
   pN3uUE5dN1Vf05ReZ5H0gZtSsYlJZ56mriMu/fIv2NDo8UoQQvdmVJVYW
   yxZIMpyvCGgDmDNHfFpV1FcPcogiegFnpjQWShmceXSUaGemBkfOtIc6e
   fWEK1Ukwrq01Zfw+LB5OU0YjjBYZkQFMwCnhGg8qKSaVwSow//gHLByKo
   IjBdRTvUhkCno9B8UD/Yj0EvQ6Wduo59mxzUfdK8Ep4pH40+jSP40a9SI
   R/CA28Wp1gA/bSY2RrM4nDL0MSHPlTldxJ9SI/suKNSPUsKs5Yz61kLxQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380767193"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380767193"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="728449270"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="728449270"
Received: from skwasnia-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.222.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:23 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8835310A157; Thu,  5 Oct 2023 16:14:14 +0300 (+03)
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
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 12/13] x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
Date: Thu,  5 Oct 2023 16:14:01 +0300
Message-ID: <20231005131402.14611-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_061649_976452_4AEB1A50 
X-CRM114-Status: GOOD (  15.46  )
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

ACPI MADT doesn't allow to offline CPU after it got woke up. It limits
kexec: target kernel won't be able to use more than one CPU.

Zero out mailbox address in the ACPI MADT wakeup structure to indicate
that the mailbox is not usable.

This is Linux-specific protocol and not reflected in ACPI spec.

Booting the target kernel with signle CPU is enough to cover the most
common case for kexec -- kdump.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 15bdf10b1393..4e92d1d4a5fa 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -9,6 +9,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
 
 static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
 {
+	if (!acpi_mp_wake_mailbox_paddr) {
+		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
+		return -EOPNOTSUPP;
+	}
+
 	/*
 	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
 	 *
@@ -78,6 +83,18 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 	/* Disable CPU onlining/offlining */
 	cpu_hotplug_not_supported();
 
+	/*
+	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
+	 * It limits kexec: target kernel won't be able to use more than
+	 * one CPU.
+	 *
+	 * Zero out mailbox address in the ACPI MADT wakeup structure to
+	 * indicate that the mailbox is not usable.
+	 *
+	 * This is Linux-specific protocol and not reflected in ACPI spec.
+	 */
+	mp_wake->base_address = 0;
+
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
