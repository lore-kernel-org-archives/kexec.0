Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B686CD8C9D
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gtvAtyIWkgcGh5bt/21vAHxAw/x3unUhXw573vaCzPc=; b=O+8WAHZAPzIMEMlHzjyfoHfY2o
	LMc2UuqOQlPELQboQrEqKjAmWNkOjNbFwhHb3MfU0MJW5UGIgie98A2azjMtJKpoZun1yx6Zhk7fu
	Qm+9iDP4b1WQDxknbWqyGeCYDJv4EDT2PJnyTcHIcnTXnBE4rapyUAQOIanyWkDwtijOWnT8d7sj+
	quZ4EfenRC/MdYeZ7Qm0hE0SfQl9rXa/b4KqtEkct5lZQx4u28AeYBCUSv3AlQlh0bCxodnjhsjbN
	W4cjMuDrnOan4Ql7VAgxxZvUR6l79Aaz/UTpcojiG8hPKNtGQqcSi2qvKluNKNLNhfsE0oGcpTdva
	iNa56u6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWaou-00000003it6-3205;
	Mon, 08 Jun 2026 14:19:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWaot-00000003isy-1b1Z
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 14:19:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A3A5840B69;
	Mon,  8 Jun 2026 14:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592671F00893;
	Mon,  8 Jun 2026 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928354;
	bh=gtvAtyIWkgcGh5bt/21vAHxAw/x3unUhXw573vaCzPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OLD1qgx1Q2ALx/ykbqbh/knGOvOBQnjApDdNeZJB8b/ezkWqap+NYtRL28TkoF4Gb
	 1rzfXZl7/bSff2jC9w5cHHfSythG4ByZ1aaIv5EBpq9w9g5qpsuL5/hIKF1mRO7L11
	 lgaSK3xDhJJ4+Y3EtjOsO0RZGVSMzd61OBjSVlZCT8WVg5fKHqF9n0+gfgti40KCsV
	 3R1zbLvvsJp5W6VQ60PfUnoMWGjgsCtB4gqk+Se2bL7BjB1LjECmWZH3K7wLr5oQfm
	 w+7j6qBuiIWmNa599w6HPx7wVtYEE+sBgaobJ+bzASqAecdaY9yul/2LxhSh4xhnRy
	 78L+TzX8YNGEw==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>,
  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 1/2] liveupdate: Reference count outgoing FLB data
