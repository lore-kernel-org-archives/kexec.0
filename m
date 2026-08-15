Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED45AC5CFC1
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2xCf7NNzqXlGxdkctmUtmNccZAJf+QJ9HiKn7Wp1+x0=; b=mzSB1cBQE2cO7tSPbGPqjpR8zK
	m8hfoftOZKtzIz8VbposeJXJ31FWiSNIJvqTt9y9BrCbTV/d7wSM2pA6bnW2+RzcB60I0tMUaDimA
	qW+4U8oVXXbK0pWfvIQAeayYG1ewvTKDAPC6Yx/QvEy251SIQjn/nKe/BndOQ6j/TzlpJl8/KNY2d
	fkNQl5cDNQZTMbscXcopjquz8q7RHYVJ5HxfDEUmnVOAkZFoM4W0xhRMkuLTA916rvB2dxr+fTeyW
	M0A3hDD6PixGLI3m0w1RwUehjocW0SkI9D244nApuSouQ/ceKpZUXPNppmiA7LL1cL9ZYtKwRorOO
	3ZF/5xDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvCpp-00000003nEn-0Gom;
	Sat, 15 Aug 2026 11:45:57 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvCpl-00000003nEP-24If
	for kexec@lists.infradead.org;
	Sat, 15 Aug 2026 11:45:55 +0000
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F1443F1C0
	for <kexec@lists.infradead.org>; Sat, 15 Aug 2026 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786794350;
	bh=2xCf7NNzqXlGxdkctmUtmNccZAJf+QJ9HiKn7Wp1+x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=mdUhpf7yF9cAAHHeDm2FN9mKgIq84AMcfLQoHSqNsOx+wg4FQxsbAtKlh+CrmTdEh
	 qSbRjOn/iqtn0RLn8oG6YpaoRCneLU41OyYyIgLIEU6BJM4OdmZvbsth9FJVtidovR
	 2GzVfYYmZNVFJjmLYstUGHZSfnQ/ePXSWp0iThhpwywHYa/M8NQLvSyeNLam8yUpng
	 L4IcIhnInDAVSSNX4UtaLCB/fdtHFZlBWYfMnaqWCamT6ynkyiwmR7HBMzVtdtzV9r
	 3ssBvF3ln+3WX1YzhJ2zSH8iJTf/Hxao2mcmYR12jx8/VS3QLjjdLbqZbk2Xle/iqa
	 KDL76LCZosMWWeVb/Vrwkz7nZ2zU9N5+9l49V1+2FNlObndDAMMklRqMZz5HlcPw/7
	 ttCgnXONUuPe7rrZ8WdnRt1cyq/4J4L0wmUvPJOlu2lmZ+D+fOvM4oIOyjmSv43lNw
	 6fdFrJFKrl6CuOS10gP4pPWgNw4pNXP8JXLI3EaE6we0oOaazUiJEaOfPgnfC6hQP7
	 W61adUopjmn5QasAp5YXevykxE7ScS6dozI1f7HhVaQin8fJ4D5kcYk/GHWAXVBMWR
	 l7tvgrnWuI14sZ4gtfmwkMi5MJp+PmaiAXR7GD+mtrQByf1ER7qZZL2RzDu/eRMl7U
	 34YQ4LtQdyuAV7lXAVMjHqaE=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so1460761f8f.2
        for <kexec@lists.infradead.org>; Sat, 15 Aug 2026 04:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786794350; x=1787399150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2xCf7NNzqXlGxdkctmUtmNccZAJf+QJ9HiKn7Wp1+x0=;
        b=WEo/nYy/b+P2Uk5u4nRDPftQoq2xNItznfa2TPmw3FSJG/glI6dGVcLYEpUvh+A26w
         SgwGfMtXtjFSYed63YuwsvO0ZFwcTpireRn9QYdu8NzpHds+WcFMhYfKTcXVlAitdNZa
         Ej0XTHmuN827dDdESifMXytLeGwFZ7WmNxALL/Af6Li2vwqRPVxgrR4cO7DEjGkyk3TL
         inOEJLBW99OsTkugcCAIPUmaKERH3PJrDubtY9LFcxx8ESTAYQTeyk4HSu29z0mptEWY
         9UZhUVrGCZuKBqIxgUku8QJZqmFXx3Rrq753GtM3X01ScJc/3k+GWtiSVGQYiqUqpAJo
         HY+g==
X-Forwarded-Encrypted: i=1; AHgh+RqrEme4aAvcaRZya36qpTJ0G4lf9M/jYifsadP9VkDNOFTQ5kP7qe2EbPF3Sth7Chw6XpnFNQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxblwYHQwn0Xhihj71X9XtXG6Y2visIcvP6rJ1m4dgnefP3kX3T
	Qdo1lWK6+TYiOzmeIEJ5EViBWbquA8w5ReDawuVdhZTHmlVwKDgLnLr82yX0vuiw5VkLoyD7wrT
	Kj510RsKf0zveCjH8etLkaBo2kRt7w73eCkdB98iVND9fEAiF5E5Phsk5YfK9uXm1qX1ru1I52Z
	fVzw==
