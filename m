Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35B9C5ACB3
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 09:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9uFeKRMTkWjnkgiuzE7FgxDfZPmWdx2qFX/LsUgN9xk=; b=KupYebVlL03l1t
	TuSAsJ2KvpofLz0KpnMjh5vUJWnqKSSiTvpicPdz1EYdJKK9XyraqVuiyCVFzqGlaDa1CShzsCM0X
	YB3prUtNwYeUVeZ93LK9OuY5rVRtct+m/Li1riRzQi88uPEln4dmhvYj3GN5k6Yml/IoOn5qM5uvZ
	KxVIQCNR1zkohzZI3hYIRez4KTWkjtKUfFSHESQUPY4xxKRqCGzmPe6dNj6rkHF0Wf3gIszDDBjTv
	B8pnmKIs+B7pAXwFTxWSVwvUUV4CLnvdWHnrcC3GwRrXfIr6FHJq94c2ZCyPbhXxdsii+k2Jbv0TK
	VYZnCNakXFF9pw8X5Qpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5N6B-00G93m-1H;
	Tue, 21 Nov 2023 09:31:15 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5N68-00G92A-21
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 09:31:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700559072; x=1732095072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bzOd0cd2+5cL6VwtiHKsX8WwvIE2qYTC6osgFynenks=;
  b=B+9DNo5FDG7g4h6J7URhM3jO6PpSfe0CgRiDRTHWdfMzu1EZtzVC0FJl
   57KEQnlG2NXvXVE2S/12ABB06Z3TT6ZCInoSjygS00jX6Jzz4G5+2CgZd
   vlwX/LkwlsQeZp7tOC9zvgLsRd6eVVL1PxIsYte7b8UabrnuY08KAS7as
   OXaaCvyzS0Zg5H8RFg4nBv8HmHOjo6kaQowjU+4QvFsnE5cEmH0h+EwxF
   h9L9tBqmlmljrEaiRg4V70UhSYnMGgzVfNeMZAJqtiWwRDq0RrdnxOw7E
   jxW8l8IpJURAzx3MrMjP+1O7/0p6JD91Nf6yJVDlS9tFgRl9Zb8lCAIoG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4930137"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4930137"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:31:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="8023791"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:31:08 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 14A2410A36E; Tue, 21 Nov 2023 12:31:05 +0300 (+03)
Date: Tue, 21 Nov 2023 12:31:05 +0300
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 03/14] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Message-ID: <20231121093105.ev77pgbssq6scugm@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-4-kirill.shutemov@linux.intel.com>
 <dbb07c1ba14dc1bd3066aa8b784b884c67638ac1.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dbb07c1ba14dc1bd3066aa8b784b884c67638ac1.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_013112_741726_8911C917 
X-CRM114-Status: GOOD (  15.56  )
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

On Tue, Nov 21, 2023 at 02:15:59AM +0000, Huang, Kai wrote:
> On Wed, 2023-11-15 at 15:00 +0300, Kirill A. Shutemov wrote:
> > The ACPI MADT mailbox wakeup method doesn't allow to offline CPU after
> > it got woke up.
> > 
> > Currently offlining hotplug is prevented based on the confidential
> > computing attribute which is set for Intel TDX. But TDX is not
> > the only possible user of the wake up method. The MADT wakeup can be
> > implemented outside of a confidential computing environment. Offline
> > support is a property of the wakeup method, not the CoCo implementation.
> > 
> > Introduce cpu_hotplug_not_supported() that can be called to indicate
> > that CPU offlining should be disabled.
> 
> cpu_hotplug_not_supported() -> cpu_hotplug_disable_offlining().

Right.

> > 
> > This function is going to replace CC_ATTR_HOTPLUG_DISABLED for ACPI
> > MADT.
> 
> Is MADT too generic? MADT wakeup?

I'll replace it with "ACPI MADT wakeup method".

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
