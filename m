Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D90C61DD6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aR6tUSKjEF7/JBVWyl2P7FkIEO8VNHl2TDvZxaecF/s=; b=wPmjdup+qqWL8j4tXY9iE9fW/g
	3zpR6/AQsdCJEWDBumZzsXC5zSYEcFIZtVICsGOMB2Z5yWOJ53NNMW+gqPJxo2yw5FuyCGY2smhIZ
	Mzhda7BtmDo4U6RqQVlPTmBqLmDcqG5xmU+e6sEEg1sRn1FPyO9SLmxj9uRw57M10fUCFHNr9k2D4
	nCykUR3bT6UvueTb9qs6r08oNry23Dy/yddfgpIwZrlJT5kFt1EW4XyfDakE27g8p6mqzrv+1+nnY
	hrKiZ30bJareV0CajBCbmCibiAWZqcvjk1QWaYbN3PlAcGElYvCrb4QbI/qfNdG/PIGWjYEyQRc4f
	M5WZohOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1pEm-0000000FWQa-3Ob6;
	Wed, 02 Sep 2026 17:59:04 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1pEi-0000000FWNS-1KrG
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 17:59:03 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c2530cabcf4so224532966b.0
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 10:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788371938; cv=none;
        d=google.com; s=arc-20260327;
        b=RuWF+RpO0XeHjyONr7kNKxmCRcMvtg91aDfiQO/TFf/7/MymyFMkdiqMrERzC8Re16
         yPEvevy8YOFFhLOVVQJvG0DXHkdEfR/FEppmJ1QfLthDZmuzr/f0ZKGZaVxqJ+iJrBvk
         B8qMgYDstyNLDlZVWiPE31C/n8SPBwfBO/ptTVXAd/wKUCTqzwzYmpbecmMbo7YYVLuH
         zOuCv8ydkHfYLVnXzJotLbQ0STXtOUnwRzdMC5o0Dcd15KBHD6/dZhnsbostXh/BUx7y
         9fQ2dAidq/n40jCvWpg4tDGWjSI6xpf9nScv38Bw1iGBijGbODhajiKrEUYpbqC6RypL
         kNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aR6tUSKjEF7/JBVWyl2P7FkIEO8VNHl2TDvZxaecF/s=;
        fh=07xlls52zBG6dkI1Y2CZ3A+waCJGLbslAp1sFb4aIpc=;
        b=bB2T2NeIuWzoD7qDet4/cPhvUTon+Bkqn+J8ogVu8o+v0NMAY1eV17tRSW1wdpanoF
         H6Hn3ofMwyB2An1w8hNnb773aHaYe5J5+LhJZxt9XjnIlYjcIDUO9mjfzxvbm31J3cV5
         P8CNSeg3zNSAamdOwyRQ7s2npxr/oSwdpphio6bsMYSOzUGI202KL1uNCzpH0/TTlvg7
         zTF6uutfyNTU3OShB9A3aB/dTbvw0hWXqYOfjKhIJnt5Btt8nTBsWRllaJK5tpWugEbf
         r0XNjOteWKHe5gNBwsG6tOFN5AK933PpATXjpOnm5/qTBcZO4ebbXm1WXxj4B1yXDfJh
         jLAg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788371938; x=1788976738; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aR6tUSKjEF7/JBVWyl2P7FkIEO8VNHl2TDvZxaecF/s=;
        b=hdRUryoTigpqDuRo3MglBtSvfuYOjhFnlSqKk9D7ukHhqZ9jauDW7a9ZaWXGH5vStS
         8TUFN0ilVJIBP82cwNeYma5IraGH24l4jxo3QolemDRF7abi6H1aCCgRNTpivLgUSnEc
         hfk7EU8tmUI2LDwKgtHhyQ6/CUbXz6bphsmqvfviQ/W207i4VWNQ//7c5eL34Rdg6d0W
         XelPE6s5gmjUMcLsKirvZAvRPJ1Q8oMH/9TqZgw5fd8zcNFHQXAV5XPfAaYjkT+T+5WM
         AQjUN2Lbkdp+aBOcCoTiQ0/IWeTe6lqPOXXLEnx0lONa6hLvtUvf0teg3YAus3uvuG/t
         UA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371938; x=1788976738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aR6tUSKjEF7/JBVWyl2P7FkIEO8VNHl2TDvZxaecF/s=;
        b=ByB7EEUt4GAOd0h+Gksj/LQvWyfO8HuuqJXKsKw5K/1qKGS7/CMubdarSaI12N1riG
         7CKGnUiOycTrnxd3WTCMIkKDUm0ROHIMDnm2XbRbp/sKALj33jNgd7Nr5Qo7Hl5hYqhe
         u8fJx1no4xCOa2/n/TR+LmhHZWMzVmTpvJmncPv3HlvF9AqIebucSfMkuLCMIngmi1Nn
         5LXPVq1D9tZ+6JuU56JB4YUAe8KIWmb9Mcmw/fNDHThBXQVg5jcJKCW/f3ad+IfBih7R
         4RrEbS3aLkqLc2mZXSph1uoVApB52sezPwmtQcGskbbuSX0SXy+6591cqE5fg7IPMH4l
         oqAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAn7SPaKGIQJug15NcEy+FEV+KVeQLRQaBH+//dalUsvAdGTcTbt45PfJwktxLO1uul4M6ng==@lists.infradead.org
