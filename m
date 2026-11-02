Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628B606A324
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NK8Pw/G5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YZHqs0S+0eF//NcnMf6waWSJNb6hMzfVqF5rDbvKzzE=; b=NK8Pw/G5nWm0he
	zPvqxG6nFP+BspkwLqMF5YGIHj+aXgwdw0B6Usmk7jXVOgXUU4QFVHIKcnpWqR9v6f3+USOLy1iRj
	Xu6KQB+qRF6e10HoQ6AV4VhfR+adZ1S8PdeMDwgu7/qzkKLOtfLig4ST4FlOd5L/y2j7+1oWQzcgG
	nvDcgody62z/CsiJskLs0zxJvnFNkejBy30msXw4qhkCvYRd3nVaaSpY489zVQGJ3ViLXBBb7E16F
	CBoykpD0Vam8inK8/KTW9MyMFEkKlBlmdmdQMjegFDaL93EaqPug5NVseSSEQNaL1ZbNFypaX7XLI
	Yn0cZGhWhrN+t8fp8XzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNyyp-00000000Pnc-2hBZ;
	Mon, 02 Nov 2026 20:50:11 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNyyn-00000000PmP-2ATD
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 20:50:10 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4682977f9aso424955866b.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 12:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652607; x=1794257407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZHqs0S+0eF//NcnMf6waWSJNb6hMzfVqF5rDbvKzzE=;
        b=vlEZVzktMlB3k1vcivqMJMCq3U6DAVi+EGWUO8PhvqTcvOU0VuSzqsBGUgx/v6kqQV
         XmcC7Vc3pAhea4ytbYrDrCyg3jRs54EJcG749+PaRcM8o9gwxWhMYj4IkR3AnBggf9ir
         X5crhgUfi4DxhNWFB+Mr4M58aTbL+dPhKHDoMUCqBLTapzAZSaYZ5PeYpO7kBOmkc4bz
         GmomwMynrIvjFH8RdDPKsgKJ1qZkwpr5Itjhv5g0s9vwDRr6XBuakvm2hGUnBzXUvsj9
         3jJZC/8lEF7J+gpS5/MGS2or0VQEmodizoU0h91oxhBBSJ1sCpL9IMcPaXiTaZ3MFDWn
         lfwA==
X-Forwarded-Encrypted: i=1; AKwUvBzz3VZxvrBAf5jNanxcfD0BRsfF4DW4RqF5pQ/LAxICg7m5aP95LYP+yN/LxUHOrkLueWUqwA==@lists.infradead.org
X-Gm-Message-State: APuU4Z80cwxA6DbxC2cV8/sfgxEmH/o59/w7p46r328THNgkszvTDV5d
	1cR87fqT0YR7+UZibL1+3jYbU0iSva2IuTq/hOeDnNmVrbVF7hg3zHVJMAMcF+qQHCo=
X-Gm-Gg: AYBFou1vQQfOqUNxvigu3BGUv7ZcuiSSUNVNObX9en8xDwL1ET7K4GRTJNupRKaQvtm
	sUzTQZTE4Cfo3uvrvVcz8xZ/x/1Kw5fUw+1epby9a1ZWVKOckTkYfhAY7hmsFUnBGgbENgLBEUr
	g+eYQIvhYW5n8/9oMoGmfn1uHKNdMnuiNojT3ZRbKAYmPb62h3g8VQLRIhrncR1jBdxoO4UclU4
	sBXNWhNcGRIOvEhF1aUThBDykqAkcP156z/p64deC9l3s7Oek7icb48t3qgcttgfp+XD5ECVudh
	zoBZpYUVqmeLl/suUy7CtsA0qDt6WmpI0yv9iCdw20L1L/HmZDhcV1SzMTDkVJ2r8JKOkuqlXl1
	L52IszCKlipcBKAOcPvX4kGTzrsug0ruq6tZAMoMSy8aE11EfObAMhyv598wPk6mBZwCJp8xKmA
	XfRroPDm80fOmdeFNK6Vjmzrf8R79VCMsyYZ6ThcRJ0Rg1fhjvBlzv8O/rrJPBKOBnS/pdriDuX
	Pg5IDaSHWI283vO8YE+SmauTAIwnAc0s2bP9MnvOFa/gCINFj3+pmJ3BSrmM+8AIyyfwh1vckiX
	G1PzdKLonZFhLRJR2akboT+wNjVnIVppg/cWZ1lcWsgaE5LTWH/jl0Wt95U=
X-Received: by 2002:a17:907:9341:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c4ca7a09978mr945535766b.17.1793652607138;
        Mon, 02 Nov 2026 12:50:07 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebefd219sm22630366b.40.2026.11.02.12.50.06
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 12:50:06 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40f29667e6so531311666b.0
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 12:50:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxtzZ2XGtkvDZ8W6tNV9kWMiGpaESwiMHd12rFfGipwqPPOmAh2c/ifXiFi2URoGOw+0W+nnw==@lists.infradead.org
X-Received: by 2002:a17:907:930d:b0:c46:9ee5:eeee with SMTP id
 a640c23a62f3a-c4ca79357a1mr947048866b.6.1793652606765; Mon, 02 Nov 2026
 12:50:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102074934.2925339-1-gubowen5@huawei.com>
