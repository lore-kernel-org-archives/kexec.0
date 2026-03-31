Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EF010F92F2
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NrBqUb822UIvex6OIe+3K5fMDptrtW6BzFohhlrirV4=; b=xGRIX092pMMkfB2R/d4cBxDS9c
	jzxLd+PBvgx3eYjCG1K643YrbUJpVDOOd9TI8TQSwQp9KqK0CJviUB4+pk7xAM29IWKzuJpVaQWQC
	L7+NfF53P99IhthlVC+GbiKsn7/C6auBvRp8J5BrVM+KOlb+RcilMFsppboauE0VBbsTKvASW7jwN
	OU3OEEQKXRDthXt1+ua0QMioKsx1zinEbleBGsXjRUzoG0tILlFZma1MvvO51L90De2Woua+/0nPH
	hK3cAfwub76T6U8/6rfgG4Qe61EkMveuo44qQpx85tADinvaTcVqGgdnlL87LYOc51yC4b9gdoMZV
	+dsJ2/bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ewo-0000000DUDd-1SpW;
	Tue, 31 Mar 2026 19:40:22 +0000
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ewl-0000000DUDI-0tie
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 19:40:20 +0000
Received: by mail-yx1-xb135.google.com with SMTP id 956f58d0204a3-6501c0399c4so5007711d50.2
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 12:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986018; cv=none;
        d=google.com; s=arc-20240605;
        b=ExDRPc65uQoMnKpBNx1HZOsEaG4h7OWJSWNsx3b7RY3Ota9osgs/v4jDjL0SCHdeB1
         hv1w3rQKWu0RtoaaJ/94+DhkYVkvmK5vh6gA9KA5gxw9DzPAKic/+X7ki7mjEYYRtFCC
         ELq9QKNUkwN4OSEpa+9ZTJxo1oLgdY8gUysL1LAin1rHQmMNSosb9vK8M6mOTqyCcZCg
         u8kpotTbYdXHGmqe5s1ft/gdfw2Q3nwy2/5YGhq4P751DY3iDlZRqOYVqHOs9ngwC4Gi
         WgU9pXEpx4joXezHKP70QunniGn+MqCx1zTXjmjizqEz+cqe5PbEwdlrlBrgLLP79dld
         /ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NrBqUb822UIvex6OIe+3K5fMDptrtW6BzFohhlrirV4=;
        fh=GANUD5BWosk9bK7F12KIXLdQusXpLCHe/533bgnHPZs=;
        b=IstUtRj+mrmGWSe8HjfBscg2JOQe/WvZx3lE92i/6BlCroAkCSJhMOpElW04aoQIYb
         rYbx2iqG1MALtTfdWvbOwRtO0WJCTEG9rUasj4jBagGaVlbmSHSv2YYczQBWlgRHUQeg
         1bHcH9/OceioipHA1JfQDbM2SMLuB3b05B+O8sPDYZEIh42I9LSa5XMxDn7CsnEphORO
         r9LgRyeITAORzQNGza0pqa7Ml1Na5hwTu+la8F0xeNid7jM//rFEB6WKiJzc3FUZkoHn
         VlYFZ5Am7e22KT7y3bwgCxjBRc3+HSEJcjcIvSFAcW6hqmjN2Gm/mFug5uhRLMNUzO4v
         0Gsw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774986018; x=1775590818; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrBqUb822UIvex6OIe+3K5fMDptrtW6BzFohhlrirV4=;
        b=hlHhrcbUUhFjB5pz2QdTt0HP34JmvfYGnuaTENrzzYhVgh/A2faRVAlFn99uy9oVhr
         o4/bAu3FA3M6eUhnsYWpnx5F3QFv4hGw6P1vMPRGIR3TuH/P3bD6ayaSCFj6PeMEuy7H
         5Z2LLBVbhWWXp11QQ5mUtfGfalPprF0RWwDOOFScDxZcX1Uy6I961a0vkks3h1mkfIbK
         W31e1qZCV6Cskjzf3l+gjLb2FcVZk73jWdQuhpXdpFd8UpjS9b2NFRsjy/y97nQnapfx
         Oia3MWo+nte+TBwz+jWU536AmzqCFMlhooAENQ/zI6oM6KtNI1MYEh91iOQOI3MuE7xR
         FaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986018; x=1775590818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrBqUb822UIvex6OIe+3K5fMDptrtW6BzFohhlrirV4=;
        b=tEl+JVdJVJITFpl4XPqAhbS+Y8bNLrc811bMyOBeywoR70S6MwpKh0el9yJgr9cknb
         tO88xQzv7GtzcmJ2PhKXZs7yLZ0QHrnIDRQMC0PmVOW/xu1trGhrSIVMtV4XPJHEdU4E
         OwSAUnbTuOug/TxkbnZeBfIQXJC5gIECUn2TXHgfNcv+p0PviYNT2AfgfESlcakmemnx
         VxylvRPfO1/HpFN5to1NpGjKUmyzD38s2YaTY+0ynxDtkw5IXJRTYvbBKqLi/Q+33Ntk
         3YliCdSRwW6BAWN91hw+bAGcO5fTMQnUB07A0v+dgfNeQrJxKo4p267udixdflPanDtf
         esnA==
