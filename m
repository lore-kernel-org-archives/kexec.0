Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB4BE7717D
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+7aMbcpFFqiF0dBAcBKoMoUVucO4y8eeE0Sdqq64qUc=; b=TRHqyX6VuRuNZ64XRC8PG4yDmn
	qW/izJV9Og6+sk3ha8pag16sYMbMGkc3PTwePgddeWMXv88r080YSsRcLFqXQk3AIgT3YhK8tvZ5c
	ISQYFXrPeo+wCXzYO+I+Fme9m3QtzvKlY/CRpeeFx/CPmyHcsA4bQIMBQY3SFDSBwHHpgX2nP4QpK
	eX2gzeLYgtKjYLGouanUJdtyId9sicMH5REaw05equr1wp/e2YNgjcTkN931tjukYWJLHDSpuENao
	NdtrgY3oDwjmgz2iaircJRcldCI64rnON/D0BLTSH19eLRdPF5yRrUlhc+9We4tguIe+5j+fwnby4
	T6qoCpVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLfn-0000000Enlt-1HEW;
	Wed, 11 Dec 2024 12:18:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLei-0000000Enf8-41cP
	for kexec@lists.infradead.org;
	Wed, 11 Dec 2024 12:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733919448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7aMbcpFFqiF0dBAcBKoMoUVucO4y8eeE0Sdqq64qUc=;
	b=N2I/h13za/pnNAhoNhl0MBlbS/dssxvVojJzZqaoxgy1K+BTPkBfghmXEaJ5OiCMF5uRGR
	dK/mDfDVvIp4gqdZ1CH5OLuHFYGC5CDf/K0s30VVAGPhlhfQmAcwYWA5WSwvT+WYjZz0od
	uGcAvwQfJGv8NIudK+Exkbeld644Lsk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-6lbncU1FO7WgfpkBEqGqrA-1; Wed, 11 Dec 2024 07:17:27 -0500
X-MC-Unique: 6lbncU1FO7WgfpkBEqGqrA-1
X-Mimecast-MFC-AGG-ID: 6lbncU1FO7WgfpkBEqGqrA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f78fdad0so78178166d6.2
        for <kexec@lists.infradead.org>; Wed, 11 Dec 2024 04:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733919446; x=1734524246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7aMbcpFFqiF0dBAcBKoMoUVucO4y8eeE0Sdqq64qUc=;
        b=KddSnFRwO8/SAW9cu+nJDUyUvJwLh85bNZffTCs0t7yZuH+J4Bq0nzvWu0ZkLhhBgw
         NJTRQg+llw2RNGGS5HX1XcUjurKFMdOcG4XetQiimXLiz5JwwaVPd8aka5Q80MyM5FI6
         YJ9ZXpcPwb3tgDNaW2yGTheki8p+eC5kEQsyow+O0MDNW4qVZP+YfhJfJ9q93TirApM+
         6rohxS3e8UEIMFiEV+PF8EOekSt2/MJh0nECA8Sa44HWnjyFcStaymX4piHCGSu0/FKn
         Iqyu2KKsOsGkTwILqfYX3vBsRc865ZH1oeLoj48qa1xC3cPxP2/sJSqiz5JQQKM6SHwc
         aysA==
X-Gm-Message-State: AOJu0Yyuaa7By4L/TXCji6mJYmU2xCsaxPu1YdXUim/W8z3U1dKmf3My
	HO1LGVabR1FIwjx/dFxQfkuKIvArfm0++RbDvkNhwpSTlDrJmlltK5JEquLqu4kyKVlmZe0L6D0
	WM+ki4KjojrtSw2AY2RLKbCbzQyPCD6Lohtf59FAjy0cns7oigXHhEpZKUBRuU3AGK5jZUV/bHe
	9cAQV7C56Sf5fUC5K50lT4vMYsktOUsj00u7aaiTu1Ci7kkw==
X-Gm-Gg: ASbGncvKEEzjQkFb8oR/Xtps6tS7adCwVyW+6jN6vRZGg2D6aESn3w0YbqegkzoS5CK
	dIyiQQiNXwWL/x+HJBtHgtmkqSkKdSl4Sc9/p
X-Received: by 2002:ad4:4eac:0:b0:6d8:8aa6:ef27 with SMTP id 6a1803df08f44-6d934bc5132mr48879796d6.38.1733919446092;
        Wed, 11 Dec 2024 04:17:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR5usU2Uwf2njGrMCdeUf2miIoLuSU5dFXiK2K1Hy58Kv3Bpm3lWsfT7t4XMVDIzWma0mXbQqkOEAaJ13HCK0=
X-Received: by 2002:ad4:4eac:0:b0:6d8:8aa6:ef27 with SMTP id
 6a1803df08f44-6d934bc5132mr48879456d6.38.1733919445860; Wed, 11 Dec 2024
 04:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20241211025810.242894-1-jeremy.linton@arm.com>
In-Reply-To: <20241211025810.242894-1-jeremy.linton@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 11 Dec 2024 20:17:15 +0800
Message-ID: <CAF+s44T-zA1qP7yF+=E0xbPsqejoQSdcDuHBLriiwA6-T4AFKA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ZBOOT zstd support
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, horms@kernel.org, ardb@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2DPYsOaKwykeke2dJZKemkZZar6udfpyPt_nVn8wfpM_1733919446
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_041729_067109_1ACBEB50 
X-CRM114-Status: GOOD (  13.76  )
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

On Wed, Dec 11, 2024 at 10:59=E2=80=AFAM Jeremy Linton <jeremy.linton@arm.c=
om> wrote:
>
> This set adds zstd compressed image support to the image decompression
> logic. This enables kexec with PE-ZBOOT images compressed with
> zstd. zstd is one of those algorithms which is better in most regards
> than zlib because it both compresses data better an is at the same
> time faster. This is in large part because its written for modern
> machines and is less of a byte oriented compression algorithm which
> optimizes well on modern 64-bit machines.
>
> Adding this logic to kexec allows distributions to ship zstd
> compressed kernels without loss of kexec/kdump functionatlity.
>
> Jeremy Linton (2):
>   zstd: Add zstd decompression logic
>   kexec: Enable zstd in kexec decompression paths
>
>  configure.ac           |  10 +++
>  kexec/Makefile         |   4 +-
>  kexec/kexec-pe-zboot.c |   3 +-
>  kexec/kexec-zstd.h     |   7 ++
>  kexec/kexec.c          |  10 ++-
>  kexec/zstd.c           | 191 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 220 insertions(+), 5 deletions(-)
>  create mode 100644 kexec/kexec-zstd.h
>  create mode 100644 kexec/zstd.c
>
> --
> 2.47.0
>
>

For this series, except some trivial format issue,
Tested-by: Pingfan Liu <piliu@redhat.com>
Acked-by: Pingfan Liu <piliu@redhat.com>


