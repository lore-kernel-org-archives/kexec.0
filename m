Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E431606A911
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HHzpyJem;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6l4/tba
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uEqaClazRJnTsShq1vBrZThkV8Ug5LupXRrZvH3pubU=; b=HHzpyJemncaWqW
	hOiUsxtfI3QYH66YAdLBI91InQ2GZTNi5GpI6+/cwyLbHjMENw0Oss63Tdw24jXPgwVilQOvHjqbU
	ZeRq2nYX2c6yFr88760SprncSh8Igweb182A1e8+rA6Rcg+vCEDKTDqCqqywcN/Q+MJXmnUbshWxG
	tHvxdjy/LhMoRd5z1hhW4pR9mlTUDGYGPA/YsexftI2dQfISdsnuPZ22onts/Y7A8zsBnZYw8MOzz
	zjB+ufUKHJl4JXfSPyv1LLlXMny3/wauUavbcCylk879nfN6V8kCdz8BaOL25xh2+jhj0f0lbgVpI
	IvOvj3zMoHl4M/ftvYSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNttA-0000000H4l4-2rFb;
	Mon, 02 Nov 2026 15:24:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtt8-0000000H4jP-1oLZ
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:23:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C1F960A4E;
	Mon,  2 Nov 2026 15:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B5A1F00A1F;
	Mon,  2 Nov 2026 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633037;
	bh=uEqaClazRJnTsShq1vBrZThkV8Ug5LupXRrZvH3pubU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=I6l4/tbaekcm4F5Uy2sM5lYNZJehob3zbilnEvdVd5Be7BHLSA58cOrhPrILPdFvq
	 VYhCXzN+7v7yzkwvPgGyx14entsyEm+617RN6ONGE//eK8k+1BetRrKVHulJ5QbSin
	 PhS8HfUZqzzeMZUZO/v6APmD3sn4yaMgG66Qsqn8sOS9bND8zFW5xc3DAvH+pJN+zW
	 2O5TNMh5qcv6DV4Yetx+J9g4v/mnh/idqce0ZMwvwkWvvLBPw7dNas6Ir9cn/TKgi3
	 cPIc+u7eIO45sBIcX4Oa8V6/wXDS2qubRfgYQs1GfGIeyTgMlWMeauo9Hh77UxYwL6
	 FfVTg57cgsBVg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4DA53F4006D;
	Mon,  2 Nov 2026 10:23:55 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 10:23:55 -0500
X-ME-Sender: <xms:C6voavPgQSRhi6XwAzM8RnPtl2Qk0fRj95s09_7pjCvBkgc9wCgEZQ>
    <xme:C6voakztuZUoJrF-uTAxl2B72x3pmfwEKg-LcE13JEST5qccjmIjzKvqrpEWmzfMg
    -nHWFjmTR6858SSLl1zCNNaUAFoAnJNEx_iFa19V0Qt32rVtZen6CU>
X-ME-Proxy-Cause: dmFkZTF+ugG07b1xzJ9p0xcEFxqeAUuLkm+cBz6ii1+M2o4G6r8HqTUbbTFu18jUFSJc51
    Uj/WAYx1vLl1HSE3ylvEypL7jKJPv1KgZWPB2jf1fZVCtbPTSv1quZFsQjIyJhe9070QIh
    uQLf2wtG4yD+ojXnVZ3slOSBiSDghElaqTK7IeYJyToLF92DkQAYc/RGRRPOyD8hBeRAvE
    Nch4lTm0R3j1fupNVliv+Zb3ueLjvcNJfLsUEyktNZuL98xLp9t29seWsvXUNWHVoJ4uvh
    slBVaqCA11v/MsN/MRHGG05E/DWbmBLvDFJPHdsId2elsukPHwuZGosb7WcPszwpbfZZgV
    bm2FrNuJvmDOIFxayRrMo3/bGXJGRqqKBPvBIaAv1rXkENYn4zSvEA5QOidA5pB3XUhmos
    x08vQ9jzlrTeM9JnMvw3se+lrV299CFmE+fTg+hlbCRXvAl6sZE79B8vu6VSR9XtNh0jVy
    C4+hYe89om3miNRS4TpzQvyb77peufEKiolSIU0wmyCGRwtb2Us1G/qCaXB0fxyzIy79cY
    1kg6qGRDh7uw8Gww/mv7TrEgW8mpkzBuVLXohTCxaKYorV+OhEcRntGnKGm/9Exa96NKy3
    AMQrlyXBmDZmT3LrcryBxr6Vx6LQ+RBaOIY9+Czn08jGf4XpaPjwaHDoTtxw
X-ME-Proxy: <xmx:C6voanx9pQkwlSkK78xJaos_d5jwrX3PPHLb_TLVG8fs-X1Spep8qA>
    <xmx:C6voalKVyQAGVPcO-wGv3krzxEi_6FtQAeAVqBnSiS8ylmXpqCdlxQ>
    <xmx:C6voajxgXNF0PnlEcauvcL5M9jsWsivItl9e9M8ymKswT8wDOTEnxg>
    <xmx:C6voaiqnbxtboTm78N0amXUEhxn5ytMWswtAcUdzERqqQMeM4JMAbw>
    <xmx:C6voapU24fdZKXD-sUGTpbuIUcSP2EFmKemoyPTf_TL11WFoX74F0nG2>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 15863782738; Mon,  2 Nov 2026 10:23:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArOOpyqnvtx-
Date: Mon, 02 Nov 2026 10:23:34 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Chris Mason" <mason@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jonathan Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Joel Granados" <joel.granados@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 "Takashi Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org
Message-Id: <58f6bc57-d6e2-446f-932a-8104b73cb654@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-fs-v1-3-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
 <20261102-work-procfs-fs-v1-3-d09a996317b3@kernel.org>
Subject: Re: [PATCH RFC 03/27] lockd: let procfs copy in writes to nlm_end_grace
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> Implement ->proc_write_buf() so procfs copies in what is written before
> it pins the entry. simple_transaction_get() was only used to get a copy
> of what was written, so look at procfs' copy instead and drop the
> transaction. A second write to the same file doesn't fail with -EBUSY
> anymore. Writes larger than PAGE_SIZE - 1 bytes fail with -EINVAL from
> procfs instead of -EFBIG from simple_transaction_get(), which refused a
> few bytes less.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

