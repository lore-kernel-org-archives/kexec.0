Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C057B10F92FA
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CvbjGMrw6sSXQtTsWR0wzJ0JMKxByG9x973fvHacnEc=; b=VHfNsVENaTy9yjCsmFQRnqIqMU
	4ElboMZCUT49H/jV4si0k6dDOklx8Ihze0tjKzWUDgDQcCqlQX42zb2eX8paH5JnbSyInPs1spLg0
	GROUDcHHbSqV6QBSqiFr8rpOpHSdE4bpBpAljQLxLKyYJEKsA1hCuGMl56DOlyn2EIyIqe91jJToS
	PNGAZB4n6gSefrzDGGNi0hYdYaoF35VEKMdjQzAcKy5cJBE6/FuOgtEm11goUa3FCQSFYfXzE5Zp1
	yor9+GhvMkS8eqmkbKpYkx45Pmt54YKxSbo6NsFXPxykEp3t35sMqh3QdxobA2FTDU75WqX3ZAgVK
	DqZblg/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7fEM-0000000DVQm-2dv4;
	Tue, 31 Mar 2026 19:58:30 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7fEI-0000000DVQJ-36IV
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 19:58:27 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-66b2f6e983bso7631621a12.0
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 12:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774987105; cv=none;
        d=google.com; s=arc-20240605;
        b=XJkXQS3BQe5afRSFG2QKH8mEYgXMVg9IEk9H15lXyXaRFSybCSaYaYPlsZNCc+MvBs
         xM/3+8NE+fcUZJzfgCxyQK+uYgGfI9M4+AWuiP25z/VYw5bYSpJB39bavKTO12IOPyfV
         VgOTkXNatjVKayaKCtGRk1HUEUVxIoN1t4GB40kVUxeDMwB8MU/Orwae/GjxXE5a6nG1
         Xg4XMJ0CFDuSJfMtaSTt/GHiCRnOxq3eB+7DB9sjVG0fnII4f9oBUqomXW+zJwVQmf6/
         KnBG/Vbzd5zaCpskqaeHzwQdHnR3wW7TY4VE54pEVBjimjARgEcQ7d98bXrg4t0Fan7e
         m1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CvbjGMrw6sSXQtTsWR0wzJ0JMKxByG9x973fvHacnEc=;
        fh=EPE7UXMVpQ0aMGhqMSJOVUIHdBHtQTCp5NYO0Bnljk8=;
        b=I5eHSgWucPPGwc22ZY1eaHO3l7kF//fCaZCAwEH0cOKbJM5QsH6UMyzYQ4vXf7w6uf
         1eHMugHk4d9ERuSCAA8J1F0/RfWN5VBl6jNuj1SNHMNq2IqboimDpRCUu8N37JvEOM5V
         ZoaC4Ug+8LVHeJqkbiJsCVl928/bxY3NjqAmeSFn2Cb1FGRb5oGuxqOeG4vaiun8c6kE
         ViBZv/3DRXjqM7oa7Z8VYVc75MAgYsM2nFWNvBlZA0GZumdqtG6hs9zCrrmpe8CA/9/Y
         /qIYyK6+eV19tC2/HaX4ECbqSu/VyuLNk0dvCA3QUIgFTacuafooc/cSsZzerg3x7uNT
         Seeg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774987105; x=1775591905; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvbjGMrw6sSXQtTsWR0wzJ0JMKxByG9x973fvHacnEc=;
        b=X/9sDVMWxDWPHL2YIt3UY3b2nytz0IbES7Vz2YqudAO+TNhVpx2vv94w9tNcdTQeI/
         06tMx/0wm6I9QlvBNtt+X18G4b9g4YUXW+TIFZl8r1L5SHgW7VsFrXsY1NeXyZfO2emH
         AV1JOSu5BKj9riDiTVxCePjwRkQotEPtmtp2eQWraDzXBV1t1oQRP/SinwPffF9duRwd
         3gLRu7OoBoFOctTDyTDl+ybHrKzYwfFjv3otv9dcs3j6NngrO1nlfZ5LTnoV9mPcl6l0
         tnnSYRNykfsP4zNDzCLr/6thK/XS6FU9+BvgQrAtN7JAsdJAog855eWlxi8d3MhuV68H
         rH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987105; x=1775591905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CvbjGMrw6sSXQtTsWR0wzJ0JMKxByG9x973fvHacnEc=;
        b=D/6Nv/dir+3gedRGdPS6xWKHttYSq7FhVeIEgbJezheTUpvy8pk8Zv1hiPpQBGV+JL
         /mO/iC5OTvGSdD0qKmrKpfO0RskDjlO97jRoyGEsty0esq/f9IvsJ7GpljQtf+qZBjqh
         qOa6tiJu8ro7v3Peg9ak0G27hmm7NAg7pA4M6lkZd4VtwdknIoAx1Gu9uZAVF7CAYn5F
         9PHO/hXcOEFvRIlvMuy2mo2Ce+M4VLptLcPVYWi6efo56/Wh0nXnHIV2+Lbik5ZqCBNn
         hrmRWHt5WgWgGhP6pPDWxeWsuxvee3fQgq5fNftUr4U4QPRRbh/egiSyeP94VuDpyILX
         1x9Q==
