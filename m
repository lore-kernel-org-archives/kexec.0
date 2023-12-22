Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA06C46CD2
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 23:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6hB6j46Hh4ad5O7p/bGFTPNsDemOnd7ibwn250O5yEo=; b=onO+D2vH5lMTCt
	+7UZr69osII4AZnY9ARiyiKhUF7hsVmaEjQ0+hGsjK/vG4iiXUUSpZDTnLq+SARTXzVAiRtBDT/nF
	m7LO5dlct6W7L0Sd26vDaicxuUrm7H8Xcsd7kKHlG6P5SI2yCqFhMmHm+UB5LiCH0DCPNqSus1wp9
	a6n4SoeHLZMbcqlwML2v+JyYdQ/++Li9n7UZzQ2G49hU6lZodYtsdV7swFvbKr8rIHbYD++HL4wBC
	pxnLwQR4dtCN6TO3EXuuVa26KLfqeP7sscR/6j2RpHPYsFhSO3lC85yu53X9QToHlm7vRm1oSrcWP
	Wk8mrOGX28y7Bh2pDX1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpK0-0073CO-1I;
	Fri, 22 Dec 2023 23:52:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJy-0073AF-2T
	for kexec@bombadil.infradead.org;
	Fri, 22 Dec 2023 23:52:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=n9Qmvgl4wJELoVDkyi0p6dG6nNIJb3dXiVHxgEQLm1I=; b=PAr5/h9PwHUyPZLHeG7SVodct5
	PeJFyW0+SRHk/hUSSEoadimuoTBm0BpXQxY/MRAdUulkz3vCh6l2qD2hiWquPOCwlaJrDaeepFQaP
	O1p+HE2PWUbhOwIg+VfSMMT/zuagAtii7say7y7i8vR+hn6VCh4a5EA5KET5QEFqGVlW5YL+ndWPO
	aTGepwnZT6/oyBDrpqclwbxR42GNDzVX0GFGmMQOe41pNGRcJH/sQ6a61VamSnqvUWN4GF6jOWHFf
	GzPV51I85FouXBEmvZXggIkmqV9YfxfBKMBWYZ3NNBDp8ecbAma5WAMdVuuVJLHqWlXejiiTzJ6Qh
	bX+0zjBw==;
Received: from mgamail.intel.com ([192.198.163.10])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGpJr-00FQMV-2P
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 23:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703289164; x=1734825164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=baddqEIghmkFajP6rpIfXbNavqQAwsBb4c0/kd75gPA=;
  b=e0b10W7nSOVluIQ1002NwxbNchr/uyWOG17FBfJsFHqkslOoRhFgkWUK
   /ra44TcQnQtaYRW3Q8ygdumcMqA4m5Iy/uBg+fiNV42In2UvMjqX+wy9Y
   Ct2rLXYsNKfXMLnf8BIyvwB1wEGHoOcHZlAJrFuUaldGrFBXAA4s9mjIH
   uLPKX4ssbgWHjCAMMkTph8ezlbbVAei+d5bIhasaCewpfPi1JGtKpZbBX
   R3hXuVpvqaKfYMHRZ0eXjouEoIa+5NMtE+V6iwGkDYcAkLUQW1ymvT/bj
   5SGNLnQPJw/kWR5sdnD/8JQzabSYwRVGYpAhZ2zvGXwmqQgTeJe7s878g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="3414379"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="3414379"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="726961497"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="726961497"
Received: from jeroenke-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.35.180])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:52:21 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 0DB1E10A47A; Sat, 23 Dec 2023 02:52:12 +0300 (+03)
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCHv5 05/16] x86/kvm: Do not try to disable kvmclock if it was not enabled
Date: Sat, 23 Dec 2023 02:51:57 +0300
Message-ID: <20231222235209.32143-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_235244_277784_8A341C6D 
X-CRM114-Status: GOOD (  14.51  )
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

kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
present in the VM. It leads to write to a MSR that doesn't exist on some
configurations, namely in TDX guest:

	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)

kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
features.

Do not disable kvmclock if it was not enabled.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
Reviewed-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvmclock.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index fb8f52149be9..f2fff625576d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -24,8 +24,8 @@
 
 static int kvmclock __initdata = 1;
 static int kvmclock_vsyscall __initdata = 1;
-static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
-static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
+static int msr_kvm_system_time __ro_after_init;
+static int msr_kvm_wall_clock __ro_after_init;
 static u64 kvm_sched_clock_offset __ro_after_init;
 
 static int __init parse_no_kvmclock(char *arg)
@@ -195,7 +195,8 @@ static void kvm_setup_secondary_clock(void)
 
 void kvmclock_disable(void)
 {
-	native_write_msr(msr_kvm_system_time, 0, 0);
+	if (msr_kvm_system_time)
+		native_write_msr(msr_kvm_system_time, 0, 0);
 }
 
 static void __init kvmclock_init_mem(void)
@@ -294,7 +295,10 @@ void __init kvmclock_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
 		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
 		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
-	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
+	} else if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
+		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
+		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
+	} else {
 		return;
 	}
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
