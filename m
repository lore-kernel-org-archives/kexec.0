Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57EFC4167B
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AnC6KsNsSdV6P+6rAaQyVlDizawiPO/cRM1f5bNfuU0=; b=JDKbO1L6KfT+qyG5VnR7owYwj3
	Hgf/SvcClh6/66cJ3y2DEmH1W0dzwF6IHrXcBa8Rvq72LJzrEQ78VNfJ32I0j9iTFCXiQz6kpP6VU
	Zc1u+zaoGll8wr9juGZPsTC4/rg7K4bkw7+2u0nK/B2jLnt0mqZL6O+xY9n3KAX8607Ph2TbpOc1q
	LF2nsIL134hUTcMtizUxEK4eZvCg3CaYYq8EVoQg7wShWwJ21Mbwt7EM3uCkUn394M7M4wWPn2O7Z
	6A1O8eB3ToRL2CCZqwiIT+Z6yJbPkV+5Umg6HJz4dud4EitCNJXFQQoutIuHlf9sfufiYCqRuTuy/
	77Kff1DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDSwc-00FaHE-1M;
	Wed, 13 Dec 2023 17:22:50 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDSwZ-00FaCu-1B
	for kexec@lists.infradead.org;
	Wed, 13 Dec 2023 17:22:48 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c65e666609so6282763a12.1
        for <kexec@lists.infradead.org>; Wed, 13 Dec 2023 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702488156; x=1703092956; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ViX/Qqiqk/4TxTiVczHsfkpJiJjwcbO6aH0GOTDDcw=;
        b=CtzGOEpfhlGFu7z5EJedHUhoXaj3OXdoXhfXRCQx0Xj8n+qd7z12ZPdD0fmVh7FkCE
         ksxM4XR9EM4sHrD1oZJGMjk6acFwAOMpDwgO2qnI1Ds3MJiGLjEDXeO5GoLCKmfWb0El
         8hEOOTm4DFMvPAgBOugP3XenOWYOLJZhF6YVGJpULUraQhmwUZmzlV/h010pEOOiWbNo
         7yWdUrum+HgkmRPa+9BGkW4ipKpgkKoplfXMCFW27iNPvNgrOOYHOKolluAgebvyvfr6
         kI5VRIBQ4lcxRcj6rBBBG51pF+fTDs9U0jrNpjfxV4suXH8LD0lqW9kBzuE65lCgLEoC
         B58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488156; x=1703092956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ViX/Qqiqk/4TxTiVczHsfkpJiJjwcbO6aH0GOTDDcw=;
        b=fJtV/7Z7aNVDgakihNBHdVVloNl4ypTbtUTK1u6BIBUCUJVCcrn2cyO6lgUEyktk2z
         q05gz24kfYFxhTWEZQBmKdocT6I11JFrQnBylSs08qPMup8z5A7LGtE9HtGJFlFcu03g
         +WS8vXFGZqeZpNAWyAXkx9J5DLccG7lxRV+TiZmUpDft0GIHnPOhjksuP9h7zLJ5Qbyh
         2Cz66klw9+XnJWRjSKsS8KP0ihJvlbO3NKBo5u++bYt+a6O+9tX0X2PruVSqVuW0nVnQ
         p6fjktM9VU7XAv+hEIBeSTtjQhyKpj42h7vD2+xrq8pBT5S51PrSEYjfiuR4oybO8Jcf
         L0yA==
X-Gm-Message-State: AOJu0Yz9LY0pMcnw5R77VgBbAIloYtkTkRgLTU/tmX89h4Es+SAiqTcd
	MNRQjAultE9XBtwwtRlg2GBwvX0WVSs=
X-Google-Smtp-Source: AGHT+IHDC+0wF7yt+7K1uyt/r/lMDTjmVPeporp00WV6ZNCML8y1Mv3AsmJMG9SX/ub7Z9qJkWpnW9vU16Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:51e:b0:5ca:3b18:9ec6 with SMTP id
 bx30-20020a056a02051e00b005ca3b189ec6mr328107pgb.5.1702488156338; Wed, 13 Dec
 2023 09:22:36 -0800 (PST)
Date: Wed, 13 Dec 2023 09:22:34 -0800
In-Reply-To: <20231211231035.743cesujphsp5eve@box.shutemov.name>
Mime-Version: 1.0
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-6-kirill.shutemov@linux.intel.com> <20231211231035.743cesujphsp5eve@box.shutemov.name>
Message-ID: <ZXnoWuaXvRkJjlDK@google.com>
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
X-CRM114-CacheID: sfid-20231213_092247_403403_14DFBC2E 
X-CRM114-Status: GOOD (  13.98  )
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

On Tue, Dec 12, 2023, Kirill A. Shutemov wrote:
> On Tue, Dec 05, 2023 at 03:45:01AM +0300, Kirill A. Shutemov wrote:
> > kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> > present in the VM. It leads to write to a MSR that doesn't exist on some
> > configurations, namely in TDX guest:
> > 
> > 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> > 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> > 
> > kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> > features.
> > 
> > Do not disable kvmclock if it was not enabled.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Wanpeng Li <wanpengli@tencent.com>
> 
> Paolo, Sean, any chance you can get it in through KVM tree while the rest
> of kexec patchset is pending? The problem is visible on normal reboot too.

Paolo is going to grab this (possibly for 6.7-rc?).  I'll keep this tagged on my
end in case that doesn't happen "soon".

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
