Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A741CD6E67
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6MvreuOVYgwKM1T4FCytrD8Ft+Ox9SvE0CPUcXUgwqE=; b=XXkGr7RnI/eUMn
	qOiUqUCVDZIsOzlCY3BE7v8ffZJuuQ0qwpoYhG0RlVZEiGBfHZ/ZciRAy4nal9COEahWB3SbKq3vm
	8PHmXjgLOCdOAd9TWBPo3X0SnSPeLA3/8ogWb0WkpKyKAZlfcL+87/swNksx2NV0qR3ar849DprB+
	EyOmziL9ASQR3yXpYtXzvmwRMx/AIVcz+xNATMBOX9J6YIaOkhnqsiSn8huJIUfwVbqdO/s7lvlUc
	K2+Z+y0CSJPAZHeH7+9SzcFSoISsbT9fWHxOX2RPHUbfoX0v4HAaJ8FpRoIfwc6mZPNZYl+FiZIfC
	DlxjfD1ukykNGuqdHufA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYzj-00Fvz1-0i;
	Wed, 11 Oct 2023 13:11:23 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYzf-00Fvw4-17
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 13:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697029879; x=1728565879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B53XM39BYMuTT2q7Eh2SVAroSIYenFGSlmbpBE0jnKI=;
  b=d3sUjAd83QRQBKM3yLebtmlZN8/OlGuOmWG3NrtqbLGX6SBxvpz+FCHb
   gxJYMhtVlIEWnWkWRppn3nq7iYcGA77Ra1rQOI5IU0nef/a0z8L5gQsqS
   kZ502fN0RQHBOfZnpocZ0Jd8x/XuW7gBv/AWmG6vnPQt3fqFpkU8xLlIA
   m3RL3NYKoVlWNwOh49sq0yyCWAwQlCEjcfRMej1QyR5W3SB9yBoclqf7k
   w+mLACv6GMV5E7g47y+Zd91LvEdXk+W4QAbOKVCYKhvK7gthQH4q8pATB
   gJ5JALy2nUEvjopNcfvnoK78jkA7QvzrgRK8aH/1jjwNfk748OVa7hoig
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383522360"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="383522360"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747443328"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="747443328"
Received: from laptop-dan-intel.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:11:06 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id C1E03109FB5; Wed, 11 Oct 2023 16:11:03 +0300 (+03)
Date: Wed, 11 Oct 2023 16:11:03 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
Message-ID: <20231011131103.6p6l3gpklsaybygy@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
 <b69b21b8-7915-4854-b5f7-5124cd4e5bbf@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b69b21b8-7915-4854-b5f7-5124cd4e5bbf@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_061119_415175_EC463331 
X-CRM114-Status: GOOD (  15.36  )
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

On Tue, Oct 10, 2023 at 06:53:27AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
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
> > Do not disable kvmclock if it was not enumerated or disabled by user
> > from kernel command line.
> 
> For the above warning,  check for CLOCKSOURCE and CLOCKSOURCE2
> feature is sufficient, right? Do we need to include user/command-line
> disable check here?

The command line disables kvmclock, even if it is enumerated, so disabling
it is not needed.

Anyway, I reworked the patch already based on Sean's feedback. No need in
taking parameter into account directly now.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
