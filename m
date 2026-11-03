Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC876082BEB
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZfATI3ol;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVuIrc17
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0V+CicgMBoN1QbZ4PU2bDKMr8pvOiaSaM7EPJ1DfD7w=; b=ZfATI3olvYRJDCfu5AYE5eQYFy
	uRVAByT0bjcBheW4N5zfA9LTdIZsk5MNkWHA8XBJYwNuW1v9vyU3t17ppa9sM+ZXE6/uZBEioS4YJ
	X8a3euV9PkH6tSQzT65070obXPV6JQ44gpOzdDxgiWIRfbaKCP6ZQTaNaQkaB31jE/2Ge472kqSzF
	na9YvV74To3Hiu+nq8lFzYSBETgn2kVS/7nVFBy/0oTxbjfzzVe+omWO7iJFMl15NtS1WC+K/glZQ
	T2WjGxYa+JNAouxDwbWE5d2CitY5wDOiiMSFyOywuU+Ai2zdwlaTgGYfBPxWglkRq2Fv3HPsc4zmL
	RP7R/rtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFog-00000002m1b-1G2U;
	Tue, 03 Nov 2026 14:48:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFoe-00000002lxk-2Xf6
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:48:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 04F2A60622;
	Tue,  3 Nov 2026 14:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0571F00919;
	Tue,  3 Nov 2026 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717327;
	bh=0V+CicgMBoN1QbZ4PU2bDKMr8pvOiaSaM7EPJ1DfD7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PVuIrc17XR1DR65SazgbGfICE7wjxOzqZgkY9U1rqo2UnB6kZRbNYqycjDbOYBHPI
	 mtr+oI337If1hGZt23auaywjb3aFf3e8V7x2KLacnHZWCqxTNAHGtZLRjV/QTQa/U0
	 2ZVG3QOmYYo3Vbue///pzGjX2fvcEVYSv1E5A4Nokf1yW93VnBHjLJNY9R0S7cKzna
	 lEsPjbqB4XU52YaxjHh1FMLVvCbZQad8DMHktuK95ryZyb144WX0kMVeswfQ7MIXWT
	 q6wVkMNqoNp3Q2h44ir/sz5Pqydvc1rrrcEksxS0NSkW2lL6OZFvuNnmSZDzSaqv1o
	 ng7I2nNH/acPg==
Message-ID: <sashiko-outbox-195510@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 38/38] selftests/proc: check that a faulting
 readlink() doesn't hold up removal
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-38-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-38-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:45 +0000
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
- [Medium] selftests/proc: Makefile adds nonexistent proc-remove-slow-reade=
r target
--

commit ac0073c08526e8690efa58576485d79bbd906522
Author: Christian Brauner <brauner@kernel.org>

selftests/proc: check that a faulting readlink() doesn't hold up removal

This commit adds a selftest verifying that a readlink() call faulting via
userfaultfd on /proc/asound/<id> does not block removal of the /proc symlink
when renaming a dummy sound card.

> diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/self=
tests/proc/.gitignore
> index 7b81334927820..e2566cc0ae079 100644
> --- a/tools/testing/selftests/proc/.gitignore
> +++ b/tools/testing/selftests/proc/.gitignore
> @@ -22,6 +22,8 @@
>  /proc-uptime-002
>  /proc-pidns
>  /proc-remove-slow-sysctl
> +/proc-remove-slow-reader
> +/proc-remove-slow-readlink
>  /read
>  /self
>  /setns-dcache
> diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selfte=
sts/proc/Makefile
> index bce6beca72744..6a9bdc999f545 100644
> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -33,5 +33,7 @@ TEST_GEN_PROGS +=3D proc-fsconfig-hidepid
>  TEST_GEN_PROGS +=3D proc-sysctl-readdir-churn
>  TEST_GEN_PROGS +=3D proc-pidns
>  TEST_GEN_PROGS +=3D proc-remove-slow-sysctl
> +TEST_GEN_PROGS +=3D proc-remove-slow-reader

[Severity: Medium]
Was proc-remove-slow-reader added to TEST_GEN_PROGS in
tools/testing/selftests/proc/Makefile (and to
tools/testing/selftests/proc/.gitignore) by mistake?

This patch adds tools/testing/selftests/proc/proc-remove-slow-readlink.c, b=
ut
tools/testing/selftests/proc/proc-remove-slow-reader.c does not exist in the
tree. Because the default all target in tools/testing/selftests/lib.mk depe=
nds
on $(TEST_GEN_PROGS), building the proc selftests fails with no rule to make
target proc-remove-slow-reader.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D38

