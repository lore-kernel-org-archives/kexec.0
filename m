Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7545606A338
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TA3Lqkr6;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=TysgCoxV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IZ9VKwNlWQHUSDTdUub0LUYCE8kQAhoKBrGZa45rXWk=; b=TA3Lqkr6QXfPWZ
	iQg/fWUy+dAmaq0tUmd5BkZAS9j4MH86CKYLbKexNKJLJAQkvUX87/zykprR5iHZO58mB0MKA7SZg
	lYh8Q/LnTsT3+1U4AD+fE9dUPuXrG1qhNe/t5pvGMdtcwPyUmK3fvyYBsGWJL8daLhZ8TO0bXnRP9
	sIOIIp7b6vtUOMtKHQvHrbwIBaxJv3uDpKu4eMjlusX6PXHpaoUtBQ1kwkHc6pzXPXmbyG/cCnzrW
	mBG7gR6M+/GoFrR2lIAbZNKTK6hXwCAAasJ5k7ARTPIa/ARl0jLObxREX3aEcap7xctNaWmI9gZ3c
	LODdBnhWZ/VQh1/Nefkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgAk-00000006UAu-0fVO;
	Wed, 04 Nov 2026 18:57:22 +0000
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgAX-00000006Tin-1N90
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 18:57:16 +0000
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-998d151f441so295169241.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793818628; x=1794423428; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IZ9VKwNlWQHUSDTdUub0LUYCE8kQAhoKBrGZa45rXWk=;
        b=TysgCoxVivOrx0/BJJ1EcPEy2BmyHKBlr/k/S13DjV6J+990rXaVvVgPQyBGZHAdyN
         yGBmL1M91aB2/h9LBM7IrJ9rL+V/zYwJ4nCoxSae2Adz1sNszf+2JbWv6trtod2a9PZZ
         BUDNdUYSl9naelR9RfJUJMFdgM+ircB2m9CXTaHZ8wxDH2/3HzZQ75yebhCDMm8dwSyU
         ZTSIiEUnb3Ltqgj1gVyTzLvHmWDxofbmTMKgF96LulW5GEWU2/cIa+UXXtf5JMdkg9wS
         SxcxwibTe7Mpbw6lwkgJS2jd58kVmHdAk4zT45ViIYSxWGH/aMXH0v7PsquHuKaPpun/
         QLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818628; x=1794423428;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZ9VKwNlWQHUSDTdUub0LUYCE8kQAhoKBrGZa45rXWk=;
        b=OmPPgWin7YYxfiZvc35AcYr5N747oRGlK0/gXeaAZOm2nF1JoGgtVnliYEHM3ddM45
         noPBce9enlg3MLOMYXUJIyO6ptMlYXBKAYyC+Ynzv2y3Z86vimGmwGO9ZohFXrH0mAqm
         Dt2gyN/VA0CmVSoQ4QGEV63xsZHqn3pRxtzfC5vmABZrzZF3O/hFhI+4aTHRBdPbFLZ5
         lxq+giy+Jq10LWx6URL3jXuTZlOEvMWOg3B6mOcb08NGyT+D8+VK9Mdaf8Gji4MthcVp
         mp6iIu6hECtmwDJcMoUAUr/nBaJ+ZzECJ0yFC5V0rHJY9WQfJexVt1T34N0gVlvTUxTW
         WmXw==
X-Forwarded-Encrypted: i=1; AKwUvBy/oLNrs82yg1swl1b6GvjpPWuqqj3jUU44TkB4zoQ6u6bQSp84zkBPjLtONeJQs01J7VqPpw==@lists.infradead.org
X-Gm-Message-State: APuU4Z/O4h8EdaVe6xA7uYwca+58vtqIaCvAK66uGAYN5iHsQF4EP0I2
	MT5ZTTSKaYbAdFlNQOcU7O0rasspUAckCLBeRlznme/apUSddmWdFDrZ3FlkbkdnINY=
