Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A4D6082BFA
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WDAezFfr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoJeH/FT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Bc8aT4Z6get1K0vbpp5ygtanM/hIwI+PelNNb0VgB7c=; b=WDAezFfrPYfVi0oe/DtCsSvvD5
	e9rnb4JdDJiO/RBloOjE1bxRevY3gntotmAPyZm8c5IRfOPcZry7d5ZW+6qAjeh4CGon1MvGZ95f1
	M+/opiq1SYXi57/KlZjLMQuhkxOi/Cl+9t2WNXQmoX0rJete1uluKgomK68yEe6Gj/dbXlbnu/fJD
	JPxHxgQvsnfPub0GKoUSTcJQDz/KhnJMaXwWU9wgQ+ot7qT9GdOzMLUd8CxNm3xP11qyM5LZHrFPR
	RYRiuakYyLQbGfw46jTeMBnAS/mZvkQmmp8Kp11Vo+ywdt4OS1NskTl++Ns2r51x/ZAjykaeftiLM
	3OnHnNUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHn-00000002vCR-0G1x;
	Tue, 03 Nov 2026 15:18:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHi-00000002v8g-41VN
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B24DC42217;
	Tue,  3 Nov 2026 15:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856681F0093A;
	Tue,  3 Nov 2026 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719130;
	bh=Bc8aT4Z6get1K0vbpp5ygtanM/hIwI+PelNNb0VgB7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CoJeH/FTtYurhrEu7pHCjreAy8kglbRPwM3Bp2MFbNXs5sfimskiQ6GdFaw2b46h5
	 LFYZjIjC0HLk9VtZElPrV+LCrvrtO/TXriYCzcHxI7ww7m4DuMtGSua9gCijZ8ag5C
	 C1QyPEjg//XpCtccxJ83qTFkU2bPqiwCZUATJ82pjvzmj0HhclIwZdtkBZ4X0D4FpB
	 W2kjXVSW4Jh+gJKkh7n8hluL4QKxxLPc9zkayoPnR79tHeS7TL9oS5+LArhquuyOcO
	 R0f20W9hUcQSALMEMf5u4F5ldJdbIIx8/qJHUPE3ePz+MiGIzk37ns/uj3hE88ZoNC
	 wd/gwuy246nxg==
Message-ID: <sashiko-outbox-195591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/23] selftests/proc: check that a faulting writer
 doesn't hold up removal
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
In-Reply-To: <20261102-work-procfs-drivers-v1-11-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-11-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:48 +0000
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
- [Medium] selftests/proc: fail and leak scsi_debug host without CONFIG_SCS=
I_PROC_FS
--

commit d0cceed0cde591b286c7977ad630183fc653ded2
Author: Christian Brauner <brauner@kernel.org>

selftests/proc: check that a faulting writer doesn't hold up removal

This commit adds a procfs selftest that uses userfaultfd and scsi_debug to
verify that a writer faulting during copy-in does not block removal of a
/proc/scsi/scsi_debug/<host> entry and fails with -EIO once the fault is
resolved.

> diff --git a/tools/testing/selftests/proc/proc-remove-slow-writer.c b/too=
ls/testing/selftests/proc/proc-remove-slow-writer.c
> new file mode 100644
> index 0000000000000..f69ca75ba87cb
> --- /dev/null
> +++ b/tools/testing/selftests/proc/proc-remove-slow-writer.c
> @@ -0,0 +1,203 @@

[ ... ]

> +/* the numbers of the hosts in /proc/scsi/scsi_debug as a bitmap */
> +static int list_hosts(unsigned long *hosts)
> +{
> +	struct dirent *d;
> +	DIR *dir;
> +
> +	memset(hosts, 0, MAX_HOSTS / 8);
> +	dir =3D opendir(HOST_DIR);
> +	if (!dir)
> +		/* the directory comes with the first host and goes with the last */
> +		return errno =3D=3D ENOENT ? 0 : -errno;

[ ... ]

> +FIXTURE_SETUP(host)
> +{
> +	unsigned long before[MAX_HOSTS / HOST_BITS];
> +	unsigned long after[MAX_HOSTS / HOST_BITS];
> +
> +	self->host =3D -1;
> +	if (access(ADD_HOST, W_OK) && system("modprobe -q scsi_debug add_host=
=3D0"))
> +		SKIP(return, "no scsi_debug");
> +	if (access(ADD_HOST, W_OK))
> +		SKIP(return, ADD_HOST ": %s", strerror(errno));
> +
> +	/* host numbers are reused, so look for the one that's new */
> +	ASSERT_EQ(list_hosts(before), 0);
> +	ASSERT_EQ(add_host(1), 0);
> +	ASSERT_EQ(list_hosts(after), 0);
> +	self->host =3D new_host(before, after);
> +	ASSERT_GE(self->host, 0);
> +	snprintf(self->path, sizeof(self->path), HOST_DIR "/%d", self->host);
> +}
> +
> +FIXTURE_TEARDOWN(host)
> +{
> +	if (self->host >=3D 0 && !access(self->path, F_OK))
> +		add_host(-1);
> +}

[Severity: Medium]
What happens if the test runs on a kernel where scsi_debug is available
(CONFIG_SCSI_DEBUG is enabled), but CONFIG_SCSI_PROC_FS is disabled?

The sysfs attribute /sys/bus/pseudo/drivers/scsi_debug/add_host is still
present and writable without CONFIG_SCSI_PROC_FS, while /proc/scsi is never
created. In FIXTURE_SETUP(host), list_hosts(before) sees ENOENT on
/proc/scsi/scsi_debug and returns 0, add_host(1) creates a new scsi_debug
host in the kernel, and list_hosts(after) still sees ENOENT and returns 0
with an empty bitmap.

As a result, new_host(before, after) returns -1 and ASSERT_GE(self->host, 0)
fails the test instead of skipping for the missing prerequisite. Because
FIXTURE_SETUP(host) aborts with self->host still set to -1, the newly
created scsi_debug host is never removed by add_host(-1) and remains leaked.

Should FIXTURE_SETUP(host) check that /proc/scsi exists and skip before
calling add_host(1)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D11

