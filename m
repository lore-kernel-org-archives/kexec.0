Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98FBC36000
	for <kexec@archiver.kernel.org>; Wed, 19 Mar 2025 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GD84eS+KjqESu8bl1BI9Aha2TWlwiVZ+GXn8bhJHG+4=; b=41RP3ECYQt/xtOoOP4Aw1fRU5F
	qAPYO9Tgt3EjuV18cVj23ozLvz5SxzO3hShfUN9zUsbVibr8MiBLgJykcw/Ig0rTE+kZn1+jvaB0f
	nPJyxpkywY01QZrM/o1040paEH5AogVHxt/AXG6SwVOvvHpPkPmcHQjjRhQEI3u1RKOGBNBSPCs2K
	7+z3ZujdrXXVnZZMz7y2rXoNAwLzH96p9wjBaIURPJZAMI6+hwBY4lfmJQU+ryr1EXMfYW7LqWDH1
	+L8fC5xuIiP6eNxDKXyvD9fGHoqhxN2bVEUtjlaWbFaq6NPam+3pyV2JF6thSHMfZlP+ORPzfNt3p
	mQN7ZH1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tutaA-000000096Hp-3oyx;
	Wed, 19 Mar 2025 13:35:42 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuta7-000000096Go-2nII
	for kexec@lists.infradead.org;
	Wed, 19 Mar 2025 13:35:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1742391339; x=1773927339;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GD84eS+KjqESu8bl1BI9Aha2TWlwiVZ+GXn8bhJHG+4=;
  b=DjrNauJf5iK1L9YHpV/UYWylBmskc8az6cQxTVVhl4p+5iGd0aAROZ6N
   N0Oizfq7dUh492Zm5QY7fMbxaaR04jbdaG8rl4FFu7R2XvS8YT9YVCXtn
   lWzQ9IqVRCoFkNNJ/av+e2/nhat5HATAG3uzG7xNmfojKgZilJcSuocbA
   U=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736812800"; 
   d="scan'208";a="481718566"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 13:35:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:53702]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 22e8791f-d226-4e39-a4e3-702c6513df8c; Wed, 19 Mar 2025 13:35:32 +0000 (UTC)
X-Farcaster-Flow-ID: 22e8791f-d226-4e39-a4e3-702c6513df8c
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 13:35:32 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 13:35:32 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 13:35:32 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTP id CF94A40238;
	Wed, 19 Mar 2025 13:35:31 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 8C4975149; Wed, 19 Mar 2025 13:35:31 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Christian Brauner <brauner@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Eric Biederman <ebiederm@xmission.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "Hugh
 Dickins" <hughd@google.com>, Alexander Graf <graf@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, David Woodhouse
	<dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike Rapoport
	<rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
	<tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, "Dave
 Hansen" <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
In-Reply-To: <20250318232727.GF9311@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
	<20250307005830.65293-2-ptyadav@amazon.de>
	<20250307-sachte-stolz-18d43ffea782@brauner> <mafs0ikokidqz.fsf@amazon.de>
	<20250309-unerwartet-alufolie-96aae4d20e38@brauner>
	<20250317165905.GN9311@nvidia.com>
	<20250318-toppen-elfmal-968565e93e69@brauner>
	<20250318145707.GX9311@nvidia.com> <mafs0a59i3ptk.fsf@amazon.de>
	<20250318232727.GF9311@nvidia.com>
Date: Wed, 19 Mar 2025 13:35:31 +0000
Message-ID: <mafs05xk53zz0.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_063539_865495_9E6EF2E4 
X-CRM114-Status: GOOD (  40.40  )
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

On Tue, Mar 18 2025, Jason Gunthorpe wrote:

> On Tue, Mar 18, 2025 at 11:02:31PM +0000, Pratyush Yadav wrote:
>
>> I suppose we can serialize all FDs when the box is sealed and get rid of
>> the struct file. If kexec fails, userspace can unseal the box, and FDs
>> will be deserialized into a new struct file. This way, the behaviour
>> from userspace perspective also stays the same regardless of whether
>> kexec went through or not. This also helps tie FDBox closer to KHO.
>
> I don't think we can do a proper de-serialization without going
> through kexec. The new stuff Mike is posting for preserving memory
> will not work like that.

Why not? If the next kernel can restore the file from the serialized
content, so can the current kernel. What stops this from working with
the new memory preservation scheme (which I assume is the idea you
proposed in [0])? In that, kho_preserve_folio() marks a page to be
preserved across KHO. We can have a kho_restore_folio() function that
removes the reservation from the xarray and returns the folio to the
caller. The KHO machinery takes care of abstracting the detail of
whether kexec actually happened. With that in place, I don't see why we
can't deserialize without going through kexec.

>
> I think error recovery wil have to work by just restoring access to
> the FD and it's driver state that was never actually destroyed.
>
>> > It sure would be nice if the freezing process could be managed
>> > generically somehow.
>> >
>> > One option for freezing would have the kernel enforce that userspace
>> > has closed and idled the FD everywhere (eg check the struct file
>> > refcount == 1). If userspace doesn't have access to the FD then it is
>> > effectively frozen.
>> 
>> Yes, that is what I want to do in the next revision. FDBox itself will
>> not close the file descriptors when you put a FD in the box. It will
>> just grab a reference and let the userspace close the FD. Then when the
>> box is sealed, the operation can be refused if refcount != 1.
>
> I'm not sure about this sealed idea..
>
> One of the design points here was to have different phases for the KHO
> process and we want to shift alot of work to the earlier phases. Some
> of that work should be putting things into the fdbox, freezing them,
> and writing out the serialzation as that may be quite time consuming.
>
> The same is true for the deserialize step where we don't want to bulk
> deserialize but do it in an ordered way to minimize the critical
> downtime.
>
> So I'm not sure if a 'seal' operation that goes and bulk serializes
> everything makes sense. I still haven't seen a state flow chart and a
> proposal where all the different required steps would have to land to
> get any certainty here.

The seal operation does bulk serialize/deserialize for _one_ box. You
can have multiple boxes and distribute your FDs in the boxes based on
the serialize or deserialize order you want. Userspace decides when to
seal or unseal a particular box, which gives it full control over the
order in which things happen.

>
> At least in my head I imagined you'd open the KHO FD, put it in
> serializing mode and then go through in the right order pushing all
> the work and building the serializion data structure as you go.

If we serialize the box at seal time, this is exactly how things will be
done. Before KHO activate happens, userspace can start putting in FDs
and start serializing things. Then when activation happens, the
box-level metadata gets quickly written out to the main FDT and that's
it. The bulk of the per-fd work should already be done.

We can even have something like FDBOX_PREPARE_FD or FDBOX_PREPARE_BOX
that pre-serializes as much as it can before anything is actually
frozen, so the actual freeze is faster. This is similar to pre-copy
during live migration for example.

All of this is made easier if each component has its own FDT (or any
other data structure) and doesn't have to share the same FDT. This is
the direction we are going in anyway with the next KHO versions.

>
> At the very end you'd finalize the KHO serialization, which just
> writes out a little bit more to the FDT and gives you back the FDT
> blob for the kexec. It should be a very fast operation.
>
> Jason
>

[0] https://lore.kernel.org/lkml/20250212152336.GA3848889@nvidia.com/

-- 
Regards,
Pratyush Yadav

