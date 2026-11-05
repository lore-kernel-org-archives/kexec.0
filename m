Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97856606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hBNwRTEj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cC58zNRz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fWBORYPn6/i1UGDhFg9BaDP0viM8Zy1xYrqG6aqMLCs=; b=hBNwRTEj+RDEbbGRgZuWKtJrB6
	wBWqPQ5/HYLcPxQzEwQ8SKmNcObm5pZdDqP71ZJgYYU0C2q8Q4tCByO+AGYsRb5bq2FqKqPSEINRE
	mNkNCSyBXJ/qhYql2j7CA+3BXojrwryRFzdvkohIvYj/a45MgCA6K45bDZHqKhS0SU4ctI3AFpzwg
	yjhIS1GjqTp5yqYk9F8oObVVQ4WoDwnjovoRlBy7GesY9rchsxAw7H/X9DVZNIFzDWIpEYroxiseQ
	2fUrUsz1P4uFkBIt4gKCAXVeTkRwOMKycT/j8HopzwjuxFG+h4YQlEFnZI9D16B4hWkiCHvEhAH/t
	GRjx+CVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cp-0000000AM19-2fUB;
	Thu, 05 Nov 2026 19:33:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3AF-0000000AKmi-1IhQ
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 153244108C;
	Thu,  5 Nov 2026 19:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20631F000C1;
	Thu,  5 Nov 2026 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907023;
	bh=fWBORYPn6/i1UGDhFg9BaDP0viM8Zy1xYrqG6aqMLCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cC58zNRzclL+bqWmFXm5jJss9grSFRNwu88igA3PKBCqEyRDhY2ITvGQVUDEPAijP
	 jc6EoImewJYAZeqNGxexTBcbXnIYrSP7cSjUbXV1pz/HzU27Iu4eyLpGA/mmB75GEJ
	 Mn/pLMLT3OA10M3sQou5NayTSnUUzk77VngzaE9sBLAsEd3IdtCBVhgIPLYs3hgSxI
	 s4cHJ5Csz2wq2CZzuXzn0ag28Cn7YJO/RX2qYjDwC/dec6cnK4P2MZKghUHrp1JdY2
	 VH7rOBjE/sAe72AY4GXbLOvjFtttoNkBV+HgMrjt5Pyq1LLAAfjEG7EQr2rtiIdsRA
	 yRfo09CVnuQmQ==
Message-ID: <sashiko-outbox-199908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 45/51] selftests/proc: check a sysctl listing
 while entries come and go
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-45-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-45-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:20 +0000
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
- [Low] selftests/proc: duplicate readdir churn test in proc-sysctl-readdir=
-churn.c
--

commit 89d111e3f559a343f6b04af3c2c0857d3d1f5a29
Author: Christian Brauner <brauner@kernel.org>

selftests/proc: check a sysctl listing while entries come and go

This commit adds a selftest in proc-sysctl-readdir-churn.c to verify that a
multi-call getdents64() listing of /proc/sys/net/ipv4/conf does not repeat =
or
skip entries when a network device is registered or unregistered in between
calls.

