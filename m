Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E4C531E1
	for <kexec@archiver.kernel.org>; Thu, 19 Feb 2026 22:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=alc86/6tZez+jJ4pB8akwxTAsV8UqLXdKg2TaieKjWU=; b=biS5csTN/PjrfIW0ZgRqRnmX3y
	LBvhV9rK0XqV6LSGipFexj61bjeZ+cUlsuAvNElUIXTcNuxdSLinaoSc7/7G3GPBXrKyDlHSiKmyH
	q6IYTspFtSifpaK69+/3wPLBEOd7sMRWRsZHxFaXSTEtq3m1yM9c0VgGA1eNN2iLMFRxpE4J3ypP+
	eyKG7W1BiYeuVdXKIvOjYauQn3dB6vHPrQteja/8LfAXrR/d2OvTw0gFkYo2GZ/CtWVy2kwhJxu+M
	ykZaFMNlI53Dtfsf1y367wCCjaTkUzTyL7ktFCGkqGmRolRXNbbtg0C9tRAuPkcGdbuWQeH6ABJWl
	aDUU8i+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtCHI-0000000C8Hj-0OaH;
	Thu, 19 Feb 2026 22:13:44 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtCHF-0000000C8HO-2yKQ
	for kexec@lists.infradead.org;
	Thu, 19 Feb 2026 22:13:42 +0000
Received: from skinsburskii.localdomain (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id A537B20B6F00;
	Thu, 19 Feb 2026 14:13:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A537B20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771539220;
	bh=alc86/6tZez+jJ4pB8akwxTAsV8UqLXdKg2TaieKjWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUYs7JSPF4TPiElOtjdBVx6EpHxPNorxgQOJUCDSAN94GWrSaf7YiiIrXSlG15BPU
	 3Ikn6YUKufJsRrwYGAZvbVAVTwHjSMgglU+b8AVsCbqOYL1iy4QU0NpAF2wH7FDZtP
	 3AjLaHQIXa0/vmmbAEm80MycYWhs0MVn7Fmi7kak=
Date: Thu, 19 Feb 2026 14:13:37 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kexec: Add permission notifier chain for kexec
 operations
Message-ID: <aZeLEZ3SlLmf9aS-@skinsburskii.localdomain>
References: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176962212169.85424.4683391728440118017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <fb651abf-0546-3bef-bf8f-597f35ddc0d6@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb651abf-0546-3bef-bf8f-597f35ddc0d6@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_141341_798866_762D8773 
X-CRM114-Status: GOOD (  25.53  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Feb 12, 2026 at 02:12:29PM -0800, Mukesh R wrote:
> On 1/28/26 09:42, Stanislav Kinsburskii wrote:
> > Add a blocking notifier chain to allow subsystems to be notified
> > before kexec execution. This enables modules to perform necessary
> > cleanup or validation before the system transitions to a new kernel or
> > block kexec if not possible under current conditions.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >   include/linux/kexec.h |    6 ++++++
> >   kernel/kexec_core.c   |   24 ++++++++++++++++++++++++
> >   2 files changed, 30 insertions(+)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..311037d30f9e 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -35,6 +35,7 @@ extern note_buf_t __percpu *crash_notes;
> >   #include <linux/ioport.h>
> >   #include <linux/module.h>
> >   #include <linux/highmem.h>
> > +#include <linux/notifier.h>
> >   #include <asm/kexec.h>
> >   #include <linux/crash_core.h>
> > @@ -532,10 +533,13 @@ extern bool kexec_file_dbg_print;
> >   extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> >   extern void kimage_unmap_segment(void *buffer);
> > +extern int kexec_block_notifier_register(struct notifier_block *nb);
> > +extern int kexec_block_notifier_unregister(struct notifier_block *nb);
> >   #else /* !CONFIG_KEXEC_CORE */
> >   struct pt_regs;
> >   struct task_struct;
> >   struct kimage;
> > +struct notifier_block;
> >   static inline void __crash_kexec(struct pt_regs *regs) { }
> >   static inline void crash_kexec(struct pt_regs *regs) { }
> >   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> > @@ -543,6 +547,8 @@ static inline int kexec_crash_loaded(void) { return 0; }
> >   static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> >   { return NULL; }
> >   static inline void kimage_unmap_segment(void *buffer) { }
> > +static inline int kexec_block_notifier_register(struct notifier_block *nb) { }
> > +static inline int kexec_block_notifier_unregister(struct notifier_block *nb) { }
> >   #define kexec_in_progress false
> >   #endif /* CONFIG_KEXEC_CORE */
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 0f92acdd354d..1e86a6f175f0 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -57,6 +57,20 @@ bool kexec_in_progress = false;
> >   bool kexec_file_dbg_print;
> > +static BLOCKING_NOTIFIER_HEAD(kexec_block_list);
> > +
> > +int kexec_block_notifier_register(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&kexec_block_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(kexec_block_notifier_register);
> > +
> > +int kexec_block_notifier_unregister(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_unregister(&kexec_block_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(kexec_block_notifier_unregister);
> > +
> >   /*
> >    * When kexec transitions to the new kernel there is a one-to-one
> >    * mapping between physical and virtual addresses.  On processors
> > @@ -1124,6 +1138,12 @@ bool kexec_load_permitted(int kexec_image_type)
> >   	return true;
> >   }
> > +static int kexec_check_blockers(void)
> > +{
> > +	/* Notify subsystems of impending kexec */
> > +	return blocking_notifier_call_chain(&kexec_block_list, 0, NULL);
> > +}
> > +
> >   /*
> >    * Move into place and start executing a preloaded standalone
> >    * executable.  If nothing was preloaded return an error.
> > @@ -1139,6 +1159,10 @@ int kernel_kexec(void)
> >   		goto Unlock;
> >   	}
> > +	error = kexec_check_blockers();
> 
> This could take a long time, and I am not sure if it's a good idea
> to stall kexec with such dependencies.
> 

Whether the call takes time should not matter. liveudpate_reboot()
already introduced the same semantics below.

Thanks,
Stanislav

> Thanks,
> -Mukesh
> 
> 
> > +	if (error)
> > +		goto Unlock;
> > +
> >   	error = liveupdate_reboot();
> >   	if (error)
> >   		goto Unlock;
> > 
> > 
> 

