Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A5410F92E9
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Z1ZTwUnghvA4wZBFW7neJ+hQNBTpYfH4OG7mwECm/M=; b=PBsRu/TucMHwCkBTUfrMfPyTDa
	7YTrWIV4HvP+mQ5Vn8kfAQo9sTEdGMBzCknHkh2beLuFRNQV2KQKLrPWUXcin7/C3har++bD2PjXr
	2i5c+k58vQb2dWaDSToZQOVMrGdBLkh7XbWLcVDOP9FbCd7E/cw18JdR8uQ97wtDqx6h3CwK8vOmH
	KJwHJr9yqPMjSgewza5qGcGnP/kHHXzcLGJgS7fyR7NNMY077mBbv6hq4PSpfTIXWhuqVnv1rWeqg
	+4KkE8OzF8nInCEOR0OTqNAcmtYhtZ9tdmDY1locR3AYYC61mrh4/luQCR0fIEGJYQd53g3pMDj2D
	UyzAX0HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7dir-0000000DPbg-30re;
	Tue, 31 Mar 2026 18:21:53 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7dip-0000000DPbG-2gXq
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 18:21:53 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so9996453a12.0
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 11:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774981309; cv=none;
        d=google.com; s=arc-20240605;
        b=kBKEomJAK936O+L9c0DarVxTWnbZhWq8UNfUIwjzfYAMc7v8UIbQVvNQLlZ4Aa8Poc
         LOWv4dnJO1aqyyLr4hqVDWwL3IVezdnkPdjocm9f7krx8ZaXFWgwq9R+cpXjRORoWCHn
         LuZ3tSL4WTLbepk2Bu1xnEdi5MJFox9e6JcBoY/3eDCO9D+v67j3jGWl3OAt3Vu3160q
         vQYMLz/6TTLLZy9c+GUMcObTnsNNy9pYXaKaheVxyeAOZgZqbPdcSUmrYjWjOEFW2rsV
         9c1Eg5H0FjoFjyPQUw6NWrRUP1vUmrWXdAkbcqolB4pt+Ou2O8bo2RLRMdmhZ4ensS0B
         gfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Z1ZTwUnghvA4wZBFW7neJ+hQNBTpYfH4OG7mwECm/M=;
        fh=ni37SOhjHixerEV2bxAsx42kJLTA6jFmDw61VZmbkYs=;
        b=OONGCxmCWsywHwNxA8TR+wi9kLIjizIy594xU93cV5PlAoUg9ct8uWxYrqfpoq12oy
         WlQ7PAQ7dkFc8wKNG2ScJ9pzpz4q5FUGZQIb2mtMJcUJyNutHA0Bj7iRHiST7EIYzY/a
         xSzPg9IWL44588m8YUXSV7DG4KsVbP4xmYu2erUwfe+xcwsEXztoW5kUkloX8mjplvjo
         SUcOvNiX4rwW6RHHdqHnJZDcqHfHaHlhGzOayAtsPLw2wch+SvkzULBhtT6c25BD36Yu
         FAR0om+lhH+rn+yrbLFydQ8v8bYnmUTO6YR/q+e8A7+6zI6IP6GkduOPLPE0lXksVvE/
         JzMg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774981309; x=1775586109; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z1ZTwUnghvA4wZBFW7neJ+hQNBTpYfH4OG7mwECm/M=;
        b=AD9KAykmsLAtjoofdkP0gVYlTv8z3mMKD0x2CXu/s2JAKeSlEj/PO3l7KpB/bTtlBe
         v2BiLnnJYJn2Gme/se0feT9v4s0/z2vjrZ6qok4CGqG7+eoon9UEg164GSCE+9DSjJHo
         T3Lh+YBDdSWlB4yg7Zab3kUVLqI+x2KJnqeJJfCvE9h9j3ZaQVEYaFPf/ZSnyGK8VgHE
         7fyjJNO5WTecbbzIEy2zJC6/gdI4SWdZRhx44Q6RsbFVWpVXCCjN2TrgJs+4KRJu2iQu
         IdPowlVRwBwXV0eZ2g6TeKqDYPZtScLFFMAur1ZdGFKc1AsEV77KGwevhXAM+/L906+D
         NWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774981309; x=1775586109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Z1ZTwUnghvA4wZBFW7neJ+hQNBTpYfH4OG7mwECm/M=;
        b=H5NIqH4W/itQ9BjdLel5z9FLntQ2kNMajVb/wQgvxQDPAAThce8NkoXp7CRu/TqPhY
         FjOSJ90ZYf5bOfuOUbZZNWmeopN4kandoL1SVKdjtLWLWDDtIuJrbcMXFvVXxMKclqq/
         L4l3L6H5sUNQsrgdfDXdhzMYk54ME34ti11GTsnxKdDs4IYS4/EyVzphV8I1IDQDgAw3
         t9ETLjdRF9j5KpPWhZXG/Wzf7Ex8AAZnsvejn3xuR4uI2szqHjYtBeTJRVR9tg/Ks1rC
         8rHNrwGN5YF6xfV6q4zyeGAT1H8WX4lX20s55F/aoAm9gSH2FHXWXFgu/7qyazW6Ya0W
         4++w==
