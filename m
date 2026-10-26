Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8F606A31D
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IsMVJkpg;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=IbKUBgip
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=serC0Qr3v1AkQ41cs9qFoAlejUw/dVTynlDISylCuz8=; b=IsMVJkpgFzKrvE
	KAMlKm2e50J+ZGPzyGYhAYqTm7W1nbBrRGHzfYqGUdVjXEBFyugoMjJaeh3EJ/wXZJ5hrgALovuUl
	rH8Gqm7uazVwq3DzT+Z8vwLOT5IhJxKaft5QJ08gSa7uGpmqMPJW0EBDJoZFHBAxV9sqTPucR81a4
	aBZoWDTlUmRbp+K+NYcW+Bb3GG89HNvdPhbsHKSOz5tPRW+/AfkzhivbhXZkIIAvXv6bvUUiFkLOL
	lIZkdjIAMmgSC2mSC4//h6JAuL5qD176dIhkhPey2FL0jpEsZuB778rskRWM6m8lfRwMW8//X50N7
	9JEi+0F/yxutmF9CWwgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9Ea-00000001Yyr-3MTs;
	Mon, 26 Oct 2026 01:10:44 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9EY-00000001YyW-0Fw1
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 01:10:43 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso3175675a12.3
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 18:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792977040; cv=none;
        d=google.com; s=arc-20260327;
        b=qBrQZAf6FKXhTBDCSTbfM3mlx1Ydy3a/0MtpUIhWmNUSrxy8JaZhFjAMBBMGinVkND
         BuTvjmLhnMd0bSSA00Q15iJ8yTCuhEjJgMs5Kfo66SDOC3AXbSLqj1bhC/2gPZK3meTR
         DTIQ9Jjz2kS4Co0YLc05Vb7sljXs0FaT6Anf+4hrk0BNdRFbLdxIoM0/7W1LFQKMKJ8X
         U+jeHlclk1cDQgPHDI8Rgk9Vb00FWdQSWsdmJq3luzS++nM3TE/J9odYrvC9UsXZZYkN
         KQht7TEStwI2SeZWB4ygiczptgatbJ7XqAXcxzyEppSOAooHgVT2Rl0htGBKhqIogLiP
         czaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=serC0Qr3v1AkQ41cs9qFoAlejUw/dVTynlDISylCuz8=;
        fh=4DqpKn6Lv3Srk4lv47pyH5Ohp3tVrYVHJZpa9Z4B8bg=;
        b=G3wLauwL6SVvSSfpgJbGGGGqiuHGzgTfDA0mG8b9dRUe/l4ZTIvFCm5yeT68KkVq9q
         03wG7d0t4tq47nJsAW54oK/MnwsPhQKaHeXxBqUbaxfETyT2ComZIwq7MmtExCgfvdh8
         JP/O0YfDMWQsXJROPZaUHJr3wTq2ohTLVbnNHkonJ1Ls7OXeiUV6CMMUaj9SN7JGDlfU
         OwNBMnFo7vm0AS78DeCWtiHYtUZrxbqipOadSTVlL+IkjEhPiDpGUXprRo0Eq5NROXbC
         g9zhsGkdz072n1CmIljY1MEK2kU99s1SxVcsKRwptAb41ZzJcDGZhc8eU0TrHz1340tb
         z3HQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792977040; x=1793581840; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=serC0Qr3v1AkQ41cs9qFoAlejUw/dVTynlDISylCuz8=;
        b=IbKUBgiphaTwvESqlIi76G1IxdUszDnpag48Iv2Qf1vQI+s2IZEei3+gFyhUxJWZm1
         7wotYUo9EMO79JcDUVQDwtz3Kgy5ckiRfDGnZ3XIgseEindc4CQcVitn9ew55V1nU/A8
         Fihu0GFWT8/a557RAaA1StmRVkVuyNgTR1jKNs4EC9b8WQ534rOhm36ckqiQeWpnwbJk
         GSvbtNXJQ5BRqRhZOa35ijHgLLYXrcOymnDOBGpLFaf6jccSV6gpPsYmeW2xp7mpF3Td
         jf1Wb1pIrD86gYn8uaWvSUqba5uzp5f5uBM4siYRA06bHQdV5YmTr5upOiAeXfDXGSNG
         VLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792977040; x=1793581840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=serC0Qr3v1AkQ41cs9qFoAlejUw/dVTynlDISylCuz8=;
        b=V8FL5mjIGcBtAg900EVZcX6ok6zJf6DPOr7bLbrNRyXwSjQso0GdstsO4cT782BSuh
         ovJK5YiSL4CeDpGOLbDh3uNiq3u1y4dpcpcGvOyyFepuo8emDod8fv4eeeantO9onbPN
         zT27irVXcXYVHFGMiqZyKII0yxz1qHJJCufv7Iqr1QpKFoKc4vHm9q3gMS/5IV0F08Y6
         rDouj48FsNdWyfblKNRSDDvJ2knc5ZtvA4rUCkHJKESIPKGmCTPk1nCoB7TzwURJWVKj
         ILpt213SWUOTD7wgfb6sLvAoczHlN3I/qC/kqZnGFjtw3lVdm4VnzxYZ3zqlHeY4a7Xk
         w74Q==
