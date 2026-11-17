Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5DF606A31C
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1nammLVe;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gjy216fU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ELJIm6lhttTjycsb10kvfPy2zAiQZ1koJX28BayYPoo=; b=1nammLVe5oTHGmk0DstnnxlY4V
	Gugv5x/YVux3/GExB1xrPv8PGVNoU2hq2M/IOLWaOgA1C5RjiJ2rhpMjIGcwUAiIDbvcePlEAP8E4
	9IXSLuXjvEkZE+6tzFBFPbjMbGeh9ZRQdvDVlvdcfUNUdYDdLcPvkUxihhNGxOe1729CwD5VOUl8R
	E6H7qieNYCiYkC4csxTE7lSSx9VGh1Hat345Jqp/OOYLY0Hu7ydgYDWVa4+4K6Z+vWoS4RVdyxvyd
	JwLeF+W2d4eNgYj7vTrgtaq1v0bqiXDi5uFibqDLuRx6AVq3y5f0FHMMMTpijHZduZndrtJ02GpkI
	3Hc+XSFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTLDh-00000006JHA-0Hu4;
	Tue, 17 Nov 2026 15:35:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTLDf-00000006JGt-0wR4
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 15:35:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 588C260E87;
	Tue, 17 Nov 2026 15:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DC71F000C4;
	Tue, 17 Nov 2026 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929738;
	bh=ELJIm6lhttTjycsb10kvfPy2zAiQZ1koJX28BayYPoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Gjy216fUZNGD3yQdI+Uehx/94ckIhB71hpnfAE/TwX77hKNYh7ZxHFGnWd/CpdRTE
	 +NBD/byRDYwL961hDWv4FBOGSkhBYakuv9Yw5LKP+wS5BHkOAVfWkQMVv6oHF1p34v
	 5ixOOVMz/QSBpbUMp4yMQxTsAcLQVkxQ3Dq02JmVAdo/VMuWdy2y2O6/OT1Ij6dccP
	 1ldK9PhCVJkUIRU3Gd4FvTcgyqX+ACy05ea555OpIyF4USEQn17AneqZL4NoLnObqG
	 6DZ+IEHCw6JYk7NDqQkoJKxkMrV9HZSPljz7LTWG5Dm5qWA3MuNc12/o0HgInhkf3Y
	 i5UwP28sulVEw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Shuah Khan <skhan@linuxfoundation.org>,  Randy Dunlap
 <rdunlap@infradead.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Tarun Sahu <tarunsahu@google.com>,  David Matlack <dmatlack@google.com>,
  Samiullah Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] KHO map
In-Reply-To: <2vxzwlqbfxtf.fsf@kernel.org> (Pratyush Yadav's message of "Tue,
	17 Nov 2026 13:26:52 +0100")
References: <20261116134013.1636689-1-pratyush@kernel.org>
	<179486913878.127049.11178890384802388709.b4-review@b4>
	<2vxzwlqbfxtf.fsf@kernel.org>
Date: Tue, 17 Nov 2026 16:35:33 +0100
Message-ID: <2vxzpkw3fp2y.fsf@kernel.org>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17 2026, Pratyush Yadav wrote:

> On Mon, Nov 16 2026, Pasha Tatashin wrote:
[...]
>> Instead of caller-chosen depth, the tree should grow (and shrink?)
>> dynamically bottom-up based on the widest key.
>>
>> Plus, with bit 0 tagging leaf values, 2M entries can be stored directly 
>> at L1 and 1G at L2 (on 4K pages). Even for huge memfds, the pgoff space 
>> is much smaller than 64 bits, so in practice the tree stays tiny in 
>> depth.
>
> I think it is a good idea to allow dynamic depth in the ABI, but I am
> not sure if we should deal with the automatic resizing just yet. How
> about we start with making callers specify the depth (max index/pgoff)
> up-front for now? The ABI stays the same, so we can add support for
> dynamic resizing later if needed.
>
> The reason for this is to keep things simpler to begin with. That said,
> I don't have a _strong_ opinion about this, so if you insist, I can add
> dynamic resizing from the get go.

I take this back. I went and looked at how xarray does it, and it is
pretty elegant. I thought some sort of rebalancing would be needed, but
all that is needed is to add a level above the root tree, and demote it
to a subtree. Similarly, for pruning, the subtree at index 0 can be
promoted if all other slots of the root are free.

So I'll add dynamic sizing and reparenting logic in v2.

-- 
Regards,
Pratyush Yadav

