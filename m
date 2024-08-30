Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC58CA0FE0
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2G2fZBDOeABWmjyp9u7LS8L+GDauf64BCxxcv1EDvps=; b=nSHdKjAoZMgWUE
	aCLtcg6wnnVhvC1VWjjSpShucnxNPeOrhMfLeG7/boyCbZk21iiSmvGVymMWNDuBzZtEeNkOH+wOV
	LvNEilEOWlhKVeH/W+cK5Do689ar+497RUssDKkDfdXXpZFvSACU/MQrwT9PlgmFuMryTO0wjqmC5
	AEcwA3Oj2o/ZjCp48kzfX0HUznu8Igas5YktTsr0s0glPWn3GndbgXHYJprPzaJfRRFS/EkigQ0gU
	VJbF4muz0ekOjSym/s7hCtwp+ijyX/ATipPCLM5lOwQIbaTIb+sb7Jn7BXozER+e2KWDDzBxP411o
	fjX629+DIB2nih+wTh4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjzdW-000000061De-0fzK;
	Fri, 30 Aug 2024 11:17:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjzdT-000000061Cp-3rMR
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 11:17:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725016666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUb4QrzT7qCuzKr20VTbfQnlpedFsYgESJIJB+0lq8k=;
	b=Gu1CvDudrpuOD4H9ERxvJW7SXvNko9hsbpb69lb640U7pEN0Z4QXMPAfuVzNDh8L8327Ri
	wUQkHRgYlpJKlWhk3atiKNJ64Cn0fFI3PvLccQaRsuAwsY3z+/DQdgvuIuAkzvZWfPZ3DY
	hH2+4GazqjwEbksYwn/h3X/DHMSR9BM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-Y6QDg5daOvCkiKXeP_nKMg-1; Fri,
 30 Aug 2024 07:17:41 -0400
X-MC-Unique: Y6QDg5daOvCkiKXeP_nKMg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44DF11955BF2;
	Fri, 30 Aug 2024 11:17:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87A6019560AA;
	Fri, 30 Aug 2024 11:17:36 +0000 (UTC)
Date: Fri, 30 Aug 2024 19:17:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_041748_070274_377A0758 
X-CRM114-Status: GOOD (  43.73  )
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

On 08/20/24 at 12:10pm, Sourabh Jain wrote:
> Hello Baoquan,
> =

> On 19/08/24 11:45, Baoquan He wrote:
> > On 08/19/24 at 09:45am, Sourabh Jain wrote:
> > > Hello Michael and Boaquan
> > > =

> > > On 01/08/24 12:21, Sourabh Jain wrote:
> > > > Hello Michael,
> > > > =

> > > > On 01/08/24 08:04, Michael Ellerman wrote:
> > > > > Sourabh Jain <sourabhjain@linux.ibm.com> writes:
> > > > > > The following errors are observed when kexec is done with SMT=
=3Doff on
> > > > > > powerpc.
> > > > > > =

> > > > > > [=A0 358.458385] Removing IBM Power 842 compression device
> > > > > > [=A0 374.795734] kexec_core: Starting new kernel
> > > > > > [=A0 374.795748] kexec: Waking offline cpu 1.
> > > > > > [=A0 374.875695] crash hp: kexec_trylock() failed, elfcorehdr m=
ay
> > > > > > be inaccurate
> > > > > > [=A0 374.935833] kexec: Waking offline cpu 2.
> > > > > > [=A0 375.015664] crash hp: kexec_trylock() failed, elfcorehdr m=
ay
> > > > > > be inaccurate
> > > > > > snip..
> > > > > > [=A0 375.515823] kexec: Waking offline cpu 6.
> > > > > > [=A0 375.635667] crash hp: kexec_trylock() failed, elfcorehdr m=
ay
> > > > > > be inaccurate
> > > > > > [=A0 375.695836] kexec: Waking offline cpu 7.
> > > > > Are they actually errors though? Do they block the actual kexec f=
rom
> > > > > happening? Or are they just warnings in dmesg?
> > > > The kexec kernel boots fine.
> > > > =

