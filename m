Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9156DD216B2
	for <kexec@archiver.kernel.org>; Thu,  4 Dec 2025 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vXS4+o2Fq+EVRwWvGJTitCnGquHusQLvUPzYznKmUto=; b=HSXpnO9pnnxJMBMkfClpE2nY1o
	zRKZJE59aFVS+9jzcjIVz4y1slv3v3Ec7QtkH/qZjucYCSlDKqrhVjfTf+2KEtIP7V25cg8+H5vNc
	rP9WkUqHPc5C46BLkTE/3SQ5Wq3xi1YFdXcHbogEe9L64TYVf1FtDaQ7WqrhjRreeQXK478rFQuno
	rqCgipaITyBlOweBAtqFvGIa6jsjAzsvbUeMA0s1bKqdbcWWrekoWRStviS55NYm+7P9pLhSsYs1f
	dNj1FKZlB6fQAPbQkZ6MHpW8vuEYIqBWd7YC0yN3/NMPWEPhu8TBdSloOQpdWHR3xikDv8fVwwg7S
	6OePgcKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCO8-00000008IuE-34oz;
	Thu, 04 Dec 2025 16:41:04 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCO5-00000008ItY-2yl5
	for kexec@lists.infradead.org;
	Thu, 04 Dec 2025 16:41:03 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-42e2e5da5fcso825554f8f.0
        for <kexec@lists.infradead.org>; Thu, 04 Dec 2025 08:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764866460; x=1765471260; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXS4+o2Fq+EVRwWvGJTitCnGquHusQLvUPzYznKmUto=;
        b=ic/5gFR3WFl5G9gFXicV8/TPWMHL6I8MZGVHQlIXOuEkbm8obnsET5TUlTPrk8Iq1O
         aWzd5ZvuS3HS374XdtaIvzd9dgeR64xoBrswegBQXz7EwMYIU+PH6pFamrkKo2PqPMVJ
         0Xwl4jVRp8cwhLXFRwHOkkPpDohR/Mc6VdRW41WIq6vnq6bNqDcE0ObwopRv0T842Z1G
         ZS+RgoCBdeVy2hA/CL7muRY0kmiCVa99gLGvM0z6/aUHEq5w2MUySgIzfgDeTMyaJ/eA
         +sorWaQIY77qKx3m6wtroC9PKjlqq/kk7yxSx8ArNIdIy9UTv1JwslTe/UNEphvZdsrd
         9G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866460; x=1765471260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vXS4+o2Fq+EVRwWvGJTitCnGquHusQLvUPzYznKmUto=;
        b=nd5Z+jhUJZ/+sG1qDgw2IQk8gWYzIegiLVOGhirAEpHulrqD6BK+tjjbxzISv/StI8
         CnmJiVz3I3wX3OIAntbQY/naNPskegJeZP332D12gwE855d+lv8JtZywUVMUCuSZKBeP
         VHUAJeqkOf98D8ognM7RhA8g0WXBOqcB+cSHUg+7sx6tBwuAs2hHZk2NEm02tSDdshiR
         d4ryPvfrAbJD9YmdL0a7x5sWJd2jEiaU0YoxWUFfJK5uoUVow9vig75C7ejpgKKyEk1K
         cQp7h4LS42FzXwuxQot9XQgtrIzMeul472SPoiVwjYmpoDP1OklAkgAGuc8VnUYEKZ2R
         RoJA==
X-Forwarded-Encrypted: i=1; AJvYcCXYMrYdclBetEC60a8AJlTEIm8lh1PvDEVtZBhPpOaiaAifp/NIhoW0bnOVwJt3AuoXLDbICw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyvxkLsWg4Yd2Eh4WCgtJFRNAhDvEE1KlTqp2ae5CIM3ZErbCMj
	99kUIfwO89oWbJ1otpwnPe73Q39JR0d+eh8x+L7Kw5nhzoooapIlxE0g6WSI998OikkYKpQ7F4t
	lcGoqjbJPWklqaV/AjW6ml07nAXpruzM=
X-Gm-Gg: ASbGnct+x+cCRR9gbrfkY1EJeaanALCAIABeKx5v5SbSq8vdDVIXOhKxrfkxSQ7CoR/
	ibE+qS2606XYQym3DLudjN7fta4novK4qGiwMH/kU/EdfCREqkNJ/U4LFcmQuyfc1TipzRAw4ig
	Trh4zY0x5WbRGhS19Yl2nLrgK3WUCGI1a1wm77/vRRMJkb+yXOLQRI+i5wRy0srQjYYJy8mXTvL
	iwrR0/Qp/sHuiCzRGXGmHvQIfJrXv+Mykxxqi3JGmM4tJ2cctDFKSUCZGm21NNiU5wfvgtybP/S
	BwGHtKHvYH+2fkAkXBxQo2oiyTA3
X-Google-Smtp-Source: AGHT+IF14EPNbw0mdpWV5SBluMRzFazpxK6xkz22t/kSoBSDcMkFk+7hReZ/2u7DRvKtxZQ8Xd9AGL3Y1VECoWoltus=
X-Received: by 2002:a05:6000:4212:b0:42b:3dfb:645f with SMTP id
 ffacd0b85a97d-42f79858038mr3500253f8f.47.1764866459724; Thu, 04 Dec 2025
 08:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20251128033320.1349620-1-bhe@redhat.com> <20251128033320.1349620-13-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-13-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Dec 2025 17:40:48 +0100
X-Gm-Features: AWmQ_bmxfZbuU8zhqgeyaLqAy9mjVXVUUmOMRc0g7rdfnIXPuRMuopEGEYYo_ps
Message-ID: <CA+fCnZfw5V4HqHepJUbH5cFSEj1G4yvJMb=1Tjd_7WDBP7uUfQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] mm/kasan: make kasan=on|off take effect for all
 three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_084101_766496_AC44734C 
X-CRM114-Status: GOOD (  19.39  )
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

On Fri, Nov 28, 2025 at 4:35=E2=80=AFAM 'Baoquan He' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Now everything is ready, set kasan=3Doff can disable kasan for all
> three modes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kasan-enabled.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.=
h
> index b05ec6329fbe..b33c92cc6bd8 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -4,6 +4,7 @@
>
>  #include <linux/static_key.h>
>
> +#ifdef CONFIG_KASAN
>  extern bool kasan_arg_disabled;
>
>  /*
> @@ -12,7 +13,6 @@ extern bool kasan_arg_disabled;
>   */
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>
> -#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)

So do we still need CONFIG_ARCH_DEFER_KASAN? If not, it needs to be removed=
.

But if we only allow kasan=3Doff for x86/arm64 after all (see my comment
to the cover letter), I believe we need to keep it.


>  /*
>   * Runtime control for shadow memory initialization or HW_TAGS mode.
>   * Uses static key for architectures that need deferred KASAN or HW_TAGS=
.
> @@ -30,7 +30,7 @@ static inline void kasan_enable(void)
>  /* For architectures that can enable KASAN early, use compile-time check=
. */
>  static __always_inline bool kasan_enabled(void)
>  {
> -       return IS_ENABLED(CONFIG_KASAN);
> +       return false;
>  }
>
>  static inline void kasan_enable(void) {}
> --
> 2.41.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev=
/20251128033320.1349620-13-bhe%40redhat.com.