X-Gm-Gg: AYBFou14KliD5FyBgjSQig/A206IM3xI7sOKiCrxbZTVsmPDQyxI8sWNiS85q9qEX9C
	WhCluP0OA4qswHxDj0Nxpp/swnplWjBSGjTHFSNbO7yi6HhptnOrv4ah3bI9LC7A/agsx6fw5ZJ
	6lep7UmH8Wm8wO3S2u5U3ead+6F9XhPN5B+Cl+ggSKiIU/C7O8fO/bmYR/rQ6XE4T33Q17z+BO4
	F23qvg2Wti8LHpiEz6P3p9wijh3JCqVfKmV/BCqDckIdcIbkFEMyKOzGjYV4tcykkyrJPUrKPRW
	1oI+xhMKwFv3xfSgdSMr9OA04LHAo8NwwGgSh6UjO8rBUG/vGl/9oVFUgPllX47CSFVF13R7rYy
	Lo5rbDlwvsHera7Cnkb1wLhKLA3MWj3sZSlpuBfwmsQe/XTLqtXHAooeTAwl0bI6CQUaJbHAgrn
	wSdPdg2KwctHtE6h+HNltvreC7zeO0kDuB2TLEh7cfzlXElc6tT5sdLyfaqRF7DlFE7DDwTFS6q
	mRkzi2inAEvKMXiaE7MFYpHarE0M5HNg8uQ8DPFJccrYeJmm15pVBW7ynkKKb7XieZD2pMwndMW
	ERcoTcgKW445ABWAehaUcMjAMVwSG0WxYqt5dItVKbWWsjCP113hSuLW0ytkVgD4USYUMgTMTFr
	hfhu9EpT2DdFc+4yAfVxo2gCRUwh9lNkT/Scih7udemKG
X-Received: by 2002:a05:6102:6cc:b0:7b5:7cd5:2a1b with SMTP id ada2fe7eead31-7d072634fbamr5914702137.10.1793818627742;
        Wed, 04 Nov 2026 10:57:07 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm736210241.9.2026.11.04.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:57:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] kho: walk bootmem areas in address order
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
Date: Wed, 04 Nov 2026 13:57:03 -0500
Message-Id: <179381862319.2089669.3389816529046759968.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=765;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=DDkD8JSCYr5RCeQfuJIIi1Yq5YW3znOE6F47n0yvgis=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq64ABQgh991wmWzNfvO9Qyexu0ErvASNIQxj0u
 FQn5xjnR/WJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCauuAAQAKCRC7dyhM23N6
 3lOvD/9RGW9gp0s0uJweY/yummMqVsr2SGqZNj6EGSPHNlXQmnWsxASxm7OJ9Vse40GT49GD+Ln
 kKoDGlELs1gC/2S+p07IIGWU+YOXN3mdiJ3WDchwha8Pjbw+WkYXrVziUAniPdr2o3/g6tQ3aBO
 GeeYGRK2ZA+cMpQlrKZ8BD0sI9C4c/Ago5YACznGJWbXdrmP53hL2feaZGuP0e5ZJjL6//yUjQ7
 UNwj4WA6o/SlAsZHWhPcTCFp2hbVmQ2Jppyvbq+vN+jsCJcAm69GEnQhzNfGOmn70Gsrr0ulGWF
 Z6nnsfLjpGwca/Ni2NWsl83PcqB88BqIpx7+wTNMQZdRTT2ZFEW3DVt1rsXDqxepV67TiWnREJO
 02GhYi3tuXCZTlgrRwyRby9wJbdILAQMEJqzT2wqeLbyRZpjdxhRJAe4srjeidOozyvFc8OGUEJ
 9GMxnPDY4/nCZWw4UmRSk+7++9H92jrkQy9circt8AbHQEWOWtlffF/We7VZroa+b2hWnZzHY1A
 yX+EmUvHDO017w7by5v3DSX34tON7P2hxHBfIo7PeE8S/FDtrt0h3nTn8M0i3ed1yhWAHtvuGbf
 7Zjq8sKqzVdT2BLuJiGiKxO939WgyGsZXvEIzBK3cBx0dXE5RnFI0vihWDLWgyJsdQ3+AsmXXIc
 WYdLSQfHpUQTV3Q==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_105709_431131_C8F4763E 
X-CRM114-Status: GOOD (  12.72  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 18:50:09 +0200, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> kexec_add_buffer() users may depend on the order in which memory holes are
> searched. For instance, arm64 places the kernel bottom-up and then
> requires the DTB to be above the kernel.
> 
> kho_walk_bootmem() walks the bootmem areas in the order they were
> reserved, so if the kernel lands in a small area at the top of the memory
> there is no room left for the DTB and kexec fails. For example, on an
> arm64 VM with 2G of RAM and kho_bootmem=8M,64M,64M, the lowmem area is
> reserved first at the top of the memory, the kernel image takes most of
> it and kexec fails with
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


