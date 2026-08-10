Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DDDC5AE49
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vAZICJ1VL+Q4P+HgVltfFci9gRl+OP2pT5x+XsJhMII=; b=zKBsZLPoI8+JdpZf7iEZbEXTd1
	txnT+Xf/etfQfI7LnYpTjsjwgm4B8XdCSW/0hABewnIjsTBLAtFtkLtxp094tMdBI+VJpT/NkRFOz
	0mCV47KGV9WIZ6NgYM0DIp/cxPjvPz+SI7halSaNwF06vVLPJ5a3jCy/ewgEkEjc6dZOssoyU0nAX
	DNldQ9PMKFdjvfqzBU2bCyy5GlOePjAe3POVC3F4ZPHaDxKfZCLSqPN+d++J/3Eov0hvXfJep7ZTg
	RW2v0bdG3UjSq7KONivEwnhnnmhOBxwouzmKcznMnaEkPUaGkaR0B4b0cYeSIGZGI1JQfTKQIIzJG
	P+sTZA5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtR8G-0000000C24A-0GYg;
	Mon, 10 Aug 2026 14:37:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtR8E-0000000C23X-3ZBN
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 14:37:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0285E60254
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 14:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7CD1F00ACF
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786372657;
	bh=vAZICJ1VL+Q4P+HgVltfFci9gRl+OP2pT5x+XsJhMII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SArZK5THaqvLXQCuVVrc4Xw1j9zygKBZI9iYjKiiwBan6sDfP+al+k2f3fu/kYx4L
	 a/Ccl5sHHDhzybny8B1waIRawyLjQrXfsKP5gX4l+3eJTqaPLs12CclPQr7DklcoWZ
	 WPJ+4ZLPPhstBUJfYMaBlNcWT8cP9GWF4gVIYvQhXL3kqcsSxcNWNuyMo09atlZdrg
	 ccX8dM8oBl5XugXNdUSVXwYJ9NcP93BpFoTcxUcp9jImtkyRSNJrtrkqCbRPZEh7uq
	 zCfbNYkxR/JHphaH2+GBlHe+vMVPtXSEM5LcFNkNlYHWboqquri3GpcaohpeKDe4su
	 82BK15pOrkmTw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so3093553a12.0
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 07:37:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqjwAFkiptOxkckAV3amTHG11epFP8naqe7HgXSHXq7IlxyiSjrOPKzP5Mr4DPr26VqY0GXTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwxlfvXzJaPPrJt9qhK9YgCwtFbmkXwgkFi7GXYtEIhaKXIkWSV
	XYdxvxFm7dkmtx9eVSDepTGyLzTD61w0YwU9B6RIkNXtDGyQ0z0Qm5yiDJ2NfGN7TsL+vnORHYQ
	6wvCcQC9s3mYYyWFr783vy4vcl3zvgBk=
X-Received: by 2002:a05:6402:52d4:b0:6a1:df2c:cfa3 with SMTP id
 4fb4d7f45d1cf-6a1f23c2558mr10654266a12.4.1786372656379; Mon, 10 Aug 2026
 07:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260807103714.33074-1-dongtai.guo@linux.dev> <20260807103714.33074-4-dongtai.guo@linux.dev>
In-Reply-To: <20260807103714.33074-4-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Aug 2026 22:37:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4pK10ONo=viJyUJBiiFb_7pbB9LaNkQWH=83r+7E0iTA@mail.gmail.com>
X-Gm-Features: AUfX_mxGX4Nbr4LsOBcUqni8J7T0qO-yPY8u3j28Wab2hCSGdEOhPb7Wq76lg-Q
Message-ID: <CAAhV-H4pK10ONo=viJyUJBiiFb_7pbB9LaNkQWH=83r+7E0iTA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] liveupdate: luo_session: include linux/mm.h for
 virt/phys translation
To: George Guo <dongtai.guo@linux.dev>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	shuah@kernel.org, ardb@kernel.org, guodongtai@kylinos.cn, kernel@xen0n.name, 
	graf@amazon.com, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org, 
	Kexin Liu <liukexin@kylinos.cn>
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

Hi, George,

This should be the 2nd patch.

Huacai

On Fri, Aug 7, 2026 at 6:39=E2=80=AFPM George Guo <dongtai.guo@linux.dev> w=
rote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> luo_session.c calls virt_to_phys() and phys_to_virt(). On LoongArch with
> CONFIG_KFENCE=3Dy, these macros (in arch/loongarch/include/asm/io.h) expa=
nd
> to offset_in_page() and page_address(), both declared in <linux/mm.h>.
>
> Since luo_session.c only includes <linux/io.h>, the translation unit fail=
s
> to build with CONFIG_KFENCE=3Dy:
>
>   asm/io.h: error: implicit declaration of function 'offset_in_page'
>   asm/io.h: error: implicit declaration of function 'page_address'
>
> Add the missing include to fix these build errors.
>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/luo_session.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_sess=
ion.c
> index f38b5b18f3f8..31490ac7b63d 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -94,6 +94,7 @@
>  #include <linux/kho/abi/luo.h>
>  #include <linux/list.h>
>  #include <linux/liveupdate.h>
> +#include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
> --
> 2.53.0
>
>

