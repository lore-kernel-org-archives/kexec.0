Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91A606A33D
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RdmM82CW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJkhhsCI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HMjVqMwWfVJkS2IkBXjF53S0Inck/QTosxfr8CwPkgc=; b=RdmM82CWcSCcif
	66XzX0N6PvC6DdcxCDlsWpQRMLhrLUfBuT3iZO6CEj3XgTFAhHS8AtyBb/4OxqX5Uj58XXRHTmZu9
	+Jh9CCm6P1iR/8VJxzO7W/r13lbb08tRqHnz+tmCT3wW1sirpPE3tgm9fLTPM485nyg80iO5JTT/Y
	QGDs7xGhg6FeZ1272HSVPckJcqaPoiIs7UOkGEmfjRzvKuM4mN4eqAQMDNNn1mFKNukoZQUO5OCwA
	EveALHCtZXGQUurYBIJwqHdH6onI6bxRONwgtLiepCZCCK5q/SYgGt/ujtE1UJPcSL9zDvuLmURtG
	YUUHQgGNAkahTbOgyHfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWIXC-0000000B75x-1D5w;
	Wed, 25 Nov 2026 19:20:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWIXA-0000000B74x-2lp6
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 19:20:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2666946271
	for <kexec@lists.infradead.org>; Wed, 25 Nov 2026 19:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16341F00AD4
	for <kexec@lists.infradead.org>; Wed, 25 Nov 2026 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634399;
	bh=HMjVqMwWfVJkS2IkBXjF53S0Inck/QTosxfr8CwPkgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aJkhhsCI5HZDNvJlXfWnRa3te9uon8LF9NfNHjioE4kF8M36Pty8PaVrkcjD1q7d3
	 EIznrbkNLsi6mx3J8hZwZB+l5TTZuVGYtWmLjbtcXrD3cXWul9I/ol/uSLq8nTBV9C
	 PUyyPtnkv4rBGgfvQzKnIdRrCZtF5rr17vOK5z8K+bXrBuVoD/sGTIT3BPb8dAEQh/
	 Ahck82IsLjD3liwVAUtmXY3Gr3qYCgK7ZCgV1LQ5qGmJ5k/9xitAuxbrdnQGM190qn
	 HL7abik+r/KilX594sQh1F+rb1mzyrNLws/7cgYA/eUMXymP6FIU5LQD8tVnvV/GdI
	 1rw/0b6CLIsAQ==
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1aefd1bf74aso3158364c88.1
        for <kexec@lists.infradead.org>; Wed, 25 Nov 2026 11:19:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFWbK1g5La/prkUB3l97rp2CB9BK/7mnZ7JTOvrj+Zz8oeSRLbfVSp1Av9Kibq5vdJQiz8uwg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/ABcTi2y+0A0mN/1+eMMYVDTlqc/F/s/9tiN12VcAGr+cDFPRi
	N2py2xjFu1DVf33m8DRwyH/edQxnFpEj4naF3ZDNMhUtx2Qcc5TMo/1EHNznI+JVB9MurrqU33F
	eEATddBsti7uZg1smwmSOa6GOjRuGe7k=
X-Received: by 2002:a05:701a:cc93:10b0:182:d0a8:d1a9 with SMTP id
 a92af1059eb24-1b551f69c66mr18716976c88.0.1795634399235; Wed, 25 Nov 2026
 11:19:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
 <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com> <SJ1PR12MB6124F08E6BA4F0D1D7BBD9EBDE772@SJ1PR12MB6124.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB6124F08E6BA4F0D1D7BBD9EBDE772@SJ1PR12MB6124.namprd12.prod.outlook.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 25 Nov 2026 11:19:47 -0800
X-Gmail-Original-Message-ID: <CAKtyLkHfQ4QETWjxew37T4p=2vLyiAUW6YBm6PFjfrk42WimHQ@mail.gmail.com>
X-Gm-Features: Aa3M54rE3TgF5e5nAv8xwCNR1hIbU2Bku9v2QUAWAUX1eU3A3wmiOQ1vCGvM17I
Message-ID: <CAKtyLkHfQ4QETWjxew37T4p=2vLyiAUW6YBm6PFjfrk42WimHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
To: Manuel Huber <manuelh@nvidia.com>
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Luca Boccassi <luca.boccassi@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
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

On Wed, Nov 4, 2026 at 4:10=E2=80=AFPM Manuel Huber <manuelh@nvidia.com> wr=
ote:
>
> My main angle is confidential Kata containers [1], a usage scenario in wh=
ich (Kubernetes) workload containers run in trusted, confidential VMs on un=
trusted hosts. This scenario involves hardware TEEs, attestation, and fine-=
grained policing of host-side inputs. Without getting into too many details=
, having an untrusted host bake trust anchors into the guest on the fly wou=
ld undermine the threat model. The proposed IPE keyring gives the trusted g=
uest the ability to construct and sign the IPE policy independently. Also n=
ote, outside of the confidential scenario for Kata containers, various Kata=
 containers flavors are very opinionated on the guest boot flow, so I canno=
t rely on UEFI being present. Having a self-contained mechanism independent=
 of firmware certificate provisioning would therefore be highly preferrable=
.
>
> [1] https://confidentialcontainers.org/docs/architecture/

A vague reference to confidential containers "without getting into too
many details" doesn't really help here. Before we can consider merging
a new keyring into IPE, we need to understand the concrete threat
model and why the existing IPE keyrings cannot work for that setup.

Neither confidential containers nor an untrusted host is mentioned
anywhere in the v2 patches. The v2 commit message explicitly states
that using the builtin, secondary, or platform keyrings is technically
possible, and only argues against shipping a static private key in the
guest build artifacts.

On the two points in your reply:

1. In an untrusted-host VM, virtual devices and host-to-guest channels
are still provided by the host. How does the guest verify that
host-supplied inputs (such as the dm-verity root hashes of dynamically
attached disks) haven't been tampered with or forged by the host?
2. For the non-confidential Kata case, what are the concerns with
using UEFI? Without UEFI, what boot verification method do those VMs
use, or are they not protected during boot?

Fan

