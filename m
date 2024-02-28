Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6E7C47DD9
	for <kexec@archiver.kernel.org>; Wed, 28 Feb 2024 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RjGHK8LBt1F8ni7MxylJOVuKfRndIZ/pynclDDpSfrw=; b=ib4gXcWXeUqPaV
	Mf0EVEYnAtnF75nzCTsip9THIPNwXDUUhPhKvStqxEVlJEoulrNL8x6ySqINSBGjNNMKKQNt9YCPz
	VVTqfIr7vG/n1Ckq1vOEhtNd9mAqeLHSwgjKVvjmprUTVANKmDsfVqE0k3EvsxtRfHL0F3F9CelxZ
	+wrCHoMdIn4Ab+8CZaiEwCH5Rmj1qChkuUH5ZncD2vJKGPVsF8uQCBw9T+Pd2n/QVtaraoeQ01ytS
	8AkTJw3jT9fZv+JQyAykAo/rUomvTfNl2916cwon41hykDh7sfZCO4vOpr1l7LaZgN1OMAzqUXoU3
	AQnkEVs1njh9I7NNvX1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfLlh-00000009sRs-0nxX;
	Wed, 28 Feb 2024 15:22:49 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfLlc-00000009sQR-452W
	for kexec@lists.infradead.org;
	Wed, 28 Feb 2024 15:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709133766; x=1740669766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pVo3nZ1TRQ7aysEs3qhN7ATzV2rZ6Gtlgvl+QzdEatc=;
  b=my1YzGO3V+1dUSAYitsROc2bv8WJgKXMLmayQnwQbIT9JNbVyn9wvGsD
   wdFbXaUa/ay7b8Ai/UNgxcDGPRngMizBbv6+Yw46rACjzHZp96pEzJhIK
   RS4c+2IS2/5TGWO5LaThA8F1mzEnfNnW0zKgMLMoeVfIYQXXHS9+6N1yO
   s+5tkuvYgqbmahRoIS4q/1y8HAbXsw/59gL8nOHVI29bqse/SkUW4mWao
   /u5qHe25HiH39rhv++/ZkdJD6gkjBIEqchK1SByFgMP3VxoNJ1V4/6pi5
   EhKW2cvLqvgk/GeeDJDtfyWyKqqYABwUMsZ9JR6goZns+vraJT3X/3j3k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14088122"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14088122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 07:22:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034395"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="937034395"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 07:22:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BCEB228A; Wed, 28 Feb 2024 17:22:30 +0200 (EET)
Date: Wed, 28 Feb 2024 17:22:30 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 17/17] ACPI: tables: Print MULTIPROC_WAKEUP when MADT
 is parsed
Message-ID: <3jgmzzbjmwtf2rtrbiulhwjj5xwzc3icf4gxcmugyyq5n7pg5m@ua3poay4gmku>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <20240227212452.3228893-18-kirill.shutemov@linux.intel.com>
 <0a633c22-8426-42cf-9572-7812ffc75d0a@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a633c22-8426-42cf-9572-7812ffc75d0a@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_072245_086147_D9E48CD0 
X-CRM114-Status: GOOD (  23.67  )
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

On Wed, Feb 28, 2024 at 11:08:38AM +1300, Huang, Kai wrote:
> 
> 
> On 28/02/2024 10:24 am, Kirill A. Shutemov wrote:
> > When MADT is parsed, print MULTIPROC_WAKEUP information:
> > 
> > ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])
> > 
> > This debug information will be very helpful during bring up.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > ---
> >   drivers/acpi/tables.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index b07f7d091d13..c59a3617bca7 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
> >   		}
> >   		break;
> > +	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> > +		{
> > +			struct acpi_madt_multiproc_wakeup *p =
> > +				(struct acpi_madt_multiproc_wakeup *)header;
> > +			u64 reset_vector = 0;
> > +
> > +			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
> > +				reset_vector = p->reset_vector;
> > +
> > +			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
> > +				 p->version, p->mailbox_address, reset_vector);
> > +		}
> > +		break;
> > +
> 
> Hmm.. I hate to say, but maybe it is better to put this patch at some early
> place in this series w/o mailbox version and reset_vector, and add
> incremental changes where mailbox/reset_vector is introduced in this series.
> 
> The advantage is in this way someone can just backport this patch to the old
> kernel if they care -- this should be part of commit f39642d0dbacd
> ("x86/acpi/x86/boot: Add multiprocessor wake-up support") anyway.

It is not subject for backporting. It is just a cosmetics fix (or debug
facility). Any new MADT type would generate a warning. Nothing wrong with
it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
