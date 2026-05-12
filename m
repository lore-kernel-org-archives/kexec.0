Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D04ECD4851
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jWIKLyq7FH0+R+N+F4OIKVJiretAMtcnJ9k3w/L+AOQ=; b=qT0jYExLJun1c2NRT+hcf6Yqii
	3FXfyWZIr5NJaqaWUH9hsboEHPgzceQNfCmm2yC7Vp9uSW6adBanfgJRblTc5mLqLV2zKHDttrKf6
	Bhd6DyU98cA0j9w09/yDC4LE1LjYQVqWQ6++pMgpVvLdpLBFKv/WIqB936WhSgeJgn3xRO8FcdJvW
	is/1hYf4Ei2VCznzYWN7fkTNWcMN/Ai5t19PMBlOydsD0trX/QQ8s+eVn83ggzplipJr7l/aPhEhU
	JxNzMQqn0uSK8IWxE6NuCR2d1uObO9MWemfvGFSlWg7GQ/0eKIBGSqrkFxUrtKMLztks6q2INdCVn
	aiTGGejw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMj9B-0000000GDq3-2weF;
	Tue, 12 May 2026 09:11:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMj9A-0000000GDpD-0vOF
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 09:11:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5496A60055;
	Tue, 12 May 2026 09:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C522C2BCB0;
	Tue, 12 May 2026 09:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778577083;
	bh=4hEM1RL8Q3Ecwa5JN6pAuey/y8Z41JPI8moNXj27aEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZxKzUQIVFSSFvPwUMy6zzHWK6v1yyQI1+b+4Ay92xGyuOyc3XqxunISgVEJQvaKA4
	 Oy6Y4eYSvs12RXLwsN5+5j2dyT3SSF8wxviUh2MORKlbFblWTILDTl1PCORmQaP06Q
	 fU8HEyQsgxqkQofnobPNrM08cCp5h37FBzg9Z9I1runT4dowCTEgpr6xHhuSzAyqyq
	 2VVUZViPyuAV3PeanymbGtGgDbVoYgo0LUdtA7a8UPQU3yRu12L5C2ECT/vLUUTrHZ
	 vfSQiIi8AA8b12fYfn4+jW9dhw4wTBUFR8YeIfkTpKI3WHYIzOwaisWWs6FJSohkH8
	 M4kZPjXQkZ1Fw==
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
In-Reply-To: <agLNUKE5LZqcoUex@kernel.org> (Mike Rapoport's message of "Tue,
	12 May 2026 09:48:48 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-4-pratyush@kernel.org>
	<agHB7HB-p_vkLS7R@kernel.org> <2vxzzf25c39x.fsf@kernel.org>
	<agLNUKE5LZqcoUex@kernel.org>
Date: Tue, 12 May 2026 11:11:19 +0200
Message-ID: <2vxz5x4tat6w.fsf@kernel.org>
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

On Tue, May 12 2026, Mike Rapoport wrote:

> On Mon, May 11, 2026 at 06:35:54PM +0200, Pratyush Yadav wrote:
>> On Mon, May 11 2026, Mike Rapoport wrote:
>> 
>> > On Wed, Apr 29, 2026 at 03:39:05PM +0200, Pratyush Yadav wrote:
>> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> >> 
>> >> A future commit will add more callbacks for the KHO radix tree. Add a
>> >> struct for collecting the callbacks.
>> >> 
>> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> >> ---
>> [...]
>> >> --- a/kernel/liveupdate/kexec_handover.c
>> >> +++ b/kernel/liveupdate/kexec_handover.c
>> >> @@ -266,16 +266,18 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
>> >>  }
>> >>  EXPORT_SYMBOL_GPL(kho_radix_del_key);
>> >>  
>> >> -static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
>> >> -			       unsigned long key,
>> >> -			       kho_radix_tree_walk_callback_t cb)
>> >> +static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
>> >> +			       const struct kho_radix_walk_cb *cb)
>> >>  {
>> >>  	unsigned long *bitmap = (unsigned long *)leaf;
>> >>  	unsigned int i;
>> >>  	int err;
>> >>  
>> >> +	if (!cb->key)
>> >> +		return 0;
>> >> +
>> >>  	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
>> >> -		err = cb(key | i);
>> >> +		err = cb->key(key | i);
>> >
>> > key(key) reads weird :)
>> > Can't say I have a good name, maybe key_action()?
>> 
>> I thought the context of it being under a callback struct would make it
>> more obvious. I don't like key_action() much better TBH, but I don't
>> have a strong opinion. Perhaps Pasha can suggest a 3rd option and we
>> pick on randomly ;-)
>
> Another option I thought is to call them ->leaf() and ->node().

This one sounds nice. Will use it in v2.

-- 
Regards,
Pratyush Yadav

