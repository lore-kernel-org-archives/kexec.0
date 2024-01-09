Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9D6C46CD2
	for <kexec@archiver.kernel.org>; Tue,  9 Jan 2024 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rq/YySGNnpYo28hXZj6J6fhprzUyJnBusIP1PEye0Rw=; b=Qg8k7dVuGVGTQv6o3/Idk9kY1b
	cP1QENlejoJpoOz7Jy12DOWE1k2OPj0sTICKQk8E6OdDsqmnQABCiolmrO4cZyGsIE0BiyUvZkwT8
	UDMkMvPSl5Q1K+hr4lqRAL3kr/0Io9lxFbmufEt8ZsHV5RIL8ifQrOSaXS3q+1k4KlO+mL3aipoWQ
	DoytUxgpU8pB7w1wBCQ3Y0JulVKsOby4iNG5JvM2kAzYX6qYPlME28adl4nCdYmu/qF3j48sB/eK7
	qLLvq3txqlkmB8XtpPLEGf//qtuEuVEwXM+HEUjNCoS3Ue+Ntz7FiGDqRPUVhAUqYxuhk5iYbkyrY
	/ia01NQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNDZd-008bHC-1Q;
	Tue, 09 Jan 2024 14:59:25 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNDZa-008bG9-0g
	for kexec@lists.infradead.org;
	Tue, 09 Jan 2024 14:59:23 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5f8ffd9fb8aso25689877b3.3
        for <kexec@lists.infradead.org>; Tue, 09 Jan 2024 06:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704812358; x=1705417158; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRUOJmFKmeM5oqO379Ob7Dp8PcHF+ZNO7Gp6RMyYig4=;
        b=A/aNVG+d2QLGeCyuK4yc/lHmEZcnh2ApqeSLu9EVNdOiyhA0vSfv+jFfd0ijVKQ8pT
         mGfYd3NIxSILjxyrkGC3LuT+Yul7umYSS3b45yuCRAPEwHCIVDDs44ewJ9u6gMI8UXbV
         NQrvNZ/FGH/3r85iqdNsEmDBTkXi27zrzvEIFnz5/d0O4q4M4seVmB6YRGHrZ5MDrfeE
         9QZzwiRD+gS6HtUiWLDb/JI6WZbwr23ArP7FsJYmJdZWrB4dpvYHP+29y4VhHWonucqa
         EYPzr7IcSx35Jxjj7VNQXxovGXvX5Q33tYkUAiu5hUFLql8a/bEdGqk19rG0br2/wW0O
         dbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704812358; x=1705417158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRUOJmFKmeM5oqO379Ob7Dp8PcHF+ZNO7Gp6RMyYig4=;
        b=Ez2pKEm3yTCfs69Lyrsbh1/dnXEF0DrtvrAGHzLSWbmXl/J9xYgx8Gh3oAtVlghAyq
         5gZuk9R/Dhc0X6uxp6OP4Xz6BXxmUb6mXT3tsdByGpXYVjyrH2c9Z+dBSTxxGhdw0xZU
         /BkMo8RSeOw3czourKqaH2i2RlkwogJFG4v3e0j9ByF5H7jvM/2Xi43Lsnr+dVy36zW3
         /GnC65is75o42/auwX0RvbPcNMC6f+eli8lH6Um+6BohI72sAfCG5teCizLLbV9HVi1K
         hhPiVFPf0AqSlWYA/l82/ZlhuTgIbOiq7OFkGeaw47X9suSZ+j4ZI7Jrih92dCDYaPwe
         parg==
X-Gm-Message-State: AOJu0Yx3AxRnUbcmZU9L+OOoBc8aFnTUJ1yQJBChX6wGh+V6bHQUSPEb
	+AHg3dVNcELLZ6HOVA48tykTvAz5XJaBCVtyOw==
X-Google-Smtp-Source: AGHT+IGyHuCu911KvlgqonOQL2XqK0U7rft8u026+64TBKlTyRqGPxisRKRQIhISiOb7Znai4/AbV5q5Ek4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:548:b0:db5:3676:74dd with SMTP id
 z8-20020a056902054800b00db5367674ddmr2055224ybs.3.1704812358274; Tue, 09 Jan
 2024 06:59:18 -0800 (PST)
Date: Tue, 9 Jan 2024 06:59:16 -0800
In-Reply-To: <20240104150526.52vbu4gownp7jm3i@box.shutemov.name>
Mime-Version: 1.0
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-6-kirill.shutemov@linux.intel.com> <20231211231035.743cesujphsp5eve@box.shutemov.name>
 <ZXnoWuaXvRkJjlDK@google.com> <20240104150526.52vbu4gownp7jm3i@box.shutemov.name>
Message-ID: <ZZ1fRP434gsSKtcn@google.com>
Subject: Re: [PATCHv4 05/14] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_065922_274832_8A1D1A34 
X-CRM114-Status: GOOD (  19.00  )
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

On Thu, Jan 04, 2024, Kirill A. Shutemov wrote:
> On Wed, Dec 13, 2023 at 09:22:34AM -0800, Sean Christopherson wrote:
> > On Tue, Dec 12, 2023, Kirill A. Shutemov wrote:
> > > On Tue, Dec 05, 2023 at 03:45:01AM +0300, Kirill A. Shutemov wrote:
> > > > kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> > > > present in the VM. It leads to write to a MSR that doesn't exist on some
> > > > configurations, namely in TDX guest:
> > > > 
> > > > 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> > > > 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> > > > 
> > > > kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> > > > features.
> > > > 
> > > > Do not disable kvmclock if it was not enabled.
> > > > 
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> > > > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > > > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: Wanpeng Li <wanpengli@tencent.com>
> > > 
> > > Paolo, Sean, any chance you can get it in through KVM tree while the rest
> > > of kexec patchset is pending? The problem is visible on normal reboot too.
> > 
> > Paolo is going to grab this (possibly for 6.7-rc?).  I'll keep this tagged on my
> > end in case that doesn't happen "soon".
> 
> Sean, any update on this?

'Tis now in kvm/next, commit 1c6d984f523f ("x86/kvm: Do not try to disable kvmclock
if it was not enabled").  The one time procrastinating on responding actually worked. ;-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
