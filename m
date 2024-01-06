Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C19AC3DA6E
	for <kexec@archiver.kernel.org>; Sat,  6 Jan 2024 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=51V/21kuiH1dEaA0j8ZuL2F78vnvaglCmWk3w2BDY7Y=; b=g6vcJJSdSklxmN
	VwXPCOD3AylH4V8dSmBodsKNGTEdqH4kSHqoExjtyO6QixAJNOnh7UX1WueSsrXVgs6Y4gQv0qRXD
	pN1qXGqqnq6TxSYc6I4isKpMK3eIKvL2hKQA8QA0y6BU4UqrwBAbunBojYH3xO2s8buv6cm1FrcI4
	F3o8roht/gh/EpJe6aUFVSEP/0LUkxS89IKzqNqKFFyS4a7fwt3iB69wpsv7KO0Mwtk+Tfq9NgRO/
	XXgt+pdGbGn36/hy244o91/MmEeC+KEilQce/GMQd4gyVLKQl33qWcK34p/V38bL2uXOaKeRgy5EL
	uulFLre04AhaWrTHb/Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLv2p-000VLV-1i;
	Sat, 06 Jan 2024 01:00:11 +0000
Received: from mgamail.intel.com ([134.134.136.31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLv2i-000VJo-1l
	for kexec@lists.infradead.org;
	Sat, 06 Jan 2024 01:00:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704502804; x=1736038804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bSsYNHPqPBPvIfJLFuPRmb0GQmnn1/patfbIJCmnLTQ=;
  b=PnSl9B87p3YzK7JEgbRi9n73URPIn7CwUPQLazXGF8MfsvEJ98l6VPxs
   QGYBed3T8SnFfMEgfFNc2VJSXpIhXyOaV+rx0EMmr/WDVNit/PBMvjIw8
   lRNwkQF7k4ogu31zfrY72mIedGCyhKnALV/XQqfdL+QhVK6vCk/KWrAWA
   BwiuKJnE4wlQK1sblaY6Jm4TrnfQCYTucMA9NqqvGFP7evAtp8m5W9xhc
   dUyiSyF7JRfcRp3T0BRBD/sHvInqz2ihCfhv18TPNfsC8K7rRYpOuobc5
   AbeiES0dKsH9mNGPxP4ikEzSs2UGo26KEiY8W/sCapyQ7mt++Q0LFIOoH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="461918824"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="461918824"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 16:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="871366157"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="871366157"
Received: from mflierl-xps15.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.36.84])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 16:59:03 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 49F5C10A57B; Sat,  6 Jan 2024 03:59:01 +0300 (+03)
Date: Sat, 6 Jan 2024 03:59:01 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Huang, Kai" <kai.huang@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240106005901.jpdxd544ddih6nw7@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <063a42bfe538710931fca183a8d28c8a3d011608.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <063a42bfe538710931fca183a8d28c8a3d011608.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_170004_649947_9B08C231 
X-CRM114-Status: GOOD (  15.43  )
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

On Fri, Jan 05, 2024 at 07:38:48PM +0000, Edgecombe, Rick P wrote:
> The break apart looks good.
> =

> On Sat, 2023-12-23 at 02:52 +0300, Kirill A. Shutemov wrote:
> > +=A0=A0=A0=A0=A0=A0=A0while (addr < end) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long size;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned int level;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pte_t *pte;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pte =3D lookup_address(ad=
dr, &level);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0size =3D page_level_size(=
level);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (pte && pte_decrypted(=
*pte)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
nt pages =3D size / PAGE_SIZE;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
* Touching memory with shared bit set
> > triggers implicit
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
* conversion to shared.
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
* Make sure nobody touches the shared range
> > from
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
* now on.
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
*/
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0s=
et_pte(pte, __pte(0));
> =

> Does this need a full shootdown at this point, at least in the crash
> case? A local flush for the non-crash case might be nice too.

See __flush_tlb_all() after the loop.

> Also, probably a barrier() between set_pte() and
> tdx_enc_status_changed().

But why? There's no concurrency at this point. Interrupts are disabled and
only one CPU is active. Nobody can touch the memory relevant for the PTE.

-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
