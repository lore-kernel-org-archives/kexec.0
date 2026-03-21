Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC241094481
	for <kexec@archiver.kernel.org>; Sat, 21 Mar 2026 22:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oLvmpAkKJO/7yepURo12dp3jQ5MqY9FaBFpsw+kHFHc=; b=XU1jtRiYld+ev2P8gtfA+jdV/b
	gRiTeytVYjn5BNv8ZmmKRX0NuPQ8JVj1Bh7AVoLb0s5LaFqGXewFEcYvvqbm/OJtx+J068hEgxOlm
	bCqCrVgM55jM65pEpVEvE/U2q1ODkxNsaLVQXyPNEXSNsZohmGR7hleIywYA4w14qW80xVfNIhK2h
	wxmhAn7mZBpbwgSkyxz4aI35XJOulpeS5PJdCnNnmPwBrQ3aIHJcQTdtSZR/tDJBUg4Cna3UqpQuK
	j/4gsxqh0qqsLDe+0yQd2dTxBvyGW76A4V61MrvpPME0bRDBIYTkgK72pfY9RD12ATcLWWKLL0xtu
	LvQaPfcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w44oh-0000000Eprn-1VjH;
	Sat, 21 Mar 2026 22:29:11 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w44od-0000000EprQ-3W0q
	for kexec@lists.infradead.org;
	Sat, 21 Mar 2026 22:29:09 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-66132b22182so4228364a12.2
        for <kexec@lists.infradead.org>; Sat, 21 Mar 2026 15:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774132145; cv=none;
        d=google.com; s=arc-20240605;
        b=ee63bXbIhERmmMOWoTCr8asy8KteH5E6bMvM7IHTpoFMPvmWmA7GPtF51Vm7Tqx5y4
         TeIQkd/h35rkueqpRfx6zX+GuqwnMglXK324RNPQtUHDwBsGfZYK0iaeyrQUcZ6+32v7
         ia/YMma8N/Il0jK6t2qLqtn4WAX1JBN9ZAShAMwwu9IaNpXPLquMM75zRnhTr2MYJc00
         gm/5FDea9uuSTQ5tF1YLzOhldwGoy0NasAhlG6mOH9bFH5urc3NK1gjrpOce5oMCl0h5
         l5V12Kqbihe3VRu/Iu13AUHe+6lTA3Pk9bH/GcAmpV02nWc6Bf6CFz6B3MuO8uDUkaQH
         rtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLvmpAkKJO/7yepURo12dp3jQ5MqY9FaBFpsw+kHFHc=;
        fh=h8AEJoySLPk1Qg6WONY0uZxXDr5ls/zWezocvrNT3VE=;
        b=ioW+QLuKn6QJWg6axRJMYBOhvsjJuMS/uiA51uyoIfKI+ni215puhxAMVdx4HU7Ivu
         AZfLJUnlZ5i31cTnqC2wCY0P5iaS29+wFCWLRc5IUuetO3tnFC2vE0k9l4gvlDCwJ6jN
         ZxS3s8kI/vRDqSUWThPE44wSIhV3QX1HCEwzDunfC/9NlaYHtUhane4DIQMk6db8Ux8e
         DstpPorEatqWI+0WQTSgBktVP5vwxmIV/aPUP8WRpxys2LtO5jG4fPkV10++OP55e2nE
         XkWGmCS7r6az+PpDfFNuuiDL3t+2nW0YfWH9llh63ezkH2w2yfTeNGJ6B95CgjPbl1Bf
         6Vww==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774132145; x=1774736945; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLvmpAkKJO/7yepURo12dp3jQ5MqY9FaBFpsw+kHFHc=;
        b=AoIvPD0XL2APWVvCzkWFcuygG2P6eOoE15BZYbwxU8qEexGSMLvZZoumcsW4jDkZHl
         lCCNPgtRrDMtGEjPUf9Av6z6RXgHDsSci2NEkGv3j18kpMM521aoJbig54AmGfJXfzrC
         b+Vgcq+cgBRVIw4lzmdga0MZ9EaGYy6yTpgrlpQosOnD/B/iMkJF1RX8ESYC1hHkBVeH
         fZg4NvVNC2H1PmJu7bmHQMo57NUqWJ6nbY9PA2cqxgD2Y2bBvFHwvKLDAzzV4kYbXTOa
         SSDEauz3t/5Cjd5edtTFX0HMuorIQ6RcmbZxc8bVlYpE+E+I5QkJa/SsP133t6FB36Cd
         AF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774132145; x=1774736945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oLvmpAkKJO/7yepURo12dp3jQ5MqY9FaBFpsw+kHFHc=;
        b=BFQYE49zfAyelucfSuiK8XCGQQKxCNvSZBAFLdcM4H+4s1bnNfkA1VudOAKZuP2WqB
         xSCSM/aBVU5pduCJgoUYWIVc9TkfbPAjqKlXA5J8950VnMqoDjBIrYfk3Pg8SYpscufS
         m4yDDCzvVCtYkrr/WW4nRfvO5sBuS0caCG/NlkDd1bFgzFcg5KoanNyKOIFaKtVWA54T
         7UGevdqNcxwpXLRzEcXlMlfWu7KTNrdLVZQx37+ZZ9YKiXQrm83scKn1Jf+p/KJuZmey
         XeKT7si5nD6DgC2R1e4YI+n0tK3QRTo8iqLtBfkC1Sx17SEvc4xVFBb+O+pDk/1rzvZB
         Gn4w==
