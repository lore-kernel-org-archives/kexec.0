Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4A4C43334
	for <kexec@archiver.kernel.org>; Wed, 29 Jun 2022 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C0KdF4wlRGAfV/BU1zd8boDEXFfQvZFo5Q/L9I5DvZ8=; b=n+fHyBoe5tALfn
	YN6osVoUDfeQZVtrib+8iZuG2SfCtx7nblQgs3d5YN+CAnU4CG4EQolesz9767yNX/GId++8d1obM
	fQx0VduxJtDHYgr9N3k5JwPESPVacWxNa309VszfZHyxjHrGPCmuaSzf4/VmOgFLalThAOo0dyLMW
	uFYgSe28Ew08lJ+bT3Wl4iy7vVCWINxdqrUWasVN0FfeuPeLuTOBHs1UHd6SPJXvHJY13zKZzR5Tq
	VABmubehwNgbicboMICBZ8UMRqctIPyj049cX1Z2UYLchd/aB0qBwrWKTSuxv3klC7kgP8zm+7BvZ
	hxuywoIaK0u7+p7V8Pew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6M36-008q8c-Q5; Wed, 29 Jun 2022 00:59:20 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6M33-008q73-V3
	for kexec@lists.infradead.org; Wed, 29 Jun 2022 00:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656464357; x=1688000357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PdXIIJIuvGiIGyuDJJCs/uSsICdNzkseyWhvo/anTLA=;
  b=aAnLC1dxAodc6K7Ch03cJ9ifj2bw3BYVrgxY9a1ocN1FigZmQFOTRNbE
   RiiWiHdw8mgmIBFHolS8yJFxO7BZtSziDkQAIuz7LL7KFv7YQHdueZ/Zi
   u0Axn+LEJjdeXHxj/IuY4xcmBZ21mV2IPIBjuggAJC9RaxroV9Bw9rBsC
   konKcpgcS19vf0AgYXO1zVscTPZsdlpj0bmr9Y8i/DUGkrOA+SKeMS6ib
   C16hzCIkseRlX4A1zMuiEpZl8Am/QvDAwL8O55cwY5Uh7jsNBc8diRckF
   5lVL+irrX7iCNH8540KuBjq4ivlETnq9Zz1C1qtGPadz5htPZenWzfs0l
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345881656"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="345881656"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="917394813"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 17:59:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 19836CE; Wed, 29 Jun 2022 03:59:15 +0300 (EEST)
Date: Wed, 29 Jun 2022 03:59:15 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Varad Gautam <varad.gautam@suse.com>,
	Dario Faggioli <dfaggioli@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>, marcelo.cerri@canonical.com,
	tim.gardner@canonical.com, khalid.elmously@canonical.com,
	philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Message-ID: <20220629005915.gieli3dbjzvjbk5i@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
 <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
 <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
 <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com>
 <88fe385c-fe40-d659-5081-7f3cdd9493e4@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88fe385c-fe40-d659-5081-7f3cdd9493e4@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_175918_118102_1BD71C79 
X-CRM114-Status: GOOD (  15.06  )
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

On Tue, Jun 28, 2022 at 05:10:56PM -0700, Dave Hansen wrote:
> On 6/28/22 16:51, Kirill A. Shutemov wrote:
> > On Fri, Jun 24, 2022 at 05:00:05AM +0300, Kirill A. Shutemov wrote:
> >>> If there is some deep and fundamental why this can not be supported
> >>> then it probably makes sense to put some code in the arch_kexec_load
> >>> hook that verifies that deep and fundamental reason is present.
> ...
> > +	/*
> > +	 * TODO: Information on memory acceptance status has to be communicated
> > +	 * between kernel.
> > +	 */
> 
> So, the deep and fundamental reason is... drum roll... you haven't
> gotten around to implementing bitmap passing yet?!?!?   I have the
> feeling that wasn't what Eric was looking for.

The deep fundamental reason is that everything cannot be implemented and
upstreamed at once.

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
