Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9EAC61DBE
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ffOGWLkNU0B5wefleM0f4kOcS8WHnfV6s3VJ7x4ll4=; b=Hq0y5Xh80SQc47yt3oHLjTKpb/
	V0NpZFUVj+BPI4JCtWOwwHpfSbhI0AZr3n+76e4+RRskB0+lQmo9jXkroT5OXDwEbdARushioVCRA
	TVc+obLKdYJH1OMn8BneIHw5t7bNBCwibcXLU+fKa2zrP+DpfZGbR7KLRPKCA33teju1qRFUu/vwz
	Y35rx4/0cADUCFTnjgqlLsRimy5D4Cz9veByRQuGVyAVKae33aJiMiub+vzblW4ohHtSA36R1u9Nd
	Wj6YrUw/1Hj1p24CrcV9OmTWfhqnBiIo1uwi/rL1gVzLXT0I1EqgebWImGnNbl+P01draPeS4wEQA
	Xm5mj8rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzJeQ-00000002x4f-163q;
	Wed, 26 Aug 2026 19:51:10 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzJeO-00000002x4C-2AQC
	for kexec@lists.infradead.org;
	Wed, 26 Aug 2026 19:51:09 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso2265857a12.3
        for <kexec@lists.infradead.org>; Wed, 26 Aug 2026 12:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787773865; x=1788378665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ffOGWLkNU0B5wefleM0f4kOcS8WHnfV6s3VJ7x4ll4=;
        b=cx2Lpvrt7cxXAATlEbKFP8z1fMvRMbPjudgT4EBa/weA6dXD52JP8rRSLgMR/6QRAb
         pz6o+1X/Tj3yDwrYOZ2b8sbRs1eoujs6+/LPRVUv11rQ0oJ94rrqObHO8dx4H+wVLXug
         dwA9jAIJLRlLTbK8UG74ZFPoVFjHsWha2ojd+eZtB1OlEHpMr/3zb7NEJA4etp0QWklL
         AKpDOPxkfP6YZG3x2UAgj0N7YoR0KDgh7GQ+KDYbWyQxDPqu0HQ+FNRq+jmWfSkFX6/4
         cVA31vho89eYDmn99dFjrY76vjTRn/cQHuzeaqGQiSwUsirwiahTJRfBz1ka+jVwKPTj
         4rYw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+7dpkqXBD5QNS02TyR1V9DWqIDmy6kk2QcjInsTr+L+D66KZd/APx88Eu5GwhLDFwph+L0Q==@lists.infradead.org
X-Gm-Message-State: AFuF++kUabMY20TVTVW4+sBd58NbEh//Pb+4UO3EXLuxLMk4d5RrDQMb
	dvNtSyjlPu1h80cZ8ln44FqT97Zf+VQ8qwARNNlfsel3DJObCdCGeodor127wn3TBjI=
X-Gm-Gg: AR+sD12v5Hxc5JEqR1gxTIZrpvjShw9yUZ4rzxBwTfQ4lV2N00DYCZ+MQ0XOjxPOTBi
	dHqDExEUAo2mKJlSwp15J58S1Q0CfVmYlnNVK+cZTq14BZ+5Lrqx5hGxVRPsQH7VgsW9sHRgm0W
	4MP2UiN/zCkYWlHgJ2p1GHcJoEwn7zxajhwr4hhLkOhqVq4TTqCQ+7DwoVpmJjtzdnGlhc1A17/
	fu/jVzs+oSszZWdjJgx34Be1a2pxsRxPF1LfYiLoURJC3uHv1yH5bhN/m7YiYWEoPOBwj+FKAGW
	D735Q+o3q/EQCUzA0M2N2IjlXxjcGVMEX8b9vUmECoS/30Wdw/uQSBAvImHxqM7dMZllngBnhGs
	yLFn1ZpxTEvG5sWEhLUe176EEL/qgkt2SOGlZbDTsN2hw41gQHTZFuZuyvhYEhUl2JGDTyQLo17
	hIcJoFB8BvYI6+KjsARdyoc8eIMHbTwU+zVhb5LF1EFCpoEkTq67HR+V/UjwM50m2WxnW1xh1b/
	YaTLf2pQLn/4bRkNJmvKvlH1vzdTw==
X-Received: by 2002:a17:907:1807:b0:c1c:5aa1:de57 with SMTP id a640c23a62f3a-c250c307d84mr1411328966b.13.1787773865304;
        Wed, 26 Aug 2026 12:51:05 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2533945d0esm130171966b.9.2026.08.26.12.51.03
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 12:51:03 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2055573c8cso204967866b.3
        for <kexec@lists.infradead.org>; Wed, 26 Aug 2026 12:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RokfFbpNO9S9mvMqY2ycLW3ifhpBxIjY/XLEG7KfwhMfRrPx70OyOy1ZQWIa8aVgXbJOUZmJg==@lists.infradead.org
