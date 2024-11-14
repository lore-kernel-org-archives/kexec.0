Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61039D65C58
	for <kexec@archiver.kernel.org>; Thu, 14 Nov 2024 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MK2gGs1BXstcPVGdu6CHHu5mGO/pKmuTrzAsijR1xcE=; b=QLE/7VaeCfxlfB
	yR1SW703JTUHKgXRfc76EWaqA1KTyBmuhRblqWMzS3l/M2DRZi8OUmzeYAH4YFFC7aNBF3Cqceex6
	zGNugDfWLjwES3X1m6D/yhWoSOgWxrRKlM3uS47cxGmvDBK8cB0aw2ST8+fJYHIqlqCXX+P531oXW
	buxc8zK1p6YYwfJdwBoYKTGoxp2ACmc5I4fZupHzXONyS/POE4l9ljvtNYh5hx/UYgjvpjZcyAY6S
	qyRqwwRMYA0og6dBw1Hdm4hhUclCyg/Dl5OAt+2YVaM2PrnWd5vn4Eh59LN8vfQb3qpw/rvnDuMCE
	ZykvnFfnPsLKqKAabUmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBUTw-000000096ZQ-134I;
	Thu, 14 Nov 2024 07:41:36 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBUSy-000000096S2-3siE
	for kexec@lists.infradead.org;
	Thu, 14 Nov 2024 07:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731570037; x=1763106037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L5fyaTcmXE+0OTLELcU68IrkvwaIdTyleUoThwtZasU=;
  b=JhSXbPQ9bGRHbQJ6mmItK9/tFkWosNPw9aGmsXir0gfO6LnYFVNkj/I5
   qqO14HlaeLKBpLaQRjB/xgT7KLCoZBsRdnAmVBPiFAmNCMHHVSpIrRbYm
   ypVbcgIAiZ1/SPx13MF9htJCafBahBKtENQc0Nu1+VSeI7kpCZlLvFP3x
   3VCoPYuq0gJWrprwC6a+fyVSnhj5IMtgj/IutuLHOjF29p67vxH77YNMy
   avFp1xfFkw854SCC6rBuQeQ5/I/5IeqgFeqfXdXRU6mtHOh2R7SPHgBfX
   kjA8+bcK8W3M96pDFsyqp4EIia6U23NPTT067YtGczAgWMLQEkiLUQb4D
   g==;
X-CSE-ConnectionGUID: xLKLCxvpShGZ0GLgCgP0mA==
X-CSE-MsgGUID: /JOyhlbTQSiQOnl+JEsOAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42917886"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42917886"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 23:40:25 -0800
X-CSE-ConnectionGUID: M1u0CHloTailCxqdhGJHKQ==
X-CSE-MsgGUID: 7EO6T3bqQFWw+RMuUToXjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="119049617"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2024 23:40:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 00BE122B; Thu, 14 Nov 2024 09:40:19 +0200 (EET)
Date: Thu, 14 Nov 2024 09:40:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Woodhouse, David" <dwmw@amazon.co.uk>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"kai.huang@intel.com" <kai.huang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
Message-ID: <ZzWpY_zR43Zq5WJh@black.fi.intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
 <20241103054019.3795299-7-dwmw2@infradead.org>
 <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
 <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
 <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_234037_050031_749D5F8D 
X-CRM114-Status: GOOD (  21.59  )
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

On Tue, Nov 05, 2024 at 01:58:40PM -0800, H. Peter Anvin wrote:
> On 11/5/24 13:37, H. Peter Anvin wrote:
> > What is the point of writing this code in assembly in the first place? A
> > much more logical thing to do is to just push the registers you haven't
> > pushed already onto the stack and call a C function to do the actual
> > dumping? It isn't like it is in any shape, way or form performance
> > critical.
> 
> arch/x86/boot/compressed/misc.c has some code that you can crib, both for
> writing to a text screen (not that useful anymore with EFI framebuffers) and
> serial port. If you factor it a little bit then you can probably even share
> the code directly.
> 
> (__putstr perhaps should have a __putchar() factored out of it?)
> 
> Then you can just do the obvious (have your assembly stub point %rdi to the
> base of the register dump; set the frame order to whatever you'd like,
> except rip/err/exc, or reverse the order if you prefer by changing the
> loop):
> 
> static inline __noreturn void die(void)
> {
> 	while (1)
> 		asm volatile("hlt");
> }
> 
> void dump_register_frame(const unsigned long frame[])
> {
> 	static const char regnames[][5] = {
> 		"rax:", "rcx:", "rdx:", "rbx:",
> 		"rsp:", "rbp:", "rsi:", "rdi:",
> 		"r8: ", "r9: ", "r10:", "r11:",
> 		"r12:", "r13:", "r14:", "r15:",
> 		"cr2:", "Exc:", "Err:", "rip:"
> 	};
> 
> 	for (size_t i = 0; i < ARRAY_SIZE(regnames); i++) {
> 		__putstr(regnames[i]);
> 		__puthex(frame[i]);
> 		__putstr("\n");
> 	}
> 
> 	/* Only return from int3 */
> 	if (frame[17] != 3)
> 		die();
> }

+ a mil here!

Please, use existing early_serial_console infra. Also we have
debug_putaddr() / debug_puthex() / debug_putstr() which are
probably ones you want to use.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
