Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85842C4829E
	for <kexec@archiver.kernel.org>; Tue, 13 Feb 2024 03:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eJAigTnPLuWnk4bcOuR6/qwvioZcOzP4LmgP06iEgvk=; b=iK0ArpyLi6tNy+
	v1lGm1HW9bTgRfkvTCBGvwlpqmPuQ2WpAVcyTHm3RlORvdR8O0PIvGyA5Hc0Pc7PstFAQkB/ijZEP
	vTjge+GFYEwCpnQd3bAgrPOjsC6GSprJZwFB/tOJfx3piWpW/2K6SrY7J/kK/fD2sfMgp/ULWBcfl
	2EvhbjqF2H1KayXveVURnLmwpWOLR67KgIYZNKLumg2f3n6+a1dIA5KLzGN5j26HfhVhpfeeeKUYs
	4hSkatEN6n8uCoGYSELRHLtj4Kwp3t96rvSvDDVyyaN3NrcNxBmw6VDlGYBjVWHSzWf7mQKgT+7gb
	hmZvvVOKUo3TYTzNdSag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZjMF-00000007qFN-3rSy;
	Tue, 13 Feb 2024 03:21:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZjMD-00000007qEb-0vFP
	for kexec@lists.infradead.org;
	Tue, 13 Feb 2024 03:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707794474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfgfhhR1Sp5K6tynZua/CXQcXYMTqRCAqc8M/+9/nR0=;
	b=KMdTJDItNbjbf/2lDUExxxTqHidIFbtKkhgvJIjTUIRhyd9OJfSy4v7VNYYBqc/cNsPsxV
	/reiNaZ7H8bWY1XvHKIKK19NmCJ1VgCB1ycAUiBDCNEQ+vb6zCskD4YLoUjdgSUE5UoabE
	jAV3QRdJtJWmxcRHrSr/pbKfMQyQ7uU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-ygDcdn5FO2eqML2zuzcgKw-1; Mon,
 12 Feb 2024 22:21:10 -0500
X-MC-Unique: ygDcdn5FO2eqML2zuzcgKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF97628237C0;
	Tue, 13 Feb 2024 03:21:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EBD92166B31;
	Tue, 13 Feb 2024 03:21:06 +0000 (UTC)
Date: Tue, 13 Feb 2024 11:21:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v15 2/5] crash: add a new kexec flag for hotplug support
Message-ID: <ZcrgHvTbDGbXc894@MiWiFi-R3L-srv>
References: <20240111105138.251366-1-sourabhjain@linux.ibm.com>
 <20240111105138.251366-3-sourabhjain@linux.ibm.com>
 <ZcBRle7szFrD3cW+@MiWiFi-R3L-srv>
 <cc02538f-9460-4cbb-9ae4-194412b85e36@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <cc02538f-9460-4cbb-9ae4-194412b85e36@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_192117_383657_A89A5AFB 
X-CRM114-Status: GOOD (  34.00  )
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

On 02/12/24 at 07:27pm, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 05/02/24 08:40, Baoquan He wrote:
> > Hi Sourabh,
> > 
......
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 802052d9c64b..7880d74dc5c4 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -317,8 +317,8 @@ struct kimage {
> > >   	/* If set, we are using file mode kexec syscall */
> > >   	unsigned int file_mode:1;
> > >   #ifdef CONFIG_CRASH_HOTPLUG
> > > -	/* If set, allow changes to elfcorehdr of kexec_load'd image */
> > > -	unsigned int update_elfcorehdr:1;
> > > +	/* If set, allow changes to kexec segments of kexec_load'd image */
> > The code comment doesn't reflect the usage of the flag.
> I should have updated the comment to indicate that this flag is for both
> system calls.
> More comments below.
> 
> > You set it too
> > when it's kexec_file_load. Speaking of this, I do wonder why you need
> > set it too for kexec_file_load,
> If we do this one can just access image->hotplug_support to find hotplug
> support for currently loaded kdump image without bothering about which
> system call was used to load the kdump image.
> 
> > and why we have
> > arch_crash_hotplug_support(), then crash_check_hotplug_support() both of
> > which have the same effect.
> 
> arch_crash_hotplug_support(): This function processes the kexec flags and
> finds the
> hotplug support for the kdump image. Based on the return value of this
> function,
> the image->hotplug_support attribute is set.
> 
> Now, once the kdump image is loaded, we no longer have access to the kexec
> flags.
> Therefore, crash_check_hotplug_support simply returns the value of
> image->hotplug_support
> when user space accesses the following sysfs files:
> /sys/devices/system/[cpu|memory]/crash_hotplug.
> 
> To keep things simple, I have introduced two functions: One function
> processes the kexec flags
> and determines the hotplug support for the image being loaded. And other
> function simply
> accesses image->hotplug_support and advertises CPU/Memory hotplug support to
> userspace.

From the function name and their functionality, they seems to be
duplicated, even though it's different from the internal detail. This
could bring a little confusion to code understanding. It's fine, we can
refactor them if needed in the future. So let's keep it as the patch is.
Thanks.

> 
> > 
> > > +	unsigned int hotplug_support:1;
> > >   #endif
> > >   #ifdef ARCH_HAS_KIMAGE_ARCH
> > > @@ -396,9 +396,10 @@ bool kexec_load_permitted(int kexec_image_type);
> > >   /* List of defined/legal kexec flags */
> > >   #ifndef CONFIG_KEXEC_JUMP
> > > -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
> > > +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
> > >   #else
> > > -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
> > > +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
> > > +			KEXEC_CRASH_HOTPLUG_SUPPORT)
> > >   #endif
> > >   /* List of defined/legal kexec file flags */
> > > @@ -486,14 +487,18 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
> > >   static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
> > >   #endif
> > > -int crash_check_update_elfcorehdr(void);
> > > +int crash_check_hotplug_support(void);
> > > -#ifndef crash_hotplug_cpu_support
> > > -static inline int crash_hotplug_cpu_support(void) { return 0; }
> > > -#endif
> > > +#ifndef arch_crash_hotplug_support
> > > +static inline int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
> > > +{
> > > -#ifndef crash_hotplug_memory_support
> > > -static inline int crash_hotplug_memory_support(void) { return 0; }
> > > +#ifdef CONFIG_KEXEC_FILE
> > > +	if (image->file_mode)
> > > +		return 1;
> > > +#endif
> > > +	return kexec_flags & KEXEC_CRASH_HOTPLUG_SUPPORT;
> > > +}
> > >   #endif
> > >   #ifndef crash_get_elfcorehdr_size
......


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
