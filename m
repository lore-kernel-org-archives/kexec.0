Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF3BC04A95
	for <kexec@archiver.kernel.org>; Tue, 25 Oct 2022 10:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3n4mI/yVWb9vYBKGpkFSJvmPJKkjfTJ8O8psVDnlkrA=; b=XyR363A7Gqs1ye
	SKNGOETiiGUhgUJVyWb42QzAk9rUO8K/IdX6H/Xq3F8qY4WuGPrqWN+OAmwrERA38IlzddNlGCEUY
	7fY9UwYOU3SlNNBRs9QdL9sU3R0vemCHQeIr0JswXPHPrrevsdiJGbSWcxJBqMdQ8QH2ctCsWnsxv
	UUtvlch3x9D6ynNf4xl2r2MBkpO/ZDnjo8/ybnl5N8WMFFrQeWy3F1nfgB6lXqsVGABOghs6mvljI
	3nyguCjii2ncp0bkpeDFeTcV2W2qBXnPqPYxCeDGcJViDQ1xc2NFrNXho2827nOTORA0svAvS1HUj
	JQtyqwU+8kfUWw/IzRiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onHLP-004pGr-8S; Tue, 25 Oct 2022 10:39:39 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onHLM-004pFm-9u
	for kexec@lists.infradead.org; Tue, 25 Oct 2022 10:39:37 +0000
Received: from zn.tnic (p200300ea9733e753329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e753:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77F211EC04CB;
	Tue, 25 Oct 2022 12:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1666694374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=bJEdtbRqgdbjhqUqDGLu9oDkYSzHvDi/vH6BXxoFAh8=;
	b=JxIF5aD8t+drPh0XyHi/aIDkukRMN7v+nUHqpoC0kztFZF/DC3CYHhIjv8G0wKaXyWcgJ2
	NJswHW8qF/0qgkCUBTscjqoybTkfq7npVh1L77t2FH8Z+j9aYvMn2i6v+EnvcLXRHTv8xn
	0ypbB4muvtXV4mgjUbabEqF3ztjeN8Y=
Date: Tue, 25 Oct 2022 12:39:34 +0200
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
Message-ID: <Y1e85gqB3kzlx7qL@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <bec2e406-bd4f-e845-6216-31c74619819b@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bec2e406-bd4f-e845-6216-31c74619819b@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_033936_523342_0C999CB4 
X-CRM114-Status: GOOD (  12.73  )
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

On Wed, Oct 12, 2022 at 11:20:59AM -0500, Eric DeVolder wrote:
> I once had CONFIG_CRASH_HOTPLUG, but you disagreed.
> 
> https://lore.kernel.org/lkml/Ylgot+LUDQl+G%2F5N@zn.tnic/
> 
> From there I simply went with
> 
>  #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> 
> which route do you prefer?

If you do a single Kconfig item which depends on those two, it probably
is cleaner this way. And if the max memory ranges are hardcoded you
don't need the other prompt asking the user something she most likely
doesn't know how to answer properly.

That is, unless you wanna have that crash hotplug built in all the time.

Because CONFIG_HOTPLUG_CPU is pretty much always enabled so you might
just as well add the crash hotplug support unconditionally, without any
Kconfig ifdeffery whatsoever except CONFIG_MEMORY_HOTPLUG as that is
special and not present on the majority of hardware.

But on a plain simple laptop or workstation which has CPU hotplug, would
it make sense for the crash ranges to get updated too when CPUs are
offlined?

If so, I think you want this code present there too, without a Kconfig
item.

If this is server-only anyway, then a single Kconfig item sounds like
not such a bad idea.

I hope that makes some sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
