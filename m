Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71088E7E62D
	for <kexec@archiver.kernel.org>; Tue, 26 Sep 2023 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J0piL8ujfYI2nTjBHF+Ps/vt0inkTxu7E2gJwRch/pc=; b=dcsOQU1A79kmqi
	kUMPztcYWSgin8kfy9hm1FZewOeLg0q+ci7bwHxNwmpQD1eBL6d0SJLc6ZzF2JtubdAcu0It5FQaf
	bI4VIBZ6LNwfZIwPpSIOKW5qhSXjcbNq+ZeROn0FXrTiY5vzzOuCHBRpLlr/3s9slKGA4tAnvLzfu
	/jugEtivo1WluTboOy5uyZ1e64NR2cJHbvi9emd18hsuC1z6aixACF6Drln91BeMxdUprwJ6t8W7x
	x44a1oiZXzK401DXF4MLTtcGviWhhSdyb/2Rp44IQF4Cf1pg9uFKyJMjsGlnfXYK9eb6qxvkROmKD
	hT9svaBGBTbPfVf3CpHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ql6nT-00GK70-14;
	Tue, 26 Sep 2023 12:04:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ql6nQ-00GK6T-1m
	for kexec@lists.infradead.org;
	Tue, 26 Sep 2023 12:04:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695729845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pdY0WCFjlWQnzuU/n992RL0sOmwnkSxRL4q+fOL9AbA=;
	b=NtybWifQ6/lI99MGCnDuNuh43cz19aGqiC7KQ2PbgWvYy8/zwBLPJoxxP0alh831Iea7ec
	/e1vEN1mBN1bzPMYs7EVugUPI17KC85GJvSUoEGtqEFSOll8oYIx5eSloCXay3XyxoO84+
	182UnCBla0yRl0lvzcVFaGpeW2H8waU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573--n3YlA7WONiEYiCMZTpFbw-1; Tue, 26 Sep 2023 08:04:02 -0400
X-MC-Unique: -n3YlA7WONiEYiCMZTpFbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F696380115A;
	Tue, 26 Sep 2023 12:04:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2438E1005B96;
	Tue, 26 Sep 2023 12:03:58 +0000 (UTC)
Date: Tue, 26 Sep 2023 20:03:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	akpm@linux-foundation.org, vschneid@redhat.com, dyoung@redhat.com,
	sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2] Crash: add lock to serialize crash hotplug handling
Message-ID: <ZRLIqztHflB38zYV@MiWiFi-R3L-srv>
References: <20230925030701.338672-1-bhe@redhat.com>
 <d6bd8083-94e5-9bb3-7b1e-5bf6cc954baa@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6bd8083-94e5-9bb3-7b1e-5bf6cc954baa@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_050408_681498_3046B390 
X-CRM114-Status: GOOD (  28.65  )
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

On 09/25/23 at 09:59am, Eric DeVolder wrote:
> 
> 
> On 9/24/23 22:07, Baoquan He wrote:
> > Eric reported that handling corresponding crash hotplug event can be
> > failed easily when many memory hotplug event are notified in a short
> > period. They failed because failing to take __kexec_lock.
> > 
> > =======
> > [   78.714569] Fallback order for Node 0: 0
> > [   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
> > [   78.717133] Policy zone: Normal
> > [   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > [   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > [   80.056643] PEFILE: Unsigned PE binary
> > =======
> > 
> > The memory hotplug events are notified very quickly and very many,
> > while the handling of crash hotplug is much slower relatively. So the
> > atomic variable __kexec_lock and kexec_trylock() can't guarantee the
> > serialization of crash hotplug handling.
> > 
> > Here, add a new mutex lock __crash_hotplug_lock to serialize crash
> > hotplug handling specifically. This doesn't impact the usage of
> > __kexec_lock.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v1->v2:
> >   - Move mutex lock definition into CONFIG_CRASH_HOTPLUG ifdeffery
> >     scope in kernel/crash_core.c because the lock is only needed and
> >     used in that scope. Suggested by Eric.
> > 
> >   kernel/crash_core.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 03a7932cde0a..5951d6366b72 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -739,6 +739,17 @@ subsys_initcall(crash_notes_memory_init);
> >   #undef pr_fmt
> >   #define pr_fmt(fmt) "crash hp: " fmt
> > +/*
> > + * Different than kexec/kdump loading/unloading/jumping/shrinking which
> > + * usually rarely happen, there will be many crash hotplug events notified
> > + * during one short period, e.g one memory board is hot added and memory
> > + * regions are online. So mutex lock  __crash_hotplug_lock is used to
> > + * serialize the crash hotplug handling specifically.
> > + */
> > +DEFINE_MUTEX(__crash_hotplug_lock);
> > +#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
> > +#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
> > +
> >   /*
> >    * This routine utilized when the crash_hotplug sysfs node is read.
> >    * It reflects the kernel's ability/permission to update the crash
> > @@ -783,9 +794,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> >   {
> >   	struct kimage *image;
> > +	crash_hotplug_lock();
> >   	/* Obtain lock while changing crash information */
> >   	if (!kexec_trylock()) {
> >   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > +		crash_hotplug_unlock();
> >   		return;
> >   	}
> > @@ -852,6 +865,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> >   out:
> >   	/* Release lock now that update complete */
> >   	kexec_unlock();
> > +	crash_hotplug_unlock();
> >   }
> >   static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> 
> The crash_check_update_elfcorehdr() also has kexec_trylock() and needs similar treatment.
> Userspace (ie udev rule processing) and kernel (crash hotplug infrastrucutre) need to be
> protected/serialized from one another.

You are right. I didn't consider the kexec_load interface. There's a
tiny racing window which we still need to avoid. V3 will be posted.
Thanks. 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
