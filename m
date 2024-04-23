Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EFCC4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=thNrv08iU4TlgBQ4GLdlQ7kTtqyZmTIzOAPgYAZj8B4=; b=c4gQWVTefWGZkb
	TVbSw5/pcB06914ZjyqLQsZpxDDRdvK42Wce2TgMcG8TSyAfhFdoQTreuP5NqgVZ3ihVPy7XTs3Pp
	+bm/Zv0jRqKAtmWXeGKvzTs9Ca0MC+B5vuO+ZinZHuBcXUntJeDI7RnuPkSJ6CXH803u+EHbtmAKf
	ZVFBeXbULizjjBhzJ/SwWkU+kXu5RZ5WDP0X+UuEH2luIBR1TmNVmZGQJDQT1oohBWlCyKr4tpTAo
	ntwNT9kPVCCklkvv1VDt/RnsYNLgrMwa+M5kW/X0H88i9OkovWukxz81JLKGB2EmQoTXHsCaCWR4P
	ObmGBeMJTpIbiuw1YDzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzD5x-0000000Gn5f-27cr;
	Tue, 23 Apr 2024 10:09:49 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzD5u-0000000Gn4z-3kbs
	for kexec@lists.infradead.org;
	Tue, 23 Apr 2024 10:09:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7C226CE0B77;
	Tue, 23 Apr 2024 10:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E739FC116B1;
	Tue, 23 Apr 2024 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713866983;
	bh=SDrP4kaBL1QTqOrq543JUsX6/r4rmoGEDKqDVQE2Tgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSxihSSuCrj6KKttZSw/JNkDPUFhhLj2FBO1e4hQu5taz0qhfXUBNtIvw8cSJqmWC
	 D0HXkavl5zSdIVVvtYMhD70mrfufXVG/ZSGYh4YWTeYdISd7LNmSH3sjmUJEpACd8m
	 ZWQEjln7HvMXu5H/VG8iqdZH+Hn8aq9fRbuj120c2/gMdNR04B94iNQtc86jehBegJ
	 OZYphnfv/LdxSX6mOJ6qUrH7C3sFGLvisOcLzhYnRDSlntWGaKO2DBTlQzyYcNC92w
	 YV/dAfXwSpxyjvskBXGbOODhbMBNnK1ZPhjiWMyJswEsio3yl2EA/ICnJpVOisyS/y
	 IHL0AwpmhrdnQ==
Date: Tue, 23 Apr 2024 11:09:39 +0100
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash: Fix spelling mistake: "crahskernel" ->
 "crashkernel"
Message-ID: <20240423100939.GH42092@kernel.org>
References: <20240419085206.888416-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240419085206.888416-1-colin.i.king@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_030947_153736_FE71FB5D 
X-CRM114-Status: UNSURE (   6.66  )
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

On Fri, Apr 19, 2024 at 09:52:06AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a pr_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
