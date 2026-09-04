Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D8AC79F82
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mcFBRkoyCJV3OWGWia+2d7PyvSuekBz/hXo7rYDNODc=; b=prQ7w/7o/EZ2WRwx+iHFZ30MYv
	YiuHYH8m6nm3Ah6Rz0HcwUpIRglEEWtSfDOvep4tuubLc5JsVxiU9PhKVzTflLiWtdg4U68VwgCKf
	Y09pDVOxS2/aa68KOh2uvIpUu86fvNhqdgLUXLLwc/2Wtz7b8joqvcu1wllqCgxl1YDcW13ZHL8nc
	8WRWbHYB8LUlQAkjiNLgNavkfnZFWbOYoQiIcZA0GxV3NdQ9cmqSXV/pq9fidwYMWoofX41q9BsP+
	1xbg1HwRG4pbrSbc6/Iko1w3wWRou4OebHYXgyNgFq2Cl5y2oAtelvICDTb8SInh2KgrwBoii3pjY
	BTRZ7aUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2bMg-00000003JT2-0Y9L;
	Fri, 04 Sep 2026 21:22:26 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2bMA-00000003JSD-0rQ0
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 21:21:55 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c1c52d920b8so192870766b.2
        for <kexec@lists.infradead.org>; Fri, 04 Sep 2026 14:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788556911; cv=none;
        d=google.com; s=arc-20260327;
        b=ouWrdssLFIIQyeIxDYBsw4CtSM61e2sMRGBFhs4Fpx9nuZ2dE8aHHtvF7XSh3NPMcI
         gssxbVpHPrjjcIMr4lk6/JiJ5Z2W9+yjnUpt+Db0bjbUedxvAkq6qte6wv6h3BY+6Shc
         ChE6+y83v7W4i6WPg2TmunQRZZT9WeoO6h2AiymXDNUM95nhCcvzzfrcrvnnqw2R2Zex
         hsFfQF6uYP5naVfu5ke7P8PgGEdBQi/wCcrb5Bkbhb/2MBwyXUKcvDtYyYO8UGv+KM2Q
         bwImYlzVikSEE6cVFSsnwrfJjYnJeJJVCaJ+o7mYmkqUPXDOAUMezwSEmOkGuTni78+C
         KufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mcFBRkoyCJV3OWGWia+2d7PyvSuekBz/hXo7rYDNODc=;
        fh=6BBXXM10FQ4RXvq3YbDRWd0ZFx/eQfBp203gdLpGkYw=;
        b=VCveQSTCqpoDjVqhf8aZGZ0gakY2OhV6ETrRDSMCVmTatmgMbge/4opNb3oc3JmNMF
         ypexOO3GGEbvEbG/oS+TJ3gQwM40q+8CL8mwWU5XAs4ACnOApXYhL9qVZoByuZ8P9O7W
         RrrysWjaw7tjvg0QTi+1Asn1vaGY8e3pkllMJC55gQazeyYs6sg4tLg+J6qcEufsQNjN
         N+u7w7oXVtPZPGKA4dfnv0ZyIE7sOo3JCcSDlq5yNJFId4ExHDOLkh2Fd4lgyRveSYnZ
         bfKUr0uhBv0XfKuWej+Y78XReaOfUYqAYtM8pITIRT5FjSoR1SRN0IzrEJwHLb1evUG7
         KDCg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788556911; x=1789161711; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mcFBRkoyCJV3OWGWia+2d7PyvSuekBz/hXo7rYDNODc=;
        b=sKRJY3/lhnv8jcFkW1DZ3hIWmcLEOe4WTIbMXtWqgV3ajNIRTr4jF8g9w2G0ZHTv8+
         r6+NW/HNR928X968YE4SYnSbwe6+Aj+xQ/b1LDbQf2CABruiP70yf/f36S3rruomplpO
         inGZcP6FRNKfPTRfwGKU9xvucdKNa264tH1o2xw+kg5BhGwVhp8TCyWKHr0kn/WQ77Vk
         8C+8ELIPn8kMeX7on2LUem3SHVWPq1577Ij6xcEouASQXHb77qhhQakZfrquzzjLEysL
         hXzcRQ33RJrAXlTF5bNwc0tp7AQ4kvYeJ6/2newX03Tx2TN7I52qGu1G4bvbK+figcGo
         +Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556911; x=1789161711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcFBRkoyCJV3OWGWia+2d7PyvSuekBz/hXo7rYDNODc=;
        b=jqEhnrRsXAVcjWGl/J2InnSM98x5LEKEMRAzHEG6x4uo2Adw3TCAT2fr6cVorIAXaq
         qJBLZgvmmoq9nFKbYy4uo6LMxu3Izx7l6i5puDrUii47Cdz35t3G8Km8D6VjtT0cu1mV
         TakoUCCnpLnMgRSxW8uSdot4RxNKuw4yROR8vajuYK1dk3PaFW3mM0dq/WVazg/SqOW5
         ep+yNAEQO8ddnuqNhaeNbWcWXwmjPAAZyluAJeCnjG83ucAMtCiCwRIwxJV3EZNnBjNA
         lRbrKgwBZimtVUgpzBC9TbckcrlCSLu9ihcdIDBwO0NYUChw95mqhLpyBIj4uSA7QFzz
         hXJA==
