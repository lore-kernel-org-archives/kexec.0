Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D70FCD6E79
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 02:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ylQEHysqMMp7KAoiMGAoFNU9p9TG2t3Mi/C9RjUsIj0=; b=Th2alxntoqS06ABDAA7NiUwoKF
	aE/u73bHnbSIYM6xJTtFY3CQozSssrJqEVyR7dtIazYL0mdDD+oHHRu7fSngjF1cCB+NcKCuntf6S
	BYb62hHoSF/uT1LINNKPW50Xxd15uBxbrdc7ta/vVVKOBCUSN9T88nJIPxnwwjxijH3K59k/Bs8t8
	CbCtRH0Ur1DyagqVsvpLBUxi4NO8uoO/mTuvJcGT+NTpJqits38dpQGDYqEYpyPIGYX94giqhnLWb
	pE4BcW3swJ72xnoXsXlj///Fhi/eTR/2H78kxmbgX5j8ftmhqIKXLOUDGO4XA0Z4WgQIzTkpGrQH7
	6jNRV5zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWm1r-00000004clp-1zSw;
	Tue, 09 Jun 2026 02:17:23 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWm1o-00000004clB-1sRg
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 02:17:21 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-915b5ce94c7so357018185a.2
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 19:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780971439; x=1781576239; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylQEHysqMMp7KAoiMGAoFNU9p9TG2t3Mi/C9RjUsIj0=;
        b=YfNA862XRxdypNVkcr1+oeuOsee+PEQoc6Zf8S/2Hk+GaX9uyFo39wH70op5rcsLU/
         8GVmOLYJTVuFqaN84SK/dOFmvySL03QxqX9n+DrX/6PSsEFu7Us2X2wIk7UxzjMsTfIO
         SfPOTTRNzppPQ8sD+9YfjLZpIjBj6nzT/7zFiCD9DebR54QRjNxp6lstTf+jdeBPPSEG
         ZNFq152LYiUMj5oBPc1PZqMboGgZSHnwTgO2YUX8YKyNmtON3oSeIDNMvybN0FoRhBc2
         mdlRa62f63jp/28WmOmTN25tnZsbecYcikFIHkIg1wFebN0Fyxp3cgffFBukoYPS4KtD
         YCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780971439; x=1781576239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylQEHysqMMp7KAoiMGAoFNU9p9TG2t3Mi/C9RjUsIj0=;
        b=gVihMTs0Pat4bKZhUNTZNseyB351yiovebJ0l1Gazo6y8jfX+3PxRW7e5/klqVBXsW
         3Tm4WWtbmM7094m6gtWoDcQKJf6DwP96kXrlYBmr0zjwZAEG9ipUJHA/ZNHGllTlqaml
         pWkJu++bjSU8BfvSxO8SEnqvry6EzRvvTdHpHmIFI159tLED+eHjq55wXgUMTVZ6286T
         iQIpsx+MKUM/NJRDJWC5498hVLL3xNMlg6QvhfP9JGe+A5jJVzSggZ+/A9O5NcXAwA4C
         Y79QcdgxVn0Tgf9YzBj3vXBKFeyA7VXmYGzRwhaq9JEXVHTsd6qTJpUehK1Sjj2aedG+
         DyNA==
X-Forwarded-Encrypted: i=1; AFNElJ/UXbB2t7TLDEfjXngWXDfs4kTJXcRQZaCxtvVDDQ1hxudTo1Mzwqt1lfNxJdFfVo2fTbyQ4g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyk5I7guUAtIpKEcl7prIW2BKYPULt4trBc9OLmdfcHxe33EfZH
	x6iiupSgbRConF/PkFH1Z6AYJ4/aL3zN0QrmDlTSwjkxjBOPoHLqJWLHAWiYbjkhzdQEs5ZkTYh
	uFkta
X-Gm-Gg: Acq92OFq8V7kg5u29XFUGxl9BWrOHEoaUH4MzVKQsa/Nxa+3cuAZqCS0V5RTbwgPS1t
	x886MJ3tL010gGIy/1ZjWqsFFQTbDAJPYIH/j5/qJezm2Y9ymnrzs55H5dRoGIMAmuPFfCGKckZ
	6AKk55uTM3dK8sR9bqdM6Iu3euF81Zzr3MicdCJsuNiz50Z/0LvL/A0e5L3MTyu5pK+Pgp7TE+N
	M1OFJvWHdvNprAmZ+p4XL5avN3qoxZEOJMy6W7rbVeeC8I8rx/uzUBa6VWThv8oaiYPAR1/NUUq
	AfUG/2jRZVOZMkSSgbZV613YJfshjV9BfrjYcN3XBMZHJOAqoCP9lZ3hvf2a8fOgHWDhTYNHIkA
	yyOnmQrePJLXxLFYiuLD2k9X+jDPtpjy66pRnX6Txvcr5t/9oH5oRZrizrfSE+YdU4wkTgpRAIA
	OWF6U/BRhNZ6WFC9sdmYebdNJtmkMZ+6E3xZw9d1YyBFO9h+Nc/u6NXbCStSAmA6y7i1uqu5Ri
