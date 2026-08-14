Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C0DC5CFC1
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 22:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=waG0BdNRrEs0bEN8xb/gjEyGJq6U6CRZNm5O6yGz0BQ=; b=z/Fi/EjDrPur38VQOh6FbLfOD5
	EFWShZJoS4K08US7YKNned0ru7CLq2uA+iPcCBE4W8QjZvTmB2svEsbVnd4zWQWKdp8hjVjp3dbZe
	+SQexr7facWXs2kvLEiE1juvFzqKyeQkH//rUauRo5iEM2VWNutYn+7PNDpQrjip4y8cf2ioEbvSI
	9aij4v7IfbDBr2l3uY9hTYfvrOaS0t04HC8OsUM5gMyJJsDBsbt4ycynV5BfQuUPKsrDmUZleLUkH
	9QaIayvIlRkZvyOved+K5U/V5B3g3lV7OgXSDV4j7JxUEQ0VcjNWFzZRGJyNgaO80XSfdH2ROTmlj
	dndU2SEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0PS-00000003GqF-2A2v;
	Fri, 14 Aug 2026 22:29:54 +0000
Received: from mail-ej1-f43.google.com ([209.85.218.43])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0PP-00000003Gpq-47qI
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 22:29:53 +0000
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c197e7e4e94so275416166b.2
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 15:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746590; x=1787351390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=waG0BdNRrEs0bEN8xb/gjEyGJq6U6CRZNm5O6yGz0BQ=;
        b=krvpdM3W+HZp5BS7GhqnTRZssi1Ge4W9/q+fSIFxvPAtb5TftfqfKv+canIS0NnmdC
         DhLbwVA4RdzIjCPBAnF1ztuCgGAzF++1JsRKyVpxJTDIm9CZltf9SCQ4Yd25hvHbqjIt
         1rP78UySH6ERhB3W0+JZEMks9tzmBpHldjX1KbKBHLFaZOWN2YMcBVaypGHi7wqgiYFK
         1djcXqgBBq+bnrt5P/uEA+01lFbBpVPtXvlyo7kqF801rkXUELGtex7V+WcZW559cPzQ
         0zH/XR4Egtctx7WZ2Bsv5rPvExckOpvOnJ29rD4fa53jJHwHeRK6/1N1JfQpBa5Dv6aI
         avSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcFkzeWpKTy9BvVOBRWbUq/Tn0SgVhZE8rrOel1FLFxssInLj2+ITudBl5x/KQHf/o1sHpZA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxQ6djQwSE2P7zonQ61HHNr8owna5Ehu0SzW1TpaVm4he4KxlD2
	KnUXhNycx77AuCUOpldU7VWrCQkyfIleHFj8+qhCGVnrmOY8G1ZCq4Vu1P4VBWiqdak=
X-Gm-Gg: AR+sD132hXSy3pzfj8hTYC/VPAZ2d+TiAj0pt6DHyAe5QsyaDBFgS0xkvmAAQWH1JVH
	HhygEuirnD4YNOIF4EdDBtz5j0cw+K9a4h4u0lNCXryXbqCfsDe+rnRDok+MRwcUyGwxYJwxOLX
	z5ugaEdH+MTmuLqUo9B8yJU+r5dDZQyeqw0mzdSFN2f4S2pmaILoTyv1SP8pcMrOCCOQ4EsgXmt
	G9lmmug5VbUNXHNb4VHCavFdarThXIEw0MMfMVhGiUoV4mz5ZT3JS/bKBGZJLxNqzoN476QeYi0
	u/yPPdlh+/ICM/tqhckX97/mhTzzfWDE/dOdCbOE0Cnq4mUCwos0K13yYK3yAZ3e7l1x8PIgHgz
	ftVWOZqfoGf+0LRlvblTWzM3crV2EVeiQ0HZktwIyLCGdOg9CwQjE4mMMRWyTVU3kf+0AcPyp6/
	Y1GmvacAcsxXkBTNfi547HCwKIxEq0nPqzgxkrJxDOlZ/fMHm4ve572Vqn3FPTTwX16Rcv9UwD4
	yx4cSSbNalpLb8+5ZI=
X-Received: by 2002:a17:907:ea8c:b0:c20:7557:d986 with SMTP id a640c23a62f3a-c212a16486emr422890366b.13.1786746589719;
        Fri, 14 Aug 2026 15:29:49 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38c9ea8b6sm1287577a12.11.2026.08.14.15.29.46
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 15:29:46 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15e592da74so213314966b.1
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 15:29:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrlbmYQHtzlzeF5XDD0332OAfI6dIE5T1wj6iKvlwEOZAd1LIr1X5hcdsTHsn1qAPHBbtU2iw==@lists.infradead.org
X-Received: by 2002:a17:907:d1b:b0:c20:3402:bd35 with SMTP id
 a640c23a62f3a-c212a15b29bmr481986966b.12.1786746585644; Fri, 14 Aug 2026
 15:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOs+rJXZ++7_o4L6LuT567FjdYsa=6NEki3qcFSRX+ehJxpoVg@mail.gmail.com>
 <20260814220631.1101496-1-fabrice.derepas@canonical.com>
