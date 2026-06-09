Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF21CD8CA4
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPyYTg0OHT/1olm05SvzdJMzrmZ5+gyo8bDaCSODScQ=; b=cUHkOgJ4MKdKORiXDqJB+hI4w6
	28EENGiUbp0fxT7PLKF1T7wfCidiPolO+iZ0oH9NDD//bdoMNpBqduaq5msdWhTvLwrnJNoiOG2As
	HHMUwBR+wXgcFdnQr5juLvTlynucCbrq4GIKkPFsBQLd6e/Z7/YyvYUE8xZOpBkWUV99tbvwXT6Wv
	VVPpP3TJb7CuCg7y00E27QYDqNPMYRLK0wfUMlL5dZ9rsQro0rafaZOinPBRb83jwkhvh0cHVSarA
	f0LFiont3GYUITQySWO+9bgSBWoNFYmzFmEe+Ea9gr978kAFOdOl01ddhgvkzJZGiTEU22WiukFpy
	CUD/haPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwZy-00000005fcX-45KM;
	Tue, 09 Jun 2026 13:33:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwZt-00000005fc7-1cMv
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 13:33:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1E98B407D3;
	Tue,  9 Jun 2026 13:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BD1F00893;
	Tue,  9 Jun 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781011993;
	bh=mPyYTg0OHT/1olm05SvzdJMzrmZ5+gyo8bDaCSODScQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=a4lVSRIYOxSxERDL4P+xqbgfRFotgdtbU08mBzO4YA/mrhUUq73RAlWh3+51j2hEi
	 9bxBRrFzcTRskjy8S7U11Ft2ctVHoKYhFJqs3sPnejuuxO4q+My92/tNd1gqjbgyJM
	 PQNWbsSMeSfv4N/6tpBnTtCT1/3tJczEcJhY1bUiXt5vTtIhKJFbdaBnvUXLjSlmB/
	 zGcRhvKh5I1ljLVk+A2ztHNEy7nKLilijsJ7XNAQLXT2rqYbZR6W36c1ZXSittdHzB
	 R3eEnC9vmAL8v0k1VoSkeTizLhK5O1GqL+rudCiCi1rxVaWj1bBAi/v5DTiDYEZgNi
	 wlrP2Y9LQTAGw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Matlack <dmatlack@google.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>,
  Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 1/2] liveupdate: Reference count outgoing FLB data
