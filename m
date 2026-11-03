Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A9606B243
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l1Y2rn5K;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8FNSykI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oZNMg0XOhOF82NdxKw8m3fuJZ/CwTFkJ3vKS6G2BA+8=; b=l1Y2rn5K73jV3mTmNykizg/Wdx
	dYqVkb4fJHsfOr1zw9h3nPE9oBh+h6jEQrLP/h9Q5BMfIz2G9aeQSNcW3itBCZuEevz1phg0cwZfc
	AULuQkUqdG3Y1m8ugs9sSffBsZysBkK8gFaSgDIq6+a43VmbCiIyvcSiOSk2CjxsdPoeKea3+1toU
	WQoP7teOF6GwRWfE1T4sbz2Ux9zDNnI0C3cZ5xWDURK50cOIBxmrtBhOEvGAFr9W3wixlY0D9+imK
	n1si/WobIwaTjhAA26AM9cBTp9jN4RvpcfEhEgSTK2dJWvhRpd8oCh9OV78nM4KonCOd/CKL/nPsG
	a5Kp4prA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoT-00000002lkf-15HH;
	Tue, 03 Nov 2026 14:48:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoL-00000002lbo-2k4Y
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:48:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1C17E609ED;
	Tue,  3 Nov 2026 14:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCB31F000C1;
	Tue,  3 Nov 2026 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717308;
	bh=oZNMg0XOhOF82NdxKw8m3fuJZ/CwTFkJ3vKS6G2BA+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8FNSykIjsbIYyaW7wlpeo7Jpn0dKaAreMckL+hzdum+Nm9DhHKifm2w4cRC12Zuf
	 FMphUuoK+hWmYUdPHNzO6H8bziy31o7b+pN218q2Hp1gBYtkbTvpEUQ+x2kYJUTGbU
	 amr4aSwQRjTvoLEO8pBwqFwBIAflxH0WBNUru5M44VEqR+WrJF38qQzc5RNwaaY8rK
	 U/bSSq6pCzSaxPBgrjZXz5mOFbKW0lxZLA/85eQV8QSkyLI5I1g237UjWtVW4FOz4i
	 7eRL44CQhswG3W572187LfOOth0Bx8K25XUo4u38O9AE4bdxmCYBIrD7N596LhCSKY
	 60DTPQ7Vz2Maw==
Message-ID: <sashiko-outbox-195502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 30/38] powerpc/pseries/lparcfg: return h_get_ppp()'s
 status as a long
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-30-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-30-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:26 +0000
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

> h_get_ppp() returns the status of the H_GET_PPP hcall as an unsigned
> int. update_ppp() hands it on as its ssize_t result, and
> lparcfg_write() turns the hcall statuses it knows into an errno and
> returns anything else as it is. So when H_GET_PPP fails, say with
> H_PARAMETER (-4), the status comes back as 4294967292 and a write to
> /proc/powerpc/lparcfg reports that many bytes written.
>=20
> Return the status as the long it is. lparcfg_write() then treats it
> like the status of H_SET_PPP and an unknown one is at least negative.
> Before commit 11529396ea31 ("powerpc/pseries: Split processor
> entitlement retrieval and gathering to helper routines") a failed
> H_GET_PPP turned into -EIO.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 11529396ea31 ("powerpc/pseries: Split processor entitlement retrie=
val and gathering to helper routines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D30


