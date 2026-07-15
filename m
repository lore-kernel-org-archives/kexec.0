Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D14C44501
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H12olXVq3F1RAP6MWw5onyOkfq0/I6cz4mvSnYOiLBA=; b=b8SmeVp68Y8s8cRgA1EFPoTXx+
	XzATM6i5rleAqctm7UBzoyzu3nP8Kf3iZ/xDa8F36nuFF5Hcy0fHyBJXuJuh7+KRT99ybyV+KeHHk
	TYWdDeYAtbvbnxXpLE9LgSoOubPR4LQEcFm8N/zuAyl9ZtCyUrCGDaQVlikZ9EOO8EfoHWlMOavsI
	vwBuF4zidMgv4wYUkC0D8GH7arkbVqFonNtlgwza+4aatJaT20qM8Qx1ZPuWyaIyB6CrPM6vXuq2T
	WYB/7v5Kk5foGMDcUweOptDB9HdQwEdEATeTMsoNF4ORF/AYOVVsm2tehSSnBeaDN5h6P58k6Ji5K
	Z5t35BVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk291-0000000FPNh-23Lo;
	Wed, 15 Jul 2026 16:07:35 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk28z-0000000FPNB-0jXK
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 16:07:34 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ced3386430so21670275ad.1
        for <kexec@lists.infradead.org>; Wed, 15 Jul 2026 09:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784131651; cv=none;
        d=google.com; s=arc-20260327;
        b=F0CAYSoFD6triuk1JXpxeRKb1HRThOCExUegbSYyZNMUbyUb3PCjut6ue0n4T4Ngye
         8QxLDcC9GIFfGjikmIKrmhNquceLNFqJt6SoDWMF0HZlWnYTfSuu4PdDYtXD3p/YmX3q
         4wRa0ea4n3Me/Jku15b0Dl5i6aNIRiwZ5SuzSou1HnogvUqWSGeIPoqkorytSFAFLqBl
         OYFXADKPCw1PBDd6pGFy4RpMeu+GPRmqc/47QASNzUFrYeUsWqsuVx0eEuBgBbn6TE+X
         uqXsIFfklHZ1MBBshF3vUCxb4Xg3NEFBR2CNO/sW/DaqN6JzEWtnl4CcZ+zAxrAWPB9w
         XO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H12olXVq3F1RAP6MWw5onyOkfq0/I6cz4mvSnYOiLBA=;
        fh=W6WNy08gPPxYRTXc2LgwBkSVp51eIsUvK97fkaXqq5c=;
        b=TPYi/f5EFM//JJLvZ6YCQlYzSqHQafruGRWBrUdws5HnbFt7i1ESkYZpQ/X7MDk9PY
         IYPwJads5uOwff58U6pZ8RsAz9yzjlAtL68NDXVizrvlEJcj0OPoASewFNQcOes7HljZ
         k1QlNmKP7BZy9urOVVjElUfuiI1KIjOvUYLwbvnda2spLBrIZqo74C5+6V0G/bLp57+V
         Q3gtoQYselON5gz7TYWFTholLZ7DW2aNZNe5Chta6lWErQz6Axice357xLfr+PzQ82tL
         G7V0XE7pGraPGhC+m/oJH6h8TV39TFIqIkQfKcO3UrHK2T+KLLVlKtDGac69EY1Aqkcm
         AD7g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784131651; x=1784736451; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H12olXVq3F1RAP6MWw5onyOkfq0/I6cz4mvSnYOiLBA=;
        b=PAFDQF00vV1PG7CATarD9O9+si00VAL2ASiiokk/aa2s+gCoPMg0IYPvLdMrxSN45S
         ABvJrIUOSOrNmI98U7EnR/D0DwXWPUcHjjDuERV0DSji9CMccsGdnPcgdzt1k9CZ7KUV
         Mh1sOEUScFtIHt2MfFSBfyCP9X18OlJqWgRMUaj8qQdiO11cQ97j7vr5pWmfxWhRDHzz
         U/ffoxdyazEcLomodrCeMSn3jYtKsCzFl18DFyqRddQqW6gbdBCSlz/l5H9alKxlVc3t
         GJPFFpz9Hz+jnLdkEkOc8v0erEy6wdg8KSNSl1VcbgFu5CLapRUPMPeH3tC7Znt4u3ZN
         XE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131651; x=1784736451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H12olXVq3F1RAP6MWw5onyOkfq0/I6cz4mvSnYOiLBA=;
        b=kcfJStBYu8WgR22du4N2JtlcyBq77Nkf1bc4kJ49KXnzNfLS3dlMKKPZ9GJA/gxafi
         HzJpA0bRM5oges1hjk7fECh/6MOLtpYzx7fkwQekLB3alQMsyeezp/1n/0nHg2batlBP
         Qpin0sTW5n29hDV5ERXuebbP1biGflhGRomjL+oqd+2nUlBvzD6jRM++Vzjsu2i+sDKb
         qH1xE1JswFBD8GvBaMQ84MSPYqhuDo6EVlozHJNZ2azp3ir/0aa3Q+iSbODGr3x9LLH7
         l7/lRkfWD3rmsR6++Vop8JbwvIzF5xnBc0FgJV9RKo6gq+ATNYKolRIKhUXfPtlrYUdH
         1Ihg==
