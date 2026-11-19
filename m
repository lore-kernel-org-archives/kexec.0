Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C9606A320
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ufZKcFVg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1HivhvE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eHUpe68o0Gyuu9bj/dGXGOLZdSYedum7yw58Zv5M3uA=; b=ufZKcFVgKnSTa336gmxl35J0ID
	aG/NuRlgwslvbl2oeDhKYpcgwA6QN3R8raigyCoVeH7eB2XbXXF+ow+TOVVRY1FlvKz3L0JbLi4/F
	1c97B6dKz2g8hXp/zXEX72rbhSBRp4CsDpsOLTsOHEmc/Zt8Ts70G6DRLhTbKkivoWJVVD/Sa1DIL
	2FStwFQO5jHlrW6/qyx2+jF3vNbFowW13DuWInmqqVkApgIoidFo+0hoDEoYug4bC7GcQLA+TqOEw
	LhwnXdkbmyvGelsj4IhAv9+0RPslNGGnJNmwrBVj4Sawy20iqvpqTsBGQRsnEBAgHUQEDNHpOLz7V
	Fu2pUBrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU6wN-0000000D11k-1hNY;
	Thu, 19 Nov 2026 18:32:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU6wL-0000000D11D-471J
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 18:32:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C361612CB;
	Thu, 19 Nov 2026 18:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B8B1F000C4;
	Thu, 19 Nov 2026 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113176;
	bh=eHUpe68o0Gyuu9bj/dGXGOLZdSYedum7yw58Zv5M3uA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=M1HivhvEpmZhxvpmc6r4vY/xkVZfSRaCfhSFVKHd/NQDka6qnq0Fp9Kvm+5I3xtSH
	 dbjOov2+k/DqmIL/4QGh/tM9Kbj/yRQqtitg6TO4IgomsOdmXo+1qfYJ7fX41Mtmdk
	 Ru4RaHbHdV8/FDguWGdnmCmot6FKWZS/SqWbYdQ+ZxiQ0niM9MaksfAW9mVYmMFTlx
	 xfiL4oTqokVgXiatdDe4PHjbngJ1xHt3PKYntRv+VX8gi5OYskfFDabFoJ5PvjITkt
	 BWwdwFeLrVLpeJDssQC1Fm+tO5xkvNPOJEYOS67LYR7XWVHzGp1bcnXF9XrMuRa5Vj
	 prGC4UZqIlxFw==
From: Pratyush Yadav <pratyush@kernel.org>
To: sashiko-bot@kernel.org
Cc: "David Matlack" <dmatlack@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  sashiko-reviews@lists.linux.dev,  "Alexander Graf"
 <graf@amazon.com>,  "Andrew Morton" <akpm@linux-foundation.org>,  "Baolin
 Wang" <baolin.wang@linux.alibaba.com>,  "Christian Brauner"
 <brauner@kernel.org>,  "David Hildenbrand" <david@kernel.org>,  "Hugh
 Dickins" <hughd@google.com>,  "Jonathan Corbet" <corbet@lwn.net>,  "Liam
 R. Howlett" <liam@infradead.org>,  "Lorenzo Stoakes" <ljs@kernel.org>,
  "Michal Hocko" <mhocko@suse.com>,  "Mike Rapoport" <rppt@kernel.org>,
  "Pasha Tatashin" <pasha.tatashin@soleen.com>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Randy Dunlap" <rdunlap@infradead.org>,
  "Samiullah Khawaja" <skhawaja@google.com>,  "Shuah Khan"
 <skhan@linuxfoundation.org>,  "Suren Baghdasaryan" <surenb@google.com>,
  "Vlastimil Babka" <vbabka@kernel.org>
Subject: Re: [PATCH v4 02/19] liveupdate: Pass user argument to file
 preserve and retrieve
In-Reply-To: <sashiko-outbox-209934@kernel.org> (sashiko-bot@kernel.org's
	message of "Thu, 12 Nov 2026 00:31:05 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-3-dmatlack@google.com>
	<sashiko-outbox-209934@kernel.org>
Date: Thu, 19 Nov 2026 18:32:50 +0000
Message-ID: <2vxzqzgg3c4t.fsf@kernel.org>
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

On Thu, Nov 12 2026, sashiko-bot@kernel.org wrote:
[...]
>
>> @@ -995,6 +1052,6 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>>  				 struct file **filep)
>>  {
>>  	return luo_retrieve_file(luo_file_set_from_session_locked(s),
>> -				 token, filep);
>> +				 token, 0, filep);
>>  }
>>  EXPORT_SYMBOL_GPL(liveupdate_get_file_incoming);
>
> [Severity: Low]
> Should this pass NULL instead of 0 for the const void __user *arg
> parameter to avoid a Sparse -Wnon-pointer-null warning?

Sashiko has a point.

With this fixed,

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

