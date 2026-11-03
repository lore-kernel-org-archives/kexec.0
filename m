Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A2B608361C
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L3WTbtpD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rcjo5N6W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z6+lpoHQf6RbDNG9fFLF3VrDYJoFB8bCt7Wgh9rVIYM=; b=L3WTbtpD9LUkOfNtmS9mTPzd36
	H0XXgFsWbBkiBr7gvpZo7rasJyUVvDo+Dk6Xs1u3MeWZ5oJMrb59vVXlut3+qLg44L4K3m5akQzcA
	LUpQbEw2KknElchbDuk6W1xJnZkbr5VqxykDlP2kZj4xT4rPR86P/HwrWtbWBgrjhz4CI9cQ1fAn6
	H3UaIyIEkiIWTBXYWsszAjKMQWhYEuLqfu3VclLpQJBGoY5JTcSR6uDf9KcUyYlCGv/yswcGBj8Cl
	Xa94guBvrQgzjFJOeGwzSf4rwOIaiAPi+vA8imL4qflmMVRtwHm7sznmr0+oQmHYgmmDSRZ52vuyk
	40+U25GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHq-00000002vHe-04ob;
	Tue, 03 Nov 2026 15:18:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGHl-00000002v9T-3MnP
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:18:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B1FB60A62;
	Tue,  3 Nov 2026 15:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF021F000C1;
	Tue,  3 Nov 2026 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719132;
	bh=z6+lpoHQf6RbDNG9fFLF3VrDYJoFB8bCt7Wgh9rVIYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rcjo5N6WbPxt2+H7rfMn0U0Qn0UK/j677OEZtoRd7RaKxV3TF0eOjybPm+Wvbn1QD
	 hSU10xi/Ht3/4EFqNAngWEFlKFjOBTZDe271HhpPKO5QqzEULVu1P5axZ8BlukFHE2
	 oyiGctcJgDzhAUtWNdK+tOSgayatUnZ1OsddqjB5Sa9aBwTAMsUI+qoCW5YBvw/inJ
	 E56t40VVP+QCWR5FL7qtLIXAdUD2SXiFQlAlvIN02UVK9jEhtzb4NOZWhSi3Mklo7S
	 1NjomUuGTNSSmAXI0piLRxDEoJT8t632y2Q993FbJx+Vtkql+a0fsVjR65UKzjfWQV
	 ++98Ev+HgB9kg==
Message-ID: <sashiko-outbox-195592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/23] scsi: sg: let procfs own the seq_file of
 allow_dio and def_reserved_size
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
In-Reply-To: <20261102-work-procfs-drivers-v1-12-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-12-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:50 +0000
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

> Pass the integer they show as the data of the entry and declare the
> show function, procfs then opens and frees the seq_file. That makes the
> open functions unnecessary.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D12


