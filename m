Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E49C04FFE
	for <kexec@archiver.kernel.org>; Mon, 29 Apr 2024 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qwdgHSqH7Bf06EfxPe52ddJBAqwkFpig5fWMHFi6yW4=; b=xqE4w1LqvAcJc1
	6zxLGaIFtc/aqXAdC/a3llUnJmCwoAaezitMnjsenxV5QV1oEdbq3p8UzL67wWbva4qCBws60Fgzg
	EFDcC1d8TIhTiM5VNFjtSPucYJ18fyzWdtRe0UV9+48ECsRI/vO5ojxUo4X3oDUTAH0WifJm/4Vgb
	q7Q9twExjf2RpggQLEUJ8QN5MT6xZa3yE5b0CIJ6lFNyCeTBcKq8hpGQ9cBsxD4PeUv5Zh56Ybu1D
	MvCG4+IqRpQbalwG8oH21K4a35VOpvL8a+TpnCSgxS2SxQhW47Y0hHp2tLuVVQ0RRbmoeMUev72W/
	oOWuWzp42V+I5dz9f6wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Sku-00000003ML9-2AEw;
	Mon, 29 Apr 2024 15:17:24 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Skr-00000003MIj-1MgQ
	for kexec@lists.infradead.org;
	Mon, 29 Apr 2024 15:17:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714403842; x=1745939842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MlSlRGaYiem3SuUQO4BAsBy3xzf+/yW9MMNWdq/F60Y=;
  b=LbISdxnSrmWPCv4ZuDaEPbUtejCg5JXzFijVLYfTmqsbnoMKRTl5RnZO
   rTIMfa8b7AHGAAJkKTtWmY/vrQ+Ys40ZaHYnZOf8WNeTv9M5mHmSvpDFq
   gatYl13jq4RwjKpx1Hy189jUrzzFLYGQeff5s/E7RgfR898CjzZRYKD4H
   DO1BPRdjEEVdjlHYGvX4RAKhWMNzo9Dqx1qfMznTsZDYkwj4ggn46vA/W
   gi7tSnSd+PoVOWxtes1e8veLSPLLykyffU/abSuTQHBatMy7lpHfG2FzM
   ha9BiSd5sSVQIR17T/giyR/ieK/jKjjNhtYDOv9SBCVdlcBlrUnib+1ux
   Q==;
X-CSE-ConnectionGUID: jPioD44aStWpun/v2nNpGA==
X-CSE-MsgGUID: zIvXNz8yS6CuI3jOUqeX9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10187903"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10187903"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 08:17:01 -0700
X-CSE-ConnectionGUID: 3l6VczyNSXi1e+hlJ02smw==
X-CSE-MsgGUID: sLGm4kwkThqjbQ/IHUUlBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26098655"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 08:16:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D0D851A0; Mon, 29 Apr 2024 18:16:54 +0300 (EEST)
Date: Mon, 29 Apr 2024 18:16:54 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <yh7wbdce5o35l4nkrkml3jp7tyzvzxwnfji2vmvnvaczsl6gdr@6qnwpw7g76a3>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
 <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
 <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
 <20240429144454.GHZi-yZkD0boKk5N17@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240429144454.GHZi-yZkD0boKk5N17@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_081721_441364_72B0D395 
X-CRM114-Status: GOOD (  15.93  )
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

On Mon, Apr 29, 2024 at 04:45:08PM +0200, Borislav Petkov wrote:
> On Mon, Apr 29, 2024 at 04:17:38PM +0300, Kirill A. Shutemov wrote:
> > As I mentioned above, clearing CR4.MCE triggers #VE. It is quirk of the
> > platform.
> 
> You mean when identity_mapped() runs as part of a kexec-ed kernel, it
> might clear CR4.MCE and that would trigger the #VE?

Yes, that's what happens in current upstream.

> So, if that is correct, you basically want to *preserve* the CR4.MCE
> setting across kexec?

Yes.

> But then __mcheck_cpu_init_generic() will go and set it
> unconditionally.

__mcheck_cpu_init_generic() will not change anything in this case as the
bit is already set. Everything is hunky-dory.

> So what exactly is the correct flow here?

TDX guest has CR4.MCE set from time 0 and it has to stay this way all the
time including kexec flow.

We have already modified early boot code to preserve CR4.MCE. See
77a512e35db7 ("x86/boot: Avoid #VE during boot for TDX platforms").
The patch extends it to kexec flow.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
