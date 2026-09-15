Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1645C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 09:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xj97Gm+bFVDZhjwESgxXGsr/TcYPbbFLUTQH8EasuOs=; b=DvC1Bi6B8fs2ije3avKARdA18G
	9nPEZ0uLCC+hsJHb0oS8usGd8Cb5nS6qYFrcOv5o4YxSKy1/8Cjtt35urocKjcStJyX/TG61Gbcvs
	TBTeuCo1n9R+kG1keikMPRBRf9Q1hHePIj0eag1SYrQrDk7oxg18rw0C8FLo5JCGEPXO9798aAay/
	k38S//eBPnuj+iPDtNDl8Dm7soFn+3ebjLjdP+51EVdO7YmKy/X2kI/J0sOJHjEK7dtrsomwaPAwf
	WuhKblkOtGKgERIijym4SwGcH5wmo9w6ItIFkVeYmguX2jHLnE8SR4DKFg2vnAVnmivSfd5qFbYar
	waLTu3jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6P5a-00000005jUK-2TxA;
	Tue, 15 Sep 2026 09:04:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6P5U-00000005jUA-1YON
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 09:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xj97Gm+bFVDZhjwESgxXGsr/TcYPbbFLUTQH8EasuOs=; b=ONO90DiDxTHtIgUgWFtThPVUIL
	BXAlSt4ayxoDAhEG5tpM7bBXuHJBdmmjYOEAE20w03J/05fkhei7QmmCRaB5Jr4DwFImxIVu40/6D
	JTYUUeCPnlv5G42UyEoAw5byK43Cc2f/GER3WxoxxnuygD7Kdt6PZv/orS4zxQP8yl7Et/GfkBxKi
	mj4YMLVX4kxYcX6duq2ScZy14ck0oCBSqPE8k6muFBbO29U9GuUHMUV4MFwFXX7z5FRNWT44GLZkz
	+snNoZHw5kZrOoEZB2OCkG0NeJKlRQH8V9I51FsvyENoDv+hJhDAdPWHenFqVflDEqtlLB+Dyw7yr
	/5ykPHyQ==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6P5R-00000006TPL-1ou1
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 09:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xj97Gm+bFVDZhjwESgxXGsr/TcYPbbFLUTQH8EasuOs=; b=lRl6heYdFmWobjqmP6MVFkL3cc
	hrfWmOjJy7y8JC4vaFY0trfhscwmnfFCx1TYA24UxzrPt41+U6Va+vFZDeo0p8FcrkDmBpzjqVsgk
	JPSe9jy/AB4dPNiYIpvuvQxdT30cSTNu7IIhDxsViLxrY5mk/yPbs+ARWqEFH2WX3MI9gNbnBwrqb
	ytBsRGkqSb7XmPuwpl/2f6Mr7KW5Uo2R/ImOZsT+mPaFhkFGTH2UfO/Dd+a9OIIJ30Hcc4lFqiRhc
	vl/N2nSH9zs66d5eQQM/R4y4PtD/9V0nDRpXZEkq7o/gZMcDF6vJOmqeMv6iu2rs80VEGFFXzMAsF
	oKG4ogTQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6P51-004HQC-0I;
	Tue, 15 Sep 2026 09:03:55 +0000
Date: Tue, 15 Sep 2026 02:03:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, harry@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 2/5] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <aqkIdVhoG2wwVBtb@gmail.com>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
 <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
 <aqKhgPKzRf0e22s3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqKhgPKzRf0e22s3@gmail.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_100421_592802_39F66024 
X-CRM114-Status: GOOD (  12.01  )
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

On Thu, Sep 10, 2026 at 06:11:53AM -0700, Breno Leitao wrote:
> So I'd say we have two options:
>
> 1) Keep it similar to unaccepted memory, with 2M granularity.
>    - Pro : Similar mental model as unnacepted memory
>    - Cons: 2 MB might be a bit wasteful
>
> 2) Move to a linked list like the RFC, keeping it outside of the EFI
>    table.
>    - Pro: Reduce the memory granularities to page instead of 2M blocs.
>    - Cons: Another way of passing memory information between kexec
>      kernels.
>
> Any any other option or strong preference?

Since nobody voiced a strong preference, I will stick with option (1),
the bitmap, for these reasons:

1) It follows the same mental model as unaccepted memory, which people
   are already familiar with.

2) It is simpler to query at boot time, especially as the number of
   poisoned memory regions grows. Walking a bitmap is easier than
   walking a linked list when freeing memory back to the buddy
   allocator.

--breno

