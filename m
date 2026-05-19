Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD16CD4F5B
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qbAhnf/+qrcbXwZIkb2YYSSf9SvHVHZdtqtIiK7l1gA=; b=Uq6kQBHA/UFgubzpG8Czi908Y7
	QxO5UfybUDMgiMVdZ6PqZIgpy2M2Ge12uHNg0oIdtJPNeb/1KHxQpKx3X4CesbwAiQ6a7GYJrn2FD
	oGeBPc2T6MaGIyiJ7u7HFoV8KBW4cRJzXPUQdS7AnnLx7998AZi3OzNvEVf4zVA6y3jYMHv7AIdHt
	bps8o3w+F7JiYo/lcT96Z6Ng3l8n/peXZh15KQPI2flMPu1tWHcHwMt3Ji8MB/Vi0bJVW+KcXfwfx
	e4IVnzMcYaJ7LInY/KWdk/FulXNX/VpNnWy3svYZlFOvo/r+h4EW9ycrjDYU87VefmdUcs8U2pbff
	95R8ozmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPLSD-00000001poC-0Y7m;
	Tue, 19 May 2026 14:29:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPLSC-00000001po2-0vd4
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 14:29:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 53F1260126;
	Tue, 19 May 2026 14:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE54C2BCB3;
	Tue, 19 May 2026 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200991;
	bh=wpYoLkXbZ09JzWdvWlJaLOcA/ezxAkZJMM14JmrXOeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ieTKkMkIGrPorjzAIC4Qowt46zqplcOBeUNq1ZB3HqLlNbHueXrmtCW/ZkgG0EbTh
	 da9NpHNjB4JmLOePSe7mAZffwVia+K5LpQ+R9okatjch7uJynWL+BHhiJL8asUZN03
	 UGRfIveprZCY6DLtutBFKcGgDFP0DFn6m0pAmBfjqZm7qym1JF8c8XmeQQVBisXfNp
	 AVAVw7TFaLjdxxHF6O+rCUv+i9z2qy5tL7Y46XXddbgMP1fdmT3eHkN+B2qWsv5n7J
	 Wya8na+pgNRBx4iVhGW9AiQXq2KTI6SaZjljOl4nYEIpVQCFrGj4NJPIj6vwDU/6eI
	 FMom3pl8gSKrw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: validate session type before performing
 operation
In-Reply-To: <agxuNavjtB8T_xRO@plex> (Pasha Tatashin's message of "Tue, 19 May
	2026 14:11:26 +0000")
References: <20260519122428.2378446-1-pratyush@kernel.org>
	<agxuNavjtB8T_xRO@plex>
Date: Tue, 19 May 2026 16:29:48 +0200
Message-ID: <2vxzfr3n8obn.fsf@kernel.org>
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

On Tue, May 19 2026, Pasha Tatashin wrote:

> On 05-19 14:24, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> The sessions ioctls are not applicable to all session types. PRESERVE_FD
>> is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
>> valid for incoming session. Calling a incoming ioctl on an outgoing
>> session is invalid and can cause file handlers to run into unexpected
>> errors.
>> 
>> For example, a user can create a (outgoing) session, preserve a memfd,
>> and then immediately do a retrieve without doing a kexec in between.
>
> Please add a self-test tools/testing/selftests/liveupdate/liveupdate.c
> to verify that outgoing sessions do not accept retrieve_fd ioctl.
> Option, you could also add to luo_multi_session.c a test to verifying 
> that incoming does not accept preserve_fd

Right, forgot about that. Will do.

>
>> This would result in memfd's retrieve handler to run. The handlers
>> expects to be called from a post-kexec context, and will try to do a
>> kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.
>> 
>> KHO catches this (thanks to KHO_PAGE_MAGIC) and returns an error, but
>> since this is considered an internal error and KHO throws out a bunch of
>> WARN()s.
>> 
>> Associate a type with each ioctl op and validate the type in
>> luo_session_ioctl() before dispatching the ioctl handler to make sure
>> the op is being called for the right session type.
>> 
>> Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

