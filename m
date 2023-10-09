Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BF9E95A91
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4XEt+xjfNxuyAgKbEAslVbR/DJ2V4DJ6nCtuOwpkYWQ=; b=gS0FHmu8Nn2aie
	OqcUpfqGZKP8YyqP9Ql+/qE9WgXDAF914AEZUJQP9/6Brhq3gwbKooUExMbSNYZZew/TEgjxbCpuC
	QBbEfVFO1Yf76KiZ6oX3SpE8ZcjLyCFdtlEYDB3WooDg5s10FNmwoDpK41TDaFjRXdn8m9Sy4MB+Y
	HUdizTaoR2Nditpuaegz2mrfXAGpFLRbcIeljDvfGypycwgRHsn7MQKwQHx5O+Y2jQS5rjb5Ch4hB
	bAr5JJVPK3cr0cGB/4Q4nOQxfRPLxCGZSh0gvkqoKcITH3kRbiktIDTvOP+9W5E+pfmGl07I3Sp18
	rfDXN8WG23F1URw4KNfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqNa-00Aoco-24;
	Mon, 09 Oct 2023 13:33:02 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqNZ-00Aobe-00
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 13:33:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696858381; x=1728394381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KQiIeN5ST8uGhtT0LhMJYQQaH+STe2BjgqRaOYnAfTw=;
  b=DJgcpOlPZIB2dj+sLhHCtMVJ8tXeAqwY9oxK+sRq3Qrbq6kbYrwnhjGp
   yBtA1+LFOdwZrlBhFc+erEuahbWI20XsAPDnPixM1Xx4syOgCgQFkYC7p
   bCeC8wdNXJ57Nm+KhaPXBRoRbS6GJnvW1iQjdHUJBfdcrzaSMGXvH2mwM
   Drgb7Lbu8GEm+IurT7Yz8DZetFsEiFgXJW+n0b1AjVrnYADNvQm2iG6tw
   ewIwCksAz8qoPpkzDdYXNHTS3l4Hpq+vDntGdqOxW7liHHySbO+gS1Sh0
   8uVk14czQ20TGM+lKf9EkJJhn4b30/DcmDj4zgm6jmcaVWb5LOyULr05T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374473692"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="374473692"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="782491307"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="782491307"
Received: from ahuge-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:32:53 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 4EAB710A196; Mon,  9 Oct 2023 16:32:51 +0300 (+03)
Date: Mon, 9 Oct 2023 16:32:51 +0300
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
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 05/13] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <20231009133251.lmdubojesxtwzdyl@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-6-kirill.shutemov@linux.intel.com>
 <2c76fa83b154566e49425e3a7ccc9a268318d63a.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c76fa83b154566e49425e3a7ccc9a268318d63a.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_063301_088508_A22D8B63 
X-CRM114-Status: GOOD (  11.48  )
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

On Mon, Oct 09, 2023 at 12:30:55PM +0000, Huang, Kai wrote:
> On Thu, 2023-10-05 at 16:13 +0300, Kirill A. Shutemov wrote:
> > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX environments.
> 
> Nit: non-TDX-guest environments. ?

Okay, will fix.

> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Thanks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