X-Forwarded-Encrypted: i=1; AKwUvBz1Fv6iufKvaGuTGppY/d1XtY7P+HeUTdk9bIaFrHLDqXQg3t/ky9NjF4uq2oHzeHdM9p/muQ==@lists.infradead.org
X-Gm-Message-State: AFuF++n4orRa2/HE+zdZAErN5zQmNCubMGX1iftLt/IwVv2yfgwf+jsS
	y3uJv8TlfJM1sD6I0V16EbdPTLJvTohamjkbkB7oPQohlERNUkJMNxzGKt5gHyj18gDI/M88V1c
	f0RN4TPulW1XApMgo+x3Epboa+D+S19ksHSSwKIEI
X-Gm-Gg: AYBFou3Nz/1Xa3CFAfK0fLs479bnHTgs+erFb74gQLjxDa+QUejcUItzEd1mLuf/QLw
	cqPfGRJkiH8orXQhfK2+p+zp1GazmG2F9AdUYqtzrevya2SyqAOOHpFrZ4EUZkDnZVWhgAGDt88
	pfT6+E4TwuSDZqNAnjFNfQqWeeyT25jBj5dXXI/Gi9Z8eU62Ez4/mMhg7MqmTEeAnev5LAafuof
	xci+OCbjQgwRmuuOtMYmNKHTZ3tA6wtEkJuQTqzkkgCIsmfU5QcSgAyWrRMQqgtIuHVX5khwVYP
	8N9m8UxwI50aJWAokB5FXaIOwPHTObNf6QnOk5CciPedNxjTh7qAhLbw
X-Received: by 2002:a17:907:3c8d:b0:c25:608d:7934 with SMTP id
 a640c23a62f3a-c260c9cb984mr394766666b.12.1788556910247; Fri, 04 Sep 2026
 14:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALzav=cE2AGXDAA4PCcohzqKwQNOZYEo4j33H6HxpMPX9Sdz0g@mail.gmail.com>
 <C6F5E157-B26C-496D-AF83-B6AA784BC74F@linux.dev>
In-Reply-To: <C6F5E157-B26C-496D-AF83-B6AA784BC74F@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Fri, 4 Sep 2026 14:21:22 -0700
X-Gm-Features: AcwNN1UvJYFaff65DcKkjf7iQwsvIxkK2pPJ3vcf2OlPfut7wgyhoPEhjQ-_Awg
Message-ID: <CALzav=d0++H70DjeNsRZezN9ySqz=-s63SiEPQbR1aFmcM10Nw@mail.gmail.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Dave Young <ruirui.yang@linux.dev>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_142154_288905_4900EAC6 
X-CRM114-Status: GOOD (  58.23  )
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

On Wed, Sep 2, 2026 at 6:02=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
>
> > On Sep 2, 2026, at 10:59=E2=80=AFAM, David Matlack <dmatlack@google.com=
> wrote:
> >
> > =EF=BB=BFOn Wed, Sep 2, 2026 at 2:18=E2=80=AFAM Pratyush Yadav <pratyus=
h@kernel.org> wrote:
> >>
> >> +Cc Roman because I am complaining about Sashiko ;-)
> >>
> >>> On Wed, Sep 02 2026, Baoquan He wrote:
> >>>
> >>> On 09/02/26 at 11:04am, Mike Rapoport wrote:
> >>>> Hi Baoquan,
> >>>>
> >>>> On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
> >>>>> On 09/02/26 at 07:34am, Mike Rapoport wrote:
> >>>>>> On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> >>>>>>> Hi kexec@ mailing list and maintainers,
> >>>>>>>
> >>>>>>> I would like to enable Sashiko code reviews for patches sent to t=
he
> >>>>>>> kexec mailing list. I have found it useful for patches I have sen=
t and
> >>>>>>> reviewed on the kvm and linux-pci mailing lists, which have Sashi=
ko
> >>>>>>> enabled.
> >>>>>>>
> >>>>>>> I sent a pull request to Sashiko to add kexec here:
> >>>>>>>
> >>>>>>>  https://github.com/sashiko-dev/sashiko/pull/474
> >>>>>>
> >>>>>> diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_pol=
icy.toml
> >>>>>> index e6e4fb57f..e9ad97708 100644
> >>>>>> --- a/sashiko.dev/email_policy.toml
> >>>>>> +++ b/sashiko.dev/email_policy.toml
> >>>>>> @@ -175,6 +175,12 @@ reply_to_author =3D false
> >>>>>> cc_individuals =3D false
> >>>>>> cc =3D ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kern=
el.org>", "Anna Schumaker <anna@kernel.org>"]
> >>>>>>
> >>>>>> +[subsystems.kexec]
> >>>>>> +lists =3D ["kexec@lists.infradead.org"]
> >>>>>> +reply_to_author =3D true
> >>>>>> +send_positive_review =3D true
> >>>>>>
> >>>>>> Do we really want those?
> >>>>>
> >>>>> Some components don't want to CC list, then other people are welcom=
e to
> >>>>> drop any comment during reviewing, while cc to maintainer and autho=
r
> >>>>> looks good to me. Just an input, no objection to any move.
> >>>>
> >>>> Sorry, I wasn't clear, I meant do we really want extra emails saying
> >>>> sashiko is happy?
> >>>
> >>> Oh, sorry. I misunderstood, I thought you had agreed to introduce
> >>> sashiko to part of list/author/maintainer or all.
> >>>
> >>> I think there are two different ways and they have different impact:
> >>>
> >>> 1) CC list (CC author and maintainer can be ignored beause all people
> >>> can see it)
> >>
> >> This is a side topic, but if we only Cc the list then Sashiko won't Cc
> >> the other people in the thread, like the usual "reply to all" every ma=
il
> >> clients does. It will _only_ Cc the list. See [0] for example.
> >>
> >> I don't think that is a good idea, because Sashiko might complain abou=
t
> >> something, and then the patch author can reply to the complaint. Peopl=
e
> >> who are not subscribed to the list will neither see Sashiko's complain=
t
> >> nor the author's response. So they lose a useful part of the patch
> >> review process.
> >>
> >> I am one of those people. I don't subscribe to any mailing lists and
> >> instead use lei [1] to fetch them. I treat my inbox as the primary
> >> stream of patches, and then glance at the lists every now and then. If=
 I
