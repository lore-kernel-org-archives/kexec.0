Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08F5C001DF
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=umvDrFXfgEzrQCXl/u8h/DqyL4a8uo8x36DQjT9oW7E=; b=yjwGUPMdmMeQEP
	et2cCAjB9EMUzXEi49/oEttYJWrfBZLmksci83Axlso5lwi70jjI1pvGGhxsICJ5qHpp2Rsvm8V1j
	pLJIwbA1Jo4MHbKC5dQKNHfyBCGdp7k70JiaNt6+yNd3ftDxmAzS0l3WhyWyP7j+vwvWhtVXcjEd8
	gusLhhZcjcZvlJw54QemUw2qhpyAjrjNOZ4yJaSXHRUuG2ohluHZNDJpuXhVjBejC6N8j53nVbEMr
	KkWP5tGqQb2JzLNdnr7rFdem8w56Jk+fqmrdL/VbujSazLvG6h2k2dlqazO9RorLvxbLgl4lUFarr
	U5iPe4byx1hEF4ucryng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlp7-001gU9-2v;
	Fri, 20 Oct 2023 09:29:41 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlp4-001gT0-2m
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 09:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794178; x=1729330178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jcyR0AHrPRoptorbJ7sUPfnYiRZ/f0uNOPZCGqeL0M=;
  b=IJAx1qxZBEzU0q7MknEF4cE3ZH/ZGXyFOREQ8T2ozjsIewaxIGdUxmEr
   zoJL8Aj5KP5EqlObLaHZfg4ls1drz96hTBVg0w103GVYKTULeC/MirstT
   1BZg4cLMlaUp/XHxIrqoHJzycq0/VQebPWTvN2snvT/y6zricaWK1ussj
   pSM5v4Cojo1OqeQlil9g2FlpcHjLENd3koHTQfjvzhw0BQNPf3jNsXGC9
   irtMPmUH3097D7ePF1Ba9mygJg60VRYeQedCXuwy+W3oanrG2/XFQNr+b
   U2pihsEJ/S9mkMp8gM0dTLqfRn93gKFGix5W1tegLDXKTFYfoHdETclRN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="452943110"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="452943110"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873848717"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873848717"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:29:32 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 9E13B109D0A; Fri, 20 Oct 2023 12:29:29 +0300 (+03)
Date: Fri, 20 Oct 2023 12:29:29 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 12/13] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
Message-ID: <20231020092929.ieig5xbhtwgrkqrl@box>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-13-kirill.shutemov@linux.intel.com>
 <100c567d4ba2e6f25dd6c51ceaf2995049d12c78.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <100c567d4ba2e6f25dd6c51ceaf2995049d12c78.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_022939_039561_54E7F23E 
X-CRM114-Status: GOOD (  28.00  )
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

On Fri, Oct 20, 2023 at 03:29:24AM +0000, Huang, Kai wrote:
> On Thu, 2023-10-05 at 16:14 +0300, Kirill A. Shutemov wrote:
> > ACPI MADT doesn't allow to offline CPU after it got woke up. It limits
> > kexec: target kernel won't be able to use more than one CPU.
> > 
> > Zero out mailbox address in the ACPI MADT wakeup structure to indicate
> > that the mailbox is not usable.
> > 
> > This is Linux-specific protocol and not reflected in ACPI spec.
> > 
> > Booting the target kernel with signle CPU is enough to cover the most
> > common case for kexec -- kdump.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/acpi/madt_wakeup.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> > index 15bdf10b1393..4e92d1d4a5fa 100644
> > --- a/arch/x86/kernel/acpi/madt_wakeup.c
> > +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> > @@ -9,6 +9,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> >  
> >  static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> >  {
> > +	if (!acpi_mp_wake_mailbox_paddr) {
> > +		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> >  	/*
> >  	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
> >  	 *
> > @@ -78,6 +83,18 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> >  	/* Disable CPU onlining/offlining */
> >  	cpu_hotplug_not_supported();
> >  
> > +	/*
> > +	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> > +	 * It limits kexec: target kernel won't be able to use more than
> > +	 * one CPU.
> > +	 *
> > +	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> > +	 * indicate that the mailbox is not usable.
> 
> Nit:
> 
> It is better to explicitly say that this will only impact the second kernel
> because the current kernel has already detected the  mailbox address?
> 
> 	Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> 	The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> 
> 	Zero out mailbox address in the ACPI MADT wakeup structure to
> 	indicate that the mailbox is not usable.  This prevents the
> 	kexec()-ed kernel from reading a vaild mailbox, which in turn
> 	makes the kexec()-ed kernel only be able to use the boot CPU. 

Okay. Looks good.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
