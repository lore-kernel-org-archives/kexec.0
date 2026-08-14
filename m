Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9860C5CFDB
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=32UXxjqR1VKYvNK68Dz7f7JjofaG/JzH3ImA8OxnCM0=; b=K+LOiUHCS7zJ40l9xdqfRCZQOt
	bt+86dfK/Akj52xlmibkwZRmKBUisAYY3BCVwmmeSVLNQUb7zP++aQaSLTCHamkx5K7aESO5Q34Yb
	f7uE37cqCBVt3JMNfQ5ecJnw1OoYB3NXStkV5ldF02IQ0HembiXWBt3RSVFC+NBQJUfunGs/QkIOz
	5b60pv7DPnqdS2o/AwSm1TGQqNHmYybPSb3KwD0897fNKL4vgkViDQBuRGpYSQoXsNosL7px+4BAI
	TVtZEVueuQ344L+HuARvwEH+AGU97j5sYw7XYT9laaQvpiX8/pq5O0htGAk2gVxZIo+ay7R9v0Xpu
	21BDr/PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wusMG-00000002kow-0IME;
	Fri, 14 Aug 2026 13:54:04 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wusME-00000002koZ-0Wrq
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 13:54:03 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c214321dc32so13130966b.0
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 06:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786715640; x=1787320440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32UXxjqR1VKYvNK68Dz7f7JjofaG/JzH3ImA8OxnCM0=;
        b=lLUr/cap2PxB7qDd4FMJhZpfAmD6SQIOMT4pNnyefzBtH3s8s3EhfnZg9SAAl4z6yd
         xI2lYzSh4bGO29Z5oZLCQ8fvRcWxyR4W+ImNVaHXnAMsGqq9lGVgIvD2hXHw1WVPzii9
         mY78GU3QQlWiL8eQpkKbLFysLiIPfOCsuEIgbvX1hZWRcEZJzq+4EUtyBhsT9eKstkM/
         8kGRVsgObVePHeL6uH2c9LA68V0RsjuLngEAQjcpvQiJFe2xiouf3sSctv0P4lQXfiu1
         +FAH29Qi14R8Mm3G+L3lE1Lf3t25wQbXzn3jHTom56bP+RoLDLVSIqZtC5tg+9uENuGx
         NSgw==
X-Forwarded-Encrypted: i=1; AHgh+RpUEuhD/OvkXFSKLr/fguBDpvbqAZxcK+3r1A0narhYKrWU8KhxF1YyA2+rb24DlAmEoTAHlQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxf+PS+/+ojVKotbQPz/czFOYiHrx8FRClFriyjSXgN68ZAvOKL
	O9cYO7Om3+CUfbzDp2Q+FBolHv4xx+JPrIgGo/zjnDtzZjnYcAtRpWqSn0N4CVApVR4=
X-Gm-Gg: AR+sD12BLqkpQPpn6hsnK0hY8QucgK+9B8Y+AszZ4vzJhEeLDBion/A79iQ2hE7gfGi
	Adb5xP9qtR4inNyy9XFdCg4oRJZBtzWGxp70a2aqj1Q5n6RRZ7FyAyYA8CdNKn84R9i130Z0Rdn
	nfNiJwhbyqrJKKLw4o6xspv2P3Ob49b5tDPYa+Fx7WKwC/JOrFx9D+GxgpTnryLkFJNgG492ax3
	8OtOkleA5gCoLm+ZC2nK3jNO18AzGkelaLkuPuJ8n+RZ6VQ3zzg0RFFO4w+U0htTQdlydpmbBog
	3e1sFurybyq7/6vg4T3GHxUS1eBbhFWAJm4M6GHRbDqJROutkg1+6/TfsBPTlCorWfwG/BrglCD
	DgGMdjlIDXHOYumr7ZYceofmBF1qORy4dYkkQ++ap0PiPNn88HhAFPKQjK3iej7GWaNvabIUjD4
	g7hzzHJPKmuIRYX2xvLdG99mq/2BvaWfA2H1TLEBAMNsfTdTXc3F9LvKwUQxTGsTxTOIuioNmbI
	naDsDQkPxlRWb8hf0A=
X-Received: by 2002:a17:907:ea92:b0:c21:2218:5c7b with SMTP id a640c23a62f3a-c2129ab6c4emr244423866b.1.1786715639974;
        Fri, 14 Aug 2026 06:53:59 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212378f82fsm100722166b.41.2026.08.14.06.53.59
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 06:53:59 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c167aa9500dso146218066b.3
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 06:53:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq3XUODBrO1TaqlIULKXRWMm6qV0d/jXklb00WuY3t/CaknS4s7SO8srLC5nAGSkppGdqKw3Q==@lists.infradead.org
X-Received: by 2002:a17:906:730f:b0:c12:aaec:342a with SMTP id
 a640c23a62f3a-c212a113efdmr280357366b.16.1786715639417; Fri, 14 Aug 2026
 06:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260813182546.138705-1-fabrice.derepas@canonical.com>
