Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA5CCD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FUParyONVI2Qj3PwFGzLdK26Nc4Lc+7LxeqmGfzlOkM=; b=b1lkyfK2YQNA2PoQkutk47F7mE
	Tf81dtz5LH6D6aY7Hk7prNJPe96ZXOennl+19EByLCQLMh0dwP6ZuR5suXd6ddoTLV3uhXFIN3RKW
	WhAPIzWgpWJZhaM+iK4NaY7sDAqqdjUb6GDiPRXtPapUA4utbEkjg6MQV8M1VNjgOYuZnDap1FUYN
	AX7+YCvHkgBRGztgfRfqfJJy1y1gfjzLJC2iMVCwPWWvUtKXnSTUfkHx7bvi5556ewhJX1n+PuVXp
	LxTnA2pSV2e8bceiCZ2CtGclkMYVEQFL8tF689+BKV9tRqbDLQqrP+x6eLgpaFAbCKPoFzcySU2C3
	eTmph/sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUpe6-0000000Fb7n-1lh0;
	Wed, 03 Jun 2026 17:44:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUpe5-0000000Fb7J-1ydb
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 17:44:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B2914601E8
	for <kexec@lists.infradead.org>; Wed,  3 Jun 2026 17:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692CB1F008A1
	for <kexec@lists.infradead.org>; Wed,  3 Jun 2026 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780508688;
	bh=FUParyONVI2Qj3PwFGzLdK26Nc4Lc+7LxeqmGfzlOkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XVmh5ADe07P1f9LqFCukv3auT/xdl4cJ45wk/gD5dFRsMpz5sCJ4B7u+9tu3rhoZr
	 EXPTc7jDaVUDZVie2L60Kjm9z+Et2iGuPB/8li6Yihuhm6C/vAgimQKCYm7I3iU9Ni
	 BAvD4RjcCj2uEjB0DPlu5xRwpj8sNtSMqh6Ys9dy01dbEly2l7JWXAUmkqCKqkzeRu
	 TOja3UUzgCCzYccSqtJ8e+7JHAIAY29bLR0W+6ngtd94yZnkXBu6WVcpOMVpyyyglD
	 TRhj0tCqeEQgsrH3txoTP5WOoxU1eCm2PH+w1gEMtJQdBcU/ccnxYYY1xY2vWFZgzn
	 ZM0drYjJBYo4w==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68ae265815aso2676414a12.1
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 10:44:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mlXOLpJCVU/iqZnagv8uT4qJdaHqDONEeBbtac7muYMOsf6bb5SlBNCphyMh8U70LuFoO/Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxFMcvp3KwC9f5l8wML/rhnc1IASULLCXLwEHegT9k3OOCS12sS
	Bmgo1xT8h8s7qyp1gRqDFLeyy7tfYzWhWNhAQowKrclOMhcigZ9eAhkRgqrQPB049MYy+Xun0Co
	BgQYu7/1TpR08Fzs+qRG620H4aPvmaw==
X-Received: by 2002:a05:6402:3224:b0:67f:9124:8815 with SMTP id
 4fb4d7f45d1cf-68e71e788c3mr2143257a12.17.1780508687065; Wed, 03 Jun 2026
 10:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-4-chenwandun1@gmail.com> <20260602162450.GA442759-robh@kernel.org>
 <79932afc-2e91-4a54-aff9-f550be784c36@gmail.com>
In-Reply-To: <79932afc-2e91-4a54-aff9-f550be784c36@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Jun 2026 12:44:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOC1ko1Len3Dyc5SNKrHmhQn9uiDAkFfVbYa2wAfFUTg@mail.gmail.com>
X-Gm-Features: AVHnY4Jg1TFYCpbsJd3VXxxqiBkj66MRmp2Oem1kgjUPEYvvmBJ9wL6Wox9sVrg
Message-ID: <CAL_JsqJOC1ko1Len3Dyc5SNKrHmhQn9uiDAkFfVbYa2wAfFUTg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] of: reserved_mem: avoid post-init UAF when
 alloc_reserved_mem_array() fails
