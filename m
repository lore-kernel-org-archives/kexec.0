Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAE1C38A2D
	for <kexec@archiver.kernel.org>; Mon, 24 Oct 2022 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MZqTJbJLdVsLnKlG+tAbwots7htEL10PMFV3ajaCnCQ=; b=yNFTc4ME21PJZo
	lPyAJ/It/apagXuHjVRxweiidNVQV1o/EvNmSgqETrBPe1DY7NzyGVvawZFoaw1nwZhOY9sqqQJFu
	zKdwHa2dAHNdwxRTsWsDbAEOpOazg6Utwqiy2EWBv/A7RjkS3ofQCzwRJWCCp0nUmEefbjkGGNPi0
	opCtzRJyYlpEpDTdCX8t3F1GP68c7EyW/3hyY2pVczLlucNg2pSRFywFTAsS0z35JcBKhJhRx77Vf
	L6kMCUWRAphENsmg5dL/Zz/Q7EVmj9c0jL9BNKNMxwhjvB18Zdm0K1uYTv+FAyJkd12OwIgu5bxR6
	2Ra7V3Ta8lfvu59IcJ3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omtTQ-000Jt4-2r; Mon, 24 Oct 2022 09:10:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omtTN-000Jqh-3H
	for kexec@lists.infradead.org; Mon, 24 Oct 2022 09:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666602614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTEDRcmXXQS08afZGdLf2piCdEuBNuck5VCmgs8GBz4=;
	b=UIacomt3y8pCg/RxsG7xj/o5WuQOIdakVX8EAXfnkhdPKlcFkTbzY9/uIGp2aWm921khPn
	DqHtSUTN+6atUBYUgue1uFrw9pRQRCiNQidnzceWr5963P9UbFZo+2rQ9s/x1yRRgP7KVQ
	BOWJiPayca+/eO5pZRaFVJu0jnUbZN4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-baUEGjhoO-Cqkt_GTX5PwQ-1; Mon, 24 Oct 2022 05:10:06 -0400
X-MC-Unique: baUEGjhoO-Cqkt_GTX5PwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D876D3810D2B;
	Mon, 24 Oct 2022 09:10:05 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A463E39DB3;
	Mon, 24 Oct 2022 09:10:04 +0000 (UTC)
Date: Mon, 24 Oct 2022 17:10:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y1ZWaSeGk53QqZHX@MiWiFi-R3L-srv>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
 <8cc31b22-a061-d07c-77dc-c555b8b35af3@linux.ibm.com>
 <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_021017_252301_B2612325 
