Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CB606EE9F
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fJ7yiNJ6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hasVYka7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=N05eG3DcsrZpQfqjL5D91LwnvEOvTP0/ov6vkT4Pvcs=; b=fJ7yiNJ6PUjANcvHvz93utK16F
	u6SUhi2XHk5wLqgMFatVWkO/nABNhOfL2HoJ6NJZlKfAFEeRY+nUkZZ0TzId8gIaKyFwpi0Sfuxr7
	Y+fA93tmR/t/Cg1y22VLdPwpgeHMcLjgtNS+0LoZn4fDDONmfO32NtHy0RF6a9TizZ2Kg6LZZ+PCi
	tg8cG8pSoBhLPANQBrUCMnAd0+M1vZ1L78OUxC/kunw+/j3ffFpt9OwORAMBWL5xlkBBVBRNKCM0S
	N7SzzPHIEIjPNyrpAxJdC4JscHPuMDUbj1tcTpe8av8/+2qp463aHl7u3P8AyxTO9vBOybhtIkI/+
	wU0n3H0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnZ-00000002kh4-3yFl;
	Tue, 03 Nov 2026 14:47:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnV-00000002ke6-43rP
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:47:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AFC7E4095E;
	Tue,  3 Nov 2026 14:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80461F00A1A;
	Tue,  3 Nov 2026 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717257;
	bh=N05eG3DcsrZpQfqjL5D91LwnvEOvTP0/ov6vkT4Pvcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hasVYka7WfTQX4gVG72LHVrtfNEhVp4P8ZtdcWyH+LgHzqiGmI0IYbQHO1iwq9m07
	 y/1lwfnTHWCCY+cbAgh9hskIZQ97rVMlqM95iGbxPIOe3f8RS9bNGt+mxw9ntpVqb/
	 scjaMJLEVTqoyjO6TjfG7nqX7032JBfqmizKNDbPX8HDDI6FUj87MgRMBXyr8hd/G6
	 o/Ht1P5w/7ACphg2RTZAjkTSNTX/ebWs2gke1l0yWrd0iIR+fNLltdhYI899csOJwZ
	 1y9qK6xl8eu6MrQZdcUR4uzY+8RNuZ/DmBvaIF0iaqRFYBY29TqHfRB0P45MNfIHFj
	 usD+mtvrE3OkA==
Message-ID: <sashiko-outbox-195477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/38] platform/x86: toshiba_acpi: reject malformed
 brightness and fan writes
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-5-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-5-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:35 +0000
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

> When lcd_proc_write() and fan_proc_write() were refactored their checks
> were inverted but the && stayed. They only fail if sscanf() didn't
> parse anything and the value is out of range at the same time, and for
> the brightness value < 0 && value > levels can't be true at all. So an
> out of range brightness or fan setting is passed on to the hardware,
> and so is the uninitialized value if nothing could be parsed.
>=20
> Restore the checks as they were before the refactoring.
>=20
> Fixes: e1a949c1b988 ("toshiba_acpi: Refactor *{get, set} functions return=
 value")
> Fixes: 3e07e5baa2af ("toshiba_acpi: Add set_fan_status function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D5


