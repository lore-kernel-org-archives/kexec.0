Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245CEFF885A
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=824fW5VJr8kTEo1jJkOZf4ojp49EPJyPH98EoCje4gY=; b=hLhT6IC3XWclFBjyDJiyJI1UHe
	3ld81wsG2+VsyF3rxxn6OseV6GgLoWfj7Kb9QFGGtT6ummG+NKHT/Uyub2Lhh823HwQthdF5BiMUx
	RRuUaKTOxmqwoAKLjrsm3WsP7G8TlNg66HukCOaEfDXALzgccFcK5JSA2QX7rUzt43IZh+mxjns3n
	LySXm5PGwdJ/xaUyUj/XQS1s7p+BHUt9wGf2ynFcxvx9j1bb1lVLniNbVAS3zf2DurvJmQb7VUJq/
	9JGaeAojPG6LdywgM7SULVDpunTuMVG8LZIBSqiQux681i33/G9G+81Rln7J2fzcAudx/gEN91Rv+
	vcqPWc1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKDp8-0000000G2ON-480s;
	Tue, 05 May 2026 11:20:22 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKDp3-0000000G2NI-2vtn
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 11:20:18 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 83AAE20B7168; Tue,  5 May 2026 04:20:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83AAE20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777980014;
	bh=824fW5VJr8kTEo1jJkOZf4ojp49EPJyPH98EoCje4gY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Rzjpi7SdVJZIrHd8F1XZbdFYMgpviBEKJ9wdzkwTw404HGuXrwUI0I50BkqAiZ8ka
	 08+/SBwTb7ENqqQpB2BhnssImDOK9lUDTn7wT7j58y66gF4LlhEkCOhBB721orvceK
	 +aKRujSg79KZfyURyOjNbesUXdDqswHSRbG1pGVw=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 8189E30705A3;
	Tue,  5 May 2026 04:20:14 -0700 (PDT)
Date: Tue, 5 May 2026 04:20:14 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Pratyush Yadav <pratyush@kernel.org>
cc: Mike Rapoport <rppt@kernel.org>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
    kexec@lists.infradead.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] kho: generalize radix tree APIs
In-Reply-To: <20260429133928.850721-2-pratyush@kernel.org>
Message-ID: <331da42-b255-326b-cd5-28d07a7e2cb2@linux.microsoft.com>
References: <20260429133928.850721-1-pratyush@kernel.org> <20260429133928.850721-2-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_042017_768485_8209B844 
X-CRM114-Status: GOOD (  11.59  )
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

On Wed, 29 Apr 2026, Pratyush Yadav wrote:

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> The KHO radix tree is a data structure that can track the presence or
> absence of an arbitrary key, with nothing inherently tied to KHO memory
> preservation tracking. This was one of the design goals of the radix
> tree. This was done to enable it to be re-used by other users of KHO.

"Arbitrary key": Not quite the complete 64-bits, rather 64 - PAGE_SIZE, 
correct?

> + * kho_radix_add_key - Add a key to the radix tree.
>  * @tree: The KHO radix tree.
> + * @key: The key to add.
>  *
> + * This function traverses the radix tree based on the key provided. It sets the
> + * corresponding bit in the leaf bitmap to mark the key as present. If
> + * intermediate nodes do not exist along the path, they are allocated and added
> + * to the tree.

Consider adding a note on the key-width limitation.

Best,
Jork

