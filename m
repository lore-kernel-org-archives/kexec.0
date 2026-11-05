Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE96077C95
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gog/LpOX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j23WgGy3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lQ8JIZZ5kxkUAmXk+xiS/+ArzA9TFxFnFqVMIk+xVec=; b=gog/LpOXFQWu12jdK4o2GF4fEb
	uu80iJVtGyUA4TeOT8i9MAn5igiZG7EVy/H4p6O2FA+iSAWSo2dQ/GZF077tOcGHw1yeJObE30aYa
	Om4771YDdxzUKnLOoS21UnOlN5CAc0I2+1G3mydoY0tnPlRj+TFdzP1uH3zxvCUDc2rp7AtjrzXFn
	f3Yh+bWt0IxoPs2BZRzco5si6zE2pjsOsmH4sncsT7Z8TPFmw34WXbvXDby6KC+CWgNeqrvFCkdT+
	FpLzCB2D/sCvp3TPA1vQ+5rpRQXaQZBPoZA2AZ2/1hP0fZdmCloHfkpbeLJvdlxhKqTEmAN6qo0rY
	Y2Fk55rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3T4-0000000APy7-1Gj1;
	Thu, 05 Nov 2026 19:49:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Sn-0000000APlS-23fd
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:49:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E9E6260235;
	Thu,  5 Nov 2026 19:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52EE1F0089F;
	Thu,  5 Nov 2026 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908172;
	bh=lQ8JIZZ5kxkUAmXk+xiS/+ArzA9TFxFnFqVMIk+xVec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j23WgGy3ZqOpo9kyAHUXU5TgvkUzhD6a54kglnxcdgVHF5WgUmqLTvnUkLSBL02NN
	 ZdW0u6lyXYxXcbzgP4wZH3y1mtnPgrg5z7WwxtjxTC0MXuUY7FZBiGNIJN33actq5M
	 5yEtX7ikb+TeUy83H9n+K05TTJFiakZeU4BBjUvK8gx/zO1ZuKoWzEZSfEaKAkxDJ2
	 KAukZAJBis282pacUrKrUpdcLpMu2c+LVBvHUNQoV0aMN6jIUx+dB0vbXhUvz3bUUN
	 fJ/2AAVIZ6++OWfNDvCq5yu5I3y9gI6EpRYBWpZ5gmuqjIbW8UEqzGQ4UAADKdqsI3
	 MtbtxRO6ZwLEg==
Message-ID: <sashiko-outbox-199998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 12/26] selftests/proc: check that a faulting
 writer doesn't hold up removal
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
In-Reply-To: <20261104-work-procfs-drivers-v2-12-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-12-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:30 +0000
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

> Write to /proc/scsi/scsi_debug/<host> from a buffer whose page is backed
> by userfaultfd and remove the host while procfs copies in what is
> written:
>=20
> - removing the entry doesn't wait for the writer
>=20
> - the write fails with -EIO once the fault is resolved
>=20
> The test loads scsi_debug if it isn't there and skips without it or
> without /proc/scsi.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D12


