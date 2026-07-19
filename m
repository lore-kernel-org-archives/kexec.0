Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713A7C4451B
	for <kexec@archiver.kernel.org>; Sun, 19 Jul 2026 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lXPllgzpXlDPcSqjRNXdzqpvgSvmJH0XLIFd6MTukVQ=; b=QAoSC6ToHFrxzBAwzSGGthvom+
	L4XNaRh6vvl5DNV4LQuMTSY0tD7u00KGUdogxDTRadPnp9f5mAhj3cLc/uL+vICSVe5/FW+TxQK82
	hgQ+JJRcQOu3Ni5sIDtPrGmP28jWh5yMWGv4O+bh+ybfC5OjeUSet6pMSlTCeYNYCThGd/sNfaImr
	Y/csIjmhlFGuILUHBHtOCSooE62GMkA2KH8XUXQgUZ/nrqtsUioK8ZvrB2hFZZ57c9yO6npCxPy/a
	QPXGU9E/P+fXz+nyDIE/r+h5niZ90TDQpBplJ6v7JqCYWnUUn3YUvDZ/0dMst+MzFGxmhaykMrsa8
	uGgXZEGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlUHg-00000005AIl-3KzX;
	Sun, 19 Jul 2026 16:22:32 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlUHa-00000005AIK-2v7z
	for kexec@lists.infradead.org;
	Sun, 19 Jul 2026 16:22:28 +0000
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-8eefd4a8057so54993106d6.0
        for <kexec@lists.infradead.org>; Sun, 19 Jul 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784478145; x=1785082945; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lXPllgzpXlDPcSqjRNXdzqpvgSvmJH0XLIFd6MTukVQ=;
        b=gKxszqYBETl1/nZQAi4uD4s5UCzpY5KPDt7Ri2HpiXVd51wkG4mi3xIsQs9w5I+F4n
         o4YZ/wU+5rkaYjUi645Nb3/uD/4s/T/J3O6XdKeanxzNTnUcoRtyVpO28ddZo9+y2Dtb
         6uaTNkaRnB89Od43MtWiaOvI7mJOfuzOyQPpsw+cXba135Q95YYbxnoJOsaUNGa1upCD
         nR09b4Sl/3opD1RRejdOjLygu7iMKL4ZSInNp07DJUk41KTiCqpHzMaKCO9QIjhZJnlb
         lRXS+mU46bMxcEm/MC1ZvetgriV0R/RVPjpIMLcven+oUu0ouKjcvGoe0WXSya5b0Y9b
         Nfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784478145; x=1785082945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXPllgzpXlDPcSqjRNXdzqpvgSvmJH0XLIFd6MTukVQ=;
        b=sDnyuKSLxJlJKlzdi3iAJgQwDPx0iT8PPU4za3L4Zy1xnBi6E7bC+k2mqNsA2bUPKO
         FJvrwHQ5tQIaiFeR/sn8eUqzZX2H/j99slFyDWlzktD6+xCOybPQN9KsN+g8Hkgl8hYy
         LsescwI10b6hvCKwSsNOyP0BNMppb+mlLXZzj2U36HCVLCv0NqJE9eOlURySK/uxVNEV
         ZH/VWpMxbN/Qtbgic7B8g6zH4K7+CIxQxrdNHjaLMbDIM7AM8bJHqWFACP4x3OAC5VSN
         PApCPK4fHrOCTn54PIKuqyGVqQdDhNcy/72SmKMSIcpAFeiHC1/Fw4AUdQWRJKIpGADC
         soaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUDa0ijejn2uhVH50Y9ykRwZ5H22pHDPrFlGptM8I34UPRzodwZyNwRHtHpK9WAkG8nVA3PA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMsS5mHiPTTHZrIi0xGxurzA3O8ckY2qdexDRBUzxzP0PMe3D8
	rlRm7ZnugaNO1i1WWIuXAKrm7y6AFhGZgQ3afn6alHz0GXPgrD45SP3VVoM9NjGCVk1WPsIm0eT
	xRx+m
