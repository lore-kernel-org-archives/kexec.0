Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90E2CD343B
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m4+1/o+xgo43F+2pBLdcVc3ZSu95uTHefiaNtMBxq4s=; b=Zyof7ltNMWT59ewvLwPgyF7Pxj
	oOcEuBEtfsXFqTok2mLS48mIxV3wLAdpQw9xwTE+t9foFJfIhCJ5lYWl3o6h6NAO/ByQMQdoXwpZ/
	lu9cvoO+2xvYzAmSkJO6v20ypmt7d+B2K+Vsb2sMw84pDjQJwXKMBcd7ApzsRFpTfbb8uKaWODr9H
	Edpv9KkUcQ9dKD7v/hGPC9igtUc30e+3cqPQ0lSqccFQ/pjzRgnEJafJRIkIhXF/xlU9IJzXMaXK9
	SyVKydXY34kVT7dRIkwqHW57u/mVUxn4ROkrnHyeMiaWXbTFELzYHvbMdtLufwkaeUk0D0QZDCmoW
	SRMw7Y0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKetx-00000001TMZ-23r2;
	Wed, 06 May 2026 16:15:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKetv-00000001TKN-21Ym
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 16:15:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C34C66013B;
	Wed,  6 May 2026 16:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD015C2BCB0;
	Wed,  6 May 2026 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084106;
	bh=B3REzEcQHj5vktVYOp4io+MCxNEzgbT4NgOlD9ZnWao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XLSYvey9WPz2hBbTkwmzbkAclbXbGSfpdwIDc+Qakic8vcMii2sl4fpp8de9POwem
	 YDOu5cwi+KZiAVLsrm3mGdBMpyoD0+pjJiiUDIBRGK2Z75SgVUfKbZKQ3EbuHgGXLI
	 umXWjbt31/C/Y8k0UnXp6lWiuPUktxeicjqW/50yMWOCcOrnTpC/Nxflc50vgRWCqi
	 UcxINZSro7yvGoiAgEI3exnmpg8W94PXXNH2EipqC9haLLDaXDQFAJur/55u8sYC7O
	 PLORoNONKCwOlt/9tTopJlV/852N1qWWPEPw+iG14eRg2okK+Qswc5t0dTI/K5z37E
	 awlvD2RGakkjA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Cris Jacob Maamor
 <crisjacobmaamor@gmail.com>,  Mike Rapoport <rppt@kernel.org>,  Alexander
 Graf <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] liveupdate: validate restored LUO metadata
