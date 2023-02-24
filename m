Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE9C61DA4
	for <kexec@archiver.kernel.org>; Fri, 24 Feb 2023 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nlOaCNhcJTRWlX92HI9zmFZoU6/AOO9t4vASh67PtW4=; b=StMRmsC7iPJHGP
	M7HmMynJimve3SCgNqmJjnoqnh0X/GQOjWGNI6W0pr0c56tK5hvx1S4bxK8f0RfyZ2dHtCM+dup/U
	HktuBQyd+mz/9Y/UThHgCX0/wZWap8lxOd9TpmC7+juRFxJ1+icv2t9EL1cZRGqeSMQ/bYl4D7b/N
	xlNwrce0LNQprDjKXzilCMeD7k8kAjZof+X+O+kF7Dr+2/BtBdxX61PtOVWTCpydW5KGHrJ2Q4G1e
	koDFbnGEtm4xYu0sCRQsOkmeexsS7/Lq/QaEL/w7rAjgY/PC6jKk/zhvdg4pGhB4Z8/TFgpIGAOXw
	77E7Q76XGnGRJxqlpDrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVZ5V-002lvx-F2; Fri, 24 Feb 2023 14:30:17 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVZ5R-002luA-Hl
	for kexec@lists.infradead.org; Fri, 24 Feb 2023 14:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677249013; x=1708785013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8oT9KIiIwHATiu37VBCkX8K+98mUm7+5JCf02Wuh6IQ=;
  b=IhfZWVxghcb0YGlhu8vN5jd7CZE8gV0HahsqG0LZpRQNGBsvMUj0ovne
   cNzNVDOGwkYF2mpFXiIK7cA7d0WBnF82ZbqWmpEf1+UMq484gKLAN+n1h
   Tmx6v/k8yeWVtc4+f9vJI+vxYOOxArJYPxpcJYPmah8HU/bLor2Gm7Q1t
   yr5fcCICm4oC5M/pUFOlM/D9ibalqVuQY99i0QSPnA3BJS5RzPA5W7ENf
   o4qcbWbi4zTxLvry9O5kCkU9FxrljJyQmS4cyPEUVcoOYBQoKHHifX6Zf
   9tRg9KV01qenwQV3UmVN9Kr7RMReZ8FKMbswG7jq7+2oSl+YcDA4uirfl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="313118674"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="313118674"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:30:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="815759493"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="815759493"
Received: from rkris18-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.190])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:30:06 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 52A9910A5FE; Fri, 24 Feb 2023 17:30:04 +0300 (+03)
Date: Fri, 24 Feb 2023 17:30:04 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
	linux-coco@lists.linux.dev, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Message-ID: <20230224143004.xqhpv6upn2fkqkjp@box.shutemov.name>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <6b09a3505bf3deaa11906a2ecb9d15c4ec427ea2.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b09a3505bf3deaa11906a2ecb9d15c4ec427ea2.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_063013_609783_A5D9C0E0 
X-CRM114-Status: GOOD (  19.19  )
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

On Wed, Feb 22, 2023 at 10:26:22AM +0000, David Woodhouse wrote:
> On Tue, 2023-02-14 at 02:48 +0300, Kirill A. Shutemov wrote:
> > The patch brings basic enabling of kexec in TDX guests.
> > 
> > By "basic enabling" I mean, kexec in the guests with a single CPU.
> > TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
> > doesn't allow to put a CPU back offline if it has woken up.
> > 
> > We are looking into this, but it might take time.
> 
> Can't we park the secondary CPUs in a purgatory-like thing of their own
> and wake them from there when we want them?
> 
> Patches for that were floating around once, although the primary reason
> then was latency, and we decided to address that differently by doing
> the bringup in parallel instead.

That's plan B. It is suboptimal. kexec() can happen into something that is
not Linux which will not be able to wake up CPUs.

Ideally, it has to be addressed on BIOS level: it has to provide a way to
offline CPUs, putting it back to pre-wakeup state.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