X-Gm-Message-State: AOJu0YxTHZDxXkSLw8HL7WifBWu6R+wfn4sOhi5GwKv+5yRJJW183OFi
	5+TBFKENJtf1osIfd0/rb9Fz94UtRHaWeX8kYlulk32OZp+iOqCyXhs2j+bzg585CyiQXNYql1M
	wUPVrSLlKVRdkeCT/IVANgB0c7bv6Crd7rV3nmlEoYw==
X-Gm-Gg: ATEYQzz3545IHFDojSTBiulGnoRNPqoURkl9gHhKVb/vlNuCO0v2YQ+IlqLK5rHLMDo
	StCQceRIAN39/gmcrC3CuJA2qIuLnGE+/dDVEf8X/6nLCMX6s7R+omlSE9JRN3lM7WdZYZiL0SM
	o4kKAb/SAfADvxs/r2mUR0lgSArKONqEQTeCewD5n5glUw2QjQlEzd6nr0lCtHOpPUyYsjCSaP2
	ZyyQhVHTIDcZirjdfGpNh++T5cf3fsuGOSbWnyZddlt/DXNVktJBpdDYDMrxi1z7/2EAQC47gIs
	/IZmgHdABZPVQLyaew/0k47/bDzi3WQDz1jyTQ==
X-Received: by 2002:a05:6402:1286:b0:66d:d07c:a8ea with SMTP id
 4fb4d7f45d1cf-66dd07caa9amr52754a12.7.1774987104740; Tue, 31 Mar 2026
 12:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175456.4065874-1-luca.boccassi@gmail.com>
 <CA+CK2bB0bMxW721Q+SzFJENe4X0_GwcOh83R-mm1V5dig3oP3A@mail.gmail.com>
 <CAMw=ZnQZm_k_mMQPmKwuBtkFyXXgAn9MK1NzmVbZst4nGu6xhw@mail.gmail.com>
 <CA+CK2bDL9=uNmy9hq=3D-w=MHYsY82FNCkqvNeNpnTnX6meYRA@mail.gmail.com> <CAMw=ZnRKEaWC0GiXWHpbiAchpZeBawOCoDgtq18B1UJsZpNN-w@mail.gmail.com>
In-Reply-To: <CAMw=ZnRKEaWC0GiXWHpbiAchpZeBawOCoDgtq18B1UJsZpNN-w@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 31 Mar 2026 15:57:47 -0400
X-Gm-Features: AQROBzD0oAOC_h1ZImCURxvI7CwZiGV3FDojPlJTfAKD12_kRIP0nvfRHxNVwpY
Message-ID: <CA+CK2bDSfOE2VardTc=QY2RyY0uv6yQu7ucn=5sWg17t78oMjw@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: truncate getfile name to NAME_MAX
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_125826_816253_84EAAFFD 
X-CRM114-Status: GOOD (  45.43  )
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

