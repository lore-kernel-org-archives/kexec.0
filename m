Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6890FC4706C
	for <kexec@archiver.kernel.org>; Tue, 16 Jan 2024 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QMg2ekl+J1HMpm3NjVIuidOi2QwwH8/3eSBSyIh7Cxg=; b=K2CU49/ZAQn6RV
	nmNRar00THd/9TfaFEFGyOGH9H9sqWRlXg2+aEl7GHKiPcJ9ZpMHiJRt70J0WMsAMBc4nDZT5jEtM
	g1VMPnkkBZAcWojPcnTGSsG2DDawEaQgtdkIRoRe2mwwBVN3eg3IL2VvxLn5E86V54TZQgy3cYmau
	cSKj314O0cieAtqUyS/6vpp0GDJJ4CN/LEhm0wHXysMS+Q4tQjlG12C5vZXDwqYfdiCHEMlYHmNLy
	AHvSiPXsiwq8gqgLOOdnk8pdOcliAOWJXFoR9wNoPr5DYaaHJPLwPyMZ+xw/Pu902FE/xnnUquRSe
	5EleebgrE9bto0BXar0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPh4a-00BilN-03;
	Tue, 16 Jan 2024 10:53:36 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPh4X-00Bikk-1D
	for kexec@lists.infradead.org;
	Tue, 16 Jan 2024 10:53:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705402413; x=1736938413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwLew776p5vzcGbpOZt4QJk08QQAHvX8ubIV3cyIJIw=;
  b=KbEWUu1Ge8ZpC9QZ67NOETkzeOOGaG3IBJPCpG05thxetqI5xUEf8L2n
   1aWfXn7RsfgPVKYc8hEiNSIVIdyKXgFogJgYtWB7SkCX7xMQlgIKMSxqs
   7Udf97MCChaqGtZzTb9LPQIMkgun23HoZZGZdt4Q94EbStc3TAgQZlV0V
   XxR+efB8VF3x3SjDsl/2yEJd0Rlk8Ogpv4M280/MYN3aex54cd75SFeDv
   3k1BlUYy1URBelVtrputZRf83xEnKzH9i5ubGvvhvvfdeeIZYeFmEPUzQ
   NGr17oMO4nRUfl/ipD5whBZTI/fhAfm1wDJJHbar8BXLgbvHFleD8bqUU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="396983675"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="396983675"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:53:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="818134005"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="818134005"
Received: from uschumac-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.254])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:53:27 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id BBABD10A17B; Tue, 16 Jan 2024 13:53:24 +0300 (+03)
Date: Tue, 16 Jan 2024 13:53:24 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240116105324.5kz6b2b6cbv6g4xn@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <89e8722b-661b-4319-8018-06705b366c62@suse.com>
 <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_025333_446178_212F7330 
X-CRM114-Status: GOOD (  14.05  )
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

On Tue, Jan 16, 2024 at 10:28:22AM +0300, Kirill A. Shutemov wrote:
> > > @@ -809,12 +823,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> > >   static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
> > >   					 bool enc)
> > >   {
> > > +	atomic_inc(&conversions_in_progress);
> > > +
> > > +	/*
> > > +	 * Check after bumping conversions_in_progress to serialize
> > > +	 * against tdx_shutdown().

s/tdx_shutdown/tdx_kexec_stop_conversion/

> > > +	 */
> > > +	if (!conversion_allowed) {
> > > +		atomic_dec(&conversions_in_progress);
> > > +		return -EBUSY;
> > > +	}
> > 
> > nit: Can you make the inc of conversions_in_progress be done here, this
> > eliminated the atomic_dec in case they aren't. Somewhat simplifies the
> > logic.
> 
> Okay, fair enough. Will change.

Actually, no, it will breaks serialization.

Consider following scenario (includes change you proposed):

	    CPU0			      CPU1

tdx_enc_status_change_prepare()
  if (!conversion_allowed) // false
					tdx_kexec_stop_conversion()
					  conversion_allowed = false;
					  <...>
					  <return as no conversion in flight>
  <continue with conversion>

Incrementing conversion_in_progress before checking conversion_allowed
will make tdx_kexec_stop_conversion() to spin until CPU0 is done with
conversion.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
