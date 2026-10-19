Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BE606A319
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iROGn5HU;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=k/4afkAd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UDVr2jRR6Ik9p8PRWRYl4J4mWZgBLdNkTR6eKk/XdxA=; b=iROGn5HU2Q4V3nto1ZHPTDupz7
	24cWGKLM08AOj+t58WLvBRm1KQCb4B5agfQFk/FKwjAf87rpZMm9365JZzbIlyqxPd4VL2l02nbH+
	5u+G6AQlx8pGiat5BAb+T9DqR4LlbrYmI9e2HBl4E7DxziqPPLNtcsNVfKU6JPunT60xlBbtJl36d
	gx6pn7+7Jy15YoIkdDZWKRr1XnKj5YNw5q/n0VfsHHm03l9jXMnygfU385kSptdUFipOgy9TkhFR/
	yXHP/ZTmAq27de9AC0pUnVgorHt095ogV9hEX/iZvKVC5ZxQ/UHezk1ScdkO2kCz5iUuvrzSkiejl
	7trG0EOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIt62-00000008Fig-0BRS;
	Mon, 19 Oct 2026 19:32:34 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIt5z-00000008Fhk-2D0Z
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 19:32:32 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so2963098a12.3
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 12:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792438350; cv=none;
        d=google.com; s=arc-20260327;
        b=rpjPIgMdpdxXoiUNendnVhIAOD4sKoOIytaieA7VXAJO08pLQOTallsSBo9JLxF9Yw
         TA82BVz6aVMfY33SRAaqvKurHBLHCCSrlZNjGcTFwZMuledtxWzA+Q/qyiv+WhA4uIPj
         OyQ0E92TOM4b2d2WCyEQCeOVaAXSa4epncKnVByMbinG28nO9xBByYqSu5I34399+S/K
         6mJ1KoUWiH4CT7UpUzVMm8kgoRlFkNZRZZuoPG1U1TErLQSbtdCN7UuxBUfJvimc7M1L
         IBCtkwfpU5KNatjVrRmcTu05FAMEHrECYNaZWF2lDRrjCHT7OYVXO72oCJcRHhts+Qea
         3WfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UDVr2jRR6Ik9p8PRWRYl4J4mWZgBLdNkTR6eKk/XdxA=;
        fh=vQaGEYiFtR0K8Ox0pXFRRG32TD8g7rZhmRR9So4llCw=;
        b=kFZdz+1fcb1j2bsOVnJLIVUh1m95AckvAYHhH8HBXB7oPwTQn3KLfpqKYNNrn0QZi1
         Dnx9WdgeJobwjjTF88XclJAgt6SQVYrVqQJQvwYPAHxJ12CEK8frcfvbMCn7QrtSqrxt
         zoPZm2aQCeF0Q/kiA7Wrma8n77CpdwYZazwf7ZshznwEP2xap+LU+Ehc88sM3nHhokuW
         b8CQ66rRBhoktFTHcOAXSkpaY0vPlzYolHm4VjDYpnp1KD10gZeHfqMUiShaIR4xWwjR
         gmUFryI0LqDLFaSrwC6SLjk5h3S2fWLNQ5kJIPYhTo2HdVzKta2x/txDRmowICU9oj25
         aR9w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792438350; x=1793043150; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UDVr2jRR6Ik9p8PRWRYl4J4mWZgBLdNkTR6eKk/XdxA=;
        b=k/4afkAd8Qe+OxXOhtyLzrBu4TUqxf2KYZsGl0QSN4CkES9yD747qeWGa9Xx7reCBS
         kSOcxBKl3udXKvtpJ0LQ51kMoKnxgb531uXAwI78BcE7iDFkSEKcTIetX+94Xt4CldC3
         A2u3znc5djDN/xGaiUxajeLwhGxEwjbFNc/gwTECN1b752PUFIUD3hLkYxNJqJuL6XOn
         UtWI5XkKnrpC2QzuYUqMgnMLdkCaDhvlTy/f8E6sqIIrDkxLnTHx6uQL8DMpid/pqGW/
         bgI73DBbEt7+MZnSGit6XE75Vf/ewSWJi89Mb4L4asW2ES0nM6J/I3kBcqxloIOJYesD
         Sb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792438350; x=1793043150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDVr2jRR6Ik9p8PRWRYl4J4mWZgBLdNkTR6eKk/XdxA=;
        b=d2qXu6uYLgdSkwQW6DMDC4loF+wr2JZo+h7Ga7Dze0Ebmf8Tx5/OimJ+dek0tywZww
         +GfJU38JNPIACuLiyAKB61NtlAF8jBl/UXqEXngJPfZ/bflGRzar3UI9D17UkQtRnMPV
         RLbPTqsWio38wepohWi8G8S46B3Ns4u9x2q59IImucf+/9rUfO224EAnhy8RtVkAkssk
         NJPYXXwv0vICxzrt4sKuCv3rDQQX+Gd5hn/8vwBRNIfSBw86kp+FdWvgXAWIpnLOWbuH
         j5B9Za3LWdibb8/Qt14oQcvLHhFCiL3Hw9uDBqLkz7PwtkYorgI5wL/863fE/z6ZUDzh
         NZYQ==
