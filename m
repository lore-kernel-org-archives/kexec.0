Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28660A3830
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oEc/Z8kv;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=jhKaYXmq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gizFMxgAiNeNcK9yHAVbAAuSg3KjclB/mQKEXDByXnY=; b=oEc/Z8kvHdyaq0
	Geyb52dPmtJAwXRwPLaMmGEhHCB19aw8LfPOGv282bODYe61WLr2AxziPOOdGXE8jbygq/p9RTjqx
	/vESsDedd5TOdJ2XZMKmvKcyjhoeU65JkkvNbogZjo9IquRlNOyeg8XbFbfNZeO2EvrQVZ3MzPrJi
	vyz/D6DFTwhkRSbek5UcBize2684Vk9ymmNZXS+qHwxx5PdjlskXQ4i/TUR0AL45ZIIHJoFJcnk8n
	CodMLV4yLsWXBvEsaJN+mJXx/udTiZ7RW8MeIZRoAD6jDlDDGIfJ1bN5CghOSFECOjQpSfTaHloZ5
	b9w6PH41RQxh3ousAIdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJt4U-0000000EE85-1Edm;
	Thu, 22 Oct 2026 13:43:06 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJt4R-0000000EE6z-1usk
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 13:43:04 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so2801204a12.3
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 06:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792676581; cv=none;
        d=google.com; s=arc-20260327;
        b=mBSs4ZYu4sHeeKaqY9fOdKxXA3eP0fFysEuNi7DZmn6JoYsYPqh7o4U778Biv4vab1
         o/9NZTu9RNLNVr8snsrWu7CTUHpVREGMnBWzDT5dXQ8aFgI8ghDvCeyBhRpuhEv5NIR3
         jVEpy1CQF195bMjqIezpfiaEqLOD+Tmr7TxTL4L4TLXt3Y/ueoxurYXKOcIdvT0iAZqP
         LCgj+TqXN7fgn57gBRmNXyzahVGZvaFp+j8SQFyvJfsjNXNU5eTQRYeW6NoQcEEW3lQT
         qrQqZ6S0vyGS/BQomii1Sq/P09wn6R1UsG2r9IZq7qf9MBhxt5uw4hbDFXDnW9RplZO1
         LhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gizFMxgAiNeNcK9yHAVbAAuSg3KjclB/mQKEXDByXnY=;
        fh=/+PWQAgzGDRfOpnpsipXL7pLjJ0Jj9oMMvy2HQIHvI8=;
        b=acg2+u1gxFrrVdS66OQuEY+5Oq9TZADi/qi82k9F3ChvoDFIV0FKr9su8UXmh6upf4
         2a+nznk9j987kl1UfKqWN4PAfsy7xN60XTEWg0QK3oQvBAZWAm+3s5Ozo73ov3HCSZVN
         dSg/C+Ay+kfl0RmOJJJYbmbX0fa+6J4TUp0lJ+dJdezVxRbUIN1IpoPEmcKlX0s4cKv7
         1sQZ4wETSlgn+qf+OLmA9YgILVznPxwAw9rJvXEGMIofG2qKTz79X9yv30j55TNEjokZ
         rVnct2ImCvoEdBxsQr48yu37K6OWMMFzkwiaGGUMKIgLj84PR6O4VE8Pt5r4sLaTrEOj
         44yw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792676581; x=1793281381; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gizFMxgAiNeNcK9yHAVbAAuSg3KjclB/mQKEXDByXnY=;
        b=jhKaYXmq2SHX+IRxD9Nq7JobKADwz1QbOsmXkUST6XEqzaU0seyIAlNQYMML3kmCmj
         t/pZGOgWRCxEFPayxzRAEsrUTOvQXABAxjhLvFhWcZ7R0B9Z/DSFvBviMpnLpL/gwtGD
         1/vyaMqn6oOET/xnRK/3gyt4zjRpHb/o/oAxfhkLWVto5d70ugrRmnM9TZWhNoPg4n4L
         HSQ6ugY0cDB1LfqTnVrKNDkJfY6pRDCK4P4+ZVJUErD7JHUnmFNSLM+itHBGzO2mlS4I
         CgzP+2Vla0KhwQE1N+iUHVHd+vpFUAB+ZQ83diePnPc4C8bKRPVzfIhy48mQ6Pb06qGA
         9QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676581; x=1793281381;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gizFMxgAiNeNcK9yHAVbAAuSg3KjclB/mQKEXDByXnY=;
        b=O47tHfKQhfm+iLb5cmOsWHG/aUCiGKDNJ3IpuLYcoNOyXJrTjBr5sx+OXiFjPbTj07
         V6LvsciSI7DMclQwDxdywIsmFuGXCZyK1v+QJiIfGr5HDnH6jYqaYqxKnoVKWWwYAPtY
         Bc+ZSNMRbGQmD/E50s+HJgK+2lpulGwuAzAbaLAzmiFEnJTzqebD/oy+cJytKKPZnDt0
         uVbVNvUVzMJSJeEqCHw105euKA2Nt1QfpNKjMC0aFWvTbIqV33w5thnBNEJErLhucw7n
         C55Ozo/Tw6s93M0FTSnjphqMhwgo5x7ArerqLYKNgLIwb1G1XkoR+1yEmaOSDAbPx/So
         kdQg==