> > > > This warning appears regardless of whether the kdump kernel is load=
ed.
> > > > =

> > > > However, when the kdump kernel is loaded, we will not be able to up=
date
> > > > the kdump image (FDT).
> > > > I think this should be fine given that kexec is in progress.
> > > > =

> > > > Please let me know your opinion.
> > > > =

> > > > > Because the fix looks like it could be racy.
> > > > It seems like it is racy, but given that kexec takes the lock first=
 and
> > > > then
> > > > brings the CPU up, which triggers the kdump image, which always fai=
ls to
> > > > update the kdump image because it could not take the same lock.
> > > > =

> > > > Note: the kexec lock is not released unless kexec boot fails.
> > > Any comments or suggestions on this fix?
> > Is this a little better?
> > =

> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 63cf89393c6e..0355ffb712f4 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
> >   	crash_hotplug_lock();
> >   	/* Obtain lock while reading crash information */
> > -	if (!kexec_trylock()) {
> > +	if (!kexec_trylock() && kexec_in_progress) {
> >   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> >   		crash_hotplug_unlock();
> >   		return 0;
> > @@ -539,7 +539,7 @@ static void crash_handle_hotplug_event(unsigned int=
 hp_action, unsigned int cpu,
> >   	crash_hotplug_lock();
> >   	/* Obtain lock while changing crash information */
> > -	if (!kexec_trylock()) {
> > +	if (!kexec_trylock() && kexec_in_progress) {
> >   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> >   		crash_hotplug_unlock();
> >   		return;
> =

> Ideally, when `kexec_in_progress` is True, there should be no way to acqu=
ire
> the kexec lock.
> Therefore, calling `kexec_trylock()` before checking `kexec_in_progress` =
is
> not helpful.
> The kernel will print the error message "kexec_trylock() failed, elfcoreh=
dr
> may be inaccurate."
> So, with the above changes, the original problem remains unsolved.
> =

> However, after closely inspecting the `kernel/kexec_core.c:kernel_kexec()`
> function, I discovered
> an exceptional case where my patch needs an update. The issue arises when
> the system returns
> from the `machine_kexec()` function, which indicates that kexec has faile=
d.
> =

> In this scenario, the kexec lock is released, but `kexec_in_progress`
> remains True.
> =

> I am unsure why `kexec_in_progress` is NOT set to False when kexec fails.
> Was this by design,
> or was it an oversight because returning from the `machine_kexec()` funct=
ion
> is highly unlikely?
> =

> Here is my proposal to address the original problem along with the
> exceptional case I described
> above.
> =

> Let's implement two patches:
> =

> 1. A patch that sets `kexec_in_progress` to False if the system returns f=
rom
> `machine_kexec()` before

I don't think we have chance to return from machine_kexec() after
triggering kexec/kdump jumping. The KEXEC_JUMP could return, but I'v
never heard people using it.

> =A0=A0 unlocking the kexec lock in the `kernel_kexec()` function.
> =

> =A0=A0 ```
> =A0=A0 diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> =A0=A0 index c0caa14880c3..b41277183455 100644
> =A0=A0 --- a/kernel/kexec_core.c
> =A0=A0 +++ b/kernel/kexec_core.c
> =A0=A0 @@ -1069,6 +1069,7 @@ int kernel_kexec(void)
> =A0=A0 #endif
> =

> =A0=A0=A0 Unlock:
> =A0=A0 +=A0=A0=A0=A0=A0 kexec_in_progress =3D false;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kexec_unlock();
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return error;
> =A0=A0=A0 ```
> =

> 2. A patch to return early from the `crash_handle_hotplug_event()` functi=
on
> if `kexec_in_progress` is
> =A0=A0 set to True. This is essentially my original patch.

There's a race gap between the kexec_in_progress checking and the
setting it to true which Michael has mentioned. That's why I think
maybe checking kexec_in_progress after failing to retriving
__kexec_lock is a little better, not very sure.

> =

> Please share your comments on the new approach.
> =

> Thank you for review.
> =

> - Sourabh Jain
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