X-Forwarded-Encrypted: i=1; AKwUvBz7v3mQHw5GY8vkoyU5HsjYiOKgQ4gfcg5aK3UI/ISmj7K0Q7iUYLEZ7szUCQ8OOaJoOUgSwQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIcxLSI1wRdoFn4oAnp/HgYLy1819hipFzXffCebFsf9ZVHdrew
	0mD+TyfpgbXQcJXDgcCx2wc1jbw5TVvnRTRwky4WzzqGVS7v0WWXCz1ABXDg5QYFAJdwkAk9lQa
	hMMyf2dUKLvorRguH/PSWM2AV8MDOL0A3ssPfi9xnUQ==
X-Gm-Gg: AYBFou1K97D8tE30wi+tIe/ntehVcN+p0i26YBRnxFor4uruu05XE2LG2Q04riJek3E
	I/NBFdah1a34rlXCtcjNz1NxClB/1bk0PqG2YgrRImOQ+N3FjROVCywfXo4Ljehc2aUsDjcFXug
	Ye+Amt5rSrwWdUGctVxIRA763O2jiuqZ2CsVQDuzIvitDjxtM3rMsEpBw0dh5inE7k8camF+G6G
	qFRE5FgDEdh12ZCQPGYJv8acyuQ94sAep35YRb2Aw8FRFI2nIaBUAxgC2/qd1hHYg/oTS6SCiuf
	CLfEZzShHJaO81rxo8iCfQyMTBE7FZpT7EMOne0n+U97mTnTelTUiXefTXf8e/4FtrM7B2fw46o
	Ys4BEAXveinb6/K3NCTFpdauTjJ+vnk/7xHDW4yqlEs068sKy9SoBIeUBlt1IjKCuh7bRgw==
X-Received: by 2002:a05:6402:440b:b0:6ac:62c2:bd39 with SMTP id
 4fb4d7f45d1cf-6b442fe12famr6368009a12.10.1792977039532; Sun, 25 Oct 2026
 18:10:39 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
 <20261020144710.4154339-2-pasha.tatashin@soleen.com> <atsMZW4ChOWj7Lqv@kernel.org>
In-Reply-To: <atsMZW4ChOWj7Lqv@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 25 Oct 2026 21:10:02 -0400
X-Gm-Features: AclHuK-SGyJEu7JWPJQ5FgiFjB9NPuO2-XlJh__utMnCfsTc4KvmMW8PdPmX4kI
Message-ID: <CA+CK2bD_=gwB-py6U3Y9pdc7RRoACeK9cqyHo65Q2ZKTyKaC2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl to
 freeze sessions early
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com, 
	linux-kernel@vger.kernel.org, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, graf@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_181042_273528_281F69F1 
X-CRM114-Status: GOOD (  41.81  )
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

On Fri, Oct 23, 2026 at 3:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Oct 20, 2026 at 10:47:03AM -0400, Pasha Tatashin wrote:
> > Currently, LUO sessions are frozen automatically only inside the
> > reboot(LINUX_REBOOT_CMD_KEXEC) pathway, where luo_session_serialize()
> > iterates through all outgoing sessions under global write locks and
> > freezes them serially during shutdown. Allowing userspace to decide whe=
n
> > to freeze a session once it is done with it (and to freeze multiple
> > sessions in parallel, since luo_session_freeze() only acquires the
> > per-session mutex) avoids postponing this work to kexec shutdown and
> > reduces blackout time.
> >
> > Introduce LIVEUPDATE_SESSION_FREEZE on session file descriptors to free=
ze
> > a session early. The ioctl runs .freeze() across all preserved files in=
 the
> > session and serializes their metadata. Once frozen, no additional files=
 can
