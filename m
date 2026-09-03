Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCF6C61DD6
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 01:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:
	Date:In-Reply-To:From:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8g8KymnKrLeIxleep9l0L91rv8EWX79pScHra9GPCf4=; b=xiuv33p9cCu6sbL15u4KNkiw6+
	xpaj2QWprVS/Ov5KxUcy7p/vJ2V/AuY/dBTxlR8Lga2Oyi8Xgk7u4QHH32l2Ufd+W3xxiF5dm1ObM
	RJLQY3/YfQIxTFEpXs8DB7S9roD7ED0QoFTNAfzxZGG+9o2bECBmibZjmQFKCkZJ/ta6mSsYwymwg
	6cuaPboQSVwDPWdFKIyQQHo9n6ZueTA0YZhXG8oCPJaAQbaMNThFvPqvlJEkqrToIipUR+czWH5Ao
	nqYEUOzLtmqiTRajYtrWDqxKgfaTokvg44L0sGXm3MeR0xQgOiww6YsB8x2gFzOYjw2BnHYOT0jX1
	gbQ8xONw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1vr5-0000000G90Z-3rce;
	Thu, 03 Sep 2026 01:03:03 +0000
Received: from out-204.mta1.migadu.com ([95.215.58.204] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1vr2-0000000G8yQ-0k8y
	for kexec@lists.infradead.org;
	Thu, 03 Sep 2026 01:03:02 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=AeDxW45QjwesbUw8iPATCrxihLV2KDavoNyjbkC0yyo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788397375; v=1; x=1789002175;
 b=D3KjKq5I0SoMG0uiJyPYJ/4Cp03M/eeuiyzYyKwedBd4HBVGMrU6Ye4IyX+NhNSulqQDecRA
 EcGTywtsZqQCcTqxt1sIA5MkUwrZzI6444bvocgiKsszx8COO5xq/XeBkcvhRBNXqkCbacc3xQh
 lJ6qRl+DBO0G+Qh0tSoNGlTw=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 474d10de32a6a109;
	Thu, 03 Sep 2026 01:02:45 +0000
X-Mizu-Trace-ID: 474d10de32a6a109
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <CALzav=cE2AGXDAA4PCcohzqKwQNOZYEo4j33H6HxpMPX9Sdz0g@mail.gmail.com>
Date: Wed, 2 Sep 2026 18:02:29 -0700
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Dave Young <ruirui.yang@linux.dev>, Alexander Graf <graf@amazon.com>
Message-Id: <C6F5E157-B26C-496D-AF83-B6AA784BC74F@linux.dev>
References: <CALzav=cE2AGXDAA4PCcohzqKwQNOZYEo4j33H6HxpMPX9Sdz0g@mail.gmail.com>
To: David Matlack <dmatlack@google.com>
X-Mailer: iPad Mail (23G83)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_180301_026136_FB865840 
X-CRM114-Status: GOOD (  38.27  )
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


> On Sep 2, 2026, at 10:59=E2=80=AFAM, David Matlack <dmatlack@google.com> w=
rote:
>=20
> =EF=BB=BFOn Wed, Sep 2, 2026 at 2:18=E2=80=AFAM Pratyush Yadav <pratyush@k=
ernel.org> wrote:
>>=20
>> +Cc Roman because I am complaining about Sashiko ;-)
>>=20
>>> On Wed, Sep 02 2026, Baoquan He wrote:
>>>=20
>>> On 09/02/26 at 11:04am, Mike Rapoport wrote:
>>>> Hi Baoquan,
>>>>=20
>>>> On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
>>>>> On 09/02/26 at 07:34am, Mike Rapoport wrote:
>>>>>> On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
>>>>>>> Hi kexec@ mailing list and maintainers,
>>>>>>>=20
>>>>>>> I would like to enable Sashiko code reviews for patches sent to the
>>>>>>> kexec mailing list. I have found it useful for patches I have sent a=
nd
>>>>>>> reviewed on the kvm and linux-pci mailing lists, which have Sashiko
>>>>>>> enabled.
>>>>>>>=20
>>>>>>> I sent a pull request to Sashiko to add kexec here:
>>>>>>>=20
>>>>>>>  https://github.com/sashiko-dev/sashiko/pull/474
>>>>>>=20
>>>>>> diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_policy=
.toml
>>>>>> index e6e4fb57f..e9ad97708 100644
>>>>>> --- a/sashiko.dev/email_policy.toml
>>>>>> +++ b/sashiko.dev/email_policy.toml
>>>>>> @@ -175,6 +175,12 @@ reply_to_author =3D false
>>>>>> cc_individuals =3D false
>>>>>> cc =3D ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kernel.=
org>", "Anna Schumaker <anna@kernel.org>"]
>>>>>>=20
>>>>>> +[subsystems.kexec]
>>>>>> +lists =3D ["kexec@lists.infradead.org"]
>>>>>> +reply_to_author =3D true
>>>>>> +send_positive_review =3D true
>>>>>>=20
>>>>>> Do we really want those?
>>>>>=20
>>>>> Some components don't want to CC list, then other people are welcome t=
o
>>>>> drop any comment during reviewing, while cc to maintainer and author
>>>>> looks good to me. Just an input, no objection to any move.
>>>>=20
>>>> Sorry, I wasn't clear, I meant do we really want extra emails saying
>>>> sashiko is happy?
>>>=20
>>> Oh, sorry. I misunderstood, I thought you had agreed to introduce
>>> sashiko to part of list/author/maintainer or all.
>>>=20
>>> I think there are two different ways and they have different impact:
>>>=20
>>> 1) CC list (CC author and maintainer can be ignored beause all people
>>> can see it)
>>=20
>> This is a side topic, but if we only Cc the list then Sashiko won't Cc
>> the other people in the thread, like the usual "reply to all" every mail
>> clients does. It will _only_ Cc the list. See [0] for example.
>>=20
>> I don't think that is a good idea, because Sashiko might complain about
>> something, and then the patch author can reply to the complaint. People
>> who are not subscribed to the list will neither see Sashiko's complaint
>> nor the author's response. So they lose a useful part of the patch
>> review process.
>>=20
>> I am one of those people. I don't subscribe to any mailing lists and
>> instead use lei [1] to fetch them. I treat my inbox as the primary
>> stream of patches, and then glance at the lists every now and then. If I
>> get some patches in my inbox but then I don't get any of the follow-ups
>> from the author to Sashiko, that's annoying. Sure, I might see them on
>> the list later, but it is still annoying.