X-Forwarded-Encrypted: i=1; AKwUvBwYGdrvexXN8+rYPryyULglC5s0VOIiK8PlBcWK9FNOqw6c7w9opSXpQ6RanzbYWWUq4DXHNw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJSgaQmJ7WW7NjxkwAYzh3FcRLItq2Up0aoneddR4UzZeSOXciY
	PsifPedJdgguKa6AtEjpSWoW1EERdQQVrs+KsoQFkqphHaO+h+iHsPUqT2PMzwvmHF8rceoqCiA
	o+VuMUCXIki3mXCVpbNQqIPB29QMNcHlMTBmm0iQuXQ==
X-Gm-Gg: AYBFou0PgK20nEWA6neumUKFHTvSH+y49ISFUE4Rg87JLJu5z2OPYAzzCeyA1dhkYTx
	UyofPJBae8aTHaELziLA2HzyK+KFUu2ST5N3qrrH+OU/4Kc5a2DcaVh9t80j8b9B6hijAlI/Gs+
	iWMmKIHnRTvrOeZXd3hsF3svYLJmBUqNMEGEX/TNU+gLSn4PsRz7EKw3qJocWLo70zSsVFuM9nE
	nQmAY0XN16U5bi96zRKx+SOZyZuRkAAL6IAnYQbTDPGMrU2osXvffCfJjabUq+I9QctJH5mWy/t
	lh+U47+8R6sij5ysjc9MQ124XazYZe8XaSijm9tsv4z5Fk6qulF4zL6vNQJn+2WEkph8nRFdyP1
	EV7HhAcXuMsfaVHNs5KP6xr10cJvmlFMBv6Lln1rAjZ/1e22qKGOMAaOqKoqSNQxe48f6
X-Received: by 2002:a05:6402:51cb:b0:6b1:ba86:5f55 with SMTP id
 4fb4d7f45d1cf-6b408eda746mr4955017a12.35.1792676580475; Thu, 22 Oct 2026
 06:43:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-3-tarunsahu@google.com>
 <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com> <9huzik2t5281.fsf@tarunix.c.googlers.com>