X-Gm-Message-State: AOJu0Yy9LrAZsWp19cBUzVLKfRTQVwdL0pnamYmEIF6GQLoaWne4BBNO
	vrGKjku3ggvcKSwRuFQOyv/eruj9QHsUw7/JtmTS/lffNACaYbyz0wa6c3kc6KOd4cNrdd1iUAs
	yA4RP21W0s4unLD4uEnjhmxTsKYpBuv3DXg==
X-Gm-Gg: ATEYQzwezXOvchJkGhZ+EA4I+T9+G2gLb8MLS2iX8oV8+VRXZaG0FrLIYl8sCKOTppm
	TjECG13yb7cpnObifs84tS3d0Tjf6VTlNq3PnviaOUQFhAKkin5bx17i5Etlo9VSu5/176ePxSl
	9PRV821iri78KuZhJN0dbUfc9Ve8UQem1IdPnpCk7zCm7sX3bvXRc/Na6ACdrui/pR9KLC+bzI7
	OqteDPJAvIf6oBKzu94A31FJfJH7zCUAs1rWPhScio7DgjXJM0JmAwfKsdBflsFp9gchcvNVH6G
	lWeu7Nlcx8rmg3KObavm4BuxFIp84qUfkSnQg53C6A==
X-Received: by 2002:a53:be51:0:b0:650:19b1:751c with SMTP id
 956f58d0204a3-6502fe65217mr459746d50.53.1774986017941; Tue, 31 Mar 2026
 12:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175456.4065874-1-luca.boccassi@gmail.com>
 <CA+CK2bB0bMxW721Q+SzFJENe4X0_GwcOh83R-mm1V5dig3oP3A@mail.gmail.com>
 <CAMw=ZnQZm_k_mMQPmKwuBtkFyXXgAn9MK1NzmVbZst4nGu6xhw@mail.gmail.com> <CA+CK2bDL9=uNmy9hq=3D-w=MHYsY82FNCkqvNeNpnTnX6meYRA@mail.gmail.com>
In-Reply-To: <CA+CK2bDL9=uNmy9hq=3D-w=MHYsY82FNCkqvNeNpnTnX6meYRA@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 31 Mar 2026 20:40:07 +0100
X-Gm-Features: AQROBzA80Z5vv8p1B8O-wR4-lNM3XMfZwPtBcQ1uf2wGh6dYtIhVFfM-a8O-V2Q
Message-ID: <CAMw=ZnRKEaWC0GiXWHpbiAchpZeBawOCoDgtq18B1UJsZpNN-w@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: truncate getfile name to NAME_MAX
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_124019_292200_BFC4D377 
X-CRM114-Status: GOOD (  37.46  )
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

On Tue, 31 Mar 2026 at 20:14, Pasha Tatashin <pasha.tatashin@soleen.com> wr=
ote:
>
> On Tue, Mar 31, 2026 at 2:30=E2=80=AFPM Luca Boccassi <luca.boccassi@gmai=
l.com> wrote:
> >
> > On Tue, 31 Mar 2026, 19:21 Pasha Tatashin, <pasha.tatashin@soleen.com> =
wrote:
> >>
> >> On Tue, Mar 31, 2026 at 1:55=E2=80=AFPM <luca.boccassi@gmail.com> wrot=
e:
> >> >
> >> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >> >
> >> > dynamic_dname() harcodes its limit to NAME_MAX bytes, which includes=
 a