> >> get some patches in my inbox but then I don't get any of the follow-up=
s
> >> from the author to Sashiko, that's annoying. Sure, I might see them on
> >> the list later, but it is still annoying.
>
> It feels like there are two types of people: some know how to use email f=
ilters and some don=E2=80=99t.
> Unfortunately, the latter group is often very vocal about what they don=
=E2=80=99t want
> to see on mailing lists. I can easily see the problem with too much ai-ge=
nerated noise
> (and useful information as well), so no complaints from me, just saying t=
hat there is a reason
> sashiko is fairly conservative here.
>
> >>
> >> And of course, there might be patches that touch multiple subsystems a=
nd
> >> maintainers of that subsystem might not subscribe to or track kexec@ a=
t
> >> all. So they will entirely miss the conversation.
> >>
> >> If Sashiko is useful enough to send replies on the list, then I think =
it
> >> is useful enough to reply to everyone.
> >
> > It looks like this can be configured:
> >
> > - reply_all=3Dtrue will have Sashiko reply to everyone on the To/Cc lin=
e.
> > - cc_individuals=3Dtrue will have Sashiko include all inidividuals from=
 the
> >   To/Cc line of the original patch.
> >
> >>
> >> IIRC some people have complained in the past about automatically getti=
ng
> >> replies from Sashiko so maybe that is why this behaviour exists? Roman=
,
> >> is that correct? Is there any appetite yet to change that behaviour?
>
> Can you, please, describe, what behavior do you want?
>
> >>
> >> Or could we perhaps have an unsubscribe mechanism where people who don=
't
> >> want to see anything from Sashiko can unsubscribe themselves and Sashi=
ko
> >> will skip them when replying?
>
> This is the territory I don=E2=80=99t really want to go, honestly. Not a =
dealbreaker if there is a very strong
> reason to implement it, but I don=E2=80=99t think we have similar lists f=
or other tools like syzbot or the build verifier.
> I feel it=E2=80=99s more about the politics around ai then a real technic=
al reason (it=E2=80=99s like super trivial to drop emails from
> a specific sender), so I=E2=80=99d avoid this if possible.

I synced with Pratyush offline and we agreed adding
cc_individuals=3Dtrue is the best way to address his use-case.

I'm not hearing any other pushback on enabling Sashiko so I say let's
proceed with the updated PR and go from there.

>
> Thanks
>
> >>
> >> [0] https://lore.kernel.org/kvm/20260902072059.90ADC1F000E9@smtp.kerne=
l.org/
> >> [1] https://public-inbox.org/lei.txt
> >>
> >>>  This equals to cc author and push other reviewers away. And no
> >>>  reviewers will be patient and curious enough to check the sashiko
> >>>  report except of maintainers. Because maintainers need pick patch
> >>>  and may check if all reported issues are handled;
> >>>
> >>> 2) Cc maintainers when patch is cooked
> >>>  Maintainers tell patch author to check the report. Maybe CC patch
> >>>  author directly can save maintainers' effort.
> >>>
> >>> I personally think 2) is good. About whether introducing sashiko,
> >>> I would vote yes. I buy token by myself, sashiko would be a plus.
> >>
> >> FWIW, Sashiko already tracks the kexec@ list and you can see all the
> >> patches in the web interface [2]. So you don't need to burn your token=
s
> >> on reviewing kexec patches ;-)
> >>
> >> What David is proposing is to send those reviews to the list.
> >>
> >> [2] https://sashiko.dev/#/?list=3Dorg.infradead.lists.kexec
> >>
> >>>
> >>> Thanks
> >>> Baoquan
> >>
> >> --
> >> Regards,
> >> Pratyush Yadav