X-Forwarded-Encrypted: i=1; AKwUvByqKWVmsdBZAYD2Gd/+/qXt+G/NpRi2PaNertfJXus7hWgaiFJLoEwUwLUbLBjLAP+xETN7MA==@lists.infradead.org
X-Gm-Message-State: AFq9FYLsNFjqpEqdUMWGbMTO66aI9UiUh3IxYhvmfYp+NgC/ToWy29MG
	eyadCOvTuTrtLbTaLcF7vNmjAnrdMQDqCPlBMFSStVOJ111nEPeC80a/+l1hkBy3BE0Lf3D1ZOf
	/MsKUrGF3Qmzws5+kVFdz4V3Co1QlGMXxmYo39ya6lA==
X-Gm-Gg: AYBFou0+mjJ+23a44+jQybir9OwBCfDYiFKEOMAO3KM4OGZCUglwfARAV2gHYnMka1Z
	wSyGm1MA2RvCeRmMvzqmUJ9dlafn49PwmkK5X3KwIUjCrHVa4kEY4jCS20ePLfQJnokF9xCSEGt
	BNS2Jf1UwsMwXQVdRo5aH2R6+bJVEWB/YgTy5qy0/BNseffU6Ss1nEYjTvdHarLTJOI4rF646a1
	2WAApTB8dbDWmUN6u3PLVH/rrmkQBlEtVx1EMlA1M5YAxHZvbn4ONc33X2bCGYxn/ZcCgO0nhNk
	ENcQgPOtfxPBfBWX7Fk8jOJH9TARXOp+zjRG0u3CzQW7zFBx6jlIEkpv4sUSsT8iIr7JukaypDz
	cs4UeIW7HnJHfiFuRm4gkd+fbrAA2JoiVEbyKJN9NioCLrZPcM/Ck4YjJNbMtqPlz+kE=
X-Received: by 2002:a05:6402:46ce:b0:6ac:9a44:d404 with SMTP id
 4fb4d7f45d1cf-6b3a80333f9mr4787170a12.0.1792438349280; Mon, 19 Oct 2026
 12:32:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-4-pasha.tatashin@soleen.com> <9huzwlrdh4q4.fsf@tarunix.c.googlers.com>
In-Reply-To: <9huzwlrdh4q4.fsf@tarunix.c.googlers.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 19 Oct 2026 15:31:50 -0400
X-Gm-Features: AclHuK9RhOF8P0_iSDq0R6E-rGot2pIUv8sHnfpDWRrrJfxNdPKGST9db7rmV8M
Message-ID: <CA+CK2bD83qVv54_Wps4GRr9otg32pW2A01WVTo-gTR=oYs95Vw@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] liveupdate: Pass user argument to file preserve
 and retrieve
To: tarunsahu@google.com
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com, 
	linux-kernel@vger.kernel.org, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, graf@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_123231_747343_8F4AFEF0 
X-CRM114-Status: GOOD (  42.93  )
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 3:26=E2=80=AFPM <tarunsahu@google.com> wrote:
>
>
> As Per Today's Hypervisor liveupdate meeting, This patch will be picked
> by @dmatlack@google.com for latest tmpfs preservation series.
>
> I have a suggestion to make here.
>
> Let's send this patch as a saperate patch so that I can also use this in
> my guest_memfd preservation work. This will help landing this feature
> sooner and unblock other subsystem who needs it.
>
> Let me know what you think?

Hi Tarun,

You can include this patch the next time you send your guest_memfd
patches. Whichever series lands first will pull in this change.

