Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA7606D82B
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dYbLYr+E;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kz/9BmYM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=paGK4Vm3mtE5b0c2DhkRMvpNzDa4nvSsw4DnEf+BgQc=; b=dYbLYr+EIxGdq0P6e4luk2VTAu
	ug45GXvjo5WypXtggdFu/HITuyxHKn0Rq1Rd6WkNlZwfwrX3f+iASzfkfp3Bbb12R52rxfScLfGFN
	Ouft/UHr4vuW33dfHSPsQc6TOG204hyxlTIJ8nJhhljvWSkOzRFnRX2UqMYElUBdqVfGqr6c53f4q
	3KadJDA5Y6JIICUCokAeMd3QRR1gpgZ82y+M8KJpJVe9lM0ZhBSfBPDHoXzeWblV4la8Dk+FL/7M7
	B15z28MBIkvjGjAuHVSg88CphcJmUEttOH9gwX1Jy20FD0KbSkwUGcQenfXcKk9KdaNlocAcC2e2z
	m8rezKVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0e-00000002paX-1ThL;
	Tue, 03 Nov 2026 15:01:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOG0d-00000002pZa-3ccC
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:01:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F47D609D1;
	Tue,  3 Nov 2026 15:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C80F1F00919;
	Tue,  3 Nov 2026 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718071;
	bh=paGK4Vm3mtE5b0c2DhkRMvpNzDa4nvSsw4DnEf+BgQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kz/9BmYM8ipZ0nqa4i1SDv6lAnRGk0DIAMwuEMDu9VajUTqnuibPJ60MM7nVnRyWU
	 0YGeeeZk1WD+5JhFzeeiubPttCRps/6djOG+ittG2lCUSz7LOAZYeKer7ogjO+h2Kf
	 NysxxWG34bBgucluHmCoqrvXiFc86zWo0lyI1OFo9kGGQlfblamt4HbUkUxT4PE6CV
	 LOEA6bDUBX8DU55FH/kj+Kw7Csqqg0NGPAkqtEvSpQ2QlNenqLvrP7m5r9qMAJz+Bp
	 sLUC6fAIW91wbjix1EMEC1iN30+fEqcayJA2ywzzSpskhM1z/zvbwlYUrxSQ32aLe+
	 VKbU2vNEoY5eQ==
Message-ID: <sashiko-outbox-195532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/16] proc: let procfs own the seq_file of
 proc_create_seq() and friends
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
In-Reply-To: <20261102-work-procfs-core-v1-5-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-5-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:09 +0000
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

> proc_create_seq_private(), proc_create_single_data() and their network
> namespace variants keep the seq_operations or the show function in the
> entry already. Let procfs own the seq_file for all of them. For the
> network namespace variants ->proc_open() and ->proc_release() keep
> taking and dropping the reference to the network namespace.
>=20
> That's most of /proc/net, among them the files of xt_hashlimit and
> /proc/net/dev_snmp6/<dev>. A reader that faults on its buffer no longer
> holds up their removal.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 786d7e1612f0 ("Fix rmmod/read/write races in /proc entries")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D5