> diff --git a/tools/testing/selftests/proc/proc-sysctl-readdir-churn.c b/t=
ools/testing/selftests/proc/proc-sysctl-readdir-churn.c
> new file mode 100644
> index 0000000000000..b2ad097b464aa
> --- /dev/null
> +++ b/tools/testing/selftests/proc/proc-sysctl-readdir-churn.c
> @@ -0,0 +1,152 @@
[ ... ]
> +#define CONF_DIR	"/proc/sys/net/ipv4/conf"
> +#define TUN_NAME	"a0"		/* sorts before "all" */
> +#define TUN_PATH	CONF_DIR "/" TUN_NAME
> +#define SMALL_BUF	80		/* ".", ".." and one short name */
> +#define NAMES		64
> +
> +static int tun_open(const char *name)
> +{
> +	struct ifreq ifr =3D {};
> +	int fd;
> +
> +	fd =3D open("/dev/net/tun", O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		return -1;
> +	strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
> +	ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
> +	if (ioctl(fd, TUNSETIFF, &ifr)) {
> +		close(fd);
> +		return -1;
> +	}
> +	return fd;
> +}
> +
> +/* one getdents64() into @buf, the names appended to @names */
> +static int list(int fd, char *buf, size_t size, char names[][NAME_MAX + =
1],
> +		int *n)
> +{
> +	long ret, off;
> +	int got =3D 0;
> +
> +	ret =3D syscall(__NR_getdents64, fd, buf, size);
> +	if (ret < 0)
> +		return -errno;
> +	for (off =3D 0; off < ret;) {
> +		struct dirent64 *d =3D (void *)(buf + off);
> +
> +		if (*n < NAMES)
> +			strcpy(names[(*n)++], d->d_name);
> +		got++;
> +		off +=3D d->d_reclen;
> +	}
> +	return got;
> +}
> +
> +static int count(char names[][NAME_MAX + 1], int n, const char *name)
> +{
> +	int i, c =3D 0;
> +
> +	for (i =3D 0; i < n; i++)
> +		if (!strcmp(names[i], name))
> +			c++;
> +	return c;
> +}
> +
> +FIXTURE(sysctl_readdir) {
> +	int dir;
> +	int n;
> +	char names[NAMES][NAME_MAX + 1];
> +	char buf[65536];
> +};
> +
> +FIXTURE_SETUP(sysctl_readdir)
> +{
> +	int tun;
> +
> +	if (unshare(CLONE_NEWNET))
> +		SKIP(return, "unshare(CLONE_NEWNET): %s", strerror(errno));
> +	tun =3D open("/dev/net/tun", O_RDWR | O_CLOEXEC);
> +	if (tun < 0)
> +		SKIP(return, "/dev/net/tun: %s", strerror(errno));
> +	close(tun);
> +	self->dir =3D open(CONF_DIR, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> +	if (self->dir < 0)
> +		SKIP(return, CONF_DIR ": %s", strerror(errno));
> +	self->n =3D 0;
> +}
> +
> +FIXTURE_TEARDOWN(sysctl_readdir)
> +{
> +	close(self->dir);
> +}
> +
> +/* a device registered in front of the position doesn't repeat an entry =
*/
> +TEST_F(sysctl_readdir, register_in_front)
> +{
> +	int tun;
> +
> +	/* ".", ".." and "all", "default" doesn't fit */
> +	ASSERT_EQ(list(self->dir, self->buf, SMALL_BUF, self->names, &self->n),=
 3);
> +	ASSERT_EQ(count(self->names, self->n, "all"), 1);
> +
> +	tun =3D tun_open(TUN_NAME);
> +	ASSERT_GE(tun, 0);
> +	ASSERT_EQ(access(TUN_PATH, F_OK), 0);
> +
> +	while (list(self->dir, self->buf, sizeof(self->buf), self->names,
> +		    &self->n) > 0)
> +		;
> +	EXPECT_EQ(count(self->names, self->n, "all"), 1);
> +	EXPECT_EQ(count(self->names, self->n, "default"), 1);
> +	EXPECT_EQ(count(self->names, self->n, "lo"), 1);
> +	close(tun);
> +}
> +
> +/* a device unregistered in front of the position doesn't skip an entry =
*/
> +TEST_F(sysctl_readdir, unregister_in_front)
> +{
> +	int tun;
> +
> +	tun =3D tun_open(TUN_NAME);
> +	ASSERT_GE(tun, 0);
> +	ASSERT_EQ(access(TUN_PATH, F_OK), 0);
> +
> +	/* ".", ".." and the device, "all" doesn't fit */
> +	ASSERT_EQ(list(self->dir, self->buf, SMALL_BUF, self->names, &self->n),=
 3);
> +	ASSERT_EQ(count(self->names, self->n, TUN_NAME), 1);
> +
> +	/* closing the device unregisters its sysctls under RTNL */
> +	close(tun);
> +	ASSERT_EQ(access(TUN_PATH, F_OK), -1);
> +
> +	while (list(self->dir, self->buf, sizeof(self->buf), self->names,
> +		    &self->n) > 0)
> +		;
> +	EXPECT_EQ(count(self->names, self->n, "all"), 1);
> +	EXPECT_EQ(count(self->names, self->n, "default"), 1);
> +	EXPECT_EQ(count(self->names, self->n, "lo"), 1);
> +}

[Severity: Low]
As reported by Sashiko on RFC [1], this isn't a bug, but tun_open(),
list(), count(), the fixture state in FIXTURE(sysctl_readdir),
FIXTURE_SETUP(sysctl_readdir), FIXTURE_TEARDOWN(sysctl_readdir), and the
register_in_front and unregister_in_front test cases in
tools/testing/selftests/proc/proc-sysctl-readdir-churn.c duplicate the
helpers, FIXTURE(proc_readdir), and the add_in_front and remove_in_front
test cases in tools/testing/selftests/proc/proc-readdir-churn.c, differing
only in the target directory (/proc/sys/net/ipv4/conf vs
/proc/net/dev_snmp6) and expected entries.

Should these sysctl cases be added to
tools/testing/selftests/proc/proc-readdir-churn.c (for example using
FIXTURE_VARIANT() and FIXTURE_VARIANT_ADD()) rather than introducing a
separate standalone test file?

[1] https://lore.kernel.org/r/sashiko-outbox-195504@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D45

