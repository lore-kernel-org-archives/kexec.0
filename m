Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913C4109449D
	for <kexec@archiver.kernel.org>; Sat, 21 Mar 2026 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxFfukiYQfTiKo8hngBXYOGIkpypLUKnBpebRqVgDE8=; b=OFGsQPNAyi0vtccPz5EbIJlbwT
	D1V2L+IVRwIggO4MIMEFw9Th3dsKjcZZ2K5imkcCVqLR61kTE+9dBpfafKFrvVhPQw/21ccH54E0q
	3Av2MFvetZeEYAHPscrgJpeHToYlPfRarBrEmYJ6QzpgVn6F2Bdhgd3HAl2ADKLzzz9q+v7FJgGHk
	1nmkfYdt1toutG1+yikbTfyrInvAgNNw0SaC9cLQAffm/zGHu8QEkrhqaYUL6Pomi8XGcm45BmTfZ
	GVBMUUCWhnUmxrQsU10NYZitiPp+mzBwFW11HJwQNWu8kTbbY7i5FZBAsbr4IESzTgBB0aUvNlIQu
	68/bXAyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w45O7-0000000ErRi-3O8o;
	Sat, 21 Mar 2026 23:05:47 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w45O5-0000000ErRN-3Ymp
	for kexec@lists.infradead.org;
	Sat, 21 Mar 2026 23:05:47 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6689033d0c3so2556934a12.0
        for <kexec@lists.infradead.org>; Sat, 21 Mar 2026 16:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774134344; cv=none;
        d=google.com; s=arc-20240605;
        b=HOxVKf7YLyNgsrflYaH4kRdAbYL+HA/0Njigy45dzffA9P/r9KegkXg++NKLiwaiJO
         7JjVZ3j23acXr9+1906fFMtOzjZF6DuyxObYn0wmwx2EgZlKh55d7df7S34X43FbOYiW
         XxJHwqi+fK/pKOh/TVNDX9dehcbpMPuG8PPXsge+DE/XOu6vVsJPenS/6cXBq5xWCJ16
         VJ06dpGFtXA4YU9JE2i/ItS5G1/BnUYcpMx9wI8zaaU/TszvyyFL/A1HwSD/vXd/Z/JO
         UivDt5HDIW6R5xsSK6WLMeAMxPywop0WI+SW/eBu8x00Bb0VLnDhUy9PR6RFjg6DMab/
         BL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxFfukiYQfTiKo8hngBXYOGIkpypLUKnBpebRqVgDE8=;
        fh=YZMN9kPlyusikQtMBICQm78yKKDLe/SJzIRMMUzq/pU=;
        b=YcWFTb9wndf4+4upDrC3X3MO2T3cozCUvVMWX3TymxV5ym//Ryo3QBOnHWF02EXvHU
         1lOFYA8zAEEFoKrID8SJPdi9NvuMEmSL6BqdAbidfh9w3XOPmaS6k2H3XXAG6S8rb6TM
         6W8nQllgKlCzCUCwrku361fGpWcXx6MdDsScsa3zXwBeEq4hIvxDQ1ks1+/IkUM1d2Uq
         Jn8DR65mieYkM3ph6rk5O3iIU62LgWAs7OFjLWrbw07a98nQX6BT7/epqGDx62PMk1LZ
         keACPAt4rmygZZOg5Tq08jwJmjZsXP7UYRd9VHjNgzM61ANv49BqO7IYdymcPnFyTYTz
         sVOQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774134344; x=1774739144; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxFfukiYQfTiKo8hngBXYOGIkpypLUKnBpebRqVgDE8=;
        b=ipLCZ80d55Ou1Ak167AktwySHqyT3eSrOo+HzAhSlucgiQ90IOBTHI6si80RIoaWNs
         m5pEVE9Ilq/eH0l12MQ5V5i1qmKKeSKxuZAdQdE1PMGsc0l3cOIYsK62duAZJbX492tq
         RrP7H/9Mknqj3CJAg482xgoYLDc1ARAPv8HYkHJWefYclTxEaBUuJnYL36oGA36btP9B
         VegSQeaq71uRBnsU82TEOT6qg2eUvlxPvGLYMXSLgzBHZ1v1eS/SfefO7p/v52EnchE9
         ff++0jKMxW8VaZSkzn/3UtTL66zR1SfTlM334RrBUCsl8AJOzviTKuC8ilr4VAB+inkk
         FknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134344; x=1774739144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxFfukiYQfTiKo8hngBXYOGIkpypLUKnBpebRqVgDE8=;
        b=BlJU32WkZ4cAROrHXlFXerA9SnPGiWFH5HpkkrVEIGlJg+H6RtzaLLEe9QW/4WPdXG
         seHk+/k6sqr2vC430jw19t/VvzOkgFAqASJm5S7jKDbZm0Jv9B1LpNuIvr2u15seBBL7
         vuiEqeTao6b/HjtKpBjpoDOVXeHXoAOdH0Eb94jnWPWIZr7lPIKDz/Qp4YPbLNdfZ8i+
         8CLKXl3MV3xenSGsKPgmXwRUFi+owjc0cyQp8nBSuSBR+YOhc0CEMkPviTQLm23JM1h8
         ogUbxawQUFyTdazuyMsPhK/gt7j3szbEikP+L3dYt/IOuCqoCOuighZz/EnSBwdgw8ZE
         xdvg==
