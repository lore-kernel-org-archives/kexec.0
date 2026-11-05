Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDE606D809
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mabEwu12;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNcTfu51
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oYzAsF0I+e0CW5z5u7FoosueNiGCXkY4vYyESz+rdRw=; b=mabEwu120wtAhH8XMzR7Maw+zc
	CQnOV0YasRd+n7PxXfQMZGlypEXu0Mp9ovQEGQB6wtOvchJ+UkpElvYybI7+p5KvK4imDzRfS9iUB
	DlNSfT7mcaIunl955iHaVfMXqQNJG3JOSCyXGMHuTgSGEcpWgSosjUFz0pVnPiuoZBTjx69BBkMyl
	Fhxw/1XGCraOKEjE5cCkvFmwVowiBNChJvsuKDZzXV4kpVMECI5vFVw5mAmrOfbeIzihyJVWD97uJ
	bDJX7SvTAjipH/QfM3/2a4gfwBjnkgoFivg2fINbRIqb8e9ykzY4NSJr2ZHmXrf12JovoNyJVJ+pI
	oLXx8YFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3HX-0000000ANkZ-0YnJ;
	Thu, 05 Nov 2026 19:37:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Fe-0000000AN5N-03lr
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:36:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 719DE601DE;
	Thu,  5 Nov 2026 19:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAAA1F0089E;
	Thu,  5 Nov 2026 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907357;
	bh=oYzAsF0I+e0CW5z5u7FoosueNiGCXkY4vYyESz+rdRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNcTfu51HAjp9arjwyGN1MZppN/dC3Ih6DC5avMnmUZvCl1H8KMvBU/ZZwYPTddlq
	 8PnPW4CSFGBN1dDKTDcBXSBShP3a2WX5Pp6p0nXP7btknLRFB9PL8Ncjca4QfFR7o6
	 oieIQ42NP3xLduOm0i3X+wXP5Uc/isojnKGZtzQxRcqeCltZdRDFH+n0KxLYl41RIP
	 ATkNXn2O63ucMGLH8txRIYQC8ZLHJgxM0FFautSGCwD/y0R1M9Jy2DlUyf0qiqgXBM
	 VIcI6Y0C/5lhKqfM+6+0N06nY7P1BiHq8y1ifirsgXbr9GMfqL0sos0ji0uQdTtER0
	 P0SLP3MDfXv8g==
Message-ID: <sashiko-outbox-199950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 20/23] selftests/proc: check that a mapped
 entry can be removed
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
In-Reply-To: <20261104-work-procfs-core-v2-20-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-20-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:54 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/proc: 32-bit off_t truncation in proc-remove-mapped mm=
ap()
- [Low] selftests/proc: unused len parameter in mem_bar() in proc-remove-ma=
pped
--

commit df303f424b9a370ffbd0eec6c07ff2a99d0ee4ea
Author: Christian Brauner <brauner@kernel.org>

selftests/proc: check that a mapped entry can be removed

This commit adds a procfs selftest that maps a PCI device memory BAR via
/proc/bus/pci and removes the PCI device through sysfs to verify that remov=
ing
a mapped procfs entry does not block and leaves the file returning -EIO on
subsequent reads.

> diff --git a/tools/testing/selftests/proc/proc-remove-mapped.c b/tools/te=
sting/selftests/proc/proc-remove-mapped.c
> new file mode 100644
> index 0000000000000..92860fb2a8f40
> --- /dev/null
> +++ b/tools/testing/selftests/proc/proc-remove-mapped.c

[ ... ]

> +/* the first memory BAR of @dev */
> +static int mem_bar(const char *dev, unsigned long long *start,
> +		   unsigned long long *len)
> +{
> +	unsigned long long s, e, flags;
> +	char path[PATH_MAX];
> +	int ret =3D -ENODEV;
> +	FILE *f;
> +
> +	snprintf(path, sizeof(path), SYSFS_DEVICES "%s/resource", dev);
> +	f =3D fopen(path, "r");
> +	if (!f)
> +		return -errno;
> +	while (fscanf(f, "%llx %llx %llx", &s, &e, &flags) =3D=3D 3) {
> +		if ((flags & IORESOURCE_MEM) && e >=3D s) {
> +			*start =3D s;
> +			*len =3D e - s + 1;
> +			ret =3D 0;
> +			break;
> +		}
> +	}
> +	fclose(f);
> +	return ret;
> +}

[ ... ]

> +TEST_F(pci, remove_while_mapped)
> +{
> +	long psz =3D sysconf(_SC_PAGESIZE);
> +	unsigned long long start =3D 0, len =3D 0;
> +	char path[PATH_MAX];
> +	volatile unsigned int *p;
> +	unsigned int v;
> +	int fd;
> +
> +	if (mem_bar(self->dev, &start, &len))
> +		SKIP(return, "%s has no memory BAR", self->dev);

[Severity: Low]
This isn't a bug, but is the len parameter in mem_bar() needed? mem_bar()
writes *len =3D e - s + 1 and remove_while_mapped() passes &len, but len is
never read afterward because mmap() maps a single page of size psz.

> +
> +	fd =3D open(self->path, O_RDONLY | O_CLOEXEC);
> +	ASSERT_GE(fd, 0);
> +	if (ioctl(fd, PCIIOC_MMAP_IS_MEM)) {
> +		/* no PCI mmap on this architecture, or locked down */
> +		if (errno =3D=3D EINVAL || errno =3D=3D EPERM) {
> +			close(fd);
> +			SKIP(return, "PCIIOC_MMAP_IS_MEM: %s", strerror(errno));
> +		}
> +		ASSERT_TRUE(false) {
> +			TH_LOG("PCIIOC_MMAP_IS_MEM: %s", strerror(errno));
> +		}
> +	}
> +	p =3D mmap(NULL, psz, PROT_READ, MAP_SHARED, fd, start);
> +	if (p =3D=3D MAP_FAILED)
> +		SKIP(return, "mmap: %s", strerror(errno));

[Severity: Medium]
On 32-bit architectures, will passing start to mmap() in remove_while_mappe=
d()
truncate or sign-extend PCI BAR addresses at or above 0x80000000?

Neither proc-remove-mapped.c nor tools/testing/selftests/proc/Makefile defi=
nes
_FILE_OFFSET_BITS to 64, so off_t is a 32-bit signed integer on 32-bit buil=
ds.
When mem_bar() parses a BAR physical address >=3D 0x80000000 into unsigned =
long
long start, converting start to a 32-bit signed off_t in mmap() either
truncates bits above 32 or produces a negative offset (which fails with EIN=
VAL
in musl, or sign-extends the page offset passed to mmap2 in glibc so
pci_mmap_fits() in proc_bus_pci_mmap() fails with ENODEV and causes the test
to skip).

Should proc-remove-mapped.c define _FILE_OFFSET_BITS 64 before including the
system headers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D20

