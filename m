Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29222C433FE
	for <kexec@archiver.kernel.org>; Fri, 30 Sep 2022 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WwXhAT7BvI5xEiI6UW/H1T6I0y/AF6oAZpF8JR3+fnQ=; b=p/C91Guoqr91F5
	b/mLzKIoVcrDliuSQlEKhw2rFM7a2NXxZiS6MT2RRNkNgdETcQfbkXH3EUxEuzMU64mlwqiFnGLnn
	uiB8sgUCNHDCNF0FNu3nhi768MtqCHI3kYzFsttBaVh7VX53YgFpojFSrAvD5m96rgDR5TM/imcoj
	cKFKGChOKFOwqaVQd/HsTkN6EcxAgguxMDoe76dUG2u2mKLz3qdql5EkOMYvRgXAN/+uT5q2MvZf/
	MkAmvHFd4tJJc01Y/MgxSEiNUyHztvz4akxG7QuIHPLj1fPlV01ev/D9TbNGTM10X8BFZk0fa5z7m
	obPXFrl2j7vlPET83Q/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeJEE-00AfrM-ES; Fri, 30 Sep 2022 16:51:10 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeJE9-00Afpq-50
	for kexec@lists.infradead.org; Fri, 30 Sep 2022 16:51:09 +0000
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 521CF1EC04DA;
	Fri, 30 Sep 2022 18:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1664556659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=tP9Z9kALkJplQ//X4pAwQj/9u9C0dERnBu4DmkUwjxM=;
	b=c5NyopsCGhoBd1uFmWvBwlikJDwE9xijsQuDUsK2MmV90jGTOcm63idZOnV6Lj4D4e39P9
	v61pX3A4xPk6l3MtmFUWpfWQtk+mOYlIUb/P9iMve1okkWXLYa8XM4GmjXSHmiQ3q/Ddaa
	ZeUxI7kH5Q5VUgJQuc7SssTEQA+hucI=
Date: Fri, 30 Sep 2022 18:50:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Yzceb/y3SSFMuALR@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_095105_390966_1BB04BDB 
X-CRM114-Status: GOOD (  22.89  )
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

On Fri, Sep 30, 2022 at 10:36:49AM -0500, Eric DeVolder wrote:
> > Your help text talks about System RAM entries in /proc/iomem which means
> > that those entries are present somewhere in the kernel and you can read
> > them out and do the proper calculations dynamically instead of doing the
> > static CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES thing.
> 
> The intent is to compute the max size buffer needed to contain a maximum
> populated elfcorehdr, which is primarily based on the number of CPUs and
> memory regions. Thus far I (and others involved) have not found a kernel
> method to determine the maximum number of memory regions possible (if you
> are aware of one, please let me know!). Thus CONFIG_CRASH_MAX_MEMORY_RANGES
> was born (rather borrowed from kexec-tools).

Let's ask some mm folks.

mm folks, is there a way to enumerate all the memory regions a machine
has?

It looks to me like register_memory_resource() in mm/memory_hotplug.c
does register the resource so there should be a way to count that list
of resources or at least maintain a count somewhere so that kexec/crash
code can know how big its elfcodehdr buffer should be instead of doing a
clumsy Kconfig item where people would need to guess...

Hmm.

> > +#ifdef CONFIG_CRASH_MAX_MEMORY_RANGES
> So I think the use of CONFIG_CRASH_MAX_MEMORY_RANGES is not correct; it
> still needs to be based on the cpu or memory hotplug options.

You're kidding, right?

+config CRASH_MAX_MEMORY_RANGES
+	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
	^^^^^^^^^^				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> > @@ -622,6 +622,15 @@ static int __init crash_save_vmcoreinfo_init(void)
> >   subsys_initcall(crash_save_vmcoreinfo_init);
> >   #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> > +
> > +void __weak *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> > +{
> > +	return NULL;
> > +}
> > +
> > +void __weak arch_unmap_crash_pages(void **ptr) { }
> > +void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
> > +
> I was asked by Baoquan He to eliminate the use of __weak

Because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
