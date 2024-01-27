Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4CBC46CD2
	for <kexec@archiver.kernel.org>; Sat, 27 Jan 2024 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gOy/b/Bbh+DHK3UABuNdwwc9YAoGOvxDzCrscv0L4rU=; b=tR5Kyz+Il7k9rW
	5zHInFt+kA8fVBecCXBamGcVSqTn1mS+vJYxZ7ZdcES7EcpP5uiF4tRFSCb0Z9UNDEZ6/jucMgyyx
	fgx+yc8daB9uW2yOaNlaOW35JcV2gluZq9HQkW8nvRIXQD3I1J3E9oNukgqhdrRwwYTvLCR+3+NBM
	ERwAmbGS/Rh4oKqux5EsCivpTt2MNvdlIFn31xpDmgEpNOgCo8uQXsK+r1VYAW3T93q04acusdBda
	Jh9y21WeVh4kXAwwJ0NRL9CfH00iDDSzEFez3dNr8YFweZaH6d1HQVRQtavdgatH9eIrmjBf2LMxo
	UaXDgdv9Sg5F1xGB3sNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTnE1-00000007yrz-3sSe;
	Sat, 27 Jan 2024 18:16:17 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTnDx-00000007yq5-35ko
	for kexec@lists.infradead.org;
	Sat, 27 Jan 2024 18:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706379373; x=1737915373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZaHfr8zzpIiXgdpCUTc6QBJVotPOw1kev8Awy0ZxIXE=;
  b=R3R2ekPXLiAw4lEtjMjudSci7Fknx50iqeA3j185yM/K8zFCxstbt1qj
   RgDsQse8FjxPvWfd1VK0fF3FGHLuddv37btxM63T1h/3uQziXjGv04wos
   bA9xZEEA8ox7GCLVqp4ZnsvJ18OHB4aOkw0tDzSEnRzUaIV7DFh8Fl/PO
   vwV/RHTnOD82aVGeYSAuUjBxzQxItjfQ/HgENko2AnvFrt3z+KIJ+PW1o
   m4a6QwcTR34cHwttvIkDUTkbUdtUzQUoQl0dNRXG7EkfFul3tMvRZi0Ul
   cXY0gRYD++TJ2wvhp6sQR8WnkZ3tUdBLTpqS5/WSJcU73qkDsigo/4M6Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="10084695"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10084695"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 10:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="787423836"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787423836"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2024 10:16:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9CC521F1; Sat, 27 Jan 2024 20:15:59 +0200 (EET)
Date: Sat, 27 Jan 2024 20:15:59 +0200
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com" <seanjc@google.com>, 
	"bhe@redhat.com" <bhe@redhat.com>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv6 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <r6u3m7ux2v7w3bg24dqmrolos4jna74nfeheudgxmxcn3iuets@qkuaj2son5mr>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-17-kirill.shutemov@linux.intel.com>
 <075348cdf2b4d3361db5c7d420f09a1c8935328e.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <075348cdf2b4d3361db5c7d420f09a1c8935328e.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_101613_801429_0EF10119 
X-CRM114-Status: GOOD (  11.08  )
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

On Fri, Jan 26, 2024 at 02:21:30PM +0000, Huang, Kai wrote:
> > +static int __init acpi_mp_setup_reset(u64 reset_vector)
> > +{
> > +	pgd_t *pgd;
> > +	struct x86_mapping_info info = {
> > +		.alloc_pgt_page = alloc_pgt_page,
> > +		.free_pgt_page	= free_pgt_page,
> > +		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
> > +		.kernpg_flag    = _KERNPG_TABLE_NOENC,
> > +	};
> 
> Nit: Reverse Christmas-tree style
> 
> [...]

Okay, will fix if new version is required.

> >  
> > -#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
> > +#define ACPI_MP_WAKE_COMMAND_WAKEUP	1
> 
> Nit: Is this change intended?

Yes. Changed to indentation with tabs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
