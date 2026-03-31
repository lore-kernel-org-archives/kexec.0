Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66F210F92EB
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmHyVXpnDYQ20Y8tpOog8F563dlY7wEta5zrK8UkI6g=; b=k/5KSVMqKJXwxIQKEsCUnfgZQq
	BwD2izHy/YdvzAg0pVSFPxIjqnFPYdCrCfDlo2qWY7GFn/d3IYN6aFEVlmDJ+MvwZPobO4aiF9Z7x
	G1UpM8gepM8t7I1RKPSGTdshr6LO/hf6lZv/iV5Tlxj0CBnwV/nk/9O98cB3VY9HHA5jZr6nb8FsM
	vrFiNXaizyK+WbAf7k7ZsN0JffDtgJyO0VgKUamfk75CYZe5AkLEYdIyJViQ+oQ3QksuHtyy4+UFI
	08o3wNsefrnTF1cRZx7B7c3TJfeiF0+iYqlxsm3H/+3igYDdpTXX/0N+w9KQk5ZpvTsQosxQHFf+O
	0a8jEvVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7eXe-0000000DSmF-2M7Z;
	Tue, 31 Mar 2026 19:14:22 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7eXc-0000000DSYo-15w0
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 19:14:21 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-66db0cf6a4aso375284a12.0
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 12:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774984458; cv=none;
        d=google.com; s=arc-20240605;
        b=gWVpOR/SQxtAaBLOWpdzdtGKLJsSJY2Ne/tmLkQG39NrjMRftX0MlO9e9kXEk7HEKV
         jpPmmN+qgZ6jnmZih3u7Bv3SQid5HZw1pT7IrBme/3w1lBj1LgYE25aN1fgDPkQG5qOZ
         6P5sHWsyMw3bz2cQRWqWVM3seDeJbwyxHEmsDWBDT1q3pQ0tMvBMyIm5CMhRXpdKIXi4
         Ghj6ho0+OiYtr7YJidXfCRuxaMAsrCVgbRoB0I7sqUluwG2XG1mImKQMqMQmTfZyrV6i
         r13mSOJVUE1a2rMm32fmVoxlkpXuBzVmnkYw/Col/Yo1b3cTobeWBdPUPSlJwSNAbPgl
         HJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bmHyVXpnDYQ20Y8tpOog8F563dlY7wEta5zrK8UkI6g=;
        fh=EPE7UXMVpQ0aMGhqMSJOVUIHdBHtQTCp5NYO0Bnljk8=;
        b=eVZuTC9cL4+oNfgUqWtOi1cjUhwsImgp9YCk7jBtQy9xsXkNM38aoJM25MxTO2j09Z
         BgOZbM/l8hVv9li9UtskOUOMGcBGRDUomzOJAMLL9NAoaNvYbZnSPxUEQn7iftC6R4vO
         BqZ/LfPNjAQrc8/uuTLjeWAhhxpkYYJAypSdmdU2q0z7wOOP7mWFpkdpp4//IcVVbe2B
         CM12FjQj/gFamdLR58uMysM4StKjn9UVJhuWWlhyq6+Pwz69oetRqvcD1uJKOw8kfmZn
         fMW4umIK8Z66aoz2YxzA0u/N7UYzRldP4hRRcYy9AdyRsoQf6KNFAROrBzSl7TTYLkPb
         prDQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774984458; x=1775589258; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmHyVXpnDYQ20Y8tpOog8F563dlY7wEta5zrK8UkI6g=;
        b=fno3vvaP/rd9iouxcRCXBNxE/8oYe0KVDemnqaiHjA2BEkWKko6zjt8fBJmb4AylzF
         4JJUbnRLiOpg7Z/8y7+kopuUk10L4c/r5XW9XuJIOSYZvZEHWqvTyaFvj5nDDxFee1Y+
         zd6TXa2IUoYL1HK2CdvVY+XC62GsFLahMlwsDEPG2n1K4n0sfDxB8xFZtPR/h+c7Unpr
         e8kh9DlFIQBzBbaiZf2Y7eLvgmiI5TEht653QOEgCLLJCg5FuxQZcurXyvjtb/MnfdPV
         3znqXHckC++7qhmzh2EqdrwDlotulgufR5oLP/cIT3XV6ASUa9wwBwMDp/S4vqi8+Gbi
         EvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984458; x=1775589258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmHyVXpnDYQ20Y8tpOog8F563dlY7wEta5zrK8UkI6g=;
        b=BhMt7iC+sCxnj9cUtSZqbQso8+YotSryBZ5b2njN265uOlLGm24GkqqznMgx81iNki
         fLXPXcuLlJjZG/YgXgvee5AGO9IFo55+yUpdYyD+WiZ8nf90H8MJkanI48re+NbcVd74
         Jz3jsiIGRma9fgFWsfLOmsK3dYeCsjGTfZQ0fU5lrYxe8pnQlGQ2lTawxSUiy/GNvvCB
         Aigvnlz/DPfufXtJp4c/V3RHoxa5RjeS4deU25KnmxF585FC0ncAC1LlqophEPz3QBTZ
         OnVmO9x+zlyhBdGT/TIRkbKQxqR3AASfZylWAhco+CrRfYLdx8iOGPWU0z+kz59IHSr4
         fmEg==
