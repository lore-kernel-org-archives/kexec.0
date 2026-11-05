Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A82606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=20C2uYYN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cu7eu+12
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gWl/eS0i+nr4XdDXA5M0CJZ7C2TAuMbpXQ8ABOJIUDE=; b=20C2uYYNlz8ixjnfyU5qmu7f0g
	aL/kQq6yYnhGuaeeahpP5rUqbiTQ2ZHWbZEHn2H3rvvg6VreQb5IEKgQpceET7ap1x5ljnWRmrcJS
	TBgSzyKLG16620hzsyn1CJ1Dha4Bixu4n0yIpv7SVDzHdrilutP/1rmTV6W1CHyw0E8Qsa6kv8v8y
	WGO8/tSFIv6drvwyRntfLhhzhHp5ekUt9+CZi2+5rh10jYyIMr2haX9a9/Eitx8wd+JcEc6kpqaCj
	e3HEUu/Y/1qJgyjZ1Hcxu4+W3A+QkozjY7SKXOIT40EIFEgaMjTxJJ77Ty7UpFCWurWWgSvWRw8pk
	x5EaDo3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Cc-0000000ALsi-0KTn;
	Thu, 05 Nov 2026 19:32:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3AA-0000000AKmQ-3Vts
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:30:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95D9343986;
	Thu,  5 Nov 2026 19:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F881F00A15;
	Thu,  5 Nov 2026 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907018;
	bh=gWl/eS0i+nr4XdDXA5M0CJZ7C2TAuMbpXQ8ABOJIUDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cu7eu+12hzXn2rBgNm5FgURzXiyF+JzZ/HlWMrHH+wloSAfrTnDuHK/4nzsGd3RJF
	 OfhkDN1FJWE2zeT0nBEOto7RrFn2Vo3CHtOHlbAtLSlIHJW3WS/ka4jpgMEdobZqj6
	 TRVRHQSZHdfrZbstLAqLE1AsQHNIhFWYraM8mxuSmv08QDshuTBKJUnVNTRRPaE9Sl
	 ZtoZMpZjJHhqEVktCV8sijDQ1MfTVKPqVWHtRNTPrsxUHp4+DE5ncU3V3cirf4h2hR
	 uG1ycvfacpeK0T3AqbcZk1NO96i54BYiLNW3IoQg4Lup6PGIZvO2ao2d0AtDNhGZpI
	 J4HUeGgLf3t9w==
Message-ID: <sashiko-outbox-199906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 43/51] powerpc/pseries/lparcfg: return
 h_get_ppp()'s status as a long
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-43-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-43-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:16 +0000
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

> h_get_ppp() returns the status of the H_GET_PPP hcall as an unsigned
> int. update_ppp() hands it on as its ssize_t result, and
> lparcfg_write() turns the hcall statuses it knows into an errno and
> returns anything else as it is. So when H_GET_PPP fails, say with
> H_PARAMETER (-4), the status comes back as 4294967292 and a write to
> /proc/powerpc/lparcfg reports that many bytes written.
>=20
> Return the status as the long it is. lparcfg_write() then treats it
> like the status of H_SET_PPP: an unknown error status is at least
> negative, and one of the positive long-busy statuses comes back as a
> byte count, as it does for H_SET_PPP already. Before commit
> 11529396ea31 ("powerpc/pseries: Split processor entitlement retrieval
> and gathering to helper routines") a failed H_GET_PPP turned into -EIO.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 11529396ea31 ("powerpc/pseries: Split processor entitlement retrie=
val and gathering to helper routines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D43


