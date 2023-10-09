Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11500E95A8E
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+YWBoluPxXMMeeTYmvayXQEA2I9agEhXal6+u048CRE=; b=HE5fY1vVwACF8z
	1uRH8iz58bCh1gp9zF/+ECRoZb9JPW4jcEaw5/TdzojVLwwRFjtSmyVQilW1Ji3nzWgCnpgZhomvM
	JXXFQQpwuXait/yPWRbCMc0czWnxVhrrIdMtTJxFjLCX4eu62akK1486wywXReomCN407q3ScZoZi
	5hhy7YAPBeiCYF/c9ZDl2UO52LX9gfRlBOhmO7OOakD/r2wSAWQcOIIOCn0a/Oh7zFn472/nxTB9Y
	cadQD5ZS4of02GOClFnl2wXjaRf/2mJYhhukSiGsxnAysg+treiihMqkBeIcc4m2ZdOe4Dik7s4NT
	evLt6AXa4T3RG3udY8vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqN1-00AoXu-0t;
	Mon, 09 Oct 2023 13:32:27 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqMy-00AoXA-0a
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 13:32:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696858344; x=1728394344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6X7t52RMQYAzBBtDAQ5xYHufke1Kv7hNGxphb4I9Vo=;
  b=F8oCP8+kW0jsRTjB6FqaslR8rHMYpWQP8if9VE2O09Y+doyPLUmnz12j
   FB1o5LbeL/9oix5ivslYFPiuDP02DSfB/8NsWZu5nZopXEt2h1065Why6
   tcdcPA9ZJLZZeAu6FMR6wqx2fPeduG0XqlwPko3AzXMU8WbyGtCuHu4QE
   Ppfuc9JTIeEMV1dICbJchXSa++ZBWlavyEJzpHH4mmHbDGW143STvzrR2
   bjspJZfggz6z0nuzV/wQ+POV6lCbd24A/x+Dhc5boZfnH8muwD/vXZP0D
   BS/jRouH4DtVhJwr/XzEE/d2z5Z5rQrHUH/QyBxY11SMnXCebAQ3Wj98Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450644570"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="450644570"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="756719143"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="756719143"
Received: from ahuge-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.233])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:32:18 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 40F1710A196; Mon,  9 Oct 2023 16:32:16 +0300 (+03)
Date: Mon, 9 Oct 2023 16:32:16 +0300
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
Subject: Re: [PATCH 01/13] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <20231009133216.pmihemrukk6k63mo@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-2-kirill.shutemov@linux.intel.com>
 <2be8a356-79c8-49a0-ba93-2a92df119af3@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2be8a356-79c8-49a0-ba93-2a92df119af3@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_063224_280145_D5820A7D 
X-CRM114-Status: GOOD (  24.98  )
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

On Fri, Oct 06, 2023 at 11:33:47AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Kirill,
> 
> On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> > In order to prepare for the expansion of support for the ACPI MADT
> > wakeup method, the relevant code has been moved into a separate file.
> > A new configuration option has been introduced to clearly indicate
> > dependencies without the use of ifdefs.
> > 
> > There have been no functional changes.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/Kconfig                   |  7 +++
> >  arch/x86/include/asm/acpi.h        |  5 ++
> >  arch/x86/kernel/acpi/Makefile      | 11 ++--
> >  arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
> >  arch/x86/kernel/acpi/madt_wakeup.c | 80 +++++++++++++++++++++++++++
> >  5 files changed, 99 insertions(+), 90 deletions(-)
> >  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 3154dbc49cf5..7368d254d01f 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1108,6 +1108,13 @@ config X86_LOCAL_APIC
> >  	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
> >  	select IRQ_DOMAIN_HIERARCHY
> >  
> > +config X86_ACPI_MADT_WAKEUP
> > +	def_bool y
> > +	depends on X86_64
> > +	depends on ACPI
> > +	depends on SMP
> > +	depends on X86_LOCAL_APIC
> > +
> >  config X86_IO_APIC
> >  	def_bool y
> >  	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> > index c8a7fc23f63c..b536b5a6a57b 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -73,6 +73,11 @@ static inline bool acpi_skip_set_wakeup_address(void)
> >  
> >  #define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
> >  
> > +union acpi_subtable_headers;
> > +
> > +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> > +			      const unsigned long end);
> > +
> 
> IMO, you don't need to declare acpi_parse_mp_wake() in asm/acpi.h. Since the
> only user of this function is in arch/x86/kernel/acpi, you can either create
> a header file there or re-use sleep.h.

Is it a really a bid deal? I don't see how it fits into sleep.h and
introducing one more header file for one declaration seems excessive.

> If you want to leave it here, do you want to protect it with
> CONFIG_X86_ACPI_MADT_WAKEUP?

Declarations are harmless if nobody uses them. Needless ifdeffery hurts
eyes :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
