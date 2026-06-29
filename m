Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BFFC43327
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KIRuiP3uGCfyDumZZydtFbsuLumGucf7ctHvx92C2Lg=; b=hP1l4YGrSCSRuTe/qjf13etpaX
	Fs67s3Oy85aimy8mpqG670Y9ZBP20oAaTBojZ7kgKtAVKVeuqvYVOVRqGb/FMggRC3ZEIZLkn5ctp
	qFtDoIjOtak9yo2Rl63yMh8bc8lejRE3H3zY0qMCzZphl5D9Cb7DJ7SjR7eQ0+l3kZSMzij0BcG3w
	u4D+2733V/UZBBU7x5/aC7oBK2DqcHr/jvGHpONxcFZmM+EjTjtluaWP7LEnmPCHj4+zrhjkNcYpz
	qhQIRkp+HtmeIh/PELh1bHl13bFoVHx3SgZ8R2k0IbUJXIg872yg/USgKCAOsbn8cj7FkP0XxQeoi
	k+JvNCBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we7yS-0000000E6SJ-3dsx;
	Mon, 29 Jun 2026 09:08:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we7yQ-0000000E6SC-3ica
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 09:08:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A47D242A10;
	Mon, 29 Jun 2026 09:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AC41F000E9;
	Mon, 29 Jun 2026 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724094;
	bh=KIRuiP3uGCfyDumZZydtFbsuLumGucf7ctHvx92C2Lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jWKRGPoeMKYHSWkprOEof3gvzQRlZRx/8mWh62FjBsp6cQ8dpsUO9cI3BKqCVYrbq
	 1dVVK0m4XRp6AXO9nTc8x49vNb1K9dY/r/796rhyvBkYvrSYBDgmj3PW5rCQav3Prg
	 KImAK6rmCHhw8T+uiW7bQGZD5aR35DDCMQcPdUvXEpo/WWeSu8Qw+qf+oqJeU2gclo
	 tvRKgl00sZls7MEKtNXpfnz0u4mPMktOjV10TCjFwlhbR4vlIh90s2wQm4gCna9VZb
	 MyF55vWI3mdh+/WPRZKOfoFR2aFPlvbLrFdPnjJdY1Yv6GGV0+na1KustcINvsCc0W
	 cujHChQtJTYfw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Samiullah Khawaja
 <skhawaja@google.com>,  Mike Rapoport <rppt@kernel.org>,  Alexander Graf
 <graf@amazon.com>,  David Matlack <dmatlack@google.com>,
  tarunsahu@google.com,  open list <linux-kernel@vger.kernel.org>,  "open
 list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>,  "open list:KEXEC
 HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add internal APIs for file
 preservation
