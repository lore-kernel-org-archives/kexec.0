Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B52EEAA59
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bfkMqxd1Q5eatPgYUOnJi/V5WqF5srHnz1GuYlcjGjc=; b=PeEziPCeidtP78
	UVIehYutc9kuqLhc5QgeWZNJDqjYBiosFflbC1oJHJsZG+UtMFKCY+dN/ebShnjhZ3xNTzgQqjF9p
	NbxtoLkOslNKd29XmwziR51Vo9P+OWyulXxmNHTjw300USV0PGrsSmTnFygj2/HZkxAf3cyy1Oszi
	jxgzoP2EcNk/a/myB48mOlXD2UibWbmOLpYC0bqv1zaIDCYW0+TJvk/Wqd97wjTVz5aQAdhpSnsl3
	jWuirVB7KT+B6LG3m9WHAuqw5KPgnbL/BXdCSZlijqv4rTqCIaMPCt82ypMo98vH9e4a1UnjZfn7b
	P9+hx1LESWg3GvZcadzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgpoY-008xpO-38;
	Thu, 14 Sep 2023 17:07:38 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgpoX-008xog-0N
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 17:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694711257; x=1726247257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/eQr3ybfflzRpAXDDtun+U9e54s/8RMewMOTgkhAo/s=;
  b=OaOblyQU6Qf6erGh8i2rTN+J2fN6cyNMbhhRsEBHcOpms/7QWSms6XpL
   mo1CzGmKU+XyGXkCk8++AvImMf6oNzyY2nFyg/RAwvetBTm0lcQeaBdHd
   25j6iAgdwhoAHwhm34iYopzfmV9mbhnUnMdAHTYUhGlhJRpxdh8yaok0p
   YH3OKAcXwcQ/WaevtEboXVLbSrW22oloGj7eOvS9j0qQ6GkhHSNpO/I5l
   gix3W+oko1VqiS6FsMNzTjpvrMdZCN+9noIVyCtsGFzU31xROJrBweJp/
   89lGNc0sx/L3EKgqv2r05dMWVvkSJQyOsnzeRQI0i3WVKo8EvF6k5aqKV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="382832866"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="382832866"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075471230"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="1075471230"
Received: from njayagop-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.48.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:07:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 5E48B109D89; Thu, 14 Sep 2023 20:07:26 +0300 (+03)
Date: Thu, 14 Sep 2023 20:07:26 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@google.com>, Kees Cook <keescook@chromium.org>,
	Aaron Lu <aaron.lu@intel.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.de
Subject: Re: [PATCH] x86/boot/compressed: Reserve more memory for page tables
Message-ID: <20230914170726.4am7xi36m4hdgiyk@box>
References: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
 <45cdb5ae-986e-d186-f0fd-a308f946ce8d@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <45cdb5ae-986e-d186-f0fd-a308f946ce8d@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_100737_219240_76910BD3 
X-CRM114-Status: GOOD (  18.75  )
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

On Thu, Sep 14, 2023 at 08:51:50AM -0700, Dave Hansen wrote:
> On 9/14/23 05:30, Kirill A. Shutemov wrote:
> > +/*
> > + * Total number of page table kernel_add_identity_map() can allocate,
> > + * including page tables consumed by startup_32().
> > + */
> > +# define BOOT_PGT_SIZE		(32*4096)
> 
> I agree that needing to know this in advance *exactly* is troublesome.
> 
> But I do think that we should preserve the comment about the worst-case
> scenario.

Want me to send v2 for that?

> Also, I thought this was triggered by unaccepted memory.  Am
> I remembering it wrong?  How was it in play?

Unaccepted memory touched EFI system table. I was able to reproduce
without unaccepted memory enabled: if get_rsdp_addr() takes
efi_get_rsdp_addr() path. So it is not the root cause, just a trigger.

So we need several things to run into the problem:

- System supports 5-level paging and it is enabled;

- Decompressor takes control in 64-bit mode, so it uses page tables
  inherited from bootloader until initialize_identity_maps().

  In initialize_identity_maps() kernel resets page tables, rebuilding them
  from scratch. Here we only map what is definitely required: kernel,
  cmdline, boot_patams, setup_data.

  Entering in 32-bit mode would make startup_32() map the first 4G
  unconditionally, but in this setup we rely more on #PF to fill page
  table. It masks problem as we rarely need all four PMD tables.

- Make kernel touch at least one page per-gigabyte in the first 4G.

  In our case, unaccepted memory path was the last straw: it triggered
  allocation of the fourth PMD table which failed. 

We can increase the constant by one and it will work as long as nobody
need anything beyond the first 4G (or any 1G-aligned 4G region where we've
got loaded, I guess). I am not sure we can guarantee this with
(potentially buggy) ACPI and EFI in the picture.

> Either way, I think your general approach here is sound.  But let's add
> one little tweak to at least warn when we're getting close to the limit.

Yeah, makes sense.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
