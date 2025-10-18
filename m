Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C75CCD195
	for <kexec@archiver.kernel.org>; Sat, 18 Oct 2025 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T3gTxIGjw9Qz+bpbJJ8oa2MJJauNGUSJxMGXi0hr0Mc=; b=uQRall8fH8g7J8TXUrN0JSCYZv
	YzTIDuBK3gNaAszBwgT6JQUJ3DhJYT/ok/0q9JR3c9OIhiURUA9l4F8qvfFYJJsR1ffiPoAwsBvja
	jKQO0VOqGgwW4RY7QgiYMe6qa2ssg5Vozi2tZvvJNWmmpuX8Dt/jNKCrAx5GzVDUw34+HydzjhzDv
	AKrHF6wiKxnmkchrUfdt/b2KbIj9HINjVVYfBIZiMsXnhB6lt2l5uEr8ZlfyH593A9MUpB8yCF7kN
	kxMuS8xRtxIRhEoJP6mIn9nrR6BToD1GrJuJPdj/7P5nJBJfMFRYhn6/Fx00gGieHx3sBy77rBRoL
	VVK8gWuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vACqk-0000000AP55-3lG2;
	Sat, 18 Oct 2025 19:44:22 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vACqe-0000000AP4S-1sSN
	for kexec@lists.infradead.org;
	Sat, 18 Oct 2025 19:44:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760816657; x=1792352657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IxGbQ+0oog6MEU2YUYCjRLsGaSp8M46wL1EyN+tTuJA=;
  b=E5UVdLKOj6rjFO1WERRsajG36j7O5uU/iNkOynMfE4+AIKzuiZdrC/1K
   LCi/9glWZRgG89DpEvZD5n0s0SXkw+eh83htMUaF5AqEEClY7lX57xH8t
   qmGg+oxWAkaKYBkD4RdwmurfrWXSJPzDirG8cOGibAdu3ysMg1sZX1FM9
   pOXlSQ0jJhFf1Z2XbP/bvr11t2gxkjfJeIHuFjgAzJk5Nvu1b7o3v/bVa
   7LofsfP2TqISMO0VMJAVL82qe7sFBEf3VNrLtBeRpeHh5TUhhgeM5WIbc
   /kvcUO6lS2/i243QdGUUyg8qtoOJIwRCx1iea+KQqFgDpDuuhB10vCdN8
   g==;
X-CSE-ConnectionGUID: THRQjFDhRCWZInhrZSda9w==
X-CSE-MsgGUID: g+Em/vtfReOaivdNIwyHhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74114575"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="74114575"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:44:14 -0700
X-CSE-ConnectionGUID: apqLdoj/Qaaf0a/9rbmSSw==
X-CSE-MsgGUID: NUNJhOViRPG7nCoGuDZXSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182192273"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:44:12 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACqW-00000000xjT-2jcB;
	Sat, 18 Oct 2025 22:44:08 +0300
Date: Sat, 18 Oct 2025 22:44:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aPPuCIyL3yuxGQMR@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_124416_551190_E66D0D92 
X-CRM114-Status: GOOD (  21.74  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On Tue, Sep 23, 2025 at 10:50:55AM -0700, Justinien Bouron wrote:
> On Tue, Sep 16, 2025 at 02:51:09PM +0200, Andy Shevchenko wrote:
> > clang is not happy about set but unused variable:
> > 
> > kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
> >   745 |         unsigned long maddr;
> >       |                       ^
> > 1 error generated.
> > 
> > Fix the compilation breakage (`make W=1` build) by removing unused variable.
> > 
> > As Nathan noted, GCC 16 produces the similar warning;
> > 
> > Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
> FYI the commit this patch is fixing (i.e. f4fecb50d6e1) is going to need a
> second revision as well (I haven't submitted it yet, still working on it), this
> means that your "Fixes:" tag will need to be changed again, requiring a 3rd
> revision.
> 
> I am not sure what is the proper way forward here. Should I:
>     - Send my v2, without fixing the unused variable and then you send your v3
>       with the updated "Fixes:" tag pointing to my v2.
>     - OR fixing the unused variable in my v2 (i.e. "absorb" this patch in my
>       v2).

Second is the best (integrate this fix into yours v2).

> In the latter case, I am not sure how I am supposed to credit the work in this
> case? Do I need to add another "Signed-off-by: Andy Shevchenko" besides mine?

Just in the comment block (after the cutter '---' line and before the diff) in
a free words. No need for any special tags for this in such a case.

> I'm still learning the ropes on how to contribute through the mailing list so I
> would be grateful if you could share your input on what's the proper way forward
> here.

-- 
With Best Regards,
Andy Shevchenko



