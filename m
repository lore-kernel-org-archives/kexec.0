Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982F1CAC5AA
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZHzOWV+oYS7NM+O/EnxL1NZMPrx+NYmi9n1hVl/0UI=; b=ivssKJHep+LyMP6kq4DNqH6Pco
	SQX0Qn79nv4ibVUi1ilzYU3rBaimiR3XnYpbkTQG9qttWDsqPo3oQkiV3HKXOiz7nKry9Qr5vl9p7
	zxp+Ff6SBeM2pVkPLo8/q2+bdYjefklhYtkevvlSMK26vthcMY3IHygXXo9szbTePNUxsVIRoAMch
	FpiygdK3k3/PsJwNTLruG3xc0VHovQLKCR30drrJ2+AnhmIIzF8P5trSZXfT1/Jz0D7JlUAXKOclc
	CNSvskXGVwVo+u/0jzDy+8eg5QNJKiytpQjhup/ZQ9FE830P0NrdKPR6EW4QG/nVSkc7k0TYj94Dt
	SLbo9uMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0hX2-0000000Afdx-2p2H;
	Mon, 22 Sep 2025 14:28:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0hWz-0000000AfdR-2TSF
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 14:28:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758551319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZHzOWV+oYS7NM+O/EnxL1NZMPrx+NYmi9n1hVl/0UI=;
	b=WYCKkNu1JhXzcKgbLzjxBSHvJcVNyL/D03bA+wWpJoE9+iJGGsmJ8zDYoDxYUBC2YMs9ud
	L1xc6gBTAv0abBXuPvxto0FubkIDRqrMyvFPWAgn+uC4uKGYtdNsKDC0e5jMFgrz0rHNjE
	huMuMF2hRsdRgA+HGZ7EVnUZszB5H5Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-0ss1WCFdPea5agxgnXoSyA-1; Mon,
 22 Sep 2025 10:28:35 -0400
X-MC-Unique: 0ss1WCFdPea5agxgnXoSyA-1
X-Mimecast-MFC-AGG-ID: 0ss1WCFdPea5agxgnXoSyA_1758551314
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE8121956055;
	Mon, 22 Sep 2025 14:28:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.34])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7F791800446;
	Mon, 22 Sep 2025 14:28:32 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:28:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <20250922142831.GA351870@fedora>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bw/30tv/Tia50C1o"
Content-Disposition: inline
In-Reply-To: <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_072841_697767_85E35F2B 
X-CRM114-Status: GOOD (  20.98  )
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


--Bw/30tv/Tia50C1o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 02:40:18PM -0700, Cong Wang wrote:
> On Fri, Sep 19, 2025 at 2:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > This patch series introduces multikernel architecture support, enabli=
ng
> > > multiple independent kernel instances to coexist and communicate on a
> > > single physical machine. Each kernel instance can run on dedicated CPU
> > > cores while sharing the underlying hardware resources.
> > >
> > > The multikernel architecture provides several key benefits:
> > > - Improved fault isolation between different workloads
> > > - Enhanced security through kernel-level separation
> >
> > What level of isolation does this patch series provide? What stops
> > kernel A from accessing kernel B's memory pages, sending interrupts to
> > its CPUs, etc?
>=20
> It is kernel-enforced isolation, therefore, the trust model here is still
> based on kernel. Hence, a malicious kernel would be able to disrupt,
> as you described. With memory encryption and IPI filtering, I think
> that is solvable.

I think solving this is key to the architecture, at least if fault
isolation and security are goals. A cooperative architecture where
nothing prevents kernels from interfering with each other simply doesn't
offer fault isolation or security.

On CPU architectures that offer additional privilege modes it may be
possible to run a supervisor on every CPU to restrict access to
resources in the spawned kernel. Kernels would need to be modified to
call into the supervisor instead of accessing certain resources
directly.

IOMMU and interrupt remapping control would need to be performed by the
supervisor to prevent spawned kernels from affecting each other.

This seems to be the price of fault isolation and security. It ends up
looking similar to a hypervisor, but maybe it wouldn't need to use
virtualization extensions, depending on the capabilities of the CPU
architecture.

Stefan

--Bw/30tv/Tia50C1o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjRXQ8ACgkQnKSrs4Gr
c8iFTggAnVrECy2HUHacKiUoa/0O6N7WnJASVkoIOOM6+CKjlG2uzF8tSvls85dZ
ybO6yoTpnuEGFQXEAyA7aB3vc3RK5xxhtowcXnQpV6tzpGRKgEdLyCqvwq0DnOiu
aQZwB7XPmWVeROXSZgHpfEF6CYIthQBDpbTMBjQyGxCzD2VQf+GL9Je/3Dd7HQe6
LdVemRZrJqRh3HxHH0JwDAIBDeP4VKZWOme7qPE0si/8DUPx+2DPECH/HesiPm2t
/J5O8u71QN+D1X3M0V90uWC3udRQcTXSqgQUHSLPvV5V3bfRxFHi/nvRNGLElRzj
kKmT/NrKeONOTt+0Q0iKH5mcW6XvAQ==
=On8H
-----END PGP SIGNATURE-----

--Bw/30tv/Tia50C1o--


