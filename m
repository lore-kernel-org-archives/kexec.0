Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC137606B9E8
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oWUzk7vr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEI4ikOB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8t0QfyFe1liiONBCTMlez4ytrK71Ift17tTGikupoLg=; b=oWUzk7vrhgIyamRQ3gg4qlz5wl
	ysoSJYZNRVCpMIctIn1CtYR3ZrbJGWhZNzjWCjupdFcVRJ3BTENa3y+XTk/stz2wv9bi7G4S8CFw3
	Cvp6FaARJLwkLyokIxdzly1474LSKevbsKl+LtLmnBCiEsLonsp+udJbd3bX1C9NQrhvs6kV3A6F8
	hoMIuN2HiQTFz4M1/LpLFs2fqcvtSZ9vF+SbEag9zBoZ9xffY9yygbzPSKhAw8kb3bXnbbMKPw7qO
	4vuKrBufqUo0IcvTl7bd4Y9Ojf1YrudWeukcBMuQ6qYbknvhq28yN796NT2iS1+HGW9uUjzYrmaLP
	L3bY3Kzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3cB-0000000ATQc-0I6W;
	Thu, 05 Nov 2026 19:59:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bI-0000000ASnz-2UAJ
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:58:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0DE84605E0;
	Thu,  5 Nov 2026 19:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FBE1F0089F;
	Thu,  5 Nov 2026 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908699;
	bh=8t0QfyFe1liiONBCTMlez4ytrK71Ift17tTGikupoLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEI4ikOBif0YdvyG9c/JXg4UAq9wzCRJ2tUoh6l/SSa/2WVnkH9hA1BIgInSHg+q2
	 S8MvRGxkNSNXeuU2pdWx9vvH0/lHO3YLlTf6RuF/k3KGo9inmQ02djE8tGI4R3WRbh
	 txHlJHD83suRog63eGHl9b4pAooaygbYrXCtctmo+LhJDYyu9dd/pCL7jRfwULqqke
	 j9Bx2xSO9aU33IFh9Z3L7G/WC3b46VQxhi9nXsVu1DjCd0eZWp0eUtjYoBK4e3NJ/A
	 it3OWfn2/g+uGUcrJxiU+iwqJ1q0DhVeE7jszj0KGvPIQ8UbvkE8cLU9aPDbbTqcHq
	 m4sMfyWesJ+Rg==
Message-ID: <sashiko-outbox-200058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 24/30] ipc: let procfs own the seq_file of the
 sysvipc files
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
In-Reply-To: <20261104-work-procfs-fs-v2-24-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-24-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:58:17 +0000
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

> Declare the seq_operations and the size of the iterator and let procfs
> open and free the seq_file of /proc/sysvipc/*. ->proc_open() only fills
> in the iterator now and ->proc_release() drops the references it holds.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D24


