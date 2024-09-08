Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA1AECE57A
	for <kexec@archiver.kernel.org>; Sun,  8 Sep 2024 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M1cHDLueqKXeOuCip4fwQjglsa6vZCe/aH20ugWPSNw=; b=od69Z1HSF5ab9d
	Xz41I8YyJsaa+FRxOnizoaRae2ZtQZ+SP8cSQkaqLP9gAe968iwUiR7QQB2TS1Xp+mM6jmyuPnTxe
	RkxSksgUuxSAPuf1jZ/dHKT4bAymnB43VCjuEULRmzo2O68nqbaBpv1IvRG+qgx6rxAJ/DgcqfWNN
	ZzNiZQYL/y4mdPwMN7s5RFhJEsgnYqZV6MibgqXIk2BIfCNye9uGEKYwknmyJG1wNVzTNmCh5KhMl
	aAgAl6o4tG/Za4HnTtTancLh0PqrjHvWxbIVt7gbi5lHNKZjWAnv5oOtrlFRmyMtTO+wmx4gdDSai
	cLU7pO1yXCn/vjPCl21Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snEmg-0000000GYDG-3V4Q;
	Sun, 08 Sep 2024 10:04:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snEmd-0000000GYCL-2lYf
	for kexec@lists.infradead.org;
	Sun, 08 Sep 2024 10:04:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725789876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4s6L1b6UTWwXIgN+h2ZkyoLWzDj1bmp+8k4owaes3c=;
	b=i2ripcD+m8VbXyVQ1nLHNXcONtm4WYnWYsmdgkyGVnwTDxmCiwWN5Cq0VwkGoOmTie/Jcf
	wW/l5zjsdX0ZDb9gQCwmqkRlvt8t8flzPadQw0ZEJWQmVUv7GIbwdEYfflSJYWei1Mt8ba
	IyiJ1sUXroAzhqt/v6O1CEmaUoxjJBM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ADwoEIdTNxK39xifeSiilQ-1; Sun,
 08 Sep 2024 06:04:33 -0400
X-MC-Unique: ADwoEIdTNxK39xifeSiilQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1466119560AB;
	Sun,  8 Sep 2024 10:04:31 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D951956048;
	Sun,  8 Sep 2024 10:04:28 +0000 (UTC)
Date: Sun, 8 Sep 2024 18:04:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] [RFC] crash: Lock-free crash hotplug support reporting
Message-ID: <Zt12p/eOCO0D5/e6@MiWiFi-R3L-srv>
References: <20240823115226.835865-1-sourabhjain@linux.ibm.com>
 <641be54a-440f-475b-a62d-fac157ecbbcb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <641be54a-440f-475b-a62d-fac157ecbbcb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_030439_808028_2798F225 
X-CRM114-Status: GOOD (  25.29  )
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