In-Reply-To: <aidpNcyBcee0HMCE@plex> (Pasha Tatashin's message of "Tue, 9 Jun
	2026 02:17:17 +0000")
References: <20260528174140.1921129-1-dmatlack@google.com>
	<20260528174140.1921129-2-dmatlack@google.com>
	<2vxzfr34dfty.fsf@kernel.org> <ah8SDsIuZQXyvpZq@google.com>
	<2vxzse6xt8rj.fsf@kernel.org> <aidSKOlkw_XMvVKl@google.com>
	<aidpNcyBcee0HMCE@plex>
Date: Tue, 09 Jun 2026 15:33:10 +0200
Message-ID: <2vxzv7brsusp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jun 09 2026, Pasha Tatashin wrote:

> On 06-08 23:37, David Matlack wrote:
>> On 2026-06-08 04:19 PM, Pratyush Yadav wrote:
>> > On Tue, Jun 02 2026, David Matlack wrote:
>> > 
>> > > On 2026-06-02 07:15 PM, Pratyush Yadav wrote:
>> > >> Hi David,
>> > >> 
>> > >> On Thu, May 28 2026, David Matlack wrote:
>> > >> 
>> > >> > Increment the outgoing FLB refcount in liveupdate_flb_get_outgoing() so
>> > >> > that the FLB structure cannot be freed while the caller is actively
>> > >> > using it. Add an additional liveupdate_flb_put_outgoing() function so
>> > >> > the caller can explicitly indicate when it is done using the outgoing
>> > >> > FLB.
>> > >> >
>> > >> > During a Live Update, the kernel may need to fetch the outgoing FLB
>> > >> > outside of the scope of a file handler's preserve() and unpreserve()
>> > >> > callbacks. In that situation there is no way for the caller to protect
>> > >> > itself against the outgoing FLB from being freed while it is using it.
>> > >> > Incrementing the reference count in liveupdate_flb_get_outgoing()
>> > >> > ensures it cannot be freed.
>> > >> 
>> > >> We grab a reference to the FLB's module when the first file using the
>> > >> FLB is preserved. So the FLB should never go away while preserved files
>> > >> exist. Once all preserved files go away, you normally shouldn't be doing
>> > >> anything with the FLB anyway.
>> > >> 
>> > >> Can you please elaborate on the use case and why this is a problem?
>> > >> Using the FLB outside of the standard LUO file callbacks sounds
>> > >> problematic.
>> > >
>> > > The scenario I had in mind was to remove a PCI device from the outgoing
>> > > FLB if the device is forcibly removed while the file is still preserved,
>> > > for example someone writes 1 to /sys/bus/pci/devices/.../remove or a
>> > > device is physically hot-unplugged.
>> > >
>> > > Specifically this call here from the patch below:
>> > >
>> > > +void pci_liveupdate_cleanup_device(struct pci_dev *dev)
>> > > +{
>> > > +	/*
>> > > +	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
>> > > +	 * since there should no longer be any references to @dev on the system.
>> > > +	 */
>> > > +	if (READ_ONCE(dev->liveupdate.outgoing)) {
>> > > +		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
>> > > +		pci_liveupdate_unpreserve(dev);
>> > > +	}
>> > > +}
>> > >
>> > > https://lore.kernel.org/linux-pci/20260522202410.3104264-3-dmatlack@google.com/
>> > >
>> > > I can do this without adding reference counting to
>> > > liveupdate_flb_get_outgoing(), but the reference counting makes it
>> > > obvious that the outgoing FLB will not be freed while I am using it
>> > > here, and also aligns with liveupdate_flb_get_incoming().
>> > 
>> > The lifecycle of FLB is bound to _preserved_ files. So it is only valid
>
> An FLB is a shared global resource whose lifecycle is bound to the 
> duration of first creation and final destruction across multiple files. 
> It is not associated with any single preserved file, but rather with the 
> fact that files of a particular type(s) are currently being preserved.
>
> Because the kernel is highly asynchronous, we must handle concurrent 
> access and race conditions during teardown and FLB lookups. Reference 
> counting provides a standard, robust, and methodical way to handle this 
> safely.

But that's my point. As you say, destruction is supposed to happen when
the last file using the FLB goes away. That stops being true when any
random caller can hold a reference. So now you can get a FLB with no
files. It fundamentally breaks the model we started with FLBs.

The FLB model also deals with asynchronicity, but it does so by managing
the lifetime of the FLB directly in LUO instead of leaving it to
subsystems. This reduces cognitive load on the users of the FLB API.
They do not need to care about managing the lifecycle themselves.

If users of FLB are directly managing references, then why does LUO even
need to manage anything? Then subsystems can just create their own
global data structure, grab a reference and release it as they please.
That is a perfectly valid way of managing this global object, but we
decided to _not_ do this because letting LUO manage the lifecycle (and
thus the refcount) results in code that is easier to understand and
reason about.

>
>> > as long as preserved files exist. So I think you should only get the FLB
>> > object when you are inside a file preservation callback for a file which
>
> Limiting access to only within a file preservation callback is not 
> feasible. FLBs are global resources and may be queried early during boot 
> or late during teardown, completely outside of a specific file's 
> preservation callback.

To clarify, I don't mean only the preservation callback. I mean during
any of the file handler callbacks.

And if the subsystem needs to do something with the FLB after all its
files are frozen, we can provide a freeze() callback to
liveupdate_flb_ops.

Why do you need to access the FLB anywhere else outside of these
callbacks? What's the use case?

>
>> > the FLB is registered. Anywhere outside of that, you are not guaranteed
>> > to get anything sane.
>> 
>> LUO should enforce this then, IMO.
>> 
>> > This refcounting scheme breaks the inherent "file-lifecycle-bound" part
>> > of FLB, since now anyone can grab a reference and hold the FLB as long
>> > as they like, even when no preserved files exist.
>
> This is the standard design pattern for shared resources in the kernel. 
> When the last file of that type is unpreserved, the FLB's reference 
> count reaches zero, and it is cleanly destroyed.
>
> If there is a bug where someone holds onto a reference indefinitely, 
> that is simply a leak/bug to be fixed. It is not a flaw in the 
> reference-counting pattern itself, which is crucial for preventing 
> use-after-free and race conditions under concurrent access.

Going to my previous point, the whole reason for FLB to exist is that we
don't want to burden subsystems with managing these references. If we do
that, then I think it would be way easier to just get rid of FLBs
entirely. It would be almost as easy for each subsystem to allocate a
global struct with its state and a refcount.

I don't get why we want to mix these approaches. FLB makes my life as a
user of the API easier because I don't need to worry about the
lifetimes. LUO takes care of that for me.

>
>> > For the normal case, your the VFIO driver gets probed, it registers its
>> > file handler, then when the device is preserved by VFIO, the VFIO file
>> > handler's callbacks can get the FLB and do whatever. LUO guarantees the
>> > FLB exists. Anywhere outside of that, you should _not_ touch the FLB
>> > because of the reasons above.
>> > 
>> > Now for hot-unplug, I think that case is not supported right now. When a
>> > preserved file exists, LUO can only remove it when the user closes the
>> > session. Trying to clean up the file from any other context will leave
>> > dangling references to the file and we currently do not handle those.
>> > Trying to hold the file reference won't help much either since LUO
>> > callbacks will try to proceed as normal, and normal no longer applies.
>> > 
>> > For example, say userspace preserved the file for your device in their
>> > session, then you hot-unplug the device, then userspace triggers a
>> > kexec. What is the freeze() callback supposed to do? Sure, the FLB
>> > object still exists, but the device doesn't. Similarly, if you force
>> > remove the module, the freeze() callback itself no longer exists, and
>> > you likely get a panic.
>> > 
>> > We might at some point support "invalidating" preserved files. I imagine
>> > when you hot-unplug with a preserved device, you tell LUO to invalidate
>> > all preserved files with that device. They would still exist in their
>> > sessions, but all operations on them fail immediately, including
>> > freeze(), which prevents live update from proceeding until user cleans
>> > them up.
>> > 
>> > So unless I am missing something, I think this refcounting is a band-aid
>> > and the real problem is to properly track these "invalidated" files.
>> > 
>> > Also, I think the refcounting on the incoming path is also a mistake.
>
> On incoming path FLBs may be accessed during early boot and later 
> including once we enter userspace. We must have a way to ensure valid, 
> race-free access to these shared resources. Without reference counting, 
> querying the existence of an FLB or retrieving it would require 
> introducing global locking, which is highly undesirable.

Ideally, on the incoming path LUO should provide a subsystem init hook
that lets them get their FLB data and use it during init. Unfortunately
it isn't easy because of boot ordering. You might need the FLB before
LUO comes up.

But I think we should still tighten up access to the FLB on the incoming
side as well. You can use the FLB early until it gets registered (or
something similar) with LUO. Then you hand over the ownership to LUO and
can only use it from the standard LUO callbacks. At this point the
access model of incoming and outgoing become the same.

Overall, my point is that we should pick one usage model. Either LUO
manages the lifetime of the object or the subsystem. Mixing both this
way sounds wrong.

>
> Also, having both the incoming and outgoing FLB paths behave 
> symmetrically using the same reference-counting API makes the overall 
> design uniform, clean, and less error-prone.
>
>> > Unfortunately for incoming, there is a need for accessing the FLB
>> > outside of the file handling callbacks, since subsystems needs to use it
>> > to initialize itself. But I suppose we can have a accessor that
>> > subsystems can call once on boot/init to get their object. Then they use
>> > it to initialize their state and refer to the state directly, with all
>> > later calls going through the usual file handler callbacks.
>> > 
>> > If you are interested in solving this problem, we can have a chat to
>> > talk in more detail, or perhaps have a discussion at one of the
>> > bi-weeklies?
>> 
>> Thanks for the detailed reply but I think it's hard to discuss all these
>> as theoretical situations since we can get bogged down in the parts that
>> aren't clear yet and potential future use-cases.
>> 
>> Can you review the use of the outgoing and incoming FLB in the PCI core
>> series and let me know what you think I am doing wrong?
>> 
>>   https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/

Yes, good idea. Will do.

-- 
Regards,
Pratyush Yadav