It feels like there are two types of people: some know how to use email filt=
ers and some don=E2=80=99t.
Unfortunately, the latter group is often very vocal about what they don=E2=80=
=99t want
to see on mailing lists. I can easily see the problem with too much ai-gener=
ated noise
(and useful information as well), so no complaints from me, just saying that=
 there is a reason
sashiko is fairly conservative here.

>>=20
>> And of course, there might be patches that touch multiple subsystems and
>> maintainers of that subsystem might not subscribe to or track kexec@ at
>> all. So they will entirely miss the conversation.
>>=20
>> If Sashiko is useful enough to send replies on the list, then I think it
>> is useful enough to reply to everyone.
>=20
> It looks like this can be configured:
>=20
> - reply_all=3Dtrue will have Sashiko reply to everyone on the To/Cc line.
> - cc_individuals=3Dtrue will have Sashiko include all inidividuals from th=
e
>   To/Cc line of the original patch.
>=20
>>=20
>> IIRC some people have complained in the past about automatically getting
>> replies from Sashiko so maybe that is why this behaviour exists? Roman,
>> is that correct? Is there any appetite yet to change that behaviour?

Can you, please, describe, what behavior do you want?

>>=20
>> Or could we perhaps have an unsubscribe mechanism where people who don't
>> want to see anything from Sashiko can unsubscribe themselves and Sashiko
>> will skip them when replying?

This is the territory I don=E2=80=99t really want to go, honestly. Not a dea=
lbreaker if there is a very strong
reason to implement it, but I don=E2=80=99t think we have similar lists for o=
ther tools like syzbot or the build verifier.
I feel it=E2=80=99s more about the politics around ai then a real technical r=
eason (it=E2=80=99s like super trivial to drop emails from
a specific sender), so I=E2=80=99d avoid this if possible.

Thanks

>>=20
>> [0] https://lore.kernel.org/kvm/20260902072059.90ADC1F000E9@smtp.kernel.o=
rg/
>> [1] https://public-inbox.org/lei.txt
>>=20
>>>  This equals to cc author and push other reviewers away. And no
>>>  reviewers will be patient and curious enough to check the sashiko
>>>  report except of maintainers. Because maintainers need pick patch
>>>  and may check if all reported issues are handled;
>>>=20
>>> 2) Cc maintainers when patch is cooked
>>>  Maintainers tell patch author to check the report. Maybe CC patch
>>>  author directly can save maintainers' effort.
>>>=20
>>> I personally think 2) is good. About whether introducing sashiko,
>>> I would vote yes. I buy token by myself, sashiko would be a plus.
>>=20
>> FWIW, Sashiko already tracks the kexec@ list and you can see all the
>> patches in the web interface [2]. So you don't need to burn your tokens
>> on reviewing kexec patches ;-)
>>=20
>> What David is proposing is to send those reviews to the list.
>>=20
>> [2] https://sashiko.dev/#/?list=3Dorg.infradead.lists.kexec
>>=20
>>>=20
>>> Thanks
>>> Baoquan
>>=20
>> --
>> Regards,
>> Pratyush Yadav

