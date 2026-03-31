Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A5E10F92FC
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 20:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/S10Yg5r6+ePkLPaA1Okih/qpU7AMuquFLu+r3+2gc=; b=wqcIA2aL+Qw7u2l8RdGng18fJ6
	nrwayxrWEd68z19XrUQjsSGSicaShJGS3OYxZXv5CR/fNncwueX58s4ndllgWKoGXuNCciNJ63e7m
	22L17E1jIBHZNVv8OLwQmBXom28vpucmCz7mspUACFiKYN5qe/3iEMWAXuIyGBfq2PUKq3ClpQcvw
	tAprZMhYXI0DZM7tJZLHOo9dDT8Ut2AX6y83/N85BnJ4HLRrEb0RQg5FQrm45wF1Qb0G4unpjuY+G
	BPudXlEPmL5ewTdftFOfUdBej9zu0TJLM+79IXF4R4NqEpmYIVDosdXQ3TxMv8GboCSsqqi4OD0dH
	4CpZJ9eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7fP2-0000000DVnL-03VU;
	Tue, 31 Mar 2026 20:09:32 +0000
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7fOz-0000000DVmz-18RS
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 20:09:30 +0000
Received: by mail-yx1-xb130.google.com with SMTP id 956f58d0204a3-650221149e2so4335697d50.0
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 13:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774987768; cv=none;
        d=google.com; s=arc-20240605;
        b=h4hrt4GiUKJXOvLGOtRbvr92USMvg1IcP1ezM7/aaSM4sEOiBsLQDgZBbru8/CawPj
         vqooFKgQdQ/3zNfIky8xjXEzWmpPsYFpmBkhWM0zyFeeDIVP2Go/uz8xkJMSki4cjRkr
         pyOzc5L86lxGnCOde/MqRlrw1KsZpfFBFpnAcKJPrM1UTaWmijk346BRvNivykNrUFH3
         G1+hJy2lkQZtK9Uy1X4o9sm9O41/A/WvtucdQs80ZhBmYd8tpOgfQtEEQKYOUyjs7Tff
         BwVn5tU3iXYnsQthbBkOd8pbpdUh5jVCL+12z1K5nQdNbUkDS7Iq1N4rxICz0MblpjNH
         v+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y/S10Yg5r6+ePkLPaA1Okih/qpU7AMuquFLu+r3+2gc=;
        fh=GANUD5BWosk9bK7F12KIXLdQusXpLCHe/533bgnHPZs=;
        b=S52h+9HkWSiEyw3wiQVwdQFMUawZiZy9ZhRJ2jpoB4Anv6eOqVULBnNFFMc26zBAmm
         yDezMjzDaC97pKwNwgenK53mUaWTCDU9Mdz57VqfdORfI/mz2CNh7mLtBg57cqDEA6lw
         pR1/22hULH3dz8WivjFhgjlmCZA9qe0Lhi0XGggGstnf1hrFcYdJKcJYezUcErI7fOW1
         DctVEAgFwzu+u6xUPVGapSRcMZF3lvFgJYiMdwn4Bdxu1cO0SCBmKNzbc3Rt8DCgUSMq
         iTKkoWXHMj0x6kjOO5WGpr49Vv92kN111/qjMS8vzG3F6KkkX1zPmAfX6QT154OuWYp8
         6dgg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774987768; x=1775592568; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/S10Yg5r6+ePkLPaA1Okih/qpU7AMuquFLu+r3+2gc=;
        b=E7ObfFJAm+H3syjlbu4reWehQi9rQmlBmqptEHn3MlODxoBYvjUa+Xow/8ZONMh+OX
         e2yPrUmzluWeGf1mxCXSFw/tkDqhUJJjsYkM36MSASreOHZR3IZw5ow9jX6H6ui2+8Lc
         QlaOc+dlijpfbsanTSskVO61rqkTqJefKapHETKxtRFFSaoyVUNkM26yML1+2mBs2V4g
         duUAk8m77WGiEEaHfGlZfCYGu7b/h6aQtFrnF+90FvJQHNMAP6Rfuo96d1cBKHBGxC//
         sFnXAh9BdQykWwc07GhWtI6x9ve1qRMl7QHuPzBeCJ11DVGJ4eKsK1Z6d2/BBCnr4t2o
         iH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987768; x=1775592568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/S10Yg5r6+ePkLPaA1Okih/qpU7AMuquFLu+r3+2gc=;
        b=WrwiSDh+BSYNM3YdbBNP96KAsGz6l2vDXtdDTYC3VWW7NO11qYzh3jgJTdnykaLKkR
         JNJN9XLOZNXST6Ld8BsrmvlgGdxbIURmIAErviS5CwKfdtg151OzhoisDJwWCibaLPQ7
         2yTZdpmrBFLfM4zPi3pOO9CrFsbjDSHxji1PtC49ziutMJMTEwP4kmrFw7DdDC2SsUD8
         A5uYIoGwIcQtEuTf0EfOFMvZfIMaUveuEafl/t3idJNNEc9KZ+rBpQcblo0FxytQf0iU
         Cic0xfSBOyTbJfXL3MOaS5dtVYyr4Brcwi+e1+tKhE3bS0vMT5PaVmdZgM1QBip0+nwe
         sa7w==
