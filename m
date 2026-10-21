Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8B606A324
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hn29aBU4;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ObzTRRDk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elbAOUhGKDzUinaTQ0302ZCYZ7inGoSdWd2JTt/hv+g=; b=Hn29aBU4RHpNfLGRZalftAzCXU
	QwWOH6MqP7OJujJMF/5X6ljI9PFasFpkBBRPn0DsjWsLMV7bDfLhgiM9J0shHTBZLgQh2QCkOllmF
	+5qjOJDTvf/W/HyekzOX4+L7dw38tMydtToZLbnQrgOXmIS2tXaNGOq0ZjIJkZXEifxAikOwLuoQm
	0d0+GgeuwEY/uXnbKk9c0/OU80NzrQGStYbaHTeh4AwCf7Z2/L51HZyhZo7Psw6iUj0cokuEemZCb
	/q7CaAZoubJE5cGXktMjxTaU+E2rCkdKM+RObimZb5V4VY7ikiVzbL11MujUiYiDnBgaqddVRpb+5
	lZxyXn/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJZww-0000000CXL7-27lm;
	Wed, 21 Oct 2026 17:18:02 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJZws-0000000CXJU-3Gte
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 17:18:01 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c3fd91337baso138587566b.3
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 10:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792603077; cv=none;
        d=google.com; s=arc-20260327;
        b=l7X5imiy0DrP1Y4Wp1T2H7siKP1isH6z+K6NE50uZikg4TBzAWV0wp71CAlj5k8xxW
         A8o2M7HCgclAQPRf3ohOmC3nXYUwFEG2jFQwXVeoVR2ACRtVc2w5jfmipuKPtMPFkN89
         CheVmyZ5dBAdHQZOgnJwd7jOcOQKdQZRXh+uFM0PTXTZLhYLJzl4FpaXvUqUBydtuPVd
         NZUjD31kI0GTLOkFzYpH9+beBfzMAWc0+eBmyyBTsq1POLXbV4IqKUL7gK7HVZtvli9z
         QbufTlBGFSMCq6rC3mkfBBpl0cMCRPPewli6lm73PcXIMJI+dGfmnxh75zneGQh9uiKL
         UZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=elbAOUhGKDzUinaTQ0302ZCYZ7inGoSdWd2JTt/hv+g=;
        fh=rEcu85+IkHKsca1ZlU9egh7etcO4JQZSPzfwReunzas=;
        b=HDAd3AKD+M4Slq2Sc3kVJPO2ucjJMR92K1OpVLefT5STsye89UcuINH26chsbAc2XQ
         Dly1X0L1sel+P01NgYKOiIuFxXAYdzEnIayXGK5l2R5KztAsO7T8DRgZaiM34TcWFEgw
         WsU5qh0OCD/JicaeMYLfmNV5zDznzOyNkK3KpSvON4er66sGMKjBG1A+A45UZvOHzLQD
         UYWnm+mz1dXzIB1uZtfO5aSFqVNc6pR7mUs+NpEfV7jaIiy92+/NX12V0yKvXeUDL9OS
         Q9yVPxAsecAHDkfzppQZmSEDxC2V9zZcBUEJwE/2R3+7x/75th6KWbtL1mkmEOKSobTd
         MHUg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792603077; x=1793207877; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=elbAOUhGKDzUinaTQ0302ZCYZ7inGoSdWd2JTt/hv+g=;
        b=ObzTRRDkCvX+leRLl0LWibecMFebyxX93xwwRwdjTG+Ha7EKU6PqU5bFw1hKa0Jfdk
         GVk8bxD0qpMw8ZdAx5q04evqfhWlWEs+AgNCYwL/i0uhHvVPOzYg6aqUa53DUyZLWiy6
         IrdUMrWz5+Pki8eU2xX5JmDxrOOOd7n9VPyma1aWjhYGtRXFp1zaFpWrcJUrweHvOzNT
         M/af7NE8qLTpuBkRNXwuKFLipT5CGl2jzT7EYUmyh8FrejsSraJab9MdZuKSPIz39REe
         PNUWFSJVqfnxgd9/JAJ+PYIrTtF0xjtX2cKOYt4cWHlYJlVuccObGOHabKiv62udYkdi
         F+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603077; x=1793207877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elbAOUhGKDzUinaTQ0302ZCYZ7inGoSdWd2JTt/hv+g=;
        b=zm6lYkLHsOnszBakj3zhQANwMG/Rq/ERDlZsmXqgDiSpA/WPAQz3zs52F/vnBCa6vZ
         JsnIfMhkHPuHCKwVMnnFhDn/S+nYsE9DPCQP7CYt4RZl5uCgrdYibGOdgSV518plea+R
         SAB/2LOXAU2v96t0CXZC2LiGMBvfFYJV+e28rR4YAquwt5du5COPPtgNh395g9/3WT36
         bOfYG7odiVVfI1ZeJlhkqtde02PeGJ8MKSrNeS/Q5r/JOLVYMqPJSKpFo/eOZXxFq/7Y
         /hsJj6pAsad34aQ4Cp5+vdV8L92e/M+chcYkHY3dkEzP0HH/FMmMvXaeaAumPQerb5cJ
         C2wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcTaRhIDH5Tssqp4Gv4oeRigs/nL7SriB3L9oJTc9NzOnzgqBOwn9aqV4f+p6tRhGXIXAJsQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYK5iKp/cToKcLOZKjtfv/X/nSwNcZDdBsHYGDOJDu6MhxwtpV4v
	JBXhUd6n9HsULtGpxpBWNF2SmhKNx+OGpKEcEmR9WRgXtRtt/84UUWUkh6w6mOKWAB33aCP5CoF
	5FaWJVLP3uF4OOwCfDtxrI9IMud281tZ0jNdZo2mryQ==
