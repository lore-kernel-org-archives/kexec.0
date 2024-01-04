Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA14C47255
	for <kexec@archiver.kernel.org>; Thu,  4 Jan 2024 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tuOMfgS6v0oQxJlV3wRQYRN3Ew3ffiErbwPWRjMtP2U=; b=eADykvnooj97L+
	5WHVHTMmVrqXU/Z5JSzNexumM0kGaffSxzwxUXKgIhY252ozBPHyNyldiBjlbl9dlr8SP/Hn+abBJ
	ql1eU1O24LDz46DqeckUogpnALUn87Ps6+WV3OPxFr9XKZq2xg7Nst41Hup2jADBKWp+1z/2ANlPp
	/pdjNzv2Knuqrg32Xw4ACbrtrJ5FDjkH5UWgEmiRseWLYaM6+W9gOHqQbTjIxuakMcxeUbYeo8tvu
	ip3ec+j6Zyb0U3YlDY7l8X1/sSQbSKkKPMelCkLEpuzlK5Km2lnihPNd1akhcAAPtMi0W8QZBr/8F
	uJMjdOaLxeFH1C3GP6Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPIB-00ERMx-2G;
	Thu, 04 Jan 2024 15:05:55 +0000
Received: from mgamail.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPI7-00ERJv-0P
	for kexec@lists.infradead.org;
	Thu, 04 Jan 2024 15:05:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704380751; x=1735916751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jTNWC7v3qXqODsfpzwcE3CQHUSZdjh7Vh3v7ScwF4/k=;
  b=GgukGKOcCO9eLEKUI+rnS241Wu3gZMF9HM7Bcnwo+LHmLiLl9aawYgtv
   loAVLX4OdcB4/wi072z7xON0IlXXAF64aP74CYViecRhKRt0lw6QV2QjK
   rD3aSDETRRGkvIbL0jTZWRryumJm2IsDaulaYjR6PTDjEL2nOjXdLYkE4
   c3lSuufNwf/pZ9GxmnvcLyqyFgTbgwmPoH9pZF8OPWzHIZnC2M6dlZpsb
   HIFhU2BN4/kimwtHbRnYZ7qIIVXhkrW1JwUcJUFtHfJK20uXurlCsL4xY
   PaBXYx94BRMaR6rlcC8K05u0GDu0JJunI2GdQK/EFfmvK9sBSokGEF1hR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="428428937"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="428428937"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 07:05:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1111783591"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="1111783591"
Received: from dekblom-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.36.199])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 07:05:28 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8AC2A10A57B; Thu,  4 Jan 2024 18:05:26 +0300 (+03)
Date: Thu, 4 Jan 2024 18:05:26 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCHv4 05/14] x86/kvm: Do not try to disable kvmclock if it
 was not enabled
Message-ID: <20240104150526.52vbu4gownp7jm3i@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-6-kirill.shutemov@linux.intel.com>
 <20231211231035.743cesujphsp5eve@box.shutemov.name>
 <ZXnoWuaXvRkJjlDK@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXnoWuaXvRkJjlDK@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_070551_214877_550B73CF 
X-CRM114-Status: GOOD (  17.89  )
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

On Wed, Dec 13, 2023 at 09:22:34AM -0800, Sean Christopherson wrote:
> On Tue, Dec 12, 2023, Kirill A. Shutemov wrote:
> > On Tue, Dec 05, 2023 at 03:45:01AM +0300, Kirill A. Shutemov wrote:
> > > kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> > > present in the VM. It leads to write to a MSR that doesn't exist on some
> > > configurations, namely in TDX guest:
> > > 
> > > 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> > > 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> > > 
> > > kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> > > features.
> > > 
> > > Do not disable kvmclock if it was not enabled.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> > > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Wanpeng Li <wanpengli@tencent.com>
> > 
> > Paolo, Sean, any chance you can get it in through KVM tree while the rest
> > of kexec patchset is pending? The problem is visible on normal reboot too.
> 
> Paolo is going to grab this (possibly for 6.7-rc?).  I'll keep this tagged on my
> end in case that doesn't happen "soon".

Sean, any update on this?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