In-Reply-To: <20261102074934.2925339-1-gubowen5@huawei.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Mon, 2 Nov 2026 20:49:55 +0000
X-Gmail-Original-Message-ID: <CAOs+rJWjCTUwuYQMcBcbiUk8K_NQQtYGVFEBDEMZAKHWCLv98A@mail.gmail.com>
X-Gm-Features: AclHuK9uKtGwMBZoHntdWHPm90lnYY-0KuyQanxDFP3TVplvFnPCOByhCba7eNE
Message-ID: <CAOs+rJWjCTUwuYQMcBcbiUk8K_NQQtYGVFEBDEMZAKHWCLv98A@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: asymmetric_keys: verify_pefile: fix integer
 underflow in pefile_strip_sig_wrapper
To: Gu Bowen <gubowen5@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_125009_575739_A817B6B1 
X-CRM114-Status: GOOD (  25.47  )
X-Spam-Score: -1.6 (-)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 7:32=E2=80=AFAM Gu Bowen <gubowen5@huawei.com> wrote=
:

nit: the subject line looks malformed: weird "-next" suffix pointing
nowhere. Otherwise:

> The pefile_strip_sig_wrapper() function validates the win_certificate
> wrapper that precedes the PKCS#7 signature in a PE binary.  It checks
> that the wrapper length does not exceed the certificate table size
> (``wrapper.length > ctx->sig_len``) but fails to verify that the
> wrapper length is at least ``sizeof(struct win_certificate)`` (8 bytes).
>
> When a crafted PE image supplies a wrapper with ``length`` in the range
> [1, 7], the subsequent arithmetic::
>
>     ctx->sig_len =3D wrapper.length;      /* e.g. 1 */
>     ctx->sig_offset +=3D sizeof(wrapper);
>     ctx->sig_len -=3D sizeof(wrapper);    /* 1 - 8 =3D 0xFFFFFFF9 (unsign=
ed) */
>
> underflows the unsigned ``ctx->sig_len`` to a value near UINT_MAX.  The
> following ``sig_len < 4`` sanity check is bypassed because 0xFFFFFFF9 is
> greater than 4.
>
> The underflowed ``sig_len`` is then passed to verify_pkcs7_signature()
> and onwards to asn1_ber_decoder().  The ASN.1 decoder's own
> ``datalen > 65535`` entry guard can be satisfied by constructing a
> PKCS#7 length field of exactly 65535 (e.g. ``30 82 ff fb``), allowing
> the decoder to proceed and attempt to read OID octets beyond the
> allocated vmalloc buffer, triggering a page fault in look_up_OID()::
>
>   BUG: unable to handle page fault for address: ffffd1e986cb2000
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:look_up_OID+0x14/0x100
>   Call Trace:
>    pkcs7_note_OID+0x33/0xa0
>    asn1_ber_decoder+0x363/0xbd0
>    pkcs7_parse_message+0xd9/0x1b0
>    verify_pkcs7_signature+0x24/0x80
>    verify_pefile_signature+0x7b/0xf0
>    kexec_kernel_verify_pe_sig+0x1b/0x40
>    kimage_file_alloc_init+0x1d8/0x3f0
>    __se_sys_kexec_file_load+0xc6/0x270
>
> This is reachable through the kexec_file_load syscall on architectures
> that verify PE signatures (x86 bzImage with
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG, arm64 Image with
> CONFIG_KEXEC_IMAGE_VERIFY_SIG), requiring CAP_SYS_BOOT.
>
> The oops occurs while the caller holds kexec_lock; if the faulting task
> is killed, the lock is never released, leaving all subsequent kexec and
> kdump operations permanently returning -EBUSY until reboot.
>
> Add a lower-bound check on wrapper.length before the subtraction to
> prevent the underflow.
>
> Fixes: 09dacbbda935 ("pefile: Strip the wrapper off of the cert data bloc=
k")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Reviewed-by: Ignat Korchagin <ignat@linux.win>

> ---
>  crypto/asymmetric_keys/verify_pefile.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index cec99db14129..cfa85ccb1cf7 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -146,6 +146,11 @@ static int pefile_strip_sig_wrapper(const void *pebu=
f,
>                         ctx->sig_len, wrapper.length);
>                 return -ELIBBAD;
>         }
> +       if (wrapper.length < sizeof(wrapper)) {
> +               pr_warn("Signature wrapper too small (%x < %zx)\n",
> +                       wrapper.length, sizeof(wrapper));
> +               return -ELIBBAD;
> +       }
>         if (wrapper.revision !=3D WIN_CERT_REVISION_2_0) {
>                 pr_warn("Signature is not revision 2.0\n");
>                 return -ENOTSUPP;
> --
> 2.43.0
>
>

