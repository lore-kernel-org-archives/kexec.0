Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11B606A329
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v0KYyNhK;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5d/fGZi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hhNNwe04L4FKYQylx+fx8GowXeOCuwfY4bU4uoMs+Zk=; b=v0KYyNhK104rsp/RxUSHT391Io
	bo1GxWZBFwpzL/LVDc6C9ylsFagzBWsmkf/QSjBRXQ/MRSQGOXKdZW08M/8b4lDVEua4b0ocyBcr3
	M1+ptzUlUx6Btc9GV8pUb/aBxGfOmeuR++boBnvJv/fWawLW56BDzOIaquTv0YPxNhYhMoLfIJSuu
	0NdsiTykivHB6/fLws7fG9tFR7O8ETAOlzR4JoK3N5sneyY90mpQ6z86lXN58GxhBPFa6UZQcBabV
	ZANDBTjeCe6B3nqXrTVeCf7X7rM3UaxMTztqt56/oYkJCC6x6AmvyMcZSgTeI6WMEGKbHR0CMuvSA
	0mVQOadA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cq-0000000AM3t-3OrG;
	Thu, 05 Nov 2026 19:33:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3AS-0000000AKnd-07Sv
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 79E07601F5;
	Thu,  5 Nov 2026 19:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA2F1F000C1;
	Thu,  5 Nov 2026 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907035;
	bh=hhNNwe04L4FKYQylx+fx8GowXeOCuwfY4bU4uoMs+Zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H5d/fGZie/GoRN7MHtK+vOB/Ap1IgYNrnS7OIFVYrIl3BAh2twEoWoV2v1D1ANr82
	 Z88cSeALKxyTaNGZMcx6eAjOqVsj7JMMVVHDzaMXh9vzmIx4JwInJVfr9Glo3L+Jbr
	 EcyVSXsNPriCocoRBtla7Tbb+aIbDHKYiN5X3R3O6c36//3BOWw3M4U+PaEq112AWQ
	 9c6EaQ95R7dZEkoNxWPFXpR5y//vT+nN/V5TXpwOF2BZ/cJsAVeFgDgQAnT/m8f7XF
	 3V3fQRCNlNmMpcBNkB0tSssvWsyXhfdHIwU6LUOeywmgh0K3F4lJUnYbrVCAdczb3x
	 LI5cY1vDJVFeA==
Message-ID: <sashiko-outbox-199914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 51/51] selftests/proc: check that a faulting
 readlink() doesn't hold up removal
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-51-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-51-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:32 +0000
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

> Add the symlink case:
>=20
> - readlink() /proc/asound/<id> of a dummy card into a buffer backed by
>   userfaultfd
>=20
> - change the card's id through sysfs while the reader faults, which
>   removes the symlink with snd_card_mutex and info_mutex held
>=20
> - expect that to finish without waiting for the reader
>=20
> Skipped without snd-dummy.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D51


