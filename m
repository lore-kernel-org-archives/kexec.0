Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45F4C7EE24
	for <kexec@archiver.kernel.org>; Fri,  2 Jun 2023 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uUNgUypI0fyqNzAU4yZXJ/us43UbZU3hvN4BtGl9l2w=; b=FdeWGzjJxzcnyS
	+5G6tLdcJdwfZjofIV6xo9/51VzamybDNyX+cDOwztuums524W7j2qjb9vqOBTxdn5Uu4M/ORubEj
	j8ZKvbEr7WqMbujojukwTwuOxpXg8ZAIm5Ujvljy4b+hhJsmQa+B1zSJ1D0+D/YKj2gcHW7NJvbt0
	X2vts9YT0IlLnl6BsiLICtnmIcUTof5M5hRzyeDiBvK22eHeDJpJgtWoZj8h/d6rV1WWMb0RGir0p
	d4kjkcbBlJs2gxM/yBqonFbXD6JT2IY3+veLvn+eUPk2KTdyap8WiEWoXwsWW1wKOekRI87l0EopE
	C0d4grbgwq7CceB17Gww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5CQG-007xHq-0w;
	Fri, 02 Jun 2023 21:35:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5CQD-007xHR-0x
	for kexec@lists.infradead.org;
	Fri, 02 Jun 2023 21:34:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A9CCC61ECC;
	Fri,  2 Jun 2023 21:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2154AC433EF;
	Fri,  2 Jun 2023 21:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685741696;
	bh=x2Bq6SqRV41prwMJ381Fmp+/QUaGoTrwFGIS9pRTnm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hEmhvo6Xb4s96CHynJIOTGFU7GR2g5BCkPcTHJtX6QmTtiWR3Z9NDsvD29kTj4402
	 dusEnc8hvXtHWM3Yk5asN4iuDcgYgAR8q/EPXYXBjtMFUzP1k7XBl8QmcCQLuKOhSQ
	 wielXXa4N+/S+MHpsKtwCRVlQUNkbAxjdcThJISVlfvrhBmE+akCKXhiGTxIBdxhGI
	 bSqjqH9tKRgLKxEaStWPXwabrSqo0xANa6kIGNYc2QKB6KErCDNiUQTffAh3Nyxu1e
	 Amm0RF5Nlb/vOhR0clGs9YgeQ06fpRVt9/AiQc54VXA4Awbog+Xz5IxXB/wWvatfMk
	 s2yNHjND6aNHg==
Date: Fri, 2 Jun 2023 14:34:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, x86@kernel.org,
	dm-devel@redhat.com, Pingfan Liu <kernelfans@gmail.com>,
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Young <dyoung@redhat.com>, Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Message-ID: <20230602213452.GC628@quark.localdomain>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230602_143457_410650_92C98F5B 
X-CRM114-Status: UNSURE (   7.59  )
X-CRM114-Notice: Please train this message.
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

On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
> [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key

The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
happens to use.  But LUKS is a userspace concept.

This is a kernel patchset, so why does it make sense for it to be talking about
LUKS at all?  Perhaps you mean dm-crypt?

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
