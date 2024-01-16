Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB38C4706C
	for <kexec@archiver.kernel.org>; Tue, 16 Jan 2024 06:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K+v+B2KADF/rmRgeR8s1tuPAAdHhEPgjeuLsiYjbf5o=; b=vG7nkDDdauAumn
	/f//gko4jsGkvIrkDJEXTfWQma0hS66Xs3G0/2EXGJZ2TN2u7vACknCFnaqWS5QKc61k6Lg8a7vBP
	DhX9VsknlV6ebIO3ljpLXmQg6Hjs2iptUprdJ7cotPgTOg72oozkbW5pJ21GVrhMAUSR4nN9YZ96h
	vG6KfTodL0TjiOQqtetXccREJbZN6fyQBaQ/YGJMf1FSe+a2aJfZeruqRTZ87HtRuul1vuEHpVSJm
	wW0llItHrG4dOsNMOMGO9NE5uw+ltSczFyj+X0EPwzBRESGa6ogzi+IE8/SXGPVK13kVILJqzICRK
	dY89Dg++Ek5ugFk2orXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPdHt-00B9CJ-2e;
	Tue, 16 Jan 2024 06:51:05 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPdHq-00B9Aq-05
	for kexec@lists.infradead.org;
	Tue, 16 Jan 2024 06:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705387862; x=1736923862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPysNPwhIAnQcyfr8stWiSetUkU3Df0caepIuGAELpQ=;
  b=f+wjo1PyeSZNm+MdCutB69AEtDUkQoumvidaBXt7OeYXFXa7wqkdCCON
   pkf/noYX/8EuSRQUjvsSY7gWi12jDlHUIBmhjoWiRn8kLMZQSDpmRxhT6
   t/ARliqJ5L+hroSNIUb3FJj3aJTuYxJzOVbW4y/8yEoNnZ5IVnhAnbsmr
   cVdgEl1e3HwFSPSogA6wzQgBt4iR9Wyy4MCIPR/6x7bRTPIRUqkmmtnkW
   8JhizHbSasSfoiNK+OnFmo3n4QzVmzHHN67uLthdap0C5Qx2Fo7VqMQR1
   bxZp5fF7W6Rx0RM8GJTvMAnL+dnMooL7vhicuQxoclCabYIG9tz460boH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6488764"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6488764"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 22:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="25688932"
Received: from uschumac-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.254])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 22:50:57 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 55B9010A17B; Tue, 16 Jan 2024 09:50:53 +0300 (+03)
Date: Tue, 16 Jan 2024 09:50:53 +0300
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
Subject: Re: [PATCHv5 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20240116065053.7a6omvqi3jmncppg@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-17-kirill.shutemov@linux.intel.com>
 <fa1e3873-6218-461b-85fa-1ff353380532@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa1e3873-6218-461b-85fa-1ff353380532@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_225102_144790_C8CD9328 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jan 15, 2024 at 03:19:43PM +0200, Nikolay Borisov wrote:
> > +	/* Switch to identity mapping */
> > +	movq	%rsi, %rax
> > +	movq	%rax, %cr3
> 
> nit: Can't you move directly to cr3

For some reason, I thought I couldn't. Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
