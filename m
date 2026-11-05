Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525160741CE
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NG8A8QBz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4uXMQS0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LF8VpmJw4dCUN3dqspTWei3V377XPonyjnxs49cHpOg=; b=NG8A8QBzYuOqm7V7lUccuivsjc
	nWU67KyPTMULEEB9+IFd+nxl4O15SNGCpQwhXxt1zzDrXaqBFSx1HqVONtr5+mj1Gc0iM/E6HtU+y
	CnP+zAlxDqbHGJYwmxFcST7gBaEfhYzjiC3pr7WTh+WNWMgAO4tV13lt1x7SHMkGf4rAgMAF45b4B
	+dQpa07gDXHFZz9g5OtCne0lVyCKBK0OwdnzDp8WDhVE52vzB8cCL+Xl/fj7vp71DThZtP/QtRgri
	XTsGJhW2ZgXwpUKa2cpZ5nvvuN9K6TRTS+XL73dvveqyDxbKfWhewBblfgGqZ3n6ORZpAFBGEBO7v
	X73isoAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Sp-0000000APmL-3aGm;
	Thu, 05 Nov 2026 19:49:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3SY-0000000APhO-3thY
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:49:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AD88E438F2;
	Thu,  5 Nov 2026 19:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7DA1F0089F;
	Thu,  5 Nov 2026 19:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908158;
	bh=LF8VpmJw4dCUN3dqspTWei3V377XPonyjnxs49cHpOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P4uXMQS0qGvKvjXwimwvNpEP86OSTy+1P03oepuCWi2uHAnixHXsgMAU6QqtIOry3
	 K3QqnkC+misS2LDKVZVl7RGt5gyckxcJdleSix8YLMu65Jc+DdOgSM0oSOd9tUEQ3b
	 Fp4U6JF/uNE8R52gsNWntUcjnDZkqxkce2kcKjifgoBueIcJVGHhk/f9XP4Nk5o26I
	 Eb0/TSjZ8oOdGaJC1+/zDtxAXdUZ8ONcd0qruzsYz7D7ovOHWwNXas4S58DiNRTZha
	 ovqkoGSLcs2Uzae2+RygZDj4AM5s2bRqvh74o9xP5jgHwhTt3uTIudTRbgcITC2H9F
	 XJDGcW2q+s0Lg==
Message-ID: <sashiko-outbox-199992@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 06/26] md: let procfs own the seq_file of
 /proc/mdstat
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
In-Reply-To: <20261104-work-procfs-drivers-v2-6-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-6-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:16 +0000
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

> Declare the seq_operations and let procfs open and free the seq_file.
> ->proc_open() only records the event count for ->proc_poll() now.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D6


