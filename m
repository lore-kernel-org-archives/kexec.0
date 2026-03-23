Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC63F46126
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wYr4H7Qc1JW2lOr57BNU90w82iHcpZfVMmSZ/RMRf1o=; b=1g5OLPzfLCYu6R/6CI9rZA1ukB
	vren90KduCCgGjTMG6QUilX3mWHMdLV2yZigih7RK2+FeJNNkiW7nOmNUnXlXJ0eYfF4Bnk4Sq3ZR
	nnt5ak+OHfUYLtBl7q3wYw4GVlDsZ9XB6F8jS1LpRRJ90eLxi9jLkF5rz3YX77Ab5EBmcLVemVyf9
	5EfsmM1WJ5U7JK5BzmyYUUNk5jsIYrHv7Cu+Bx89x2IXcEMKV7mv/TOSIRtHmHSwd6lZw9iu4cZKa
	zur786Dt/IkUCrzfksvBIRRxODcGKhRd5OYe+DtTeUhqMZ8B+RY29ZIjSFndFCPa5rpxn9OjlPQcx
	mv+X9Xbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4g1e-0000000Gu4w-3WLV;
	Mon, 23 Mar 2026 14:13:02 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4g1c-0000000Gu4M-3R4M
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 14:13:02 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-668d9dba217so619775a12.3
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 07:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774275179; cv=none;
        d=google.com; s=arc-20240605;
        b=UuborvF4G8kbZOh/Un1m2nf5+KcAs+s5sPAHmsl3lEUFtBJK4UNY9Yd3QfckwG62qX
         f+PerYgYir4JR+ZTtFdBln2jJtWJSgVeaRWtStKSb5KSS/5oD4v1JBuPLxDC4NgLsE8S
         fg0NxOVDEmNX7VUzhnHYrCF2rAgfWq8+1nyPjzqL1VzWxoB1mgIWMG+ZJ1xpr2OMaT6q
         8Y3eAsY3QwzGAe1aQn/fiSxLi6oOPkRM+xcze5QrcgCJuViQzYY9RFC+CxAtb6nMtgB/
         1sYkc0UT8Xdup2jATytPuXQ1V+rHLe5Qf2zoyNEABmyDQn20333PsHjPcfKezezNiHzA
         X/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wYr4H7Qc1JW2lOr57BNU90w82iHcpZfVMmSZ/RMRf1o=;
        fh=GnxVVytvidwm8pafPVf5+vF28zHJiGTVQO9YZpMrqSM=;
        b=UH9rYDE/j2rR2I2z/e1o90wyM/MAuPzsR6X1YVMMVAB1x0pTTRngbaTSLkpXq4CwYX
         aC5f7ERrmWPOpTAvs0gVDzEZBEzP8GnFNH9pB8Qgy1vZEU4B0P2K7cc8zYLTIOAFMaMq
         y8s53ZIUiwiombWrOlSDHk1Q42Pwn7/KiiUUoqTMWKuU6zrV/oqngya7h1Z7tgEBzlUp
         TSu+dLnMV50g53QS6ys0dSBdimqV973P3kwOVixvGdmxo/wBz32eLFlg6wex49oMk0W5
         iuuatX3i7dTZwfjG9qlHYazik3WZrUOV0EU4XN34/fPBVZZPr2bZ0rjkPm65EztAaMvh
         6F5Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774275179; x=1774879979; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYr4H7Qc1JW2lOr57BNU90w82iHcpZfVMmSZ/RMRf1o=;
        b=jo9rEYdFlnj7frMZ28elK4u1Ju5kmyl8Rqs1ln+AqXt1PItEeWW2+vzPIaRI0zI32I
         9Ve0GXanHtp/LiHAZzN3skKE8Ju77QxZdrkm6U04UEuzADVx0q6WfeSXcNck9Th0Tt2X
         R5dFxZZQhjRtV3/Tarj1jLPX+XJCD0BT8ridMeneZeCAumBV430/dlXQslvl2R36S+LA
         HlXMFfSHg8/3tD42auSggOVlwIQlTqlPtG6Cp9kPz8KIBN2AVd5+7iGWzGhKRqxOdF4G
         4rs14j26GIOKXRCdVoOu/kNyTzOFF8UdhuI/VlGzZ1yehqfDBFPkEAqCHD+p8PmG13XH
         cvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275179; x=1774879979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYr4H7Qc1JW2lOr57BNU90w82iHcpZfVMmSZ/RMRf1o=;
        b=OdJbl41yVzVAkD2NEQMptk8VUG/SOdJW+lvT2uzb5TOnMnOGZkTEPRwWnsFBOUdQYV
         9MWx+dlYWvyHRVfz2SLqNNWNAuPid+zzr1M6t5JbsC8tFTXzFcEHHZhoK7BkTxAnTm51
         nxYLmCpPOg15rEyqy64Vx46yLyHrs8Nytxj2xDPSZq67HZ6zoReITWlqK5fU08VsEX6T
         hf8Wh4cZdqIcVdjwlkNX+TJ2PDpkVsjB4vkk+qeCCNk2wV8xmmwjE1TxIPG8pRvGRBL6
         9yVubY9S3F7bhcvjh6fFoKr5wWtN7BgH5mk+9nDTo6VRIq5fEUzWUqMKffxlJl25dOay
         LN5A==
