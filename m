Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96413C55165
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2x/3afnS5nA1+U4o3Wmcac5daCL5SWJ0JULSmSn8Nlg=; b=iNKqM046b8aEZVnjd3K1/zgtc9
	EdceIMXT+O/WqpzKoPS6+6NPvbWmhJtoGaykpi8uKQlosBik8mlkf6JnvhGClQhUxxQJ8kcm+p2Cj
	dU8oE2yHqfM1hn2utSu4Fp2Mz04wF1YylsWXPY5KgLkaRMuQRp7rsldBuNTB2zdcEgWtlClUyuyfa
	M7smi4V+A2exvvm0GrROgIaeKWkJFNNrm9T5JPuNujPeAcB+MpogLs/Oi9EwygJaSaKTvTxJGovV/
	fA25eYjtEjec1BARqePajOszMJa5dNMiLUZ7E06gXFsgBqoEGObOtCO65hKnRcNebRbpUOA8jo7ht
	x5LpReXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPHd-0000000AOCs-0v70;
	Thu, 30 Jul 2026 11:50:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPHb-0000000AOCM-3rYN
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 11:50:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0BC3A4075C;
	Thu, 30 Jul 2026 11:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE7A1F00A3A;
	Thu, 30 Jul 2026 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785412237;
	bh=2x/3afnS5nA1+U4o3Wmcac5daCL5SWJ0JULSmSn8Nlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VFxavYoID/H1SY3p3HdWy6FGgQHd/Sc3WjhPk+qvd7eOlGYPzkZo8IULG3d/Yrb8P
	 iOx/Wkl/68RIeETIGvf7cm8dC2UMMZ1wbyKxqav0vNGc9eoTVdOAhOwg99eCoZoam6
	 owNFEC3JwnEO30HkW3uOqO3ALOkSiuWzjNwwrPM7x7Xh2Qa+Jq54B6PD4TnGKro+eB
	 C51nzZV87/Yb4XRcHdWeJMx88WWTlnurt6kNXm8tFVuB5MOzOYw0dWFZNf3afQuQJM
	 7a05sBj0fVAfgP7CAnAZkdt9liUQ6j5fgy6hfRYcbaazkXrGsBQWYwKLS3WZW7s6c0
	 KGY7i8A1ouf5A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/22] kho: generalize radix tree APIs
In-Reply-To: <amsN9_4LTNFBxaFE@kernel.org> (Mike Rapoport's message of "Thu,
	30 Jul 2026 11:40:23 +0300")
References: <20260729145610.2827231-1-pratyush@kernel.org>
	<20260729145610.2827231-2-pratyush@kernel.org>
	<amsN9_4LTNFBxaFE@kernel.org>
Date: Thu, 30 Jul 2026 13:50:34 +0200
Message-ID: <2vxzmrv87l2t.fsf@kernel.org>
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

On Thu, Jul 30 2026, Mike Rapoport wrote:

> On Wed, Jul 29, 2026 at 04:55:46PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Generalize the APIs by taking the key directly and doing the encoding at
>> the callers. Rename the functions to kho_radix_add_key() and
>> kho_radix_del_key(). In practice, this removes a line each from the
>> functions and moves the encoding function call to the callers.
>> Similarly, update kho_radix_tree_walk_callback_t to take the key
>> directly.
>>
>> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
>> index 84e918b96e53..f368f3b9f923 100644
>> --- a/include/linux/kho_radix_tree.h
>> +++ b/include/linux/kho_radix_tree.h
>> @@ -34,30 +34,24 @@ struct kho_radix_tree {
>>  	struct mutex lock; /* protects the tree's structure and root pointer */
>>  };
>
> sashiko: This isn't a bug, but did you miss updating the kerneldoc for
> struct kho_radix_tree?

That's new, sashiko didn't find this on v4...

>
> And indeed "DOC: Kexec Handover Radix Tree" talks about addresses and
> orders.

Yep, will fix for v6.

-- 
Regards,
Pratyush Yadav

