Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2F606D2F8
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NF96x/21;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1r9+8r2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=08+d1qfvreEkjdhfCWoVI27IHQFdkJLNOAr+NI9qWps=; b=NF96x/21YK2MCLZA2VwZF1oBHQ
	QoeZ8ozYz+zFB8BaQam6WH5K/loQu10CTOSixCvDQj2NFOH6KIlKZAJD4IENVbjFaT4odJ+4xo4Z5
	oaXTKVqvquBi5XkyclX58cpxnbMa7VRa+sSn0zKYlPzAOB10jXh+kiKME5lnW+JEdqPySUVABZia7
	9Hz/Wi/3FRtfVMWMtkxk0axjAOHlDjyFPNWjWhLnLdPShWjhNHRqgxoVZKlSnv3Skfhy+NDSzk4Rc
	kl2IHw90JPYHJS753FJlGbV2vr/vDBQyHXDH8RcdLezY61KWNLImQT4tzAxfbQgbTz68tmHVocuiU
	vfODoajw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGIS-00000002w0j-44wx;
	Tue, 03 Nov 2026 15:19:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGI8-00000002vhp-2xZD
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 15:19:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AB3843F40;
	Tue,  3 Nov 2026 15:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B51F000C1;
	Tue,  3 Nov 2026 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719156;
	bh=08+d1qfvreEkjdhfCWoVI27IHQFdkJLNOAr+NI9qWps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1r9+8r2Wy5ZjOv4fJ1GoSbUdruq+AKDakXdPym36omcIQj5oI3RDvQXQkk7K2pOH
	 aZOYNjI9zOi+rkLqyjgQUDVNg8zZ4OIRXHIivKTwUb8xi0sYaUhL8HtOq4hFDxlnsC
	 ugaWfdP1eR4O/X8dqLwIEm3+bKrgwf1ndJQeP/YdlN8NK359AzrXxLprhNHYW/1Dpp
	 vL847jEpl/4GoCymsogWvpPgMP5lTJjt0Z9FMjl/iXXQhlwp8eo243i8ta6gWDAkpG
	 R/CGZIXSyz6k4CMqZUTFX4EjDGUfogAbrkZmxlVgTnJiWhIG78B81lpdbWmuce6I3g
	 Nyv+90V+AsLYQ==
Message-ID: <sashiko-outbox-195603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 23/23] ALSA: info: drop the ioctl hook of data
 entries
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
In-Reply-To: <20261102-work-procfs-drivers-v1-23-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-23-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:19:14 +0000
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

> No driver implements ->ioctl() of struct snd_info_entry_ops.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D23


