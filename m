Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26D4CAC5B5
	for <kexec@archiver.kernel.org>; Mon, 29 Sep 2025 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wUxjCdJ+LBOQczVnd2iMYVQAKgwjCqV4hUPHBbCXanQ=; b=J3OVcbITUAPyh8sXXpppBp/vlD
	r92IPlV8dpjKLT+YjW5eA2cX2mb5Lkm6ik0509ZpjNr7CGHL1LMXbWXWJoPbvFCqzue8gMALngAi8
	mzQ75a2GNtKiC4efKKbFQHp6Tl3mthByJI6WVJxoGAPMhWl8ObYPvjal7Bi9LBB0qdSJW1tHRUY9s
	ClxbpOLSwr1oMMmQt1+kQUT54OXDOhEqSRhLj03YUISkY79vy+LXXbivcdurRB766mrj8tmd6cCFL
	qjRS/bpFRs4aXjEtfUcKSA49xSoL7P4T/Si92rho0/1qou42vx8iDc2Qz9yXJvoC0pG9RMHLo3YZ7
	KQoDC9pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3FXp-00000002lUp-3byW;
	Mon, 29 Sep 2025 15:12:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3FXk-00000002lU0-2Wc5
	for kexec@lists.infradead.org;
	Mon, 29 Sep 2025 15:12:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759158718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUxjCdJ+LBOQczVnd2iMYVQAKgwjCqV4hUPHBbCXanQ=;
	b=Y00RwKTkmPfXKLJ92VwM/IfU+xqwlH2V4eIB8wT9hwFaAwcqAvWJAmIMg6voxRCglPdvUQ
	8y7LSU2JCp6W0h2nFYE3aqxgbaLZnvma4manJ2MMd00Habhi/fCSMwLFr4/+IAHRnN2JwA
	C/OlkQfnEefJELD8ZEG7zUFwLNFbrUk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-2ba4FcJWPCCwlvOIPJH7zQ-1; Mon,
 29 Sep 2025 11:11:54 -0400
X-MC-Unique: 2ba4FcJWPCCwlvOIPJH7zQ-1
X-Mimecast-MFC-AGG-ID: 2ba4FcJWPCCwlvOIPJH7zQ_1759158713
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AC28195609F;
	Mon, 29 Sep 2025 15:11:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B25B195608E;
	Mon, 29 Sep 2025 15:11:50 +0000 (UTC)
Date: Mon, 29 Sep 2025 11:11:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev,
	jasowang@redhat.com
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <20250929151149.GB81824@fedora>
References: <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
 <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora>
 <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora>
 <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
 <20250924190316.GA8709@fedora>
 <CAM_iQpXnvyZWrv4W45SBTDV-tCXU4Fz1=S8z_0s5en+U29vSZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yMiB+Rg43ijt+EVK"
Content-Disposition: inline
In-Reply-To: <CAM_iQpXnvyZWrv4W45SBTDV-tCXU4Fz1=S8z_0s5en+U29vSZQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_081200_715254_AF1E372C 
X-CRM114-Status: GOOD (  29.57  )
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


--yMiB+Rg43ijt+EVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 12:42:23PM -0700, Cong Wang wrote:
> On Wed, Sep 24, 2025 at 12:03=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
=2Ecom> wrote:
> >
> > Thanks, that gives a nice overview!
> >
> > I/O Resource Allocation part will be interesting. Restructuring existing
> > device drivers to allow spawned kernels to use specific hardware queues
> > could be a lot of work and very device-specific. I guess a small set of
> > devices can be supported initially and then it can grow over time.
>=20
> My idea is to leverage existing technologies like XDP, which
> offers huge benefits here:
>=20
> 1) It is based on shared memory (although it is virtual)
>=20
> 2) Its API's are user-space API's, which is even stronger for
> kernel-to-kernel sharing, this possibly avoids re-inventing
> another protocol.
>=20
> 3) It provides eBPF.
>=20
> 4) The spawned kernel does not require any hardware knowledge,
> just pure XDP-ringbuffer-based software logic.
>=20
> But it also has limitations:
>=20
> 1) xdp_md is too specific for networking, extending it to storage
> could be very challenging. But we could introduce a SDP for
> storage to just mimic XDP.
>=20
> 2) Regardless, we need a doorbell anyway. IPI is handy, but
> I hope we could have an even lighter one. Or more ideally,
> redirecting the hardware queue IRQ into each target CPU.

I see. I was thinking that spawned kernels would talk directly to the
hardware. Your idea of using a software interface is less invasive but
has an overhead similar to paravirtualized devices.

A software approach that supports a wider range of devices is
virtio_vdpa (drivers/vdpa/). The current virtio_vdpa implementation
assumes that the device is located in the same kernel. A
kernel-to-kernel bridge would be needed so that the spawned kernel
forwards the vDPA operations to the other kernel. The other kernel
provides the virtio-net, virtio-blk, etc device functionality by passing
requests to a netdev, blkdev, etc.

There are in-kernel simulator devices for virtio-net and virtio-blk in
drivers/vdpa/vdpa_sim/ which can be used as a starting point. These
devices are just for testing and would need to be fleshed out to become
useful for real workloads.

I have CCed Jason Wang, who maintains vDPA, in case you want to discuss
it more.

>=20
> >
> > This also reminds me of VFIO/mdev devices, which would be another
> > solution to the same problem, but equally device-specific and also a lot
> > of work to implement the devices that spawned kernels see.
>=20
> Right.
>=20
> I prototyped VFIO on my side with AI, but failed with its complex PCI
> interface. And the spawn kernel still requires hardware knowledge
> to interpret PCI BAR etc..

Yeah, it's complex and invasive. :/

Stefan

--yMiB+Rg43ijt+EVK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjaobUACgkQnKSrs4Gr
c8ipuwf+KotYqejI+vt5pti8fHvl4phnkHcS2tYcg/IHT1cO0y5ha7uvltnia9/N
uSJ88YcQ/Fo2pkLyiIZYVAH7jqJIWJ5GI61pAwiTDiXi+EDoao4EpqD3MC+GHBQ9
ZD444E59MYSKts6yCIHC6gpcXSU12Z9uPvQgQLRDQ3cStlAJC33HRmBFptZNt2rD
8/2/c35N16qbMo3a7O/Owe3/2fJkQFEHp+3znyf8U3obn0b8Cutec++rA4e4UAQR
PuaVm3iBeSDJRjXZvJMXlDBrBYma0mOhsUkJBdcs/8D1ncAs1v+0kBK1UbA2JgQv
vjv+rLhgtSOCuUALtpAqfw53quM2OQ==
=y4ib
-----END PGP SIGNATURE-----

--yMiB+Rg43ijt+EVK--