In-Reply-To: <ah8SDsIuZQXyvpZq@google.com> (David Matlack's message of "Tue, 2
	Jun 2026 17:25:34 +0000")
References: <20260528174140.1921129-1-dmatlack@google.com>
	<20260528174140.1921129-2-dmatlack@google.com>
	<2vxzfr34dfty.fsf@kernel.org> <ah8SDsIuZQXyvpZq@google.com>
Date: Mon, 08 Jun 2026 16:19:12 +0200
Message-ID: <2vxzse6xt8rj.fsf@kernel.org>
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

On Tue, Jun 02 2026, David Matlack wrote:

> On 2026-06-02 07:15 PM, Pratyush Yadav wrote:
>> Hi David,
>> 
>> On Thu, May 28 2026, David Matlack wrote:
>> 
>> > Increment the outgoing FLB refcount in liveupdate_flb_get_outgoing() so
>> > that the FLB structure cannot be freed while the caller is actively
>> > using it. Add an additional liveupdate_flb_put_outgoing() function so
>> > the caller can explicitly indicate when it is done using the outgoing
>> > FLB.
>> >
>> > During a Live Update, the kernel may need to fetch the outgoing FLB
>> > outside of the scope of a file handler's preserve() and unpreserve()
>> > callbacks. In that situation there is no way for the caller to protect
>> > itself against the outgoing FLB from being freed while it is using it.
>> > Incrementing the reference count in liveupdate_flb_get_outgoing()
>> > ensures it cannot be freed.
>> 
>> We grab a reference to the FLB's module when the first file using the
>> FLB is preserved. So the FLB should never go away while preserved files
>> exist. Once all preserved files go away, you normally shouldn't be doing
>> anything with the FLB anyway.
>> 
>> Can you please elaborate on the use case and why this is a problem?
>> Using the FLB outside of the standard LUO file callbacks sounds
>> problematic.
>
> The scenario I had in mind was to remove a PCI device from the outgoing
> FLB if the device is forcibly removed while the file is still preserved,
> for example someone writes 1 to /sys/bus/pci/devices/.../remove or a
> device is physically hot-unplugged.
>
> Specifically this call here from the patch below:
>
> +void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> +{
> +	/*
> +	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
> +	 * since there should no longer be any references to @dev on the system.
> +	 */
> +	if (READ_ONCE(dev->liveupdate.outgoing)) {
> +		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
> +		pci_liveupdate_unpreserve(dev);
> +	}
> +}
>
> https://lore.kernel.org/linux-pci/20260522202410.3104264-3-dmatlack@google.com/
>
> I can do this without adding reference counting to
> liveupdate_flb_get_outgoing(), but the reference counting makes it
> obvious that the outgoing FLB will not be freed while I am using it
> here, and also aligns with liveupdate_flb_get_incoming().

The lifecycle of FLB is bound to _preserved_ files. So it is only valid
as long as preserved files exist. So I think you should only get the FLB
object when you are inside a file preservation callback for a file which
the FLB is registered. Anywhere outside of that, you are not guaranteed
to get anything sane.

This refcounting scheme breaks the inherent "file-lifecycle-bound" part
of FLB, since now anyone can grab a reference and hold the FLB as long
as they like, even when no preserved files exist.

For the normal case, your the VFIO driver gets probed, it registers its
file handler, then when the device is preserved by VFIO, the VFIO file
handler's callbacks can get the FLB and do whatever. LUO guarantees the
FLB exists. Anywhere outside of that, you should _not_ touch the FLB
because of the reasons above.

Now for hot-unplug, I think that case is not supported right now. When a
preserved file exists, LUO can only remove it when the user closes the
session. Trying to clean up the file from any other context will leave
dangling references to the file and we currently do not handle those.
Trying to hold the file reference won't help much either since LUO
callbacks will try to proceed as normal, and normal no longer applies.

For example, say userspace preserved the file for your device in their
session, then you hot-unplug the device, then userspace triggers a
kexec. What is the freeze() callback supposed to do? Sure, the FLB
object still exists, but the device doesn't. Similarly, if you force
remove the module, the freeze() callback itself no longer exists, and
you likely get a panic.

We might at some point support "invalidating" preserved files. I imagine
when you hot-unplug with a preserved device, you tell LUO to invalidate
all preserved files with that device. They would still exist in their
sessions, but all operations on them fail immediately, including
freeze(), which prevents live update from proceeding until user cleans
them up.

So unless I am missing something, I think this refcounting is a band-aid
and the real problem is to properly track these "invalidated" files.

Also, I think the refcounting on the incoming path is also a mistake.
Unfortunately for incoming, there is a need for accessing the FLB
outside of the file handling callbacks, since subsystems needs to use it
to initialize itself. But I suppose we can have a accessor that
subsystems can call once on boot/init to get their object. Then they use
it to initialize their state and refer to the state directly, with all
later calls going through the usual file handler callbacks.

If you are interested in solving this problem, we can have a chat to
talk in more detail, or perhaps have a discussion at one of the
bi-weeklies?

>
>> >
>> > This change also aligns the outgoing FLB lifecycle management with the
>> > incoming FLB, since the latter uses the same get/put semantics.
>> >
>> > Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
>> > Assisted-by: Gemini:gemini-3-pro-preview
>> > Signed-off-by: David Matlack <dmatlack@google.com>
>> [...]
>> 
>> -- 
>> Regards,
>> Pratyush Yadav

-- 
Regards,
Pratyush Yadav