In-Reply-To: <9huzik2t5281.fsf@tarunix.c.googlers.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 09:42:22 -0400
X-Gm-Features: AclHuK8k5bT2ZKs2HYGA795ETIkO2JydSGkbGrRRu0cT3FC7RgYcT81JMzNVsA4
Message-ID: <CA+CK2bA2zqQJryBqpoNG7RQqnUnQT1+d8G5xwrjx0Dqo58woHA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
To: tarunsahu@google.com
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
X-CRM114-CacheID: sfid-20261022_064303_691685_E92D2588 
X-CRM114-Status: GOOD (  55.34  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 8:50=E2=80=AFAM <tarunsahu@google.com> wrote:
>
>
> I have gone through the discussion in reply to this thread between
> @dmatlack and @pasha
>
> I am not sure If I understood the discussion correctly.
>
> userspace IOCTL for FLB compatiblity might not necessary as each FLBs are
> registered with the file handler. So when new file handler introduced in =
the
> system, new flb handlers can be registered that is compatible with this
> new file handler. I have tried to explain this below.
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> >>
> >> Currently luo_preserve_file() iterates over luo_file_handler_list and
> >> picks the first registered handler whose .can_preserve() callback
> >> returns true. When a subsystem introduces a new, backwards-incompatibl=
e
> >> file handler alongside an existing one for the same file type, userspa=
ce
> >> has no way to choose which handler preserves a file descriptor, nor ca=
n
> >> the kernel keep the existing rollback-safe handler as the default whil=
e
> >> allowing callers to opt into the new handler.
> >
> > That is not how it will work.
> > If we are in the .can_preserve() call,
> > it means the user has already decided which file handlers to use.
>
> That is not true.

Please re-read what I wrote: I said that is not how it *will* work.
Currently, we only have one FH per supported FD type, and that is how
it will remain when we supply the target kernel specs. before the live
update begins.

>
> From the documentation of the luo_preserve_file(): 3rd point.
>
> * This function orchestrates the first phase of preserving a file. It per=
forms
>  * the following steps:
>  *
>  * 1. Validates that the @token is not already in use within the file_set=
.
>  * 2. Ensures the file_set's memory for files serialization is allocated
>  *    (allocates if needed).
> =3D>* 3. Iterates through registered handlers, calling can_preserve() to =
find one
>  *    compatible with the given @fd.
>  * 4. Calls the handler's .preserve() operation, which saves the file's s=
tate
>  *    and returns an opaque private data handle.
>  * 5. Adds the new instance to the file_set's internal list.
>  *
>
> luo_preserve_file():
>
>         list_private_for_each_entry(fh, &luo_file_handler_list, list) {
>                 if (fh->ops->can_preserve(fh, file)) {
>                         if (try_module_get(fh->ops->owner))
>                                 err =3D 0;
>                         break;
>                 }
>         }
>
>
> the first handler whose can_preserve return true will be selected as the
> FH;
>
> later in code:
>
>         err =3D fh->ops->preserve(&args);
>
> So can_preserve() is called on every handler for a fd and once it finds
> the FH which reutrns true, it uses its preserve call to preserve the file=
.

And as I explained later in that e-mail, the set of FHs will be
decided ahead of time:

"Therefore, there should be a luoctl call (i.e via a new ioctl to set
compatability) that provides the kernel with the specs file of the
target kernel we are updating to, allowing the kernel to select the
compatible file handlers. Since .can_preserve() is called when the
user is already preserving files, the specification must have already
been supplied, or the kernel should fall back to using the default
(i.e., latest) file handlers."

The user/admin will configure the active set of FHs *before* the first
FD is preserved. By the time we search for a compatible FH via
.can_preserve(), that choice has already been made, and there will be
ONLY one active FH per supported FD type.

>
> > We
> > need to do that before any preservation happens; otherwise, we could
> > run into conflicts on FLBs i.e. FH of different version require
> > different FLBs.
>
> My change below will select the user passed handler directly if it is
> valid otherwise it fallbacks to looping .can_preserve based selection.
>
> ****For flb****:
>
> Registration of flb handlers happens with original
> subsytem fd handler, for example, for iommu
>
>  iommu_liveupdate_register_flb(&iommufd_ser_handler); ->liveupdate_regist=
er_flb(fh, flb);
>
> This function takes the FH argument. So every FH has direct relation
> with their flbs.
>
> If new FH will be introduced within the system, it must register
> compatible flbs handlers with it by liveupdate_register_flb.
>
> Currently, FLB objects are preserved with the first dependent file's
> preservation. and each flb handler in fh->flb_list (was associated
> using each flb handler registration) will call its ops to preserve itself=
.
>
> Same on retrieval side, handler name is preserved so the flb name is
> also preserved. And they can just call their respects ops to retrieve
> themselves.
>
> What about If user try to preserve other dependent but same subsystem
> files with different handler. Kernel must reject this. I have not
> integrated this support. Which can also be added as part of this series.
> Let me know if this sounds good, Then I will add that in the V3?

No, do not go this route. Rejecting mismatched handlers on subsequent
FDs still leaves handler selection as a per-FD decision, meaning the
first session/process to preserve an FD dictates the FH and FLB
version for the entire subsystem. Individual processes preserving FDs
should not need to know which handler version the target kernel
supports. Version compatibility is a global orchestration policy and
should be configured once up front before any FDs are preserved.