> > be added to the session, and subsequent freeze calls return -EBUSY. Fre=
eze
> > is only valid on outgoing sessions and returns -EINVAL on incoming ones=
.
> >
> > During kexec, sessions that were already frozen early are skipped, whil=
e
> > sessions that did not invoke this ioctl auto-freeze as before. If an
> > early-frozen session is released before kexec, its files are rolled bac=
k
> > via .unfreeze() before being unpreserved.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/liveupdate.h       |  3 +-
> >  include/uapi/linux/liveupdate.h  | 25 ++++++++++
> >  kernel/liveupdate/luo_file.c     | 73 +++++++++++++---------------
> >  kernel/liveupdate/luo_internal.h |  9 ++--
> >  kernel/liveupdate/luo_session.c  | 82 +++++++++++++++++++++++++-------
> >  mm/memfd_luo.c                   |  5 +-
> >  6 files changed, 134 insertions(+), 63 deletions(-)
> >
> > diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> > index 6051abc0612c..851692571e13 100644
> > --- a/include/linux/liveupdate.h
> > +++ b/include/linux/liveupdate.h
> > @@ -59,7 +59,8 @@ struct liveupdate_file_op_args {
> >   *                compatible with the given file.
> >   * @preserve:     Required. Performs state-saving for the file.
> >   * @unpreserve:   Required. Cleans up any resources allocated by @pres=
erve.
> > - * @freeze:       Optional. Final actions just before kernel transitio=
n.
> > + * @freeze:       Optional. Prepares final state before kexec (via
> > + *                LIVEUPDATE_SESSION_FREEZE or during reboot).
> >   * @unfreeze:     Optional. Undo freeze operations.
> >   * @retrieve:     Required. Restores the file in the new kernel.
> >   * @can_finish:   Optional. Check if this FD can finish, i.e. all rest=
oration
> > diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveu=
pdate.h
> > index 4043d4038712..1644c502521e 100644
> > --- a/include/uapi/linux/liveupdate.h
> > +++ b/include/uapi/linux/liveupdate.h
> > @@ -60,6 +60,7 @@ enum {
> >       LIVEUPDATE_CMD_SESSION_RETRIEVE_FD =3D 0x41,
> >       LIVEUPDATE_CMD_SESSION_FINISH =3D 0x42,
> >       LIVEUPDATE_CMD_SESSION_GET_NAME =3D 0x43,
> > +     LIVEUPDATE_CMD_SESSION_FREEZE =3D 0x44,
> >  };
> >
> >  /**
> > @@ -236,4 +237,28 @@ struct liveupdate_session_get_name {
> >  #define LIVEUPDATE_SESSION_GET_NAME                                  \
> >       _IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
> >
> > +/**
> > + * struct liveupdate_session_freeze - ioctl(LIVEUPDATE_SESSION_FREEZE)
> > + * @size:     Input; sizeof(struct liveupdate_session_freeze)
> > + * @reserved: Input; Must be zero. Reserved for future use.
> > + *
> > + * Freezes the session early from userspace before the reboot kexec ph=
ase.
> > + *
> > + * When this ioctl is called, the kernel executes the .freeze() callba=
ck on all
> > + * preserved files in the session and serializes their metadata. Once =
frozen,
> > + * no further files can be preserved in the session.
> > + *
> > + * During the subsequent reboot kexec, this session is recognized as a=
lready
>
> Nit: kexec reboot

Ok

>
> > + * frozen and is skipped from the late auto freeze.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +struct liveupdate_session_freeze {
> > +     __u32           size;
> > +     __u32           reserved;
> > +};
> > +
> > +#define LIVEUPDATE_SESSION_FREEZE                                    \
> > +     _IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FREEZE)
> > +
> >  #endif /* _UAPI_LIVEUPDATE_H */
> > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.=
c
> > index a39992da504f..7f79890beb31 100644
> > --- a/kernel/liveupdate/luo_file.c
> > +++ b/kernel/liveupdate/luo_file.c
> > @@ -31,9 +31,9 @@
> >   *   - unpreserve(): Cleans up any resources allocated by .preserve(),=
 called
> >   *     if the preservation process is aborted before the reboot (i.e. =
session is
> >   *     closed).
> > - *   - freeze(): A final pre-reboot opportunity to prepare the state f=
or kexec.
> > - *     We are already in reboot syscall, and therefore userspace canno=
t mutate
> > - *     the file anymore.
> > + *   - freeze(): Prepares the final state for kexec. Invoked either ea=
rly via
>
> Nit: I'd drop "early", it seems relevant only to the current change, but
> will be more confusing than useful later.

Good point, will do.

>
> > + *     the LIVEUPDATE_SESSION_FREEZE ioctl once userspace is done modi=
fying
> > + *     the session's files, or during the reboot() syscall.
> >   *   - unfreeze(): Undoes the actions of .freeze(), called if the live=
 update
> >   *     is aborted after the freeze phase.
> >   *   - retrieve(): Reconstructs the file in the new kernel from the pr=
eserved
> > @@ -48,7 +48,8 @@
> >   *    handler, calls its .preserve() operation, and creates an interna=
l &struct
> >   *    luo_file to track the live state.
> >   *
> > - * 2. Freeze (Pre-Reboot): Just before the kexec, luo_file_freeze() is=
 called.
> > + * 2. Freeze (Pre-Reboot): Either explicitly via LIVEUPDATE_SESSION_FR=
EEZE or
> > + *    just before the kexec during reboot(), luo_file_freeze() is call=
ed.
> >   *    It iterates through all preserved files, calls their respective =
.freeze()
> >   *    operation, and serializes their final metadata (compatible strin=
g, token,
> >   *    and data handle) into a contiguous memory block for KHO.
> > @@ -74,15 +75,16 @@
> >   *
> >   * 1. Abort Before Reboot: If the userspace agent aborts the live upda=
te
> >   *    process before calling reboot (e.g., by closing the session file
> > - *    descriptor), the session's release handler calls
> > - *    luo_file_unpreserve_files(). This invokes the .unpreserve() call=
back on
> > - *    all preserved files, ensuring all allocated resources are cleane=
d up and
> > - *    returning the system to a clean state.
> > + *    descriptor), the session's release handler unfreezes the files i=
f the
> > + *    session was already frozen and calls luo_file_unpreserve_files()=
. This
> > + *    invokes the .unpreserve() callback on all preserved files, ensur=
ing all
> > + *    allocated resources are cleaned up and returning the system to a=
 clean
