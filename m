Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69072C07548
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 13:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8u5OdvzHqin4P7VwNUN+EOPZuY+Jge9wQTSg/WIo4jE=; b=zy8yNrVIyoFCKX
	Sl7km/3y+SNQCl1f6qbc9a69YLU+cKrJoBxZeaK9cxvaySm6w5CliuI4wo0slOkqnabhYzZTqbUTQ
	eUkb/hjkoZkQmZfuzXiaqmzZP4MxJqyAZ7LtsJxl9oDiHhlGNyB9tO2V6SCIRr8wfFlv72OdRWCVC
	0A7DgVAmmSQeIWbgz/nOJb22UoJwqJrME52FbJQ2bl2katYexUn5+GmVBcJRVMuxFfp7KqiJT1Mrd
	yx1zZghI60ECUbuJDgD8Iah02zFSTxoAxZ/NAdtUTZGiQuXECqf8kNx7MwB+Yewq4ap81R++EEwny
	c/K5YKjLt/bt9UtplFNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3FYB-000p9v-0W;
	Wed, 15 Nov 2023 13:03:23 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3FY8-000p7X-15
	for kexec@lists.infradead.org;
	Wed, 15 Nov 2023 13:03:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700053400; x=1731589400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4dKQNl6OtXKCpQsl6Lr+xytDUybE96dRWIvxmvWFcQ=;
  b=YIPWmt85swVvfd/fmvd8jOgTyHXAuyQ4E4KZFNRCl+UgxfQ8DURtU8Ya
   o3YbntRlGG5gg9X4QpZ3FjbYh4Gjbm3rqEvIzwU9yFRZkR1fOUkcktNYU
   ZUTSJqc3UCviRWaBUcgracfMyPxEZ7V/Q3IMBDEaS5skDblIX0/WdZaZh
   Mjhcg1L0lJuQTFI/DUpQ+O1aQyagFOhYOPlZtNDEodTx2TCpuHe/naIS9
   Ag3Vobbv2kDz0vUHbWRKaqpeUTImSYDnJnOtzZhFqTMQlEWrjS/rRjGb2
   m/kRlJJZk6+mSfHqNSPBWx5kMfqMfo0xSCkdK2GDIdGQ2iRkW/Ihgglr0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="477091540"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477091540"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="835391248"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="835391248"
Received: from mituomis-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:03:09 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id EE156109F3E; Wed, 15 Nov 2023 16:03:06 +0300 (+03)
Date: Wed, 15 Nov 2023 16:03:06 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCHv3 06/14] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <20231115130306.kmhaqsfpzi3gkpik@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-7-kirill.shutemov@linux.intel.com>
 <20231115122343.GA8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231115122343.GA8262@noisy.programming.kicks-ass.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_050320_420511_58F4087B 
X-CRM114-Status: GOOD (  18.73  )
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

On Wed, Nov 15, 2023 at 01:23:43PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 15, 2023 at 03:00:36PM +0300, Kirill A. Shutemov wrote:
> > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX-guest environments.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > ---
> >  arch/x86/kernel/relocate_kernel_64.S | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..bea89814b48e 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -145,11 +145,16 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >  	 * Set cr4 to a known state:
> >  	 *  - physical address extension enabled
> >  	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
> > +	 *    in TDX guests.
> >  	 */
> >  	movl	$X86_CR4_PAE, %eax
> >  	testq	$X86_CR4_LA57, %r13
> >  	jz	1f
> >  	orl	$X86_CR4_LA57, %eax
> > +1:
> > +	ALTERNATIVE "jmp 1f", "", X86_FEATURE_TDX_GUEST
> > +	orl	$X86_CR4_MCE, %eax
> >  1:
> 
> 	ALTERNATIVE "", "orl $X86_CR4_MCE, %eax", X86_FEATURE_TDX_GUEST
> 
> ?

Oh. Right. Silly me.

Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