Pasha

>
> ~Tarun
>
> >
> > Therefore, there should be a luoctl call (i.e via a new ioctl to set
> > compatability) that provides the kernel with the specs file of the
> > target kernel we are updating to, allowing the kernel to select the
> > compatible file handlers. Since .can_preserve() is called when the
> > user is already preserving files, the specification must have already
> > been supplied, or the kernel should fall back to using the default
> > (i.e., latest) file handlers.
> >
> >>
> >> Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
> >> liveupdate_session_preserve_fd immediately after token, keeping
> >> IOCTL_OP min_size at offsetofend(..., token) so callers passing the
> >> original 16-byte structure continue to work:
> >> - When handler is empty (all-zero, or zero-filled when userspace
> >>   passes the 16-byte structure), luo_preserve_file() selects the first
> >>   registered handler whose .can_preserve() callback accepts the fd.
> >> - When handler is non-empty, it must be null-terminated within
> >>   LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
> >>   luo_preserve_file() looks up the registered handler with that exact
> >>   name (returning -ENOENT if unknown) and verifies that its
> >>   .can_preserve() callback accepts the fd (returning -EINVAL if not).
> >>
> >> The retrieve ioctl is unchanged because the handler is identified by t=
he
> >> name stored in the serialized payload from the source kernel.
> >>
> >> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> >> ---
> >>  include/uapi/linux/liveupdate.h  | 12 +++++++++---
> >>  kernel/liveupdate/luo_file.c     | 21 ++++++++++++++++++---
> >>  kernel/liveupdate/luo_internal.h |  3 ++-
> >>  kernel/liveupdate/luo_session.c  |  7 ++++++-
> >>  4 files changed, 35 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/live=
update.h
> >> index 509c6236720d..2413b19dabc1 100644
> >> --- a/include/uapi/linux/liveupdate.h
> >> +++ b/include/uapi/linux/liveupdate.h
> >> @@ -126,9 +126,14 @@ struct liveupdate_ioctl_retrieve_session {
> >>
> >>  /**
> >>   * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_P=
RESERVE_FD)
> >> - * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
> >> - * @fd:    Input; The user-space file descriptor to be preserved.
> >> - * @token: Input; An opaque, unique token for preserved resource.
> >> + * @size:    Input; sizeof(struct liveupdate_session_preserve_fd)
> >> + * @fd:      Input; The user-space file descriptor to be preserved.
> >> + * @token:   Input; An opaque, unique token for preserved resource.
> >> + * @handler: Input; Optional null-terminated file handler name (max l=
ength
> >> + *           %LIVEUPDATE_HNDL_NAME_LENGTH including null terminator) =
selecting
> >> + *           which registered handler preserves @fd. If empty (all-ze=
ro, or
> >> + *           omitted when passing the 16-byte structure), the kernel =
selects
> >> + *           the first registered handler whose .can_preserve() accep=
ts @fd.
> >>   *
> >>   * Holds parameters for preserving a file descriptor.
> >>   *
> >> @@ -152,6 +157,7 @@ struct liveupdate_session_preserve_fd {
> >>         __u32           size;
> >>         __s32           fd;
> >>         __aligned_u64   token;
> >> +       char            handler[LIVEUPDATE_HNDL_NAME_LENGTH];
> >>  };
> >>
> >>  #define LIVEUPDATE_SESSION_PRESERVE_FD                               =
  \
> >> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file=
.c
> >> index fb81239bedf3..be20e0f1e0aa 100644
> >> --- a/kernel/liveupdate/luo_file.c
> >> +++ b/kernel/liveupdate/luo_file.c
> >> @@ -207,6 +207,8 @@ static bool luo_token_is_used(struct luo_file_set =
*file_set, u64 token)
> >>   * @file_set: The file_set to which the preserved file will be added.
> >>   * @token:    A unique, user-provided identifier for the file.
> >>   * @fd:       The file descriptor to be preserved.
> >> + * @handler:  Optional NUL-terminated handler name. If NULL or empty,=
 the first
> >> + *            registered handler whose .can_preserve() accepts @fd is=
 selected.
> >>   *
> >>   * This function orchestrates the first phase of preserving a file. U=
pon entry,
> >>   * it takes a reference to the 'struct file' via fget(), effectively =
making LUO
> >> @@ -238,11 +240,13 @@ static bool luo_token_is_used(struct luo_file_se=
t *file_set, u64 token)
> >>   *         -EBUSY if the file descriptor is already preserved by anot=
her session.
> >>   *         -EBADF if the file descriptor is invalid.
> >>   *         -ENOSPC if the file_set is full.
> >> - *         -ENOENT if no compatible handler is found for the file typ=
e.
> >> + *         -ENOENT if no matching handler is registered or accepts @f=
d.
> >> + *         -EINVAL if the named handler cannot preserve @fd.
> >>   *         -ENOMEM on memory allocation failure.
> >>   *         Other erros might be returned by .preserve().
> >>   */
> >> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int f=
d)
> >> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int f=
d,
> >> +                     const char *handler)
> >>  {
> >>         struct liveupdate_file_op_args args =3D {0};
> >>         struct liveupdate_file_handler *fh;
> >> @@ -266,6 +270,18 @@ int luo_preserve_file(struct luo_file_set *file_s=
et, u64 token, int fd)
> >>         err =3D -ENOENT;
> >>         down_read(&luo_register_rwlock);
> >>         list_private_for_each_entry(fh, &luo_file_handler_list, list) =
{
> >> +               if (handler && handler[0]) {
> >> +                       if (strcmp(fh->name, handler))
> >> +                               continue;
> >> +                       if (!fh->ops->can_preserve(fh, file)) {
> >> +                               err =3D -EINVAL;
> >> +                               break;
> >> +                       }
> >> +                       if (try_module_get(fh->ops->owner))
> >> +                               err =3D 0;
> >> +                       break;
> >> +               }
> >> +
> >>                 if (fh->ops->can_preserve(fh, file)) {
> >>                         if (try_module_get(fh->ops->owner))
> >>                                 err =3D 0;
> >> @@ -274,7 +290,6 @@ int luo_preserve_file(struct luo_file_set *file_se=
t, u64 token, int fd)
> >>         }
> >>         up_read(&luo_register_rwlock);
> >>
> >> -       /* err is still -ENOENT if no handler was found */
> >>         if (err)
> >>                 goto err_fput;
> >>
> >> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_=
internal.h
> >> index dac6644bfb18..911ffedec9f3 100644
> >> --- a/kernel/liveupdate/luo_internal.h
> >> +++ b/kernel/liveupdate/luo_internal.h
> >> @@ -101,7 +101,8 @@ int __init luo_session_setup_incoming(u64 sessions=
_pa);
> >>  int luo_session_serialize(void);
> >>  int luo_session_deserialize(void);
> >>
> >> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int f=
d);
> >> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int f=
d,
> >> +                     const char *handler);
> >>  void luo_file_unpreserve_files(struct luo_file_set *file_set);
> >>  int luo_file_freeze(struct luo_file_set *file_set,
> >>                     struct luo_file_set_ser *file_set_ser);
> >> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_s=
ession.c
> >> index f48e9a4185f9..194ef45907c1 100644
> >> --- a/kernel/liveupdate/luo_session.c
> >> +++ b/kernel/liveupdate/luo_session.c
> >> @@ -266,8 +266,13 @@ static int luo_session_preserve_fd(struct luo_ses=
sion *session,
> >>         struct liveupdate_session_preserve_fd *argp =3D ucmd->cmd;
> >>         int err;
> >>
> >> +       if (strnlen(argp->handler, sizeof(argp->handler)) =3D=3D
> >> +           sizeof(argp->handler))
> >> +               return -EINVAL;
> >> +
> >>         guard(mutex)(&session->mutex);
> >> -       err =3D luo_preserve_file(&session->file_set, argp->token, arg=
p->fd);
> >> +       err =3D luo_preserve_file(&session->file_set, argp->token, arg=
p->fd,
> >> +                               argp->handler);
> >>         if (err)
> >>                 return err;
> >>
> >> --
> >> 2.56.0.212.g129ede20d9-goog
> >>

