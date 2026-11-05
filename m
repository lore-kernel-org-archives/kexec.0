Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD96606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VtmSmGEI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOvMqP+c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Uq4i262WOQaYVL9uHrrjKQ33JdfPWVKPdUraeND3OfE=; b=VtmSmGEIsyAM0rzZvTAhJFH4IZ
	HLIJTASjFPBW7w05xgwtdYumOPdRQnLLyRbiboy5aIUnhUG7aPHQ7FFp/ZTRmDpQNUg/CPW56D0jz
	iGIV1OuXpCvQOgnIZhN/M19JDByB66bmVZu18StJDPHEVJh2S3zs9Z59SnhwsZFh7FoX05ANErx8E
	hnNtFNmSPRkXfNYPVCzvHcEYqbOm0sjpZAyGiCgoNlpOpEvU5MObL1sIuHFYxJO4GSR7Y5r5fuyVB
	gPiAyt/mT1dxpuIX1IM026rHa2DEYEzdAKIKnY48Y6xsZMVOl3j4n7jD2YkIvruD3uHSOB8DEVyBx
	V1SuyeWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3HX-0000000ANkU-0ALs;
	Thu, 05 Nov 2026 19:37:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Fb-0000000AN5C-2Y2e
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:36:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 115C9601AC;
	Thu,  5 Nov 2026 19:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4891D1F0089F;
	Thu,  5 Nov 2026 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907354;
	bh=Uq4i262WOQaYVL9uHrrjKQ33JdfPWVKPdUraeND3OfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOvMqP+c6a7YXK9+H/ZuDenXtrEpHzLqnu+MIMYNNusWymGQVT1Q4/ec1t4w9PjCO
	 qmkMvDH17i0eObC2beXzEFzADb2Xw2kymtYtn4SFw8ANhKSVhVpcnkQtfbpcSYZg9N
	 4l7J3MSm3a+sGzpZkH8kVTx2NrNd1TkZE3b0wDS9CPx8atrywkEgH3c4qaCIcxYIm9
	 dducVG4MRPcnbp0cfT9GmqSQ0uK/VKpBfmn2Z5AJsRGEKqgwI3kPTede2Uzq0Kx9jz
	 cWMxxkM6AxN0Z0X5UmQGN06QpwBQ8vnODudNJE/T70S35JR+kfwyN2SPUyPEeWjKos
	 Y2lpLs6jftrBQ==
Message-ID: <sashiko-outbox-199949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 19/23] proc: pin the entry around the
 vm_operations of its mappings
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
In-Reply-To: <20261104-work-procfs-core-v2-19-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-19-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:52 +0000
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

> proc_reg_mmap() pins the entry around ->proc_mmap() and that's it. What
> the entry hands out lives on without the pin: the vm_operations it put
> on the mapping run on every fault, on every write to a read-only page
> and on every ptrace access with the entry unpinned, and the mapping
> itself survives remove_proc_entry(). For /proc/vmcore that means the
> fault handler runs after vmcore_cleanup() freed what it looks at, and a
> mapping of the old memory keeps pointing at it after fadump gave that
> memory back to the page allocator. /proc/bus/pci has the same problem
> when a device goes away.
>=20
> So do what kernfs does for the mappings of sysfs files. procfs puts
> vm_operations of its own on the mapping. They pin the entry around its
> ->open(), ->fault(), ->page_mkwrite() and ->access() and fail with
> SIGBUS, or do nothing, once the entry is gone. The entry's
> vm_operations are kept in its open node, so every mapping of an entry
> [ ... ]
> window.
>=20
> Entries that are never removed aren't wrapped, procfs never pins them.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D19


