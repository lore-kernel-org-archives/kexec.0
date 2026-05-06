Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93738CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1NlSxiVeRccjoO9T41j1TDUVCXxIrINfCMNKdoJdfgU=; b=iS84NX9/4dtcchlA9TlUIQJ5j8
	xjdrPF/pM5lnTFxbQnzll7FdZVeGRxZcPF5+2AXmxbyFyWnk0MbkNjSaBl+PyH7SNZ167h6eYXgMz
	70FDIC1+KTTjE/nknrHm0amtxmtCYVDRmKJUqMuwiBUkboryvyYtGTpvfs7wAO1+fEMzYwwS64Uf7
	ibpT4xriDCNQpwlz8lisgJYRYdBJ/pSn7NP4/sDW5gDpGccq2kGTXMt2bjXPhw5Mw2gdhylAVRpwB
	T+Yev78kZHioTBEk0IHpcR3/+it6M4MmRBkNpW4SfyfQ5enx3+4xoZjHaZeVJ6ycpqgY5/auqmtwJ
	9Zl0xLNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKY0i-00000000FvG-42tR;
	Wed, 06 May 2026 08:53:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKY0h-00000000Fuu-3h0m
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 08:53:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 265376013B;
	Wed,  6 May 2026 08:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0C2C2BCB8;
	Wed,  6 May 2026 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778057618;
	bh=7nPqnjcbCwL0xt6SvXlllnq2oT21ELzYOApfrUFK6HY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cvt1x3sLIqFHyinhL5mHeD5/hAflSnAzfTmfzstfDkR6/cUsiZcVCxgbubNL3slcw
	 ZpjhgFwfJj4ekADWRN7VPECArnPUN6EjoD8bw+lUe/ilMXgHB05Dpt1eXIYjFL95/Q
	 5mdsLprp5YYdtjA4IFAip7brC8eAw8Xh9BabObRhLzvy1f0t8tYufgoU0eA1Lyi/+0
	 Wj/+r9nURDqRbQ0951ql2YECT8JVXfIXnPvaCMS27YFVSKZTnBqNxh10ZIs4D5zkTD
	 w1wQsGXHOaTCGQe9VsqJaxziucvka+4gTd3VK8nJ657C6Gly2K2H3LSKm+UjB4msvm
	 Q1CnD1lEBYLxg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  liaoyuanhong@vivo.com,  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  graf@amazon.com,
  mario.limonciello@amd.com
Subject: Re: [PATCH v1 3/3] liveupdate: pin sessions and handle inactive
 ones during serialization
In-Reply-To: <20260506043200.2025677-8-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Wed, 6 May 2026 00:32:04 -0400")
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
	<20260506043200.2025677-8-pasha.tatashin@soleen.com>
Date: Wed, 06 May 2026 10:53:34 +0200
Message-ID: <2vxztsskzzox.fsf@kernel.org>
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

> During the reboot() syscall, user processes are still running
> concurrently. Even though the system is actively serializing LUO
> sessions and will not return to userspace unless liveupdate_reboot()
> fails, it is still possible for a user process to close a preserved LUO
> session. This creates a race condition where a session could be
> destroyed while it is being serialized.
>
> To fix this, we must ensure that we only preserve sessions that are not
> closed at the time of serialization. Take a reference to the session's
> struct file for all outgoing sessions to pin them during this process.
>
> Handle inactive sessions (where get_file_active() fails) by cleaning
> them up and removing them from the outgoing list during the pinning
> phase. This ensures serialization can safely proceed with the remaining
> active sessions.
>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Same here. If we hold the session header and session locks, we don't
have to worry about all these corner cases. It is too late to touch the
session once liveupdate_reboot() starts, and if you try you just get put
to sleep.

[...]

-- 
Regards,
Pratyush Yadav