> > + *    state.
> >   *
> > - * 2. Freeze Failure: During the reboot() syscall, if any handler's .f=
reeze()
> > - *    op fails, the .unfreeze() op is invoked on all previously *succe=
ssful*
> > - *    freezes to roll back their state. The reboot() syscall then retu=
rns an
> > - *    error to userspace, canceling the live update.
> > + * 2. Freeze Failure: During LIVEUPDATE_SESSION_FREEZE or the reboot()=
 syscall,
> > + *    if any handler's .freeze() op fails, the .unfreeze() op is invok=
ed on all
> > + *    previously *successful* freezes to roll back their state, and an=
 error is
> > + *    returned to userspace.
>
> I think we still want to say that freeze failure at reboot cancels live
> update.

OK

>
> >   *
> >   * 3. Finish Failure: In the new kernel, if a handler's .finish() op f=
ails,
> >   *    the luo_file_finish() operation is aborted. LUO retains ownershi=
p of
> > @@ -440,12 +442,11 @@ static void __luo_file_unfreeze(struct luo_file_s=
et *file_set,
> >
> >  /**
> >   * luo_file_freeze - Freezes all preserved files and serializes their =
metadata.
> > - * @file_set:     The file_set whose files are to be frozen.
> > - * @file_set_ser: Where to put the serialized file_set.
> > + * @file_set: The file_set whose files are to be frozen.
> >   *
> > - * This function is called from the reboot() syscall path, just before=
 the
> > - * kernel transitions to the new image via kexec. Its purpose is to pe=
rform the
> > - * final preparation and serialization of all preserved files in the f=
ile_set.
> > + * This function is called from LIVEUPDATE_SESSION_FREEZE or from the =
reboot()
> > + * syscall path. Its purpose is to perform the preparation and seriali=
zation of
>
> Nit:                                          ^ final?

OK

>
> > + * all preserved files in the file_set.
> >   *
> >   * It iterates through each preserved file in FIFO order (the order of
> >   * preservation) and performs two main actions:
> > @@ -457,22 +458,20 @@ static void __luo_file_unfreeze(struct luo_file_s=
et *file_set,
> >   *
> >   * 2. Serializes Metadata: After a successful freeze, it copies the fi=
nal file
> >   *    metadata=E2=80=94the handler's compatible string, the user token=
, and the final
> > - *    private data handle=E2=80=94into the pre-allocated contiguous me=
mory buffer
> > - *    (file_set->files) that will be handed over to the next kernel vi=
a KHO.
> > + *    private data handle=E2=80=94into the pre-allocated serialization=
 blocks
> > + *    (file_set->block_set) that will be handed over to the next kerne=
l via KHO.
> >   *
> >   * Error Handling (Rollback):
> >   * This function is atomic. If any handler's .freeze() operation fails=
, the
> > - * entire live update is aborted. The __luo_file_unfreeze() helper is
> > - * immediately called to invoke the .unfreeze() op on all files that w=
ere
> > - * successfully frozen before the point of failure, rolling them back =
to a
> > - * running state. The function then returns an error, causing the rebo=
ot()
> > - * syscall to fail.
> > + * __luo_file_unfreeze() helper is immediately called to invoke the .u=
nfreeze()
> > + * op on all files that were successfully frozen before the point of f=
ailure,
> > + * rolling them back to an unfrozen state, and an error is returned to=
 the
> > + * caller.
>
> Don't you want to say that reboot is canceled here too?

Sure

>
> >   *
> > - * Context: Called only from the liveupdate_reboot() path.
> > + * Context: Called from LIVEUPDATE_SESSION_FREEZE or the liveupdate_re=
boot() path.
> >   * Return: 0 on success, or a negative errno on failure.
> >   */
> > -int luo_file_freeze(struct luo_file_set *file_set,
> > -                 struct luo_file_set_ser *file_set_ser)
> > +int luo_file_freeze(struct luo_file_set *file_set)
> >  {
> >       struct luo_file *luo_file;
> >       struct kho_block_set_it it;
> > @@ -506,9 +505,6 @@ int luo_file_freeze(struct luo_file_set *file_set,
> >               file_ser->token =3D luo_file->token;
> >       }
> >
> > -     file_set_ser->count =3D file_set->count;
> > -     file_set_ser->files =3D kho_block_set_head_pa(&file_set->block_se=
t);
> > -
> >       return 0;
> >
> >  err_unfreeze:
> > @@ -519,28 +515,25 @@ int luo_file_freeze(struct luo_file_set *file_set=
,
> >
> >  /**
> >   * luo_file_unfreeze - Unfreezes all files in a file_set and clear ser=
ialization
> > - * @file_set:     The file_set whose files are to be unfrozen.
> > - * @file_set_ser: Serialized file_set.
> > + * @file_set: The file_set whose files are to be unfrozen.
> >   *
> >   * This function rolls back the state of all files in a file_set after=
 the
> > - * freeze phase has begun but must be aborted. It is the counterpart t=
o
> > - * luo_file_freeze().
> > + * freeze phase has begun. It is the counterpart to luo_file_freeze().
> >   *
> >   * It invokes the __luo_file_unfreeze() helper with a NULL argument, w=
hich
> > - * signals the helper to iterate through all files in the file_set and=
 call
> > - * their respective .unfreeze() handler callbacks.
> > + * signals the helper to iterate through all files in the file_set, ca=
ll their
> > + * respective .unfreeze() handler callbacks, and clear the serialized =
blocks.
> >   *
> >   * Context: This is called when the live update is aborted during
> > - *          the reboot() syscall, after luo_file_freeze() has been cal=
led.
> > + *          the reboot() syscall, after luo_file_freeze() has been cal=
led,
> > + *          or when an early-frozen session is released before kexec.
> >   */
> > -void luo_file_unfreeze(struct luo_file_set *file_set,
> > -                    struct luo_file_set_ser *file_set_ser)
> > +void luo_file_unfreeze(struct luo_file_set *file_set)
>
> I went several time back and forth trying to understand why we remove
> *file_set_ser here.
>
> Maybe add a preparation patch that does the renames and moves file_set_se=
r
> handling?

Yes, this is a good suggestion. I will add another patch  to rename,
and change the argument.

>
> >  {
> >       if (!file_set->count)
> >               return;
> >
> >       __luo_file_unfreeze(file_set, NULL);
> > -     memset(file_set_ser, 0, sizeof(*file_set_ser));
> >  }
> >
> >  /**
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_i=
nternal.h
> > index dac6644bfb18..b3fc3dcf5f36 100644
> > --- a/kernel/liveupdate/luo_internal.h
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -64,6 +64,8 @@ struct luo_file_set {
> >   *              previous kernel) sessions.
> >   * @retrieved:  A boolean flag indicating whether this session has bee=
n
> >   *              retrieved by a consumer in the new kernel.
> > + * @frozen:     A boolean flag indicating whether this session has bee=
n
> > + *              frozen early from userspace.
>
> s/early/explicitly

OK

>
> >   * @file_set:   A set of files that belong to this session.
> >   * @mutex:      protects fields in the luo_session.
> >   */
> > @@ -71,6 +73,7 @@ struct luo_session {
> >       char name[LIVEUPDATE_SESSION_NAME_LENGTH];
> >       struct list_head list;
> >       bool retrieved;
> > +     bool frozen;
> >       struct luo_file_set file_set;
> >       struct mutex mutex;
> >  };
>
> --
> Sincerely yours,
> Mike.

