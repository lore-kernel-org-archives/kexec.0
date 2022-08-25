Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6A5C04AA5
	for <kexec@archiver.kernel.org>; Thu, 25 Aug 2022 11:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gHcyCyYeHWAD7ruID/VDhJTsc84qsNS7/JAfNfn0u5M=; b=y89R+3EdGwuEmp
	x4aU3l1HQrypvlKAN0Kd7bPc85KGDUHRrscwkXp1CUaSkA+Qjo87gksb64H+YGxd8bApE76CxRsKe
	blFirW6eIhryf7R1OmIKaidM4kDKaNjmN0CgpufYcX0E4U5G15MXoRjbLMQVSPWEYolTdYFewe/gB
	3LG/46PLft/wa3M0HV8wIdSBVM6dW8I6UKFLiY5/wPj9x7nNxBdou5sDmRlQuXblGsZ1HDyGWTHcn
	5N2SeWlEmGffoHPlgIEbJBEnzoerJOCVK5CSEBcYGZEBc8/zW6OxRKObvAXaCXtLIO52GxZVFezdn
	mYag+LBPVKFyTS9cgLrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRBGY-00CrDQ-Uj; Thu, 25 Aug 2022 11:43:18 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRBGV-00Cr9q-SW
	for kexec@lists.infradead.org; Thu, 25 Aug 2022 11:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661427795; x=1692963795;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tYG7WhfDi49Qt6vYSgp3uYShnGTRn+X7NAL+bBNRm8c=;
  b=A785o5O6uLJDBjgjPE1aXl/4OgKZ4EpgMloQ38p8AJvY5nt/cLvlor/3
   ajxeiROfRLFpYeI29h1faeaP5vgG3FsJ6YXXkC3M5qaOz6xqnySBF5bMY
   Iw20URkzc5vLSwXC8Lr3HOL02fQe1rjn5lL4dZiO7NJY6TmgKW1bWsfvf
   UA0R+vJr3IlhoQaeSDicEJnIyngAdOhncogsDMPqKmPc8fNcqrb4pJ9Xl
   3lRzxV14e5wUiUTHSJ10t9FmfUvYU/U7hqcuM2208JEVa8QtOmDKcgtYE
   0Y0rcos5EvETbgKHteiFM88yQro9H78A/tzudsfja1pb+x/nEjE0G0/qa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="294995038"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="294995038"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:43:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="560996613"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.149])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:43:05 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: David Hildenbrand <david@redhat.com>, Joe Perches <joe@perches.com>,
 linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 kexec@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>
Subject: Re: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and
 friends
In-Reply-To: <b1103c81-0c56-0e9b-711c-246e431db151@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-3-david@redhat.com>
 <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
 <b1103c81-0c56-0e9b-711c-246e431db151@redhat.com>
Date: Thu, 25 Aug 2022 14:43:02 +0300
Message-ID: <87y1vch7ll.fsf@intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_044316_031936_2763E5D3 
X-CRM114-Status: GOOD (  13.73  )
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

On Thu, 25 Aug 2022, David Hildenbrand <david@redhat.com> wrote:
> On 24.08.22 18:52, Joe Perches wrote:
>> On Wed, 2022-08-24 at 18:31 +0200, David Hildenbrand wrote:
>>> checkpatch does not point out that VM_BUG_ON() and friends should be
>>> avoided, however, Linus notes:
>>>
>>>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>>>     no different, the only difference is "we can make the code smaller
>>>     because these are less important". [1]
>>>
>>> So let's warn on VM_BUG_ON() and friends as well. While at it, make it
>>> clearer that the kernel really shouldn't be crashed.
>>>
>>> Note that there are some other *_BUG_ON flavors, but they are not all
>>> bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
>>> flags KVM as being buggy, so we'll not care about them for now here.
>> []
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> []
>>> @@ -4695,12 +4695,12 @@ sub process {
>>>  			}
>>>  		}
>>>  
>>> -# avoid BUG() or BUG_ON()
>>> -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
>>> +# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
>>> +		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {
>> 
>> Perhaps better as something like the below to pick up more variants
>> 
>
> Trying to find more possible variants and exceptions

> CI_BUG_ON(
> -> Bad with CONFIG_DRM_I915_DEBUG
> GEM_BUG_ON(
> -> Bad with CONFIG_DRM_I915_DEBUG_GEM_ONCE

These are hidden behind debug knobs that we use in our CI to
specifically catch "should not happen" cases fast and loud. Should not
be a problem for regular users.

BR,
Jani.


> So an extended versions of your proposal like (ignoring do_BUG and handle_BUG, people are smart enough to figure that out)
>
> if ($line =~ /\b(?!AA_|BUILD_|DCCP_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/
>
> ?

-- 
Jani Nikula, Intel Open Source Graphics Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
