Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36085D2FFFA
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1ijHW9rMBf8kyEHccArFpTfnJFWMhZ1Z/54EWE5GtgY=; b=Y1dEur+Hljjqxs
	XH1NzzLVh17XlNZZYFJHrgFGxffb8c9VDQupj+zPQ7uR9TkjTEJ9BfvvFwpthpPwV/jZyFV3Dh+Bq
	5jEREu0C8/6Oz6WDGXkkJCN2tfdSLUEVRJ2Tjh8Dv+nzWzXFTYisfspTGnCA0zOT3yDhg2BbnzaqW
	gPTmo6beT3CddcZ1iV8ZI5m3nbKlVp5TJWltLABg8TQ2++7AUluHCIAJC7GXIx59gG4dAzaBExRCh
	mGIMXxr00+Jxqtl6JSknPhF52YmanipKuSHmne5fNyLlVUkcC0M+sBTkb/C2P8BLZ0D1aWKGjg6l6
	dcgA3pz6/JSeJn6TTkVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1pMX-00000001GfP-3hqP;
	Fri, 18 Oct 2024 15:58:01 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1pMU-00000001Gew-3yTk
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 15:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729267079; x=1760803079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/jhK/IFMqwYDsQdHj+5TZBuOduQ+FEeTuIymxvj+BtU=;
  b=SIpJHmUMCRcZVY83KdLdnbgXZcoi6esgBsctQMa77dyv3fjkqgZU/HBD
   KHCCbVNNU66Otkas6X0rfo7DNJk7lElQpk2e1xDap+VQgWt9f5WL7255C
   J+o39jOu6O1eOMpAHRvIrY41iZaWq2bSJER1XwUJ7njmAlfutC3aB82St
   HBkjAKaUjXnUDDTG1+BKvQTYqfoia7TQ2kNdQPw247lBiwDb2Cd9dWmHK
   ZvbzmdWFmj9vvHzEo1KZeC5wV00gwiYvsOwqm0fCLJ0xNRxfNTEU7/j0d
   WgRN07on/Er/7iyFpboES4zT2nsXuj01Q4AtJnSWEdJuU9bfERDCg3wlZ
   Q==;
X-CSE-ConnectionGUID: HR1vjYKpQvuSKisX5uOczQ==
X-CSE-MsgGUID: fv9LoOM9SguCAOD/C/KAag==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="40200891"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="40200891"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 08:57:54 -0700
X-CSE-ConnectionGUID: J/Sl4MABSPKELOlAeygCFg==
X-CSE-MsgGUID: qlkVBjWrQuebpoPjghY1gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83534334"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 08:57:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1pMK-00000004WXx-3hbY;
	Fri, 18 Oct 2024 18:57:48 +0300
Date: Fri, 18 Oct 2024 18:57:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com, ying.huang@intel.com,
	tglx@linutronix.de, takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxKFfOIOhxlw2YJD@smile.fi.intel.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
 <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
 <ZxJ13aKBqEotI593@smile.fi.intel.com>
 <ZxJ2NxXpqowd73om@smile.fi.intel.com>
 <ZxKBFMAecrL25Fwb@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZxKBFMAecrL25Fwb@MiWiFi-R3L-srv>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_085759_055231_8E217A80 
X-CRM114-Status: GOOD (  21.93  )
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

On Fri, Oct 18, 2024 at 11:39:00PM +0800, Baoquan He wrote:
> On 10/18/24 at 05:52pm, Andy Shevchenko wrote:
> > On Fri, Oct 18, 2024 at 05:51:09PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 18, 2024 at 09:52:47PM +0800, Baoquan He wrote:
> > > > On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> > > > > On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:

...

> > > > > Can we get more test cases in the respective module, please?
> > > > 
> > > > Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
> > > > test cases basically is system testing, not unit test or module test. It
> > > > needs run system and then jump to 2nd kernel, vm can be used but it
> > > > can't cover many cases existing only on baremetal. Currenly, Redhat's
> > > > CKI is heavily relied on to test them, however I am not sure if system
> > > > with CXL support is available in our LAB.
> > > > 
> > > > Not sure if I got you right.
> > > 
> > > I meant since we touch resource.c, we should really touch resource_kunit.c
> > > *in addition to*.
> > 
> > And to be more clear, there is no best time to add test cases than
> > as early as possible. So, can we add the test cases to the (new) APIs,
> > so we want have an issue like the one this patch fixes?
> 
> I will have a look at kernel/resource_kunit.c to see if I can add
> something for walk_system_ram_res_rev(). Thanks.

Thank you! I will appreciate that.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
