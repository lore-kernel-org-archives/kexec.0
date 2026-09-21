Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA44DC982ED
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YuDe9pA1WPnbu9k5jZuDfnztXNOTbiX+JI4KYMHh14=; b=ZzdDkfmHqWM8OKDOPQfizv5eZs
	FuxLu51DsNe/wNB6JHMRWT6g8UAKa4lkkAx7TD/hpcgfmrt5eWb6Ot6FMFDUHWR5BYkClTnywOped
	DiUUB/h3UCsrqujFEdc3GIMV3AbbUVpyvZy9PYN6WycXtc7kre91jSkuvZVtHdZkB9N+5FitrLf0O
	o0mCdfbpFPg+DBpBqTDh77mv+p4sTb7OLRhHVh73nNHgS28Cd9U4KQwOcZClfiUzkcDmIMoDzkTt2
	DIZpl38ee6EYMpYntt3JWMjyuTHJrN5oGX2JXNG2hz2wtNT35L21vJ9q1eNm7XVKTBUhPqCaWef0S
	oCDqRa4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8gln-00000002obX-06mH;
	Mon, 21 Sep 2026 16:21:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8glm-00000002obC-0zrM
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 16:21:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C713A4403B;
	Mon, 21 Sep 2026 16:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8811F000FF;
	Mon, 21 Sep 2026 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007689;
	bh=7YuDe9pA1WPnbu9k5jZuDfnztXNOTbiX+JI4KYMHh14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lZzAz+egWCoJeubPyiX0H2yFFcdevkHcHUuSNlxjHvy0aUTufTeNdrgUPOeUtOUa7
	 cH0tNvE/QBOMIGGxC1wgpRw9j/rDCbvZUTuMNkLAOp8JD7E2qRur4IfcDwCgKcfD2j
	 CDefaVzAyJinaWuZq59KXzcyl5xFe39Ye+REKJ6MguGW5l/C1EldYKAbKIxOtu2c0M
	 IKGERUD5+IK5IvQS4WgcGfWAChqLtpLX0ARRlqGMw4uTYzOYb7qFhN0dZCjiYHdH5q
	 T///EExEOewALz2aOO8/hs48z6/uGshvkjAFvuLPyFKRg/OL6YoSC/GG4H9Tbk8Ec1
	 kkUbdF2pZ24Fw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: David Matlack <dmatlack@google.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Baoquan He <baoquan.he@linux.dev>,  Mike Rapoport
 <rppt@kernel.org>,  kexec@lists.infradead.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Dave Young <ruirui.yang@linux.dev>,  Alexander Graf <graf@amazon.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
In-Reply-To: <C6F5E157-B26C-496D-AF83-B6AA784BC74F@linux.dev> (Roman
	Gushchin's message of "Wed, 2 Sep 2026 18:02:29 -0700")
References: <CALzav=cE2AGXDAA4PCcohzqKwQNOZYEo4j33H6HxpMPX9Sdz0g@mail.gmail.com>
	<C6F5E157-B26C-496D-AF83-B6AA784BC74F@linux.dev>
Date: Mon, 21 Sep 2026 18:21:26 +0200
Message-ID: <2vxzse3260e1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Sep 02 2026, Roman Gushchin wrote:

>> On Sep 2, 2026, at 10:59=E2=80=AFAM, David Matlack <dmatlack@google.com>=
 wrote:
>>=20
>> =EF=BB=BFOn Wed, Sep 2, 2026 at 2:18=E2=80=AFAM Pratyush Yadav <pratyush=
@kernel.org> wrote:
>>>=20
>>> +Cc Roman because I am complaining about Sashiko ;-)
>>>=20
>>>> On Wed, Sep 02 2026, Baoquan He wrote:
>>>>=20
>>>> On 09/02/26 at 11:04am, Mike Rapoport wrote:
>>>>> Hi Baoquan,
>>>>>=20
>>>>> On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
>>>>>> On 09/02/26 at 07:34am, Mike Rapoport wrote:
[...]
>>> This is a side topic, but if we only Cc the list then Sashiko won't Cc
>>> the other people in the thread, like the usual "reply to all" every mail
>>> clients does. It will _only_ Cc the list. See [0] for example.
>>>=20
>>> I don't think that is a good idea, because Sashiko might complain about
>>> something, and then the patch author can reply to the complaint. People
>>> who are not subscribed to the list will neither see Sashiko's complaint
>>> nor the author's response. So they lose a useful part of the patch
>>> review process.
>>>=20
>>> I am one of those people. I don't subscribe to any mailing lists and
>>> instead use lei [1] to fetch them. I treat my inbox as the primary
>>> stream of patches, and then glance at the lists every now and then. If I
>>> get some patches in my inbox but then I don't get any of the follow-ups
>>> from the author to Sashiko, that's annoying. Sure, I might see them on
>>> the list later, but it is still annoying.
>
> It feels like there are two types of people: some know how to use
> email filters and some don=E2=80=99t. Unfortunately, the latter group is =
often
> very vocal about what they don=E2=80=99t want to see on mailing lists. I =
can
> easily see the problem with too much ai-generated noise (and useful
> information as well), so no complaints from me, just saying that there
> is a reason sashiko is fairly conservative here.
>
>>>=20
>>> And of course, there might be patches that touch multiple subsystems and
>>> maintainers of that subsystem might not subscribe to or track kexec@ at
>>> all. So they will entirely miss the conversation.
>>>=20
>>> If Sashiko is useful enough to send replies on the list, then I think it
>>> is useful enough to reply to everyone.
>>=20
>> It looks like this can be configured:
>>=20
>> - reply_all=3Dtrue will have Sashiko reply to everyone on the To/Cc line.
>> - cc_individuals=3Dtrue will have Sashiko include all inidividuals from =
the
>>   To/Cc line of the original patch.
>>=20
>>>=20
>>> IIRC some people have complained in the past about automatically getting
>>> replies from Sashiko so maybe that is why this behaviour exists? Roman,
>>> is that correct? Is there any appetite yet to change that behaviour?
>
> Can you, please, describe, what behavior do you want?

Sorry for the late reply.

The behaviour is already an option that can be configured
(reply_all=3Dtrue), I just wasn't aware that was an option. So I don't
think any change is needed.

IMO this should be the default but I can see why you might not want to
do it just yet.

>
>>>=20
>>> Or could we perhaps have an unsubscribe mechanism where people who don't
>>> want to see anything from Sashiko can unsubscribe themselves and Sashiko
>>> will skip them when replying?
>
> This is the territory I don=E2=80=99t really want to go, honestly. Not a
> dealbreaker if there is a very strong reason to implement it, but I
> don=E2=80=99t think we have similar lists for other tools like syzbot or =
the
> build verifier. I feel it=E2=80=99s more about the politics around ai the=
n a
> real technical reason (it=E2=80=99s like super trivial to drop emails fro=
m a
> specific sender), so I=E2=80=99d avoid this if possible.

Yeah, fair enough.

[...]

--=20
Regards,
Pratyush Yadav