X-Received: by 2002:a17:906:9fce:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c250bb50762mr1103314466b.1.1787773863104; Wed, 26 Aug 2026
 12:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAOs+rJW1QymCXkr8-mU4kwMFvznnC98CXVvZMRjqpXwjJutdtA@mail.gmail.com>
 <20260815114533.2171445-1-fabrice.derepas@canonical.com>
In-Reply-To: <20260815114533.2171445-1-fabrice.derepas@canonical.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Wed, 26 Aug 2026 20:50:49 +0100
X-Gmail-Original-Message-ID: <CAOs+rJVggeq-Y4hysPRtpV0pQRBU8cZTm-iyQ4EpHM6-6eapkA@mail.gmail.com>
X-Gm-Features: AcwNN1W5DIcNWEcvlctI_OYJ194qPghIiHh-JbFunx3timWYfG5krkQObSF_4k4
Message-ID: <CAOs+rJVggeq-Y4hysPRtpV0pQRBU8cZTm-iyQ4EpHM6-6eapkA@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: asymmetric_keys - bound PE section ranges in pefile_parse_binary
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_125108_574214_1532FD6F 
X-CRM114-Status: GOOD (  31.71  )
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

Sorry for delay on this,

On Sat, Aug 15, 2026 at 12:45=E2=80=AFPM Fabrice Derepas
<fabrice.derepas@canonical.com> wrote:
>
> On Fri, Aug 14, 2026 at 11:29 PM Ignat Korchagin <ignat@linux.win> wrote:
> > > Tested under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case t=
hat
> > > calls verify_pefile_signature() on real images: a signed-then-tampere=
d
> >
> > Same as your other patch - any reason not to include this KUnit case?
>
> The reason I am not including my tests is that I use real signed EFI
> binaries (a valid one and a tampered one), ~88 KB each via xxd -i, which =
is
> a lot of binary to carry in-tree. For upstream I'll write a self-containe=
d
> case that constructs a minimal PE in the test itself and asserts that
> pefile_parse_binary() rejects an out-of-range section, so there are no
> embedded blobs. I'll send it as a second patch in a v3 series, so the fix
> is not gated on the test.
>
> > > +       for (loop =3D 0; loop < ctx->n_sections; loop++)
> >
> > Looking at the code again: seems ctx->n_sections is user-controlled.
> > What happens if it is 0?
>
> For this loop, nothing: n_sections is unsigned, so "loop < 0" is false on
> the first test and the body never runs -- no chkaddr() call and no
> ctx->secs[] dereference. So the patch itself adds no hazard for
> n_sections =3D=3D 0.
>
> But you have pointed at a real pre-existing problem one step further on.
> n_sections =3D=3D 0 is not rejected anywhere -- pefile_parse_binary() onl=
y
> bounds it from above, against header_size -- and pefile_digest_pe_content=
s()
> then does:
>
>         canon =3D kcalloc(ctx->n_sections, sizeof(unsigned), GFP_KERNEL);
>         if (!canon)
>                 return -ENOMEM;
>         ...
>         canon[0] =3D 0;
>
> kcalloc(0, ...) returns ZERO_SIZE_PTR, which is non-NULL, so the !canon
> check passes and the unconditional "canon[0] =3D 0" writes through
> ZERO_SIZE_PTR. Because the digest runs only after verify_pkcs7_signature(=
)
> succeeds, this has the same reachability as the read this patch fixes: a
> validly signed image with n_sections tampered to 0 (the PKCS#7 is
> unaffected) reaches it via kexec_file_load().
>
> I confirmed it under KASAN. With a trusted key embedded, a signed image
> whose NumberOfSections I set to 0 (leaving the certificate table untouche=
d,
> so verify_pkcs7_signature() still returns 0) faults in the digest step,
> while the untampered image verifies:
>
>   control (trusted, 7 sections): verify_pefile_signature() =3D 0
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   #PF: supervisor write access in kernel mode
>   Oops: 0002 [#1] SMP KASAN NOPTI
>   RIP: 0010:verify_pefile_signature+0x5c3   (pefile_digest_pe_contents in=
lined)
>
> Address 0x10 is ZERO_SIZE_PTR and error_code 0x2 is a write -- the
> canon[0] =3D 0 store -- so it is a write fault, reachable the same way as=
 the
> out-of-bounds read this patch already addresses.
>
> Since we are now centralising section-table sanity in pefile_parse_binary=
(),
> the natural fix is to reject n_sections =3D=3D 0 there as well, e.g. by f=
olding
> it into the existing bound:
>
>         if (ctx->n_sections =3D=3D 0 ||
>             ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
>                 return -ELIBBAD;
>
> A PE with zero sections is malformed (a signed kernel/EFI image always ha=
s
> at least one), so rejecting it at parse is safe and closes the
> ZERO_SIZE_PTR write too. I will include that in v3 and cover it in the KU=
nit
> case.
>
> Do you prefer it folded into this patch, or kept as a separate fix for th=
e

Let's fold into this patch, since it is one place now.

> canon[0] write? Either way I will respin as v3 with the KUnit case once y=
ou
> let me know.

Thank you.

>
> Thanks for the careful review, Ignat.
>
> Fabrice
>

