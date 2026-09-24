Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD54C98317
	for <kexec@archiver.kernel.org>; Thu, 24 Sep 2026 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjlo8XBtE9TxB1LKTX/vUG/maDWdF6slESEL4axLxF0=; b=xWl+P2wu3k9Iy6AFNqHKm4FG3K
	+4lpqLiIFKOVaBYxMHpgSe/3nK7FF+uOckiDz3WezZtUm0GiY7/pYj4mNIBXbMlWPFuVyDt6PJbpq
	T9U0gA2fFgMUOmNtSvGNr7Cu746Vc1is0ymzQGsrT/0dlpVAZmZ9ymH05HtMdIKLeVnLaxh10OlR+
	OMU/HKwTg1yLBgODL3Y8Yv7KO/wp2oiu/LL5FdiMoR8Dg8DyzLbR1ucw8kw6UBfuxuhARWab8cg7E
	74DHjfMEqSeT0w7494BectKHvzM+bBhyj2G8KOfuilvewp8k8SEmaX64lvII+2Z05OWdeHGbfd+YH
	vTm/I3qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9jT5-0000000B5MG-30xQ;
	Thu, 24 Sep 2026 13:26:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9jT3-0000000B5M6-3AUj
	for kexec@lists.infradead.org;
	Thu, 24 Sep 2026 13:26:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DFA2F601FE;
	Thu, 24 Sep 2026 13:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15541F000FF;
	Thu, 24 Sep 2026 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256388;
	bh=kjlo8XBtE9TxB1LKTX/vUG/maDWdF6slESEL4axLxF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EXoEyJpbObkYPw/DP1BT2piCT31gRKuurm0smBCDhbkQwG4a2mfShKuql3FVVLIjm
	 +yA/famYpOLn89tGaZGE+MzXDC1ESpo5SncCDOsPksbiM3Bvm3pVL55WPEW2ZEFrTS
	 PJe6teyjuYG0jkQsqYCFIhZon1XF4icI4W44CDhYIwY7CHPbsaGFygYPIsCv8RvtW8
	 8HlnJpEghYdF0tIp4r24+iUYmRjjr/Np/xzuf8gTk6o+gyERUXhEtTdy9J/qN7F7hr
	 tbZlHPvZtTXvrpoq1AhVWxM6YNeYJTZ9D0iFATWWZqb8GNhSvZp7In4Qz+IfdXphnC
	 ffIWYWAo54S0A==
From: Pratyush Yadav <pratyush@kernel.org>
To: sashiko-bot@kernel.org
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  "Samiullah Khawaja" <skhawaja@google.com>,
  "Pratyush Yadav" <pratyush@kernel.org>,  "David Hildenbrand"
 <david@kernel.org>,  "Alexander Graf" <graf@amazon.com>,  "Baolin Wang"
 <baolin.wang@linux.alibaba.com>,  "Mike Rapoport" <rppt@kernel.org>,
  "David Matlack" <dmatlack@google.com>,  "Hugh Dickins"
 <hughd@google.com>,  "Lorenzo Stoakes" <ljs@kernel.org>,
  sashiko-reviews@lists.linux.dev,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/6] liveupdate: luo_file: look up outgoing tokens
 by id
In-Reply-To: <20260923225550.32AC21F00898@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Wed, 23 Sep 2026 22:55:49 +0000")
References: <20260923224408.3745689-1-pratyush@kernel.org>
	<20260923224408.3745689-2-pratyush@kernel.org>
	<20260923225550.32AC21F00898@smtp.kernel.org>
Date: Thu, 24 Sep 2026 15:26:24 +0200
Message-ID: <2vxzwlsa4w73.fsf@kernel.org>
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

On Wed, Sep 23 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] liveupdate: NULL pointer dereference in liveupdate_get_token_outgoing() on incoming sessions
> - [Medium] liveupdate: flat ID namespace in liveupdate_get_token_outgoing() risks cross-handler collisions
> - [Low] liveupdate: O(N) indirect function calls in liveupdate_get_token_outgoing() list traversal
> --

