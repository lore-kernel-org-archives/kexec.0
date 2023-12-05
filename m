Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA5CC4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VJDoT/n8F5rC18PAunis/3Z6A6ojy1yAly85BSVAb1s=; b=LekiH8/DINcK7R
	ppoXDHNiGjW/QlRA4lgImHuKGlB+QRmDxS8Vpelr4rKpWQIFKgbzfA3dx5J9CyWhZP9ObwPVT0KGQ
	Zr6dR9Mp/sjBPyowpidU/DWjQHv8vSJ6d/3F5BECLTKDigPFmBpi+IVQunR2dfQXUPNrpxLWiZmy1
	8keIBI4wcAKdmkXLNaumMKaO7f0AbXt6tDfO6wXMYWgWnUfZbZ80Pyo6ne9Y/G8w6M3kIA4xXezqk
	rgR6+l4k6o88KS33bGoCQu1h64sXPgB9tiQpN32Xojj+ffDysrQghF9m2A+uackpIO5HBiHRsxehk
	pN5KLIETfdg+8Csxbimg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZR-005tvo-2j;
	Tue, 05 Dec 2023 00:45:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZM-005tq5-33
	for kexec@bombadil.infradead.org;
	Tue, 05 Dec 2023 00:45:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2QApud+Si4fBkF6IRq5Uf9OvVaHBPaEKNYV+SCrlMVg=; b=IWWjE6cEPRupLA60eHF9evZT96
	gW+EA+q6nlq8gLxjkP7At+63AWPAFPwQJ+4/zL2cMVvuz8yiuYLtbF2iuOuRPukxjxzt2n7T6rUTl
	U4BWvtHkAxS9SM4svxPtdTh82k1dM1+6fxyASGQwMAPkJdh33aqFnEIqo0qfDTR+kx7H06GtCMvdt
	2fmVCkGFFLVGB3+ybNAD32AdroFDBk2WQZ9HgPx7jaZnK7wvWSuDLuJGlnxViTeSmh7oy8aRo7SJb
	s4EK6FdiWC02BHHIy2sl0psXGCUOeLihRHMYEV+0LoyjQoCTyKLYY4tmHLJnsLf1uGgPI4zPIR2G4
	/8EwWmZg==;
Received: from mgamail.intel.com ([192.55.52.120])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAJZI-004V3I-1L
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 00:45:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737144; x=1733273144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X/WHs4jb2k1fyD6oT320fhQc0wtdLRiTKuUWbSP8aYs=;
  b=eVvyawvUq6V+YPqCw2ooqGWGVSlk7Tr4crj2DprM1bTe58uZN+Kv581k
   uYBPNXl3bIMiTSILwgUV+SMphdjDSUO7GbI2Q/EQZ40bLRERPw11TGkSn
   2OFTjk6k19Q9m8uZbDQTqgh1JE5LQyT1ZLPtKqwnklM4GShrqZM5NbxgV
   tNYjKGL4oBVTjCK79k39MzK53qow7+RW4BrMtdX72VurjNzE7wDhITDpv
   deNWLzp7h+lpF+QGhk4P53RkaWtFF/I6hBZxG0GuScMTLJqln2WH3z20s
   3joB0QLkJACkIEuxr6RoIh2hnSJndK765/06DOj7KMR9ezaUrfyGs3Fin
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392688692"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="392688692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="888704411"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="888704411"
Received: from abijaz-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B75CB10A450; Tue,  5 Dec 2023 03:45:20 +0300 (+03)
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
Subject: [PATCHv4 13/14] x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
Date: Tue,  5 Dec 2023 03:45:09 +0300
Message-ID: <20231205004510.27164-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_004544_934335_431F349F 
X-CRM114-Status: GOOD (  16.56  )
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
kexec: the second kernel won't be able to use more than one CPU.

Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
The acpi_wakeup_cpu() will use it to bring up secondary cpus.

Zero out mailbox address in the ACPI MADT wakeup structure to indicate
that the mailbox is not usable.  This prevents the kexec()-ed kernel
from reading a vaild mailbox, which in turn makes the kexec()-ed kernel
only be able to use the boot CPU.

This is Linux-specific protocol and not reflected in ACPI spec.

Booting the second kernel with signle CPU is enough to cover the most
common case for kexec -- kdump.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 386adbb03094..5d92d12f1042 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -13,6 +13,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_afte
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
+	if (!acpi_mp_wake_mailbox_paddr) {
+		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
+		return -EOPNOTSUPP;
+	}
+
 	/*
 	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
 	 *
@@ -78,6 +83,23 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	cpu_hotplug_disable_offlining();
 
+	/*
+	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
+	 * It limits kexec: the second kernel won't be able to use more than
+	 * one CPU.
+	 *
+	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
+	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
+	 *
+	 * Zero out mailbox address in the ACPI MADT wakeup structure to
+	 * indicate that the mailbox is not usable.  This prevents the
+	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
+	 * makes the kexec()-ed kernel only be able to use the boot CPU.
+	 *
+	 * This is Linux-specific protocol and not reflected in ACPI spec.
+	 */
+	mp_wake->mailbox_address = 0;
+
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