X-Forwarded-Encrypted: i=1; AJvYcCVoUVrWQPmsIE++6bFMqQBWCt4kRaS0z67qseoNVqG3McMa19kI6SWFq5Uu67tHQEgy+yK2nA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1qKXs65BeDUYeeUFILggK3JWTzqWG9/xXftO2PQisxERT/zPS
	cjX66AnQyGNXJWJ/sJEdlrFTH4oyOemKjC7sQ9U6PJSzsGtFpHImRbOG9WexVLbEGk3nN7xoGK+
	Xi9ZiVnC48cXnNtH3tUNPozAgTSvotnh5tiwcbv1gww==
X-Gm-Gg: ATEYQzz08EMz3eMBs165u9D5Z7jUu2m63HY1eoK8zTVt2dGeuamAAmpKW37b2cGj0ys
	UH7hislJaIZZg6sb/xbx5FbtM9IaLPzz2LArQDUK6wzx7FSJZ7Mr3kQZTJ8izY+Q+bE7umruaJ3
	R9YnUvfvku++7InCRZWAFrZ5/7/R81sk+sf/37+SwJRHhLK017wbMtuPjaU5JWWt2VfkLdot9x5
	ZR2SGjpWpbCTOp6mpuc4jpZVmlPkl4d2TJsQcYyKPkmAYqxMSot4DNyWBkMMA2kYDGnCAiZhqqW
	s5W4zU2zCQo2BiWgLwn14KE+RTzysaEGu8vUYA==
X-Received: by 2002:a05:6402:3041:10b0:669:1f41:ee4b with SMTP id
 4fb4d7f45d1cf-6691f41fb83mr3013680a12.23.1774132144285; Sat, 21 Mar 2026
 15:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260321143642.166313-1-oskar@gerlicz.space>
In-Reply-To: <20260321143642.166313-1-oskar@gerlicz.space>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 21 Mar 2026 18:28:28 -0400
X-Gm-Features: AaiRm52hbnollu0Us6j2DCRk78-wry-b-pCgVq85KRcq0czvl-ek3Z0p2n_q06I
Message-ID: <CA+CK2bAfPSKfV=_Sw20oqF56+H3a4k3x+47i6-EUK8mLV-i2+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] liveupdate: block outgoing session updates during reboot
To: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Cc: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_152908_049957_03D9FC97 
X-CRM114-Status: GOOD (  35.72  )
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

