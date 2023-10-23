Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5A8C004C0
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AzuWWBkFdjVll+3FPzE+7CHEc2OThwzVUEJpaox8Rp0=; b=HYgZQOCQCtJdng
	rk8OXmcwRR0TG6BE/av/TDMJnsXtri3E6P7L/2zQBIS+KGPpya3TOrcFbCpQAUOtPLNcuHzr0HigD
	bhzsFURy5UxIBRsQOF8WWfwOn6Gtslq9huZY3gWqdLgHS+uKVw0vTEQrivT1Ii4I48SrG3b8b1aEU
	ALghd4ajo2H+jfFBlonEwLDcH9NEoJiZaaQtPxGwbxtJhenZ01pWhele7gXWVXdxH0EqMOym0Jn63
	wYLKjEcfg/k+YmhQMA6QG1k4Fckq97LDhFTLTwBlGVbI6GJvzpPSku+9JUOsmYQsD0JxraVtJd/ZF
	0l1oZUWkkvDCZWGf0m+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quwy2-007hcB-17;
	Mon, 23 Oct 2023 15:35:46 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quwxz-007hb6-0x
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 15:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698075343; x=1729611343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rh3WIkroWfusSZh8pyM6xIJoI8clu8Gzvxh74Q9Cu1A=;
  b=AKPGAb0/jc5FfAl2fWdRgn94CgdgJ1pSnfg3S2sIqIWc/U/ZPOvP+tR0
   zLBcBzwwhSdhE7wIbT7WTgmt+KCTJXDv1QcUVjCBjsAjkqmMLkt5gApl+
   Giw3EqMYpnpNvON8oBxO3bfcDOz6pjasGFsTNkF6QyBZ52xSG1T9XDtR9
   i9RO+6NazNglV+nGsUaCvShdhxmjC3sRxixXRbIMmkT4/fteSAROh85aF
   DEmSqkRIWIFCDHp4NAHbn845ODCevodMFMsLpPkrScOHZ45GaMFg1MIXY
   joC3oLmHVyaUyIb+hlZDB6CWCOdYhYyXiztnvz6gvccKOQfSqK1UwGnW+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385762203"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="385762203"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828480810"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="828480810"
Received: from swidman-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.211.241])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:31:45 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id D62B9109B10; Mon, 23 Oct 2023 18:31:42 +0300 (+03)
Date: Mon, 23 Oct 2023 18:31:42 +0300
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
	"Christopherson,, Sean" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Message-ID: <20231023153142.bes7zxcjc2soihsl@box>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
 <0a29fef814e51a2aa0030ec9cc97366718859411.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a29fef814e51a2aa0030ec9cc97366718859411.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_083543_346698_39016C43 
X-CRM114-Status: GOOD (  20.16  )
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

On Mon, Oct 23, 2023 at 09:30:59AM +0000, Huang, Kai wrote:
> IMHO it's a little bit odd to have two mechanisms in place, even in this middle
> state patch.  Is it better to completely replace CC_ATTR_HOTPLUG_DISABLED with
> the new cpu_hotplug_offline_disabled in this patch? You can explicitly call
> cpu_hotplug_disable_offlining() in tdx_early_init() so no functional change is
> done.

I can. But I don't see how it makes a difference.

> Or I am wondering why cannot just merge this and the next patch together, with a
> proper justification?

Because the very next thing reviewers would ask is to split them :P

> Btw, IMHO the changelog (this and next patch's) seems didn't explain the true
> reason to replace CC_ATTR_HOTPLUG_DISABLED.
> 
> 	Currently hotplug prevented based on the confidential computing
> 	attribute which is set for Intel TDX. But TDX is not the only possible
> 	user of the wake up method.
> 
> "TDX is not the only possible user of the wake up method" doesn't mean we need
> to replace CC_ATTR_HOTPLUG_DISABLED.  E.g., other CoCo VM type can also select
> CC_ATTR_HOTPLUG_DISABLED if it uses MADT wake up method.
> 
> To me the true reason is the new MADT wake up version actually brings the
> support of offlining cpu, thus it's more suitable to decide whether the CoCo VM
> needs to disable CPU offline based on the MADT wake up version, but not the CC_*
> attributes that is determined by CoCo VM type.

No. MADT is orthogonal to CoCo. It can be implemented outside of CoCo
environment and CoCo platform can implement other wake up methods. It is
not up to TDX/SEV/whatever to decide if offlining is supported. It is
property of the wakeup method implemented on the platform.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