X-Gm-Message-State: AFuF++mcYaOCneSw3jhksPY0HMBS521lqunPcug6d3n6yovg6JC1VyER
	owseMcZ7G44nsXbzb3IEAGEc2Ys0pWjC3c564tUfCvXv+xTtJ4+tLkgpnahplQAJntQW+iefAsl
	eAgPlVqYvXQ+r5wYZmBh2JtlalblIjeJN994bUAX5
X-Gm-Gg: AYBFou3PuTjv6x/ctnCm8BpIUQH8Vn+tNZ/29RAsZbt4iD++ZxHATXVh7uvAxk+D33O
	2lrotRO2pDD+ozbDI6ESxs15WKj8WdOCdaIawjEP8ik7zV16fiJYVu8NDZCrfDV6ggLIaK9fB8Q
	uY9eLaxBNH31cc7R5uoh1jXfQWjByt6j+DZ1yOAS78Mmssu3Rg2b7Q3yuhJ/PcmbCBXDJMqXDua
	Vz/NG/zjBNCNnSNn2iYZpLsLZdLZEucsR0/TUJdbMnJGEjlqeMFHrjIyL/XR/22W6HqzTnN6Jh0
	A/QAnsZAz37lXw7eyCGx8Sic7FrS3j4PDq71La7YGDmy9A==
X-Received: by 2002:a17:907:72c4:b0:c16:3074:657f with SMTP id
 a640c23a62f3a-c25d52b487bmr386936566b.9.1788371937608; Wed, 02 Sep 2026
 10:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
 <apenOdHJmH_VeD-X@kernel.org> <ape5s5tdwV6WwPih@fedora> <apfYhLD0sHt2odi8@kernel.org>
 <apfdhh0YYwo4am7A@fedora> <2vxzqzjcxb8r.fsf@kernel.org>
In-Reply-To: <2vxzqzjcxb8r.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 2 Sep 2026 10:58:29 -0700
X-Gm-Features: AcwNN1UuOv44xL9vMuNSoZmdDOtn5yCTuliGWAwyAN4y08Io6iZDQiK6ph6V1BA
Message-ID: <CALzav=cE2AGXDAA4PCcohzqKwQNOZYEo4j33H6HxpMPX9Sdz0g@mail.gmail.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Dave Young <ruirui.yang@linux.dev>, Alexander Graf <graf@amazon.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_105900_406175_82E51C8A 
X-CRM114-Status: GOOD (  54.97  )
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