X-Gm-Gg: AYBFou3v8UyjQMI3kTK8XULF0ugSzGD+SAr6mk4QlnujZNZX1/hzP1np9k7x6cXLD20
	KmRvqG7pucRj+F3aV0Wy0JhPWseTeX8u7JhhOZ106UsZNFSCYzNWA8uLvOnSuxC+j1QsM4whDb8
	U2qNpp3Zx63TEVd4jABQedA1ox+vzxg2gPkoBW703tw/funxEpIeRPs6TQbhstqgtdUkahGAJwO
	dAgDe3duoTQ2PM12btdnI2uathmfy86Qxyr0+XZEqflWJ9sIurZcaHaOH6WT9ITIWIN5zJ4gQNj
	U6N/nrGt1Cxxhy/y+5VenmdlqpQYPs9a5VvN3AKkN6lP67OJNgq2AvKF14EVl2dFPVQGtivJ8+e
	Un7D4h6726B6ILlN4jQxSRoZ992b0KoWWUGhgqFCTCu06uWyXnZctEFOZvNQ5d6/LDf4=
X-Received: by 2002:a17:906:f597:b0:c3e:f39b:2286 with SMTP id
 a640c23a62f3a-c4678f7c6cemr225893866b.0.1792603076743; Wed, 21 Oct 2026
 10:17:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-3-tarunsahu@google.com>