In-Reply-To: <20260813182546.138705-1-fabrice.derepas@canonical.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 14 Aug 2026 14:53:48 +0100
X-Gmail-Original-Message-ID: <CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com>
X-Gm-Features: AUfX_mwuLx2aJR43wVpuS27IhjyS7MfpE6qQTDN1bU1nAQBlqaS068ZzBhfmWrg
Message-ID: <CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com>
Subject: Re: [PATCH] crypto: asymmetric_keys - bound section data range in pefile_digest_pe_contents
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_065402_197393_F7B08BF8 
X-CRM114-Status: GOOD (  30.66  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Aug 13, 2026 at 7:26=E2=80=AFPM Fabrice Derepas
<fabrice.derepas@canonical.com> wrote:
>
> pefile_digest_pe_contents() hashes each PE section with
>
>         crypto_shash_update(desc, pebuf + ctx->secs[i].data_addr,
>                             ctx->secs[i].raw_data_size);
>
> where both data_addr and raw_data_size come straight from the untrusted P=
E
> section table. pefile_parse_binary() bounds only the section table's
> location, never the sections' data ranges, and nothing else on the path
> checks them. A section with data_addr and/or raw_data_size pointing outsi=
de
> the image therefore reads past the pelen-byte buffer (CWE-125); a large
> raw_data_size makes it read far past the end and fault.
>
> Commit f7dd32c5179d ("crypto: asymmetric_keys - fix OOB read in
> pefile_digest_pe_contents") recently fixed a sibling underflow in this sa=
me
> function (the hashed_bytes + certs_size trailer computation); the
> per-section read below was left unchecked.
>
> This loop runs only after verify_pkcs7_signature() succeeds, so it requir=
es
> a validly signed image -- but not an attacker signing key. The PKCS#7
> signature covers the SpcIndirectDataContent (a self-contained digest in t=
he
> certificate table), not the live section bytes, so tampering data_addr in=
 a
> publicly available signed image leaves the signature valid at that step
> while the out-of-bounds read fires when this function recomputes the
> digest. It is thus reachable by a local CAP_SYS_BOOT user via
> kexec_file_load() with a tampered signed image; the access is an
> out-of-bounds read only, but a large raw_data_size faults, which is a
> denial of service when panic_on_oops is set.
>
> Reject a section whose data range does not lie within the image before
> hashing it.
>
> Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKC=
S#7 data")
> Assisted-by: copilot-cli:claude-opus-4-6 frama-c
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
> Note: f7dd32c5179d, which fixed the sibling underflow in this function, w=
as
> assigned CVE-2026-64544; this closes the per-section read it did not cove=
r.
>
> Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64). Two things were sh=
own:
>
>   1. The defect + fix: a KUnit case calls pefile_digest_pe_contents() wit=
h a
>      crafted context whose section has data_addr =3D pelen. Unpatched:
>      slab-out-of-bounds read; patched: -ELIBBAD before the hash.
>
>   2. The reachability, end-to-end against a real trusted keyring: a real =
EFI
>      binary was signed with a test key embedded via CONFIG_SYSTEM_TRUSTED=
_KEYS,
>      then its section data_addr was tampered (leaving the PKCS#7 byte-ide=
ntical).
>      Results from verify_pefile_signature(): the untampered image verifie=
s (0),
>      one signed by an untrusted key is rejected at verify_pkcs7_signature=
()
>      (-ENOKEY), and the tampered-but-trusted image passes that step and t=
akes
>      the OOB read in pefile_digest_pe_contents(). So no signing key is re=
quired.
>
> The KUnit case (item 1) is easy to package and I can submit it separately=
; the
> end-to-end setup (item 2) needs an embedded trusted key and signed images=
, so
> it is harder to ship standalone. Neither is included here.
>
>  crypto/asymmetric_keys/verify_pefile.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db..4e84fcf 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -292,6 +292,11 @@ static int pefile_digest_pe_contents(const void *peb=
uf, unsigned int pelen,
>                 i =3D canon[loop];
>                 if (ctx->secs[i].raw_data_size =3D=3D 0)
>                         continue;
> +               if (ctx->secs[i].data_addr > pelen ||
> +                   ctx->secs[i].raw_data_size > pelen - ctx->secs[i].dat=
a_addr) {

Can we do this validation earlier? Perhaps in pefile_parse_binary()?
The idea is that if the data is malformed we should probably not start
hashing at all. You could also reuse chaddr() macro for the check.

> +                       kfree(canon);
> +                       return -ELIBBAD;
> +               }
>                 ret =3D crypto_shash_update(desc,
>                                           pebuf + ctx->secs[i].data_addr,
>                                           ctx->secs[i].raw_data_size);
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
> --
> 2.53.0
>
>

Ignat

