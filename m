Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85828C0032E
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bxkcJY8Kx51W1XOS4sJmh4BRZr5zN/q0DokLBlNCqJI=; b=YSz3xZ/jlDaPSS
	eoxFUnwu2msCXnV6EH9ivhCbCVGMvvOxQy9J5pFV/Jnls3GuKyqGYyFZU+BcEnUxun54EgVuxkfTC
	+vjtWmEYDU1+WRkjFxoZjksp1+1LUOhh7XIMPacaGeFlgsHLNZTwgasHg3EpCnX1eE3yGvBcJAk0a
	FuuaZUDCN6s5ovAIDdrZEbk3Xj2f68wPaWEfM4iMGeTchq3nnDhwdr4f9DMogr0hLKjOcL0hPddzd
	hZ3sa2Igizi1Zu4yiuLGIek6BtEa2ICvdm2pr1ZEpMKUBOG+/akJvSdy12eVIrrsr6RyRdRfziRjK
	KDgJVNMr2xRyexyNcJWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrBW-002Zkm-13;
	Fri, 20 Oct 2023 15:13:10 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrBQ-002Zcr-05
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 15:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697814784; x=1729350784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPIjCtbNsICrtwqXzYBNDwDeX3sLS3gFAi6SoZOpAO8=;
  b=ASf3+NNvmnqZXAycQ4dL4/FACr6v743C9nQp2wjhWiqFnW6oHQ4zBABu
   urDw9/C2cqCU8R7fUwhKazUWoybEkYCmZ8lHeyE/citNjQoBHn3bGiE5b
   nP6MbmXF4hxoDk3jOXbTSe98DhJ41XIgnctazbYPZbdtybFBTCFiRmNlF
   N+Oi48XD9maD7PKvY121Z5ENwK6NrqN2rLAPG5pYrQ9vTl74t/K9mIopj
   le9EGL9iEfkY/cxCJM7EWAX9c3DHnnIR0qrqarF9WGYuJwR3UOWc5BJKf
   JvM6ZO4Z3lEQ6+HCxhNgiqAIz6+zVXKgto9WVbB69t4/60xjLKrt+i459
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="376893627"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="376893627"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="761080250"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="761080250"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:12:48 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 10D5D10A296; Fri, 20 Oct 2023 18:12:45 +0300 (+03)
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
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it was not enabled
Date: Fri, 20 Oct 2023 18:12:33 +0300
Message-ID: <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_081304_173437_A6BBA7B4 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
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