On Wed, Sep 2, 2026 at 2:18=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> +Cc Roman because I am complaining about Sashiko ;-)
>
> On Wed, Sep 02 2026, Baoquan He wrote:
>
> > On 09/02/26 at 11:04am, Mike Rapoport wrote:
> >> Hi Baoquan,
> >>
> >> On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
> >> > On 09/02/26 at 07:34am, Mike Rapoport wrote:
> >> > > On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> >> > > > Hi kexec@ mailing list and maintainers,
> >> > > >
> >> > > > I would like to enable Sashiko code reviews for patches sent to =
the
> >> > > > kexec mailing list. I have found it useful for patches I have se=
nt and
> >> > > > reviewed on the kvm and linux-pci mailing lists, which have Sash=
iko
> >> > > > enabled.
> >> > > >
> >> > > > I sent a pull request to Sashiko to add kexec here:
> >> > > >
> >> > > >   https://github.com/sashiko-dev/sashiko/pull/474
> >> > >
> >> > > diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_pol=
icy.toml
> >> > > index e6e4fb57f..e9ad97708 100644
> >> > > --- a/sashiko.dev/email_policy.toml
> >> > > +++ b/sashiko.dev/email_policy.toml
> >> > > @@ -175,6 +175,12 @@ reply_to_author =3D false
> >> > >  cc_individuals =3D false
> >> > >  cc =3D ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@ker=
nel.org>", "Anna Schumaker <anna@kernel.org>"]
> >> > >
> >> > > +[subsystems.kexec]
> >> > > +lists =3D ["kexec@lists.infradead.org"]
> >> > > +reply_to_author =3D true
> >> > > +send_positive_review =3D true
> >> > >
> >> > > Do we really want those?
> >> >
> >> > Some components don't want to CC list, then other people are welcome=
 to
> >> > drop any comment during reviewing, while cc to maintainer and author
> >> > looks good to me. Just an input, no objection to any move.
> >>
> >> Sorry, I wasn't clear, I meant do we really want extra emails saying
> >> sashiko is happy?
> >
> > Oh, sorry. I misunderstood, I thought you had agreed to introduce
> > sashiko to part of list/author/maintainer or all.
> >
> > I think there are two different ways and they have different impact:
> >
> > 1) CC list (CC author and maintainer can be ignored beause all people
> > can see it)
>
> This is a side topic, but if we only Cc the list then Sashiko won't Cc
> the other people in the thread, like the usual "reply to all" every mail
> clients does. It will _only_ Cc the list. See [0] for example.
>
> I don't think that is a good idea, because Sashiko might complain about
> something, and then the patch author can reply to the complaint. People
> who are not subscribed to the list will neither see Sashiko's complaint
> nor the author's response. So they lose a useful part of the patch
> review process.
>
> I am one of those people. I don't subscribe to any mailing lists and
> instead use lei [1] to fetch them. I treat my inbox as the primary
> stream of patches, and then glance at the lists every now and then. If I
> get some patches in my inbox but then I don't get any of the follow-ups
> from the author to Sashiko, that's annoying. Sure, I might see them on
> the list later, but it is still annoying.
>
> And of course, there might be patches that touch multiple subsystems and
> maintainers of that subsystem might not subscribe to or track kexec@ at
> all. So they will entirely miss the conversation.
>
> If Sashiko is useful enough to send replies on the list, then I think it
> is useful enough to reply to everyone.

It looks like this can be configured:

 - reply_all=3Dtrue will have Sashiko reply to everyone on the To/Cc line.
 - cc_individuals=3Dtrue will have Sashiko include all inidividuals from th=
e
   To/Cc line of the original patch.

>
> IIRC some people have complained in the past about automatically getting
> replies from Sashiko so maybe that is why this behaviour exists? Roman,
> is that correct? Is there any appetite yet to change that behaviour?
>
> Or could we perhaps have an unsubscribe mechanism where people who don't
> want to see anything from Sashiko can unsubscribe themselves and Sashiko
> will skip them when replying?
>
> [0] https://lore.kernel.org/kvm/20260902072059.90ADC1F000E9@smtp.kernel.o=
rg/
> [1] https://public-inbox.org/lei.txt
>
> >   This equals to cc author and push other reviewers away. And no
> >   reviewers will be patient and curious enough to check the sashiko
> >   report except of maintainers. Because maintainers need pick patch
> >   and may check if all reported issues are handled;
> >
> > 2) Cc maintainers when patch is cooked
> >   Maintainers tell patch author to check the report. Maybe CC patch
> >   author directly can save maintainers' effort.
> >
> > I personally think 2) is good. About whether introducing sashiko,
> > I would vote yes. I buy token by myself, sashiko would be a plus.
>
> FWIW, Sashiko already tracks the kexec@ list and you can see all the
> patches in the web interface [2]. So you don't need to burn your tokens
> on reviewing kexec patches ;-)
>
> What David is proposing is to send those reviews to the list.
>
> [2] https://sashiko.dev/#/?list=3Dorg.infradead.lists.kexec
>
> >
> > Thanks
> > Baoquan
>
> --
> Regards,
> Pratyush Yadav

