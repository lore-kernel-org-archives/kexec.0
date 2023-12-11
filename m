Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D7C4332F
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TzAANNlr70JEB870DO//HaFRIrlmLxRVHJPfk9R9Ld0=; b=Ib4MXlVXu2a72E
	H12mFO2MXx8Px5InaSNKeV7kK1aHFZWLYXTsukeqGU2XEVNYojKtI000FyrlaETkxZx4kYMspmGH+
	dmXDEIKHeUX5j2qNVzDVVdmNLUkKNjwXpUVAa6EHVyWUpXE0B9Z37iqxuqlaB2S9eLizEAjc7k/R4
	udK31tJjvA91yEabDJRYWEzSZjO8I0ivAcVfZyRziKita5KshIvlMW7gxVsWz/pzLNkO5nOP2HUzM
	vLGsgAK3d27vnwEH2AnqXy1FaoCWiPvZeGXlo6unsmNpOGWpCLVwnnrT3mDqMlTeK1JIUaPLVg9kV
	Ptf5yFTMwUkGt/ruuoFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCpQH-009Y3a-2Z;
	Mon, 11 Dec 2023 23:10:49 +0000
Received: from mgamail.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCpQE-009Y08-0V
	for kexec@lists.infradead.org;
	Mon, 11 Dec 2023 23:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702336246; x=1733872246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fdZ2x/5+NDcHqfPGDDUoiJaMPSKPPuvvjvF9z/kpukA=;
  b=PWFH0NxpyX8/GaUPcoDt++9+m/lPvolrrco+B0ISkM2CkcPy+wlEAvQL
   //mkXDHm28iEW0CHm2XqLu5Nbyp+JWd2RfHJO8wNhuJHCbd4XC2zvS7rD
   03WDIWfaEhtD5K2b2N5D1CqntJf8ihHVuOUdPUhGRi/247JTlEQo/uEIa
   PFZ0Q0auTeJ0qDBqsIwki7l5i4HDSnMk1XQls7jLEw2dOGaSTToLrbKdU
   6T71vvctxXnFXUhyaFcx2oBXgP6grcUzmME/0ZE3KujsjYDDRT+ImwzvF
   iWQQZMYMsY/0E43Q89TgrTHg73rxiSaMF4QBIO1nXBNo29y19SKo6RAcY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374229718"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="374229718"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="722994661"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="722994661"
Received: from liviuoct-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.47.81])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:10:38 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 9998110A290; Tue, 12 Dec 2023 02:10:35 +0300 (+03)
Date: Tue, 12 Dec 2023 02:10:35 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCHv4 05/14] x86/kvm: Do not try to disable kvmclock if it
 was not enabled
Message-ID: <20231211231035.743cesujphsp5eve@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231205004510.27164-6-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_151046_213411_8329D1D5 
X-CRM114-Status: GOOD (  12.33  )
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

On Tue, Dec 05, 2023 at 03:45:01AM +0300, Kirill A. Shutemov wrote:
> kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> present in the VM. It leads to write to a MSR that doesn't exist on some
> configurations, namely in TDX guest:
> 
> 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> 
> kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> features.
> 
> Do not disable kvmclock if it was not enabled.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>

Paolo, Sean, any chance you can get it in through KVM tree while the rest
of kexec patchset is pending? The problem is visible on normal reboot too.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
