Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41610F3381D
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3e0YC03hyon1Le6dOafGrBEV+8gcHzSoitXDLRAEfg0=; b=UzDE9cNcbk4VElRkFnz6dkZpdW
	XoASAZB/XIIHd7cjcgciFfpvdj1+SU07jp6NlcecSDOfw+Oj7/gsDuTWg/488gGATTScg11Frr3eQ
	N2KKRV5cNDPzhggsxK5DEJIoCh1KNItHl+iwg+ck1JJBpwKbs2evWLN8yXiSeUrufhgREv1lHe98P
	n/cbShhwJnAr1v+GKgpiLKzgTMdXDcFY4M/g+uSiniYcsLfMylGTvN2ggrLbh6Urjree449TLyFxe
	8cPDnHwaMaEChUlCEy/LvQtFSsr9j9Rc+FCCZQpu12SwWdQTQy1+NrVYG59mPjit1PBPeLucxqoqx
	N9jm1/tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QQu-00000005oRM-1Me7;
	Tue, 17 Mar 2026 09:09:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2QQn-00000005oQa-32Hj
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 09:09:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EF67860127;
	Tue, 17 Mar 2026 09:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70463C4CEF7;
	Tue, 17 Mar 2026 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738580;
	bh=Ak+fkoI4kuQLOTzVMHsdfWZxTKkFz4NFB8J6dcF3eS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i7SW/bR05M3EjYJgdOTRtR0PzK6x+w20Ft0042LLJ6uprnCdWX0HmDexl5MVUNu7l
	 h+REqv0LK2fhaBMyoK7B3MAdNKQVF6DY8TZeUZUB7P8KyRHzWaEzvjE+ZdUNyJJeD1
	 RpGWZKX8DYZeoxLww7PNXtUy9YpT/CyjTZXXotLkjTqOOteuaAi8sKTk8jQyiTjCfl
	 zx8ubORE5LoN6oLyWw6L0pPxyICvVFV+8ukD7WY+p0cwePLLHBmC8i/hW4k+CxYyed
	 bs6/N+hEyhAYeTKpgjb8mk436rwyZpqIVa0T45Ne/jUVswC3aZdh3/SUoohUweuGLW
	 +navEj6W7tgbQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  ranxiaokai627@163.com,
  graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  jasonmiu@google.com,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  ran.xiaokai@zte.com.cn,  Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH] kho: fix child node parsing for debugfs in/sub_fdts
In-Reply-To: <20260314154637.86a7d4f07800b59c00049814@linux-foundation.org>
	(Andrew Morton's message of "Sat, 14 Mar 2026 15:46:37 -0700")
References: <20260309033530.244508-1-ranxiaokai627@163.com>
	<2vxzpl58f3oh.fsf@kernel.org>
	<20260314154637.86a7d4f07800b59c00049814@linux-foundation.org>
Date: Tue, 17 Mar 2026 09:09:36 +0000
Message-ID: <2vxzse9yddpr.fsf@kernel.org>
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

On Sat, Mar 14 2026, Andrew Morton wrote:

> On Fri, 13 Mar 2026 10:02:06 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:
>
>> On Mon, Mar 09 2026, ranxiaokai627@163.com wrote:
>> 
>> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> >
>> > Commit e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
>> > changed KHO_FDT_SUB_TREE_PROP_NAME from "fdt" to "preserved-data". However,
>> > kho debugfs code still hard-coded the "fdt" string when parsing the
>> > device tree, causing the debugfs node /debugfs/kho/in/sub_fdts/
>> > fail to parse child nodes correctly.
>> >
>> > Fix this by including the header file and using KHO_FDT_SUB_TREE_PROP_NAME
>> > instead of the hard-coded string.
>> >
>> > Fixes: e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
>> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> 
>> Breno's patch [0] also fixes this, but I'd rather have this go through
>> hotfixes and get backported to stable, and Breno's series to build on
>> top of this.
>> 
>> [0] https://lore.kernel.org/linux-mm/20260309-kho-v8-4-c3abcf4ac750@debian.org/
>
> Confused.  This patch (kho: fix child node parsing for debugfs
> in/sub_fdts) fixes the mm-unstable patch "kho: adopt radix tree for
> preserved memory tracking".
>
> So what are you suggesting be added to -stable?
>
> (Please lay it all out very clearly, idenfifying patches by name!)

Sorry, my bad for causing the confusion. I thought the radix tree
patches ("kho: adopt radix tree for preserved memory tracking") already
landed in mainline, but I went and checked and it seems that they
haven't. They are still in mm-unstable. So we should just meld this
patch ("kho: fix child node parsing for debugfs in/sub_fdts") into
("kho: adopt radix tree for preserved memory tracking").

There is nothing that needs to be added to -stable, and there is nothing
that needs to go to hotfixes.

Breno's patch ("kho: fix kho_in_debugfs_init() to handle non-FDT blobs")
also fixes this bug, but then also adds some other changes with it. So
Breno's patch will cause conflicts once applied on top of this patch,
but they should be simple enough to resolve I think.

-- 
Regards,
Pratyush Yadav

