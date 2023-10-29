Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1835CC4332F
	for <kexec@archiver.kernel.org>; Sun, 29 Oct 2023 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yR5OPes7X4pWu3v8qCuVxDRp45tb/XJ2bZPVy7ZGtwA=; b=oiOWPvBol53QzS
	26PRdNr7+oSGbpTcQ67CFmKwt1Rg0uuXhCcy/xBAJ1mE9DsylxC9KUFf2C/Aezi4WBD2xJ5KGLJx2
	nJ/6AQsnToRTRE0CJbXlj3DZvEzRnKf9TLsWStar+lODp1adstrhMaIF4hUNFeWcq1aEWVAU6dLTM
	oqBk0CzNkRn/QcBAe8FHShDzqHRARGjE/nSZiFCazZWUQ1VWp+m+Iv5ml2iPKhNqsmTUIb57SZ+m9
	Uw+b8ybzf5zw478r7IRjdS23WKOv+pXtFuJkKqleZONMf+SHcYNOmDDKFLJW2LQ/qFi3k2xrdwcmE
	xwtaPY9yJiMS5+JcRGpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qx6hm-001ofH-2F;
	Sun, 29 Oct 2023 14:23:54 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qx6hi-001oec-23
	for kexec@lists.infradead.org;
	Sun, 29 Oct 2023 14:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698589430; x=1730125430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TRjASw0YiznO3WvwpwfHDnA6Y5I6mL2iMy28CyYTpIQ=;
  b=SSATf6hlQ76jI5TJpYGDdkM5Hr553udKonfo4aB2NR3BMPLqpigVdipf
   51pTp8C7py0FWq70rhODzRyWnR51h7xpPWq6D0vKglI0nNGYsTgP4wawD
   iYozPnbN9p69LF6LGsWfLjFU1SUq5juRU3px8++cRIXAA/i6ojrp3x0HF
   fWc6Us9YQX3YZzq1j1p+O/pSGhhbhHwQhBSFVDNdd5GRbTLsgXCyLky+p
   acc6wNXd2m7DYD8LbUSBErGi1JSJvDsQLswUQSJ6Tq48QpxgAY4z+kTIU
   3D/NJ/EW/vFGdA6ss8BgBTuQsfV/wjG6BD8BKRK2JCCnEeIfVm4GH7JY8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="391817795"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="391817795"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 07:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="1289679"
Received: from aafra-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.32.230])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 07:23:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B5C9B10A29C; Sun, 29 Oct 2023 17:23:37 +0300 (+03)
Date: Sun, 29 Oct 2023 17:23:37 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Message-ID: <20231029142337.54cvg7cuwlmr3bzc@box>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
 <87a5s225vp.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a5s225vp.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_072350_783309_85161343 
X-CRM114-Status: GOOD (  16.00  )
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

On Sat, Oct 28, 2023 at 04:12:10PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 20 2023 at 18:12, Kirill A. Shutemov wrote:
> 
> Subject: cpu/hotplug: ...
> 
> > ACPI MADT doesn't allow to offline CPU after it got woke up.
> 
> ACPI MADT is a table ...
> 
> This is about the MADT mailbox wakeup method, right?
> 
> > Currently offlining hotplug prevented based on the confidential
> 
> is prevented
> 
> > computing attribute which is set for Intel TDX. But TDX is not
> > the only possible user of the wake up method.
> >
> > Introduce cpu_hotplug_not_supported() that can be called to indicate
> > that CPU offlining should be disabled.
> 
> Otherwise the changes look good!

Thanks!

Thomas, could you take a look if the last patch in the series is sane?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
