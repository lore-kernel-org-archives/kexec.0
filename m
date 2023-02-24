Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5F5C7EE2E
	for <kexec@archiver.kernel.org>; Fri, 24 Feb 2023 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nPZu8jYoPp2eguYo4AyiTzPkPrJ7FPXyE0ynWatLmPQ=; b=zqYSEMzVtFpto+
	Oe9MK7nSARdhi2kTcujThdVX0JPVN0o5yFDhY2mx13vfiUy/AMgZlaXbucS9X7/HN4BGKMKXNbqpp
	RnCdo/5jgnwyH+8RFgTCmo6JGGyZL1s9Lm7nDPNECJTPrb+QnXFiTkWVlUIsYYX2LZFAcRwB9dujG
	VcrERNIAcZsTUTCIyGTPODgosSD/84qdEFV5KKyaj0w3QKLO0jVf6DBrnokIvOZ4XojMp53BFzmO8
	2L7GatkNfCqtiGvS7bdlG/8Pa3SfrFpg5vtbN61u1GULhyLOd0jHYp7r5i3DU5qOvg8kPeAKwKSn3
	unZP9OSNVn+YJqenqgqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVagQ-0034Y2-K2; Fri, 24 Feb 2023 16:12:30 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVagN-0034XC-N6
	for kexec@lists.infradead.org; Fri, 24 Feb 2023 16:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677255147; x=1708791147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zrIOX/eAJTtv52elNQI1lM9u3xMyOfuLqflASbexGuA=;
  b=AAoCjdhN9xbVx4TVqCiSkOV1G9ryuHrEaKSYiu4nprRF5SF8U/KJUj0U
   2OTuaLIqppa4j/Xba3rwTDAMgfhNteyXMFrzQr2fzGbzrHCH5fKbrSfbZ
   kK6UmMlNrhkyvu/qlev/2ZO+MB/gMWIuhIEFrfw9liE0l8xujnrim2hTm
   uB+6s4oBnMu4Z9y4gWxnJXNzvLmdJvWTgSwawkyRplzUDA+cP2N5r0G92
   H0vxHXir6mDSgyThrUiX2hOxKxT9dxJ3dONSDPsbbtfaiVz2CGCSVwLTu
   Ycmq9rb9d7P6AifqLdQDztnhYbUtpqvxcWLXcB/gqMlqaCGMC8wccFyMl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="332197945"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="332197945"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:12:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="703227125"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="703227125"
Received: from rkris18-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:12:22 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B706810A5FE; Fri, 24 Feb 2023 19:12:19 +0300 (+03)
Date: Fri, 24 Feb 2023 19:12:19 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Borislav Petkov <bp@alien8.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
	linux-coco@lists.linux.dev, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Message-ID: <20230224161219.txwidrzpfnkbn7oi@box.shutemov.name>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <6b09a3505bf3deaa11906a2ecb9d15c4ec427ea2.camel@infradead.org>
 <20230224143004.xqhpv6upn2fkqkjp@box.shutemov.name>
 <f32f1f77-c707-ae19-ae1a-dc0a37fa9806@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f32f1f77-c707-ae19-ae1a-dc0a37fa9806@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_081227_770202_F629B599 
X-CRM114-Status: GOOD (  14.17  )
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

On Fri, Feb 24, 2023 at 07:22:18AM -0800, Dave Hansen wrote:
> On 2/24/23 06:30, Kirill A. Shutemov wrote:
> > Ideally, it has to be addressed on BIOS level: it has to provide a way to
> > offline CPUs, putting it back to pre-wakeup state.
> 
> Is there anything stopping us from just parking the CPUs in a loop
> looking at 'acpi_mp_wake_mailbox_paddr'?  Basically park them in a way
> which is indistinguishable from what the BIOS did.

+Rafael.

 - Forward compatibility can be an issue. Version 0 of mailbox supports
   only single Wakeup command. Future specs may define a new command that
   kernel implementation doesn't support.

 - BIOS owns the mailbox page and can re-use for something else after the
   last CPU has woken up. (I know it is very theoretical, but still.)

 - We can patch ACPI table to point to mailbox page in kernel allocated
   memory, but it brings other problem. If the first kernel didn't wake up
   all CPUs for some reason (CONFIG_SMP=n or nr_cpus= or something) the
   second kernel would not be able to wake up them too since they looping
   around the old address.

But ultimately, I think it is clearly missing BIOS functionality and has
to be addressed there. Hacking around it in kernel will lead to more
problems down the road.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
