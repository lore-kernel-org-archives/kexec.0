Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2559EC28D13
	for <kexec@archiver.kernel.org>; Thu, 25 Aug 2022 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:
	To:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wwHweV937GjKux082MASOrplQMDWlynKq26xTp7isVU=; b=HD5ylJT/4POtwU
	kTerpuLr3lgjSN0GFu/WZJNwdL+28dsdFM4qDwVba9xZckP9ykUVOto74l9FrL7zpktsXGR4s3XhM
	k1Rzu6lnMzc5VKRc1aMgHAM8F5eTJl7W0d3e9z+8KGp9JP6B2ZoaDeBr9Q1SdRGPBzrkHIEdkdnT1
	gzBRJuLV55DHzdT3kvQAgIBQUbnILkUUFCau9rNpllPOofFI+DulqauOy2zgHpv8biESPWunCY4CT
	32/zWenAl/9/kxE6ooiGfHMfjEJWe3UdXwLJaU0MXRjPYc2DQ7u6JXkF5sKU4oXzlVxR8imvC1YBK
	+mjbirl1ORUOtJqbxsyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR9dd-00Bcot-6m; Thu, 25 Aug 2022 09:59:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR9dY-00Bcgc-T5
	for kexec@lists.infradead.org; Thu, 25 Aug 2022 09:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661421532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXEuh/C7EhMT4N5IVCTMgJSlHVPtxpuWjvzgdztQOwA=;
	b=FyYafbFkTwL/yGrlVFUCKT4YjfwfnI7ZlkozTJ2e2AFuQQ9kdkSEIcovrum9Rq4hthtpiJ
	dDWKpP0h9SlzziymOCHgTfyAZHgQJzPquw55v/oaYuhXHa+0NP+WJErOOIWkI9eDQF/y5V
	+I4kDsOmkwpyKuPhNfX65drDz3NJnKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-AjyfCUtrPxq_kq02qxNoaA-1; Thu, 25 Aug 2022 05:58:51 -0400
X-MC-Unique: AjyfCUtrPxq_kq02qxNoaA-1
Received: by mail-wr1-f69.google.com with SMTP id l25-20020adfa399000000b002252058bad2so3282864wrb.11
        for <kexec@lists.infradead.org>; Thu, 25 Aug 2022 02:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=sXEuh/C7EhMT4N5IVCTMgJSlHVPtxpuWjvzgdztQOwA=;
        b=QK+w6egPWbjmLMkGvcu4JFieHgoubFkaYeH49g2aZLCBzWkvMLGlOe1zlAR1PZDY9d
         R6/Epw4DFRrdbRXKdARH5h+lfQY7qW4Qs38+DKUfwV2mlGri7xT1Cij7S0iGKPBVsARW
         dLRnPKPHxNeL+ktbj3A9z4DDM/NjjgXLDx7jQ6LFJTF+4tQh40VHdx2guq1+29M656ss
         5JJ6MVoOPeq5jeckg6gRONEE6n8xFiWwXiBzH0JtxECdDZ/sZ1ZDgvWzd5ZNhu0+2S2y
         vzwSYFlbhCqqNJ6tSAs2QWsCmaTl9TblQ3clc3NZwe4+k0H0e05VAMGGLBArt+siVtxB
         BuXw==
X-Gm-Message-State: ACgBeo3sLiWNNxXg9UUIcA8ghwZC/RONkzKnHe4Fo6Hx4ivArWuYl0It
	eSv5oIJgFPyJj4wc942e3rofSWeMiwsK/o+UQ85//QLBTnRam492KtoCrapKeBAzxSY1kucdMfS
	1evXmVOMk3vQUSR5Rng3G
X-Received: by 2002:adf:fe09:0:b0:225:6c9a:1925 with SMTP id n9-20020adffe09000000b002256c9a1925mr1689592wrr.546.1661421530148;
        Thu, 25 Aug 2022 02:58:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zjV5/uX5zJoDDQGvyv88ADNp860yGdsGm+iTCH+1DVQ3YBmb2/7qZdaBeUnu1fynPZfG7sQ==
X-Received: by 2002:adf:fe09:0:b0:225:6c9a:1925 with SMTP id n9-20020adffe09000000b002256c9a1925mr1689579wrr.546.1661421529892;
        Thu, 25 Aug 2022 02:58:49 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0021e42e7c7dbsm19557923wri.83.2022.08.25.02.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 02:58:49 -0700 (PDT)
Message-ID: <b1103c81-0c56-0e9b-711c-246e431db151@redhat.com>
Date: Thu, 25 Aug 2022 11:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-3-david@redhat.com>
 <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and
 friends
In-Reply-To: <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_025857_064575_216C989E 
X-CRM114-Status: GOOD (  16.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 24.08.22 18:52, Joe Perches wrote:
> On Wed, 2022-08-24 at 18:31 +0200, David Hildenbrand wrote:
>> checkpatch does not point out that VM_BUG_ON() and friends should be
>> avoided, however, Linus notes:
>>
>>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>>     no different, the only difference is "we can make the code smaller
>>     because these are less important". [1]
>>
>> So let's warn on VM_BUG_ON() and friends as well. While at it, make it
>> clearer that the kernel really shouldn't be crashed.
>>
>> Note that there are some other *_BUG_ON flavors, but they are not all
>> bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
>> flags KVM as being buggy, so we'll not care about them for now here.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -4695,12 +4695,12 @@ sub process {
>>  			}
>>  		}
>>  
>> -# avoid BUG() or BUG_ON()
>> -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
>> +# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
>> +		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {
> 
> Perhaps better as something like the below to pick up more variants
> 

Trying to find more possible variants and exceptions

$ git grep -h -o -E "\b[a-zA-Z]+_BUG(_ON(_[a-zA-Z]+)*)?\(" | sort | uniq
AA_BUG(
-> Ok, no BUG()
ASM_BUG(
-> Bad
BUILD_BUG(
BUILD_BUG_ON(
BUILD_BUG_ON_INVALID(
BUILD_BUG_ON_MSG(
BUILD_BUG_ON_ZERO(
-> Ok
CI_BUG_ON(
-> Bad with CONFIG_DRM_I915_DEBUG
DCCP_BUG(
DCCP_BUG_ON(
-> Ok, no BUG()
do_BUG(
-> BUG implementation, ok.
GEM_BUG_ON(
-> Bad with CONFIG_DRM_I915_DEBUG_GEM_ONCE
GLOCK_BUG_ON(
-> Bad
handle_BUG(
-> BUG implementation, ok.
IDA_BUG_ON(
KVM_BUG(
KVM_BUG_ON(
-> Ok, no BUG()
lkdtm_BUG(
paravirt_BUG(
-> bad
PROM_BUG(
-> unused, will remove
RWLOCK_BUG_ON(
-> Ok, no BUG()
snd_BUG(
snd_BUG_ON(
-> Ok, no BUG()
SNIC_BUG_ON(
-> Bad
SPIN_BUG_ON(
-> Ok, no BUG()
UNWINDER_BUG(
UNWINDER_BUG_ON(
VIRTUAL_BUG_ON(
VM_BUG_ON(
VM_BUG_ON_FOLIO(
VM_BUG_ON_MM(
VM_BUG_ON_PAGE(
VM_BUG_ON_PGFLAGS(
VM_BUG_ON_VMA(
XA_BUG_ON(
-> Bad

So an extended versions of your proposal like (ignoring do_BUG and handle_BUG, people are smart enough to figure that out)

if ($line =~ /\b(?!AA_|BUILD_|DCCP_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/

?

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
