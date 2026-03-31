Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2A210F92E9
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DY3wbcvnuH3o7Ixe/6Ynw4mfzgsEK5w185n5jaWWQGM=; b=nQ+iq54kw0bE4hUfnBvW9y6ZK9
	hKyR8I2XObQ19GkBN9sUgt/RlIoQMFBqbFMOE3ADLpxSwx/4rodaKcvsS2pBc903PIv2tq2ZHtZfB
	OCvsuyPVJidbIvE7O7vLzB/FOutzBzUP5g9E2gVYprlOUHZlIKP8D5eUy70I7Q7ss/quzV34cER+q
	ZIFOTpA7oeWA5z2lHvXDE4orlHXnIR++TDDbwjc2kMoV+jbSTH0LPI00nDqFBdMFwDqnzETPsYpPR
	sl7iE4MO4bjpeVuSRTI0xdC/Xyj8dn40Mr08xDm4oR8QoVAFKDfTYgd3vgaLbQ7d/S+jO4JewGdVR
	FQpAS5vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7dvE-0000000DQgO-3ek5;
	Tue, 31 Mar 2026 18:34:40 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7dvC-0000000DQg1-26Am
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 18:34:39 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-b97a06d7629so900303666b.0
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 11:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774982076; cv=none;
        d=google.com; s=arc-20240605;
        b=Ur3XoBIZ6PDSUyeK6PN7o2WMXmM6qfUeEdBaD6pZNeKWY5lfkU4hwNCT2Dpb/f1Tka
         347Q6kKXGj1ieK0EoCFd+78+LcAXtca0f/r/YkJk69CcdBZWf2GD9lLTR8n/5poQ9Ti5
         piUzXZlPpRt3aziZPH3lffwlRDrL2T2nfuQoZYXxqSrZwy38hF2HUip3m6c9CThAcNpn
         0HSKnE1JyZZVKQmFKSTABPnm9hXUxbfVc12JefDZNny8cD02RcNYqZvDAzD7IzHNziP3
         kZ6r4ZuFniqsG0hCPKsEyyqfftZH7dTLcgFN67owdXKUwMrEtRVdAvtvSua07y9UwypY
         ZlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DY3wbcvnuH3o7Ixe/6Ynw4mfzgsEK5w185n5jaWWQGM=;
        fh=ni37SOhjHixerEV2bxAsx42kJLTA6jFmDw61VZmbkYs=;
        b=b764PX2E3MHcBzpyxwY21Of5249Y/x4hZ7KU60Mk8xn0lW8ezPoVq3y8L6Q2KOWyt5
         /36hvnLK2D/kt8YOL0QmSSAiYzjNUt50hPxhhJeOu4DYCsTfjXe/youQPwpw5SyXm3fF
         SmiZcKl3wPvSwAAqjDAY6kBvdk4m4RPm87WpJ4yRNqanGOeyFUqNbLW6KKeMPJrEzJ6S
         FhJhtKiCjMRv6X9PnmkfwsR/3/g/h/Htvu9OBmNJqgUNyZrHffEYHzyx2on/LpaeGCtv
         rKmYZG7WPdHMVUH0TuKLYXb/DA/Zo010a4GwsIgwFLY7b+kcUPGqguC9AcJ+o7Zj88W9
         /UXQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774982076; x=1775586876; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY3wbcvnuH3o7Ixe/6Ynw4mfzgsEK5w185n5jaWWQGM=;
        b=h258UTUW4sSgj8cHMzcTnJ5vOGtERpABfOea8pAao4fsj6WwIdMMFjibrP+MewW2D+
         aszCqS9iXqLRXeJX9YNb5RUn/NCq+1tBh5dEaRgVqNwP81z0WIZQ/GbuZQYZR7l9cZe9
         IFk8C9phnTp3XZmBrpAHa/bsnUgEKZxvzgKWzBzgw9P9DYpX2zcnMZrdHX3tgJkbCsHX
         EtZRSj9WnT2PFcLOVZxy5ePW8HmkUAggHaPv44ILMcErKlwj6HngDWHW7KkOjdpy0ERM
         OAGOk0ihK0vPHE8qlqp0Qd0JDfgGVl/0T5gL+XXjiR89SIXlsuo09cii4ylYn8iyMoHA
         Td+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774982076; x=1775586876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DY3wbcvnuH3o7Ixe/6Ynw4mfzgsEK5w185n5jaWWQGM=;
        b=CmUg9dWhVmPlIKy/HJs1CqaFlqJ+zScgW61BG/gzszsyZ97o77+Fl7TtZekIUxusbl
         yUYVnvUL9/yZbKE3xsHV+7fZZ8GrzOvEVX/utFhNecTqEOQQRLSUXADOrn6C6d6lq+7F
         K+mJ68yObYlwzQpvm6A6/qUifbMrZkOpHdHoGXeeKHiuSdziKV0zbYNWVjekCdZ6ClMl
         oY8aPn0nA3vs112OKmJLDOARORrq95yySNS7CVKv5U+gIFFbNcFxUISnyEzzJnrq2CfF
         Ow0xaMo6SjIdFtBZJipfjPGnA3IBW2EqnzGAevfRHQY0sF3YQ8SOSOgLs71sX72aYrEq
         KCdg==