On 09/07/24 at 10:30am, Sourabh Jain wrote:
> Hello Baoquan,
> 
> Do you think this patch would help reduce lock contention when
> CPU/Memory resources are removed in bulk from a system?
.....snip...
--
> >   include/linux/kexec.h | 11 ++++-------
> >   kernel/crash_core.c   | 27 +++++++++------------------
> >   kernel/kexec.c        |  5 ++++-
> >   kernel/kexec_file.c   |  7 ++++++-
> >   4 files changed, 23 insertions(+), 27 deletions(-)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index f0e9f8eda7a3..bd755ba6bac4 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -318,13 +318,6 @@ struct kimage {
> >   	unsigned int preserve_context : 1;
> >   	/* If set, we are using file mode kexec syscall */
> >   	unsigned int file_mode:1;
> > -#ifdef CONFIG_CRASH_HOTPLUG
> > -	/* If set, it is safe to update kexec segments that are
> > -	 * excluded from SHA calculation.
> > -	 */
> > -	unsigned int hotplug_support:1;
> > -#endif
> > -
> >   #ifdef ARCH_HAS_KIMAGE_ARCH
> >   	struct kimage_arch arch;
> >   #endif
> > @@ -370,6 +363,10 @@ struct kimage {
> >   	unsigned long elf_load_addr;
> >   };
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +extern unsigned int crash_hotplug_support;
> > +#endif
> > +
> >   /* kexec interface functions */
> >   extern void machine_kexec(struct kimage *image);
> >   extern int machine_kexec_prepare(struct kimage *image);
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 63cf89393c6e..3428deba0070 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -30,6 +30,13 @@
> >   #include "kallsyms_internal.h"
> >   #include "kexec_internal.h"
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +/* if set, it is safe to update kexec segments that are
> > + * excluded from sha calculation.
> > + */
> > +unsigned int crash_hotplug_support;
> > +#endif
> > +
> >   /* Per cpu memory for storing cpu states in case of system crash. */
> >   note_buf_t __percpu *crash_notes;
> > @@ -500,23 +507,7 @@ static DEFINE_MUTEX(__crash_hotplug_lock);
> >    */
> >   int crash_check_hotplug_support(void)
> >   {
> > -	int rc = 0;
> > -
> > -	crash_hotplug_lock();
> > -	/* Obtain lock while reading crash information */
> > -	if (!kexec_trylock()) {
> > -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > -		crash_hotplug_unlock();
> > -		return 0;
> > -	}
> > -	if (kexec_crash_image) {
> > -		rc = kexec_crash_image->hotplug_support;
> > -	}
> > -	/* Release lock now that update complete */
> > -	kexec_unlock();
> > -	crash_hotplug_unlock();
> > -
> > -	return rc;
> > +	return crash_hotplug_support;


I may not understand this well. Both kexec_load and kexec_file_load set
hotplug_support, crash_check_hotplug_support and
crash_handle_hotplug_event are to check the flag. How do you guarantee
the cpu/memory sysfs checking won't have race with kexec_load and
kexec_file_load?

And here I see taking crash_hotplug_lock() is unnecessary in
crash_check_hotplug_support() because it does't have race with
crash_handle_hotplug_event().

> >   }
> >   /*
> > @@ -552,7 +543,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
> >   	image = kexec_crash_image;
> >   	/* Check that kexec segments update is permitted */
> > -	if (!image->hotplug_support)
> > +	if (!crash_hotplug_support)
> >   		goto out;
> >   	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index a6b3f96bb50c..d5c6b51eaa8b 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -116,6 +116,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >   		/* Uninstall image */
> >   		kimage_free(xchg(dest_image, NULL));
> >   		ret = 0;
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +		crash_hotplug_support = 0;
> > +#endif
> >   		goto out_unlock;
> >   	}
> >   	if (flags & KEXEC_ON_CRASH) {
> > @@ -136,7 +139,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >   #ifdef CONFIG_CRASH_HOTPLUG
> >   	if ((flags & KEXEC_ON_CRASH) && arch_crash_hotplug_support(image, flags))
> > -		image->hotplug_support = 1;
> > +		crash_hotplug_support = 1;
> >   #endif
> >   	ret = machine_kexec_prepare(image);
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 3d64290d24c9..b326edb90fd7 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -378,7 +378,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >   #ifdef CONFIG_CRASH_HOTPLUG
> >   	if ((flags & KEXEC_FILE_ON_CRASH) && arch_crash_hotplug_support(image, flags))
> > -		image->hotplug_support = 1;
> > +		crash_hotplug_support = 1;
> >   #endif
> >   	ret = machine_kexec_prepare(image);
> > @@ -432,6 +432,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >   		arch_kexec_protect_crashkres();
> >   #endif
> > +#ifdef CONFIG_CRASH_HOTPLUG
> > +	if (flags & KEXEC_FILE_UNLOAD)
> > +		crash_hotplug_support = 0;
> > +#endif
> > +
> >   	kexec_unlock();
> >   	kimage_free(image);
> >   	return ret;
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
