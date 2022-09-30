Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9C6C433F5
	for <kexec@archiver.kernel.org>; Fri, 30 Sep 2022 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rntuFa2xwW5Xfsj89QNcTKmunSk/RP7CF5ZdE62SiPY=; b=qjPQ1JSpBpVpML
	BlaJ6/QwVmoeF/nTaR1Y75YGn7g4mc7bNyHayBy9BFioiCb/NHK1uhRJeoO+AHGYNoyDuwOeqLbjS
	65P3xDzTFHL2nAoq9E06QcnIqD6YP6dRee93IJ1pkz2Xg77/frs/rEp/0j+rMVEi9v50ZqYPxnWnA
	p/FZzm7BQtwV/YzQMu+Kb9sbZ9Urfg/EXMrfMnfWt7kHyZKCuBoxrDZ++2HfBmpjMPF+x2GcKw/Ar
	SdUaGsyE0r/7IHcA26WPZ9emm/PrlC9kLMEqhSpGXMzNDInmXYCEEq9RYEnVt0cvFUvkJuUtnXpZ2
	3XxTpcdo6H9KVdZKcokg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeK0K-00AqM0-KB; Fri, 30 Sep 2022 17:40:52 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeK0G-00AqJQ-9A
	for kexec@lists.infradead.org; Fri, 30 Sep 2022 17:40:51 +0000
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE81F1EC01CE;
	Fri, 30 Sep 2022 19:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1664559636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=rPlsW5KXga8GPT52DXx9hd1bxPky9/DpS45uUaF1jqQ=;
	b=LAMPYyFU5/elnJA6eLDIg0hj/h8ekXQ+HIwqaG5hORiAdOY3BXtgD2dOu4EWezSox6Kfu4
	cuuNrlmnypVPqorNFf45jNS+fzd5mpIvfODZpSEW+KyeqJhlSqdYQlDu8P8BCxaqaOSm13
	7DNGh8ICOnqiSTOkxmKCmlRCNRD/iVk=
Date: Fri, 30 Sep 2022 19:40:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
	bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <YzcqE1RVtPcuLlxN@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_104048_516563_00FD5E7B 
X-CRM114-Status: GOOD (  16.95  )
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

On Fri, Sep 30, 2022 at 12:11:26PM -0500, Eric DeVolder wrote:
> There is of course a way to enumerate the memory regions in use on the
> machine, that is not what this code needs. In order to compute the maximum
> buffer size needed (this buffer size is computed once), the count of the
> maximum number of memory regions possible (even if not currently in use) is
> what is needed.

Isn't that max number documented somewhere in memory hotplug docs?

Because then you don't need that Kconfig item either. Imagine you're a
distro kernel distributor and you want crash to work on all machines
your kernel works.

So you go and set that number to max. And that would be the 99% of the
kernel configs out there.

Which means, you can just set it to max without a Kconfig item.

> Oh, that would be an error of haste on my part. This should be:
>   depends on CRASH_DUMP && MEMORY_HOTPLUG

You need a Kconfig item which enables all this gunk as MEMORY_HOTPLUG is
not a omnipresent feature. And that Kconfig item should depend on the
other Kconfig items of the technology you need.

> Baoquan pointed me to:
> 
> https://lore.kernel.org/lkml/cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com/T/

In that thread says:

"- arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
  Retain the function prototype for those and move the weak
  implementation into the header as a static inline for other
  architectures."

So yes, that's even better.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
