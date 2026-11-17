Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37A606A332
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WyQX2KfE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVNFSdox
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=imUJWBchit9SuVHDzuMNjlSPoobNZbAUtuLMrGVWVHg=; b=WyQX2KfEag25XTCwaxTtlROkSa
	XjoKn//Al9RO/RNx8tAHrmibVWwzK+8ymBUE3HPoUcpP0TJ5EHdKixXIephbbuEYfS2G1MfdYVSxY
	vpaT2/ATUg++YyRaszarmPHnfdYKv7WZPKYKM6x0OJa0g3mKHEOpHd050XeG1w8JnArMjn7m511SH
	iINYiOpsjc8TishueeSREfDYLqAKcOWvVwPApNcfZgOJhxdt/1D4nRxdj632nAMxOfu/KbNfEpDZM
	PJFnaHxi2a0QBkTt9xnMwvorYr1twxXBE1bvFcV+0RdBiOOEnV8fSSswiZVvWBq1yoinJL6geU3tN
	RfhI+60A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTGcn-00000005JLw-3GHp;
	Tue, 17 Nov 2026 10:41:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTGcm-00000005JLO-2pE3
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 10:41:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A40844DFC;
	Tue, 17 Nov 2026 10:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A95B1F000C4;
	Tue, 17 Nov 2026 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794912076;
	bh=imUJWBchit9SuVHDzuMNjlSPoobNZbAUtuLMrGVWVHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CVNFSdoxu4l/nj9Mm2t0iUMPrhaOa4wgFFHGazUP4pNZG3iVJogqLdJRtgEQF9czH
	 m4snTDqFKQ3MkIbWzh75EhHd7RnhaUXlGRkmsSWK112fFsCxKPzMuuvptHfqjccnnH
	 tnzU+NfrXZvW1AvcjOKxICz+exYDTNTQ142SIYK3sfM2NPToO2s8hPj3GUpd5AOGUF
	 1NUYkeSmlrz4EDqLtJXzjVXoH52BxzV3TDyAvmeSzGON/Bgtc+8wbu8p94EZ8BP/l+
	 IwkQq2f0NbmR4zpxS7teFcFqKIhRYFA5/ELcuVo73JX7yC2H+qT7BbYZYlTwqY4T54
	 WQXZrrz9MeoBw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Mike Rapoport"
 <rppt@kernel.org>,  "Alexander Graf" <graf@amazon.com>,  "Jonathan Corbet"
 <corbet@lwn.net>,  "Shuah Khan" <skhan@linuxfoundation.org>,  "Randy
 Dunlap" <rdunlap@infradead.org>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  "Tarun Sahu" <tarunsahu@google.com>,  "David
 Matlack" <dmatlack@google.com>,  "Samiullah Khawaja"
 <skhawaja@google.com>,  <kexec@lists.infradead.org>,
  <linux-mm@kvack.org>,  <linux-doc@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] kho: build KHO objects into a single kho.o
In-Reply-To: <DMWWRQTLNYH6.1LJ2K5HT60LK8@soleen.com> (Pasha Tatashin's message
	of "Mon, 16 Nov 2026 15:13:23 -0500")
References: <20261116134013.1636689-1-pratyush@kernel.org>
	<20261116134013.1636689-3-pratyush@kernel.org>
	<DMWWRQTLNYH6.1LJ2K5HT60LK8@soleen.com>
Date: Tue, 17 Nov 2026 11:41:11 +0100
Message-ID: <2vxz5wxvhha0.fsf@kernel.org>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16 2026, Pasha Tatashin wrote:

> On Mon Nov 16, 2026 at 8:40 AM EST, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>>
>> kho_block.o is part of the KHO infrastructure, but is currently built as
>> part of luo.o, which ties it to CONFIG_LIVEUPDATE.
>>
>> Group all KHO objects into a composite kho.o, built for
>> CONFIG_KEXEC_HANDOVER, the same way the LUO objects are grouped into
>> luo.o. This also gives a single place to add new KHO objects.
>>
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  kernel/liveupdate/Makefile | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
>> index d9f4694625567..bc679905ce3f2 100644
>> --- a/kernel/liveupdate/Makefile
>> +++ b/kernel/liveupdate/Makefile
>> @@ -1,13 +1,17 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> +kho-y :=								\
>> +		kexec_handover.o				\
>> +		kho_block.o
>> +
>> +kho-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debugfs.o
>> +
>> +obj-$(CONFIG_KEXEC_HANDOVER)		+= kho.o
>> +
>>  luo-y :=								\
>> -		kho_block.o						\
>>  		luo_core.o						\
>>  		luo_file.o						\
>>  		luo_flb.o						\
>>  		luo_session.o
>>  
>> -obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
>> -obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
>> -
>>  obj-$(CONFIG_LIVEUPDATE)		+= luo.o
>
> Please send it as a separate patch. I have the same change included as 
> part of the kho-ro series, but let's fix it outside of both series 
> instead as a standalone fix. Also, maybe rename kexec_handover_debugfs.c 
> to kho_debugfs.c and kexec_handover.c to kho_core.c for consistency, now 
> that they are not shared with the rest of the kexec_* files in kernel/*?

Sure, makes sense. I have a few other misc cleanups in mind like
re-organizing some of the KHO headers. I can do that all in a single
"misc cleanups" series.

-- 
Regards,
Pratyush Yadav

