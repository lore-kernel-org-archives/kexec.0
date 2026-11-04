Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0F606EE80
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U1eMWC9y;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YL0mHBdN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=onQfzVmJC7HohmP0cLeGwtdRODbHCJknVIWGqjziqDY=; b=U1eMWC9yMFMTQC9mpZLpRtOfeJ
	h+iinMb/3NR2EzhzJpxaOxYlwHIZ3+qo9kpQ7rHK1UelDdSbyDMG0K5ouPVfxjJ6ettmO53HfNqsT
	wZKJEpU8gLgrlA4QqeQjNL9XKd5HZ6Brtn7ShZjAaI+goQwGndg2AdCc/9JgyQym+AnZJYS6T3LV7
	I0lGabbpLlZbyRpmVEdzS0x6DmsPjYZOgXqXcxfCi4+xrrWYeEW2op/90nxMz6w+ZgAl8s2vl9BIQ
	mS16UK2h54k9mz26qj/logi+njiEHYCJGeqhauufcpvGpXUB844JQ1morFDrmPiCvai0DNdxvmpah
	PkR/VJ0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObj7-00000005asC-3gHP;
	Wed, 04 Nov 2026 14:12:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObj6-00000005as1-327F
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 14:12:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3CA6943A73;
	Wed,  4 Nov 2026 14:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432C31F0093A;
	Wed,  4 Nov 2026 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801552;
	bh=onQfzVmJC7HohmP0cLeGwtdRODbHCJknVIWGqjziqDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YL0mHBdNDiunlG8rrAEkkTaGCj1hrgX75U4z1Ml7hTgNdeY1G7/Lqev+aLVQR+Qpn
	 TdKK4Vzx6TtBRwXZ0bt3OeqzYSVcAzAuv0DOqjLJZibnLWMQIU/66PYdTMkEiIBUUg
	 oj0qzD5GM57Kb7BUN+tcdPhyVuRQ5maPjgC4q1aYirAW4HGo5HdtYvdCLd2VdgR5bZ
	 xrKT2Zx3kw/mDTMaP3mQK8OQ527/ncS5Cy74zMQDkUzrend2XgDr7ldd3EqnS2iipS
	 eCkX7zd4zq9sxqWgYQwz2VRR/vrIFIjwhVNMy7fdS2JG63WulEzNoe96K2ooNFMRV5
	 mw0Ektf6TZZCQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Christian Brauner <brauner@kernel.org>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 03/10] liveupdate: Allow file handlers to mark
 retrieve failures as retryable
In-Reply-To: <20261103010216.3447716-4-dmatlack@google.com> (David Matlack's
	message of "Tue, 3 Nov 2026 01:02:09 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-4-dmatlack@google.com>
Date: Wed, 04 Nov 2026 15:12:26 +0100
Message-ID: <2vxzv76ck7n9.fsf@kernel.org>
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

On Tue, Nov 03 2026, David Matlack wrote:

> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> When luo_retrieve_file() invokes a handler's .retrieve() callback and it
> returns an error, LUO currently records the error in
> luo_file->retrieve_status and blocks any subsequent retrieve attempts.
> This is necessary when the handler has already partially consumed or
> freed the preserved KHO state.
>
> However, with user arguments passed to .retrieve(), a handler may fail
> early while validating caller-supplied parameters (such as a missing
> argument, an invalid or read-only target file descriptor, or a non-empty
> target file) before touching any preserved KHO state. In such cases,
> userspace should be able to fix the argument and retry
> LIVEUPDATE_SESSION_RETRIEVE_FD, and if the file is never retrieved,
> .finish() must still run to release the preserved KHO state.
>
> Add a retryable output flag to struct liveupdate_file_op_args. When a
> handler sets args->retryable = true on error, luo_retrieve_file() leaves
> luo_file->retrieve_status at 0 so the retrieve operation can be retried
> and .finish() will still clean up the unconsumed preserved state if the
> session is finished without retrieving the file.

Should we give some sort of signal to userspace whether the error is
retriable or not? How would it know it can or should try again?

>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
[...]

-- 
Regards,
Pratyush Yadav

