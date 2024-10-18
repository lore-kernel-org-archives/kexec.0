Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B0ED30006
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SoIqznwgFVdfU8FXlw0n60sk7dV2R7bw+AIhsk3vEns=; b=jPw/D33AQ+9HVs
	rftmZ5NaWWnL7Fi7bW7Z8yrWp6FQ6B1fS4Oc7+m4c26S/K380ah6SfiLDWS77cuJ6oRQY/oLbA9Nf
	rb0fLFGxFgrl5NRaHndw1yDN055ieuXYZCt63Vw01OFth4vNIsuEiDuNYLOJBCpkLdCpZCJDDomkP
	WeUTwl5qJ7YB5p6M5es3VOon7raY5aURAw+ZpTPmws2chAq2HUjB9gEUlYhO/OsGNmW75OU50MdbG
	TSfthTPSK9WiS2Du6qOrwz7Oc2kvD5ea1SG4oRxYfo5xswxSEiyJ9fwJhAcqk4ICPBIh50p0g1PqG
	nhMmJWdjxIgx9zv5lT1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1mdN-00000000pB3-0Uoz;
	Fri, 18 Oct 2024 13:03:13 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1mY0-00000000ocr-0oD3
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 12:57:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729256260; x=1760792260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vi3a1mXgYGi7GRXfKsrnUCbV0Q+BiHOW7Bq6nhRpVk=;
  b=YBWorI8UUXTz94oDb1SNrqHofnkExo6un9GqUcw8XQ1axqnUrrQNldXo
   lwQ+/VOtNGkvHUuS6rbVD6plH6u5tFPebNC02IMTcYuyk8r4wXBl7KQ0k
   PI1a1NPbzcMd+fVVOzRDy52sUJjDUlV5z9Z/WQcs5DtMjZnaDhT5zZvVg
   jl8tYS1WL9pYohXSiOmUvHYd6z6BrlKru5/cj9P7QgakMGTcA3y5reJ9E
   VYFrwNpUPjiuja8ETr1nm4kFdZCf1wm6MPFpayH/E5ggvMxzY9EKtvcQL
   bCshV4eprqwDcVsoJ+qcRpJceSPOkbngdtN4wpzmOS3L8KhX51Qikdb01
   g==;
X-CSE-ConnectionGUID: 5FGEZYvnQUmcfVxIo+Ds+A==
X-CSE-MsgGUID: XPktgbOvSh2TYm/WPrxzqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="39412768"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39412768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:57:37 -0700
X-CSE-ConnectionGUID: G9LB692CSuS0E4anPdXY2w==
X-CSE-MsgGUID: r3KnnZ/hSOqpnxrDRYyR+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79283610"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:57:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1mXq-00000004T8S-2EsZ;
	Fri, 18 Oct 2024 15:57:30 +0300
Date: Fri, 18 Oct 2024 15:57:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, mika.westerberg@linux.intel.com,
	ying.huang@intel.com, bhe@redhat.com, tglx@linutronix.de,
	takahiro.akashi@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJbOinZ0E4Ppmak@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241017190347.5578-1-gourry@gourry.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_055740_264425_8856949A 
X-CRM114-Status: GOOD (  12.53  )
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

On Thu, Oct 17, 2024 at 03:03:47PM -0400, Gregory Price wrote:
> walk_system_ram_res_rev() erroneously discards resource flags when
> passing the information to the callback.
> 
> This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> have these resources selected during kexec to store kexec buffers
> if that memory happens to be at placed above normal system ram.
> 
> This leads to undefined behavior after reboot. If the kexec buffer
> is never touched, nothing happens. If the kexec buffer is touched,
> it could lead to a crash (like below) or undefined behavior.
> 
> Tested on a system with CXL memory expanders with driver managed
> memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
> showed the flags were being discarded and as a result the check
> for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.
> 
> find_next_iomem_res: name(System RAM (kmem))
> 		     start(10000000000)
> 		     end(1034fffffff)
> 		     flags(83000200)
> 
> locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)
> 
> [.] BUG: unable to handle page fault for address: ffff89834ffff000

Please, cut this down to only important ~3-5 lines as suggested in
the Submitting Patches documentation.

Yeah, I see that Andrew applied it to hist testing branch, if it's not going to
be updated there, consider above as a hint for the future contributions with
backtraces.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