In-Reply-To: <20261021152527.375070-3-tarunsahu@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:17:19 -0400
X-Gm-Features: AclHuK-IkiswuL9j-om2-Yvi6ZhWxvxntziJi6QKVuLB1ELR4YcI0vWO7hzjpeA
Message-ID: <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_101758_877168_68BDBF11 
X-CRM114-Status: GOOD (  36.74  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.com> =
wrote:
>
> Currently luo_preserve_file() iterates over luo_file_handler_list and
> picks the first registered handler whose .can_preserve() callback
> returns true. When a subsystem introduces a new, backwards-incompatible
> file handler alongside an existing one for the same file type, userspace
> has no way to choose which handler preserves a file descriptor, nor can
> the kernel keep the existing rollback-safe handler as the default while
> allowing callers to opt into the new handler.

That is not how it will work. If we are in the .can_preserve() call,
it means the user has already decided which file handlers to use. We
need to do that before any preservation happens; otherwise, we could
run into conflicts on FLBs i.e. FH of different version require
different FLBs.

Therefore, there should be a luoctl call (i.e via a new ioctl to set
compatability) that provides the kernel with the specs file of the
target kernel we are updating to, allowing the kernel to select the
compatible file handlers. Since .can_preserve() is called when the
user is already preserving files, the specification must have already
been supplied, or the kernel should fall back to using the default
(i.e., latest) file handlers.

>
> Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
> liveupdate_session_preserve_fd immediately after token, keeping
> IOCTL_OP min_size at offsetofend(..., token) so callers passing the
> original 16-byte structure continue to work:
> - When handler is empty (all-zero, or zero-filled when userspace
>   passes the 16-byte structure), luo_preserve_file() selects the first
>   registered handler whose .can_preserve() callback accepts the fd.
> - When handler is non-empty, it must be null-terminated within
>   LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
>   luo_preserve_file() looks up the registered handler with that exact
>   name (returning -ENOENT if unknown) and verifies that its
>   .can_preserve() callback accepts the fd (returning -EINVAL if not).
>
> The retrieve ioctl is unchanged because the handler is identified by the
> name stored in the serialized payload from the source kernel.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/uapi/linux/liveupdate.h  | 12 +++++++++---
>  kernel/liveupdate/luo_file.c     | 21 ++++++++++++++++++---
>  kernel/liveupdate/luo_internal.h |  3 ++-
>  kernel/liveupdate/luo_session.c  |  7 ++++++-
>  4 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupd=
ate.h
> index 509c6236720d..2413b19dabc1 100644
> --- a/include/uapi/linux/liveupdate.h
> +++ b/include/uapi/linux/liveupdate.h
> @@ -126,9 +126,14 @@ struct liveupdate_ioctl_retrieve_session {
>
>  /**
>   * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_PRES=
ERVE_FD)
> - * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
> - * @fd:    Input; The user-space file descriptor to be preserved.
> - * @token: Input; An opaque, unique token for preserved resource.
> + * @size:    Input; sizeof(struct liveupdate_session_preserve_fd)
> + * @fd:      Input; The user-space file descriptor to be preserved.
> + * @token:   Input; An opaque, unique token for preserved resource.
> + * @handler: Input; Optional null-terminated file handler name (max leng=
th
> + *           %LIVEUPDATE_HNDL_NAME_LENGTH including null terminator) sel=
ecting
> + *           which registered handler preserves @fd. If empty (all-zero,=
 or
> + *           omitted when passing the 16-byte structure), the kernel sel=
ects
> + *           the first registered handler whose .can_preserve() accepts =
@fd.
>   *
>   * Holds parameters for preserving a file descriptor.
>   *
> @@ -152,6 +157,7 @@ struct liveupdate_session_preserve_fd {
>         __u32           size;
>         __s32           fd;
>         __aligned_u64   token;
> +       char            handler[LIVEUPDATE_HNDL_NAME_LENGTH];
>  };
>
>  #define LIVEUPDATE_SESSION_PRESERVE_FD                                 \
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index fb81239bedf3..be20e0f1e0aa 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -207,6 +207,8 @@ static bool luo_token_is_used(struct luo_file_set *fi=
le_set, u64 token)
>   * @file_set: The file_set to which the preserved file will be added.
>   * @token:    A unique, user-provided identifier for the file.
>   * @fd:       The file descriptor to be preserved.
> + * @handler:  Optional NUL-terminated handler name. If NULL or empty, th=
e first
> + *            registered handler whose .can_preserve() accepts @fd is se=
lected.
>   *
>   * This function orchestrates the first phase of preserving a file. Upon=
 entry,
>   * it takes a reference to the 'struct file' via fget(), effectively mak=
ing LUO
> @@ -238,11 +240,13 @@ static bool luo_token_is_used(struct luo_file_set *=
file_set, u64 token)
>   *         -EBUSY if the file descriptor is already preserved by another=
 session.
>   *         -EBADF if the file descriptor is invalid.
>   *         -ENOSPC if the file_set is full.
> - *         -ENOENT if no compatible handler is found for the file type.
> + *         -ENOENT if no matching handler is registered or accepts @fd.
> + *         -EINVAL if the named handler cannot preserve @fd.
>   *         -ENOMEM on memory allocation failure.
>   *         Other erros might be returned by .preserve().
>   */
> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
> +                     const char *handler)
>  {
>         struct liveupdate_file_op_args args =3D {0};
>         struct liveupdate_file_handler *fh;
> @@ -266,6 +270,18 @@ int luo_preserve_file(struct luo_file_set *file_set,=
 u64 token, int fd)
>         err =3D -ENOENT;
>         down_read(&luo_register_rwlock);
>         list_private_for_each_entry(fh, &luo_file_handler_list, list) {
> +               if (handler && handler[0]) {
> +                       if (strcmp(fh->name, handler))
> +                               continue;
> +                       if (!fh->ops->can_preserve(fh, file)) {
> +                               err =3D -EINVAL;
> +                               break;
> +                       }
> +                       if (try_module_get(fh->ops->owner))
> +                               err =3D 0;
> +                       break;
> +               }
> +
>                 if (fh->ops->can_preserve(fh, file)) {
>                         if (try_module_get(fh->ops->owner))
>                                 err =3D 0;
> @@ -274,7 +290,6 @@ int luo_preserve_file(struct luo_file_set *file_set, =
u64 token, int fd)
>         }
>         up_read(&luo_register_rwlock);
>
> -       /* err is still -ENOENT if no handler was found */
>         if (err)
>                 goto err_fput;
>
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_int=
ernal.h
> index dac6644bfb18..911ffedec9f3 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -101,7 +101,8 @@ int __init luo_session_setup_incoming(u64 sessions_pa=
);
>  int luo_session_serialize(void);
>  int luo_session_deserialize(void);
>
> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
> +                     const char *handler);
>  void luo_file_unpreserve_files(struct luo_file_set *file_set);
>  int luo_file_freeze(struct luo_file_set *file_set,
>                     struct luo_file_set_ser *file_set_ser);
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_sess=
ion.c
> index f48e9a4185f9..194ef45907c1 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -266,8 +266,13 @@ static int luo_session_preserve_fd(struct luo_sessio=
n *session,
>         struct liveupdate_session_preserve_fd *argp =3D ucmd->cmd;
>         int err;
>
> +       if (strnlen(argp->handler, sizeof(argp->handler)) =3D=3D
> +           sizeof(argp->handler))
> +               return -EINVAL;
> +
>         guard(mutex)(&session->mutex);
> -       err =3D luo_preserve_file(&session->file_set, argp->token, argp->=
fd);
> +       err =3D luo_preserve_file(&session->file_set, argp->token, argp->=
fd,
> +                               argp->handler);
>         if (err)
>                 return err;
>
> --
> 2.56.0.212.g129ede20d9-goog
>