X-Forwarded-Encrypted: i=1; AJvYcCXkJ4RjtFwhiuoDE1/lKPmH5Ab8znddvdIIbtp0NAUaVQLGje6f1h3EiaJxWWbIC96FKs2RJw==@lists.infradead.org
X-Gm-Message-State: AOJu0YysofsndOCncZcvdq6hHWBeMgQ7cn+NF9RFBM1RqoBict+oc8Xw
	QKi7f0Sn0z5ydpt59/WKZOtWfgd1p/vJXdEOJwpzAnHcMfkqwLohk0ku4HBw9y4lnVJpoRSR7xS
	YUblBJbI+Zm0MNUL82/TXBHNLptWMQzY4pljnrkyihg==
X-Gm-Gg: ATEYQzzuJYZKnSHxxh+dA7ZnJOb7EQLj31/jyh2zcEJbuW6pYVVE1evyHRn4k4p6EjL
	1vh8hPeGsP5+9COdtSX1aTgf4cPykbeE/Rd04CyoESy7sxbamf9VwQPyb5Tx3lzx1/WQawvIKf1
	7fSiWIaLsmuYvBdz8rpmlscK1V3Wojld6SrscfguDCDPEd12gTUtuLjA3pghEnJUsnVvqO6Fdr4
	y3KbPOEs8LSxLJtsSvAaiD/p+tWYqiKnh8fgnvTvIQrgEychV8UQhUcKJtKgvcUc0skDhJZ0lo5
	gOuIzlrv+HKrCClC3e39Ggd2m0VrGcXpa0nX1w==
X-Received: by 2002:a05:6402:380c:b0:663:dfd2:6c94 with SMTP id
 4fb4d7f45d1cf-668ca31c297mr7921141a12.30.1774275178540; Mon, 23 Mar 2026
 07:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260321143642.166313-1-oskar@gerlicz.space> <20260321143642.166313-2-oskar@gerlicz.space>
 <CA+CK2bCVge7xybLshgLLphHAdRSHMLD3egT1nEyESBUFi7kHCw@mail.gmail.com>
In-Reply-To: <CA+CK2bCVge7xybLshgLLphHAdRSHMLD3egT1nEyESBUFi7kHCw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 23 Mar 2026 10:12:21 -0400
X-Gm-Features: AQROBzB4CJo-Q6aqcjHwweredVmDHdcxO42AcEjPRWBK_-LL7WH4i_ce90Z2WLk
Message-ID: <CA+CK2bDvv44+YLX6PcTOX_8eM5iET0RrC3gS4BCjMQRUjOSF1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] kexec: abort liveupdate handover on kernel_kexec() unwind
To: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Cc: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_071300_909362_19EAC376 
X-CRM114-Status: GOOD (  38.14  )
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