X-Forwarded-Encrypted: i=1; AJvYcCULmatwLTOv7fliBpUFoGdifcLy/vmKoRJp8APSG4R2VaCU2KOjBYSk4kbTAagdnvwdTqqfcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YziqL722D3U/jVCmSoK+Y377wDvkaGHkH64SrEZEOtVe1zoi6Qv
	2X99ZP+qTtdi0NHnCRGX4tiDcUwuiazOwqJoMK5f21fUeejknV6wKZqTYOoVKORW+8PJftPRPZb
	tQjyZiC1mnbDhtZOTeT5umpe7KfsUQvtAt6/niqmWUg==
X-Gm-Gg: ATEYQzzGo8x6duSsExqphYzoQKntloKGAOCCiWbbSbH24H3T/Sl7euFboFmKHKCZ/LS
	BjypNZnDEuTUdHFbWb2jZEag3/4QYU3LyMx0bPlQ80i49tfz1/kpEAAHrPEgHOkz3QGLetAngmu
	wKSN48r//pBmBsCmdkgyAPc9buaU2G93Vwi9e/3i6I8Uyy80ia2x/CpLIlNaShbNnZIgFWQkx2f
	dTAZ7ujXHhmNKZCRFRJGAqtBxGzljdl5qcbUZ9CsOcEUNq3DdNUt+fmexffxEXGlHewNZNuvj7l
	8IyNlYLLrolugLiw/BEYwYGoUmbgQ5tSZeE3aRnkr4VHKJxF
X-Received: by 2002:a05:6402:5287:b0:667:7d90:71cc with SMTP id
 4fb4d7f45d1cf-668c911507amr5739041a12.3.1774134343288; Sat, 21 Mar 2026
 16:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260321143642.166313-1-oskar@gerlicz.space> <20260321143642.166313-2-oskar@gerlicz.space>
In-Reply-To: <20260321143642.166313-2-oskar@gerlicz.space>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 21 Mar 2026 19:05:07 -0400
X-Gm-Features: AaiRm52N1A5JiyPRBAXH_ftxFPoPbwtABbjPiEkUX2L9NL3d-c2DKSK2P4FMnrU
Message-ID: <CA+CK2bCVge7xybLshgLLphHAdRSHMLD3egT1nEyESBUFi7kHCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] kexec: abort liveupdate handover on kernel_kexec() unwind
To: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Cc: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_160545_953624_5481FA0D 
X-CRM114-Status: GOOD (  28.12  )
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

On Sat, Mar 21, 2026 at 10:39=E2=80=AFAM Oskar Gerlicz Kowalczuk
<oskar@gerlicz.space> wrote:
>
> liveupdate_reboot() can freeze outgoing session state before the kexec
> transition completes. v2 only unwound that state when kernel_kexec()
> returned a non-zero error, which misses the preserve_context path where
> machine_kexec() can return to the old kernel with error =3D=3D 0.
>
> If that return path skips the abort, outgoing sessions remain stuck in
> the reboot state and later user space operations cannot make progress.
>
> Treat every return to the original kernel after a prepared liveupdate
> handover as an unwind point and call liveupdate_reboot_abort() there as
> well.
>
> Fixes: 8b32d3ced269 ("kexec: abort liveupdate handover on kernel_kexec() =
unwind")
> Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>

AFAIK, preserve-context reboot is no longer used; in fact, it is
currently broken. I tried using it six years ago and hit an old
spinlock bug in the x86 code that prevented it, which means this path
touches dead code.

It was originally developed for machines lacking hardware support for
hibernation, and I can't imagine anyone using it today. (I know Amazon
is using it for a non intended reason and that is a very specific
scenario in a costumized kernel that internally fixes the upstream
bugs, and would not conlict with live update).

During live update, we cannot return to userspace after a successful
liveupdate_reboot(). We specifically place liveupdate_reboot() in the
kexec path as the last possible point of failure. Perhap, to guarantee
this behavior, we could  add !KEXEC_JUMP as a dependency to KHO and
LUO or crash the kernel.

