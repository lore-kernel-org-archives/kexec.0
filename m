Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC56AD6CFA2
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LbjBnPVhpRbR+iDPKNRkBtw2lZYOaBG/Duh0jODc6ZA=; b=09nm8IWeLDXjrEjNXpgYtCIcyB
	3vAf+f3k3BmnEqu3y5ZajefN3LF0JI8mLR30WBQt+CejUx//GnLD7cN/cJxd1klf8DowZbLKdJxWT
	TWAOI+w8nBjQ9VXlQ67Mj3NzYJ/jeP3eM+bkydRvM8Rpd5ld/OK1696CQ/X8pnQpjuYhSqEJxkSfs
	PQCDX7xqate4EYmZpgbTRH2BC77KeTagr3p0Y25oJ6dbztH0EhLUNJ62xHfCKo1HkA7K7elZz1yl6
	UIcqoOU7Wjxu1c/1juZGVcHBhU76disJdgOgUHEXDe9feKYBXU6zUtxM5LVUmdzTNMrFQDXtJQ4lp
	fRIrdsYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viz7x-00000007c0H-1oAc;
	Thu, 22 Jan 2026 18:09:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viz7s-00000007c0A-32u7
	for kexec@bombadil.infradead.org;
	Thu, 22 Jan 2026 18:09:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LbjBnPVhpRbR+iDPKNRkBtw2lZYOaBG/Duh0jODc6ZA=; b=VZi17Ct5F3h2aLFVeO31wQt8Fd
	sqKFOiKMEMCDJE5bZE3dr8ygracOP4rfow1cWOf0QMdeL0XlPrwFfim+V2wy3cBwZla3/xoJWN7U3
	O4X48SdRyhsaUgH/ETKaJC/X6uWJM8rYE+EoDO/AobTroWuris5LFcim7DJu1pUPrNrqNwxxX0qFf
	PbWwtvM3pUpAq3dNQFLk6zuqcebacGnlTuQiHKQMW1gYgW55dcT0kUGCF9lJRMU+nJ0yG6uPEK759
	jrq3/TnCZ82/y6EBBuEl3iRg5YKFETqejd1VMhh2A0LFBhVU5oxi8Uo0RXxvaIE/202JNOzPJ+NJK
	Q8WiaSWw==;
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viz7p-000000011LR-09VH
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:09:47 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-65832eb9723so2465890a12.1
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:09:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105383; cv=none;
        d=google.com; s=arc-20240605;
        b=bmpop04LOCtSDqOqoY9X3B9cDi5DPUD2F0j4O80ylLKkWbgHzNfawajqm3IG4fMiGr
         2QH9fBZ4X17yMjEa91uEgVZ7OSwNOKhnyebo+YmvcjVhAAT07hkz+xpV4U3ZcKVdMCfG
         cB7MHb1u4T+9Ja6Eb8yIGyJX2t76CmslRZgsDKdm8UXzi5aV1avJwYMvOwXUne/fh18G
         VRdRgSTq7bzZMH2cRkS3LSSgGrEN+18BTOZ0UXK8EcMY0sXVhTHTX1CuM+7G3tK8iQ7L
         OWkQlQqVA8IKXdZcGsgUGlnv3taUw2LYeJSlKYufS6KGl1+Mmt4DtqC4On+ydP5GR9Ck
         gXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbjBnPVhpRbR+iDPKNRkBtw2lZYOaBG/Duh0jODc6ZA=;
        fh=2vmNh02j64meUPBnQgCNVODf5Dddub/jkKJlRIvnYHQ=;
        b=iGcNnyZLvi0mYgoFNDjiFYoEq0+6NW40m0Vb2a0ywuROUUAq76rX0qW6A5SbyoWqLd
         +kGx37Y2NT85XjVcljulVg01XM2kRGw1vEvxHshBfokU3FfpxSynswZdV8veV0tvg4Ag
         Hm6fnvblbNJpaVUuCht/1H3EqBqpLqT94Zh8hUiFxUd337fXQ6idfgG+KhOCktj5sKqx
         rDmJXe82xdfhjiQ5R7k9l3IjB+ezrQLL3kuJB5kKSmepLt1ePZn4DrCUXDBFmjHEgLK9
         istfJRBQMNb21SpUhaWK2dbUOrZhO1DRj7DgxEqY+Vc2R3Y9lyLmnwS2zt2aeCzqP8Ay
         Flpw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769105383; x=1769710183; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbjBnPVhpRbR+iDPKNRkBtw2lZYOaBG/Duh0jODc6ZA=;
        b=Kndf5dLWM/6+bWwvKf7UOu0YM0GxspRC0IM/qZtIJyZi4zOcU1ZgJEnRkzjp7oRL6c
         V5pgs3phYuQ/2Np9LD2O96opGHMrqwye3G6Gtg/ICvST7MsKwVZO6P7OOzNSl+DZRIyp
         eLf8888YS26s7DAz+0W7h+zfXdSMXSGAQa+LIW6eC/oDlE+AzKEFekgVV67UCfN6AQ2l
         c8s6oqCKRupJazOG+YNraG3jsgrQZ2DcuaO6J+poBGTCHJ9Lu3ZZ9/mob9ZxUR3fO3JI
         rc4LpRZXby8pfPe6zFYRgZvKH4ZNyv0AFVeSyQQAMCsNZ6UvoUdALHaWpmjRpb30TB+t
         fIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105383; x=1769710183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LbjBnPVhpRbR+iDPKNRkBtw2lZYOaBG/Duh0jODc6ZA=;
        b=TZkhJYyqOSXbSVJtGhtfRlwu5TrfUR3PLbWbJT157vRPlZCWXm3/QWwW5SUhI4vSbf
         YNuHeqNSDLY6WTRn614lNSS2zKKVlOj6+eNG9vEcNgrZ/In7MswPWM+DkH7LiE4gafps
         Z/JPSzQ0MtFYxJk3+p9PcJdLwToBBWZCBbHYDOMS32eOzEInKR5xTQY/MB6OToorBY+b
         F6y9hn1UY7AxSc5cRLN1PzXFf7worehmQuJGSlefOxNJs1m4u++VmUi5r/6JX5u+wFc2
         n/8ktn6k35PWMPvEcVPp6scHyAyO4aPQ1BJDiVfEAPtbdCiMM0I/HcdUo5ELJvy0e7mX
         Mkcg==