X-CRM114-Status: GOOD (  35.93  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Eric, Sourabh,

On 10/07/22 at 02:14pm, Eric DeVolder wrote:
> =

> =

> On 10/3/22 12:51, Sourabh Jain wrote:
> > Hello Eric,
> > =

> > On 10/09/22 02:35, Eric DeVolder wrote:
......
> > > +static void handle_hotplug_event(unsigned int hp_action, unsigned in=
t cpu)
> > > +{
> > > +=A0=A0=A0 /* Obtain lock while changing crash information */
> > > +=A0=A0=A0 mutex_lock(&kexec_mutex);
> > > +
> > > +=A0=A0=A0 /* Check kdump is loaded */
> > > +=A0=A0=A0 if (kexec_crash_image) {
> > > +=A0=A0=A0=A0=A0=A0=A0 struct kimage *image =3D kexec_crash_image;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 if (hp_action =3D=3D KEXEC_CRASH_HP_ADD_CPU ||
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hp_action =3D=3D KEXEC_CRASH_HP_RE=
MOVE_CPU)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("crash hp: hp_action %u, =
cpu %u\n", hp_action, cpu);
> > > +=A0=A0=A0=A0=A0=A0=A0 else
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("crash hp: hp_action %u\n=
", hp_action);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 /*
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 * When the struct kimage is allocated, it i=
s wiped to zero, so
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 * the elfcorehdr_index_valid defaults to fa=
lse. Find the
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 * segment containing the elfcorehdr, if not=
 already found.
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 * This works for both the kexec_load and ke=
xec_file_load paths.
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > +=A0=A0=A0=A0=A0=A0=A0 if (!image->elfcorehdr_index_valid) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned char *ptr;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long mem, memsz;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int n;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (n =3D 0; n < image->nr_segmen=
ts; n++) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mem =3D image->segment=
[n].mem;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memsz =3D image->segme=
nt[n].memsz;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ptr =3D arch_map_crash=
_pages(mem, memsz);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ptr) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* The seg=
ment containing elfcorehdr */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (memcmp=
(ptr, ELFMAG, SELFMAG) =3D=3D 0) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 image->elfcorehdr_index =3D (int)n;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 image->elfcorehdr_index_valid =3D true;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 arch_unmap_crash_pages=
((void **)&ptr);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 if (!image->elfcorehdr_index_valid) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("crash hp: unable to locate=
 elfcorehdr segment");
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
> > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 /* Needed in order for the segments to be upda=
ted */
> > > +=A0=A0=A0=A0=A0=A0=A0 arch_kexec_unprotect_crashkres();
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 /* Flag to differentiate between normal load a=
nd hotplug */
> > > +=A0=A0=A0=A0=A0=A0=A0 image->hotplug_event =3D true;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 /* Now invoke arch-specific update handler */
> > > +=A0=A0=A0=A0=A0=A0=A0 arch_crash_handle_hotplug_event(image, hp_acti=
on);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 /* No longer handling a hotplug event */
> > > +=A0=A0=A0=A0=A0=A0=A0 image->hotplug_event =3D false;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 /* Change back to read-only */
> > > +=A0=A0=A0=A0=A0=A0=A0 arch_kexec_protect_crashkres();
> > > +=A0=A0=A0 }
> > > +
> > > +out:
> > > +=A0=A0=A0 /* Release lock now that update complete */
> > > +=A0=A0=A0 mutex_unlock(&kexec_mutex);
> > > +}
> > > +
> > > +static int crash_memhp_notifier(struct notifier_block *nb, unsigned =
long val, void *v)
> > > +{
> > > +=A0=A0=A0 switch (val) {
> > > +=A0=A0=A0 case MEM_ONLINE:
> > > +=A0=A0=A0=A0=A0=A0=A0 handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY=
, 0);
> > > +=A0=A0=A0=A0=A0=A0=A0 break;
> > > +
> > > +=A0=A0=A0 case MEM_OFFLINE:
> > > +=A0=A0=A0=A0=A0=A0=A0 handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEM=
ORY, 0);
> > > +=A0=A0=A0=A0=A0=A0=A0 break;
> > > +=A0=A0=A0 }
> > > +=A0=A0=A0 return NOTIFY_OK;
> > =

> > Can we pass v (memory_notify) argument to arch_crash_handle_hotplug_eve=
nt function
> > via handle_hotplug_event?
> > =

> > Because the way memory hotplug is handled on PowerPC, it is hard to upd=
ate the elfcorehdr
> > without memory_notify args.
> > =

> > On PowePC memblock data structure is used to prepare elfcorehdr for kdu=
mp. Since the notifier
> > used for memory hotplug crash handler get initiated before the memblock=
 data structure update
> > happens (as depicted below), the newly prepared elfcorehdr still holds =
the old memory regions.
> > So if the system crash with obsolete elfcorehdr, makedumpfile failed to=
 collect vmcore.
> > =

> > Sequence of actions done on PowerPC to server the memory hotplug:
> > =

> >  =A0Initiate memory hot remove
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 |
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 v
> >  =A0offline pages
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 |
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 v
> >  =A0initiate memory notify call chain
> >  =A0for MEM_OFFLINE event.
> >  =A0(same is used for crash update)
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 |
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 v
> >  =A0prepare new elfcorehdr for kdump using
> >  =A0memblock data structure
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 |
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 v
> >  =A0update memblock data structure
> > =

> > How passing memory_notify to arch crash hotplug handler will help?
> > =

> > memory_notify holds the start PFN and page count, with that we can get
> > the base address and size of hot unplugged memory and can use the same
> > to avoid hot unplugged memeory region to get added in the elfcorehdr..
> > =

> > Thanks,
> > Sourabh Jain
> > =

> =

> Sourabh, let's see what Baoquan thinks.
> =

> Baoquan, are you OK with this request? I once had these parameters to the
> crash hotplug handler and since they were unused at the time, you asked
> that I remove them, which I did.

Sorry to miss this mail. I thought both of you were talking about
somthing, and didn't notice this question to me.

I think there are two ways to solve the issue Sourabh raised:
1) make handle_hotplug_event() get and pass down the memory_notify as
Sourabh said, or the hp_action, mem_start|size as Eric suggested. I
have to admit I haven't carefully checked which one is better.

2) let the current code as is since it's aiming at x86 only. Later
Sourabh can modify code according to his need on ppc. This can give
satisfying why on code change each time.

I personally like the 2nd way, while also like seeing 1st one if the
code change and log is convincing to any reviewer.

> =

> To accommodate this, how about this:
> =

> static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>      unsigned long mem_start, unsigned long mem_size)
> =

> For CPU events, I would just pass zeros for mem_start/size. For memory ev=
ents,
> I would pass KEXEC_CRASH_HP_INVALID_CPU.
> =

> Thanks,
> eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