Pasha

> ---
>  include/linux/liveupdate.h       |  5 +++++
>  kernel/kexec_core.c              |  6 +++++-
>  kernel/liveupdate/luo_core.c     | 11 ++++++++++-
>  kernel/liveupdate/luo_internal.h |  1 +
>  kernel/liveupdate/luo_session.c  | 23 +++++++++++++++++++++++
>  5 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index dd11fdc76a5f..d93b043a0421 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -226,6 +226,7 @@ bool liveupdate_enabled(void);
>
>  /* Called during kexec to tell LUO that entered into reboot */
>  int liveupdate_reboot(void);
> +void liveupdate_reboot_abort(void);
>
>  int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)=
;
>  int liveupdate_unregister_file_handler(struct liveupdate_file_handler *f=
h);
> @@ -250,6 +251,10 @@ static inline int liveupdate_reboot(void)
>         return 0;
>  }
>
> +static inline void liveupdate_reboot_abort(void)
> +{
> +}
> +
>  static inline int liveupdate_register_file_handler(struct liveupdate_fil=
e_handler *fh)
>  {
>         return -EOPNOTSUPP;
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 2fea396d29b9..95710a7d5e56 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1139,6 +1139,7 @@ bool kexec_load_permitted(int kexec_image_type)
>  int kernel_kexec(void)
>  {
>         int error =3D 0;
> +       bool liveupdate_prepared =3D false;
>
>         if (!kexec_trylock())
>                 return -EBUSY;
> @@ -1147,6 +1148,7 @@ int kernel_kexec(void)
>                 goto Unlock;
>         }
>
> +       liveupdate_prepared =3D true;
>         error =3D liveupdate_reboot();
>         if (error)
>                 goto Unlock;
> @@ -1230,7 +1232,9 @@ int kernel_kexec(void)
>         }
>  #endif
>
> - Unlock:
> +Unlock:
> +       if (liveupdate_prepared)
> +               liveupdate_reboot_abort();
>         kexec_unlock();
>         return error;
>  }
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index dda7bb57d421..95a0b81ce60d 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -233,8 +233,9 @@ int liveupdate_reboot(void)
>         err =3D kho_finalize();
>         if (err) {
>                 pr_err("kho_finalize failed %d\n", err);
> +               liveupdate_reboot_abort();
>                 /*
> -                * kho_finalize() may return libfdt errors, to aboid pass=
ing to
> +                * kho_finalize() may return libfdt errors, to avoid pass=
ing to
>                  * userspace unknown errors, change this to EAGAIN.
>                  */
>                 err =3D -EAGAIN;
> @@ -243,6 +244,14 @@ int liveupdate_reboot(void)
>         return err;
>  }
>
> +void liveupdate_reboot_abort(void)
> +{
> +       if (!liveupdate_enabled())
> +               return;
> +
> +       luo_session_abort_reboot();
> +}
> +
>  /**
>   * liveupdate_enabled - Check if the live update feature is enabled.
>   *
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_int=
ernal.h
> index 0cfc0269d746..8a6b1f6c9b4f 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -88,6 +88,7 @@ int luo_session_retrieve(const char *name, struct file =
**filep);
>  int __init luo_session_setup_outgoing(void *fdt);
>  int __init luo_session_setup_incoming(void *fdt);
>  int luo_session_serialize(void);
> +void luo_session_abort_reboot(void);
>  int luo_session_deserialize(void);
>  bool luo_session_quiesce(void);
>  void luo_session_resume(void);
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_sess=
ion.c
> index d97ec91e1118..200dd3b8229c 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -788,6 +788,29 @@ int luo_session_serialize(void)
>         return err;
>  }
>
> +void luo_session_abort_reboot(void)
> +{
> +       struct luo_session_header *sh =3D &luo_session_global.outgoing;
> +       struct luo_session *session;
> +       int i =3D 0;
> +
> +       guard(rwsem_write)(&sh->rwsem);
> +       if (!READ_ONCE(sh->rebooting))
> +               return;
> +
> +       list_for_each_entry(session, &sh->list, list) {
> +               if (i >=3D sh->header_ser->count)
> +                       break;
> +
> +               luo_session_unfreeze_one(session, &sh->ser[i]);
> +               memset(&sh->ser[i], 0, sizeof(sh->ser[i]));
> +               i++;
> +       }
> +
> +       sh->header_ser->count =3D 0;
> +       luo_session_reboot_done(sh);
> +}
> +
>  /**
>   * luo_session_quiesce - Ensure no active sessions exist and lock sessio=
n lists.
>   *
> --
> 2.53.0
>
>

