Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EA9D216B2
	for <kexec@archiver.kernel.org>; Thu,  4 Dec 2025 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wb9ZdPQgurLaP8ZtzTPbdlyBs0CGGHqRQ+aYAuE+t9k=; b=kvTz2CoyekH7JzmIf1Hlq+pb6H
	kAfNP4jGTbcKh7NRuzU/yToLa5DaolIdH2lEXQ5GoHQtDcHevNvs6QWskm0t1Mm8bouGRBOWgplXL
	/wS56v12kHg5dbhlY5ruGLEzteda2L1ESOfQwEStjM97QZYKrF0c0HPqwoxeVVyrf7qsYSQbeFlh2
	djrRh4a0xOnse96YK3SGXfvTuV8uWZTtez+14JbTwtuoxIZJttKeXUZ+/zsNx3uHYcFGkWRhcoZv7
	WdeB/iwFeoDCZO/8oCMppK4O4o2QLjWjJKUS5cydWoPrHJE7y/h2bYUENVwT1p+TyHK6itQW3ouZ0
	iU2dpwmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCNv-00000008IrN-0Zo0;
	Thu, 04 Dec 2025 16:40:51 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCNo-00000008IqB-2dsC
	for kexec@lists.infradead.org;
	Thu, 04 Dec 2025 16:40:50 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-42e2ce8681eso880597f8f.0
        for <kexec@lists.infradead.org>; Thu, 04 Dec 2025 08:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764866443; x=1765471243; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb9ZdPQgurLaP8ZtzTPbdlyBs0CGGHqRQ+aYAuE+t9k=;
        b=PZdvjlBM2cGaagLIU+Cql6eDsfJfXrlxk5DioOTR2GYYwfDJydOd5Z5GBYIkMzDjC7
         rOU/So82R1atvkOVOhrsr90hQYKec3LmN40LsrDMq0wv5rHWdiNXiUP4Xr6V4zraSQw9
         g16T2ukTOp2GlpMS4TnOKrfO0gWkfqqgAygrx1ZW/T6R3H4rBYErPodnZ0XM1KpVT6e5
         9oTXcMfUYPpEpvvk8Ju/uwnwPOviB/c4HvMieaR8OGOCWg4WXLNsMsTt0y54OgV+A1wO
         Yo7EsaDzfen9tRkbsS/P6OMm8WNxIsXDybAwVUn2Mg1zmVHBhomka1BflJ/d0YMeOapS
         KrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866443; x=1765471243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wb9ZdPQgurLaP8ZtzTPbdlyBs0CGGHqRQ+aYAuE+t9k=;
        b=qMMZDHFi5E9xWwn6vC6QNmrWlIyB6iriEfnLd5lA6kQZjrG1AM7YeBzzGkZ+aMN85L
         M71iMJ8zFzRbhded+NaORIH4FCk/BXUj1S/6w+Ui/jsaFnH0vkVMOHYeYcrh61YEF7Sf
         IrKo6MBq+1f8wpc6HdgvIXvK85XtmyL1ApXBi1cVvePX2wT8m1hzQdOtjxQkisbSBdJK
         bU7kqeDg6Ua06coFdBEuc33asYvg1GJZYRkgB1GaZ5WrDWUh3tR0/j9VoEJ9FrReN9PJ
         N9qK4n9rOqk+HfijAsloRET5iOitHrqfk/H37daN8TMrE+LpAR3ehQFFRdw4zbbyg0vy
         B1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLFyo1zL5GNedkrbMMkSO6XFuqyVE22yLEjRIT8RFHp2n5SkvmTM/vKmaHNp3KtwOtM7XyGQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9N9SDuQGQw3A3zE48rwiqc2JVJkep+0EI3ceZFMIl8SmQ+wrl
	+ttHjKLsF9ZvVIm+ZQCHGaWqsgJfsMIMmS1BZPxw8CmqhJrtNm581OivP+XyztFZcrBuQyMY+2Z
	gwjKR6yp4/J87dsSBldEwdzjABOtYSqY=
X-Gm-Gg: ASbGnct72sjuhzsBQ4/x3bL3FDLtqSuKJ5q8ch/E4WOnNSgG9JUK0PNYa2wzqCYReeB
	jXjzgPz77YzVZZBfmT/sUBpeKx+QACNPBYvfNf88uhWdoc27m3/UmIIe9fuX1XmuUbY/80Gg4Mz
	Y7wUkpZ2cSwWhCa4soGT89oGv1g0NFVlESoVWHaLwp0ogDJdKCwCStQrkV9p1ypfmKEY/AyX6fj
	0fFIRc1AKXq4o3DXwgBTZJMdK7ogIJ1+9OkgOb+68h5nre+/OPNmMp+k8apY+KH+JrpNxGncp/T
	kzkqvF4KUirB/af4sXnAvil39i5O
X-Google-Smtp-Source: AGHT+IFBRVSuUZ34af9rjSbMuf6IaH9HO13HkHrc7coRDjjoLj9cIdf9EynSSP33VRIl9frOkufLTItP6mOGaTfz2hg=
X-Received: by 2002:a05:6000:1a87:b0:42b:483f:da8b with SMTP id
 ffacd0b85a97d-42f73187378mr7778677f8f.25.1764866442731; Thu, 04 Dec 2025
 08:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20251128033320.1349620-1-bhe@redhat.com> <20251128033320.1349620-4-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-4-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Dec 2025 17:40:29 +0100
X-Gm-Features: AWmQ_bnAHBHdMEtZR2H-axXWT-9zuGdxSA8XYx7l16HmfMLSXrkVqTo9q2sNGCg
Message-ID: <CA+fCnZfVPGYkFrEaU0-AzxUDLQcwoT08XuTrXf9oifHWEbhA=g@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] mm/kasan/sw_tags: don't initialize kasan if it's disabled
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_084048_406466_064E5CC5 
X-CRM114-Status: GOOD (  13.10  )
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

On Fri, Nov 28, 2025 at 4:34=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>

This commit message is too empty :)

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/kasan/sw_tags.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 6c1caec4261a..58edb68efc09 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -40,6 +40,9 @@ void __init kasan_init_sw_tags(void)
>  {
>         int cpu;
>

Here and in other places where you check this flag, add a comment: "If
KASAN is disabled via command line, don't initialize it.".



> +       if (kasan_arg_disabled)
> +               return;
> +
>         for_each_possible_cpu(cpu)
>                 per_cpu(prng_state, cpu) =3D (u32)get_cycles();
>
> --
> 2.41.0
>

