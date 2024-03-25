Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64408C54E64
	for <kexec@archiver.kernel.org>; Mon, 25 Mar 2024 20:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ca00uwD7eCA/847KCHrvQum+ycmmAxRwYPFF09PeVb0=; b=JIJUf2Pa2ngKGe
	Ujn4jmSR25InvN9YNDkRj9YL529becpjduhJbRN8rr8hT6TbmwSScDYKEqyFtKJU77mprvPu7JLge
	KYPT2+VCs5bE0z9qTm2mfDRcsSFJG+DBTI7vUF+jGlCDV9RQxqxFooijOmWNGbYKWPNnjHgkE6Rh/
	HsXEkYWRkLQroFCOS9VB0b0mWGSTku8C9F9tHdP9rk2dud+ZqzfunLUawPKxRU71a0oKxDrZqtnwm
	yjCIEEdN4dhe3Wgho4n+8UXHvhttIhrUWe05pAZdUAn3NLUDu3ZV0FrFjSu1mKkS8W7FMiUD43OkD
	3JCuGsMtO80hnONHPZIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roqwV-00000001nxS-3FI1;
	Mon, 25 Mar 2024 20:29:15 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roqwT-00000001nvy-1qgt
	for kexec@lists.infradead.org;
	Mon, 25 Mar 2024 20:29:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6B9EDCE1D42;
	Mon, 25 Mar 2024 20:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD3AC433C7;
	Mon, 25 Mar 2024 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711398550;
	bh=nfVLFY97TTH4TNsZH8G5ndSxRhKAMtXtADlNh6V0jyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lLqvdpovYZYCLrBxcniicIdrfgG84STczHwD082AmwsVdLSbADv7f8H+LXhIBvDgn
	 jFPLERwXKBBCnDazptInYJ5w1EdJJyIqLziwHyHzqpdNzPQkPg/xibLzKrLh5VcNub
	 DEDjxkQPrWn24SyhoPel+o+zO2Rr/LLZoK2Ccv4E=
Date: Mon, 25 Mar 2024 13:29:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, chenhuacai@loongson.cn,
 dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
 chenhaixiang3@huawei.com
Subject: Re: [PATCH v2] crash: use macro to add crashk_res into iomem early
 for specific arch
Message-Id: <20240325132909.741ae47a8a05837c175a981e@linux-foundation.org>
In-Reply-To: <ZgDYemRQ2jxjLkq+@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
	<ZgDYemRQ2jxjLkq+@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_132913_717593_0961B041 
X-CRM114-Status: GOOD (  13.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, 25 Mar 2024 09:50:50 +0800 Baoquan He <bhe@redhat.com> wrote:

> There are regression reports[1][2] that crashkernel region on x86_64 can't
> be added into iomem tree sometime. This causes the later failure of kdump
> loading.

So I think a cc:stable is needed.

> This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
> crashkernel resources") was merged.
> 
> Even though, these reported issues are proved to be related to other
> component, they are just exposed after above commmit applied, I still
> would like to keep crashk_res and crashk_low_res being added into iomem
> early as before because the early adding has been always there on x86_64
> and working very well. For safety of kdump, Let's change it back.

I'll use 4a693ce65b18 as the Fixes: target, since there is no
"Exposed-by-non-buggy-patch:" tag.  To tell the -stable tree
maintainers how far back in history this should be backported.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