X-Gm-Gg: AR+sD10BIP/8kav82W3gSATyUwAeqxBP1JlQcdJ85hOd5qGPrGpro6ZyRzWAbAXTKHJ
	8xmWEhVRsK8im7/OcGe+iFD3WR8HOtnxjxXiUpSnUK9hmafnfIzXkJy7DP1k2CnUh1N5VX7PDxV
	MYcv/rmRz0ihMac1hRtDG15nT8vueTsD4Cr0ydY8W+uo8gws5iJUSihW5j34D9742+Caf/g3oP8
	HA+twGZwiVWIhIGACOzEs/1a3C5dnpoNW5ftPqvvWrapTYga5WQXzG7fsSlV7wP/B20NPl1PZeq
	0AYBWRcuwux5RBh74XvJe4lSMmvQ5wfj1GFlZwgircj6ZF35cDE6R9FIAuEVm0sHRbPyJzthLC9
	05tbwbjnxKQDJmKNNXrlTXb/yJSWb3SrrKOAh04AOO3sfTFNvvyP58Lb2YtWeiS7e5AdSYLnaF4
	/CLqtEqIfxJjsBkQFfnT+uDnUDA1mdegs=
X-Received: by 2002:a05:6000:3105:b0:481:60fc:edd0 with SMTP id ffacd0b85a97d-48160fcf090mr16008101f8f.8.1786794349911;
        Sat, 15 Aug 2026 04:45:49 -0700 (PDT)
X-Received: by 2002:a05:6000:3105:b0:481:60fc:edd0 with SMTP id ffacd0b85a97d-48160fcf090mr16008041f8f.8.1786794349117;
        Sat, 15 Aug 2026 04:45:49 -0700 (PDT)
Received: from t-14.home (2a01cb000883230031a3fd8213e7cff4.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:31a3:fd82:13e7:cff4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b13c3sm13090884f8f.19.2026.08.15.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:45:48 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: Ignat Korchagin <ignat@linux.win>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: asymmetric_keys - bound PE section ranges in pefile_parse_binary
Date: Sat, 15 Aug 2026 13:45:30 +0200
Message-ID: <20260815114533.2171445-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOs+rJW1QymCXkr8-mU4kwMFvznnC98CXVvZMRjqpXwjJutdtA@mail.gmail.com>
References: <CAOs+rJW1QymCXkr8-mU4kwMFvznnC98CXVvZMRjqpXwjJutdtA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_044554_005124_5819F869 
X-CRM114-Status: GOOD (  22.24  )
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

On Fri, Aug 14, 2026 at 11:29 PM Ignat Korchagin <ignat@linux.win> wrote:
> > Tested under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case that
> > calls verify_pefile_signature() on real images: a signed-then-tampered
>
> Same as your other patch - any reason not to include this KUnit case?

The reason I am not including my tests is that I use real signed EFI
binaries (a valid one and a tampered one), ~88 KB each via xxd -i, which is
a lot of binary to carry in-tree. For upstream I'll write a self-contained
case that constructs a minimal PE in the test itself and asserts that
pefile_parse_binary() rejects an out-of-range section, so there are no
embedded blobs. I'll send it as a second patch in a v3 series, so the fix
is not gated on the test.

> > +       for (loop = 0; loop < ctx->n_sections; loop++)
>
> Looking at the code again: seems ctx->n_sections is user-controlled.
> What happens if it is 0?

For this loop, nothing: n_sections is unsigned, so "loop < 0" is false on
the first test and the body never runs -- no chkaddr() call and no
ctx->secs[] dereference. So the patch itself adds no hazard for
n_sections == 0.

But you have pointed at a real pre-existing problem one step further on.
n_sections == 0 is not rejected anywhere -- pefile_parse_binary() only
bounds it from above, against header_size -- and pefile_digest_pe_contents()
then does:

	canon = kcalloc(ctx->n_sections, sizeof(unsigned), GFP_KERNEL);
	if (!canon)
		return -ENOMEM;
	...
	canon[0] = 0;

kcalloc(0, ...) returns ZERO_SIZE_PTR, which is non-NULL, so the !canon
check passes and the unconditional "canon[0] = 0" writes through
ZERO_SIZE_PTR. Because the digest runs only after verify_pkcs7_signature()
succeeds, this has the same reachability as the read this patch fixes: a
validly signed image with n_sections tampered to 0 (the PKCS#7 is
unaffected) reaches it via kexec_file_load().

I confirmed it under KASAN. With a trusted key embedded, a signed image
whose NumberOfSections I set to 0 (leaving the certificate table untouched,
so verify_pkcs7_signature() still returns 0) faults in the digest step,
while the untampered image verifies:

  control (trusted, 7 sections): verify_pefile_signature() = 0
  BUG: kernel NULL pointer dereference, address: 0000000000000010
  #PF: supervisor write access in kernel mode
  Oops: 0002 [#1] SMP KASAN NOPTI
  RIP: 0010:verify_pefile_signature+0x5c3   (pefile_digest_pe_contents inlined)

Address 0x10 is ZERO_SIZE_PTR and error_code 0x2 is a write -- the
canon[0] = 0 store -- so it is a write fault, reachable the same way as the
out-of-bounds read this patch already addresses.

Since we are now centralising section-table sanity in pefile_parse_binary(),
the natural fix is to reject n_sections == 0 there as well, e.g. by folding
it into the existing bound:

	if (ctx->n_sections == 0 ||
	    ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
		return -ELIBBAD;

A PE with zero sections is malformed (a signed kernel/EFI image always has
at least one), so rejecting it at parse is safe and closes the
ZERO_SIZE_PTR write too. I will include that in v3 and cover it in the KUnit
case.

Do you prefer it folded into this patch, or kept as a separate fix for the
canon[0] write? Either way I will respin as v3 with the KUnit case once you
let me know.

Thanks for the careful review, Ignat.

Fabrice