In-Reply-To: <aftVd5RnpnAi2jdc@google.com> (Pasha Tatashin's message of "Wed,
	6 May 2026 11:05:32 -0400")
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
	<20260501173053.73116-1-crisjacobmaamor@gmail.com> <afT_xHDuFwAUSR0X@plex>
	<2vxzse84zzag.fsf@kernel.org> <aftVd5RnpnAi2jdc@google.com>
Date: Wed, 06 May 2026 18:15:03 +0200
Message-ID: <2vxzfr44zf94.fsf@kernel.org>
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

On Wed, May 06 2026, Pasha Tatashin wrote:

> On 05-06 11:02, Pratyush Yadav wrote:
>> Hi Pasha,
>> 
>> On Fri, May 01 2026, Pasha Tatashin wrote:
>> 
>> > On 05-02 01:30, Cris Jacob Maamor wrote:
>> >> LUO restores metadata from KHO/FDT during liveupdate. The restored
>> >> metadata contains physical addresses and count fields used to access and
>> >> walk preserved session, file set, and FLB arrays.
>> >> 
>> >> This series adds a non-consuming KHO preserved-range check and uses it
>> >> before phys_to_virt() on restored metadata addresses. It also rejects
>> >> restored counts above LUO_SESSION_MAX, LUO_FILE_MAX, and LUO_FLB_MAX
>> >> before traversal.
>> >> 
>> >> As far as I can tell, this is root/admin-only; I do not have evidence
>> >> that a normal unprivileged user can trigger it directly.
>> >> 
>> >> Changes since v1:
>> >> - Dropped RFC marking.
>> >> - Added changelog text to each patch.
>> >> - No code changes.
>> >> 
>> >> Cris Jacob Maamor (5):
>> >>   kexec: handover: add helper to check preserved page ranges
>> >>   liveupdate: validate LUO FDT physical address before mapping
>> >>   liveupdate: validate restored LUO session metadata
>> >>   liveupdate: validate restored LUO file set metadata
>> >>   liveupdate: validate restored LUO FLB metadata
>> >
>> > I have replied separately in the security report to clarify that this is 
>> > not a bug. The behavior follows the ABI specification exactly: we use 
>> > the PA addresses and ranges provided by the KHO FDT tree.
>> >
>> > NAK
>> 
>> I really do think we should do a restore-only variant for the
>> kho_alloc_preserve() family of allocators and use it everywhere. It
>
> That is unrelated to the provided patch series. The author of this 
> series reported this as a security issue to the Linux security ML, and 
> submitted this series at their request.

Oh yes, sure. I am not arguing for taking this series. I just figured
this would be a good point to have this discussion.

>
> This is not a security issue, and in fact, it is not an issue at all. A 
> restore-only variant can be added, but I do not see a reason for LUO to 
> use it.
>
>> would prevent problems in the future. Not because the previous kernel is
>> malicious, but because we might have bugs and the KHO page magic sanity
>> check acts as a defense in depth.
>> 
>> For example, I am currently looking at a LUO bug where LUO does not
>> track if a session is outgoing or incoming. So you can do a retrieve()
>> or finish() on an outgoing session. A lot of nastiness is saved because
>> of the page magic check. Things like kho_restore_vmalloc() or
>> kho_restore_folio() fail early and loudly.
>
> I am not sure what bug you are looking at (please share the details!), 

I was looking at LUO code and realized that we do not separate outgoing
and incoming sessions when dealing with preserve/retrieve/finish ioctls.
So you can create a session, preserve a FD, and then immediately call
finish or retrieve without doing a kexec. Of course, LUO file handlers
aren't able to cope with it.

So for example, you can preserve a memfd and then immediately call
finish. This will call memfd_luo_finish(), where it will try to
kho_restore_vmalloc(). That fails with a bit WARN splat. And then later
it calls kho_restore_free() which also fails in a similar fashion.

You can do the same thing with retrieve(), but that also fails early and
loudly and does not cause any problems.

I am working on a fix for it. Should have something out shortly.

> but the fix absolutely should be to use outgoing/incoming sessions 
> properly, and if we mixed them up somewhere, THAT should be fixed. Using 
> KHO restore is not going to help much; however, I agree it can add 
> some extra scrutiny (i.e., similar to an ASSERT), but it is not really 
> something that would help improve correctness in any meaningful way. The 
> correctness should lie in the LUO logic using incoming as incoming, and 
> outgoing as outgoing.

I am not arguing that we shouldn't fix the logic bugs. Of course we
should.

My point is that this sanity check acts as another layer of defence.
Bugs happen, but the earlier we catch them the better and this sanity
check helps us do exactly that.

For example, if we did not have these sanity checks, the loud errors I
described above would be replaced by silent use-after-free, double-free,
struct page corruption, or other problems.

So I would like to understand why you _don't_ want to have this line of
defence. What's the problem? If you are worried about performance, we
can go and measure it. If the overhead is too high this can be behind a
debug config.

>
>> 
>> If we want to squeeze out more performance later down the line we can
>> move it behind a debug config, but having this usage pattern of always
>> restoring before using is going to be a lot more sane than just using
>> physical addresses willy nilly.
>> 
>> The approach this series takes with kho_is_preserved() is the wrong
>> design. But a kho_restore() or something similar (maybe we can find a
>> better name?) is really where we should be going.
>> 
>> -- 
>> Regards,
>> Pratyush Yadav

-- 
Regards,
Pratyush Yadav

