Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8F6FDEE35
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zC/Rvuafxmv1NRQo19/P/Pi+8hYq1qGRsY1yAUjYcA8=; b=k01VjCHIU0AQ59551Mwcv83I2B
	KTLEq6s8+o5byF5GsufDQN98e0XkXShpH2aiuUfdJEVvnT/xJETO18+vbLiDp39nhgAdgCiId5DDY
	M/7t0tP4Os975RSobVsUJzpn009xHwQswWh8FwvudVjChvvqbB9JOW2J0pVRRACdWQRKpd/S8av0t
	MvItrZd1larvfMI/JVT0oFalKGc7YHwQ0IJyb/Im8KEzVxliK1wfKDyb8BPRKGImxnxyn6uLfAZn7
	1wpdNIkSXEczhLBVnXCzlHLzkMwkqAD59EnmpyEKS3xdbp+fPcilo5yObL2JayfaOiHIuOoSWXQiU
	1FHfxTFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFy63-0000000C4co-1Hko;
	Thu, 23 Apr 2026 17:44:15 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFy61-0000000C4cQ-1UV3
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 17:44:14 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-506aa685d62so35781251cf.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776966252; x=1777571052; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zC/Rvuafxmv1NRQo19/P/Pi+8hYq1qGRsY1yAUjYcA8=;
        b=LhwxfMxErpl99YBcqBdz3N+2Z9Dln49pGiowNy0t54z1K7QgMnHGpEmSj7XnsI7hpu
         qPlT037M0RfV5Vu5mbtS7/kAB6tu/2vL+WLgLB4NGUxX4W2rKHMi2w8GmdsUWQ47EBrg
         PYMyHI1j93TVNCnTbb+UJDAvV/dQl70BJV7yavugz08nV6hxE0DBcqfAh8ZV7kQjDK93
         LWcb1+l5p3jzeKFwTqiNqqJRVxictHJZQCP04abyrvE0LUyASqYdcFyvUEPiUAYzgOJI
         f/78nNo3pIvOo9B3GUY5kG2mrpmp+fATmbEL8O24imt7DyDmr+IRwNaAihxnFEbjmPo6
         znxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966252; x=1777571052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC/Rvuafxmv1NRQo19/P/Pi+8hYq1qGRsY1yAUjYcA8=;
        b=PNWcszxwncKcVlSewM4vZ0mMsJibffI51PnI10eckFxQZRnao+X3a2JsyHwsrFzRYs
         L45Unx1Gu1bxP1AucRjd34VP12+Zo7ZvjxHSDuTiF6usOEkkZXN1AYRBACN9pYclXpXq
         CkswgK13IrrId7R+48Wqdb2TaKVjiIL5PBAw+p6jBzKSTtxPhL248/xlZal/NfDfWO7h
         UJ8kKaHsvom3FSBhp/T/xJD+nC32kBP9/5rv1tsxio2o6vqIGm2YlMlO3nvCBssa5nKf
         JsERiQkLGGyl/+j9ww1neA+oCC6HjT59adfAGVLysMf46BaINDDBh214lb3VyBfesIrL
         flxg==
X-Forwarded-Encrypted: i=1; AFNElJ/s8dm/c9OvSnemfrPXTSSRRczC3KWHOkmJunOr794qp9b7Mm2z3nSdndthMaJkHlV2OF0lGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwQLlMneHU+Avf1aVrbPk69ktGQjxFi5Qn4P2sCIx4PmWba0lxw
	CP1OwKZCsNDx9WsWhxYtwPdT1Sw1uNxKgiwyh3pLmRm0zuvkXc9bKD6nvxYBK6L9CM4=
X-Gm-Gg: AeBDiesV8cTlW09P+/4h6y+FyC7HNYraH2YiY64om9JrSXXodCQSP/k9yvlCsOAqFOP
	afEuuJo5gwalvjXGWOhUNFivfHZloejlU+/Tr3l34dMF9UvacNX8Hz5NvmzrxoodMcfjh8KtQN3
	atOWZ1nD1Cd6/Fx3g659M34Nl2gzVNJvtEaQrWf3qGUR3DYm4t3d9gBEkegdFsSWCeIXEmgAdkl
	JPLxucIxNeYubwnvuwiiTkjV7Yr6MnprUg9ywS/fnp065VOIehxPZOZI/tjTAJPd5CGynBK1P2G
	y4ER2jGP/ydImTy06xaGhZw+E0ZgGkT1IKUIfdaLgUHycjBmidbyBVVS0zzkBVR64WfIIE4lXhL
	LVCrXgVDqCrINbJS6gRmQFxB/hwOcBr12sibzf0eucZTuZPdv2EXqUjef6xOcmS6ba2BZt4uqbz
	ODRkSHeZhY/yPVDFt6LXHwm5fg77d3ZfsakDuo+Nmf43Kc29/ZTkaRzJae/YyvPQ==
X-Received: by 2002:a05:622a:5818:b0:50d:65ec:a071 with SMTP id d75a77b69052e-50e367fe18amr407627591cf.5.1776966251944;
        Thu, 23 Apr 2026 10:44:11 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae61332sm156030426d6.24.2026.04.23.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:44:11 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:44:10 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 3/3] selftests: kho: test with deferred struct page
 init
Message-ID: <aepaWxfdHWT4Q-mi@plex>
References: <20260423122538.140993-1-mclapinski@google.com>
 <20260423122538.140993-4-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423122538.140993-4-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_104413_403231_20E5B58D 
X-CRM114-Status: GOOD (  10.86  )
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

On 04-23 14:25, Michal Clapinski wrote:
> Enable DEFERRED_STRUCT_PAGE_INIT which depends on SMP.
> Also enable additional debugging options.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  tools/testing/selftests/kho/vmtest.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
> index 49fdac8e8b15..0014bd76e88d 100755
> --- a/tools/testing/selftests/kho/vmtest.sh
> +++ b/tools/testing/selftests/kho/vmtest.sh
> @@ -59,10 +59,14 @@ function build_kernel() {
>  	tee "$kconfig" > "$kho_config" <<EOF
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KEXEC_HANDOVER=y
> +CONFIG_KEXEC_HANDOVER_DEBUG=y
>  CONFIG_KEXEC_HANDOVER_DEBUGFS=y
>  CONFIG_TEST_KEXEC_HANDOVER=y
>  CONFIG_DEBUG_KERNEL=y
>  CONFIG_DEBUG_VM=y
> +CONFIG_DEBUG_VM_PGFLAGS=y
> +CONFIG_SMP=y
> +CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
>  $arch_kconfig
>  EOF
>  
> -- 
> 2.54.0.rc2.533.g4f5dca5207-goog
> 

