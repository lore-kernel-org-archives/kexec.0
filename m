Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6BDCD98C7
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 09:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bWzKKA513sGWS7gystdQPOj/dPx2tvXmn4sVux70dh4=; b=mZuzG9xWD/9blixPG5CcCZ4QhI
	FMphFbAK0Qi/6nluc7mm6AAdtqYEVRy9/QWLzJWvhnQD+7LTYea7IZVhc7Rr30W+BV4/r5lQ/wfxn
	pQ0Gy2zQTd3PLE2TO5mfjF8fvxGHXKwKJtXK2cYdKNGmb6IuI3d3jn0dUh0I5HRRMpzstSg+Vev5o
	XVAH3oyUCuDi0s5ho0uQRBM/YPjRikYesOH5SnMeJ13LM+1S27rZ8Yn2kn8NjOIDiSnly42TCHfA5
	2RcB96bRvoWTDoVk81vIp/iw8NyD/YczyAlwJ4TByEHsE4uzN2Mcue+tdlRt8m14YZZWvkqAgl1ox
	RcNbZc/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXbYX-000000097EG-411w;
	Thu, 11 Jun 2026 09:18:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXbYW-000000097E4-1U8h
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 09:18:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B2AE460052;
	Thu, 11 Jun 2026 09:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF21F00893;
	Thu, 11 Jun 2026 09:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781169511;
	bh=bWzKKA513sGWS7gystdQPOj/dPx2tvXmn4sVux70dh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lU5HDb6KEPuf+i5iweN+1uq4PzaRUar82asCxKXNZoZVLuD2maPIYQxVhbxLTYYs8
	 TfLn48EvXODOG+vZdJc1UAJISJo9ScuculIfqLv0Y6PrDKIndAGPztAdMiQg5NUt+w
	 EaYzx2iODXJ3g034ttKNtUeSK6GMXCG8yKMc8TRvGI7EOlJpkJv/1UZMsQ7vep4uI7
	 QRxvwrKlZDh2TJ84kJg1bcU1V1bvKYSx8qRebPQXgwBny9KmtQSWc7NmssGQ4Bv5yd
	 nkyRHgHQYq303ENlT3ZfbeKSt55TD2R1IfkiRgcqrMX0jRYHz04rS6sSiF3XXn82Gh
	 bF403Ri4fxFRA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] pstore: add a KHO backend
In-Reply-To: <202606101331.BDB11F097@keescook> (Kees Cook's message of "Wed,
	10 Jun 2026 13:34:10 -0700")
References: <20260605121040.1177072-1-mclapinski@google.com>
	<202606101331.BDB11F097@keescook>
Date: Thu, 11 Jun 2026 11:18:28 +0200
Message-ID: <2vxzzf11qvtn.fsf@kernel.org>
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Michal Clapinski <mclapinski@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jun 10 2026, Kees Cook wrote:

> On Fri, Jun 05, 2026 at 02:10:40PM +0200, Michal Clapinski wrote:
>> Up to this point to preserve late shutdown logs in memory, users had to
>> predefine a memory region using ramoops. This commit changes this by
>> preserving a buffer using kexec-handover.
>> 
>> pstore_kho supports preserving only 1 dmesg buffer.
>> It gets replaced with the new buffer on every kexec, so the user has to
>> copy the file out of pstore after every kexec.
>> There is no erase() support.
>> 
>> Signed-off-by: Michal Clapinski <mclapinski@google.com>
>
> I'm a fan of the idea! I'd love to see a selftest added for this
> backend, since it should be possible to do a direct tests for dmesg
> preservation across a kexec in tools/testing/selftests/pstore/
>
> There is still good feedback from sashiko, which caught everything I was going
> to mention and then some:
> https://sashiko.dev/#/patchset/20260605121040.1177072-1-mclapinski%40google.com
>
>> ---
>> v2:
>> - Added a comment explaining the benefits of pstore_kho.
>> - Created include/linux/kho/abi/pstore.h.
>> - Got rid of the KHO subtree.
>> - Made sure never to free incoming kho data.
>>   This way the module can be safely reloaded.
>> - Sashiko complained that I trust the data coming from the old kernel.
>>   I ignored it. LMK if I shouldn't trust the old kernel.
>
> We shouldn't trust the old kernel. :) Sashiko's suggestion here seems
> reasonable which is to at least bounds-check the size against
> RECORD_MAX_SIZE since that's the largest it should ever be.

I'll do my usual piece about trust when using KHO. You _have_ to trust
the previous kernel. KHO has no way of validating the information from
the previous kernel. It has to trust what it says. Because of this, the
previous kernel has a lot of influence on the state of the current
kernel. I don't think we can draw any sane security boundary here.

So I think if you are using KHO, you should rely on chain of trust or
other similar mechanisms to make sure you trust the previous kernel. KHO
itself can't provide much of a security model.

All that said, I think it makes perfect sense to do bounds checking. You
should still protect yourself from a _buggy_ kernel.

But be careful. Currently RECORD_MAX_SIZE depends on
CONFIG_LOG_BUF_SHIFT. This can change between kernel versions and
shouldn't be used to enforce correctness. Because otherwise, if the new
kernel sets a smaller CONFIG_LOG_BUF_SHIFT, it will reject perfectly
valid data. Come up with a reasonable value and use it as ABI. If you
ever need to change it, you can do so with an ABI version bump.

-- 
Regards,
Pratyush Yadav

