Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970F3CD37BE
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wrqTfVPdTZxJRp68YocSY09APfo4bTsMDgF1qR5U+20=; b=wZKB8eWWYX+fx8eue876JFCuZn
	HlGRieiH3E5izb7b6dh5Q2Uu8uX9uWnbkQrJ7GiZJ/nUk/vPqhtju3ICrSSoKKio+/rnLUbpzDvCE
	KZi/8O0OMPZaU3joJrx9NWYQQvxi9oe/O0a7yxKuwupaXwSnIT5br0O2EC2paTEDOWLfXTTbNtVLW
	CmZdbrBJbETEsZD8uYLolY5K5+c6tvSf49OkmgEpLCNBWrW3Wv5Uox6f49skWOrQ12uDgXnR0yhB7
	n5Me9FR1alSQltGyy5imEVE/9Zfeysk0accn1oMlmLLoX33eT9CVf68FFKUW6yh1qKseZuemiYoBN
	wwR2frAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTSF-0000000ECTD-19nV;
	Mon, 11 May 2026 16:26:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTS9-0000000ECSs-2MA6
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 16:25:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C91B36001A;
	Mon, 11 May 2026 16:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C686C2BCC9;
	Mon, 11 May 2026 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516756;
	bh=qrw+cNWHzlyf8OR75OuLW8AXYM+NnLkhDwF7fpuKwm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pUXVVVwGAJN+u+9N0+31sblPJ4F4UWk6pPMzc+qZHLlm+J+vKIZu7kcFcW6uDlS1+
	 3r2woy3sazFt2w9ffUCV7Krk1EzPmX/B3GcNzzFK/kniGNb0eMAHWqmQfgeQhWyjul
	 X7fbOi4vvdOEUKwpqV3YvdanWBdGW9GcWhFuTOKAeLBW8EBV3S+UySWxIrykPBLokI
	 4rijrpU4jyvbO8oJDUmfCezSBrvYyh6rjhP4+Qogwjxnqg+X9rcNi4I7z7DWmoBb6I
	 jhdDXGVYZddJIbK6/63qYps2PN7hnbkJTcF/45ycA5jJsglIYnIdlofPbhc/157lc8
	 XHvOmN2BIMubw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] kho: generalize radix tree APIs
In-Reply-To: <agG-OuOTAg5YD-CV@kernel.org> (Mike Rapoport's message of "Mon,
	11 May 2026 14:32:10 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-2-pratyush@kernel.org>
	<agG-OuOTAg5YD-CV@kernel.org>
Date: Mon, 11 May 2026 18:25:52 +0200
Message-ID: <2vxz8q9pdib3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, May 11 2026, Mike Rapoport wrote:

> On Wed, Apr 29, 2026 at 03:39:03PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> The KHO radix tree is a data structure that can track the presence or
>> absence of an arbitrary key, with nothing inherently tied to KHO memory
>> preservation tracking. This was one of the design goals of the radix
>> tree. This was done to enable it to be re-used by other users of KHO.
>> 
>> Despite that, the radix tree APIs are very closely tied to KHO memory
>> preservation tracking. Adding a key is done by kho_radix_add_page(),
>> which encodes it as a page tracking operation and takes in PFN and
>> order. kho_radix_del_page() does the same. These functions encode the
>> key internally that goes into the radix tree. kho_radix_walk_tree() does
>> the same by baking the PFN and order into the callback arguments.
>> 
>> Generalize the APIs by taking the key directly and doing the encoding at
>> the callers. Rename the functions to kho_radix_add_key() and
>> kho_radix_del_key(). In practice, this removes a line each from the
>> functions and moves the encoding function call to the callers.
>> Similarly, update kho_radix_tree_walk_callback_t to take the key
>> directly.
>> 
>> To keep the naming convention clearer, rename
>> kho_radix_{encode,decode}_key() to kho_{encode,decode}_radix_key().
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  include/linux/kho_radix_tree.h     | 18 +++----
>>  kernel/liveupdate/kexec_handover.c | 76 ++++++++++++++----------------
>>  2 files changed, 42 insertions(+), 52 deletions(-)
>> 
>> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
>> index 84e918b96e53..f368f3b9f923 100644
>> --- a/include/linux/kho_radix_tree.h
>> +++ b/include/linux/kho_radix_tree.h
>> @@ -85,7 +85,7 @@ static struct kho_out kho_out = {
>>  };
>>  
>>  /**
>> - * kho_radix_encode_key - Encodes a physical address and order into a radix key.
>> + * kho_encode_radix_key - Encodes a physical address and order into a radix key.
>
> Let's keep kho_radix_ prefix for namespasing please.
> This is the common practice these days.

I am keeping the namespacing, just moving it out of the "kho_radix"
namespace to "kho" namespace. The mental model is that this function has
nothing to do with the radix tree. It is just something KHO uses for one
of its radix tree, so it should live in the "kho" namespace not
"kho_radix".

Does that make sense? I can add this explanation to the commit message
as well.

>
>>   * @phys: The physical address of the page.
>>   * @order: The order of the page.
>>   *
>
> ...
>
>> @@ -144,24 +144,21 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
>>  }
>>  
>>  /**
>> - * kho_radix_add_page - Marks a page as preserved in the radix tree.
>> + * kho_radix_add_key - Add a key to the radix tree.
>>   * @tree: The KHO radix tree.
>> - * @pfn: The page frame number of the page to preserve.
>> - * @order: The order of the page.
>> + * @key: The key to add.
>>   *
>> - * This function traverses the radix tree based on the key derived from @pfn
>> - * and @order. It sets the corresponding bit in the leaf bitmap to mark the
>> - * page for preservation. If intermediate nodes do not exist along the path,
>> - * they are allocated and added to the tree.
>> + * This function traverses the radix tree based on the key provided. It sets the
>
> Nit:                                                     @key here and in
> the comments below.

ACK.

>
>> + * corresponding bit in the leaf bitmap to mark the key as present. If
>> + * intermediate nodes do not exist along the path, they are allocated and added
>> + * to the tree.
>>   *
>>   * Return: 0 on success, or a negative error code on failure.
>>   */

-- 
Regards,
Pratyush Yadav

