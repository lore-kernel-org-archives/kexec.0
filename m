Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1199606A331
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SqXfBaEd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfR8WLKm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kkl+icFjzxE01q0Je1m7UUl7PHHf9qq5oQVDLnVQrE4=; b=SqXfBaEdajPhni2XdJh0unbO7T
	k8OpGgcMaJ4eCf9YtICUw8KwUb3bXEdCQF+LnqMjUSZg6CEP7Wvc7eiDb3SdWtV7l9VX6OLVGFGvc
	FTfYRcsR9GZh/zFAHSg86QoKZTPW7KGCwUbyxa80w3LUEW6GC1q4owHRl3diIVVATYZUy07Nq9kyo
	AgbWh6Tt1BvO4/eeGIU2V7HDEpMW3li0e+uxZSJiBBDUozEOlbkpISFMNR+mA7wHXfXN4BXQezitL
	wMFNv8WKp4nsMhIEJyAo2zdDDyWW6MMtpptEdu/on8Qy+9XKOMWhNAPShLNoa3vFfWY67rCkUpnoH
	Pk73k8Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVAl-0000000A8m6-1ogl;
	Thu, 12 Nov 2026 13:49:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVAi-0000000A8lG-2G7V
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:49:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 25726403E3;
	Thu, 12 Nov 2026 13:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE841F00A05;
	Thu, 12 Nov 2026 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491340;
	bh=kkl+icFjzxE01q0Je1m7UUl7PHHf9qq5oQVDLnVQrE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BfR8WLKmKOsDXaKLiM1Ug8DXfW2zJBjiN9fzDTa5EwV3z/sxUhZlb7IASSQ96U421
	 Mt4TsyTelm4lALktExl12zsgk/+O+uSElGKX4+AShhNRldi1RycsYF4np8RLDt3NZp
	 8zD45kOYeEt6mwyEf0cEPy7UpQBZWN7nmcvPQqBD+YWWwG/W2vcy03aA5x0fytDeNn
	 fygblzfkCt0nOWp/i5DNrXmtHLKMLXPo2+xEYTZjGBMNgySpYJ2Btfzk6TE9FopFdb
	 FX0hHNLxoFBG1EABRvXPDQGLR6rN+Ep1ph0B9qT/pSsNowZHegrNPUMrgsc77wzFlV
	 2GfEPlkisak9w==
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
Subject: Re: [PATCH v3 5/5] kho: docs: update description of bootmem regions
In-Reply-To: <20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org> (Mike
	Rapoport's message of "Thu, 12 Nov 2026 12:38:57 +0200")
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
	<20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org>
Date: Thu, 12 Nov 2026 14:48:56 +0100
Message-ID: <2vxzcxsagnxz.fsf@kernel.org>
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

> The description of the boot memory regions does not mention the low
> memory region and claims there is always a region per node plus a global
> region, while the low memory and the global regions are not allocated
> when they would be empty.
>
> List all types of the boot memory regions and describe when they are not
> allocated.
>
> While on it, fix grammar and split the description of the regions size
> and of the CMA usage into separate paragraphs.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

