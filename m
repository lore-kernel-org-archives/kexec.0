Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFB5C25B67
	for <kexec@archiver.kernel.org>; Fri, 27 Oct 2023 11:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t0UdzCu5EUlzBINGgYLLjkcZM2Mk9isWZOWq1NLtlWs=; b=OaytTxYxdkS4j8
	QiWIUvmCEs8XsRJTZP/f+i3bL7sp4kYuwii97GPaEkosRIrJXo2uxOxwuNMAzFVqV0/GVVDVBGfZB
	g+0EccGZUS5CLjkKHiylw5fgnNotDfFlFkHag45UeM7jA1N56y/YZw5Fx8IDByaTvPBqh9cecRUzA
	ONoFTkilD5WPfrgmmN5e6go9GhVC3nQdT8qeJ5uNMMVOUvHWrwGrN/CnM1a+PTs+SYXzeRRllCJwC
	g6AIvg0bIcGxkXc29AuEgnmNSHeR6Y1YNDJAk/QuwsAettK+Lj3/DRSOOgfasmzSwLebEK+WJBXlj
	Sbg5hnFV8sEEwOmP9egg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwLTt-00GLV6-27;
	Fri, 27 Oct 2023 11:58:25 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwLTr-00GLTj-0N
	for kexec@lists.infradead.org;
	Fri, 27 Oct 2023 11:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698407903; x=1729943903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FMgGs7keUPnSe1O0ZLkjvny+7wogrNAYRVjIflUV0NE=;
  b=ig2J9cwk4Dcr5wSmp585Wwn5ZdV2EiFamOCXB4snezoh52lQKkdUBXyn
   6UO+h97nit7S0kCQhvkzbA7mPibktV04A0AtKHAwh00S/VcelBrUW3UKg
   Qi/TFJ02iAm8GHYOfOxOVw8ffmKNq87FbiUUobdRbncZBwffl8P743Hss
   IqBlUs6Bhn9Uanl8mQQ2zAQtRQerIrAWTdfPW2LfCzBhuzTRCQkzqqNNm
   PKO3OKBKFL30RHlwDFZz/ZnJVyYK3m/FujNuPn85ckJjd0mAVwus4w2LF
   QnlbfT/qaSopQ9OspKjU9VRgyLldh6n36PxQCCYjnvn66ng67e22ERtR9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="474001329"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="474001329"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="7634420"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:58:04 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 98EBE10A210; Fri, 27 Oct 2023 14:58:13 +0300 (+03)
Date: Fri, 27 Oct 2023 14:58:13 +0300
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"Christopherson,, Sean" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231027115813.imxsyq2ehl664nnw@box.shutemov.name>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
 <d86dbb81338d3473f24b3c479cf985a70bfc1118.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d86dbb81338d3473f24b3c479cf985a70bfc1118.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_045823_199274_A91A04D5 
X-CRM114-Status: GOOD (  18.92  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Oct 24, 2023 at 10:11:58AM +0000, Huang, Kai wrote:
> =

> > --- /dev/null
> > +++ b/arch/x86/kernel/acpi/madt.S
> =

> I think the name 'madt.S' is too generic.  How about something be more sp=
ecific
> such as madt_reset.S, or madt_playdead.S, etc? =


Okay, madt_playdead.S sounds good.

> > @@ -11,6 +16,150 @@ static u64 acpi_mp_wake_mailbox_paddr;
> >  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> >  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> >  =

> > +u64 acpi_mp_pgd;
> > +u64 acpi_mp_reset_vector_paddr;
> > +
> > +void asm_acpi_mp_play_dead(void);
> > +
> > +static void __init *alloc_pgt_page(void *context)
> > +{
> > +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +}
> > +
> > +/*
> > + * Make sure asm_acpi_mp_play_dead() is present in the identity mappin=
g at
> > + * the same place as in the kernel page tables. The function switches =
to
> > + * the identity mapping=A0
> > =

> =

> This function itself doesn't switch to the identity mapping.  It just cre=
ates
> the kernel mapping for asm_acpi_mp_play_dead() in the identify mapping pa=
ge
> table.

By "The function" I meant asm_acpi_mp_play_dead(). Yeah, it is not clear.

Will so s/The function/asm_acpi_mp_play_dead()/

> > -	cpu_hotplug_disable_offlining();
> > +	if (mp_wake->version >=3D ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
> > +	    mp_wake->header.length >=3D ACPI_MADT_MP_WAKEUP_SIZE_V1) {
> > +		acpi_mp_setup_reset(mp_wake->reset_vector);
> =

> It's better to fallback to "disable offline" if this function fails.
> =


Okay, will warn to disable offlining.

-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
