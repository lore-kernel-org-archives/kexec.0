Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA08606A320
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sAHV9DhN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBCXgTzd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eWJNfm9GtGG5Ubanl3qk25zMJ042O5sWVEAKnjQLJPY=; b=sAHV9DhNxEB75eUR3aZ6wvKb46
	7h1kY30cD1qFwV2ou0i+6pGXYtAKZ28QQQ/Kh14Ivr8XusGe8vvRJQqRhsB5NlJ5jBQ4Ypcy/ipuj
	Cq5yxyM/6XeMibpxnaSNvJd1ZcDc5XVRG0YZ68/++VKIm/msJhQ0HE8NHjfCK0byHb3AVL6t4nN3/
	G8fmB3lb+ji+aqs3rdCNqQ03Q4L3fWm+u2gCMidwcbYVGtPpgEQtDwQcSPry3kk+jh1l52qAq6oMH
	16YBxrjFpmUws1dg0ofTN7ZPdG620a3R4av8z9WzWCXOZAJ3gimqf3QbkQTVklY/WWFonzRs9PCVw
	Cjii2JjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm4-0000000DaWY-1j3b;
	Thu, 19 Nov 2026 22:38:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm0-0000000DaQY-06B1
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C2007416D1;
	Thu, 19 Nov 2026 22:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EB01F000C4;
	Thu, 19 Nov 2026 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127911;
	bh=eWJNfm9GtGG5Ubanl3qk25zMJ042O5sWVEAKnjQLJPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBCXgTzdXOi/7DOeX1CsqbC6s08zU0plDgVxTJCBLg5OOqYF701jlXIfu3xyeqrtR
	 /XbYvyEwX4oJ1ZuGw0y3FDlJgHpfBC/MDy2mVQJhLvFYyvA8kNpcB1Rjd7eyNImyij
	 Cm8HDiOQTIt88OCKXtzBCJiHfEgdu5e0Khuj9UaSsvoSg+BnBtDNxCIBcUU6kX/MIJ
	 dDppknI5UtdlK9CvjjmUNhfh4em92yMtJtqOnzOD1Zu3oDzcEBX5b4yPqOAH8IidpO
	 oDGHKq4YUdcH+2Yd3w/ElsGWahoqAWO3Whd+07LmUByZ18rxvat8Le6AlIJDZp0ulx
	 w0at2sll7flYw==
Message-ID: <sashiko-outbox-224141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/13] PCI: liveupdate: Preserve bus numbers during
 Live Update
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-7-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:29 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Keep the secondary and subordinate bus numbers that the previous kernel
> programmed into bridges, rather than assigning new ones, if the previous
> kernel preserved any device across a Live Update. Do this even when
> pcibios_assign_all_busses() is true, e.g. with pci=3Dassign-busses.
>=20
> Preserved devices must be allowed to continue performing memory
> transactions across a Live Update, so the kernel cannot change the
> fabric topology. Changing the bus numbers of a bridge changes the
> Requester IDs of the devices below it, which would require disabling and
> flushing any in-flight memory transactions first.
>=20
> Apply the policy globally rather than only to the paths that contain
> preserved devices. Bus numbers have to be preserved above a preserved
> device anyway, since an upstream bridge cannot expand its window. A
> global policy matches the scope of pcibios_assign_all_busses(), and
> [ ... ]
>=20
> Make PCI_LIVEUPDATE depend on !CARDBUS, since preserving bus numbers on
> CardBus bridges is not implemented.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D6


