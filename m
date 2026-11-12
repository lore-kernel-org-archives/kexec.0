Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A722606A8A8
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U7K3XgNT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPVSqwts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TIJ/B4xCXlnMR973pp/iagBmP0zyby+RS+bYxCX6O/A=; b=U7K3XgNT9WHN7zql436hxISEmd
	ZOiZBCfkw3GpbcjqAxxVrbOzxzEokK4PPNqdG3RjDhXJSwLC+yQ0FwT19Pb8MoDIgmrdqqnaUrK/B
	KBXwEefmIm2N4nLtFHY8IdtkCrmvOpUrOUj+O3MVX6m25Tw17Wl0cm4b6Ebr4dNu8Fxs47KAaHR+d
	a6YHO50yh9S7TdHZu4oCsJHU/Ug+n5S6MOHrMACp3ts7J2O/Jt/BVvuJk7f2R2SFTChk41cnL//v6
	/7l/osE2lf7V/oJHKEJAwGc084VEsmlrNawRLtbvvCdPsIyjNCpiMOurRCO9WragzEwXcNrPSGzKl
	IKucP7lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUt4-0000000A4bP-3hfT;
	Thu, 12 Nov 2026 13:30:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUt3-0000000A4bF-25Qk
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:30:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 09BE441332;
	Thu, 12 Nov 2026 13:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA581F00A06;
	Thu, 12 Nov 2026 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490244;
	bh=TIJ/B4xCXlnMR973pp/iagBmP0zyby+RS+bYxCX6O/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gPVSqwtsS4+iVC1025PcArimiK7ZsHRGSfLl/9vWj0OFRDu3FHfI2SLPjoziXSFGd
	 tCksDvCxQdG6NdNpsUcKUfbfZFW61q1znvRx0Qpmku3wmIYklPB4XX6DhKQYXGaKsu
	 Xbu8aacc3lRj6gAcSN/lrVVf01PuoNk5mZjnlcQJFKlFMAcHSyCTa73yoMurgPflNC
	 +UAz8LhHJ0LNk3h5Bm4EgtdH5kI6Vqv03I2ajqOCLPe4CMU3GGMoZS/guUm46MlYOd
	 hXbG+m9rvuttdDpzt4Bx5O6QJ2qbbqx/z/Rw2dFI2uULXT/u3EvIyRvFjV0WfHh5Rq
	 hE44LMljP4V9g==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chen Pei <cp0613@linux.alibaba.com>,  George
 Guo <guodongtai@kylinos.cn>,  Kexin Liu <liukexin@kylinos.cn>,  Randy
 Dunlap <rdunlap@infradead.org>,  Shuah Khan <skhan@linuxfoundation.org>,
  Sourabh Jain <sourabhjain@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v3 1/5] kho: reject zero bootmem scale
In-Reply-To: <20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org> (Mike
	Rapoport's message of "Thu, 12 Nov 2026 12:38:53 +0200")
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
	<20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org>
Date: Thu, 12 Nov 2026 14:30:40 +0100
Message-ID: <2vxzjymigosf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12 2026, Mike Rapoport (Microsoft) wrote:

> kho_bootmem=0% sets bootmem_scale to 0, and then the bootmem areas are
> sized using the explicit sizes that default to 0. KHO remains enabled,
> but there is no usable bootmem to load the next kernel.
>
> Reject zero scale the same way zero explicit sizes are rejected.
>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

