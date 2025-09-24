Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A037CAC5B3
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTQTYZTiz2YYOPaT/MkK88YrNEGe0k4y4vUiJM9oV9U=; b=RYIsY/oj0kj1WWci45Ne9mRTEQ
	yuCNbebLPjq+lVxqbZHTcwmTYD7H+YOVQ0DSAqnCuSaGe+z/o6SlhzmrxXCwAUsME3ZJxWY2c1Wz3
	XHpN5k+Pz0hGuB8bsK9QBl8ZKgotakV4bBOYs1+HTbv8hn+Qyo8OfAlVuT9RGEovT/PPJA4CocTuj
	79rS8WwIjz1ymV77rMte+sVYinsD+RxPsKS1QJJ8UqryQCc+BF6P9ZlitppUB3I85iWQUpF6Wgn25
	sJ01/VG0U40rF5KTF6r9ERFWD8zMrLJ8/2r4ZhdThamooSHlqNlPHda8ekRJAsVQSIU5DqYNQpOgQ
	ysrc/C1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Oxm-0000000HYci-28Z9;
	Wed, 24 Sep 2025 12:51:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Oxj-0000000HYaj-2kiW
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 12:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758718270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RTQTYZTiz2YYOPaT/MkK88YrNEGe0k4y4vUiJM9oV9U=;
	b=WG4BIQA9rHsOJ70SKNNnABvQtbuj6cDHHS7wMpXiSQfDr2/ScUMP9GA9ONoYI//D4hZ7Dj
	RzC0xeoj9MXtokL9fSw5f4oAITfG2ZL5Yni+rOjOCt7bBvuGxZWct44ZV0pm4JtlrAHjKH
	S5gOiFhSEoPEfGNFZh59tCUYIV3Je6E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-PvkmhR6fP--M8zTnbb8_Mw-1; Wed,
 24 Sep 2025 08:51:06 -0400
X-MC-Unique: PvkmhR6fP--M8zTnbb8_Mw-1
X-Mimecast-MFC-AGG-ID: PvkmhR6fP--M8zTnbb8_Mw_1758718265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3741919560B7;
	Wed, 24 Sep 2025 12:51:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFF741800452;
	Wed, 24 Sep 2025 12:51:02 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:51:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <20250924125101.GA562097@fedora>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
 <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora>
 <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CpzOrJ/+7+dHBlWP"
Content-Disposition: inline
In-Reply-To: <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_055111_768713_7051D1A2 
X-CRM114-Status: GOOD (  21.22  )
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


--CpzOrJ/+7+dHBlWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 01:38:31PM +0200, David Hildenbrand wrote:
> > >=20
> > > Two more points:
> > >=20
> > > 1) Security lockdown. Security lockdown transforms multikernel from
> > > "0-day means total compromise" to "0-day means single workload
> > > compromise with rapid recovery." This is still a significant improvem=
ent
> > > over containers where a single kernel 0-day compromises everything
> > > simultaneously.
> >=20
> > I don't follow. My understanding is that multikernel currently does not
> > prevent spawned kernels from affecting each other, so a kernel 0-day in
> > multikernel still compromises everything?
>=20
> I would assume that if there is no enforced isolation by the hardware (e.=
g.,
> virtualization, including partitioning hypervisors like jailhouse, pkvm e=
tc)
> nothing would stop a kernel A to access memory assigned to kernel B.
>=20
> And of course, memory is just one of the resources that would not be
> properly isolated.
>=20
> Not sure if encrypting memory per kernel would really allow to not let ot=
her
> kernels still damage such kernels.
>=20
> Also, what stops a kernel to just reboot the whole machine? Happy to learn
> how that will be handled such that there is proper isolation.

The reason I've been asking about the fault isolation and security
statements in the cover letter is because it's unclear:
1. What is implemented today in multikernel.
2. What is on the roadmap for multikernel.
3. What is out of scope for multikernel.

Cong: Can you clarify this? If the answer is that fault isolation and
security are out of scope, then this discussion can be skipped.

Thanks,
Stefan

--CpzOrJ/+7+dHBlWP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjT6TUACgkQnKSrs4Gr
c8glqAf/V/fg56oCmCv+HaFs3LvmQyEljhq0JJy17N25yTd+uBaKlL/RQs/qTsez
VrTtD5K5M/dKzlI9hpUM+/RzrxvYy65ZPp6CIfo1eBCRTUpmLZeUXYnZfjk/oU7A
8lL4qXt4sohUnt52FX6jT0io63SgZfzVa+ioe2WDZmh/YVkIi9JNjxhH5HJMuUPU
MxS53WDukYaEaBUJSi4cs/QdjcCudEzZBaeP1FjC6uoeZQ/3lT6Ozr0YGNeHHLUT
XRG0dL1oq9ABmi7Yy2UHwmqj+4cT2964SErwJUesi+a7ij4/ZL2osb1aurT098ZC
e75vuYwusPi8KJrYkzuXOLpAWMW6EA==
=+t3/
-----END PGP SIGNATURE-----

--CpzOrJ/+7+dHBlWP--