On Sat, Mar 21, 2026 at 10:38=E2=80=AFAM Oskar Gerlicz Kowalczuk
<oskar@gerlicz.space> wrote:
>
> kernel_kexec() serializes outgoing sessions before the reboot path
> freezes tasks, so close() and session ioctls can still mutate a
> session while handover state is being prepared. The original v2 code
> also let incoming lookups keep a bare session pointer after dropping
> the list lock.
>
> That leaves two correctness problems in the reboot path: outgoing state
> can change after serialization starts, and incoming sessions can be
> freed while another thread still holds a pointer to them.
>
> Add refcounted session lifetime management, track in-flight outgoing
> close() paths with an atomic closing counter, and make serialization
> wait for closing to drain before setting rebooting. Reject phase-invalid
> ioctls, keep incoming release on a common cleanup path, and make the
> release wait freezable without spinning.
>
> Fixes: fc5acd5c89fe ("liveupdate: block outgoing session updates during r=
eboot")
> Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> ---
>  kernel/liveupdate/luo_internal.h |  12 +-
>  kernel/liveupdate/luo_session.c  | 236 +++++++++++++++++++++++++++----
>  2 files changed, 221 insertions(+), 27 deletions(-)

Hi Oskar,

Thank you for sending this series and finding these bugs in LUO. I
agree with Andrew that a cover letter would help to understand the
summary of the overall effort.

I have not reviewed the other patches yet, but for this patch, my
understanding is that it solves two specific races during reboot()
syscalls: session closure after serialization, and the addition of new
sessions or preserving new files after serialization.

Given that KHO is now stateless, and liveupdate_reboot() is
specifically placed at the last point where we can still return an
error to userspace, we should simply return an error if a userspace is
doing something unexpected.

Instead of creating a new state machine, let's just reuse the file
references and simply take them for each session at the beginning of
serialization. This ensures that no session closes will happen later.
For file preservation and session addition, we can block them by
simply adding a new boolean.

Please take a look at the two patches below and see if this approach
would work. It is a much smaller change compared to the proposed state
machine in this patch.

https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/log/?h=
=3Dluo-reboot-sync/rfc/1

Thanks,
Pasha


>
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_int=
ernal.h
> index 8083d8739b09..0cfc0269d746 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -9,6 +9,7 @@
>  #define _LINUX_LUO_INTERNAL_H
>
>  #include <linux/liveupdate.h>
> +#include <linux/refcount.h>
>  #include <linux/uaccess.h>
>
>  struct luo_ucmd {
> @@ -63,8 +64,7 @@ struct luo_file_set {
>   * @list:       A list_head member used to link this session into a glob=
al list
>   *              of either outgoing (to be preserved) or incoming (restor=
ed from
>   *              previous kernel) sessions.
> - * @retrieved:  A boolean flag indicating whether this session has been
> - *              retrieved by a consumer in the new kernel.
> + * @state:      Current lifecycle phase of the session.
>   * @file_set:   A set of files that belong to this session.
>   * @mutex:      protects fields in the luo_session.
>   */
> @@ -72,8 +72,14 @@ struct luo_session {
>         char name[LIVEUPDATE_SESSION_NAME_LENGTH];
>         struct luo_session_ser *ser;
>         struct list_head list;
> -       bool retrieved;
> +       enum {
> +               LUO_SESSION_OUTGOING,
> +               LUO_SESSION_INCOMING,
> +               LUO_SESSION_RETRIEVED,
> +               LUO_SESSION_CLOSED,
> +       } state;
>         struct luo_file_set file_set;
> +       refcount_t refs;
>         struct mutex mutex;
>  };
>
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_sess=
ion.c
> index 783677295640..d97ec91e1118 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -51,6 +51,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <linux/anon_inodes.h>
> +#include <linux/atomic.h>
>  #include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> @@ -66,6 +67,7 @@
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
>  #include <linux/unaligned.h>
> +#include <linux/wait.h>
>  #include <uapi/linux/liveupdate.h>
>  #include "luo_internal.h"
>
> @@ -89,10 +91,13 @@
>   */
>  struct luo_session_header {
>         long count;
> +       atomic_t closing;
>         struct list_head list;
>         struct rw_semaphore rwsem;
> +       wait_queue_head_t reboot_waitq;
>         struct luo_session_header_ser *header_ser;
>         struct luo_session_ser *ser;
> +       bool rebooting;
>         bool active;
>  };
>
> @@ -110,13 +115,24 @@ static struct luo_session_global luo_session_global=
 =3D {
>         .incoming =3D {
>                 .list =3D LIST_HEAD_INIT(luo_session_global.incoming.list=
),
>                 .rwsem =3D __RWSEM_INITIALIZER(luo_session_global.incomin=
g.rwsem),
> +               .reboot_waitq =3D
> +                       __WAIT_QUEUE_HEAD_INITIALIZER(luo_session_global.=
incoming.reboot_waitq),
>         },
>         .outgoing =3D {
> +               .closing =3D ATOMIC_INIT(0),
>                 .list =3D LIST_HEAD_INIT(luo_session_global.outgoing.list=
),
>                 .rwsem =3D __RWSEM_INITIALIZER(luo_session_global.outgoin=
g.rwsem),
> +               .reboot_waitq =3D
> +                       __WAIT_QUEUE_HEAD_INITIALIZER(luo_session_global.=
outgoing.reboot_waitq),
>         },
>  };
>
> +static void luo_session_reboot_done(struct luo_session_header *sh)
> +{
> +       WRITE_ONCE(sh->rebooting, false);
> +       wake_up_all(&sh->reboot_waitq);
> +}
> +
>  static struct luo_session *luo_session_alloc(const char *name)
>  {
>         struct luo_session *session =3D kzalloc_obj(*session);
> @@ -128,6 +144,8 @@ static struct luo_session *luo_session_alloc(const ch=
ar *name)
>         INIT_LIST_HEAD(&session->file_set.files_list);
>         luo_file_set_init(&session->file_set);
>         INIT_LIST_HEAD(&session->list);
> +       session->state =3D LUO_SESSION_OUTGOING;
> +       refcount_set(&session->refs, 1);
>         mutex_init(&session->mutex);
>
>         return session;
> @@ -140,6 +158,17 @@ static void luo_session_free(struct luo_session *ses=
sion)
>         kfree(session);
>  }
>
> +static void luo_session_get(struct luo_session *session)
> +{
> +       refcount_inc(&session->refs);
> +}
> +
> +static void luo_session_put(struct luo_session *session)
> +{
> +       if (refcount_dec_and_test(&session->refs))
> +               luo_session_free(session);
> +}
> +
>  static int luo_session_insert(struct luo_session_header *sh,
>                               struct luo_session *session)
>  {
> @@ -152,6 +181,9 @@ static int luo_session_insert(struct luo_session_head=
er *sh,
>          * for new session.
>          */
>         if (sh =3D=3D &luo_session_global.outgoing) {
> +               if (READ_ONCE(sh->rebooting))
> +                       return -EBUSY;
> +
>                 if (sh->count =3D=3D LUO_SESSION_MAX)
>                         return -ENOMEM;
>         }
> @@ -172,17 +204,98 @@ static int luo_session_insert(struct luo_session_he=
ader *sh,
>         return 0;
>  }
>
> +static void __luo_session_remove(struct luo_session_header *sh,
> +                                struct luo_session *session)
> +{
> +       list_del(&session->list);
> +       sh->count--;
> +}
> +
>  static void luo_session_remove(struct luo_session_header *sh,
>                                struct luo_session *session)
>  {
>         guard(rwsem_write)(&sh->rwsem);
> -       list_del(&session->list);
> -       sh->count--;
> +       __luo_session_remove(sh, session);
> +}
> +
> +static int luo_session_outgoing_begin(struct luo_session *session,
> +                                     struct luo_session_header **shp)
> +{
> +       struct luo_session_header *sh;
> +
> +       if (READ_ONCE(session->state) !=3D LUO_SESSION_OUTGOING)
> +               return -EINVAL;
> +
> +       sh =3D &luo_session_global.outgoing;
> +       down_read(&sh->rwsem);
> +       if (READ_ONCE(sh->rebooting)) {
> +               up_read(&sh->rwsem);
> +               return -EBUSY;
> +       }
> +
> +       *shp =3D sh;
> +       return 0;
> +}
> +
> +static void luo_session_outgoing_end(struct luo_session_header *sh)
> +{
> +       if (sh)
> +               up_read(&sh->rwsem);
> +}
> +
> +static void luo_session_wait_reboot(struct luo_session_header *sh)
> +{
> +       DEFINE_WAIT(wait);
> +
> +       for (;;) {
> +               prepare_to_wait(&sh->reboot_waitq, &wait,
> +                               TASK_UNINTERRUPTIBLE | TASK_FREEZABLE);
> +               if (!READ_ONCE(sh->rebooting))
> +                       break;
> +               schedule();
> +       }
> +
> +       finish_wait(&sh->reboot_waitq, &wait);
> +}
> +
> +static int luo_session_finish_retrieved(struct luo_session *session)
> +{
> +       int err;
> +
> +       guard(mutex)(&session->mutex);
> +       if (session->state !=3D LUO_SESSION_RETRIEVED)
> +               return -EINVAL;
> +
> +       err =3D luo_file_finish(&session->file_set);
> +       if (err)
> +               session->state =3D LUO_SESSION_INCOMING;
> +
> +       return err;
> +}
> +
> +static void luo_session_discard_deserialized(struct luo_session_header *=
sh)
> +{
> +       struct luo_session *session;
> +
> +       down_write(&sh->rwsem);
> +       while (!list_empty(&sh->list)) {
> +               session =3D list_last_entry(&sh->list, struct luo_session=
, list);
> +               __luo_session_remove(sh, session);
> +               session->state =3D LUO_SESSION_CLOSED;
> +               luo_file_abort_deserialized(&session->file_set);
> +               luo_session_put(session);
> +       }
> +       up_write(&sh->rwsem);
> +
> +       luo_flb_discard_incoming();
>  }
>
>  static int luo_session_finish_one(struct luo_session *session)
>  {
>         guard(mutex)(&session->mutex);
> +       if (session->state !=3D LUO_SESSION_RETRIEVED)
> +               return -EINVAL;
> +
>         return luo_file_finish(&session->file_set);
>  }
>
> @@ -204,26 +317,67 @@ static int luo_session_release(struct inode *inodep=
, struct file *filep)
>  {
>         struct luo_session *session =3D filep->private_data;
>         struct luo_session_header *sh;
> +       int state =3D READ_ONCE(session->state);
> +       int ret =3D 0;
> +       bool discard_flb =3D false;
>
> -       /* If retrieved is set, it means this session is from incoming li=
st */
> -       if (session->retrieved) {
> -               int err =3D luo_session_finish_one(session);
> +       if (state =3D=3D LUO_SESSION_RETRIEVED) {
> +               ret =3D luo_session_finish_retrieved(session);
>
> -               if (err) {
> +               if (ret) {
>                         pr_warn("Unable to finish session [%s] on release=
\n",
>                                 session->name);
> -                       return err;
> +                       luo_session_put(session);
> +                       return ret;
>                 }
> -               sh =3D &luo_session_global.incoming;
> -       } else {
>                 scoped_guard(mutex, &session->mutex)
> -                       luo_file_unpreserve_files(&session->file_set);
> -               sh =3D &luo_session_global.outgoing;
> +                       session->state =3D LUO_SESSION_CLOSED;
> +               sh =3D &luo_session_global.incoming;
> +               down_write(&sh->rwsem);
> +               __luo_session_remove(sh, session);
> +               discard_flb =3D !sh->count;
> +               up_write(&sh->rwsem);
> +               luo_session_put(session);
> +               luo_session_put(session);
> +               if (discard_flb)
> +                       luo_flb_discard_incoming();
> +               return 0;
>         }
>
> -       luo_session_remove(sh, session);
> -       luo_session_free(session);
> +       if (state !=3D LUO_SESSION_OUTGOING) {
> +               WARN_ON_ONCE(1);
> +               luo_session_put(session);
> +               return 0;
> +       }
>
> +       sh =3D &luo_session_global.outgoing;
> +
> +       for (;;) {
> +               down_write(&sh->rwsem);
> +               if (READ_ONCE(sh->rebooting)) {
> +                       up_write(&sh->rwsem);
> +                       luo_session_wait_reboot(sh);
> +                       continue;
> +               }
> +
> +               atomic_inc(&sh->closing);
> +               __luo_session_remove(sh, session);
> +               up_write(&sh->rwsem);
> +               break;
> +       }
> +
> +       scoped_guard(mutex, &session->mutex) {
> +               session->state =3D LUO_SESSION_CLOSED;
> +               luo_file_unpreserve_files(&session->file_set);
> +       }
> +
> +       down_write(&sh->rwsem);
> +       if (atomic_dec_and_test(&sh->closing))
> +               wake_up_all(&sh->reboot_waitq);
> +       up_write(&sh->rwsem);
> +
> +       luo_session_put(session);
> +       luo_session_put(session);
>         return 0;
>  }
>
> @@ -231,10 +385,16 @@ static int luo_session_preserve_fd(struct luo_sessi=
on *session,
>                                    struct luo_ucmd *ucmd)
>  {
>         struct liveupdate_session_preserve_fd *argp =3D ucmd->cmd;
> +       struct luo_session_header *sh =3D NULL;
>         int err;
>
> -       guard(mutex)(&session->mutex);
> -       err =3D luo_preserve_file(&session->file_set, argp->token, argp->=
fd);
> +       err =3D luo_session_outgoing_begin(session, &sh);
> +       if (err)
> +               return err;
> +
> +       scoped_guard(mutex, &session->mutex)
> +               err =3D luo_preserve_file(&session->file_set, argp->token=
, argp->fd);
> +       luo_session_outgoing_end(sh);
>         if (err)
>                 return err;
>
> @@ -252,6 +412,11 @@ static int luo_session_retrieve_fd(struct luo_sessio=
n *session,
>         struct file *file;
>         int err;
>
> +       scoped_guard(mutex, &session->mutex) {
> +               if (session->state !=3D LUO_SESSION_RETRIEVED)
> +                       return -EINVAL;
> +       }
> +
>         argp->fd =3D get_unused_fd_flags(O_CLOEXEC);
>         if (argp->fd < 0)
>                 return argp->fd;
> @@ -281,8 +446,9 @@ static int luo_session_finish(struct luo_session *ses=
sion,
>                               struct luo_ucmd *ucmd)
>  {
>         struct liveupdate_session_finish *argp =3D ucmd->cmd;
> -       int err =3D luo_session_finish_one(session);
> +       int err;
>
> +       err =3D luo_session_finish_one(session);
>         if (err)
>                 return err;
>
> @@ -371,9 +537,12 @@ static int luo_session_getfile(struct luo_session *s=
ession, struct file **filep)
>
>         lockdep_assert_held(&session->mutex);
>         snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session-=
>name);
> +       luo_session_get(session);
>         file =3D anon_inode_getfile(name_buf, &luo_session_fops, session,=
 O_RDWR);
> -       if (IS_ERR(file))
> +       if (IS_ERR(file)) {
> +               luo_session_put(session);
>                 return PTR_ERR(file);
> +       }
>
>         *filep =3D file;
>
> @@ -403,7 +572,7 @@ int luo_session_create(const char *name, struct file =
**filep)
>  err_remove:
>         luo_session_remove(&luo_session_global.outgoing, session);
>  err_free:
> -       luo_session_free(session);
> +       luo_session_put(session);
>
>         return err;
>  }
> @@ -418,6 +587,7 @@ int luo_session_retrieve(const char *name, struct fil=
e **filep)
>         scoped_guard(rwsem_read, &sh->rwsem) {
>                 list_for_each_entry(it, &sh->list, list) {
>                         if (!strncmp(it->name, name, sizeof(it->name))) {
> +                               luo_session_get(it);
>                                 session =3D it;
>                                 break;
>                         }
> @@ -428,12 +598,14 @@ int luo_session_retrieve(const char *name, struct f=
ile **filep)
>                 return -ENOENT;
>
>         guard(mutex)(&session->mutex);
> -       if (session->retrieved)
> -               return -EINVAL;
> +       if (session->state !=3D LUO_SESSION_INCOMING)
> +               err =3D -EINVAL;
> +       else
> +               err =3D luo_session_getfile(session, filep);
>
> -       err =3D luo_session_getfile(session, filep);
>         if (!err)
> -               session->retrieved =3D true;
> +               session->state =3D LUO_SESSION_RETRIEVED;
> +       luo_session_put(session);
>
>         return err;
>  }
> @@ -548,6 +720,7 @@ int luo_session_deserialize(void)
>                                 sh->ser[i].name, session);
>                         return PTR_ERR(session);
>                 }
> +               session->state =3D LUO_SESSION_INCOMING;
>
>                 err =3D luo_session_insert(sh, session);
>                 if (err) {
> @@ -578,6 +751,17 @@ int luo_session_serialize(void)
>         int err;
>
>         guard(rwsem_write)(&sh->rwsem);
> +       if (READ_ONCE(sh->rebooting))
> +               return -EBUSY;
> +
> +       while (atomic_read(&sh->closing)) {
> +               up_write(&sh->rwsem);
> +               wait_event(sh->reboot_waitq, !atomic_read(&sh->closing));
> +               down_write(&sh->rwsem);
> +               if (READ_ONCE(sh->rebooting))
> +                       return -EBUSY;
> +       }
> +       WRITE_ONCE(sh->rebooting, true);
>         list_for_each_entry(session, &sh->list, list) {
>                 err =3D luo_session_freeze_one(session, &sh->ser[i]);
>                 if (err)
> @@ -595,8 +779,11 @@ int luo_session_serialize(void)
>         list_for_each_entry_continue_reverse(session, &sh->list, list) {
>                 i--;
>                 luo_session_unfreeze_one(session, &sh->ser[i]);
> -               memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
> +               memset(&sh->ser[i], 0, sizeof(sh->ser[i]));
>         }
> +       sh->header_ser->count =3D 0;
> +       /* Reset rebooting flag on serialization failure. */
> +       luo_session_reboot_done(sh);
>
>         return err;
>  }
> @@ -624,7 +811,8 @@ bool luo_session_quiesce(void)
>         down_write(&luo_session_global.outgoing.rwsem);
>
>         if (luo_session_global.incoming.count ||
> -           luo_session_global.outgoing.count) {
> +           luo_session_global.outgoing.count ||
> +           atomic_read(&luo_session_global.outgoing.closing)) {
>                 up_write(&luo_session_global.outgoing.rwsem);
>                 up_write(&luo_session_global.incoming.rwsem);
>                 return false;
> --
> 2.53.0
>
>