X-Gm-Message-State: AOJu0YzLs5/0QbetlxAYgsN4/ogEsc80tV2HaTdf1sUI75Pal9CVUiLW
	92S3NoI+mvs5Sz4z7LzSkOJBuTvTn1SccVvV/K0WQEG8+CxYOovGZUSCjx+EfNHTyTLiI4ubNmw
	LoTxsAPpSG+wZ9qbBhqECEPAL/SV8DQuust+Dk28ypg==
X-Gm-Gg: ATEYQzycraQ6DQuViZb2/6de0LX/RQJvMQFxlzBbJUxuTe00DMyK6oGKp59bxmvsgK+
	j8Bpb6TBCR8TNSLdScmD4E0Ld9gyRS56Qt+BbemKmWlv4y/QDaCYXbAoojKQ56Cymg7XmakvSWW
	YH7NeTUJfKY6oLnqB8+crGH32IAFesdrMVQhXYxr755Ly1yXJ4tPXj0uUSiZ4lEgp7KovmUUsBJ
	rqO24SCHky2gOVcW72Y3STuKn8Kxr6Ot/oiFnx3qJI5097L8uI4pDISpf/jK+DcuzS8xC5EoeV2
	FMjClSYZHts7DFSUXwRTx+wEPbr72Jt36NiHrw==
X-Received: by 2002:a05:6402:4308:b0:66c:4d3c:fe2f with SMTP id
 4fb4d7f45d1cf-66db02aae4dmr430347a12.7.1774984457471; Tue, 31 Mar 2026
 12:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175456.4065874-1-luca.boccassi@gmail.com>
 <CA+CK2bB0bMxW721Q+SzFJENe4X0_GwcOh83R-mm1V5dig3oP3A@mail.gmail.com> <CAMw=ZnQZm_k_mMQPmKwuBtkFyXXgAn9MK1NzmVbZst4nGu6xhw@mail.gmail.com>
In-Reply-To: <CAMw=ZnQZm_k_mMQPmKwuBtkFyXXgAn9MK1NzmVbZst4nGu6xhw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 31 Mar 2026 15:13:40 -0400
X-Gm-Features: AQROBzDlFd9ZpXe2hTLzsg799tWUQs2xMihrXKRkRQAFEGJt31hcnoPOvpe85WA
Message-ID: <CA+CK2bDL9=uNmy9hq=3D-w=MHYsY82FNCkqvNeNpnTnX6meYRA@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: truncate getfile name to NAME_MAX
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_121420_329465_7AA60B12 
X-CRM114-Status: GOOD (  27.30  )
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

