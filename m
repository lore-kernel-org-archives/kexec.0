Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84904CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lhOiplwHJN7RMYzXVy8f9SQizVEsjGQWFE877Ok8FhI=; b=2T7jgMmzu7y75DcpZDZE87Mw3h
	Ncfov38Ya3veLzHEvIG/+fViZJW37WTTp/VZs+y8N3T8FVskbEQS7w372kVbzAVSwy9omS2/XtI+V
	1PQ+DFZ1Qqr5uYMnOtwoM4A4saHSfYTfJXkLVsvejGj4WCWHmaBoBNFhEnqzy+UpFASjdEzNz/DfJ
	9B3e2pA5sE3fcVUcsIOJbywLdNRsHYLbG18nLXPjk8DVyzbbEWIM4vhlQE1yogk3X/aW+2e04ukua
	Iagz+ytiUasVbDYEJ7Zx6eSvAuU5VSMBVHKPtwp7JGcZrK+g6hCoVhn7sdyw7DtNe5PErg77SYeJ0
	ACNTwarg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKXfb-00000000AQh-28io;
	Wed, 06 May 2026 08:31:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKXfZ-00000000AQZ-2cv6
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 08:31:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 750E76013B;
	Wed,  6 May 2026 08:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72F7C2BCB8;
	Wed,  6 May 2026 08:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778056308;
	bh=+4uz6jbhFPBlP7cva61vumTFpmu/FNrnQOBaRk+twOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jq6DYWvMV+P15yrk32EwXBt0g2KmIxMn8sH+vWgHCaKAxAv1VKgBmz2d0azo6GG/9
	 GLOnV0kXLLo8yLR6KPtqXgUMHYbExyzl9KGP+iT/KTESsAu+yxxKss6ezxrxH9S03I
	 QZyU/2BmZrb8fVYVvAKQCb7MZtDu87bSTUA5BrxTw6YrmPvxdFv2xHipi9nd4ushse
	 lguzUThiAyXIYFtAI1Ngp4wM+0Y+z6ALhPxlCmwpgunSZU4JM3b5uzAIyeOyUu5X0o
	 EqgNc5j3eObg9xMy77vZL2nNj9bLA8OMWDwicgh/g1XSiFf5axaIFd9TRypkjXjJca
	 RzxZmcFYyKv5g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  liaoyuanhong@vivo.com,  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  graf@amazon.com,
  mario.limonciello@amd.com
Subject: Re: [PATCH v1 1/3] liveupdate: skip serialization for
 context-preserving kexec
In-Reply-To: <20260506043200.2025677-6-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Wed, 6 May 2026 00:32:02 -0400")
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
	<20260506043200.2025677-6-pasha.tatashin@soleen.com>
Date: Wed, 06 May 2026 10:31:44 +0200
Message-ID: <2vxz34050wi7.fsf@kernel.org>
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

Hi Pasha,

On Wed, May 06 2026, Pasha Tatashin wrote:

> A preserve_context kexec returns to the current kernel, which
> is unrelated to live update where the state is passed to the next
> kernel. Skip liveupdate_reboot() in this case to avoid serialization
> and prevent sessions from being left in a frozen state upon return.

Should we also stop KHO? Now it is stateless and always finalized. I am
not sure how these kexec jump images will interact with KHO data, but
seems like we shouldn't be handing over memory if the image will jump
back.

Anyway, for this patch:

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

>
> Fixes: db8bed8082dc ("kexec: call liveupdate_reboot() before kexec")
> Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]

-- 
Regards,
Pratyush Yadav

