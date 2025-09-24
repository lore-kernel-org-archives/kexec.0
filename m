Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C980CAC5AE
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=svtYRVGVOWiQOwGeQLqrRvGYBYlTxeSGi1nAMXidbZw=; b=mr4+4kzKpZGmKJbITfHHrSfL9p
	cti/xY2nZfGu1SGS1YWRJeCVDNHK21ihJWWS6RVzmGOLEMM3C8RL9fxWrG6eD9ug2oI+daAwBvidS
	w2YHZU1YbMDAf8gxaVryjJcTfloGyWQDWqofhXPsmrz2HPHp+2pi2kAxNm0ZdA18w8VlNPuM6P2iv
	xQazSqlk8/AEQx2mhHZ8ztq50REBmH8WoNd+w+lAN809nY+4gF15OnUC8L+gda0bfbn9gXahO+pU+
	5ruCmxRVsyUwVt6B/L36VFTAE5shGz8zfIH737gjSNKm7OWXlxB8T1x5G8UmpNZz/6Ip5az8InAlQ
	lDvClGuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Um1-00000002sm8-2qtS;
	Wed, 24 Sep 2025 19:03:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Uly-00000002sii-2RWL
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 19:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758740604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svtYRVGVOWiQOwGeQLqrRvGYBYlTxeSGi1nAMXidbZw=;
	b=gBIlxJ100chrgopChZ9bgpWzhZegHp5JIpAu7nArVCixWzKEfrtD8xs8TGF+qs8p9AV8lv
	OwnJOOz+txFHz8LRNH7qnDRAeIWJsR0M/p1zvU4zPGPNkUV+2tcLAFiWIy7BnLgkLTeAUK
	p9uuP+5hqlEsUh+CMkdo57mMiC3nsus=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-q4nOE_dQORmW9pfmQoS9GA-1; Wed,
 24 Sep 2025 15:03:20 -0400
X-MC-Unique: q4nOE_dQORmW9pfmQoS9GA-1
X-Mimecast-MFC-AGG-ID: q4nOE_dQORmW9pfmQoS9GA_1758740599
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83EBC1800357;
	Wed, 24 Sep 2025 19:03:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.176])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 931C9300018D;
	Wed, 24 Sep 2025 19:03:17 +0000 (UTC)
Date: Wed, 24 Sep 2025 15:03:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <20250924190316.GA8709@fedora>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
 <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora>
 <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora>
 <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="io8Dp1r+z0FFF6O3"
Content-Disposition: inline
In-Reply-To: <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_120326_692706_9259AF34 
X-CRM114-Status: GOOD (  32.91  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--io8Dp1r+z0FFF6O3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:28:04AM -0700, Cong Wang wrote:
> On Wed, Sep 24, 2025 at 5:51=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Wed, Sep 24, 2025 at 01:38:31PM +0200, David Hildenbrand wrote:
> > > > >
> > > > > Two more points:
> > > > >
> > > > > 1) Security lockdown. Security lockdown transforms multikernel fr=
om
> > > > > "0-day means total compromise" to "0-day means single workload
> > > > > compromise with rapid recovery." This is still a significant impr=
ovement
> > > > > over containers where a single kernel 0-day compromises everything
> > > > > simultaneously.
> > > >
> > > > I don't follow. My understanding is that multikernel currently does=
 not
> > > > prevent spawned kernels from affecting each other, so a kernel 0-da=
y in
> > > > multikernel still compromises everything?
> > >
> > > I would assume that if there is no enforced isolation by the hardware=
 (e.g.,
> > > virtualization, including partitioning hypervisors like jailhouse, pk=
vm etc)
> > > nothing would stop a kernel A to access memory assigned to kernel B.
> > >
> > > And of course, memory is just one of the resources that would not be
> > > properly isolated.
> > >
> > > Not sure if encrypting memory per kernel would really allow to not le=
t other
> > > kernels still damage such kernels.
> > >
> > > Also, what stops a kernel to just reboot the whole machine? Happy to =
learn
> > > how that will be handled such that there is proper isolation.
> >
> > The reason I've been asking about the fault isolation and security
> > statements in the cover letter is because it's unclear:
> > 1. What is implemented today in multikernel.
> > 2. What is on the roadmap for multikernel.
> > 3. What is out of scope for multikernel.
> >
> > Cong: Can you clarify this? If the answer is that fault isolation and
> > security are out of scope, then this discussion can be skipped.
>=20
> It is my pleasure. The email is too narrow, therefore I wrote a
> complete document for you:
> https://docs.google.com/document/d/1yneO6O6C_z0Lh3A2QyT8XsH7ZrQ7-naGQT-rp=
djWa_g/edit?usp=3Dsharing
>=20
> I hope it answers all of the above questions and provides a clear
> big picture. If not, please let me know.
>=20
> (If you need edit permission for the above document, please just
> request, I will approve.)

Thanks, that gives a nice overview!

I/O Resource Allocation part will be interesting. Restructuring existing
device drivers to allow spawned kernels to use specific hardware queues
could be a lot of work and very device-specific. I guess a small set of
devices can be supported initially and then it can grow over time.

This also reminds me of VFIO/mdev devices, which would be another
solution to the same problem, but equally device-specific and also a lot
of work to implement the devices that spawned kernels see.

Anyway, I look forward to seeing how this develops.

Stefan

--io8Dp1r+z0FFF6O3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjUQHQACgkQnKSrs4Gr
c8g6GQf/dmqLH7btBgBhJhQSXIXjdWf+M92gUSUpXzizVaSB2xUrl68p4xZlWEzc
7ijpcKjxMVVGeUgLU7ziduh4sS/Pu/GclMmyTU17mrlVCZjbJsxwz4NmcbWJbvjl
sne3cnef4ov/U/AOPKpTLWHdNMLVvtCltuc+bZ7uS2Zeae7u0ZLWUgZUllddDu2y
OjZBAa4PxbDLrBvm5btURx7kzh4t3bP4TAcKC4GkEngI47jyl5E4XTEWYpFUSEEF
PrlgE+22skiH038nIpmPvHvQhfeM52npehlqBajdFjgmpTMOeNjDNTR0mM+b8+nr
UtE9Nt0gu32myYQUKVwt+vAfC7hNBw==
=9wqm
-----END PGP SIGNATURE-----

--io8Dp1r+z0FFF6O3--


