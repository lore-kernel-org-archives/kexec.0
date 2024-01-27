Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AFEC46CD2
	for <kexec@archiver.kernel.org>; Sat, 27 Jan 2024 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xz2evq8UD46/GOYsQHODO7lPb+Mlymfz0T9ZaG+Qbc4=; b=UKHzvHetAb03Sb
	XD7FZk83OpMZ9PxrxusSIWf/jshmdfRkj8M3Rr1lXQKUTLZrujTEl8HD3yh1DFjT3Rm7bDO5/6oqQ
	u+1pJWLQwtKWej9jbKdTk7hNOWgu4VwjqhYS2huxHnz1Pw2AN9GOZ3OdVC6fUbmUHOsUnFjdor3cD
	u3gHbmCJ7nRDsdmNnvGbhuEmVV4rRxp5/JGzWEtLurR1GoixpIebJWBuLqwZ2OKELvuzoupxnI5Us
	5kzKC+asl9V3D7/iVX777aNVtUPWDrtatwjFYte9K/XBkHWDrDVS7BGpyS7cP+zMt6LZOs9MQ0yoG
	zSGASsKGM/ZMNPuvxWiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rToT3-000000086Jt-33Nq;
	Sat, 27 Jan 2024 19:35:53 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rToT1-000000086Iv-0pD5
	for kexec@lists.infradead.org;
	Sat, 27 Jan 2024 19:35:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706384151; x=1737920151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JsNjDeEosD68W82IVuf9LcDq0mJQmIvRYnUGnYlOl5o=;
  b=B1me1+mxXKhu9draozd1weUV4odf2U0FvHBaoNLFl52tyRjfQjui45Br
   K8uxWKiutLWBiyQs0rXIQH7/XTTA/ZpJCci51EJe1dPmF0adykmjmod1c
   Zgp+QL9gKhr5+5H/ztUM9tQaw3GASOj8jldx3so86LdJjpmNkk1pOE+Ki
   pk4/D7i4z34M1TeKcjhKp1Xu5sh5XxEeOhTzqFa94wTFTtCpVPc962FWQ
   0vVKdE/WRT6T8zqYow3i0Fw0v73GT/z4XkFr3oznZWIA4j6+KHqFJHD5X
   P8tGUDN6VGOZB5MeeSqnY0j3zsaOEiJRkqsRiw/bDs2o4bG5uJQjUQ8H5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="16071602"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16071602"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 11:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="787430462"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787430462"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2024 11:35:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 21D451F1; Sat, 27 Jan 2024 21:35:41 +0200 (EET)
Date: Sat, 27 Jan 2024 21:35:41 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <vfk7v6ywaclyydshucnnuvsyg6e6sntyzimgqgjc7ye77z2ukr@lk4e3wz4ap3y>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-17-kirill.shutemov@linux.intel.com>
 <4aa2c961-a0dc-45dc-b996-57c8468660df@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4aa2c961-a0dc-45dc-b996-57c8468660df@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_113551_343000_2AE63D74 
X-CRM114-Status: GOOD (  11.53  )
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

On Fri, Jan 26, 2024 at 12:03:14PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > +	/* Don't wait longer than a second. */
> > +	timeout = USEC_PER_SEC;
> > +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
> > +		udelay(1);
> > +
> > +	if (!timeout)
> Nit: IMO, since you are dumping failure error message (not timeout
> message), you can use non zero acpi_mp_wake_mailbox->command
> check. But it is up to you.

I think my version is pretty idiomatic. The same pattern used in other
places. For instance, test_nmi_ipi().
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