We are trying not to merge new features without an actual user,
especially ones as important as those changing the uapi. I think tmpfs
preservation may actually make it easier to land, as it only changes
the code that we maintain.

Thanks,
Pasha

>
> ~Tarun
>
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > Allow userspace to pass a file-handler-specific argument structure when
> > preserving or retrieving an FD via LUO. File handlers may need
> > additional context during preservation or retrieval, such as a target
> > FD, device location, or handler-specific parameters, without introducin=
g
> > separate ioctls for each file type. Whether the argument is required,
> > optional, or unused is defined by the file handler.
> >
> > Extend struct liveupdate_session_preserve_fd and
> > struct liveupdate_session_retrieve_fd with a 64-bit arg field pointing
> > to a handler-defined argument structure that begins with a 32-bit size
> > field. Because IOCTL_OP validates a minimum size up to the token field,
> > existing callers passing the 16-byte struct remain compatible and have
> > arg zero-filled by copy_struct_from_user().
> >
> > Add parg and rarg (struct liveupdate_arg_spec) to
> > struct liveupdate_file_ops, initialized via LIVEUPDATE_ARG(_struct,
> > _min_last), which records the full struct size and minimum required siz=
e
> > while enforcing at compile time that handler argument structures begin
> > with a 32-bit size field. When arg is non-zero, LUO validates the
> > minimum size and copies the user argument via copy_struct_from_user() u=
p
> > to the handler's expected size and passes the kernel copy in
> > struct liveupdate_file_op_args, or returns -EOPNOTSUPP if the handler
> > does not accept an argument.
> >
> > Also provide liveupdate_claim_file() and liveupdate_unclaim_file() so
> > handlers whose .retrieve() callback restores state into an existing
> > user-supplied file descriptor can claim it in luo_preserved_files befor=
e
> > modifying the file.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/liveupdate.h       | 60 +++++++++++++++++++
> >  include/uapi/linux/liveupdate.h  |  6 ++
> >  kernel/liveupdate/luo_file.c     | 99 +++++++++++++++++++++++++++++---
> >  kernel/liveupdate/luo_internal.h |  5 +-
> >  kernel/liveupdate/luo_session.c  |  6 +-
> >  5 files changed, 164 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> > index 885ec0bbc4b8c..52d3f453ae011 100644
> > --- a/include/linux/liveupdate.h
> > +++ b/include/linux/liveupdate.h
> > @@ -22,6 +22,36 @@ struct liveupdate_flb;
> >  struct liveupdate_session;
> >  struct file;
> >
> > +/**
> > + * struct liveupdate_arg_spec - Specification of a file handler user a=
rgument.
> > + * @size:     Full size of the argument structure in the current kerne=
l.
> > + * @min_size: Minimum valid user-supplied size (offsetofend of the las=
t
> > + *            required field).
> > + */
> > +struct liveupdate_arg_spec {
> > +     size_t size;
> > +     size_t min_size;
> > +};
> > +
> > +/**
> > + * LIVEUPDATE_ARG - Validated specification of a file handler argument=
 struct.
> > + * @_struct:   The argument structure type.
> > + * @_min_last: The last required member in @_struct.
> > + *
> > + * All file handler argument structures passed via
> > + * &liveupdate_session_preserve_fd.arg or &liveupdate_session_retrieve=
_fd.arg
> > + * must begin with a 32-bit @size field so they can be extended compat=
ibly.
> > + * Use this macro to initialize &liveupdate_file_ops.parg and
> > + * &liveupdate_file_ops.rarg.
> > + */
> > +#define LIVEUPDATE_ARG(_struct, _min_last)                           \
> > +     {                                                               \
> > +             .size =3D sizeof(_struct) +                              =
 \
> > +                     BUILD_BUG_ON_ZERO(offsetof(_struct, size) !=3D 0)=
 + \
> > +                     BUILD_BUG_ON_ZERO(sizeof_field(_struct, size) !=
=3D sizeof(u32)), \
> > +             .min_size =3D offsetofend(_struct, _min_last),           =
 \
> > +     }
> > +
> >  /**
> >   * struct liveupdate_file_op_args - Arguments for file operation callb=
acks.
> >   * @handler:          The file handler being called.
> > @@ -39,6 +69,11 @@ struct file;
> >   *                    is not preserved. Set by the handler's .preserve=
()
> >   *                    callback, and must be freed in the handler's
> >   *                    .unpreserve() callback.
> > + * @arg:              Kernel copy of the user-provided argument for .p=
reserve()
> > + *                    and .retrieve(), or %NULL if none was provided. =
Allocated
> > + *                    to the handler's expected argument size with any=
 trailing
> > + *                    bytes beyond the user-supplied size zero-filled.=
 Valid
> > + *                    only for the duration of the callback.
> >   *
> >   * This structure bundles all parameters for the file operation callba=
cks.
> >   * The 'data' and 'file' fields are used for both input and output.
> > @@ -49,6 +84,7 @@ struct liveupdate_file_op_args {
> >       struct file *file;
> >       u64 serialized_data;
> >       void *private_data;
> > +     const void *arg;
> >  };
> >
> >  /**
> > @@ -67,6 +103,12 @@ struct liveupdate_file_op_args {
> >   *                resources in the session.
> >   * @finish:       Required. Final cleanup in the new kernel.
> >   * @get_id:       Optional. Returns a unique identifier for the file.
> > + * @parg:         Optional. Specification of the user argument structu=
re
> > + *                accepted by @preserve, initialized via LIVEUPDATE_AR=
G(). If
> > + *                unset, non-zero user arguments are rejected with -EO=
PNOTSUPP.
> > + * @rarg:         Optional. Specification of the user argument structu=
re
> > + *                accepted by @retrieve, initialized via LIVEUPDATE_AR=
G(). If
> > + *                unset, non-zero user arguments are rejected with -EO=
PNOTSUPP.
> >   * @owner:        Module reference
> >   *
> >   * All operations (except can_preserve) receive a pointer to a
> > @@ -83,6 +125,8 @@ struct liveupdate_file_ops {
> >       bool (*can_finish)(struct liveupdate_file_op_args *args);
> >       void (*finish)(struct liveupdate_file_op_args *args);
> >       unsigned long (*get_id)(struct file *file);
> > +     struct liveupdate_arg_spec parg;
> > +     struct liveupdate_arg_spec rarg;
> >       struct module *owner;
> >  };
> >
> > @@ -237,6 +281,11 @@ int liveupdate_reboot(void);
> >  int liveupdate_register_file_handler(struct liveupdate_file_handler *f=
h);
> >  void liveupdate_unregister_file_handler(struct liveupdate_file_handler=
 *fh);
> >
> > +int liveupdate_claim_file(struct liveupdate_file_handler *fh,
> > +                       struct file *file);
> > +void liveupdate_unclaim_file(struct liveupdate_file_handler *fh,
> > +                          struct file *file);
> > +
> >  int liveupdate_register_flb(struct liveupdate_file_handler *fh,
> >                           struct liveupdate_flb *flb);
> >  void liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
> > @@ -269,6 +318,17 @@ static inline void liveupdate_unregister_file_hand=
ler(struct liveupdate_file_han
> >  {
> >  }
> >
> > +static inline int liveupdate_claim_file(struct liveupdate_file_handler=
 *fh,
> > +                                     struct file *file)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static inline void liveupdate_unclaim_file(struct liveupdate_file_hand=
ler *fh,
> > +                                        struct file *file)
> > +{
> > +}
> > +
> >  static inline int liveupdate_register_flb(struct liveupdate_file_handl=
er *fh,
> >                                         struct liveupdate_flb *flb)
> >  {
> > diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveu=
pdate.h
> > index 1644c502521e0..57a3c129d5a9d 100644
> > --- a/include/uapi/linux/liveupdate.h
> > +++ b/include/uapi/linux/liveupdate.h
> > @@ -127,6 +127,8 @@ struct liveupdate_ioctl_retrieve_session {
> >   * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
> >   * @fd:    Input; The user-space file descriptor to be preserved.
> >   * @token: Input; An opaque, unique token for preserved resource.
> > + * @arg:   Input; User-space pointer to a file-handler-specific argume=
nt
> > + *         structure starting with a 32-bit size field, or 0 if unused=
.
> >   *
> >   * Holds parameters for preserving a file descriptor.
> >   *
> > @@ -150,6 +152,7 @@ struct liveupdate_session_preserve_fd {
> >       __u32           size;
> >       __s32           fd;
> >       __aligned_u64   token;
> > +     __aligned_u64   arg;
> >  };
> >
> >  #define LIVEUPDATE_SESSION_PRESERVE_FD                                =
       \
> > @@ -161,6 +164,8 @@ struct liveupdate_session_preserve_fd {
> >   * @fd:    Output; The new file descriptor representing the fully rest=
ored
> >   *         kernel resource.
> >   * @token: Input; An opaque, token that was used to preserve the resou=
rce.
> > + * @arg:   Input; User-space pointer to a file-handler-specific argume=
nt
> > + *         structure starting with a 32-bit size field, or 0 if unused=
.
> >   *
> >   * Retrieve a previously preserved file descriptor.
> >   *
> > @@ -180,6 +185,7 @@ struct liveupdate_session_retrieve_fd {
> >       __u32           size;
> >       __s32           fd;
> >       __aligned_u64   token;
> > +     __aligned_u64   arg;
> >  };
> >
> >  #define LIVEUPDATE_SESSION_RETRIEVE_FD                                =
       \
> > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.=
c
> > index 3c1c86ff14d69..e3bfdbc6baedc 100644
> > --- a/kernel/liveupdate/luo_file.c
> > +++ b/kernel/liveupdate/luo_file.c
> > @@ -112,6 +112,7 @@
> >  #include <linux/xarray.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > +#include <linux/uaccess.h>
> >  #include "luo_internal.h"
> >
> >  static LIST_HEAD(luo_file_handler_list);
> > @@ -176,6 +177,36 @@ static unsigned long luo_get_id(struct liveupdate_=
file_handler *fh,
> >       return fh->ops->get_id ? fh->ops->get_id(file) : (unsigned long)f=
ile;
> >  }
> >
> > +/**
> > + * liveupdate_claim_file - Claim a file in the LUO preserved files tab=
le.
> > + * @fh:   The file handler claiming @file.
> > + * @file: The file to claim.
> > + *
> > + * File handlers whose .retrieve() callback restores state into an exi=
sting
> > + * user-supplied &struct file (rather than allocating a new one) shoul=
d call
> > + * this before modifying @file to ensure @file is not already managed =
by LUO.
> > + *
> > + * Return: 0 on success, -EBUSY if @file is already managed by LUO, or=
 a
> > + *         negative errno on allocation failure.
> > + */
> > +int liveupdate_claim_file(struct liveupdate_file_handler *fh,
> > +                       struct file *file)
> > +{
> > +     return xa_insert(&luo_preserved_files, luo_get_id(fh, file),
> > +                      file, GFP_KERNEL);
> > +}
> > +
> > +/**
> > + * liveupdate_unclaim_file - Release a claimed file from the LUO prese=
rved files table.
> > + * @fh:   The file handler that claimed @file.
> > + * @file: The file to release.
> > + */
> > +void liveupdate_unclaim_file(struct liveupdate_file_handler *fh,
> > +                          struct file *file)
> > +{
> > +     xa_erase(&luo_preserved_files, luo_get_id(fh, file));
> > +}
> > +
> >  static bool luo_token_is_used(struct luo_file_set *file_set, u64 token=
)
> >  {
> >       struct luo_file *iter;
> > @@ -188,11 +219,45 @@ static bool luo_token_is_used(struct luo_file_set=
 *file_set, u64 token)
> >       return false;
> >  }
> >
> > +static int luo_copy_user_arg(u64 user_arg, const void **argp,
> > +                          const struct liveupdate_arg_spec *spec)
> > +{
> > +     void *karg __free(kfree) =3D NULL;
> > +     void __user *uptr;
> > +     u32 user_size;
> > +     int err;
> > +
> > +     if (!user_arg)
> > +             return 0;
> > +     if (!spec->size)
> > +             return -EOPNOTSUPP;
> > +
> > +     uptr =3D u64_to_user_ptr(user_arg);
> > +     if (get_user(user_size, (u32 __user *)uptr))
> > +             return -EFAULT;
> > +     if (user_size < spec->min_size)
> > +             return -EINVAL;
> > +     if (user_size > PAGE_SIZE)
> > +             return -E2BIG;
> > +
> > +     karg =3D kmalloc(spec->size, GFP_KERNEL);
> > +     if (!karg)
> > +             return -ENOMEM;
> > +
> > +     err =3D copy_struct_from_user(karg, spec->size, uptr, user_size);
> > +     if (err)
> > +             return err;
> > +
> > +     *argp =3D no_free_ptr(karg);
> > +     return 0;
> > +}
> > +
> >  /**
> >   * luo_preserve_file - Initiate the preservation of a file descriptor.
> >   * @file_set: The file_set to which the preserved file will be added.
> >   * @token:    A unique, user-provided identifier for the file.
> >   * @fd:       The file descriptor to be preserved.
> > + * @arg:      User-space pointer to the handler argument structure, or=
 0.
> >   *
> >   * This function orchestrates the first phase of preserving a file. Up=
on entry,
> >   * it takes a reference to the 'struct file' via fget(), effectively m=
aking LUO
> > @@ -208,9 +273,11 @@ static bool luo_token_is_used(struct luo_file_set =
*file_set, u64 token)
> >   *    (allocates if needed).
> >   * 3. Iterates through registered handlers, calling can_preserve() to =
find one
> >   *    compatible with the given @fd.
> > - * 4. Calls the handler's .preserve() operation, which saves the file'=
s state
> > + * 4. Copies the user argument structure (if @arg is non-zero) accordi=
ng to the
> > + *    handler's parg specification.
> > + * 5. Calls the handler's .preserve() operation, which saves the file'=
s state
> >   *    and returns an opaque private data handle.
> > - * 5. Adds the new instance to the file_set's internal list.
> > + * 6. Adds the new instance to the file_set's internal list.
> >   *
> >   * On success, LUO takes a reference to the 'struct file' and consider=
s it
> >   * under its management until it is unpreserved or finished.
> > @@ -225,10 +292,12 @@ static bool luo_token_is_used(struct luo_file_set=
 *file_set, u64 token)
> >   *         -EBADF if the file descriptor is invalid.
> >   *         -ENOSPC if the file_set is full.
> >   *         -ENOENT if no compatible handler is found.
> > + *         -EOPNOTSUPP if @arg is non-zero and the handler does not ac=
cept an arg.
> >   *         -ENOMEM on memory allocation failure.
> >   *         Other erros might be returned by .preserve().
> >   */
> > -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd=
)
> > +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd=
,
> > +                   u64 arg)
> >  {
> >       struct liveupdate_file_op_args args =3D {0};
> >       struct liveupdate_file_handler *fh;
> > @@ -264,10 +333,14 @@ int luo_preserve_file(struct luo_file_set *file_s=
et, u64 token, int fd)
> >       if (err)
> >               goto err_fput;
> >
> > +     err =3D luo_copy_user_arg(arg, &args.arg, &fh->ops->parg);
> > +     if (err)
> > +             goto err_module_put;
> > +
> >       err =3D xa_insert(&luo_preserved_files, luo_get_id(fh, file),
> >                       file, GFP_KERNEL);
> >       if (err)
> > -             goto err_module_put;
> > +             goto err_free_arg;
> >
> >       err =3D luo_flb_file_preserve(fh);
> >       if (err)
> > @@ -290,6 +363,7 @@ int luo_preserve_file(struct luo_file_set *file_set=
, u64 token, int fd)
> >       if (err)
> >               goto err_kfree;
> >
> > +     kfree(args.arg);
> >       luo_file->serialized_data =3D args.serialized_data;
> >       luo_file->private_data =3D args.private_data;
> >       list_add_tail(&luo_file->list, &file_set->files_list);
> > @@ -303,6 +377,8 @@ int luo_preserve_file(struct luo_file_set *file_set=
, u64 token, int fd)
> >       luo_flb_file_unpreserve(fh);
> >  err_erase_xa:
> >       xa_erase(&luo_preserved_files, luo_get_id(fh, file));
> > +err_free_arg:
> > +     kfree(args.arg);
> >  err_module_put:
> >       module_put(fh->ops->owner);
> >  err_fput:
> > @@ -533,6 +609,7 @@ void luo_file_unfreeze(struct luo_file_set *file_se=
t,
> >   * luo_retrieve_file - Restores a preserved file from a file_set by it=
s token.
> >   * @file_set: The file_set from which to retrieve the file.
> >   * @token:    The unique token identifying the file to be restored.
> > + * @arg:      User-space pointer to the handler argument structure, or=
 0.
> >   * @filep:    Output parameter; on success, this is populated with a p=
ointer
> >   *            to the newly retrieved 'struct file'.
> >   *
> > @@ -552,9 +629,10 @@ void luo_file_unfreeze(struct luo_file_set *file_s=
et,
> >   *          kernel.
> >   * Return: 0 on success. Returns a negative errno on failure:
> >   *         -ENOENT if no file with the matching token is found.
> > + *         -EOPNOTSUPP if @arg is non-zero and the handler does not ac=
cept an arg.
> >   *         Any error code returned by the handler's .retrieve() op.
> >   */
> > -int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
> > +int luo_retrieve_file(struct luo_file_set *file_set, u64 token, u64 ar=
g,
> >                     struct file **filep)
> >  {
> >       struct liveupdate_file_op_args args =3D {0};
> > @@ -591,9 +669,14 @@ int luo_retrieve_file(struct luo_file_set *file_se=
t, u64 token,
> >               return 0;
> >       }
> >
> > +     err =3D luo_copy_user_arg(arg, &args.arg, &luo_file->fh->ops->rar=
g);
> > +     if (err)
> > +             return err;
> > +
> >       args.handler =3D luo_file->fh;
> >       args.serialized_data =3D luo_file->serialized_data;
> >       err =3D luo_file->fh->ops->retrieve(&args);
> > +     kfree(args.arg);
> >       if (err) {
> >               /* Keep the error code for later use. */
> >               luo_file->retrieve_status =3D err;
> > @@ -604,9 +687,9 @@ int luo_retrieve_file(struct luo_file_set *file_set=
, u64 token,
> >       /* Get reference so we can keep this file in LUO until finish */
> >       get_file(luo_file->file);
> >
> > -     WARN_ON(xa_insert(&luo_preserved_files,
> > -                       luo_get_id(luo_file->fh, luo_file->file),
> > -                       luo_file->file, GFP_KERNEL));
> > +     if (xa_load(&luo_preserved_files,
> > +                 luo_get_id(luo_file->fh, luo_file->file)) !=3D luo_fi=
le->file)
> > +             WARN_ON(liveupdate_claim_file(luo_file->fh, luo_file->fil=
e));
> >
> >       *filep =3D luo_file->file;
> >       luo_file->retrieve_status =3D 1;
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_i=
nternal.h
> > index b42369c3b1f30..3bd9ef442934e 100644
> > --- a/kernel/liveupdate/luo_internal.h
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -87,13 +87,14 @@ int __init luo_session_setup_incoming(u64 sessions_=
pa);
> >  int luo_session_serialize(void);
> >  int luo_session_deserialize(void);
> >
> > -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd=
);
> > +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd=
,
> > +                   u64 arg);
> >  void luo_file_unpreserve_files(struct luo_file_set *file_set);
> >  int luo_file_freeze(struct luo_file_set *file_set,
> >                   struct luo_file_set_ser *file_set_ser);
> >  void luo_file_unfreeze(struct luo_file_set *file_set,
> >                      struct luo_file_set_ser *file_set_ser);
> > -int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
> > +int luo_retrieve_file(struct luo_file_set *file_set, u64 token, u64 ar=
g,
> >                     struct file **filep);
> >  int luo_file_finish(struct luo_file_set *file_set);
> >  int luo_file_deserialize(struct luo_file_set *file_set,
> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_se=
ssion.c
> > index 403906937bc0f..74f8a1bf1da8c 100644
> > --- a/kernel/liveupdate/luo_session.c
> > +++ b/kernel/liveupdate/luo_session.c
> > @@ -284,7 +284,8 @@ static int luo_session_preserve_fd(struct luo_sessi=
on *session,
> >       if (session->frozen)
> >               return -EBUSY;
> >
> > -     err =3D luo_preserve_file(&session->file_set, argp->token, argp->=
fd);
> > +     err =3D luo_preserve_file(&session->file_set, argp->token, argp->=
fd,
> > +                             argp->arg);
> >       if (err)
> >               return err;
> >
> > @@ -307,7 +308,8 @@ static int luo_session_retrieve_fd(struct luo_sessi=
on *session,
> >               return argp->fd;
> >
> >       mutex_lock(&session->mutex);
> > -     err =3D luo_retrieve_file(&session->file_set, argp->token, &file)=
;
> > +     err =3D luo_retrieve_file(&session->file_set, argp->token, argp->=
arg,
> > +                             &file);
> >       mutex_unlock(&session->mutex);
> >       if (err < 0)
> >               goto err_put_fd;
> > --
> > 2.56.0.385.gd3acb90ef8-goog

