Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23990606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LCMDtAUa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFb5Yznl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2ZEFR6gjnP3wVSksugK0Xi/aHT+AN/UQkRBLfUojuMA=; b=LCMDtAUasjGOptj6qa3JJT5gCU
	M2VhcD7ckaFLom6WMD7pFC8YJw58MZBbXUy1/oMekeD5oWX/Nbov5IuJeYCqviQm/0O+FmMiM+I0U
	TwNSbqxTZg8wRRGtthCt1rzhyNTFk+ZXRqIr1JaLhW0q5YPybHBgGrPOpPekzf3HJcLA9vcLETM9I
	Y9AhzOc5gEniyUno/9Z6ni0Qu3nxfLeRxnJlKh454iAkFtnKx/jL1ik4OCtSGh5P+UqNheZecq3cO
	712HXQx+DYn5rdpBqtrFSlD4EZhrnRzJyXd6KkSVrg+fVDlUSf59IBd60sZeWxQPMhr+On2wpkigI
	d0beI9gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cc-0000000ALuO-3WGe;
	Thu, 05 Nov 2026 19:32:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3AH-0000000AKms-34r7
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 30FF0601D4;
	Thu,  5 Nov 2026 19:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2801F00919;
	Thu,  5 Nov 2026 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907024;
	bh=2ZEFR6gjnP3wVSksugK0Xi/aHT+AN/UQkRBLfUojuMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aFb5YznlYnipR19+u+Im8pSQa+/x3WULY7AoYCqTywnkISPlw9ZNAM38Fkr0pYgvi
	 6cp1ijVNCZRYHKjlbb7mp7pruaep/7wtvEt054PrL+Zxw8V6yne8Cd+u9HQSVVaeWR
	 /crGUSwOp+7vR5Uci9LlccyoZkEnJUeSmLK9Ve7s/+EFwq4GsVFjKdQehhVg+5wuGX
	 w0RgAwmJ2guiBQr2AyG8R5mOMd+mWgU2cUDkOUbrm62IVqlgFWh8+X0/UvbreN6eUd
	 orSAqTkhmHMjsXQrmyGsTaiwsc4DUpcbRA79TZz6uGLjaUzMpDTmJ0UWgvZ1kT77o6
	 QnN26MXG0YM6A==
Message-ID: <sashiko-outbox-199909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 46/51] proc: sysctl: copy to and from
 userspace without holding the table
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>, linux-s390@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-ext4@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, tytso@mit.edu, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-46-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-46-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:23 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> proc_sys_call_handler() grabs the table, copies in what is written,
> calls the handler and copies what it produced out to userspace before
> it lets go of the table again. Unregistering a table waits until nobody
> uses it anymore. So a reader or writer whose copy faults for as long as
> it wants, with userfaultfd or a stalled FUSE mapping, keeps
> unregister_sysctl_table() waiting, and its callers like to hold locks
> while they do that. addrconf unregisters the ipv6 sysctls of a device
> with RTNL held, so a stalled read of /proc/sys/net/ipv6/conf/<dev>/mtu
> holds up every RTNL user until the reader gives up.
>=20
> Copy in before grabbing the table and copy out after letting go of it,
> like procfs and kernfs do for their files. The buffer is ours, nothing
> needs the table for the copies.
>=20
> That moves the allocation and the copy in before the permission check.
> A write that can't be copied in, or a request that is too large, now
> fails with -EFAULT or -ENOMEM where it used to fail with -EPERM.
>=20
> Fixes: 330d57fb98a9 ("[PATCH] Fix sysctl unregistration oops (CVE-2005-27=
09)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D46