X-Received: by 2002:a05:620a:1983:b0:914:bf8a:ba81 with SMTP id af79cd13be357-915a9cf8543mr2830607485a.27.1780971438749;
        Mon, 08 Jun 2026 19:17:18 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c50bsm1974387085a.24.2026.06.08.19.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:17:18 -0700 (PDT)
Date: Tue, 9 Jun 2026 02:17:17 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 1/2] liveupdate: Reference count outgoing FLB data
Message-ID: <aidpNcyBcee0HMCE@plex>
References: <20260528174140.1921129-1-dmatlack@google.com>
 <20260528174140.1921129-2-dmatlack@google.com>
 <2vxzfr34dfty.fsf@kernel.org>
 <ah8SDsIuZQXyvpZq@google.com>
 <2vxzse6xt8rj.fsf@kernel.org>
 <aidSKOlkw_XMvVKl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aidSKOlkw_XMvVKl@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_191720_524722_47454034 
X-CRM114-Status: GOOD (  63.05  )
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

On 06-08 23:37, David Matlack wrote:
> On 2026-06-08 04:19 PM, Pratyush Yadav wrote:
> > On Tue, Jun 02 2026, David Matlack wrote:
> > 
> > > On 2026-06-02 07:15 PM, Pratyush Yadav wrote:
> > >> Hi David,
> > >> 
> > >> On Thu, May 28 2026, David Matlack wrote:
> > >> 
> > >> > Increment the outgoing FLB refcount in liveupdate_flb_get_outgoing() so
> > >> > that the FLB structure cannot be freed while the caller is actively
> > >> > using it. Add an additional liveupdate_flb_put_outgoing() function so
> > >> > the caller can explicitly indicate when it is done using the outgoing
> > >> > FLB.
> > >> >
> > >> > During a Live Update, the kernel may need to fetch the outgoing FLB
> > >> > outside of the scope of a file handler's preserve() and unpreserve()
> > >> > callbacks. In that situation there is no way for the caller to protect
> > >> > itself against the outgoing FLB from being freed while it is using it.
> > >> > Incrementing the reference count in liveupdate_flb_get_outgoing()
> > >> > ensures it cannot be freed.
> > >> 
> > >> We grab a reference to the FLB's module when the first file using the
> > >> FLB is preserved. So the FLB should never go away while preserved files
> > >> exist. Once all preserved files go away, you normally shouldn't be doing
> > >> anything with the FLB anyway.
> > >> 
> > >> Can you please elaborate on the use case and why this is a problem?
> > >> Using the FLB outside of the standard LUO file callbacks sounds
> > >> problematic.
> > >
> > > The scenario I had in mind was to remove a PCI device from the outgoing
> > > FLB if the device is forcibly removed while the file is still preserved,
> > > for example someone writes 1 to /sys/bus/pci/devices/.../remove or a
> > > device is physically hot-unplugged.
> > >
> > > Specifically this call here from the patch below:
> > >
> > > +void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> > > +{
> > > +	/*
> > > +	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
> > > +	 * since there should no longer be any references to @dev on the system.
> > > +	 */
> > > +	if (READ_ONCE(dev->liveupdate.outgoing)) {
> > > +		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
> > > +		pci_liveupdate_unpreserve(dev);
> > > +	}
> > > +}
> > >
> > > https://lore.kernel.org/linux-pci/20260522202410.3104264-3-dmatlack@google.com/
> > >
> > > I can do this without adding reference counting to
> > > liveupdate_flb_get_outgoing(), but the reference counting makes it
> > > obvious that the outgoing FLB will not be freed while I am using it
> > > here, and also aligns with liveupdate_flb_get_incoming().
> > 
> > The lifecycle of FLB is bound to _preserved_ files. So it is only valid

An FLB is a shared global resource whose lifecycle is bound to the 
duration of first creation and final destruction across multiple files. 
It is not associated with any single preserved file, but rather with the 
fact that files of a particular type(s) are currently being preserved.

