Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB0606A336
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yerb+/Pt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMGngCoO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=f7pbLgB+bOANV7ZH7bSfet1egKll+CXGNKYzJQU3Yrk=; b=yerb+/PtlyFISmVrSzu4SJX+fH
	rioBHVYoOS4az4fUVRt/jHDvpwE3eQRWv8SfaB2z7DdqwItK0OFpre/XzdeOScte4gb3J/1GEACFV
	um4OQCfB1TkPJ7DN6xj6YIEjp2mo4G4ZPecZnKQw2jD/r4XYMDIkL7j1ZAZ5uiWKYq135mk4Qe9Bt
	hvI3hTJtdQGZgIiVmcTqdxSkffWZrhESh+xapGj7elm3oAk2AeArIBXqcSeEEu8k3LKrdP0Pf4Gbu
	vaXYB1pYwgjWM6sn/9NbU2/GkkWySpJwcv6U1RDA+Cc2HJ/DllBUxWuy4dsnyuKQh05NheJurYDdO
	q1EZHxjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3HX-0000000ANlE-1Lg4;
	Thu, 05 Nov 2026 19:37:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Fg-0000000AN5S-2TVf
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:36:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B0E3601EC;
	Thu,  5 Nov 2026 19:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E9A1F008A3;
	Thu,  5 Nov 2026 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907359;
	bh=f7pbLgB+bOANV7ZH7bSfet1egKll+CXGNKYzJQU3Yrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMGngCoOl/U4CYIB1rTzS3RguQRqLRp2sKfBp3odJCcMgrP4Y2V8PmtfZZo1x5Xkv
	 FLC9VNWmdujwFQtrFCf8Mg1QUR9V0cBoPIZOnqaamHivU1nhWiKlmj37JQBwx8Nw4V
	 gnJGb6AJHKNc0HghHI9fJU1uQS16q3fA1JPSybQgU9VxlezkJg9W+I3Lt4LPHuBS+G
	 M91zjKny9mmSeWhknnqhOUNYocrnIZ20lXgBv1WbhSSK7LtbVS4MpUGhBLakgtch3v
	 NiR+5uPctDAbSjOlOz7BSSMrEU1NCpxJBHKCCILKG0ymIlPQ81348+1c7a3Gat7yd+
	 kdKHITt2fXI3g==
Message-ID: <sashiko-outbox-199951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 21/23] proc: let lockdep check the pin
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
In-Reply-To: <20261104-work-procfs-core-v2-21-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-21-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:57 +0000
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
- [Low] proc: kernel-doc mismatch on __proc_create_net_single_write()
--

commit 095fce4c95ecbe25e644f1a3fe90061f695e9271
Author: Christian Brauner <brauner@kernel.org>

proc: let lockdep check the pin

This commit adds lockdep tracking to proc_dir_entry pinning so lockdep can
detect deadlocks between proc entry methods and removal under held locks.
Entries created via proc_create_single() and related helpers receive a
per-registration-site lock_class_key via wrapper macros.

> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index b78d627b024f8..9ddd7c323dfcd 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c

[ ... ]

> @@ -232,11 +233,12 @@ EXPORT_SYMBOL_GPL(proc_create_net_single);
>   * pde_data() on the file inode.  The network namespace must be accessed=
 by
>   * calling seq_file_single_net() on the seq_file struct.
>   */
> -struct proc_dir_entry *proc_create_net_single_write(const char *name, um=
ode_t mode,
> -						    struct proc_dir_entry *parent,
> -						    int (*show)(struct seq_file *, void *),
> -						    proc_write_t write,
> -						    void *data)
> +struct proc_dir_entry *__proc_create_net_single_write(const char *name, =
umode_t mode,
> +						      struct proc_dir_entry *parent,
> +						      int (*show)(struct seq_file *, void *),
> +						      proc_write_t write,
> +						      void *data,
> +						      struct lock_class_key *key)

[Severity: Low]
When proc_create_net_single_write() in fs/proc/proc_net.c is renamed to
__proc_create_net_single_write() and given the new key parameter, the
preceding kernel-doc block still documents the old name and omits @key:

/**
 * proc_create_net_single_write - Create a writable net_ns-specific proc fi=
le
 * @name: The name of the file.
 * @mode: The file's access mode.
 * @parent: The parent directory in which to create.
 * @show: The seqfile show method with which to read the file.
 * @write: The write method with which to 'modify' the file.
 * @data: Data for retrieval by pde_data().

Should this kernel-doc comment be updated to match
__proc_create_net_single_write() and document @key (or moved to the
proc_create_net_single_write() macro in include/linux/proc_fs.h) to avoid
scripts/kernel-doc warnings when building with W=3D1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D21

