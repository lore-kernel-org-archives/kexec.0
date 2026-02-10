Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E23EA811C
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y4XVuf7fFgdxotUQ4dcsKJCk8Cgp4ZE7n0aGFDw1tvc=; b=lHGCDbV0Iegqd1DjPEVTy/L6VX
	/A9v4jC1qSwNda9L9BOxY4MD9RDB25QpRi4Od/K9XYwgMv9KPhBIt6lJFTrw/Z+ttesXQhpUasYrj
	QD51Re49oTX/srsK6NHWu72mcTJCq1op7twMOPfot/USh3aE0a1CJTXr4OgK6opgOre6+WYw4NPkA
	JbuQ99VfYHSE0nI0l3VLEsbeOVmK2JWbLPuKIz+LFS6zQBfBMHX0Q3U5W+vGxBrti3sble1YBHNdI
	ezhxC44PHRq26XVDLrmBDEVqEQwmaAzAgzqGHni7nfCSrNKeHBULpl+PMLD7Eye67DYuSP/RAMajB
	E3aY3AFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpoI2-0000000H1Ox-10tV;
	Tue, 10 Feb 2026 14:00:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpoHy-0000000H1OX-2lPg
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 14:00:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 03D5344285;
	Tue, 10 Feb 2026 14:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2964CC116C6;
	Tue, 10 Feb 2026 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770732025;
	bh=Qw/RiTLGCC4XlReL7wouz9nXIOGMjkMZx2I4aimv43c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PaeJ5RittgcFyauGs4iFTI03D8aARwFnljv02mb/OI32cyBI880Z0Ao7pV1jeABQD
	 qPJaD63vKD/fQ30QyRvb9cIgbK+IKhGUOd0OAq1rT4luW3hdj+DJpKIEbOBsLumYug
	 2h/alC4i+oy8qxiZoguwXiJZL82N8Ac2i9ERsPk3wlncH01qZjgWXY2l6Cnuw5hBwH
	 nQbj/jZCWMmiiMt7aw44/RyA60jSugr/IJsjhVnJ5MnVJNDmaJj/AfeN1w86NttJqm
	 FRnKfSt/5eF6xGW5FWxFoyEbnEshogxwgeZKSNjcEE+mTk0pHdYV5PQVpTZyjAHtSv
	 z1qVL+7jaNHQQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Michal Clapinski <mclapinski@google.com>,  Evangelos Petrongonas
 <epetron@amazon.de>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike
 Rapoport <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] kho: add support for deferred struct page init
In-Reply-To: <2vxzecmssnxx.fsf@kernel.org> (Pratyush Yadav's message of "Tue,
	10 Feb 2026 14:55:22 +0100")
References: <20260210130418.297153-1-mclapinski@google.com>
	<2vxzecmssnxx.fsf@kernel.org>
Date: Tue, 10 Feb 2026 15:00:22 +0100
Message-ID: <2vxza4xgsnpl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_060026_719077_E6F9BB89 
X-CRM114-Status: GOOD (  11.51  )
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

On Tue, Feb 10 2026, Pratyush Yadav wrote:

> On Tue, Feb 10 2026, Michal Clapinski wrote:
>
>> When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page
>> initialization is deferred to parallel kthreads that run later
>> in the boot process.
>>
>> During KHO restoration, `deserialize_bitmap()` writes metadata for
>> each preserved memory region. However, if the struct page has not been
>> initialized, this write targets uninitialized memory, potentially
>> leading to errors like:
>> ```
>> BUG: unable to handle page fault for address: ...
>> ```
>>
>> Fix this by introducing `kho_get_preserved_page()`,  which ensures
>> all struct pages in a preserved region are initialized by calling
>> `init_deferred_page()` which is a no-op when deferred init is disabled
>> or when the struct page is already initialized.
>>
>> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
>> Signed-off-by: Michal Clapinski <mclapinski@google.com>
>
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Wait. I just noticed that Michal took authorship of the patch. I talked
to him and he said that was by mistake.

Andrew, can you please give the authorship to Evangelos when you queue
the patch?

-- 
Regards,
Pratyush Yadav

