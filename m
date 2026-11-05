Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F153606A326
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2Cpy7Inq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxAzMv7U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UR/bGeijImnk8Wnsd/tmizN5U2rV5dto4UZIl+xyMfM=; b=2Cpy7InqDF81COt7mNmjaBysBP
	vfAiHQWir82VttMr7WzZh05SvEjMMLyV/Z8fX+km0VIKFMd0kkYLJOPk1Hs4N95V9fJt7Lr/tifJs
	elFiNHsu3q/scd+7u7ksGRgK1qZPCLmziHgw5b+OBeSUFq606R2BFcMcUZ711LnOHSbpgSV82QmVF
	xELWZf93RVjWDs6Qx5RCw1osD22/tT5oxumFhkaUBNbhpWoAR2f5VVy8t9MPb6et665lLYPGaTgf3
	h5kRectzIJ4RBRJfALQgml7aFw4Ozl03K9GtNKUC7UpUdTgi41QKUiXDwKHy5/DBv0nULlfgePoGq
	Fsfwl+yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3BI-0000000AL8c-2ZSF;
	Thu, 05 Nov 2026 19:31:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP39W-0000000AKQ1-1SrX
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:29:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1EFE342E2B;
	Thu,  5 Nov 2026 19:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA51F00919;
	Thu,  5 Nov 2026 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906978;
	bh=UR/bGeijImnk8Wnsd/tmizN5U2rV5dto4UZIl+xyMfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxAzMv7UFsyYnoBiL2vhlW1+tAK1RI3G9hd3638uMnnOa+X1Hd/XqYwSl1li8fliq
	 01QhsAxeUKmrnct1phcjHiDBlkTHs7H5HFNvKkpojOe2Up47iBr/sA68sM31T/h6S0
	 s1ItQIwz3EUke9VL6TKuHa6OR4G5BsKdMNyDzHw3sJFWrdLfbdMVss8m2/pslWW3kO
	 Z2bpNVkFCKMDl6PKap8s1Bfs8w8BOM0UrxtXZUW8aAbl0jCRWy07zKeWwaBY/bqScI
	 FXVCXKSbBT0TU1OECjLhNsgTdw455Z7U5ly3rnd8TVtw/5tgWX0i1IZgIKT9c/raGT
	 3wuaupfHri8xg==
Message-ID: <sashiko-outbox-199887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 24/51] scsi: ips: don't return 0 from writes
 to the proc file
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>, linux-s390@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-ext4@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, tytso@mit.edu, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-24-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-24-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:29:36 +0000
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

> ips_write_info() ignores what is written to /proc/scsi/ips/<n> and
> returns 0. Writers that use stdio, echo for example, take that as no
> progress and retry forever. Return the number of bytes that were
> written.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D24