X-Gm-Gg: AfdE7ckyEBCh2RyaHORuS1IZGUe7RIgYm02HgX9du+b8hjvFzCLZIuaLeJlgrSHSa4y
	QCT1BDlwn1BJhJRVL/mfz5xGLztjyPuGO1LH6hY0f7vVqcEk27fXf4MjgVIf2SCKuZ34UknG+2h
	Br4OCmEuUP3FQBMUcXQ5py3h9idWmnaUzGy9sPa90cj3xa8UGMQ5yK48aJ5PuxCtkN7p+PZhayB
	VvvbgJRwh3wKOgwdhk7N66RQ6x3ly/MrbrLAUNN45odySy8yIL2iVxdOkIYfPrR5SuagcmI8u8r
	T+IdBWEzSUKc+lQ6m78m57UjXsZzLN6TEhHD1tn6VdmmvIv1mwfimmAJJ2Xr/zjzGkjgMeMj7bk
	CylNWbSWVIGrxpOjwJsxuDxASewEykr9uLImGSkxk8SILeixu7yjvyTYbn8VtLZBrZvWSvG7nPp
	vPak6kqime/un6hUkcBbJYwmiOnortJQ==
X-Received: by 2002:a05:6214:3f92:b0:905:6e01:b9a3 with SMTP id 6a1803df08f44-907783a03famr128579916d6.31.1784478144692;
        Sun, 19 Jul 2026 09:22:24 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b21d6sm71687696d6.24.2026.07.19.09.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:22:24 -0700 (PDT)
Date: Sun, 19 Jul 2026 16:22:23 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add internal APIs for file
 preservation
Message-ID: <alzw-bO6OATl2mdT@plex>
References: <20260613012521.835490-1-skhawaja@google.com>
 <20260613012521.835490-2-skhawaja@google.com>
 <2vxzwlvljyzs.fsf@kernel.org>
 <akIask9nPTEAhd76@plex>
 <2vxzse65k938.fsf@kernel.org>
 <2vxz7bnhjnpa.fsf@kernel.org>
 <akvT1yBvIbvft1H_@google.com>
 <2vxz4ihxil6m.fsf@kernel.org>
 <alrDpAMknlYN9jL9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alrDpAMknlYN9jL9@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_092226_799178_45F4E5D4 
X-CRM114-Status: GOOD (  79.31  )
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

