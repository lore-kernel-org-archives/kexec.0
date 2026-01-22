Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB1D6CFA3
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUUSYk75yHSKQkrJ/9Eh/39Gsadu8Q7tI7No8P2IvHA=; b=Ja4bUVIrVqaJKAF7bySmYhhtNS
	lGt8wiJhvAgZYx0MbUkz8vSBz0y2tTTm/7rF0SVWjYz5HORmx05YY6MqLTGDFzX+uLGHkjbUnv+Ui
	zSCYSmLYM8+eFYYuonxMDyGnBZFW+c0MTN83RSSgJtfa4Bsk7GULU07+ixaMFW7hQzUdfbn/uAeqn
	IiQR9+LYqxWYGwQF4r+YWov3/AmiNKtKWi87Ax+w/XRS1hLkdIfTshiuyJvmNvLCUTtnaZqZaFRUR
	7CbVGhCyHGddn2/T928Zm0W+qsh1VOwqYEFXrmmXbACBg+LN7G640RhLz2qVfD98GE7PYazNcSI1b
	fraLKkRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizGX-00000007cSl-34Di;
	Thu, 22 Jan 2026 18:18:45 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizGV-00000007cRg-08X3
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:18:44 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso2206233a12.2
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105920; cv=none;
        d=google.com; s=arc-20240605;
        b=lqR8NBY5/6gE0YA+0pTSiiB/Z4u8nlLy3ss8H5/0xKsahep2lIo/GPzoGHNtrK6kXN
         0BXxRlRMUtyBrTRBriII9tco1W5cc18SHSHc6tccd8fKYE8T6pIhBo3jr6hVqet0qYnX
         MTQ5mHfxYxgV4iT+PJxleNuOdjYEyd/01oS9g+oXfHS0uI9JmwrQoXbjoXvlbw2UHZF0
         fuIZT2ZBCUKSgwFhArkJpeZYURVg+yNWxIAmn0DBEKzMrJ2C8wIeRbGR+Vx0/gmnwgHR
         XmzBRaZEp6LhZF0Y7PITo4wg4MNkfWUC5/mNduD4w2nk0VZ43b0Bhm5a3Ah2ttnhd6Rs
         vazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUUSYk75yHSKQkrJ/9Eh/39Gsadu8Q7tI7No8P2IvHA=;
        fh=uOqPg+5b8yWTa1WPEpa4PyDtT1OAILqaHRRh6hr3Gl8=;
        b=LaVeJyb+WVyWIkgZiKCcX2GD4yO0SPJBuAggHfDKg2bhTerhzcUOnb/2eOa+ezAuDL
         Yfned1diqq01v/IqPk4nWTolE/R6nWLoZrQe4/hvrMtARMNesx/XL9MKjs7bvANd2tCb
         iBexbNzsJdOEHh7X3ZlWJS9VtkZ/5OjjRaiC98ZQdhQG7Yl/zQVn/Cv5K8ITatmbgoFp
         uS9mTN5MAdI7wzg6oexVMZuq733dz6Mhfj8wOhPcRla06sHt6IhPyxu+6aOng2mBseik
         C9zfZg9+0Y8usLrFhjBCMitYHFckERkCNsZnAX8KqKh+nGptMFYR6FexI5QYZ0Jd5D7W
         V65A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769105920; x=1769710720; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUUSYk75yHSKQkrJ/9Eh/39Gsadu8Q7tI7No8P2IvHA=;
        b=NJKiNvqLCqeoA+bQ+qbXuY33lph36EuBaOILvY2bPHVqP4CPlbSwJYoNKOtaLa8HZ5
         JbGblh7J83Yv/2GjUeNTyUDnrxJT0FEIaGiuUEMrpx8aawHVUvggrwfYe4xXsd3uGI1K
         Fvm/AwKHbqiWZodAAwum3pWxTXEAps+IGR939rKvlkz/Xg43VwIZQgEtcjerDVQzKlzG
         IdpLGLzl3CpXeTGi/91AX12Yiz2H2RBm4cKnYP7ZqWKj1VyObfwSto+snx4mESbHMwu/
         Z5gVXZZXSbEsDm5ssg9AzVZo1izFc5fsN1mFzTZ6XsJEfA5a0/hAjEjAA//qpveSo/DS
         0a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105920; x=1769710720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUUSYk75yHSKQkrJ/9Eh/39Gsadu8Q7tI7No8P2IvHA=;
        b=C5qoQ5+0KusBRBA7jA+eeEDmjfF5hJaE96dtCvYqi3qIddz47+CtL5fIriLzVe40Nq
         hewCMbaUZjiL4V9kPstje/6bKqTkW54/8x+1ERwAdYXXaDkAXAB2rBAWrNZQGQ2fR3ym
         JsoLvx8DB03yqgECXZytSZS2d10kIyK+1TYih7+56upSxbawOZurnc94U2hjOjr0P6py
         FecnUEi/zVS3HEp2nOJbRttODJ/8ThFQjBTfPyszwtDCS0CZckGl4psYL80TctKWprgb
         O8UyF4mMvmNbx9p24ekVf8sSBksUePNpt7J39Ren2oHg+AgBk5DK3al0CTvz4Cj9FVhY
         qehw==
