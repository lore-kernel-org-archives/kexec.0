Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEFECDB47F
	for <kexec@archiver.kernel.org>; Thu, 25 Jun 2026 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWgZuaM7iYZt7359X1HxJyqC3nPtLZFOpucffsH2wXI=; b=lWCDJps8EjOQEClNRf+056svXV
	1U0eDzUk2rehOvWNgtNxrmDRMja5KToZPIgxzX11y9UzDRRnyZvgpl43F0IvNSiNEtPpHPJWNvJmC
	JGx/IvBQNbf1/4VfMQPjLtqsXTxP4tv7wZAMWlRz8sFTQVBbJmUHNv6eg90FbUdXn6HN8n0l+YQ5h
	XuKZoO8oq7XECBmHf4mTvUfE/1Y7xwZuVv0R8kHaBHWiNeyrYkL0UVoFl7mAhcjgnB2jihzkqukQ+
	PWx2QV72U4262cn3iOO4EVSAjJbqAK27ar4c3SMmGLMEwmBiKKw87yHe7uQPl2j2W5dXbxh7wZrPv
	O7Z1XnGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcg2D-00000008sNE-2XH9;
	Thu, 25 Jun 2026 09:06:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcg2C-00000008sN5-1RCS
	for kexec@lists.infradead.org;
	Thu, 25 Jun 2026 09:06:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A7B664074E;
	Thu, 25 Jun 2026 09:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E7C1F000E9;
	Thu, 25 Jun 2026 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782378367;
	bh=uWgZuaM7iYZt7359X1HxJyqC3nPtLZFOpucffsH2wXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gGUZR+Pmd8hdHISAqIzcRl3hmfPpYxddIlJxAJNelBq2PMgqY2bGB1gn/o1J8/fqV
	 59NTkSRahwRttvehSso/thYLDcRNzZ0lxVwSPidD/wrLyKMO3AoCHasO2KdSotcBeg
	 jmABSXee0C9aVIauoK4MnrnMKMz9PIuUq6JCszf7kJ0/Bc139fnYjtJEPpaogDQ9xP
	 akH1+4QL/VtY6QzrvheG2MDeI9AQogxcjv3pfxXgqfgywzhcCwqduFFXx+s4SuRwMZ
	 eoFP3Q4bTx8lYp46TKZj1t/9c/LrMpAj71JxXAMsCFoE2Nn2HAo2sf3H8YUwGIRbIw
	 /MUqeEuknHjeg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,
  linux-fsdevel@vger.kernel.org,  pasha.tatashin@soleen.com,
  linux-kernel@vger.kernel.org,  rppt@kernel.org,  pratyush@kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 1/2] eventfd: luo: luo support for preserving eventfd
In-Reply-To: <20260625054946.73445-2-duanchenghao@kylinos.cn> (Chenghao Duan's
	message of "Thu, 25 Jun 2026 13:49:45 +0800")
References: <20260625054946.73445-1-duanchenghao@kylinos.cn>
	<20260625054946.73445-2-duanchenghao@kylinos.cn>
Date: Thu, 25 Jun 2026 11:06:04 +0200
Message-ID: <2vxzfr2bkn0j.fsf@kernel.org>
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

On Thu, Jun 25 2026, Chenghao Duan wrote:

> This patch adds support for preserving eventfd file descriptors across
> kexec live updates using the Live Update Orchestrator (LUO) framework.
> Userspace applications using eventfd for event notification can now
> maintain their state across kernel updates.
>
> Preserved State:
> The following properties of the eventfd are preserved across kexec:
> - Counter Value: The current 64-bit counter value, including any pending
>   events that have been signaled but not yet consumed by readers.
> - File Flags: The creation flags (EFD_SEMAPHORE, EFD_CLOEXEC, EFD_NONBLOCK)
>   are preserved.
>
> Non-Preserved State:
> - File Descriptor Number: The eventfd will be assigned a new fd number
>   in the target process after restore.
> - Wait Queue State: Any processes blocked on read() operations will be
>   woken up and need to re-establish their blocking state.
> - All other internal state is reset to default.
>
> Changes:
> - fs/eventfd.c: Add eventfd_luo_get_state() to safely read eventfd state
>   (count and flags), and eventfd_create() helper function.
> - fs/eventfd_luo.c: New file implementing LUO file operations:
>   preserve, freeze, unpreserve, retrieve, and finish callbacks.
> - include/linux/eventfd.h: Export new functions.
> - include/linux/kho/abi/eventfd.h: Define the ABI contract with
>   eventfd_luo_ser structure for serialization.

Why do you need to preserve this? Why don't you create a fresh one after
kexec? You just preserve the counter, which looks pretty much useless.
You can just as well open a new eventfd after kexec and set the counter
value if you care about it.

[...]

-- 
Regards,
Pratyush Yadav