Because the kernel is highly asynchronous, we must handle concurrent 
access and race conditions during teardown and FLB lookups. Reference 
counting provides a standard, robust, and methodical way to handle this 
safely.

> > as long as preserved files exist. So I think you should only get the FLB
> > object when you are inside a file preservation callback for a file which

Limiting access to only within a file preservation callback is not 
feasible. FLBs are global resources and may be queried early during boot 
or late during teardown, completely outside of a specific file's 
preservation callback.

> > the FLB is registered. Anywhere outside of that, you are not guaranteed
> > to get anything sane.
> 
> LUO should enforce this then, IMO.
> 
> > This refcounting scheme breaks the inherent "file-lifecycle-bound" part
> > of FLB, since now anyone can grab a reference and hold the FLB as long
> > as they like, even when no preserved files exist.

This is the standard design pattern for shared resources in the kernel. 
When the last file of that type is unpreserved, the FLB's reference 
count reaches zero, and it is cleanly destroyed.

If there is a bug where someone holds onto a reference indefinitely, 
that is simply a leak/bug to be fixed. It is not a flaw in the 
reference-counting pattern itself, which is crucial for preventing 
use-after-free and race conditions under concurrent access.

> > For the normal case, your the VFIO driver gets probed, it registers its
> > file handler, then when the device is preserved by VFIO, the VFIO file
> > handler's callbacks can get the FLB and do whatever. LUO guarantees the
> > FLB exists. Anywhere outside of that, you should _not_ touch the FLB
> > because of the reasons above.
> > 
> > Now for hot-unplug, I think that case is not supported right now. When a
> > preserved file exists, LUO can only remove it when the user closes the
> > session. Trying to clean up the file from any other context will leave
> > dangling references to the file and we currently do not handle those.
> > Trying to hold the file reference won't help much either since LUO
> > callbacks will try to proceed as normal, and normal no longer applies.
> > 
> > For example, say userspace preserved the file for your device in their
> > session, then you hot-unplug the device, then userspace triggers a
> > kexec. What is the freeze() callback supposed to do? Sure, the FLB
> > object still exists, but the device doesn't. Similarly, if you force
> > remove the module, the freeze() callback itself no longer exists, and
> > you likely get a panic.
> > 
> > We might at some point support "invalidating" preserved files. I imagine
> > when you hot-unplug with a preserved device, you tell LUO to invalidate
> > all preserved files with that device. They would still exist in their
> > sessions, but all operations on them fail immediately, including
> > freeze(), which prevents live update from proceeding until user cleans
> > them up.
> > 
> > So unless I am missing something, I think this refcounting is a band-aid
> > and the real problem is to properly track these "invalidated" files.
> > 
> > Also, I think the refcounting on the incoming path is also a mistake.

On incoming path FLBs may be accessed during early boot and later 
including once we enter userspace. We must have a way to ensure valid, 
race-free access to these shared resources. Without reference counting, 
querying the existence of an FLB or retrieving it would require 
introducing global locking, which is highly undesirable.

Also, having both the incoming and outgoing FLB paths behave 
symmetrically using the same reference-counting API makes the overall 
design uniform, clean, and less error-prone.

> > Unfortunately for incoming, there is a need for accessing the FLB
> > outside of the file handling callbacks, since subsystems needs to use it
> > to initialize itself. But I suppose we can have a accessor that
> > subsystems can call once on boot/init to get their object. Then they use
> > it to initialize their state and refer to the state directly, with all
> > later calls going through the usual file handler callbacks.
> > 
> > If you are interested in solving this problem, we can have a chat to
> > talk in more detail, or perhaps have a discussion at one of the
> > bi-weeklies?
> 
> Thanks for the detailed reply but I think it's hard to discuss all these
> as theoretical situations since we can get bogged down in the parts that
> aren't clear yet and potential future use-cases.
> 
> Can you review the use of the outgoing and incoming FLB in the PCI core
> series and let me know what you think I am doing wrong?
> 
>   https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/
> 
> > 
> > >
> > >> >
> > >> > This change also aligns the outgoing FLB lifecycle management with the
> > >> > incoming FLB, since the latter uses the same get/put semantics.
> > >> >
> > >> > Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
> > >> > Assisted-by: Gemini:gemini-3-pro-preview
> > >> > Signed-off-by: David Matlack <dmatlack@google.com>
> > >> [...]
> > >> 
> > >> -- 
> > >> Regards,
> > >> Pratyush Yadav
> > 
> > -- 
> > Regards,
> > Pratyush Yadav

