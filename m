Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483D5CD6E64
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NijQPLjivC8i1AJtas0ASBy5T8aKTcya0/XkKHtB1IU=; b=qT+Ypvzx6Mlmli
	4/NqP0+yR1S/cB8/ZgZodykHZxrucFfZwyYsMeeLxChyDH/qs/s5/M5y6rxBfXPWeIgXDoZMqX3H5
	JLfPd7BHrYpHe0UQv2/5DEDk7OYs5E+RQzo67gw3BxAOreVr48KDRsvX+XrO4ate7sTd3R130DCc8
	DxoeNM+/9iLbuIEeR+jlNN5/gU+DLgk/5HJegc3hAYtiAbg3N3CPs1c1SO81urSeKhJ1gHpP82tX1
	Q5/MClsEQ+uj1LdUWcAsnaNAF0fNatdobIefQ1kItLPTouMwXWfv5SvFVsCxVW1WH6GeoiM/ZgfuV
	J/vKVy5ZvjmY0m3f+GMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqZ3O-00Fwat-2x;
	Wed, 11 Oct 2023 13:15:10 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqZ3K-00FwWC-2A
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 13:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697030106; x=1728566106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DVj1IAQaMNXzKm35tzE0vtrTuSeRAxpGGOqdY2NfLZ8=;
  b=ir2DnvIzvTBZT8R6bGkKuPL8kqFuURurlDJaAvogK3T21Bq8OeK91uBd
   WeFjp0JVheCfVVp05/MxiiYxT1RAQXGKKTkIsEU4VeCpXEq5C+SWq2YtN
   es8pdeLyit/8J4t5QNVWbx8yl5y+iL9eCoDyT2KlcCyXDlTGVXhpnxy59
   I9l2a4XgE1gVphZT4bUvvpDVwgFLLC6JY46dhY4IXaBRYDa+SA5qW6vvh
   9ph/KwMBjC27PsiO3apJKgCcJVismBBDaado3nMTjOz8EEtrGN/pr6WCq
   i2SzEmgDie6wxr1yIb9xeq9VtrL+k2/rNE/j5X1kda/RV+QiIiz6XicNa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388525165"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="388525165"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870138127"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="870138127"
Received: from laptop-dan-intel.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.166])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:14:56 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id D5B19109FB5; Wed, 11 Oct 2023 16:14:52 +0300 (+03)
Date: Wed, 11 Oct 2023 16:14:52 +0300
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
Subject: Re: [PATCH 09/13] x86/tdx: Account shared memory
Message-ID: <20231011131452.r42nemcajjcj77hq@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-10-kirill.shutemov@linux.intel.com>
 <f3776d2b6d45e74b4d0e62eb4e788c578132c21c.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3776d2b6d45e74b4d0e62eb4e788c578132c21c.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_061506_751998_D47CD0EC 
X-CRM114-Status: GOOD (  10.17  )
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

On Tue, Oct 10, 2023 at 10:05:21AM +0000, Huang, Kai wrote:
> 
> > +#ifdef CONFIG_DEBUG_FS
> > +static int tdx_shared_memory_show(struct seq_file *m, void *p)
> > +{
> > +	unsigned long addr, end;
> > +	unsigned long found = 0;
> > +
> > +	addr = PAGE_OFFSET;
> > +	end  = PAGE_OFFSET + get_max_mapped();
> > +
> > +	while (addr < end) {
> > +		unsigned long size;
> > +		unsigned int level;
> > +		pte_t *pte;
> > +
> > +		pte = lookup_address(addr, &level);
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte))
> > +			found += size / PAGE_SIZE;
> > +
> > +		addr += size;
> 
> This could be a long loop, perhaps add cond_resched() here?

Sure.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
