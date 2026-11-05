Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F21606A326
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SpB2/hEM;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8czzOm3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=t5ltLRfeO7A4ze3tr9EcZS3s3I93T55/6iRGXRatBcI=; b=SpB2/hEMSigEokREU5alhDhDZo
	/euwv/IChcS0nusjiMl3s2ITNWp5FmojJZWni7bYF1/VyLgSiR9/Vm7eOBhoMGWb1OYI7JDrkz9Iq
	6hEkVIqe9ZEelilDx14MtGmch8VhvU2xCC+vzVQLkE+Ovrxq1MvyLrQcxEfWaLKaGsyjwbWFOiISb
	X0giaTHSkaodnKPevoNhTu+WYleuH7ZSf+1XakNhEy9UWY0Y/VuaI1BeNpxnc81fgEJxOe/nzM1vi
	mGxmcvB3Zq4EuG4UZBiTj6faAZwfyfkS/01ZrouNzcmDlvulkCjRUrKSOF0XEKqnC1rhfKu6chMTn
	mL8rsHYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP38l-0000000AK38-2aA3;
	Thu, 05 Nov 2026 19:28:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP38k-0000000AK2l-2CxW
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:28:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C4684168D;
	Thu,  5 Nov 2026 19:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F791F00919;
	Thu,  5 Nov 2026 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906929;
	bh=t5ltLRfeO7A4ze3tr9EcZS3s3I93T55/6iRGXRatBcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8czzOm3uss/Nev41wWI2HCgtA/JJ30J5ZI/5HvqHyryejYB/vPH/hBylXVkVGrv6
	 OielTQZZJsAgzXMX0XY5+ywbGo0mmqbyFRwY2koxZomesAs/TJ9/gk+vP/71ryRjrz
	 T4vkNotZqPxmBNAvJ14HURgj7iVi6JGCZi7FoFu5UsPJYhvBEXafmV8KZulQt0TLUa
	 bnhBhsrybsI04J6qaEoTmohzhtxxwuJRWFtL3gmSrI+vhB1bjBR5l4UtjzfZC6c0lO
	 DCD02LTUhjPPRIlhUjpD4vyOQAhRmKBCDZpyL6ta2I03KLDunRpmQHSavStcgYROjy
	 RlifknHgKJUtA==
Message-ID: <sashiko-outbox-199864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 01/51] alloc_tag: don't remove /proc/allocinfo
 under the codetag module lock
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:28:47 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] alloc_tag: unused function shutdown_mem_profiling_async() when !CON=
FIG_MODULES
--

commit ec0095b3ecdd2d01651f48bc80cc81d976e06106
Author: Christian Brauner <brauner@kernel.org>

alloc_tag: don't remove /proc/allocinfo under the codetag module lock

This commit defers removing /proc/allocinfo to a work item when
reserve_module_tags() fails, avoiding a deadlock between remove_proc_entry()
waiting on active procfs readers and allocinfo_start() waiting on the codet=
ag
module lock.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 82e2c3448dcf2..7d7ad67049537 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c

[ ... ]

> @@ -604,6 +605,26 @@ static void shutdown_mem_profiling(bool remove_file)
>  	mem_profiling_support =3D false;
>  }
> =20
> +static void remove_allocinfo_file(struct work_struct *work)
> +{
> +	remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +}
> +static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
> +
> +/*
> + * A module's tags are reserved with the codetag module lock held for
> + * writing, and a reader of /proc/allocinfo takes that lock with the ent=
ry
> + * pinned. Removing the entry there would wait for that reader for good,=
 so
> + * let a work item do it.
> + */
> +static void shutdown_mem_profiling_async(void)
> +{
> +	if (!mem_profiling_support)
> +		return;
> +	shutdown_mem_profiling(false);
> +	schedule_work(&remove_allocinfo_work);
> +}

[Severity: Low]
All callers of shutdown_mem_profiling_async() are in reserve_module_tags(),
which is inside the #ifdef CONFIG_MODULES block further down in
mm/alloc_tag.c.

When building with CONFIG_MEM_ALLOC_PROFILING=3Dy and CONFIG_MODULES=3Dn, w=
ill
defining remove_allocinfo_file(), remove_allocinfo_work, and
shutdown_mem_profiling_async() outside #ifdef CONFIG_MODULES trigger an
unused-function compiler warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D1

