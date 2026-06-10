Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB9BCD98C7
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yx1gbHfpUuLkitzdfd+5Th5a6Mcon18GaLpdA3Hy7TI=; b=RY8KarxoBFpcld7d/KOII8gbAG
	tmeXo9UziB5D4/QJWmeqbd1YcPpvx+ordWU4ZXuVPKDt2CE9Co8rH5Jjrr61PRdR5RNHrrOTFHBo5
	nFzt3uTrapicsA+Kta8JPKY1Qn3JTObxtDYgbdDj7GfxAzF/Glh7+LZTcdryQCmah2bUtr0VWj2bg
	Kt0lA/crc9snnTWF+Cr7pKPunFHxBSsS4jRixR9R6+zVpsmgNXV6xywD7OO1kbYKQsfBuNutMHl2H
	S1ccSp56ZveKlUffmOSpalQicK2J/kvKTVDk6x9L2ndjsonc4uTvj3CREUw3NB1QNZSLigB6kzDRn
	aWnswifg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXPcr-00000008KTw-0AJy;
	Wed, 10 Jun 2026 20:34:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXPcq-00000008KTq-2ZAS
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 20:34:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 786B760204;
	Wed, 10 Jun 2026 20:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF0F1F00893;
	Wed, 10 Jun 2026 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781123651;
	bh=yx1gbHfpUuLkitzdfd+5Th5a6Mcon18GaLpdA3Hy7TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dqxZHhMkgsCq5+FvMAOt3LSzGOHLxltZJLG+CYXEir78A1GINdncpFDwAKc4qCvce
	 KEShpS35J5kVjqSne7DT9EUFp/xVXGwfKsU6UE/VSE4MHmIPfBltqo0ig8crpty7r4
	 zJAiyJE6q+dkd3ErVFcroHeJrUaRToNIVPdR7jeSe+zJyOVvv1wFUWUIOjqOP+mf9W
	 St/ijDkn8GzCwj/Vf5jUmsqa+xEuAEtx9SMXMkhYE/L0iqWfbqih7+8j+tWQAAaBI3
	 9Zl1lEG6qKro5HUg5lWM9Ox0Guz2DZoVMVqWgcyy3E7wRaIxULKBOtrsk7Z+A+MuLy
	 bKLU4bI1qnzgQ==
Date: Wed, 10 Jun 2026 13:34:10 -0700
From: Kees Cook <kees@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH v2] pstore: add a KHO backend
Message-ID: <202606101331.BDB11F097@keescook>
References: <20260605121040.1177072-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605121040.1177072-1-mclapinski@google.com>
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Jun 05, 2026 at 02:10:40PM +0200, Michal Clapinski wrote:
> Up to this point to preserve late shutdown logs in memory, users had to
> predefine a memory region using ramoops. This commit changes this by
> preserving a buffer using kexec-handover.
> 
> pstore_kho supports preserving only 1 dmesg buffer.
> It gets replaced with the new buffer on every kexec, so the user has to
> copy the file out of pstore after every kexec.
> There is no erase() support.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

I'm a fan of the idea! I'd love to see a selftest added for this
backend, since it should be possible to do a direct tests for dmesg
preservation across a kexec in tools/testing/selftests/pstore/

There is still good feedback from sashiko, which caught everything I was going
to mention and then some:
https://sashiko.dev/#/patchset/20260605121040.1177072-1-mclapinski%40google.com

> ---
> v2:
> - Added a comment explaining the benefits of pstore_kho.
> - Created include/linux/kho/abi/pstore.h.
> - Got rid of the KHO subtree.
> - Made sure never to free incoming kho data.
>   This way the module can be safely reloaded.
> - Sashiko complained that I trust the data coming from the old kernel.
>   I ignored it. LMK if I shouldn't trust the old kernel.

We shouldn't trust the old kernel. :) Sashiko's suggestion here seems
reasonable which is to at least bounds-check the size against
RECORD_MAX_SIZE since that's the largest it should ever be.

-Kees

-- 
Kees Cook

