Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A804AC433F5
	for <kexec@archiver.kernel.org>; Sat,  8 Oct 2022 02:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H/MRaekY8S9lLdB9ckG5ewKW3lOHY7BuiwxxBmz9Hw0=; b=K7pWkFRBenKLZI
	fNIpWrbI9EDxAH7hEoZ/uEAm+JdM/OEP0HFfGFtEeXLnO0mbwK+6vOIzvO1efSR+uiSqkTcgUGcAs
	bkFUOjjcDfD7cIqnpUiuhvSS9yZM9X/AqrWYz0+0RvtoJfrn3OLWI0+Snchtaf+MB45M4J7Vtd2Ze
	iFKaXylZ3OegxvoTMzj3VOt90T5yYO5MQ33rYW2+kkAMFxb8rxzcrLeepK5ea3ZPMXGr5Xxq2gTuJ
	PHquIq9myD6cA8Q1qayNLtJpPkoPytYZW70JEdG5FpguQR/3mtiPLFB6QPnMIVy7BTSGvjkY8uCNZ
	LEbMeTRYafJMnNr7k0uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogzgX-00BSn5-72; Sat, 08 Oct 2022 02:35:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogzgU-00BSlk-Ni
	for kexec@lists.infradead.org; Sat, 08 Oct 2022 02:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665196523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5IsnY8coRZJSVHdnCDXDDkPFYnnu8TF82UevKAb/afk=;
	b=FIAxGAj5YBSV8DzDyu69+s1BexeWBABIYER9irL3wDNdEnVusPzjf7SXhkAzJYSJmSkhds
	VbL7QTVuuenBgDFBfvBTs8Ooosztw7pnSnYB7AB6DZAvswA/UrfBF6Px2H2P9fI8Nyj7I5
	GX8c1/awNLS+uuf2+p8dYgPGJWGwVx8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-AoMLW116PyS1BS81jRxTAg-1; Fri, 07 Oct 2022 22:35:20 -0400
X-MC-Unique: AoMLW116PyS1BS81jRxTAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3367B3C0E219;
	Sat,  8 Oct 2022 02:35:19 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 100679D474;
	Sat,  8 Oct 2022 02:35:18 +0000 (UTC)
Date: Sat, 8 Oct 2022 10:35:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Eric DeVolder <eric.devolder@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzcqE1RVtPcuLlxN@zn.tnic>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_193526_873334_CDE91846 
X-CRM114-Status: GOOD (  29.94  )
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

On 09/30/22 at 07:40pm, Borislav Petkov wrote:
> On Fri, Sep 30, 2022 at 12:11:26PM -0500, Eric DeVolder wrote:
> > There is of course a way to enumerate the memory regions in use on the
> > machine, that is not what this code needs. In order to compute the maximum
> > buffer size needed (this buffer size is computed once), the count of the
> > maximum number of memory regions possible (even if not currently in use) is
> > what is needed.
> 
> Isn't that max number documented somewhere in memory hotplug docs?

Memory hptlug is not limited by a certin or a max number of memory
regions, but limited by how large of the linear mapping range which
physical can be mapped into.

E.g on x86_64, with 4-level page tables, it has 64TB linear mapping
range by default. On principle, we can add 64TB of phisical memory
into system altogether from booting and memory hotplug. While with
KASLR enabled, it has 10TB of linear mapping range by default, see
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING. Means there's only 10TB
phisical memory being allowed to be added into system.

For the Kconfig CRASH_MAX_MEMORY_RANGES Eric added, it's meaningful to
me to set a fixed value which is enough in reality. For extreme testing
with special purpose, it could be broken easily, people need decide by
self whether the CONFIG_CRASH_MAX_MEMORY_RANGES is enlarged or not.
E.g on x86_64, we make a system with memory smaller than 64G, this will
cause the memory block size being probed as 256M. Then we hot added many
Tera Bytes of physical memory every second memory block after bootup with
a shell shell script. It could be easier to manipulate this with virtiomem.
Please see function probe_memory_block_size() on x86_64 about the memory
block size probing. However, I don't think on real system, this kind of
system could really exist, with a tiny memory booted up, a huge memory
hot added sparsely.

> 
> Because then you don't need that Kconfig item either. Imagine you're a
> distro kernel distributor and you want crash to work on all machines
> your kernel works.
> 
> So you go and set that number to max. And that would be the 99% of the
> kernel configs out there.
> 
> Which means, you can just set it to max without a Kconfig item.
> 
> > Oh, that would be an error of haste on my part. This should be:
> >   depends on CRASH_DUMP && MEMORY_HOTPLUG
> 
> You need a Kconfig item which enables all this gunk as MEMORY_HOTPLUG is
> not a omnipresent feature. And that Kconfig item should depend on the
> other Kconfig items of the technology you need.
> 
> > Baoquan pointed me to:
> > 
> > https://lore.kernel.org/lkml/cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com/T/
> 
> In that thread says:
> 
> "- arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>   Retain the function prototype for those and move the weak
>   implementation into the header as a static inline for other
>   architectures."
> 
> So yes, that's even better.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
