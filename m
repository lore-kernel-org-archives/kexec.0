Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F760B909E
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ILVaVk0L;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gocBBGef
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5hs0yObu632v5VqYscPdHVqsnq/hS9vQJRHPhHsRg0A=; b=ILVaVk0LGGNd56
	4v265FsjMHRJPzhMo7VQWmE/MVpymeyw6SkmJCJHOF4IzHJD3MZ50nmYqqSqTzLNCx67Ov4ue3Jfy
	AsaSkNB8dqwzad4eNeiI4FF+Jvhl+k7j94v8xvQTlnNeQcPtSXqA5W68pUtCR/boxzcnUOR2NKlBo
	fY5DT+YYYqQrq0fXMaQ379pxpUoAYhqVTSstahd9/9YT+bMhtatUFLfYgII1r0K+LHkIk+Rn+3c3w
	QKjHNojLh6jr8jh/de3sQJSBQstV0aly5HkrHWQFQzo5Wnr6L1rnNoOMosIqGiytGjPDnLgA/sM0M
	B38nXy7Cipztgu3gJ4sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhO3-00000006s9o-0j55;
	Wed, 04 Nov 2026 20:15:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhO1-00000006s8p-43lX
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 20:15:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0CDCB41470
	for <kexec@lists.infradead.org>; Wed,  4 Nov 2026 20:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E297D1F00A02
	for <kexec@lists.infradead.org>; Wed,  4 Nov 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823308;
	bh=5hs0yObu632v5VqYscPdHVqsnq/hS9vQJRHPhHsRg0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gocBBGefUS86VeDGr2GnpTXWHIBcyehEC2BzWYaGTs+R5yXx9Am/8Bh5+zeBlQHk8
	 PmhLKfvq8zVEbvNUsXvs7sMBwkgWDqScd2gBkB7tdvNcnSQ1CpRA81wa96QKKdGiP+
	 NKezweyP7HIPECGSFAQQ99swLRmH3aHllYpNahkuGi0/kw9zYNCwq4ciTGyB1Wwczm
	 N2BxU7G15rVtzlE+3zhsr0aieZPwhUfbwbnno+A7oNNVdrJ5ZQQ/bD8E1KRhsYD9tl
	 CerEHtHV04E2LVDCt47D3yJET0J2yudAl+Kjy5RxwskxCEEO8qQzUVpokNNIjQshiE
	 59nbqAC5vAy1g==
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15dd124bbe7so2280828c88.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 12:15:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxzg/FfqWSdTBuHI7ffXXZBA1FUxieq/YYBUBWyZUEksvRz+bQ6/obXp01q+D/uHoAtDctWPg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8NMAxvvmvbJuIf8E9Z7xVKW4RLUQp5kFw7tKCvliaQu5zxuRst
	N3rPeWAZMTgZrasT9KRYodqmMWUFOMosXeBRR6qotOtTI868gmMzajh7xuQeN227XR63am6+8td
	WxKw4zZlgqmJbtBgAzS/Rh7VdSy1IE7s=
X-Received: by 2002:a05:7022:5f0b:b0:1ab:de8b:5f0f with SMTP id
 a92af1059eb24-1ac5cb18717mr23723691c88.40.1793823308323; Wed, 04 Nov 2026
 12:15:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com> <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 4 Nov 2026 12:14:57 -0800
X-Gmail-Original-Message-ID: <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com>
X-Gm-Features: AclHuK825M3Tp0Q3mYcH1rJyDUZVk5uCyEMH07CZFl9zj20qOO90PZscL7Din2Q
Message-ID: <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
To: manuelh@nvidia.com
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Luca Boccassi <luca.boccassi@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 5:31=E2=80=AFPM Manuel Huber via B4 Relay
<devnull+manuelh.nvidia.com@kernel.org> wrote:
>
> From: Manuel Huber <manuelh@nvidia.com>
>
> Add a dedicated .ipe keyring for IPE policy signature verification.
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
>
> Gate creation of the keyring behind a new by-default disabled
> CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
> is empty and writable. The keyring is used as a fallback after the
> existing policy trust sources only when it is created, non-empty, and
> restricted with restrict_link_reject.
>
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> the early lifetime of a system. The trusted component can then sign the
> IPE policy, destroy the private key, and load and activate the policy.
> During that phase, the system is considered in a trusted state whereas
> the system transitions into a possibly untrusted state afterwards,
> running arbitrary user-provided applications. In such a scenario, the
> trusted userspace component could reside on a dm-verity protected
> rootfs disk, and applications would reside on additional dm-verity
> protected disks. The latter disks would be dynamically attached and
> their dm-verity root hashes and/or signatures not known a priori to
> launching the system.
>
> A concrete usage scenario could be Kata Containers, which enables
> running Kubernetes pods in ephemeral, headless utility VMs, possibly
> without systemd. The rootfs disk is static and known beforehand, but
> containerd's image layers might be acquired and transported into the
> VM using the erofs snapshotter and dynamic block device attachment
> using dm-verity. While in that usage scenario, signing a per-guest
> policy with a pre-provisioned policy-signing certificate in the
> builtin, secondary, or platform keyrings would be technically possible,
> it would require including its corresponding private key in the guest
> build artifacts. Making it possible to use an ephemeral,
> userspace-provided key avoids shipping a static policy-signing private
> key with the guest rootfs.
>

Reading through this scenario again, I have a question about the design.

I suspect the reason you need a signing key inside the guest rootfs is
that you are running the snapshotter inside the VM. Have you
considered generating the snapshots on the VM host, signing the policy
there, and passing it into the guest?

The workflow would be:

1. The host generates an ephemeral signing key pair for the VM and
injects the public certificate into the guest's platform keyring via
firmware.
2. The host prepares the image snapshots, computes their dm-verity
root hashes, and signs the resulting IPE policy which allows execution
by dm-verity root hash with the ephemeral private key.
3. The host attaches the snapshot block devices and passes the signed
policy into the guest, where the guest simply loads and activates it
against .platform.

That way no private key ever needs to live in the guest, and it
confines the TCB to the VM host. Would this approach work for your
setup?

Fan

