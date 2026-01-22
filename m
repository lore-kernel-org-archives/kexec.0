Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B96DD6260F
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 10:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8baty6keMhMUDZEZ/HySgtZbwD+Eaq2dG2O7a86KuYo=; b=OTNQLjbMUzVX/M8TPFUY/wbj6g
	p2HBAXGp62dch/ElSG/oeuE9Wr9YOwiUdPMfA92BskXNVeuihsjvfGa56B9nQUsVTMdkyvHyC/tD+
	jZJ2b+GgQwKCv6dsnnEDtkAcAYKnviH7E4D0COBsURlSC+KnKs69xnxfXvguil34jOCXX3U3Vdxg8
	brtu0E/QxmiytnxShfhx38W3KT8HxYbZ7q+4xlAtICJjOcJi6TQEwyc7u3JXcW56g75z/i2AFCZRP
	0iJDOo5+9C4nTr7feTlxFxRUACSSBx4qvbinUSYMpgzc4Hb4ggir/rOL8Z8VMhazVKrto7M0aToVL
	Jp+GRjWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1virqV-00000006pWL-45Pj;
	Thu, 22 Jan 2026 10:23:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1virqV-00000006pW3-0N2A
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 10:23:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 720AE600C3;
	Thu, 22 Jan 2026 10:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3463AC116C6;
	Thu, 22 Jan 2026 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769077402;
	bh=0te499sdFFCQEZXIav3Juo25FvmqHOPhfdLK4InvpvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f9A2yDifc9zaJDGikz+SPpBGjANGZ4ZtYGk9NJnIjH1Xhs6PV/U1QQxa4KvrGTQQn
	 okMz3uRIwBrZRTJoWDuhfOScqMTBWMVB0i6QB/mCDQDzT8QwInJ+E5+y/uWJspAjdm
	 OYMX6nw1k3adDJWMx9VzX2VUN7uEnv4gTTDkvpLHmEHhQyKUfD1znHPns4zX95E/wv
	 8ppBdCUsPUUkBoTR+Fj3t54GAIUrJuGBXEdkuk03fB44t/BUNWZOpDSC6GRFuVxH4o
	 OOpWTLsceSevIae0ARyA9C3rEPmchP8AGB7yd3WVbRp7hJAizg7HNWjNfKcaUnp69B
	 QnMgNHfAtmNLw==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: akpm@linux-foundation.org,  graf@amazon.com,  kent.overstreet@linux.dev,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  ran.xiaokai@zte.com.cn,  rppt@kernel.org,  surenb@google.com
Subject: Re: [PATCH v3] kho: init alloc tags when restoring pages from
 reserved memory
In-Reply-To: <20260122042506.175897-1-ranxiaokai627@163.com> (ranxiaokai's
	message of "Thu, 22 Jan 2026 04:25:06 +0000")
References: <20260121120804.d1334ea0cc66b4a6de691cbf@linux-foundation.org>
	<20260122042506.175897-1-ranxiaokai627@163.com>
Date: Thu, 22 Jan 2026 10:23:18 +0000
Message-ID: <2vxzqzriaquh.fsf@kernel.org>
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

Hi Ran,

On Thu, Jan 22 2026, ranxiaokai627@163.com wrote:

>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>> 
>>> Memblock pages (including reserved memory) should have their allocation
>>> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
>>> released to the page allocator. When kho restores pages through
>>> kho_restore_page(), missing this call causes mismatched
>>> allocation/deallocation tracking and below warning message:
>>> 
>>> alloc_tag was not set
>>> WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
>>> RIP: 0010:___free_pages+0xb8/0x260
>>>  kho_restore_vmalloc+0x187/0x2e0
>>>  kho_test_init+0x3c4/0xa30
>>>  do_one_initcall+0x62/0x2b0
>>>  kernel_init_freeable+0x25b/0x480
>>>  kernel_init+0x1a/0x1c0
>>>  ret_from_fork+0x2d1/0x360
>>> 
>>> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
>>> fix this.
>>> 
>>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>> ---
>>> It is based on linux-next 20260120. I dont konw whether this base is ok ?
>>
>>It's awkward.
>>
>>Your v2 patch was based on Linus mainline.  This is appropriate, as the
>>patch should be sent to Linus soon and it has cc:stable, so -stable
>>maintainers will try to backport it into earlier kernels.
>>
>>However your v3 patch is dependent upon other material ("kho: simplify
>>page initialization in kho_restore_page()") which is scheduled for
>>6.20(?)-rc1.
>
> I think i misunderstood Pratyush's last reply:
> "I suggested a re-roll of this patch based on top of my cleanup patches
> [1], since I think with those the end result is a bit nicer."

I was giving context to Andrew about the whole thing.

I thought it was a good idea when I suggested it to you, but at the time
I didn't think that this will go in the hotfixes branch. If it goes in
hotfixes, it doesn't make sense to base it on a series for the next
kernel.

Sorry for the confusion.

>
>>For a prompt, backportable merge it's best to base the fix on latest
>>Linus mainline, please.
>>
>>You didn't actually describe why v3 is different from v2.  If the
>>v2->v3 changes are just nice-to-have then let's redo those and base
>>them on linux-next in the usual fashion.
>
>>Unless I'm missing something, your well-reviewed, decently-tested v2
>>patch remains suitable for upstreaming during 6.18-rcX
>
> v2 version just fixed the folio case(compound page), but didn't fix the
> contiguous order 0 pages case. So i think it is better to send a v3 version
> base on lastest Linus tree and drop the v2 version.

Yep, that would be the idea. Resend the changes fixing both compound and
non-compound cases on top of Linus' tree and ignore my "simplify page
initialization" series.

And then I can later resend my series on top of your patch.

-- 
Regards,
Pratyush Yadav