> >> > NUL terminator and a 'anon_inode:' prefix. If the name passed on goe=
s
> >> > above the limit it results in userspace getting a ENAMETOOLONG error=
.
> >> >
> >> > Truncate the name to NAME_MAX - 12 - 1 characters to ensure this nev=
er
> >> > fails (accounting for prefix and NUL).
> >> >
> >> > Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support"=
)
>
> Let's remove this, this patch is not fixing an existing issue, but a
> preparation for future uapi changes?

The linked patch that increases the buffer to 255 is tagged with
'fixes' so I don't mind, as that's enough to fix the -ENAMETOOLONG
error in currently released kernels. The original version of this set
the truncation to the current max buffer size, hence why I had the
fixes line.

> >> >
> >> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> >> > ---
> >> > Builds on top of this just sent by Aleksa:
> >> >
> >> > https://lore.kernel.org/linux-fsdevel/20260401-dynamic-dname-name_ma=
x-v1-1-8ca20ab2642e@amutable.com/
> >> >
> >> >  kernel/liveupdate/luo_session.c | 7 +++++--
> >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo=
_session.c
> >> > index 7836772956406..4a40c7fdfb44f 100644
> >> > --- a/kernel/liveupdate/luo_session.c
> >> > +++ b/kernel/liveupdate/luo_session.c
> >> > @@ -366,11 +366,14 @@ static const struct file_operations luo_sessio=
n_fops =3D {
> >> >  /* Create a "struct file" for session */
> >> >  static int luo_session_getfile(struct luo_session *session, struct =
file **filep)
> >> >  {
> >> > -       char name_buf[128];
> >> > +       char name_buf[NAME_MAX];
> >> >         struct file *file;
> >> >
> >> >         lockdep_assert_held(&session->mutex);
> >> > -       snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", ses=
sion->name);
> >> > +       /* dynamic_dname() rejects names above NAME_MAX bytes, inclu=
ding NUL terminator
> >> > +        * and a 'anon_inode:' prefix. Truncate to NAME_MAX - 12 - 1=
 to avoid
> >> > +        * ENAMETOOLONG. */
> >> > +       snprintf(name_buf, NAME_MAX - 12 - 1, "[luo_session] %s", se=
ssion->name);
> >>
> >> I am confused by this change, the maximum session name length is: 64,
> >> as defined in:
> >> include/uapi/linux/liveupdate.h
> >> /* The maximum length of session name including null termination */
> >> #define LIVEUPDATE_SESSION_NAME_LENGTH 64
> >>
> >> So, 128 should be enough to include:
> >> "[luo_session] %s", session->name
> >>
> >> Or am I missing something?
> >>
> >> Pasha
> >
> >
> > Yeah we need to to bump that size, it's too small - see the shared doc.=
 This is anyway needed for safety, as the user space call falls apart compl=
etely if it goes over the hard coded limit,
>
> If there is a safety issue, it should be fixed (even without a limit
> bump), could you please explain it.

Nothing specific, more from the abstract point of view - given that
this will fail with a hard error if it goes above the hardcoded limit,
it seems better to me to check it, rather than assuming it's going to
match, as that's error prone.

> I looked at the shared doc [https://tinyurl.com/luoddesign under limits t=
ab]:
>
> I see:
> TODO: this needs to be bumped, as for the varlink API we will impose a
> cgroup path prefix, which means PATH_MAX + "/" + client-supplied
> string.
>
> Why would we do that? Why can't we use a 63-byte unique identifier for
> sessions and an in-memory database that maps the cgroup path prefix to
> session_ids, where the database also gets passed from one kernel to
> the other?

Because that requires tracking state across all runtime, and that's a
no-go. The session itself needs to be identifiable by cgroup, so that
its owner is uniquely identified in all cases, in all situations,
regardless of any state or lack thereof.
The structs have a size as input, so it should be doable to follow the
usual process and keep it backward compatible.

