Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E149606A329
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EH80iupP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PS7EuTM4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Di4Zv2+bgkX+HhZmCpdKbhvfGlZoAaFGwpTTtNZDf1w=; b=EH80iupP3sTkXlIjEXGaq+sTS8
	NBHxlXl012DEN6qQxsePfUc5KxiMFAsyw4HAmnaPVQr9203KX4RaXSHGM2UZqBR7lVYihfheVy4DE
	adkcZVd7kPkaVeGtBTa0Mpnbb1dqexfqqCb4kn05iqxwqlNoOP8l5alw4lqFGLZVDUi4bqHiXRl/W
	IXiryVZo1QdtlnLAGbECc5uBq6BX7gjkCnoskfN1DY8IEyPqqhCOIOAksJnoyUTbeLo77Icv4hR9s
	Wafy9pqYoCsCsIXYJVCE2VCvs5jowGJdR1IZNJk1Q1soxaYyT6EVpylbJye8uXtSQE5KFvb8YSFVC
	u2+202oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3cA-0000000ATPp-0LP1;
	Thu, 05 Nov 2026 19:59:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bF-0000000ASn8-3fRj
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:58:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F0D142B67;
	Thu,  5 Nov 2026 19:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4B01F008A2;
	Thu,  5 Nov 2026 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908697;
	bh=Di4Zv2+bgkX+HhZmCpdKbhvfGlZoAaFGwpTTtNZDf1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PS7EuTM4dqldTrwdAR0onQbkCjogqgjpUy8oBN5Oi/jsHPd1HPHlgSGbxScX7TULM
	 hRB6vR+pRSsaVGMqkA0T2yAO/9EP8dfTHiI3smO+XSdOQTs0WaU0CSspRWwNIygWmH
	 xxyaJ/jl5nVv4oGCeueAnyoM+i/SNOz1yePgzX6SBUyU7ID4QMKKDqnCau9Fzxv22l
	 9yUUQnAUlAQfxJYnkuFIsPSnTWbDHjOSLzPYjAQnKTCY8vnyzOnX2r4MnJUC80Xsxq
	 9G6Oxyszcx5C+PQB+DFxzoyTPD+CIGBL43AvNqSOHfSpIHjw0LBt6ISDjfycxH6Ryo
	 K9q3hUiMFf+cA==
Message-ID: <sashiko-outbox-200057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 23/30] dyndbg: let procfs copy in writes to
 /proc/dynamic_debug/control
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, tytso@mit.edu, dmitry.torokhov@gmail.com, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Anna Schumaker" <anna@kernel.org>, yukuai@fygo.io, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-work-procfs-fs-v2-23-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-23-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:58:14 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dyndbg: split declaration and assignment of __free() in ddebug_proc=
_write()
--

commit 1bfaabab91de2989a4d10ae03eef349ab77809d6
Author: Christian Brauner <brauner@kernel.org>

dyndbg: let procfs copy in writes to /proc/dynamic_debug/control

This commit factors the query execution logic out of ddebug_proc_write() in=
to
ddebug_proc_write_buf() and switches proc_fops to use .proc_write_buf and
.proc_write_size so procfs copies in the user buffer before pinning the ent=
ry.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 64a2112908725..1d6012c9eb41f 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -1002,11 +1002,28 @@ __setup("dyndbg=3D", dyndbg_setup);

[ ... ]

>  static ssize_t ddebug_proc_write(struct file *file, const char __user *u=
buf,
>  				  size_t len, loff_t *offp)
>  {
> -	char *tmpbuf;
> -	int ret;
> +	char *tmpbuf __free(kfree) =3D NULL;
> =20
>  	if (len =3D=3D 0)
>  		return 0;
> @@ -1017,15 +1034,7 @@ static ssize_t ddebug_proc_write(struct file *file=
, const char __user *ubuf,
>  	tmpbuf =3D memdup_user_nul(ubuf, len);
>  	if (IS_ERR(tmpbuf))
>  		return PTR_ERR(tmpbuf);
> -	v2pr_info("read %zu bytes from userspace\n", len);
> -
> -	ret =3D ddebug_exec_queries(tmpbuf, NULL);
> -	kfree(tmpbuf);
> -	if (ret < 0)
> -		return ret;
> -
> -	*offp +=3D len;
> -	return len;
> +	return ddebug_proc_write_buf(file, tmpbuf, len, offp);
>  }

[Severity: Low]
In ddebug_proc_write(), tmpbuf is declared with __free(kfree) =3D NULL at t=
he
top of the function before the early length checks and then assigned later =
via
memdup_user_nul().

Per the cleanup.h guidelines, could tmpbuf be defined and initialized in a
single statement at the allocation site instead:

	char *tmpbuf __free(kfree) =3D memdup_user_nul(ubuf, len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D23

