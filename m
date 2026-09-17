Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB57C88E72
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XMjDv8CpcRrCSJyVd2NGEOOV+eyxF8EAwstFN3OJlJY=; b=0XMGDjddejRvGlTYfTHKWkMLZq
	umi/D7cXzRp4aiQL9RTP57JUoaCDl/mvaGQAyKoprMl7SfCPTe4H+tOje0v3ol+u6SL51huSkWi9W
	lRct5NQIax7cQruPBxkrai3ejzivZD1X9MTg0KJ/u1JDCtA0xCj3N5NMs+fHpISvkklPq6FFhtlLK
	0HwAngz81tS8Jz/cmUmyQ358JmV57HTpoMpKbPr3gRko0sekN5/h53vqer2oH6IuEm3Xws3fNgk50
	zdWXRmQqJh4aRscOk56a7s9JAHVsEE/QBND4Rd436iqEM18n988187oa/bOLDzKzI05amWaMR2buy
	AbbCztEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FAT-0000000BxVY-1uWZ;
	Thu, 17 Sep 2026 16:41:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FAS-0000000BxUD-0st9
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:41:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F0D4642006;
	Thu, 17 Sep 2026 16:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0E01F00893;
	Thu, 17 Sep 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663259;
	bh=XMjDv8CpcRrCSJyVd2NGEOOV+eyxF8EAwstFN3OJlJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eoj1iJehmTUI+pYMU2YQiTzGwVf2Ghrp3dVDRhASfh1ESKqEES/TarfmI4P6fsvky
	 e44Qo2d0uhFAmIsyjcZWAD46AQt+UquhRdROS+M1SB7OrjFhBZEyEnUf+8NcpWVl89
	 CpenrUCAZ8ug73kapz5VEzPobPHuCXXUYmiFnqoC94G6nkfNDAnlb9uMgq3IvdFsWM
	 N2vWKcrmRxF7kzNA5rPhKihJ8onxPH3xHUr0I7/9Klowr4sGYvKziC9O+CUOI7Qh2r
	 1OtJXYFvrCgQFiYA8TxN1daEnvIe0KzInP3ox7S0lQmka1pL4i/csSd0+D37AfCORP
	 8QJZ85E+fvFdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] driver core: separate function to shutdown one
 device
To: "Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev, "Danilo
 Krummrich" <dakr@kernel.org>, "David Jeffery" <djeffery@redhat.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Laurence Oberman" <loberman@redhat.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, Maurizio <mlombard@redhat.com>, linux-scsi@vger.kernel.org, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Stuart Hayes" <stuart.w.hayes@gmail.com>, "John
 Meneghini" <jmeneghi@redhat.com>, "Tarun Sahu" <tarunsahu@google.com>, "Ewan
 Milne" <emilne@redhat.com>, "Bart Van Assche" <bvanassche@acm.org>, "John
 Garry" <john.g.garry@oracle.com>, "Jeremy Allison" <jallison@ciq.com>, "Martin
 K . Petersen" <martin.petersen@oracle.com>, "Pasha Tatashin" <tatashin@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260917163744.191748-5-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-5-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:40:58 +0000
Message-Id: <20260917164059.1F0E01F00893@smtp.kernel.org>
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

> Make a separate function for the part of device_shutdown() that does the
> shutown for a single device.  This is in preparation for making device
> shutdown asynchronous.
>=20
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D4


