Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E433C982D2
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6yFF79F5pQkgMedudQVjJc80KoLUU5S3vMNtZZ0tn1M=; b=3hNeKc9A/NECcsm2R0sXs0MeRs
	NpgHe4Xl+rnH3DXvsBl7jyTdITQxrdL16O+HVtrsoh5X1L8JMCCTFDdXKm6jClyiclIxgfPWQn2MM
	WWrDAD02tl/jhZEjT6Ex1Xoe1G/feh8qh0UxZnhzWHkzv/VHqwcHQ1Z04LhfYk3jgXrRVLUEYPBJi
	hnKwrIc7aRigo2Jy2dBb0KawYcqTK0ZCANK25SnFOHV30K4+08S5fE+lxl5jjQ2nJvm+ZdK/HNNYP
	utJPt0fCpIhm3h1bZ4OzNVW+8qcX5xQLhSrqFCur3tuBj8nedm9YNe2hvzX+z5GSNZSjYzBva4TUU
	Dm8aSH+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FGl-0000000Bz9A-1M5V;
	Thu, 17 Sep 2026 16:47:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FGj-0000000Bz8p-3ZJe
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:47:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32D35601F1;
	Thu, 17 Sep 2026 16:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4481F000FF;
	Thu, 17 Sep 2026 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663648;
	bh=6yFF79F5pQkgMedudQVjJc80KoLUU5S3vMNtZZ0tn1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OFidRq4co7W/H4Q0PKxuKIDlbFLlFG4EOXi0FBxtNdm5DxmCLDlC1qroW1vy6HFlK
	 6T98+/Ok2N0TlOBnQor2u4TRrCt6bIMfVoC7ssd8Z7BdWBvVAnP+VpPXjKIMvsb8bx
	 52qI60Xn2w+0bWMxkvfYILOzj6gS26Y9+aNCYJ1yA7aBePmOYUC/Siah6LOe80j4q2
	 wAEco4ALy5CtxFCaQpQjw/T1m/s6py1rAty3kkZs/V1+UuikPq/p0VSKwqPLjUOyal
	 E/YRAtHW12iVoWT6HgDemLlvqw0yoy9nGTsQaBhQMmCAb2f/wciXEDMmFmmYIJjb9y
	 fnhXmmI8QIumg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] driver core: async device shutdown infrastructure
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev, "David
 Jeffery" <djeffery@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, "Bjorn Helgaas" <helgaas@kernel.org>, "Ewan
 Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org, Maurizio <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, kexec@lists.infradead.org, linux-pci@vger.kernel.org, "Laurence
 Oberman" <loberman@redhat.com>, "Jeremy Allison" <jallison@ciq.com>, "Pasha
 Tatashin" <tatashin@google.com>, linux-kernel@vger.kernel.org, "John Garry" <john.g.garry@oracle.com>, "Tarun
 Sahu" <tarunsahu@google.com>, "Stuart Hayes" <stuart.w.hayes@gmail.com>, "John
 Meneghini" <jmeneghi@redhat.com>
In-Reply-To: <20260917163744.191748-7-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
 <20260917163744.191748-7-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:47:27 +0000
Message-Id: <20260917164727.DE4481F000FF@smtp.kernel.org>
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

> Patterned after async suspend, allow devices to mark themselves as wanting
> to perform async shutdown. Devices using async shutdown wait only for the=
ir
> dependencies to shutdown before executing their shutdown routine.
>=20
> Sync shutdown devices are shut down one at a time and will only wait for =
an
> async shutdown device if the async device is a dependency.
>=20
> Enabled by default, async shutdown can be explicitly enabled or disabled
> by using the kernel parameter "core.async_shutdown=3D<bool>"
>=20
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163744.1917=
48-1-djeffery@redhat.com?part=3D6