On Tue, Mar 31, 2026 at 3:40=E2=80=AFPM Luca Boccassi <luca.boccassi@gmail.=
com> wrote:
>
> On Tue, 31 Mar 2026 at 20:14, Pasha Tatashin <pasha.tatashin@soleen.com> =
wrote:
> >
> > On Tue, Mar 31, 2026 at 2:30=E2=80=AFPM Luca Boccassi <luca.boccassi@gm=
ail.com> wrote:
> > >
> > > On Tue, 31 Mar 2026, 19:21 Pasha Tatashin, <pasha.tatashin@soleen.com=
> wrote:
> > >>
> > >> On Tue, Mar 31, 2026 at 1:55=E2=80=AFPM <luca.boccassi@gmail.com> wr=
ote:
> > >> >
> > >> > From: Luca Boccassi <luca.boccassi@gmail.com>
> > >> >
> > >> > dynamic_dname() harcodes its limit to NAME_MAX bytes, which includ=
es a
> > >> > NUL terminator and a 'anon_inode:' prefix. If the name passed on g=
oes
> > >> > above the limit it results in userspace getting a ENAMETOOLONG err=
or.
> > >> >
> > >> > Truncate the name to NAME_MAX - 12 - 1 characters to ensure this n=
ever
> > >> > fails (accounting for prefix and NUL).
> > >> >
> > >> > Fixes: 0153094d03df ("liveupdate: luo_session: add sessions suppor=
t")
> >
> > Let's remove this, this patch is not fixing an existing issue, but a
> > preparation for future uapi changes?
>
> The linked patch that increases the buffer to 255 is tagged with
> 'fixes' so I don't mind, as that's enough to fix the -ENAMETOOLONG
> error in currently released kernels. The original version of this set
> the truncation to the current max buffer size, hence why I had the
> fixes line.
>
> > >> >
> > >> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > >> > ---
> > >> > Builds on top of this just sent by Aleksa:
> > >> >
> > >> > https://lore.kernel.org/linux-fsdevel/20260401-dynamic-dname-name_=
max-v1-1-8ca20ab2642e@amutable.com/
> > >> >
> > >> >  kernel/liveupdate/luo_session.c | 7 +++++--
> > >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/l=
uo_session.c
> > >> > index 7836772956406..4a40c7fdfb44f 100644
> > >> > --- a/kernel/liveupdate/luo_session.c
> > >> > +++ b/kernel/liveupdate/luo_session.c
> > >> > @@ -366,11 +366,14 @@ static const struct file_operations luo_sess=
ion_fops =3D {
> > >> >  /* Create a "struct file" for session */
> > >> >  static int luo_session_getfile(struct luo_session *session, struc=
t file **filep)
> > >> >  {
> > >> > -       char name_buf[128];
> > >> > +       char name_buf[NAME_MAX];
> > >> >         struct file *file;
> > >> >
> > >> >         lockdep_assert_held(&session->mutex);
> > >> > -       snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", s=
ession->name);
> > >> > +       /* dynamic_dname() rejects names above NAME_MAX bytes, inc=
luding NUL terminator
> > >> > +        * and a 'anon_inode:' prefix. Truncate to NAME_MAX - 12 -=
 1 to avoid
> > >> > +        * ENAMETOOLONG. */
> > >> > +       snprintf(name_buf, NAME_MAX - 12 - 1, "[luo_session] %s", =
session->name);
> > >>
> > >> I am confused by this change, the maximum session name length is: 64=
,
> > >> as defined in:
> > >> include/uapi/linux/liveupdate.h
> > >> /* The maximum length of session name including null termination */
> > >> #define LIVEUPDATE_SESSION_NAME_LENGTH 64
> > >>
> > >> So, 128 should be enough to include:
> > >> "[luo_session] %s", session->name
> > >>
> > >> Or am I missing something?
> > >>
> > >> Pasha
> > >
> > >
> > > Yeah we need to to bump that size, it's too small - see the shared do=
c. This is anyway needed for safety, as the user space call falls apart com=
pletely if it goes over the hard coded limit,
> >
> > If there is a safety issue, it should be fixed (even without a limit
> > bump), could you please explain it.
>
> Nothing specific, more from the abstract point of view - given that
> this will fail with a hard error if it goes above the hardcoded limit,
> it seems better to me to check it, rather than assuming it's going to
> match, as that's error prone.
>
> > I looked at the shared doc [https://tinyurl.com/luoddesign under limits=
 tab]:
> >
> > I see:
> > TODO: this needs to be bumped, as for the varlink API we will impose a
> > cgroup path prefix, which means PATH_MAX + "/" + client-supplied
> > string.
> >
> > Why would we do that? Why can't we use a 63-byte unique identifier for
> > sessions and an in-memory database that maps the cgroup path prefix to
> > session_ids, where the database also gets passed from one kernel to
> > the other?
>
> Because that requires tracking state across all runtime, and that's a
> no-go. The session itself needs to be identifiable by cgroup, so that
> its owner is uniquely identified in all cases, in all situations,
> regardless of any state or lack thereof.
> The structs have a size as input, so it should be doable to follow the
> usual process and keep it backward compatible.

Overall, I am super happy to see LUO integrated as a first-class
citizen with systemd, and I fully support this effort. My suggestion
is that we step back and prepare a single patch series that performs
all the necessary changes together, instead of sending a few random
patches that do not make sense by themselves.

As far as I can see, we should:
1. Increase the session name limit to include the data necessary for
systemd fd store restore capabilities.
2. Make the number of stored sessions dynamic rather than having a
hardcoded limit (I have a patch for this, which we can include in the
series).
3. Add the necessary API to query back the incoming and outgoing session na=
mes.

Is there anything else that you are aware that we would need to add?

Thank you,
Pasha

