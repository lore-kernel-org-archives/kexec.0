Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7EACD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jwWBXQiXwMzWbuhR/ImNISeDkzf0zSBbuQwL4WAjm2c=; b=UXLFVmWQJ/tJC57Ssu7a5QTnx6
	4816ZoyuUhZ0cfbMIzUhxBpUC1i3g4tP6bxt8+zyVYekcHzYBQtG2tW3nTA0eTN+zoxI/fH7NoqsC
	+MXeq6p9Fjd/qhdZ3vlFul3W19kAQfaAB4uLWcJE+r+Zl4iH0wKZ+4WsmD5ew8lTGQE71CL4jqC+C
	ULxtN5plXGrLOdnSxH4fNx0ctyoyuJWK8unKA8AR5I2h/FOZ9vnRLVnJDxT79IdvrMT8zMAUqq3C8
	D442bl/XEcLxmMx6Aw/acOmkJooXhlK3Jh2HKqtfRxujL4usPSBTKP6zrxAkwx7XzFH8Z3d9xjTGo
	BTT5iHkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY35u-0000000B63G-2HXN;
	Fri, 12 Jun 2026 14:42:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY35t-0000000B62t-2jbb
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 14:42:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F1B6E4023D;
	Fri, 12 Jun 2026 14:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92021F000E9;
	Fri, 12 Jun 2026 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275368;
	bh=jwWBXQiXwMzWbuhR/ImNISeDkzf0zSBbuQwL4WAjm2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bBuLkvKxT+kPA04dXzNpzQe7XYQPe5J21ZN84ddImYNY4vHMo0/nKOAHBPzVE1sYm
	 3G16pALc4InZjTXAEuo75KY0VAX2Wo+8cyX50suVJC0xtOW+qy/eNF/1xFaXM33Pru
	 v+ehcMANfuapy5URhVBwmL/C6MxkxOAkm5VdWH5PMr/ZxMt5hHolvaD9toVBAjEggQ
	 sSGj/sVajvXPZ35rB4GKd3vs48SxCI53rv/ZSdVry5AH1oxSkLCmaRrqNr4Qe3cc0l
	 xjp1JO5mtWkhrPNZHbupEGYZl9wjTZG/rrTfIkWhWJjlP3zBE0yh5sDrHfzsQArDdJ
	 LRkfX55dOJCJQ==
Date: Fri, 12 Jun 2026 17:42:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH v2] pstore: add a KHO backend
Message-ID: <aiwa4jIWEMsvfnVg@kernel.org>
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Kees Cook <kees@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, Jun 05, 2026 at 02:10:40PM +0200, Michal Clapinski wrote:
> Up to this point to preserve late shutdown logs in memory, users had to
> predefine a memory region using ramoops. This commit changes this by
> preserving a buffer using kexec-handover.
> 
> pstore_kho supports preserving only 1 dmesg buffer.
> It gets replaced with the new buffer on every kexec, so the user has to
> copy the file out of pstore after every kexec.
> There is no erase() support.

Sorry I didn't jump at v1.

pstore does not really need a KHO backend. It can use ram backend with
reserve_mem and reserve_mem can be preserved with KHO already.
 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> v2:
> - Added a comment explaining the benefits of pstore_kho.
> - Created include/linux/kho/abi/pstore.h.
> - Got rid of the KHO subtree.
> - Made sure never to free incoming kho data.
>   This way the module can be safely reloaded.
> - Sashiko complained that I trust the data coming from the old kernel.
>   I ignored it. LMK if I shouldn't trust the old kernel.
> ---
>  fs/pstore/Kconfig              |  10 ++
>  fs/pstore/Makefile             |   2 +
>  fs/pstore/pstore_kho.c         | 230 +++++++++++++++++++++++++++++++++
>  include/linux/kho/abi/pstore.h |  27 ++++
>  4 files changed, 269 insertions(+)
>  create mode 100644 fs/pstore/pstore_kho.c
>  create mode 100644 include/linux/kho/abi/pstore.h

-- 
Sincerely yours,
Mike.