X-Gm-Message-State: AOJu0Yy1AunpKw+vZcPUqWJfNyfKkt5YMphPGr7G3kIt43I6BPlQeyHL
	Y2fr6Qi7bpr8RZGspzL76tyMTSLTlErdhkQAsRuk5W+WM5wXmttxGhZrSoAR3eXGj3JgoM1hhqV
	bLR7J+x+lnTCBRO4zvT6dZKo4uaTHTWI=
X-Gm-Gg: ATEYQzxEtqYqBxm3ZFpx1UtmlJHRxxYM1ya9UR5DURFLooy5QrPNLipn6pySB6H7p0H
	LeqQpW/d36HFEUC9FWq5GtJUoMV0ercrzzWE5MGUXM6WXPdfjQazUgXrilhq5LHjAGb+JwvGM31
	DgdsgSxNGHaG3F22LJVSSNz9Zn/sDMqzW0Akfnz8IWHJGs1BSthJl6vX/eGNBg0jMXGOa2jTjTd
	EpIaevxWd60kqU+yZMwdtLwuOElVU/DT8htaPIaEYW/zPVKm8U+4Uit4N4sW5jvEpAPtC+oZAzi
	k6kBHaz/NW3VnMDwTP95Bss35hl80ib+gu453SVmYQ==
X-Received: by 2002:a05:690e:1901:b0:650:2ff9:d660 with SMTP id
 956f58d0204a3-6502ff9d85dmr638722d50.1.1774987767715; Tue, 31 Mar 2026
 13:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175456.4065874-1-luca.boccassi@gmail.com>
 <CA+CK2bB0bMxW721Q+SzFJENe4X0_GwcOh83R-mm1V5dig3oP3A@mail.gmail.com>
 <CAMw=ZnQZm_k_mMQPmKwuBtkFyXXgAn9MK1NzmVbZst4nGu6xhw@mail.gmail.com>
 <CA+CK2bDL9=uNmy9hq=3D-w=MHYsY82FNCkqvNeNpnTnX6meYRA@mail.gmail.com>
 <CAMw=ZnRKEaWC0GiXWHpbiAchpZeBawOCoDgtq18B1UJsZpNN-w@mail.gmail.com> <CA+CK2bDSfOE2VardTc=QY2RyY0uv6yQu7ucn=5sWg17t78oMjw@mail.gmail.com>
In-Reply-To: <CA+CK2bDSfOE2VardTc=QY2RyY0uv6yQu7ucn=5sWg17t78oMjw@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 31 Mar 2026 21:09:16 +0100
X-Gm-Features: AQROBzBQ9Mc1C_QgnWw4AAOxRCJoiG1LZkbv24JzGWkrtj7pIANHvKTZSvghdTA
Message-ID: <CAMw=ZnQ++dDywZKCtv4k=9VDPHXWqPvuatrZa3JpKxN+X2C5ng@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: truncate getfile name to NAME_MAX
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_130929_501423_2EFEA379 
X-CRM114-Status: GOOD (  54.58  )
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

On Tue, 31 Mar 2026 at 20:58, Pasha Tatashin <pasha.tatashin@soleen.com> wr=
ote:
>
> On Tue, Mar 31, 2026 at 3:40=E2=80=AFPM Luca Boccassi <luca.boccassi@gmai=
l.com> wrote:
> >
> > On Tue, 31 Mar 2026 at 20:14, Pasha Tatashin <pasha.tatashin@soleen.com=
> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 2:30=E2=80=AFPM Luca Boccassi <luca.boccassi@=
gmail.com> wrote:
> > > >
> > > > On Tue, 31 Mar 2026, 19:21 Pasha Tatashin, <pasha.tatashin@soleen.c=
om> wrote:
> > > >>
> > > >> On Tue, Mar 31, 2026 at 1:55=E2=80=AFPM <luca.boccassi@gmail.com> =
wrote:
> > > >> >
> > > >> > From: Luca Boccassi <luca.boccassi@gmail.com>
> > > >> >
> > > >> > dynamic_dname() harcodes its limit to NAME_MAX bytes, which incl=
udes a
> > > >> > NUL terminator and a 'anon_inode:' prefix. If the name passed on=
 goes
> > > >> > above the limit it results in userspace getting a ENAMETOOLONG e=
rror.
> > > >> >
> > > >> > Truncate the name to NAME_MAX - 12 - 1 characters to ensure this=
 never
