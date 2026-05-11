Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF9DCD4840
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BbjyzbhAEhjiOAv/+IPvRGFECEkoPFNDnzv8HEauCyo=; b=ZV1rfQ9bIoQ3AqMQcjUB9Z0NMm
	4COn76C+Jq2XPxeNvEQgMEN0nhQuf+7n7mZ5MiXrogFkSdtqxbjnr87V48DFhBaiS7LWzeT2ENmES
	CN+uO+seVG00W8gywFoLmHBja4P0dcjEhJQw6pgMQ8waACBEGU+2L0gua/JwvZJXHYr1NKmiLr1SE
	b7LtmOO7fY9k80ttmhwQXLPuv5OVdHgBO/3Ms20Iq67OUoWiffjhje9NZK4D35lkKmmNWPMZpwaDA
	nrrlaK4PfoVwjDOvGPB4j7ePSuhKejHrqsWZLYINaF9rYD0D5a/NuLJ/vc8z5n/U7QssP4HYGxIdJ
	hr6wkQvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTco-0000000EERc-41dD;
	Mon, 11 May 2026 16:36:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTcn-0000000EERU-2ls6
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 16:36:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C4CB460103;
	Mon, 11 May 2026 16:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8450FC2BCB0;
	Mon, 11 May 2026 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517416;
	bh=liPuemz24Vdu+80R1AYC85Gv4AyR8Vh8AkBScYnpciU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CssK/dWwTimpC0aZZ9E7Ph0ahQ4YbAFQmTr+YCk9pB9grCLntPdvXVjuNkuHr4eWP
	 kR/KsrpwUC6c2NGFnw06WCYjYSN9MbkO8PRMIUtxb/KeC16cpNOdpHUdmiJsgC2TKj
	 K5LnaPhVF03y5S+x9JVfvBfBRXe9v4MtnZ41QwPJHTRNprNhXO5kY42pmXe0xJH7pa
	 l9bYGB0mzmZ1/dghLPz+7xXoNaFB9ZjK+csJnvKcKectbSoX9wYAGtTfT3oi9IALsq
	 x3jfpQetglC0Pdf+KR1MfbCZFvcN4v1rcQTGlaR46UBaeYH+BlTizT8xCAE9nExguH
	 pCdkBTN8HLh4A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] kho: add callback for table pages
In-Reply-To: <agHCbpn5Hn3XsEWH@kernel.org> (Mike Rapoport's message of "Mon,
	11 May 2026 14:50:06 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-5-pratyush@kernel.org>
	<agHCbpn5Hn3XsEWH@kernel.org>
Date: Mon, 11 May 2026 18:36:53 +0200
Message-ID: <2vxzv7ctc38a.fsf@kernel.org>
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

> On Wed, Apr 29, 2026 at 03:39:06PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> The KHO memory preservation radix tree does not mark the table pages
>> themselves as scratch. This is done to avoid a circular dependency where
>> preserving a page can lead of allocating other preserved pages. This
>> means any walker looking for free ranges of memory outside of scratch
>> areas will ignore the table
>> 
>> Add a table callback that is invoked for each table page. The callback
>
> A sentence why a table callback helps would be nice here :)

The main reason is that a later patch will create a radix tree for short
use and will need to destroy it afterwards.

Will add that here.

>
>> is given the physical address of the table page.
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  include/linux/kho_radix_tree.h     |  3 +++
>>  kernel/liveupdate/kexec_handover.c | 12 ++++++++++++
>>  2 files changed, 15 insertions(+)
>> 
>> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
>> index 030da6399d28..fe7151d89361 100644
>> --- a/include/linux/kho_radix_tree.h
>> +++ b/include/linux/kho_radix_tree.h
>> @@ -37,12 +37,15 @@ struct kho_radix_tree {
>>  /**
>>   * struct kho_radix_walk_cb - Callbacks for KHO radix tree walk.
>>   * @key:      Called on each present key in the radix tree.
>> + * @table:    Called on each table of the radix tree itself. Receives the
>> + *            physical address of the page containing the table.
>>   *
>>   * For each callback, a return value of 0 continues the walk and a non-zero
>>   * return value is directly returned to the caller.
>>   */
>>  struct kho_radix_walk_cb {
>>  	int (*key)(unsigned long key);
>> +	int (*table)(phys_addr_t phys);
>
> Naming is hard ;-)

Yes :-/

>
>>  };
>>  

-- 
Regards,
Pratyush Yadav

