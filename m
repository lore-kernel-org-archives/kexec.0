Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8686CAC5A5
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Si+gRDqfMlxuN0KqN3KFYYBkczK7pbhlc1HLNzDjYGg=; b=j/GYkqi4uv5PBvheLO2oI1UP63
	eLqzwUh060TfVo9ilKuM2ePAR4RISCUERfDQuEhTlO9KjrpXzltGAaNc6cfO2yJy3cF/J1D9bLhYq
	dH+at90vu5NS0Mqok0ZB7xhlTSxDfKNQsvVdj7ubtnlvoFup9unbobi0v58StlLaz5a2XXDSSnQKJ
	Y47e6kRCW+OPX3j8zlbADan/LKyJ0gr2RAN6TXRjfXIMd9bVwUhvYR8485tp5LhqTt4i2ePyZYbq8
	Xls8q71k8jNf0D5rzTr/ZETaIkKMgE4QEkIaUEVe6O05oWuUnOKh/lHVLURaiDSPPThkVauz2NaLT
	ZA7HFbqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16Sn-0000000EL4j-0snP;
	Tue, 23 Sep 2025 17:06:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16Sj-0000000EL3A-0Mws
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 17:05:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758647155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Si+gRDqfMlxuN0KqN3KFYYBkczK7pbhlc1HLNzDjYGg=;
	b=DnXjNFVwpzCm6XH0AOVNqDfBPmiyHV3ljem5nk9UqOse3WyhhQdhx9inDJ/NYrvDIfHlkr
	iYTcVW5kuNVjJVSNfyCaenJfGqI3H0NZniIgMAjEEmfCgUm8JZOvD5woGdBK0Co2QGTzIf
	A7qzrbcqXLh5Vil121x+PaEaP0xDFD8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-r0ZRWA2iMGiiOTICcbLMBg-1; Tue,
 23 Sep 2025 13:05:50 -0400
X-MC-Unique: r0ZRWA2iMGiiOTICcbLMBg-1
X-Mimecast-MFC-AGG-ID: r0ZRWA2iMGiiOTICcbLMBg_1758647148
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7C0D1800372;
	Tue, 23 Sep 2025 17:05:47 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B878D19560B1;
	Tue, 23 Sep 2025 17:05:46 +0000 (UTC)
Date: Tue, 23 Sep 2025 13:05:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <20250923170545.GA509965@fedora>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
 <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fOWoD/rtAfxeWV+w"
Content-Disposition: inline
In-Reply-To: <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_100557_198476_1E4A6015 
X-CRM114-Status: GOOD (  37.27  )
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


--fOWoD/rtAfxeWV+w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 03:41:18PM -0700, Cong Wang wrote:
> On Mon, Sep 22, 2025 at 7:28=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Sat, Sep 20, 2025 at 02:40:18PM -0700, Cong Wang wrote:
> > > On Fri, Sep 19, 2025 at 2:27=E2=80=AFPM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > > > This patch series introduces multikernel architecture support, en=
abling
> > > > > multiple independent kernel instances to coexist and communicate =
on a
> > > > > single physical machine. Each kernel instance can run on dedicate=
d CPU
> > > > > cores while sharing the underlying hardware resources.
> > > > >
> > > > > The multikernel architecture provides several key benefits:
> > > > > - Improved fault isolation between different workloads
> > > > > - Enhanced security through kernel-level separation
> > > >
> > > > What level of isolation does this patch series provide? What stops
> > > > kernel A from accessing kernel B's memory pages, sending interrupts=
 to
> > > > its CPUs, etc?
> > >
> > > It is kernel-enforced isolation, therefore, the trust model here is s=
till
> > > based on kernel. Hence, a malicious kernel would be able to disrupt,
> > > as you described. With memory encryption and IPI filtering, I think
> > > that is solvable.
> >
> > I think solving this is key to the architecture, at least if fault
> > isolation and security are goals. A cooperative architecture where
> > nothing prevents kernels from interfering with each other simply doesn't
> > offer fault isolation or security.
>=20
> Kernel and kernel modules can be signed today, kexec also supports
> kernel signing via kexec_file_load(). It migrates at least untrusted
> kernels, although kernels can be still exploited via 0-day.

Kernel signing also doesn't protect against bugs in one kernel
interfering with another kernel.

> >
> > On CPU architectures that offer additional privilege modes it may be
> > possible to run a supervisor on every CPU to restrict access to
> > resources in the spawned kernel. Kernels would need to be modified to
> > call into the supervisor instead of accessing certain resources
> > directly.
> >
> > IOMMU and interrupt remapping control would need to be performed by the
> > supervisor to prevent spawned kernels from affecting each other.
>=20
> That's right, security vs performance. A lot of times we have to balance
> between these two. This is why Kata Container today runs a container
> inside a VM.
>=20
> This largely depends on what users could compromise, there is no single
> right answer here.
>=20
> For example, in a fully-controlled private cloud, security exploits are
> probably not even a concern. Sacrificing performance for a non-concern
> is not reasonable.
>=20
> >
> > This seems to be the price of fault isolation and security. It ends up
> > looking similar to a hypervisor, but maybe it wouldn't need to use
> > virtualization extensions, depending on the capabilities of the CPU
> > architecture.
>=20
> Two more points:
>=20
> 1) Security lockdown. Security lockdown transforms multikernel from
> "0-day means total compromise" to "0-day means single workload
> compromise with rapid recovery." This is still a significant improvement
> over containers where a single kernel 0-day compromises everything
> simultaneously.

I don't follow. My understanding is that multikernel currently does not
prevent spawned kernels from affecting each other, so a kernel 0-day in
multikernel still compromises everything?

>=20
> 2) Rapid kernel updates: A more practical way to eliminate 0-day
> exploits is to update kernel more frequently, today the major blocker
> is the downtime required by kernel reboot, which is what multikernel
> aims to resolve.

If kernel upgrades are the main use case for multikernel, then I guess
isolation is not necessary. Two kernels would only run side-by-side for
a limited period of time and they would have access to the same
workloads.

Stefan

>=20
> I hope this helps.
>=20
> Regards,
> Cong Wang
>=20

--fOWoD/rtAfxeWV+w
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS02kACgkQnKSrs4Gr
c8gaLgf+LttcrIImZ/l3um6RUl/4dYace1hoDwxQJPCPksRImb0wzZW4C3r/6W8V
dssJAEtVxaLcMnKlkA+usUipzCoHQqjOD6IVOe3gxnD28sSaIuE8v+RhftRbEMNI
ytTI1l4AHyPwWr2nQG+FQZm2hf7LQUd2uItfnOjIS/sSelm7eOHr1m8zXvYDy1zT
JXKNxZCk0PGTkYHCDZkmnZotwC/OEUD4htrk2s1V+xaGhXx8VS59XNacaileaplO
rRPGU2lU6vXA/TRhs+FvZqPGFj0gffZrc+5H/pHCPVeod8Drolcf0YO+9WQ+b+n5
SLcZ7lhWe6O/QynTmIpd89aXu+L0tA==
=KKCS
-----END PGP SIGNATURE-----

--fOWoD/rtAfxeWV+w--