X-Forwarded-Encrypted: i=1; AJvYcCXvRCLL7GxhhV8tjtZK8MwuqTJMsUC4QDReScJHU0tkyi9rhePcWRWL2GqGRx7MgLbfZs5fYw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2y+jBGWVALPMBipXOruzY3oUwYG0pD30ET7zMTss+x44aq3jF
	xHq4kNGv+/GlSwgLSYzWKn/Uk2cfKYqUHIjZsE11L9PLGuqeI3druKA8d0LvxNukc1H6ojqB8em
	ddgypR/r+zaMAR15g69e9HeJGAWoO4ZwIKdBtbDQOzw==
X-Gm-Gg: AZuq6aJv0YrwYv5KCATxAV3yEivNSdm0bQfhTAdPhA1fMg+ATY/VA//UJgqylziuM4q
	sLM+zkKNUnITgLWGNCl/mx5IQMZfn6YnxidqJzSeXy2bnA70BQjvqYmbqVsFwBsnp/qBRkYUmmW
	82ysMOmajx/Shs10N1fvVqfBXDSWXXS+/awvhkQDwYTCYqdK/b+198KV31KytdPWMHeut0wV464
	cEszdQ2pC/EW/r28gnKTSgrYg/08RgIcoadrtouRn4WHJAXZ+tX2AWaljYMzXT5kNdNk9hXDnQG
	+PPsriXgvc2d83ppoOSFBFCQWg==
X-Received: by 2002:a05:6402:2714:b0:64d:498b:aefd with SMTP id
 4fb4d7f45d1cf-6584874e332mr336027a12.5.1769105920515; Thu, 22 Jan 2026
 10:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20260120175913.34368-1-epetron@amazon.de>
In-Reply-To: <20260120175913.34368-1-epetron@amazon.de>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:18:04 -0500
X-Gm-Features: AZwV_QgWHU5xyibFUjuLYel9awdHxBW6MBa7iM3aXogi00k15P2X6oDpylsDrzg
Message-ID: <CA+CK2bA-pzGO83wi63A1QFe=u33HXKTw6Po7j7W0PN4dK7WG9A@mail.gmail.com>
Subject: Re: [PATCH v2] kho: skip memoryless NUMA nodes when reserving scratch areas
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_101843_090574_749D8C9B 
X-CRM114-Status: GOOD (  20.22  )
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

On Tue, Jan 20, 2026 at 12:59=E2=80=AFPM Evangelos Petrongonas
<epetron@amazon.de> wrote:
>
> kho_reserve_scratch() iterates over all online NUMA nodes to allocate
> per-node scratch memory. On systems with memoryless NUMA nodes (nodes
> that have CPUs but no memory), memblock_alloc_range_nid() fails because
> there is no memory available on that node. This causes KHO initialization
> to fail and kho_enable to be set to false.
>
> Some ARM64 systems have NUMA topologies where certain nodes contain only
> CPUs without any associated memory. These configurations are valid and
> should not prevent KHO from functioning.
>
> Fix this by only counting nodes that have memory (N_MEMORY state) and
> skip memoryless nodes in the per-node scratch allocation loop.
>
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> v2:
> - Removed kho_mem_nodes_count in favour of nodes_weight(nodes_state[N_MEM=
ORY])
> - Use for_each_node_state(nid, N_MEMORY) to loop over nodes that are both
> online and have memory.
> TIL: Nodes in N_MEMORY are a subset of those that are online. Thanks Mike=
 :)
>
>  kernel/liveupdate/kexec_handover.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 9dc51fab604f..979ebaf015bf 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -643,7 +643,7 @@ static void __init kho_reserve_scratch(void)
>         scratch_size_update();
>
>         /* FIXME: deal with node hot-plug/remove */
> -       kho_scratch_cnt =3D num_online_nodes() + 2;
> +       kho_scratch_cnt =3D nodes_weight(node_states[N_MEMORY]) + 2;
>         size =3D kho_scratch_cnt * sizeof(*kho_scratch);
>         kho_scratch =3D memblock_alloc(size, PAGE_SIZE);
>         if (!kho_scratch)
> @@ -673,7 +673,11 @@ static void __init kho_reserve_scratch(void)
>         kho_scratch[i].size =3D size;
>         i++;
>
> -       for_each_online_node(nid) {
> +       /*
> +        * Loop over nodes that have both memory and are online. Skip
> +        * memoryless nodes, as we can not allocate scratch areas there.
> +        */
> +       for_each_node_state(nid, N_MEMORY) {
>                 size =3D scratch_size_node(nid);
>                 addr =3D memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT=
_BYTES,
>                                                 0, MEMBLOCK_ALLOC_ACCESSI=
BLE,

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