X-Gm-Message-State: AOJu0YyNUWu4yJn/GXZlzxSiVu/lAz7as4+DF3xQQYiDFvHid1y07AEx
	CBslqfepQQXR+H7WKUEMay2o2uVS8LZrVHk2HvQdOJzCVTLrVEN6EKYMtGyTYoXU81KFgIjrng5
	eRp1hWMqxGDnf4hO+9+PPTWFsW2sWvbmYll8I4p3rWg==
X-Gm-Gg: ATEYQzz42QfvdTZMiL5MrylX0hfHf7orNwHiGfthqIkSuss/VC+lEOqGR7JwQa/MdW6
	+3F01JvuAXKMQdhFr5BkEVCL2wp+TIl0KsApi+VC9I0+FeLRl1rg3pMPqqkByP4KxIou1SmRJdI
	EJYNx9x5oXZfbTYwSD2xjjA1tPzzd/3CciQn0D97jetIk9qpuanioErZ0+b5eTCiF2tVkw+WLg1
	Y6KYTv+GwNnrD8YAbOWyODnm9hRi8u6ut/aYqr2AS6GCH35KEhTTK0YpS/H4YmSgywI6TFx5qyP
	hDawKunUpoanulK2vkRVv4TnroJbmdphRWFF9w==
X-Received: by 2002:a17:907:84d1:b0:b9b:fd23:d0c8 with SMTP id
 a640c23a62f3a-b9c13b0fd96mr41864466b.29.1774982076111; Tue, 31 Mar 2026
 11:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260331175639.4066033-1-luca.boccassi@gmail.com>
In-Reply-To: <20260331175639.4066033-1-luca.boccassi@gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 31 Mar 2026 14:33:59 -0400
X-Gm-Features: AQROBzBHBf68DKK7aZZU4u2jQSiYayfjEGRzUDBkbeEz7PAvcd2w4jNJnR0shvA
Message-ID: <CA+CK2bCKJ8rkJ_onp9Za0KNuWujH4Gzue3a=HvwOJAK2tYhReA@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_113438_593815_62BF4636 
X-CRM114-Status: GOOD (  39.16  )
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

On Tue, Mar 31, 2026 at 1:56=E2=80=AFPM <luca.boccassi@gmail.com> wrote:
>
> From: Luca Boccassi <luca.boccassi@gmail.com>
>
> Userspace when requesting a session specifies a name and gets a FD,
> but then there is no way to go back the other way and get the name
> given a LUO session FD. This is problematic especially when there
> is a userspace orchestrator that wants to check what FDs it is
> handling for clients.
>
> Resolving the /proc/self/fd/X is lossy as that has a hard limit
> of characters, so names might be truncated. Also requiring going
> through procfs and doing manual string mangling is not a nice
> pattern.

Hi Luca,

Thank you for working on this.

This needs more explanation. The way I see it, the user orchestrator
can be the only one that has access to /dev/liveupdate (and this is
actually enforced by kernel). It opens it and creates session_fds for
any client out there. So, the orchestrator already has the FDs and
sends them to clients(e.g. via SCM_RIGHTS). It then monitors the PIDs
of the clients, and if they die, it closes the session_fds for them,
as their data does not need to be preserved.

Could you please explain why the user orchestrator would need to query
the session_fds, since it is the one that creates them in the first
place and has to keep them open in order to preserve them during a
live update?

Thank you,
Pasha

