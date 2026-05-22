Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB2FCD5BB1
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1nzqWEcupotk3bSStU86bdDF61BEXLhW/a/OqJdxDrQ=; b=JsT0chiRPnxuDSw3TCs5GnVmmE
	VJ1CzRHK9UpTbuyz8uobJkOv3ELGtYwOCmkFoB28XlmitQar0SYLuXBDxtkw4Lo726Li0ZrL+Dx/7
	4D9hqLm3WTxzavdo8cpQwZyvnStG6phAZVqooi+KW9p+XNINwYBnxHpWgkuNSjthlv11o+AKby0ZQ
	1gXL1/l4IEHHpWNVCXixkmP3K/Zcy6Wp96Ztv6Vxu5XgjKmETOcnDkvtJfa9iT4xdyk0pR9o813Tr
	ystL0jqlKOsvrnyHcufhzExE331Yd9mYVEfsip+0Zz3fyOauY8Q1l2ECluU/FeQYzlInBt3k0MVOU
	hT5o0ifQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQPMM-0000000Ase4-1ou1;
	Fri, 22 May 2026 12:52:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQPMJ-0000000AsdL-3ldF
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 12:52:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 289DD43FD3;
	Fri, 22 May 2026 12:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CB71F000E9;
	Fri, 22 May 2026 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454331;
	bh=1nzqWEcupotk3bSStU86bdDF61BEXLhW/a/OqJdxDrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CEmtow2RQ3c/3xsbSZZXeBCiAew/hjls0zYGgRGzv21AAvv5SIhYlJaNgNIvd2sBj
	 s2COCrWxDtvjVNQrNcX8/Aa019YyIAnO+iWmjESYW6E551164CVxOvM9Smh4eMDGSs
	 h4d8dLT/nI7PnSZCMOxjFE7E2mYoOqKb7d691PGLYss7FTDvkVjwiZDxqHs2y5PzRG
	 QmwgZMLolQCk8M/qjJEwpnPqKcJNDHdhNZGqMKT3o/rDwq5RwwDF4fIEO8Rhm/mv2I
	 xPs8Oa9WLySmHYPOZgnFeVVfM3A0kQrfEUAEmZw0OcdC5KASGf48Vx0by6KbNXYkmi
	 x8fpdZ8WxKvGA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  rppt@kernel.org,
  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  skhawaja@google.com,  graf@amazon.com,
  mario.limonciello@amd.com
Subject: Re: [PATCH v5 3/5] liveupdate: block session mutations during reboot
In-Reply-To: <aguXhxrjhvmxAyb2@plex> (Pasha Tatashin's message of "Mon, 18 May
	2026 23:15:17 +0000")
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
	<20260518125459.1092373-4-pasha.tatashin@soleen.com>
	<2vxzo6ic8ysn.fsf@kernel.org> <aguXhxrjhvmxAyb2@plex>
Date: Fri, 22 May 2026 14:52:07 +0200
Message-ID: <2vxz4ijz8v48.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_055211_973745_B5E63946 
X-CRM114-Status: GOOD (  25.47  )
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

On Mon, May 18 2026, Pasha Tatashin wrote:

> On 05-18 18:31, Pratyush Yadav wrote:
>> On Mon, May 18 2026, Pasha Tatashin wrote:
>>=20
>> > During the reboot() syscall, user processes may still be running
>> > concurrently and attempting to mutate sessions (e.g., creating,
>> > retrieving, or releasing sessions). To prevent this, introduce
>> > luo_session_serialize_rwsem to synchronize mutations with the
>> > serialization process.
>> >
>> > All session mutation operations (create, retrieve, release, ioctl) take
>> > the read lock. The serialization process (luo_session_serialize) takes
>> > the write lock and holds it indefinitely on success. This effectively
>> > freezes the LUO session subsystem during the transition to the new
>> > kernel. If serialization fails, the lock is released to allow recovery.
>>=20
>> Good idea I think.
>
> Hi Pratyush,
>
>>=20
>> But, do we need a new mutex? Can't we use luo_session_header->rwsem?
>> Session creation and release take the header rwsem at one point anyway,
>> so perhaps we can just reuse that?
>
> The sh->rwsem is for protecting the the session list. We only take it as=
=20
> a writer when modifying the list (insert/remove) and as a reader when=20
> traversing it. Also, we drop sh->rwsem as soon as we've acquired the=20
> per-session mutex to allow other list operations to proceed while a=20
> session is being modified.
>
> Because of this, many session mutation operations (specifically ioctl=20
> calls) don't touch sh->rwsem at all=E2=80=94they jump straight to the  se=
ssion=20
> state via the file's private_data. To use sh->rwsem to block
> these mutations, we would be forced to add down_read(&sh->rwsem) to=20
> every ioctl path. This would be a layering violation, coupling list=20
> management to per-session data mutations, and would introduce a global
> bottleneck for operations that are otherwise independent.

As for the layering violation, I think we would need to change the
semantics of the lock -- it no longer protects only the list, but other
session operations as well.

But yeah, if we do this then operations like session creation would have
to wait for ongoing session operations like PRESERVE_FD. My argument was
based around the fact that session creation or removal should not be
very frequent (and don't happen in the hot path anyway) so the added
latency should not affect them as much. By doing this tradeoff we get
slightly simpler code (and simpler locking scheme).

But I see your point as well. In practice session creation and
PRESERVE_FD are independent and one should not block the other. Maybe we
get VMMs creating sessions while another VMM is preserving stuff, and
this slowing down the live update preparation? Dunno...

I suppose let's go with this patch. But, can you please document the
lock hierarchy where you explain what this lock is for?

>
> The only other way to prevent mutations without a new global lock would=20
> be for the reboot process to acquire every individual session mutex.=20
> However, since LUO_SESSION_MAX can be large, this would exceed lockdep's=
=20
> maximum lock tracking limit and trigger failures. The=20
> luo_session_serialize_rwsem provides a dedicated signal to freeze the=20
> entire subsystem without messing with the existing fine-grained locking=20
> logic.

Yeah, that would have been nice, but we shouldn't break lockdep I reckon.

>
>>=20
>> Also, do we need to block incoming sessions? They won't participate in
>> serialization, so perhaps we can leave those alone, and all the outgoing
>> sessions get protected by the outgoing session header rwsem?
>
> Incoming sessions don't participate in serialization, but blocking them=20
> makes the code more robust. This provides a level of future proofing if=20
> new ioctls or operations are added later, we won't accidentally miss a=20
> path that should have been frozen during reboot. It's safer to treat the=
=20
> subsystem as a single unit that freezes entirely once the transition=20
> begins.

Sure, makes sense.

--=20
Regards,
Pratyush Yadav

