Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7804AD2F339
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CL9mqA+L5ChBc4KUhSETt4hYPO2nC8ZfXtH0nl6Jj08=; b=WEBbffF39yFRjMOOwuJERS2Uuv
	Wwpy8iT+OaI52Qnd/AMddR4UIdmfxQ4bn3w4thA8UE0QrTyC+D26VtsOYkMkaOXH+mCpUwGhHmyC4
	IOSmJPipI6anlH4KH87LQY1Hk0nRBWRGnoKhwMfFWZKHehRGGs1BnC/X8hba9iFcXNXOXIRqW66N+
	83Be6mE0G95VNRRUGLIoHK3l1/AnJInDGwyOdnzPl41v7wiSzBq5XgWka41bBxHiUaZETaTVJk3kZ
	1AG1w4lfQojhLPSbCdZHUIwvMHILIkD1674nR2rlzGMeNvvhQaZG7hyORvv1eBmibhRohhwlEMDZQ
	9o3MXTsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfh9k-00000007Sjl-28Zl;
	Tue, 13 Jan 2026 16:22:08 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfh9i-00000007Siq-0WeT
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 16:22:07 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so12141112a12.3
        for <kexec@lists.infradead.org>; Tue, 13 Jan 2026 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1768321324; x=1768926124; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL9mqA+L5ChBc4KUhSETt4hYPO2nC8ZfXtH0nl6Jj08=;
        b=fJkZsLqP6UW4mOsrdqT9bv9Knzt0eG4vqpvKlzNwFzr3OoBarT229JsqBzAnJ4i59B
         YhUwrSOdzzGdXX0KkFaEBgUnmWruwXi2vB0Wup3qufKWYmOoS2q/ZF889F/mRZligiad
         724iGEKV9n0axGB6f+Rn1VJbboX9oYeI3ZjpldYZbHw3BMfIDyD74GcP5rQRTLYCYpmH
         xYl/zirqkd7QZAorSG0xW0J7HGsdRr3LY9v7j8ZLTMpo4Nc9aRKcl+U1yk3S7cvURCXr
         PXjUU7eDv0jMh2GB9w2ihBWAgWB/WWKP5/E+oS5iGeB+SBP8nR/+x5tXrgMLTcijF6r2
         4Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321324; x=1768926124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CL9mqA+L5ChBc4KUhSETt4hYPO2nC8ZfXtH0nl6Jj08=;
        b=q4IzbWOJvGRVh52CP9u9iZ4RRvuw6h/NC0jC407OzMfn8UHBB7j0tkx7TEdyeGq9mD
         JT49zuRTtXZ8jIZqSz0TncvrzKdwLK1AGqbPl1xHdbSvsJXKy+pmWrAYh8dsTI6Yd/2n
         qWAWBudAAf9G/1iEkmSkVLQOUws2VLg77vWSgi6ntQt5YNcyumxspxnvO1/1eMLJqycd
         ysLXphJE/KU6HwT3oiQXkpJyJVmZUnTbKRIc2cifofuka/JqvU+TltudX7k/O57OTdV/
         I/KpjEwHCWN3ewzLzAUQfMTJPuhp+k0nhnv9q2NL96QQGPVYJe1WJpzLXQgSybPqH8k5
         jLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeq0byFijRDiiJh0aroxIaKfzw6auT57oyEjBV5XLkzOP/LAm4jkxLROEDXNFQSn9xhL/trw==@lists.infradead.org
X-Gm-Message-State: AOJu0YymAofHyZJNrGb2H1CxUW/bAaWS4G83hcG4meyWpQi65wb4ug2k
	0f3va8PPoazVk+qS+XZ1A3R/Tcl881O5uwVupPcbMtfxlM/GuCAWZicNWH00Ezx64ZTlVFp821Z
	Y84vTkR6cGEHmu1GFBFtkqNn2AL8r0oycwQH+dajH4A==
X-Gm-Gg: AY/fxX7CEWtf2xQmzZ9GUK9mX4DEy7AflwLnVbmmyuuz18QF5pPFykf/B51hsL5wz79
	JDwOsFHRwvF2Clk7WVMu4zl+/7zVF8VSU31AmQbDdSqeCzSuNLa8GixLJYFve8HaIKliK170D/F
	dXGhtutkIRQaUUjUonzycRhSspJwO/RpzKms5tjGJyoU2wP53b7pZANvopLSkQMBERyJmNQ3Bwh
	EHZ0meJ4DWCTTGsOLvkI+w29f2gIYMcFUfw04m/kj4Fbkl4co1SpqjB/rrlR6E8iYIR1y0ew0ET
	BtEhG340+XqLKOHltBrztaCslQ==
X-Google-Smtp-Source: AGHT+IE09dEuw/V3YD01k0td3WIxhGV8UT0oz/yQ+pLP1I2+bSDu0laME8BHispRCz0saUuovB6LZomX8UuT6DU+VTM=
X-Received: by 2002:a05:6402:50c7:b0:649:815e:3f9b with SMTP id
 4fb4d7f45d1cf-65097dcba5amr20365112a12.3.1768321324008; Tue, 13 Jan 2026
 08:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20260113033403.161869-1-ranxiaokai627@163.com>
In-Reply-To: <20260113033403.161869-1-ranxiaokai627@163.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 13 Jan 2026 11:21:26 -0500
X-Gm-Features: AZwV_Qhd1NUaX74PyQKfMs_orfB5NGTMsZf295fX_SYz96GVd1njvy0k-ruLXJE
Message-ID: <CA+CK2bDmfuqnR4SuMSgLS43e=wqM9ovu_VBCYDCzdcBaFJW8+g@mail.gmail.com>
Subject: Re: [PATCH v2] kho: init alloc tags when restoring pages from
 reserved memory
To: ranxiaokai627@163.com
Cc: graf@amazon.com, rppt@kernel.org, pratyush@kernel.org, 
	akpm@linux-foundation.org, surenb@google.com, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_082206_188385_415DE7E1 
X-CRM114-Status: GOOD (  14.59  )
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

On Mon, Jan 12, 2026 at 10:34=E2=80=AFPM <ranxiaokai627@163.com> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and below warning message:
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
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

> ---
>  kernel/liveupdate/kexec_handover.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index cd6b3fb9dcae..2d47f2c50bd8 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t phys=
, bool is_folio)
>         else
>                 kho_init_pages(page, nr_pages);
>
> +       clear_page_tag_ref(page);
>         adjust_managed_page_count(page, nr_pages);
>         return page;
>  }
> --
> 2.25.1