In-Reply-To: <20260814220631.1101496-1-fabrice.derepas@canonical.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 14 Aug 2026 23:29:33 +0100
X-Gmail-Original-Message-ID: <CAOs+rJW1QymCXkr8-mU4kwMFvznnC98CXVvZMRjqpXwjJutdtA@mail.gmail.com>
X-Gm-Features: AcwNN1Xw9h6GNj0ibMyw5rWypoAatSz6xjvorf8gf94rjiZOoVeFiOOzG0DX_sA
Message-ID: <CAOs+rJW1QymCXkr8-mU4kwMFvznnC98CXVvZMRjqpXwjJutdtA@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: asymmetric_keys - bound PE section ranges in pefile_parse_binary
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_152952_052091_D4C5EE23 
X-CRM114-Status: GOOD (  30.71  )
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

On Fri, Aug 14, 2026 at 11:06=E2=80=AFPM Fabrice Derepas
<fabrice.derepas@canonical.com> wrote:
>
> pefile_digest_pe_contents() hashes each PE section with
>
>         crypto_shash_update(desc, pebuf + ctx->secs[i].data_addr,
>                             ctx->secs[i].raw_data_size);
>
> where both data_addr and raw_data_size come straight from the untrusted P=
E
> section table. pefile_parse_binary() bounds the section table's location
> but not the sections' data ranges, and nothing else on the path checks
> them. A section with data_addr and/or raw_data_size pointing outside the
> image therefore reads past the pelen-byte buffer (CWE-125); a large
> raw_data_size makes it read far past the end and fault.
>
> Commit f7dd32c5179d ("crypto: asymmetric_keys - fix OOB read in
> pefile_digest_pe_contents") recently fixed a sibling underflow in this sa=
me
> function (the hashed_bytes + certs_size trailer computation); the
> per-section read was left unchecked.
>
> The digest loop runs only after verify_pkcs7_signature() succeeds, so it
> requires a validly signed image -- but not an attacker signing key. The
> PKCS#7 signature covers the SpcIndirectDataContent (a self-contained dige=
st
> in the certificate table), not the live section bytes, so tampering
> data_addr in a publicly available signed image leaves the signature valid
> at that step while the out-of-bounds read fires when the digest is
> recomputed. It is thus reachable by a local CAP_SYS_BOOT user via
> kexec_file_load() with a tampered signed image; the access is an
> out-of-bounds read only, but a large raw_data_size faults, which is a
> denial of service when panic_on_oops is set.
>
> Validate each section's data range against the image when the section
> table is parsed, reusing the existing chkaddr() bounds macro. A malformed
> range is rejected with -ELIBBAD at parse time -- before signature
> verification and before any hashing -- so a bad image is never digested.
>
> Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKC=
S#7 data")
> Assisted-by: copilot-cli:claude-opus-4-6 frama-c
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
> v2:
>   - move the check into pefile_parse_binary() and reuse chkaddr(), per
>     Ignat Korchagin's review [1], so a malformed image is rejected at par=
se
>     time -- before signature verification and before hashing. v1 put the
>     check in the pefile_digest_pe_contents() section loop.
>   - because chkaddr() runs on every section, v2 also validates zero-size
>     (raw_data_size =3D=3D 0) sections, which v1 and the shipping digest l=
oop
>     skip. This only rejects a zero-size section whose data_addr points pa=
st
>     the image -- malformed input that real PEs never produce (.bss uses
>     PointerToRawData =3D 0, which passes) -- and matches the "don't start=
 on
>     malformed data" intent.
>
> [1] https://lore.kernel.org/all/CAOs+rJXZ++7_o4L6LuT567FjdYsa=3D6NEki3qcF=
SRX+ehJxpoVg@mail.gmail.com/
>
> Tested under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case that
> calls verify_pefile_signature() on real images: a signed-then-tampered

Same as your other patch - any reason not to include this KUnit case?

> image (a section's data_addr set to pelen) is now rejected with -ELIBBAD =
in
> pefile_parse_binary(), before verify_pkcs7_signature() and with no KASAN
> splat, while an untampered signed image passes parse and reaches the
> signature check (-ENOKEY, as the test key is not trusted in this build).
> v1's KASAN repro -- a crafted context taken straight into the digest loop=
 --
> showed the slab-out-of-bounds this prevents.
>
>  crypto/asymmetric_keys/verify_pefile.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db14..c447597f7 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -30,6 +30,7 @@ static int pefile_parse_binary(const void *pebuf, unsig=
ned int pelen,
>         const struct data_dirent *dde;
>         const struct section_header *sec;
>         size_t cursor, datalen =3D pelen;
> +       unsigned int loop;
>
>         kenter("");
>
> @@ -112,6 +113,14 @@ static int pefile_parse_binary(const void *pebuf, un=
signed int pelen,
>                 return -ELIBBAD;
>         ctx->secs =3D pebuf + cursor;
>
> +       /* pefile_digest_pe_contents() hashes each section's raw data usi=
ng
> +        * these fields directly; reject a section whose data range falls
> +        * outside the image so hashing never reads past the buffer.
> +        */
> +       for (loop =3D 0; loop < ctx->n_sections; loop++)

Looking at the code again: seems ctx->n_sections is user-controlled.
What happens if it is 0?

> +               chkaddr(0, ctx->secs[loop].data_addr,
> +                       ctx->secs[loop].raw_data_size);
> +
>         return 0;
>  }
>
>
> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> --
> 2.53.0
>
>

Ignat