On Tue, Mar 31, 2026 at 2:30=E2=80=AFPM Luca Boccassi <luca.boccassi@gmail.=
com> wrote:
>
> On Tue, 31 Mar 2026, 19:21 Pasha Tatashin, <pasha.tatashin@soleen.com> wr=
ote:
>>
>> On Tue, Mar 31, 2026 at 1:55=E2=80=AFPM <luca.boccassi@gmail.com> wrote:
>> >
>> > From: Luca Boccassi <luca.boccassi@gmail.com>
>> >
>> > dynamic_dname() harcodes its limit to NAME_MAX bytes, which includes a
>> > NUL terminator and a 'anon_inode:' prefix. If the name passed on goes
>> > above the limit it results in userspace getting a ENAMETOOLONG error.
>> >
>> > Truncate the name to NAME_MAX - 12 - 1 characters to ensure this never
>> > fails (accounting for prefix and NUL).
>> >
>> > Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")

Let's remove this, this patch is not fixing an existing issue, but a
preparation for future uapi changes?

>> >
>> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
>> > ---
>> > Builds on top of this just sent by Aleksa:
>> >
>> > https://lore.kernel.org/linux-fsdevel/20260401-dynamic-dname-name_max-=
v1-1-8ca20ab2642e@amutable.com/
>> >
>> >  kernel/liveupdate/luo_session.c | 7 +++++--
>> >  1 file changed, 5 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_s=
ession.c
>> > index 7836772956406..4a40c7fdfb44f 100644
>> > --- a/kernel/liveupdate/luo_session.c
>> > +++ b/kernel/liveupdate/luo_session.c
>> > @@ -366,11 +366,14 @@ static const struct file_operations luo_session_=
fops =3D {
>> >  /* Create a "struct file" for session */
>> >  static int luo_session_getfile(struct luo_session *session, struct fi=
le **filep)
>> >  {
>> > -       char name_buf[128];
>> > +       char name_buf[NAME_MAX];
>> >         struct file *file;
>> >
>> >         lockdep_assert_held(&session->mutex);
>> > -       snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", sessi=
on->name);
>> > +       /* dynamic_dname() rejects names above NAME_MAX bytes, includi=
ng NUL terminator
>> > +        * and a 'anon_inode:' prefix. Truncate to NAME_MAX - 12 - 1 t=
o avoid
>> > +        * ENAMETOOLONG. */
>> > +       snprintf(name_buf, NAME_MAX - 12 - 1, "[luo_session] %s", sess=
ion->name);
>>
>> I am confused by this change, the maximum session name length is: 64,
>> as defined in:
>> include/uapi/linux/liveupdate.h
>> /* The maximum length of session name including null termination */
>> #define LIVEUPDATE_SESSION_NAME_LENGTH 64
>>
>> So, 128 should be enough to include:
>> "[luo_session] %s", session->name
>>
>> Or am I missing something?
>>
>> Pasha
>
>
> Yeah we need to to bump that size, it's too small - see the shared doc. T=
his is anyway needed for safety, as the user space call falls apart complet=
ely if it goes over the hard coded limit,

If there is a safety issue, it should be fixed (even without a limit
bump), could you please explain it.

I looked at the shared doc [https://tinyurl.com/luoddesign under limits tab=
]:

I see:
TODO: this needs to be bumped, as for the varlink API we will impose a
cgroup path prefix, which means PATH_MAX + "/" + client-supplied
string.

Why would we do that? Why can't we use a 63-byte unique identifier for
sessions and an in-memory database that maps the cgroup path prefix to
session_ids, where the database also gets passed from one kernel to
the other?

Increasing this limit would require a kernel uAPI change, which
requires a very strong rationale, and would bump up the KHO ABI for
LUO. It also means that the LUO session data in:

struct luo_session_ser {
   char name[LIVEUPDATE_SESSION_NAME_LENGTH];
   struct luo_file_set_ser file_set_ser;
} __packed;

would get bigger, and thus the kernel would need to preserve more data
for every single session.

Ideally, this extra data should be preserved by the userspace
orchestrator via a separate memfd.

Pasha