In-Reply-To: <akIask9nPTEAhd76@plex> (Pasha Tatashin's message of "Mon, 29 Jun
	2026 07:32:14 +0000")
References: <20260613012521.835490-1-skhawaja@google.com>
	<20260613012521.835490-2-skhawaja@google.com>
	<2vxzwlvljyzs.fsf@kernel.org> <akIask9nPTEAhd76@plex>
Date: Mon, 29 Jun 2026 11:08:11 +0200
Message-ID: <2vxzse65k938.fsf@kernel.org>
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

On Mon, Jun 29 2026, Pasha Tatashin wrote:

> On 06-26 13:57, Pratyush Yadav wrote:
>> Hi Sami,
>> 
>> On Sat, Jun 13 2026, Samiullah Khawaja wrote:
>> 
>> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
>> >
>> > Live update orchestrator file handlers depend on the preservation of
>> > other files. To make sure that the dependency is preserved, the file
>> > handlers needs to fetch the preservation token of the preserved
>> > dependency. Similarly during restore, a file handler wants to fetch the
>> > restored file of the dependency.
>> >
>> > Add APIs that allows fetching token of dependency during preservation,
>> > and fetching the restored file dependency during restore.
>> >
>> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> 
>> We discussed this once already on a call, but I'll write my argument out
>> here for everyone else to get a say as well.
>> 
>> While it isn't obvious, this patch implicitly defines a part of the uAPI
>> for live update. This patch says to VMMs (or other live update users)
>> that "you can restore dependent files in any order". That is, VMMs
>> don't have to restore the files in a topological sort order or
>> dependencies, they can do so in any order and the kernel will manage the
>> dependencies on its own.
>
> Avoiding a forced dependency ordering is a deliberate design choice in 
> LUO, to avoid any kind of circular dependeces: A depends on B, B depends 
> on C, and C depends on A.

Do we have anything like this in practice? IIUC IOMMUFD and VFIO FD have
sorted out their dependency order and we no longer have circular
dependencies there.

>
> To achieve this, LUO provides the .can_finish() callback. So, LUO does
> two-phase verification:
>
> 1. It iterates through all tracked files and invokes .can_finish().
> 2. Only if *all* files return success does it proceed to invoke .finish().
>
> If a VMM restores a file (such as guest_memfd) but fails to restore its
> dependency (such as the VM FD), or attempts to close the session 
> prematurely, the .can_finish() check for that file will fail (returning 
> -EBUSY), and the entire finish sequence will abort. This guarantees 
> kernel-enforced correctness at the session boundary and without forcing 
> the VMM to execute restores in a strict sequential order, which anway 
> would not make  any sense from kernel side due to circular dependecies 
> issue, where topological sort does not exist.
>
>> 
>> But on the preservation side, VMMs still do need to follow the
>> topological order of dependencies. Because if they don't, the
>> liveupdate_get_token_outgoing() call will fail and preservation can't
>> proceed.
>
> Actually, preservation can also be performed in an order-independent manner.
> While a handler can call liveupdate_get_token_outgoing() during .preserve(),
> it can also defer this query until the .freeze() callback. Because .freeze()
> is invoked after all files in the session have completed their .preserve() phase,
> all dependency tokens are guaranteed to be available, completely eliminating any
> topological ordering requirements during the initial preservation calls. It is
> up to individual file handler implementations to decide whether they wish to
> enforce ordering at .preserve() time or defer it to .freeze().

That is the worst of both worlds. I get your point that LUO doesn't want
to enforce dependency ordering. My arguments against that are somewhat
subjective so I can live with this.

But then you can't let file handlers enforce it as they wish. The
dependency ordering is uAPI because it directly affects how VMMs
preserve files. If the VMM has to keep track of dependencies for some
file types and doesn't have to do so for others, that is a terrible and
inconsistent API.

Ideally, LUO should handle the dependencies on its own. preserve() can
give LUO a list of files the preserved file depends on, and LUO makes
sure all the dependencies are present in the session at freeze. We would
also need a way of getting the dependent files back from LUO on
retrieve(). That would make sure the dependencies are properly enforced
both on freeze and finish, and the enforcement isn't left up to the file
handlers.

Unfortunately all that sounds fairly complicated so I am not sure if we
want to do that just yet, although I would like to hear your thoughts on
this.

>
>> In simple words, if file type A depends on file type B, VMMs always need
>> to preserve B before A, because A's preservation will try to find B's
>> token, and if B is not preserved that will fail. On the _restore_ side
>> though, liveupdate_get_file_incoming() implicitly retrieves the file so
>> the VMM can restore then in any order.
>> 
>> I don't like this for a couple reasons. First, this makes the API
>> asymmetric. If the VMM needs to manage dependency order during
>> preservation anyway, why not do it on retrieve as well?
>> 
>> Second, the API is easier to misuse. The VMM can restore A but not B,
>> and then close the session. It will go on its merry way never knowing it
>> did something wrong. For example, guest_memfd depends on its VM FD. With
>> this patch, LUO will allow restoring guest_memfd without restoring the
>> VM FD. This makes the guest_memfd practically useless. Yes, it is a bug
>> in the VMM anyway, but if guest_memfd restore was denied, then it would
>> be easier to catch.
>> 
>> The kernel will keep itself safe in either case, but it will make the
>> API harder to misuse. And you can always _relax_ the ordering
>> requirement if there is a need in the future, but you can't go the other
>> way round.
>> 
>> So that's my question: do we enforce restore ordering? The code change
>> should be relatively simple. You just need to fail if the file is not
>> already restored in liveupdate_get_file_incoming().
>> 
>> In either case, please at least add a piece in the documentation about
>> this ordering. We should not leave it implicit.
>
> As explained above, the .can_finish() callback addresses this problem 
> and prevents any misuse (such as closing a session with a missing VM FD 
> dependency).
>
> That said, I agree that these ordering semantics, deferred verification 
> model, and the exact roles of .can_finish() and .freeze() should not 
> remain implicit. It makes sense adding details to the documentation to 
> clarify this behavior.
>
> Pasha

-- 
Regards,
Pratyush Yadav