On Sat, Mar 21, 2026 at 7:05=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Sat, Mar 21, 2026 at 10:39=E2=80=AFAM Oskar Gerlicz Kowalczuk
> <oskar@gerlicz.space> wrote:
> >
> > liveupdate_reboot() can freeze outgoing session state before the kexec
> > transition completes. v2 only unwound that state when kernel_kexec()
> > returned a non-zero error, which misses the preserve_context path where
> > machine_kexec() can return to the old kernel with error =3D=3D 0.
> >
> > If that return path skips the abort, outgoing sessions remain stuck in
> > the reboot state and later user space operations cannot make progress.
> >
> > Treat every return to the original kernel after a prepared liveupdate
> > handover as an unwind point and call liveupdate_reboot_abort() there as
> > well.
> >
> > Fixes: 8b32d3ced269 ("kexec: abort liveupdate handover on kernel_kexec(=
) unwind")
> > Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
>
> AFAIK, preserve-context reboot is no longer used; in fact, it is
> currently broken. I tried using it six years ago and hit an old
> spinlock bug in the x86 code that prevented it, which means this path
> touches dead code.
>
> It was originally developed for machines lacking hardware support for
> hibernation, and I can't imagine anyone using it today. (I know Amazon
> is using it for a non intended reason and that is a very specific
> scenario in a costumized kernel that internally fixes the upstream
> bugs, and would not conlict with live update).
>
> During live update, we cannot return to userspace after a successful
> liveupdate_reboot(). We specifically place liveupdate_reboot() in the
> kexec path as the last possible point of failure. Perhap, to guarantee
> this behavior, we could  add !KEXEC_JUMP as a dependency to KHO and
> LUO or crash the kernel.

So, I think the right approach to address this issue is simply skip
liveupdate_reboot() call when we are doing preserve context kexec.
With preserve context we are going to get back to the current kernel,
there is absolutly no need to do serialization. So something like this
should work:
https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/commit/?=
h=3Dluo-reboot-sync/rfc/1&id=3Db13cf19ebbf2f8483a3c5a61a7358611b391edf6