On 07-18 00:36, Samiullah Khawaja wrote:
> On Fri, Jul 17, 2026 at 07:24:17PM +0200, Pratyush Yadav wrote:
> > On Mon, Jul 06 2026, Samiullah Khawaja wrote:
> > 
> > > Hi,
> > > 
> > > Sorry I was out of office, so couldn't contribute to this discussion
> > > early.
> > > 
> > > On Mon, Jun 29, 2026 at 06:50:09PM +0200, Pratyush Yadav wrote:
> > > > On Mon, Jun 29 2026, Pratyush Yadav wrote:
> > > > 
> > > > > On Mon, Jun 29 2026, Pasha Tatashin wrote:
> > > > > 
> > > > > > On 06-26 13:57, Pratyush Yadav wrote:
> > > > > > > Hi Sami,
> > > > > > > 
> > > > > > 
> 
> [snip]
> 
> > > > > > Actually, preservation can also be performed in an order-independent manner.
> > > > > > While a handler can call liveupdate_get_token_outgoing() during .preserve(),
> > > > > > it can also defer this query until the .freeze() callback. Because .freeze()
> > > > > > is invoked after all files in the session have completed their .preserve() phase,
> > > > > > all dependency tokens are guaranteed to be available, completely eliminating any
> > > > > > topological ordering requirements during the initial preservation calls. It is
> > > > > > up to individual file handler implementations to decide whether they wish to
> > > > > > enforce ordering at .preserve() time or defer it to .freeze().
> 
> Quoting this text from pasha below.
> > > > > 
> > > > > That is the worst of both worlds. I get your point that LUO doesn't want
> > > > > to enforce dependency ordering. My arguments against that are somewhat
> > > > > subjective so I can live with this.
> > > 
> > > Pasha replied with some interesting points already, but I want to add
> > > some clarification here.
> > > 
> > > During preservation, enforcing order gives the following functionality:
> > > 
> > > - The token of the dependency (can be retrieved during freeze as you
> > >   suggested).
> > > - The dependency is preserved and that means it has bound with the LUO
> > >   session lifecycle. This guarantees that it is not going to go away
> > >   until the session is closed.
> > > - Once preserved, the dependency is in some kind of "immutable" state.
> > >   This might not be required by all dependent FDs, but it is critical
> > >   for some.
> > > 
> > > These ordering requirements should be clearly documented by the
> > > associated filehandler so the VMM knows how to do the preservation of a
> > > specific FD properly. This is actually similar to the memfd seal rule
> > > that iommufd preservation will enforce.
> > > > > 
> > > > > But then you can't let file handlers enforce it as they wish. The
> > > > > dependency ordering is uAPI because it directly affects how VMMs
> > > > > preserve files. If the VMM has to keep track of dependencies for some
> > > > > file types and doesn't have to do so for others, that is a terrible and
> > > > > inconsistent API.
> > > 
> > > But as you have already pointed out that the VFIO/IOMMUFD circular
> > > dependency is resolved, I am okay with enforcing dependency ordering
> > > during restore as well. However, establishing an ordered
> > > preserve/restore mandate in LUO at this point will force all future file
> > > handlers into complicated and buggy design choices if they have circular
> > > dependency or different lifecycle requirements.
> > 
> > Not really. You can always _relax_ the ordering requirements if a need
> > does come up. Because all the programs following the ordering will still
> > continue to work. The other way round won't work though.
> 
> Yes, this is a fair point.
> > 
> > > > > 
> > > > > Ideally, LUO should handle the dependencies on its own. preserve() can
> > > > > give LUO a list of files the preserved file depends on, and LUO makes
> > > > > sure all the dependencies are present in the session at freeze. We would
> > > 
> > > This again assumes the lifecycle of various FDs and that dependencies
> > > can be resolved during freeze(). Some file handlers do want order of
> > > preservation, and this scheme only guarantees preservation dependency
> > > without order, introducing hacky dependency state management until
> > > freeze().
> > > > > also need a way of getting the dependent files back from LUO on
> > > > > retrieve(). That would make sure the dependencies are properly enforced
> > > > > both on freeze and finish, and the enforcement isn't left up to the file
> > > > > handlers.
> > > > > 
> > > > > Unfortunately all that sounds fairly complicated so I am not sure if we
> > > > > want to do that just yet, although I would like to hear your thoughts on
> > > > > this.
> > > > 
> > > > We had discussion about this in the live update bi-weekly today. The
> > > > conclusion we arrived at is to keep the current functionality. That is,
> > > > we don't enforce preservation dependency.
> > > > 
> > > > But that also means file handlers can't try to get their dependent file
> > > > in their preserve() callback, since that would implicitly enforce
> > > > ordering. They always _have_ to do it from their freeze() callback.
> > > 
> > > This has problems at multiple levels:
> > > 
> > > - This indirectly sets up a precedent in uAPI that the VMM is allowed to
> > >   preserve the FDs in any order and the file handler will be able to
> > >   handle this.
> > > - This will be very tricky and will force filehandler to have
> > >   complicated/hacky state management to handle dependency. Specifically
> > >   I do need iommufd to be preserved before preserving the VFIO cdev that
> > >   has an iommufd dependency. Not sure, but I think this will also be
> > >   tricky when we start preservation of VFs and SRIOV PFs.
> > > 
> > > I don't think LUO should enforce an arbitrary rule like this unless we
> > > have a strong reasoning behind it.
> > 
> > It looks like you, me, and Pasha are saying slightly different things.
> > We all first need to take a step back and lay out our proposals clearly.
> > I'll write my points down, and I'll try to reproduce what I understood
> > from discussions with you and Pasha.
> 
> Thanks for laying down your points clearly. I'll reply to point 1 and 3
> together as those are entangled I think.
> 
> > 
> > I think we should focus discussions around the below 3 high level topics,
> > and we can figure out the implementation details later.
> > 
> > 1. Do dependent files need to be preserved before their main files?
> > 2. Do we apply the same rules to preserve() and retrieve()?
> > 3. Do the rules apply to all file handler or can file handlers choose
> >   their rules?
> > 
> > Here's my take for 1: Say A depends on B. I think it would be a good
> > idea for LUO to enforce that B gets preserved before A. You already
> > mentioned a few reasons for why. Similarly, LUO should also enforce that
> > B gets restored before A. We can figure out where the actual enforcement
> > happens, but that would be the principle of the LUO API.
> > 
> > Pasha suggests the opposite. In my discussions, and this email thread,
> > he doesn't want to enforce _any_ ordering. So you can preserve A and B
> > at any time and you check at freeze() that everything is present. Now I
> 
> Just to correct/clarify, quoting Pasha from his earlier email in this
> thread:
> 
> "It is up to individual file handler implementations to decide whether
> they wish to enforce ordering at .preserve() time or defer it to
> .freeze()."
> 
> Basically, a FH can choose to enforce ordering during preservation or
> not enforce any ordering and check it during freeze(). I agree with
> Pasha on this point, as it gives FHs the flexibility they need.
> 
> However, I see the value in maintaining consistency and simplicity for
> the VMMs, we can enforce that dependencies are preserved in order as a
> principle of the LUO API. I am ok with this. It might become tricky for
> any future circular dependencies down the road, but we can relax this if
> they come up, as you suggested above.
> 
> > see the value in this idea. It removes the need of tracking ordering
> > from VMMs. But I think it is also somewhat dangerous, because what
> > happens when freeze() fails? VMMs need to recover and restart the VMs or
> > retry live update. I don't know if they would be able to do so. This
> > path will likely be less tested.
> > 
> > But still, I can live with that. At least for memfd, guest_memfd, etc.
> > this shouldn't be very problematic. I am not sure about iommufd.
> > 
> > So in conclusion, I would prefer to have ordering, but I can live with
> > no ordering as well.
> 
> As elaborated in my previous email, I disagree with enforcing a
> no-ordering policy.
> 
> > 
> > For 2, I think we should apply the same rules on both sides. Mainly for
> > consistency. The VMMs should follow the right order for preservation and
> > restoration. Now again, I am fine with both enforcing the ordering or
> > not enforcing it, but I really think the rules should be consistent
> > across both sides.
> > 
> > From my reading, I think Pasha does as well, but from talking with you,
> > IIUC you think retrieve is a fundamentally different operation and it
> > should not enforce any ordering.
> > 
> > I do see your point but I still think there is value in keeping things
> > symmetric. Unfortunately this is fairly subjective, so I don't have much
> > better arguments.
> 
> I agree with you on this. For consistency and simplicity, we can apply
> the same rules on preserve/retrieve both.
> 
> > 
> > For 3, I _strongly_ think it should be a LUO wide policy. Leaving this
> > up to file handlers will become messy over time because each would come
> > up with its own rules and for VMMs there would be no consistency in how
> > they should use LUO.
> > 
> > I hope this helps focus our discussion to the major points. And again,
> > we can figure out the implementation details as we go along, so I didn't
> > reply to some of the points you raised in this email, to not distract
> > too much.
> > 
> > [...]
> > 
> > -- 
> > Regards,
> > Pratyush Yadav
> 
> Also I think with the next revision of this series, if Pasha also agrees
> with this, I will add documentation about FD dependency in general.

Pratyush, and Sami, thanks for the discussion. Here is my take. As Pratyush
mentioned earlier during hypervisor live update upstream meeting we agreed that
LUO should not enforce dependency ordering. The ordering must be performed by
FH, and it is up to us as LU reviewers to ensure that ordering is checked
during freeze() and can_finish().

However I would like to address two points:

Enforcing order today and relaxing it later is problematic. Not enforcing
ordering is the most future-proof approach: it solves the problem of dependency
graphs and shared resources. Once userspace starts relying on errors during
preservation or restoration to check ordering, we cannot undo that, as it
becomes uAPI.

The point that a VMM will have a hard time recovering from a freeze() failure
is not important. Missing dependencies are VMM bugs. They will be caught during
testing and will never actually happen in production.

Pasha

