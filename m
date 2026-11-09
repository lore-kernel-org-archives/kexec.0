Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E08606A31C
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zw2VJORZ;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvhxiug+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date
	:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ngLdVs5ADSc+NgiOyvdsEU2ojAZWKq+pUBeFdxdN+sA=; b=zw2VJORZASk23+lzjB9Vo5yxGd
	iEAAgwM28SOfpeJgKLif9yH9g0hPWOl/z2rha4gbyPnajGjf6d2qUXQpLXtrLmbKb+wGs0PTZkkLB
	aVNmy2M3ROLaITGEw0dXfzjFkMBFHBqCZK4aqdViVzGTdA4e3GUlAj8cqiUzYdNX0LqjhlzymyAqv
	DVaOFHv1QmfOAw63MUxxawYQfn3vSayBs3Ne3j/tkG7JZEY9HCFZJsbQulGxwDx8e8I0uHsYylY1Y
	vWvEIwW0pn8x17E4jszlygCWm3CNftoZvfdahCmqTqZ2GAU+nL6a9OL5qChDxAKd227VEZix4ieeN
	Q+t+sb2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIJ4-0000000HSn8-2a8U;
	Mon, 09 Nov 2026 05:52:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIJ2-0000000HSn0-3Sdd
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 05:52:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 12D1A43F81;
	Mon,  9 Nov 2026 05:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4EC1F0089F;
	Mon,  9 Nov 2026 05:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203555;
	bh=ngLdVs5ADSc+NgiOyvdsEU2ojAZWKq+pUBeFdxdN+sA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lvhxiug+ERAgyEb3q015lbkxsX0mFCoaNkuzkQF6afElu7r5uMW1MorylNaNp8Yar
	 +jXHTdkrnARbVZhFpIAnMv/ddZWUuBsvFhpZXIso0yAUsE/SrKjnAy1uGscJTyUDlk
	 aYkvbHBknQGPTMwxXhmDBBfpjFI98ujM7g48zfqgMYC8eXTZmQ3EnW5rp7475YSqk0
	 ZD17dKYztxfMZ9HSwhyTrlbEDW5WT0jcCgbW3CrM1zLCOAQ9rKbprFGGtYZTKZFJPd
	 89P6oT5HXDrSWmNvo8BwT7zOU0fHW8o7ENq71POAbiyOJBzYIGr23jwGw8z65neF1e
	 qZmLhBfHmAkBw==
Message-ID: <sashiko-outbox-204461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] x86/vmware: Report guest crashes after kmsg
 dumpers
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
In-Reply-To: <4dc02120a69e0d4b21f1ea3a12b4aedf6f22e706.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
 <4dc02120a69e0d4b21f1ea3a12b4aedf6f22e706.1794201807.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:52:33 +0000
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
Cc: "Michael
 S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Jonathan
 Corbet <corbet@lwn.net>, Brennan
 Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, John
 Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah
 Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian
 Forbes <ian.forbes@broadcom.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Thomas
 Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> VMware accepts a structured guest-crash event, but a host configured with
> backdoor.coredumpOnCrash may terminate the VM before the hypercall
> returns. Keep this event separate from the log sender, which runs
> earlier in panic.
>=20
> Register a panic-only kmsg dumper with late_initcall_sync(), after built-=
in
> dumpers registered by then. Skip the event while a crash kernel is loaded
> so the host cannot terminate the guest before kdump saves its vmcore.
>=20
> Issue the event at most once. With CONFIG_PRINTK=3Dn, use a late INT_MIN
> panic notifier. An unexpected dumper registration failure with printk
> enabled leaves reporting disabled rather than overtaking working dumpers.
>=20
> Link: https://lore.kernel.org/r/20260309235250.2611115-4-alexey.makhalov@=
broadcom.com
> Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
> Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794201807.gi=
t.zack.rusin@broadcom.com?part=3D4


