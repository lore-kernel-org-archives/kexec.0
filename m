Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72001CD8C85
	for <kexec@archiver.kernel.org>; Sat,  6 Jun 2026 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=No/xV3x9JOJgAL1c15ZIv+cOiIPQT3ioZC04jvxeT6A=; b=dboUtZaknD4oQ/tNgTweD23j6G
	ctO7K/JBkCnpCtnG4EKEIKGAgzbeobH9sT++laaOjfFNZOpLn+2gS94rCYwsWQNUe+g3SJLHaQDok
	6l+w4rBzJ+8hJeyN64h8mnsOAv4av5F+tGvu6YrTYbPgUZT3DfpjjYPXpjX6MGn7ydz8QsOjNTxul
	4Z3D0YdWrHWSTvlBY/Md+e2lC+9kYP5Rh81qO8t2rBGx4K2q0Bo0ZjU52TDUZP/J3voO4sseRv+bv
	sU1Soatrb8r3XL052o2dTnEhI1iEguwP1TJZK08WJiompqiu5sIfdddYvJzWYGl6dJirbCp1+fFrt
	j5fy/Qhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVwov-00000001mpZ-2WOM;
	Sat, 06 Jun 2026 19:36:37 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVwot-00000001mpL-1tu3;
	Sat, 06 Jun 2026 19:36:35 +0000
Message-ID: <37fbe86b-b476-4d28-b8e6-5b8cb3808b42@infradead.org>
Date: Sat, 6 Jun 2026 12:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: memfd_preservation: fix rendering of ABI
 documentation
To: Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20260605160645.3650271-1-pratyush@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260605160645.3650271-1-pratyush@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/5/26 9:06 AM, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The "memfd Live Update ABI" section in include/linux/kho/abi/memfd.h
> currently does not render in the exported documentation. This is because
> it should not include the "DOC:" in its reference. Drop it to ensure
> correct rendering. Tested by running make htmldocs.
> 
> Fixes: 15fc11bb2cb6 ("docs: add documentation for memfd preservation via LUO")
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
> 
> Notes:
>     Mike/Pasha, I reckon this can still go in liveupdate/next. But if you
>     think it is too late, we can probably take it via -rc1 fixes as well.
> 
>  Documentation/mm/memfd_preservation.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
> index a8a5b476afd3..c908a12dffa7 100644
> --- a/Documentation/mm/memfd_preservation.rst
> +++ b/Documentation/mm/memfd_preservation.rst
> @@ -11,7 +11,7 @@ Memfd Preservation ABI
>  ======================
>  
>  .. kernel-doc:: include/linux/kho/abi/memfd.h
> -   :doc: DOC: memfd Live Update ABI
> +   :doc: memfd Live Update ABI
>  
>  .. kernel-doc:: include/linux/kho/abi/memfd.h
>     :internal:
> 
> base-commit: 2935777b418d2bfcbfe96705bb2c0fa6c0d94e18

-- 
~Randy