To: Wandun <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux.dev, 
	zhaomeijing@lixiang.com, catalin.marinas@arm.com, will@kernel.org, 
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, saravanak@kernel.org, 
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, quic_obabatun@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jun 3, 2026 at 1:44=E2=80=AFAM Wandun <chenwandun1@gmail.com> wrote=
:
>
>
>
> On 6/3/26 00:24, Rob Herring wrote:
> > On Wed, May 27, 2026 at 11:29:09AM +0800, Wandun Chen wrote:
> >> From: Wandun Chen <chenwandun@lixiang.com>
> >>
> >> The global pointer 'reserved_mem' continues to reference the
> >> reserved_mem_array which lives in __initdata if
> >> alloc_reserved_mem_array() fails. of_reserved_mem_lookup() is
> >> exported for post-init use, that would dereference freed memory
> >> and trigger a use-after-free.
> >>
> >> So reset reserved_mem_count to 0 when alloc_reserved_mem_array()
> >> fails.
> >>
> >> Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically alloca=
te reserved_mem array")
> > Fixes should come first in a series.
> Understood, will do in future submissions.
> >
> >> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> >> ---
> >>   drivers/of/of_reserved_mem.c | 20 ++++++++++++++------
> >>   1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem=
.c
> >> index 313cbc57aa45..6d479381ff1f 100644
> >> --- a/drivers/of/of_reserved_mem.c
> >> +++ b/drivers/of/of_reserved_mem.c
> >> @@ -69,29 +69,31 @@ static int __init early_init_dt_alloc_reserved_mem=
ory_arch(phys_addr_t size,
> >>    * the initial static array is copied over to this new array and
> >>    * the new array is used from this point on.
> >>    */
> >> -static void __init alloc_reserved_mem_array(void)
> >> +static bool __init alloc_reserved_mem_array(void)
> >>   {
> >>      struct reserved_mem *new_array;
> >>      size_t alloc_size, copy_size, memset_size;
> >>
> >> +    if (!total_reserved_mem_cnt)
> >> +            return true;
> >> +
> >>      alloc_size =3D array_size(total_reserved_mem_cnt, sizeof(*new_arr=
ay));
> >>      if (alloc_size =3D=3D SIZE_MAX) {
> >>              pr_err("Failed to allocate memory for reserved_mem array =
with err: %d", -EOVERFLOW);
> >> -            return;
> >> +            goto fail;
> >>      }
> >>
> >>      new_array =3D memblock_alloc(alloc_size, SMP_CACHE_BYTES);
> >>      if (!new_array) {
> >>              pr_err("Failed to allocate memory for reserved_mem array =
with err: %d", -ENOMEM);
> >> -            return;
> >> +            goto fail;
> >>      }
> >>
> >>      copy_size =3D array_size(reserved_mem_count, sizeof(*new_array));
> >>      if (copy_size =3D=3D SIZE_MAX) {
> >>              memblock_free(new_array, alloc_size);
> >> -            total_reserved_mem_cnt =3D MAX_RESERVED_REGIONS;
> >>              pr_err("Failed to allocate memory for reserved_mem array =
with err: %d", -EOVERFLOW);
> > These prints could be moved to 'fail'. Perhaps instead of just printing
> > an error value, you can return the error value instead of boolean.
> Will do, consolidating pr_err() under 'fail' and changing the return type
> to int.
> >
> > If you respin just this patch, I can pick it up for 7.2.
> Before I respin, I'd like to flag a dependency:
> patch 05/07 in this series build on the signature change introduced by th=
is
> patch ("the void -> bool return type change of alloc_reserved_mem_array()=
")
>
> Could you let me know which of the following you'd prefer:
> a) Take patch 03 alone via your tree as you suggested, after it lands, I'=
ll
>     respin the remaining patches of this series.

I would go with this option. AIUI, this series isn't going to land in
7.2, so ultimately you will rebase on v7.2-rc1 which will have the
fix.

>
> b) Keep patch 03 in the v4 respin of the full series, reordered to the fr=
ont
>     per your earlier comment.


Rob

