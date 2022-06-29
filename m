Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDC6C43334
	for <kexec@archiver.kernel.org>; Wed, 29 Jun 2022 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hOTHyBWWKjuTCCgYq6/pP+LFRo1hLZ1vQMUabFyh7L4=; b=OYCovUoilbbh/X
	+/klKlzFtaSDjdSxlclR5dP7G5omq60uYlW+ommi+ZmCzXy6wEY8KaZMYwY8mcApElzkZwy2vAHMH
	wLpCa2Bz5BNFMXFxuJXxEXfqiJ/4qfkdOj5FAV+fsymOGkl5iRFcORTInSmEy55dIm1R463PW8K1U
	tYa9Bf/DN93pM6kmmTwqFVmg4oNo074xkvIvRfkPzlQ7mb4NSThTQuN+PQ+/KasPbtx+7Kx8tzKIa
	vYVTdr7rHShDvgM8kQggRtmAZD07IskNgF2zUhfyqLr1xHW5wCWnLpAxwLQZojW8lCckNF/iZmV30
	oCPTVXmkkv/NCjJBdykA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YGF-00CMmS-IH; Wed, 29 Jun 2022 14:01:43 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YG9-00CMjQ-Tv
	for kexec@lists.infradead.org; Wed, 29 Jun 2022 14:01:42 +0000
Received: from zn.tnic (p200300ea97156ae0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:6ae0:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF6A31EC04C2;
	Wed, 29 Jun 2022 16:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1656511279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=1nfA4bd39uY9wmMuXeUB/WuKXARluBCBaMbOeIYcBnY=;
	b=LRK5ezlYQtIou/WwjqaCHEkzUwF537MTzAq2lHavZu/AFBFt05GjuZvi60LPc/HaFKAxzq
	8gWqVL7Mu26tnpybnyjQJEPDCModDkJIdXd2axk+QkTaTDn2Byx0on7m3eWcQgCLlHow8m
	WLyN6KMa6BsOQrx4FEIgjDu5NbaXcMM=
Date: Wed, 29 Jun 2022 16:01:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan McDowell <noodles@fb.com>
Cc: kernel test robot <lkp@intel.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] of: Correctly annotate IMA kexec buffer functions
Message-ID: <YrxbK4IsYb6yls5d@zn.tnic>
References: <202206291039.yGgljGbx-lkp@intel.com>
 <YrwPjnxBk3Xyuakg@zn.tnic>
 <Yrwg1aYEnFz38V6+@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yrwg1aYEnFz38V6+@noodles-fedora.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_070138_147546_6BE7EA1F 
X-CRM114-Status: GOOD (  11.78  )
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

On Wed, Jun 29, 2022 at 09:52:50AM +0000, Jonathan McDowell wrote:
> Below is on top of what was in tip; I can roll a v7 if preferred but
> I think seeing the fix on its own is clearer.

Yes, and you don't have to base it on top because, as I've said, I've
zapped your other patch there.

Once IMA folks are fine with that fix of yours I can take both, if they
wish so.

> ima_free_kexec_buffer() calls into memblock_phys_free() so must be
> annotated __meminit.

Why __meminit?

The very sparse comment over it says:

/* Used for MEMORY_HOTPLUG */
#define __meminit        __section(".meminit.text") __cold notrace \
                                                  __latent_entropy

so how does ima_free_kexec_buffer() have anything to do with
MEMORY_HOTPLUG?

It calls memblock_phys_free() which is __init_memblock.

Now __init_memblock is defined as

#define __init_memblock __meminit

for some CONFIG_ARCH_KEEP_MEMBLOCK thing so I guess that is the
connection.

But then the couple other functions which call into memblock are all
__init...

IOW, I probably am missing something...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
