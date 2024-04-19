Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1299C4345F
	for <kexec@archiver.kernel.org>; Fri, 19 Apr 2024 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RanQz1dUx9I1ETBwA9QknmggNYFGMv8gniGi6qkFv50=; b=bpxYHXNFw1SuOo
	rCXLYd+z/TwJ7Aw/IIXQ2TjGT0izaXr/4tZBTz9ajP5L50NSyT6kk4BRe7ngtH1z1LHnfDC45FWdI
	lfd1XB0BLvBF2ty805Xu/cxMRz/0TW6DX6Rdy3oqsjBlbXcqJdJw/JZVfKf39zj+Z0RSEF0Ey9QkH
	PzLUaeVbzL7u6zEO0QRXxDXBjW3H6KA8R756KaTbGKFdBWeZjo3WzUzsSMbl1WT3CnfaiFa0ZGDgX
	G5sSuSMN7DoAqwpS73NZUToNHwsWHkRx6VrGIpivWhCvY9aoKe6wijUVZmHg6ILudt8/MOgmac1BY
	XseMaqcugKuM+Lo2kp4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxoLG-00000005lac-0cS8;
	Fri, 19 Apr 2024 13:31:50 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxoLC-00000005lZe-1PQU
	for kexec@lists.infradead.org;
	Fri, 19 Apr 2024 13:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533506; x=1745069506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q8sLxUQXTmO+zQlO+Nq2zQY8GKJ0uOrx6YdkifWv8s8=;
  b=LXMJLVNvMh7kLIg+OQpGV3kIW52FsgOxk4V2z9Zj+eo63+Wvzc4hxwEh
   DcCUGRysIJ82uybKP+4zUq9Xbjt90+A62OCQeyhmKT2QUVzuc1xMvF9gD
   ZMlkpJsAIgYuduZTNGC3yh+N2mJUTh3DcKiIo4mAmn10SLaBnhRjVwzSP
   s0XDpCfZdosoXZRq+ELaRLYZZO5w59wHEWnc59x9Mm8+wE7K2g1VxTqKu
   E5oRqWgoe4M2CVtARlJ2jSZdS7L/vL20DFIV0HCOWStGQySy7PSF8auAw
   eOo579oO/oxKfcizcMBUPL6oWIhcd+qaHTMw0Rrsz/PsW3Sex9Zs8Yt3q
   A==;
X-CSE-ConnectionGUID: IPFhSAQ8S1mwVm4bwUnxIQ==
X-CSE-MsgGUID: IDh1MNauRoWAMXnHjDzOaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="19829824"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19829824"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:31:45 -0700
X-CSE-ConnectionGUID: 8EhFIYEkSGmj4XmvSB/OuA==
X-CSE-MsgGUID: 32PEEwedQ4ewi5StWKTDOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23411447"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 19 Apr 2024 06:31:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CEE59FD; Fri, 19 Apr 2024 16:31:39 +0300 (EEST)
Date: Fri, 19 Apr 2024 16:31:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 03/18] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Message-ID: <rju6u37prtr5nf4upcntcy4jcnul6atqmbh6impzqdn3dlo2pj@lqodxa7elohz>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-4-kirill.shutemov@linux.intel.com>
 <20240418143709.GJZiEwFejGQY3jiwsp@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240418143709.GJZiEwFejGQY3jiwsp@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240419_063146_418741_61A4054C 
X-CRM114-Status: GOOD (  15.54  )
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

On Thu, Apr 18, 2024 at 04:37:09PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 02:29:55PM +0300, Kirill A. Shutemov wrote:
> > +/* Declare CPU offlining not supported */
> > +void cpu_hotplug_disable_offlining(void)
> > +{
> > +	cpu_maps_update_begin();
> 
> "/*
>  * The following two APIs (cpu_maps_update_begin/done) must be used when
>  * attempting to serialize the updates to cpu_online_mask & cpu_present_mask.
>  */
> void cpu_maps_update_begin(void)
> ..."
> 
> > +	cpu_hotplug_offline_disabled = true;
> 
> but this doesn't do that here.
> 
> Are we doing a one-off here for that variable or what?

Yes, it is one-off. I guess we could use READ_ONCE()/WRITE_ONCE() to
access the variable with the same result. I am not sure why it would be
better.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