> > > >> > fails (accounting for prefix and NUL).
> > > >> >
> > > >> > Fixes: 0153094d03df ("liveupdate: luo_session: add sessions supp=
ort")
> > >
> > > Let's remove this, this patch is not fixing an existing issue, but a
> > > preparation for future uapi changes?
> >
> > The linked patch that increases the buffer to 255 is tagged with
> > 'fixes' so I don't mind, as that's enough to fix the -ENAMETOOLONG
> > error in currently released kernels. The original version of this set
> > the truncation to the current max buffer size, hence why I had the
> > fixes line.
> >
> > > >> >
> > > >> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > > >> > ---
> > > >> > Builds on top of this just sent by Aleksa:
> > > >> >
> > > >> > https://lore.kernel.org/linux-fsdevel/20260401-dynamic-dname-nam=
e_max-v1-1-8ca20ab2642e@amutable.com/
> > > >> >
> > > >> >  kernel/liveupdate/luo_session.c | 7 +++++--
> > > >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >> >
> > > >> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate=
/luo_session.c
> > > >> > index 7836772956406..4a40c7fdfb44f 100644
> > > >> > --- a/kernel/liveupdate/luo_session.c
> > > >> > +++ b/kernel/liveupdate/luo_session.c
> > > >> > @@ -366,11 +366,14 @@ static const struct file_operations luo_se=
ssion_fops =3D {
> > > >> >  /* Create a "struct file" for session */
> > > >> >  static int luo_session_getfile(struct luo_session *session, str=
uct file **filep)
> > > >> >  {
> > > >> > -       char name_buf[128];
> > > >> > +       char name_buf[NAME_MAX];
> > > >> >         struct file *file;
> > > >> >
> > > >> >         lockdep_assert_held(&session->mutex);
> > > >> > -       snprintf(name_buf, sizeof(name_buf), "[luo_session] %s",=
 session->name);
> > > >> > +       /* dynamic_dname() rejects names above NAME_MAX bytes, i=
ncluding NUL terminator
> > > >> > +        * and a 'anon_inode:' prefix. Truncate to NAME_MAX - 12=
 - 1 to avoid
> > > >> > +        * ENAMETOOLONG. */
> > > >> > +       snprintf(name_buf, NAME_MAX - 12 - 1, "[luo_session] %s"=
, session->name);
> > > >>
> > > >> I am confused by this change, the maximum session name length is: =
64,
> > > >> as defined in:
> > > >> include/uapi/linux/liveupdate.h
> > > >> /* The maximum length of session name including null termination *=
/
> > > >> #define LIVEUPDATE_SESSION_NAME_LENGTH 64
> > > >>
> > > >> So, 128 should be enough to include:
> > > >> "[luo_session] %s", session->name
> > > >>
> > > >> Or am I missing something?
> > > >>
> > > >> Pasha
> > > >
> > > >
> > > > Yeah we need to to bump that size, it's too small - see the shared =
doc. This is anyway needed for safety, as the user space call falls apart c=
ompletely if it goes over the hard coded limit,
> > >
> > > If there is a safety issue, it should be fixed (even without a limit
> > > bump), could you please explain it.
> >
> > Nothing specific, more from the abstract point of view - given that
> > this will fail with a hard error if it goes above the hardcoded limit,
> > it seems better to me to check it, rather than assuming it's going to
> > match, as that's error prone.
> >
> > > I looked at the shared doc [https://tinyurl.com/luoddesign under limi=
ts tab]:
> > >
> > > I see:
> > > TODO: this needs to be bumped, as for the varlink API we will impose =
a
> > > cgroup path prefix, which means PATH_MAX + "/" + client-supplied
> > > string.
> > >
> > > Why would we do that? Why can't we use a 63-byte unique identifier fo=
r
> > > sessions and an in-memory database that maps the cgroup path prefix t=
o
> > > session_ids, where the database also gets passed from one kernel to
> > > the other?
> >
> > Because that requires tracking state across all runtime, and that's a
> > no-go. The session itself needs to be identifiable by cgroup, so that
> > its owner is uniquely identified in all cases, in all situations,
> > regardless of any state or lack thereof.
> > The structs have a size as input, so it should be doable to follow the
> > usual process and keep it backward compatible.
>
> Overall, I am super happy to see LUO integrated as a first-class
> citizen with systemd, and I fully support this effort. My suggestion
> is that we step back and prepare a single patch series that performs
> all the necessary changes together, instead of sending a few random
> patches that do not make sense by themselves.

Yeah I don't mind, I noticed these two issues and fixed them as I was
going, so just thought of sending them as I verified they work.
Thankfully Aleksa's patch is enough to fix the ENAMETOOLONG issue and
should get into the released kernels too, so this can wait.

> As far as I can see, we should:
> 1. Increase the session name limit to include the data necessary for
> systemd fd store restore capabilities.
> 2. Make the number of stored sessions dynamic rather than having a
> hardcoded limit (I have a patch for this, which we can include in the
> series).
> 3. Add the necessary API to query back the incoming and outgoing session =
names.
>
> Is there anything else that you are aware that we would need to add?

Yeah also mentioned in the doc - we should bump the limit of FDs per
session, as for the fdstore I am using a single session for the whole
system, as we talked about two weeks ago. Apart from this I haven't
come across anything, but I just got the initial proof of concept to
work end to end this morning so haven't had a lot of time. Also the
per-client session is still in progress. If I find more requirements
I'll definitely bring them up ASAP.