>
> Pasha
>
> > ---
> >  include/linux/liveupdate.h       |  5 +++++
> >  kernel/kexec_core.c              |  6 +++++-
> >  kernel/liveupdate/luo_core.c     | 11 ++++++++++-
> >  kernel/liveupdate/luo_internal.h |  1 +
> >  kernel/liveupdate/luo_session.c  | 23 +++++++++++++++++++++++
> >  5 files changed, 44 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> > index dd11fdc76a5f..d93b043a0421 100644
> > --- a/include/linux/liveupdate.h
> > +++ b/include/linux/liveupdate.h
> > @@ -226,6 +226,7 @@ bool liveupdate_enabled(void);
> >
> >  /* Called during kexec to tell LUO that entered into reboot */
> >  int liveupdate_reboot(void);
> > +void liveupdate_reboot_abort(void);
> >
> >  int liveupdate_register_file_handler(struct liveupdate_file_handler *f=
h);
> >  int liveupdate_unregister_file_handler(struct liveupdate_file_handler =
*fh);
> > @@ -250,6 +251,10 @@ static inline int liveupdate_reboot(void)
> >         return 0;
> >  }
> >
> > +static inline void liveupdate_reboot_abort(void)
> > +{
> > +}
> > +
> >  static inline int liveupdate_register_file_handler(struct liveupdate_f=
ile_handler *fh)
> >  {
> >         return -EOPNOTSUPP;
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 2fea396d29b9..95710a7d5e56 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1139,6 +1139,7 @@ bool kexec_load_permitted(int kexec_image_type)
> >  int kernel_kexec(void)
> >  {
> >         int error =3D 0;
> > +       bool liveupdate_prepared =3D false;
> >
> >         if (!kexec_trylock())
> >                 return -EBUSY;
> > @@ -1147,6 +1148,7 @@ int kernel_kexec(void)
> >                 goto Unlock;
> >         }
> >
> > +       liveupdate_prepared =3D true;
> >         error =3D liveupdate_reboot();
> >         if (error)
> >                 goto Unlock;
> > @@ -1230,7 +1232,9 @@ int kernel_kexec(void)
> >         }
> >  #endif
> >
> > - Unlock:
> > +Unlock:
> > +       if (liveupdate_prepared)
> > +               liveupdate_reboot_abort();
> >         kexec_unlock();
> >         return error;
> >  }
> > diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.=
c
> > index dda7bb57d421..95a0b81ce60d 100644
> > --- a/kernel/liveupdate/luo_core.c
> > +++ b/kernel/liveupdate/luo_core.c
> > @@ -233,8 +233,9 @@ int liveupdate_reboot(void)
> >         err =3D kho_finalize();
> >         if (err) {
> >                 pr_err("kho_finalize failed %d\n", err);
> > +               liveupdate_reboot_abort();
> >                 /*
> > -                * kho_finalize() may return libfdt errors, to aboid pa=
ssing to
> > +                * kho_finalize() may return libfdt errors, to avoid pa=
ssing to
> >                  * userspace unknown errors, change this to EAGAIN.
> >                  */
> >                 err =3D -EAGAIN;
> > @@ -243,6 +244,14 @@ int liveupdate_reboot(void)
> >         return err;
> >  }
> >
> > +void liveupdate_reboot_abort(void)
> > +{
> > +       if (!liveupdate_enabled())
> > +               return;
> > +
> > +       luo_session_abort_reboot();
> > +}
> > +
> >  /**
> >   * liveupdate_enabled - Check if the live update feature is enabled.
> >   *
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_i=
nternal.h
> > index 0cfc0269d746..8a6b1f6c9b4f 100644
> > --- a/kernel/liveupdate/luo_internal.h
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -88,6 +88,7 @@ int luo_session_retrieve(const char *name, struct fil=
e **filep);
> >  int __init luo_session_setup_outgoing(void *fdt);
> >  int __init luo_session_setup_incoming(void *fdt);
> >  int luo_session_serialize(void);
> > +void luo_session_abort_reboot(void);
> >  int luo_session_deserialize(void);
> >  bool luo_session_quiesce(void);
> >  void luo_session_resume(void);
> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_se=
ssion.c
> > index d97ec91e1118..200dd3b8229c 100644
> > --- a/kernel/liveupdate/luo_session.c
> > +++ b/kernel/liveupdate/luo_session.c
> > @@ -788,6 +788,29 @@ int luo_session_serialize(void)
> >         return err;
> >  }
> >
> > +void luo_session_abort_reboot(void)
> > +{
> > +       struct luo_session_header *sh =3D &luo_session_global.outgoing;
> > +       struct luo_session *session;
> > +       int i =3D 0;
> > +
> > +       guard(rwsem_write)(&sh->rwsem);
> > +       if (!READ_ONCE(sh->rebooting))
> > +               return;
> > +
> > +       list_for_each_entry(session, &sh->list, list) {
> > +               if (i >=3D sh->header_ser->count)
> > +                       break;
> > +
> > +               luo_session_unfreeze_one(session, &sh->ser[i]);
> > +               memset(&sh->ser[i], 0, sizeof(sh->ser[i]));
> > +               i++;
> > +       }
> > +
> > +       sh->header_ser->count =3D 0;
> > +       luo_session_reboot_done(sh);
> > +}
> > +
> >  /**
> >   * luo_session_quiesce - Ensure no active sessions exist and lock sess=
ion lists.
> >   *
> > --
> > 2.53.0
> >
> >

