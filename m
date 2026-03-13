Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618AF105F781
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 09:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7RkWyzPXjHL89ofn8Q+fzfKSQYSHi6pxQY83d9wtI7k=; b=AcY6XXuURWwxaSKvNebySNiMhx
	HleqRfI5XhxA/A0DUFp5X3cdKmM3rDWE30MGbnrjMITw+S5u6c8mL9DHVXqbBnEI+tbQTvUmkzvdV
	ahwlCyVEviIc0QnA967fLq+yb9/Yosg5gcy9WnVBORnP1PcfJmZMFlnuhwBhOwSN0D9Y1S+nuZK3t
	sGXHaFmuQHdO1VSNAa3THJi60sNLmqKWVGvYaz6jslsCzBSJul5q7O4+y6yRiCg3A3E3L0kb5ft8k
	B+w/eVBM41tp2HFEoeBsLuXzHoq9ZrNQZtp7kHnTKIrqGPgV5eoZA2lPv6zhCVy+kEhORdH7jBDbC
	7pmQRVAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0z7H-0000000HQ0s-09Vs;
	Fri, 13 Mar 2026 09:47:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0z7F-0000000HPzg-3DoF
	for kexec@bombadil.infradead.org;
	Fri, 13 Mar 2026 09:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7RkWyzPXjHL89ofn8Q+fzfKSQYSHi6pxQY83d9wtI7k=; b=qxiY1Zd0BIuKFdYUU7LFuXtaA1
	dXLJ+F8Tf1Lw4Y2HexEwKokeAfxAhPsVf8SRgRyfPfzZqWKHkoUkTB4Nh7DO+0CjCdNsT8qMyOjFl
	njITAgGKP7v0QapRKv9p44coJYhTi200BWR1MYtXgMV0iFJp2wBHXWqF8SQhvrFfS/fWU5JBkHgzJ
	QoXksL9g/p/QyQMmLrIQUuOMvU3izgn3TJaoapNCDp6V5tzlEum/zox+B8Go6081ka7AUFUk5snBT
	oha2o7eyxAwWKfqx16pCxD5jH/JPhKHRZpuxP5pjO3PLlP5W13POBMmyDsfjAKOTP7YGom1iJIaFY
	7Qfsqoiw==;
Received: from mgamail.intel.com ([192.198.163.7])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0z7A-0000000306I-2Yqe
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 09:47:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773395249; x=1804931249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=shbEn4UYXRSF/93kbIkRAJWzAwqCM62LTnDiD1zvGnQ=;
  b=dEPRQW7y7xOCDBJsOTbjd/JL7a1wxXOs6yeF123ZbOWzb1n2qx21e84i
   bTVnaDV8vIlZt92FfzTDcHZ07jmbJfU95vJaaW7vRSmxpCQW/aRhzJA5L
   p22OrPC+9OsXvYrFGCaNPzRjA5LwkzRLKeVj57ASYtNvKDCkRzKABD15j
   ZzthDfXEE6P6fssQMo9E3/3VKT0BC0anAudZHlPegoO2vmMkjQoe57ma4
   VVqmyxOdoboX4m2VrIyyrm2Sah5ILPC9N8yRqvvImbL98lZArKD9BMJV5
   Ueg3LG1wCAcCGWZmelwwdTJarlsIytvp5CznAEB+G3F7XKhQoomMGeiyo
   g==;
X-CSE-ConnectionGUID: ND/QXx6OTlGsX9j+IJVyMg==
X-CSE-MsgGUID: oLJBZQX2THekBZI82KfB/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="99961765"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="99961765"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:47:23 -0700
X-CSE-ConnectionGUID: GsebdnTlT/SDLdY0V6biEA==
X-CSE-MsgGUID: 10eCGMq3Tca5BCiKpXMAoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="251629178"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:47:17 -0700
Date: Fri, 13 Mar 2026 11:47:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <abPdItJ152oMzGd6@ashevche-desk.local>
References: <20260312230817.372878-1-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312230817.372878-1-ynorov@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_094730_104384_5A93D739 
X-CRM114-Status: GOOD (  17.56  )
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

On Thu, Mar 12, 2026 at 07:08:16PM -0400, Yury Norov wrote:
> Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> 
> The 32-bit behaviour is inconsistent with the function description, so it
> needs to get fixed.
> 
> There are 9 individual users for the function in 6 different subsystems.
> Some arches and drivers are 64-bit only:
>  - arch/loongarch/kvm/intc/eiointc.c;
>  - drivers/hv/mshv_vtl_main.c;
>  - kernel/liveupdate/kexec_handover.c;
> 
> The others are:
>  - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
>  - rzv2m_csi_reg_write_bit(): ARCH_RENESAS only, unclear;
>  - lz77_match_len(): CIFS_COMPRESSION only, unclear, experimental;
> 
> None of them explicitly tweak their code for a word length, or x == 0.
> 
> Requesting comments from the corresponding maintainers on how to proceed
> with this.
> 
> The attached patch gets rid of 32-bit explicit support, so that both
> 32- and 64-bit versions rely on __ffs().

> CC: "K. Y. Srinivasan" <kys@microsoft.com> (hyperv)
> CC: Haiyang Zhang <haiyangz@microsoft.com> (hyperv)
> CC: Jason Gunthorpe <jgg@ziepe.ca> (infiniband)
> CC: Leon Romanovsky <leon@kernel.org> (infiniband)
> CC: Mark Brown <broonie@kernel.org> (spi)
> CC: Steve French <sfrench@samba.org> (smb)
> CC: Alexander Graf <graf@amazon.com> (kexec)
> CC: Mike Rapoport <rppt@kernel.org> (kexec)
> CC: Pasha Tatashin <pasha.tatashin@soleen.com> (kexec)

Please, move the Cc: list to the...

> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---

...comments block. It will have the same effect on emails, but drastically
reduces unneeded noise in the commit message in the Git history.

You may also read this subthread (patch 18) on how to handle it locally:
https://lore.kernel.org/linux-iio/20260123113708.416727-19-bigeasy@linutronix.de/

>  include/linux/count_zeros.h | 9 +++------

...

> +#define COUNT_TRAILING_ZEROS_0 (-1)

Shouldn't we also saturate this to BITS_PER_LONG?

-- 
With Best Regards,
Andy Shevchenko



