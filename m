Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B122C88E72
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1q/kOx6JG2vi/MQ8HOsXmPagpC3QttyiydLa7Cv1w8I=; b=Z3h40S2DiGMvxOoLHkU2RH0JWG
	oqheDCmWJhjQohtfoknpxHZFXO3Jx0AqOnkCjEd49xbNHm9fRc8Imptwnn6dugaaDn7SUYfih4V2H
	y0muBqVUXAFS81lKRHcQy0KwXSFqX9uTDqxMdlELl6vP5+JdvX5T9l3gGobu0+1VmAVI9CND3Sa8F
	Y8e0x9+cmlB5CiAqcfZZaOZ3h4KWSGC7uNU40cHMcWiHJLPjY8E2FV5AsnFV01yQ+6MPZ1jPxxvhp
	ICOS0ZszN1SzxPRegtYpKIj7kPZiEOWx6vzq0SLPnIcXk48ngQRLQNkZUGgkeduIOiKYQS8zyzP1c
	xhlxwnQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FEj-0000000Bybs-0vl7;
	Thu, 17 Sep 2026 16:45:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FEi-0000000Bybc-2piw
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:45:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8181342157;
	Thu, 17 Sep 2026 16:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CAF1F000FF;
	Thu, 17 Sep 2026 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663522;
	bh=1q/kOx6JG2vi/MQ8HOsXmPagpC3QttyiydLa7Cv1w8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnX54qJmdlzA0+fG/aSGjWc+9heDNZv9Qk1jL7SFsUwrHAYkYvUqn27SRFXmpzLyo
	 p3OUj2/FSCaLev4hq6yPXmVyd1qb5Rtl+q8CJocgB8w0cv+Kz4U1F98GS/pNTsEu4r
	 ch4Xze6uGFWzYO1Qa9LNt/VYed0bI0KAGa2btYSM7l5czbM6fiNY+EY+LeByAWVsNR
	 cYXvHWKJFLcsuC9upvj28mBvt9OtjK4kRBMxeF9gQxcNdIplVit0ayoFZEcWn4/FFV
	 WtFi3rUAv0hNLTQfm6j+EbdAtcwYtchxBz/CUE8Dr5dO4Gwj7zuM/I/rVppMuTuRhp
	 l6OYL8rGdcHMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] driver core: rely on put_device to free dev->p
To: "David Jeffery" <djeffery@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev
Cc: "John Meneghini" <jmeneghi@redhat.com>, "Laurence Oberman" <loberman@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, linux-pci@vger.kernel.org, "Stuart Hayes" <stuart.w.hayes@gmail.com>, "Ewan
 Milne" <emilne@redhat.com>, kexec@lists.infradead.org, Maurizio <mlombard@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, "John
 Garry" <john.g.garry@oracle.com>, "Jeremy Allison" <jallison@ciq.com>, "Bart
 Van Assche" <bvanassche@acm.org>, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, "Tarun
 Sahu" <tarunsahu@google.com>
In-Reply-To: <20260917163744.191748-2-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-2-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:45:20 +0000
Message-Id: <20260917164521.66CAF1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> From: Tarun Sahu <tarunsahu@google.com>
>=20
> device_add allocate private_data for device and assigns to
> dev->p. If device_add fails in later steps of the function,
> it cleans up this dev->p which is not necessary because In
> the next call, put_device free it anyway (if reference to
> the device is 0 which will be unless someone concurrently
> get the reference to this device).
>=20
> This avoids unnecessary races introduced in system. After device
> is added in device_kset->list by device_add and later steps in the
> device_add function failures occur, it will free dev->p manually,
> while in between there might be a user of device_kset->list will
> take reference to the device just added by device_add. and might
> try to access dev->p. So relying on put_device to free dev->p
> prevents such problem.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D1


