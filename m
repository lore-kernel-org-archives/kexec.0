Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1B4CD37BE
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ORD3PwyyW2DYfLIqd/NoUkaMynxGygGMiJ0enNnIn6c=; b=W5i9etDeqpnZtCCQiTWaz+LdW2
	unkqe01RWlEDeP4hxHOF7XAlAQwrV0xbMPIIaMLDbSyRusy0Ffat5X9HeoGc0JpGhv/4dUYlTYkBn
	LCz5rsQ9fyghcyzTjJYZludyaoe5RdV/YgsTahvojqa1pJ+GzxNMSZlQQuLAPQXxjknhnpGj4jlw9
	fbNFO+nhhq49UWfQZG31ltTFdi4SEZtQezeV/Ss4GT0X+QVwdIQurXv7BZHFoe2yNmLL17Ei8ijA/
	WTii9PQ1dy7kPOUeLXc+yQ1eksTiMxtBsOeXbzr1krgLRTQHRUBOd7R5HZlj0B+tDb95tJlrh3+UO
	Ges9M3Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTc0-0000000EELa-30WJ;
	Mon, 11 May 2026 16:36:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTby-0000000EELF-3wFB
	for kexec@bombadil.infradead.org;
	Mon, 11 May 2026 16:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ORD3PwyyW2DYfLIqd/NoUkaMynxGygGMiJ0enNnIn6c=; b=kmAhiKeqpKW1yJc5+MyoWgfJMt
	AVo8Dj3p2SauPdVl/YdHtaAnmFFZdbP3Pb55g2I/hnOLdhCw52yw/zlA7CeLP3/mxBn8GrCWWKSmo
	YRXRQeV3oloJTDZFEWRnZEghUWsq5grRBwXFrFog0QtMO8IwUv54VDkExZfpP+p9XvexFDfNQPjm3
	a8HyEOG5EftWz1eV0y47iFgZjZSvda308oEP57YvU/iOk+F/qHknMDsnZbLiVSZgdmOfFh5YX48yV
	1M1xyzO5pSytaKO2x2hHP0Vw3CGwz3BIpZ2ik6MtmMBj3ry7C4saelPdIqi0636rQz8Oe5fFVTlIh
	XHme6K6Q==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTbu-0000000CLsY-1zSY
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 16:36:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 66BF643493;
	Mon, 11 May 2026 16:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548B1C2BCB0;
	Mon, 11 May 2026 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517358;
	bh=pj/UdlMowZtsAQ7KPce4Qa+NpB32K7TNb0wg1aMyj7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=idLeIRL9ovET+lCaODzlgj4aiZ5Y6SYo/1Jnar26AsQVrG4KKwahz9CaLUAyB/Rlr
	 MHnjKSvDOXwXp9JHp76z2kksMMcgzPh0ISYvazdM8ZXDkXU6msyXONGDEtgYXzz3tE
	 y3tUPsDp/xRlRSrY0L+nzRH1oE1dlcNKnwrBcTvAxSTQ1DPdG4/FrOODQgW7D2YebA
	 y+6MQsnwGA9GfpNugxx+Mug7afGVBlWjTA8Us6XPYabaweaUbmshm/O9lGAWAITop+
	 r2r6pzJr61FVJOW+Luq+pIa7QXEytJ+1qu2tCFwdipUpjAdnOYxwfOTGkJDAFbhamq
	 YNDSTl3xH862Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] kho: add a struct for radix callbacks
In-Reply-To: <agHB7HB-p_vkLS7R@kernel.org> (Mike Rapoport's message of "Mon,
	11 May 2026 14:47:56 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-4-pratyush@kernel.org>
	<agHB7HB-p_vkLS7R@kernel.org>
Date: Mon, 11 May 2026 18:35:54 +0200
Message-ID: <2vxzzf25c39x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_173603_441297_3E7F6158 
X-CRM114-Status: GOOD (  11.63  )
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

> On Wed, Apr 29, 2026 at 03:39:05PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> A future commit will add more callbacks for the KHO radix tree. Add a
>> struct for collecting the callbacks.
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
[...]
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -266,16 +266,18 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
>>  }
>>  EXPORT_SYMBOL_GPL(kho_radix_del_key);
>>  
>> -static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
>> -			       unsigned long key,
>> -			       kho_radix_tree_walk_callback_t cb)
>> +static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
>> +			       const struct kho_radix_walk_cb *cb)
>>  {
>>  	unsigned long *bitmap = (unsigned long *)leaf;
>>  	unsigned int i;
>>  	int err;
>>  
>> +	if (!cb->key)
>> +		return 0;
>> +
>>  	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
>> -		err = cb(key | i);
>> +		err = cb->key(key | i);
>
> key(key) reads weird :)
> Can't say I have a good name, maybe key_action()?

I thought the context of it being under a callback struct would make it
more obvious. I don't like key_action() much better TBH, but I don't
have a strong opinion. Perhaps Pasha can suggest a 3rd option and we
pick on randomly ;-)

>
>>  		if (err)
>>  			return err;
>>  	}

-- 
Regards,
Pratyush Yadav