>
> Add a ioctl to simply get the name from an FD.
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> Need this for integration in systemd, so that I can check what
> FDs I get from clients and what they are, and so that I can know
> where to hand it back to
>
>  include/uapi/linux/liveupdate.h               | 19 +++++
>  kernel/liveupdate/luo_session.c               | 13 ++++
>  .../testing/selftests/liveupdate/liveupdate.c | 72 +++++++++++++++++++
>  3 files changed, 104 insertions(+)
>
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupd=
ate.h
> index 30bc66ee9436a..41dc44d239dde 100644
> --- a/include/uapi/linux/liveupdate.h
> +++ b/include/uapi/linux/liveupdate.h
> @@ -59,6 +59,7 @@ enum {
>         LIVEUPDATE_CMD_SESSION_PRESERVE_FD =3D LIVEUPDATE_CMD_SESSION_BAS=
E,
>         LIVEUPDATE_CMD_SESSION_RETRIEVE_FD =3D 0x41,
>         LIVEUPDATE_CMD_SESSION_FINISH =3D 0x42,
> +       LIVEUPDATE_CMD_SESSION_GET_NAME =3D 0x43,
>  };
>
>  /**
> @@ -213,4 +214,22 @@ struct liveupdate_session_finish {
>  #define LIVEUPDATE_SESSION_FINISH                                      \
>         _IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
>
> +/**
> + * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAM=
E)
> + * @size:  Input; sizeof(struct liveupdate_session_get_name)
> + * @name:  Output; A null-terminated string with the full session name.
> + *
> + * Retrieves the full name of the session associated with this file desc=
riptor.
> + * This is useful because the kernel may truncate the name shown in /pro=
c.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +struct liveupdate_session_get_name {
> +       __u32           size;
> +       __u8            name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +};
> +
> +#define LIVEUPDATE_SESSION_GET_NAME                                    \
> +       _IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
> +
>  #endif /* _UAPI_LIVEUPDATE_H */
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_sess=
ion.c
> index 4a40c7fdfb44f..819e8864869fd 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -289,10 +289,21 @@ static int luo_session_finish(struct luo_session *s=
ession,
>         return luo_ucmd_respond(ucmd, sizeof(*argp));
>  }
>
> +static int luo_session_get_name(struct luo_session *session,
> +                               struct luo_ucmd *ucmd)
> +{
> +       struct liveupdate_session_get_name *argp =3D ucmd->cmd;
> +
> +       strscpy((char *)argp->name, session->name, sizeof(argp->name));
> +
> +       return luo_ucmd_respond(ucmd, sizeof(*argp));
> +}
> +
>  union ucmd_buffer {
>         struct liveupdate_session_finish finish;
>         struct liveupdate_session_preserve_fd preserve;
>         struct liveupdate_session_retrieve_fd retrieve;
> +       struct liveupdate_session_get_name get_name;
>  };
>
>  struct luo_ioctl_op {
> @@ -319,6 +330,8 @@ static const struct luo_ioctl_op luo_session_ioctl_op=
s[] =3D {
>                  struct liveupdate_session_preserve_fd, token),
>         IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
>                  struct liveupdate_session_retrieve_fd, token),
> +       IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
> +                struct liveupdate_session_get_name, name),
>  };
>
>  static long luo_session_ioctl(struct file *filep, unsigned int cmd,
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/test=
ing/selftests/liveupdate/liveupdate.c
> index c2878e3d5ef90..510a583371fac 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -102,6 +102,22 @@ static int create_session(int lu_fd, const char *nam=
e)
>         return args.fd;
>  }
>
> +/* Helper function to get a session name via ioctl. */
> +static int get_session_name(int session_fd, char *name, size_t name_len)
> +{
> +       struct liveupdate_session_get_name args =3D {};
> +
> +       args.size =3D sizeof(args);
> +
> +       if (ioctl(session_fd, LIVEUPDATE_SESSION_GET_NAME, &args))
> +               return -errno;
> +
> +       strncpy(name, (char *)args.name, name_len - 1);
> +       name[name_len - 1] =3D '\0';
> +
> +       return 0;
> +}
> +
>  /*
>   * Test Case: Create Duplicate Session
>   *
> @@ -345,4 +361,60 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
>         ASSERT_EQ(close(session_fd), 0);
>  }
>
> +/*
> + * Test Case: Get Session Name
> + *
> + * Verifies that the full session name can be retrieved from a session f=
ile
> + * descriptor via ioctl. This is important because /proc may truncate th=
e
> + * anon_inode name.
> + */
> +TEST_F(liveupdate_device, get_session_name)
> +{
> +       char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] =3D {};
> +       const char *session_name =3D "get-name-test-session";
> +       int session_fd;
> +
> +       self->fd1 =3D open(LIVEUPDATE_DEV, O_RDWR);
> +       if (self->fd1 < 0 && errno =3D=3D ENOENT)
> +               SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +       ASSERT_GE(self->fd1, 0);
> +
> +       session_fd =3D create_session(self->fd1, session_name);
> +       ASSERT_GE(session_fd, 0);
> +
> +       ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)=
), 0);
> +       ASSERT_STREQ(name_buf, session_name);
> +
> +       ASSERT_EQ(close(session_fd), 0);
> +}
> +
> +/*
> + * Test Case: Get Session Name at Maximum Length
> + *
> + * Verifies that a session name using the full LIVEUPDATE_SESSION_NAME_L=
ENGTH
> + * (minus the null terminator) can be correctly retrieved.
> + */
> +TEST_F(liveupdate_device, get_session_name_max_length)
> +{
> +       char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] =3D {};
> +       char long_name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +       int session_fd;
> +
> +       memset(long_name, 'A', sizeof(long_name) - 1);
> +       long_name[sizeof(long_name) - 1] =3D '\0';
> +
> +       self->fd1 =3D open(LIVEUPDATE_DEV, O_RDWR);
> +       if (self->fd1 < 0 && errno =3D=3D ENOENT)
> +               SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +       ASSERT_GE(self->fd1, 0);
> +
> +       session_fd =3D create_session(self->fd1, long_name);
> +       ASSERT_GE(session_fd, 0);
> +
> +       ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)=
), 0);
> +       ASSERT_STREQ(name_buf, long_name);
> +
> +       ASSERT_EQ(close(session_fd), 0);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.47.3
>