Let me reply to Sashiko for this patch since I think we should take this
regardless of where this series goes. I think struct file is the wrong
primitive for liveupdate_get_token_outgoing().

I'll ignore Sashiko on other patches. It does raise some good points,
but code correctness isn't the main point of the series. I'll fix them
up on the main posting if we agree to go in this direction.

>
> commit 17b042e4901cfc25a86dec1038092fbe1eb5d060
> Author: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> liveupdate: luo_file: look up outgoing tokens by id
>
> liveupdate_get_token_outgoing() is used to look up tokens of dependencies.
> It does the search based on struct file. LUO provides file handlers a
> get_id callback that can return the unique identifier of a resource. This
> patch uses ID to look up dependencies in liveupdate_get_token_outgoing()
> instead of struct file.
>
>> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>> index a39992da504fb..51817d202ce26 100644
>> --- a/kernel/liveupdate/luo_file.c
>> +++ b/kernel/liveupdate/luo_file.c
> [ ... ]
>>  int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>> -				  struct file *file, u64 *tokenp)
>> +				  unsigned long id, u64 *tokenp)
>
> [Severity: Medium]
> Will this flat ID namespace risk cross-handler collisions?
>
> Because liveupdate_get_token_outgoing() searches across all preserved files
> using just an unsigned long id, it loses the context of which file handler
> the ID belongs to.
>
> If different handlers use overlapping namespaces, such as IDR indices or
> pointers that might alias depending on object lifetime, a lookup intended
> for one handler's object could incorrectly match an object from a different
> handler that happens to appear earlier in the list.

The IDs are supposed to be unique in the whole session. That's the whole
point of the ID mechanism. If handlers use overlapping IDs, the handlers
are broken and should be fixed.

>
> Could the API require the expected file handler context to scope the search
> safely?

This can be done but only when there is a need for it, which we have not
seen so far. Without a use-case, namespacing the IDs per-file-handler is
overengineering.

>
>>  {
>>  	struct luo_file_set *file_set = luo_file_set_from_session_locked(s);
>>  	struct luo_file *luo_file;
>>  	int err = -ENOENT;
>>  
>>  	list_for_each_entry(luo_file, &file_set->files_list, list) {
>> -		if (luo_file->file == file) {
>> +		if (luo_get_id(luo_file->fh, luo_file->file) == id) {
>
> [Severity: High]
> Can this cause a NULL pointer dereference on incoming sessions?
>
> In an incoming session after deserialization, luo_file->file is initialized
> to NULL and remains NULL until the file is explicitly retrieved.
>
> Because liveupdate_get_token_outgoing() is an exported API that accepts a
> generic struct liveupdate_session, an in-kernel caller could mistakenly pass
> an incoming session.

That's a broken caller and should be fixed.

>
> Prior to this patch, doing so would safely return -ENOENT because NULL == file
> is false. With this patch, luo_get_id() will blindly pass the NULL file
> pointer to the handler's get_id callback.
>
> Handlers like memfd_luo call file_inode(file), which would cause an
> immediate NULL pointer dereference and kernel crash.
>
> [Severity: Low]
> Are these indirect function calls necessary during the list traversal?
>
> Replacing the direct pointer comparison with luo_get_id() performs an indirect
> function call (fh->ops->get_id) if defined, on every iteration of the
> files_list traversal.
>
> Because this function is used to look up tokens for dependencies, it can be
> called for every dependency of every preserved object, resulting in O(N * M)
> indirect calls.

A very large number of files with dependencies need to be preserved for
this to be a problem. We haven't hit this bottleneck so far and don't
think will hit it at least in the near future.

>
> Since the ID is a constant property of the preserved file, could it be
> evaluated exactly once during luo_preserve_file() and cached directly in
> struct luo_file?

Not a bad idea to be fair. But that's an independent fixup.

>
>>  			if (tokenp)
>>  				*tokenp = luo_file->token;
>>  			err = 0;

-- 
Regards,
Pratyush Yadav

