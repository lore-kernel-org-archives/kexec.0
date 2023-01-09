Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC36CC54EBD
	for <kexec@archiver.kernel.org>; Mon,  9 Jan 2023 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AOjNuQgSLT+jsY8G/6zHNkBijbtomClVxQiiA+4iz+4=; b=vzWq66Z07vZk+f
	+T0DLfqT4Wm1pys6B1RD6dKVl0NWlGi37PTRb+Jq5bkfeX5xppyLH5NhGEbZEQeEtf6NyZSx4valt
	Fk0BmktWZGkQ3Z8jPzepsyhrIKA/bF0Sn18Sqovef+lD6Pv3D6LprXAs8ODP0CnwRa93157Jjr4Hx
	uQfMDH8sbBsK5Lc8i7lN3b2x8nbDaYf8C63A5s47GjypJ8Z9c2US72LzTlAn78W9Bgqb3LN2RQSyP
	lC+5NzDu7A/e+CaAWPu6ZfZe6Psj9Ne5QWw6tsPmuzz34Kaah0ytWpojaBz/vxHyqqV7vvm6L2F00
	6uYyWfet8gim7a+I6FQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF1rz-004fjX-7A; Mon, 09 Jan 2023 23:47:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF1rw-004fhd-K7
	for kexec@lists.infradead.org; Mon, 09 Jan 2023 23:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673308073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ4O+Pza8mF8eNdykukSI5mqc0eTZz0ZSMoCpZTcRks=;
	b=hXygRydR9PAqFxRzrew/AS5JnFyTVV8LDy5mBECgR/g8WiRI/Rh0NUfof/MWpqH/PLrKPb
	gFZqwE6XXgPFMLvKdvTaPPcurSehVDglz097yjmI/NVyCFccnE1gDN4NvzabDDufWCjedD
	D2PAA7jvx7a43Hxk514d8ZJrKbmChDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-0McbnAQPNYWv7LgkHKfDuw-1; Mon, 09 Jan 2023 18:47:49 -0500
X-MC-Unique: 0McbnAQPNYWv7LgkHKfDuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C4FC80234E;
	Mon,  9 Jan 2023 23:47:48 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 328642166B26;
	Mon,  9 Jan 2023 23:47:47 +0000 (UTC)
Date: Tue, 10 Jan 2023 07:47:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v16 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y7ynnzmfy+Kxj8hQ@fedora>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
 <20230105151709.1845-8-eric.devolder@oracle.com>
 <Y7vD6bm9xy9uyvRD@fedora>
 <bc4ade74-dcbc-88f6-2d88-2bd4c2be38ba@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc4ade74-dcbc-88f6-2d88-2bd4c2be38ba@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_154756_753513_4E96B91A 
X-CRM114-Status: GOOD (  21.11  )
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

On 01/09/23 at 01:43pm, Eric DeVolder wrote:
> 
> 
> On 1/9/23 01:36, Baoquan He wrote:
> > On 01/05/23 at 10:17am, Eric DeVolder wrote:
> > ......
> > > @@ -394,10 +409,37 @@ int crash_load_segments(struct kimage *image)
> > >   	if (ret)
> > >   		return ret;
> > > -	image->elf_headers = kbuf.buffer;
> > > -	image->elf_headers_sz = kbuf.bufsz;
> > > +	image->elf_headers	= kbuf.buffer;
> > > +	image->elf_headers_sz	= kbuf.bufsz;
> > > +	kbuf.memsz		= kbuf.bufsz;
> > > +
> > > +	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
> > > +		/*
> > > +		 * Ensure the elfcorehdr segment large enough for hotplug changes.
> > > +		 * Start with VMCOREINFO and kernel_map.
> > > +		 */
> > > +		unsigned long pnum = 2;
> > > +
> > > +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > > +			pnum += CONFIG_NR_CPUS_DEFAULT;
> > > +
> > > +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> > > +			pnum += CRASH_MAX_MEMORY_RANGES;
> > 
> > Logic of pnum calculating is a little confusing to me. If I only enable
> > one of CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG, is it OK? Say I
> > only enable CONFIG_HOTPLUG_CPU and CONFIG_SMP, on x86_64,
> > CONFIG_NR_CPUS_DEFAULT will be 64. pnum will be 64, is it OK. Am I miss
> > anything?
> 
> Ah, your understanding is correct, and the issue you point out I need to fix.
> Specifically is only one of HOTPLUG_CPU or MEMORY_HOTPLUG is set, then I need
> to allow a default for the other. Using the example you have above, there would
> not be room for a single memory region, so I need to allow for a default number
> of memory regions.

Hmm, for the above example, should we get real number of memory
regions? I am worried if the default number of memory regions 
need be big enough. Because on system w/o memory hotplug, it could have
very many memory regions. The cpu number is similar.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