X-Gm-Message-State: AOJu0Yzje8BhxFMQGKhb4qwuHh3x/soN102xs/4kYwq9ADAL6tqtUyaz
	QAYy0My0Yna3h42xR3eKE83OqPPvvFYF7YmsZ1zrkMutq+R/0QTciAc+M/yEKLhJMh5cF0hJ7tL
	Xnw1pteBMmZkRcWxQXdraU/4HPfcIHXR7yTWo9igHgQ==
X-Gm-Gg: ATEYQzycCpgJ657wpL+CqVG7DBi3y1XP/yNzJdUQfD/uvs4aThJUEsu+cTHtZuVM+jG
	mwxSs7DYMG8RQ513DKDZcK0hkg3YP1SBcAeg0NT/5TUh2tpA0gzTSk8XQhQF3hQJgtdkUErgiPE
	nkdsj3RFOeSiedOzaOWWmasc8IvqvhA1fnGdDFuEfKvBbjTmNiQTz0NIqIz9CS7XcDmN10b6Rbk
	ayU5qe4sntDwCC406SE8ykLR12t9SNlPz+rcbu+kWsnqayY785+f4m2llODBMc1JOx5/A6syorp
	1kDJXczq7lV/fFKTpbrsK1PoSrY6uSvKRCc/ow==
X-Received: by 2002:a05:6402:4306:b0:665:a417:3ed8 with SMTP id
 4fb4d7f45d1cf-66db09e189emr327584a12.16.1774981309415; Tue, 31 Mar 2026
 11:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175456.4065874-1-luca.boccassi@gmail.com>
In-Reply-To: <20260331175456.4065874-1-luca.boccassi@gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 31 Mar 2026 14:21:12 -0400
X-Gm-Features: AQROBzCTHvb05M0vcsTVPES6Ynk7b97-HrtYc5Ey0Occ_WM5chA1DLPefIFWYrc
Message-ID: <CA+CK2bB0bMxW721Q+SzFJENe4X0_GwcOh83R-mm1V5dig3oP3A@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: truncate getfile name to NAME_MAX
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_112151_701342_69423882 
X-CRM114-Status: GOOD (  19.25  )
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

On Tue, Mar 31, 2026 at 1:55=E2=80=AFPM <luca.boccassi@gmail.com> wrote:
>
> From: Luca Boccassi <luca.boccassi@gmail.com>
>
> dynamic_dname() harcodes its limit to NAME_MAX bytes, which includes a
> NUL terminator and a 'anon_inode:' prefix. If the name passed on goes
> above the limit it results in userspace getting a ENAMETOOLONG error.
>
> Truncate the name to NAME_MAX - 12 - 1 characters to ensure this never
> fails (accounting for prefix and NUL).
>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> Builds on top of this just sent by Aleksa:
>
> https://lore.kernel.org/linux-fsdevel/20260401-dynamic-dname-name_max-v1-=
1-8ca20ab2642e@amutable.com/
>
>  kernel/liveupdate/luo_session.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_sess=
ion.c
> index 7836772956406..4a40c7fdfb44f 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -366,11 +366,14 @@ static const struct file_operations luo_session_fop=
s =3D {
>  /* Create a "struct file" for session */
>  static int luo_session_getfile(struct luo_session *session, struct file =
**filep)
>  {
> -       char name_buf[128];
> +       char name_buf[NAME_MAX];
>         struct file *file;
>
>         lockdep_assert_held(&session->mutex);
> -       snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session-=
>name);
> +       /* dynamic_dname() rejects names above NAME_MAX bytes, including =
NUL terminator
> +        * and a 'anon_inode:' prefix. Truncate to NAME_MAX - 12 - 1 to a=
void
> +        * ENAMETOOLONG. */
> +       snprintf(name_buf, NAME_MAX - 12 - 1, "[luo_session] %s", session=
->name);

I am confused by this change, the maximum session name length is: 64,
as defined in:
include/uapi/linux/liveupdate.h
/* The maximum length of session name including null termination */
#define LIVEUPDATE_SESSION_NAME_LENGTH 64

So, 128 should be enough to include:
"[luo_session] %s", session->name

Or am I missing something?

Pasha