X-Forwarded-Encrypted: i=1; AJvYcCVM33DQRnSgzgDicSib8rw0mgjsdsVbvm00i70WxuZr9oUZaKzd1JfWBRXYLF3ckqeNyxtl1g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwGfrj9YTbRFTsaUWDVskhlwjcfo4H3w5TEAjXg6EgBpQzLBDBK
	PbJQ9k7A2jiKboXd8FuDgh8oeHhP2DFb64gDmcFJaPuLfzG4p+ttsAPpuhjddpMbbVxKkb9rVO4
	U9EkXl5Kmgs8Oh66fnP04pEn7t0Pcbf/zxLyKjwMVPg==
X-Gm-Gg: AZuq6aLp1OnzZFwNKcMEwfKbYArY/OCayY+wWziDj9irMwbQOw7CO99PkxRrDCA0BMo
	uri241d9A9RGPMz9RVkZxzq2Hka4X7rLVpdXxk9CMuU3uCcXNA60tDNGQ9A/Diptb7FviBDbXmw
	5coHusZHS9Zw1SoX/NTxv8PMRfVeb0uO6sdRxKm26SoQ2DxR4Jln/LINjuYOskUomS85jU9wUki
	ZY+AWLTUoHyEtO4ONRCfAjp3uLolycOeILp6YOA7RmTx9Oz8l9ERDfCjpGlGdPPSNhIXLt2OKRw
	QI3AAvuldzok7VWZjah9lQvq+g==
X-Received: by 2002:a05:6402:1e92:b0:64d:3b22:a5c2 with SMTP id
 4fb4d7f45d1cf-658487baf12mr292541a12.25.1769105382740; Thu, 22 Jan 2026
 10:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20260122132740.176468-1-ranxiaokai627@163.com>
In-Reply-To: <20260122132740.176468-1-ranxiaokai627@163.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:09:06 -0500
X-Gm-Features: AZwV_Qi9TMnkjzXXfx8I6-lM4eliGE6Ihf3Eq84jRCQeznE2azuug8e_3kMlNnw
Message-ID: <CA+CK2bAMBxZMBGS6DLaEO7M92vutW5UhfJNSwk+okdVu=EYu+g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] kho: init alloc tags when restoring pages from
 reserved memory
To: ranxiaokai627@163.com
Cc: pratyush@kernel.org, surenb@google.com, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, rppt@kernel.org, graf@amazon.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	ran.xiaokai@zte.com.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_180945_148398_D6D9B0C1 
X-CRM114-Status: GOOD (  17.92  )
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

On Thu, Jan 22, 2026 at 8:28=E2=80=AFAM <ranxiaokai627@163.com> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and below warning message:
>
> alloc_tag was not set
> WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1=
: swapper/0/1
> RIP: 0010:___free_pages+0xb8/0x260
>  kho_restore_vmalloc+0x187/0x2e0
>  kho_test_init+0x3c4/0xa30
>  do_one_initcall+0x62/0x2b0
>  kernel_init_freeable+0x25b/0x480
>  kernel_init+0x1a/0x1c0
>  ret_from_fork+0x2d1/0x360
>
> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> fix this.
>
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>
> v2 -> v3:
>  - also call clear_page_tag_ref() for non-compound order-0 tail pages
>
>  kernel/liveupdate/kexec_handover.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index d4482b6e3cae..96767b106cac 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -255,6 +255,14 @@ static struct page *kho_restore_page(phys_addr_t phy=
s, bool is_folio)
>         if (is_folio && info.order)
>                 prep_compound_page(page, info.order);
>
> +       /* Always mark headpage's codetag as empty to avoid accounting mi=
smatch */
> +       clear_page_tag_ref(page);
> +       if (!is_folio) {
> +               /* Also do that for the non-compound tail pages */
> +               for (unsigned int i =3D 1; i < nr_pages; i++)
> +                       clear_page_tag_ref(page + i);
> +       }
> +

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Pasha

>         adjust_managed_page_count(page, nr_pages);
>         return page;
>  }
> --
> 2.25.1
>
>
>