X-Gm-Message-State: AOJu0YxDTOKtq9+EaXWOtJLCsBAW2gSs/Flrig9ApTHK1xKM23flJWk6
	14DnAkdU28i3Wrs4+zUokS3FPnALnPBLx7jIUS7dfwVXVkIJvFcBA0/yucSHtgtR2R2Tu/cZOaK
	Z1nzs62xwDV5Pg5hcj11psplQboUsEG4HW3ickGhu
X-Gm-Gg: AfdE7ckbQCfRPOSJQ7yp5Yt09BOPbqoxrD+t9E++AA+NyEWO2vsavtTXgeLqb0gmvv5
	JTu0OVhE+I/8uoHOWTT6TjlTeavGs3zbJvqEd+HptTGoFOZ9XsPjmWxnMvplKLPXl/e2JpxZGKW
	AEvM0aU3nmw4NeRav0zalkYmTNFOyjh/5RMgwziif5JecJJfCWWe1ZhSNeTBLZfthjjcd4rA7JB
	Z+TVryJSPJAnH1R0r25TZ/8mM7v5g76rjmTWxHhE9HxfKHJn3t0WChnj9+sSDvHGVaRywdX
X-Received: by 2002:a05:6a21:3988:b0:3c3:821e:1f84 with SMTP id
 adf61e73a8af0-3c3821e43ecmr718389637.41.1784131651046; Wed, 15 Jul 2026
 09:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260714190356.190328-1-dmatlack@google.com> <2vxzy0fcicpi.fsf@kernel.org>
In-Reply-To: <2vxzy0fcicpi.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 15 Jul 2026 09:07:03 -0700
X-Gm-Features: AUfX_mwWLIIwIbCORwPju6JjaZTyqkA_jPyoKhqBFYSqQTZxJQormdY_HQIDbQg
Message-ID: <CALzav=ev6KVOM_BckL5poGaGOHfWFMn6=tajeph2GwcN8xTY6g@mail.gmail.com>
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for /dev/liveupdate
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_090733_221329_981215E2 
X-CRM114-Status: GOOD (  35.67  )
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

On Wed, Jul 15, 2026 at 6:50=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi David,
>
> On Tue, Jul 14 2026, David Matlack wrote:
>
> > Remove the single-opener restriction for /dev/liveupdate by removing th=
e
> > atomic in_use tracking and the exclusive open check in luo_open() that
> > returned -EBUSY. Protect luo_session_deserialize() with a mutex guard s=
o
> > that concurrent open attempts by multiple processes safely executes
> > deserialization only once. Update liveupdate selftest to verify that
> > multiple concurrent openers succeed.
> >
> > LUO does not inherently require a single opener. There is some
> > documentation about it simplifying state management, but the only thing
> > it actually protects is the session deserialization during first open,
> > which can be easily handled with a mutex.
> >
> > Relaxing the single-opener requirement avoids the kernel forcing a
> > design pattern on userspace that it itself does not require, e.g.
> > allowing multiple userspace processes to create and manage sessions.
>
> Agreed. When the kernel had a global state machine in the early versions
> of LUO, this might have been more relevant. With sessions, even if we
> later add a state machine, it likely will be per-session instead of
> being global. So I think letting userspace open /dev/liveupdate multiple
> times makes a lot of sense.
>
> Also, today's systemd only supports preserving individual files, and
> does not hand out sessions. To get sessions, userspace must open
> /dev/liveupdate and create a session. This opens up room for one bad
> process to block every other process from creating sessions. It also
> imposes a need for userspace to add a polling/retry logic for getting
> sessions and serializes their execution around this point.
>
> I don't see any architectural reasons for doing so from kernel's side.
> If userspace wants to only have one owner of /dev/liveupdate, they are
> free to do so by unlinking the device from devtmpfs after opening or
> restricting its permissions.
>
> So the idea has my vote :-)
>
> Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> That said, a comment on the code below.
>
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> [...]
> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_se=
ssion.c
> > index b79b2a488974..ca4d0639d39a 100644
> > --- a/kernel/liveupdate/luo_session.c
> > +++ b/kernel/liveupdate/luo_session.c
> > @@ -584,13 +584,17 @@ static int luo_session_deserialize_one(struct luo=
_session_header *sh,
> >
> >  int luo_session_deserialize(void)
> >  {
> > -     struct luo_session_header *sh =3D &luo_session_global.incoming;
> > +     static DEFINE_MUTEX(luo_session_deserialize_lock);
> >       static bool is_deserialized;
> > +     static int saved_err;
> > +
> > +     struct luo_session_header *sh =3D &luo_session_global.incoming;
> >       struct luo_session_ser *ser;
> >       struct kho_block_set_it it;
> > -     static int saved_err;
> >       int err;
> >
> > +     guard(mutex)(&luo_session_deserialize_lock);
>
> Do we really need a new lock? Can we re-use sh->rwsem instead?
>
> It can block session retrieve (but not file retrieve) for a short time
> though since luo_session_retrieve() also takes it. But the block will be
> short since only the first open of /dev/liveupdate does work. After that
> it just checks is_deserialized and returns. And session retrieval should
> not be very frequent anyway.
>
> I don't have very strong opinion on this, but I reckon the less locks to
> keep track of the better.

The lock here is just to protect the local static variables
(is_deserialized and saved_err) so that's why I went with a local
static lock. But re-using sh->rwsem should work as well and would not
block luo_session_retrieve() any more than the current static lock
would (opening /dev/liveupdate must always preceded retrieving a
session).

