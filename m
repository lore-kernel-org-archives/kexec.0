Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDC5C35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5dOlAaBYfeE7OALwgLMcI01fFjTLtyiDX6NEh4tAv0w=; b=p4TM67cAFNbSZh
	7PfuL0J4r2iBjpGOaREwBV8mcGV/HUR7plnSUyuWlKdXZhsl3mHnTbiWDQJAXWVZcdwURElTQX/Wt
	p6nsgWDtFblr9+kMwvEOAATYVna8c9n1YyWuU3l90ncIfzDfzC9bTweFnrthrTSckNefcNsYptwJo
	ATg/f1kdGWZqX+722PMRuGS6zsg97aX8hMh0bIxojr8w3Rllk9c1biXHpcwCjo7D++beL/tuqZwhN
	ADDvzvKvn5ezD3IopCkjMZJXStH5OW8qKWPp8yqEBsr6tq6tdn/POJqNVqA7Vs91EXbaZoKuP1xXi
	5EJ9mUIVGPNh0om7I8aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGRHs-004I0R-33;
	Thu, 21 Dec 2023 22:13:04 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGRHp-004I01-3B
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 22:13:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 2F8A7B821CD;
	Thu, 21 Dec 2023 22:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513D5C433C8;
	Thu, 21 Dec 2023 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703196779;
	bh=Xj5b7BBgsG+mfoh/BRfljpTiO2RqoZvx/iiu+mRkX6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d3htO9qv8US2F2TIt+dvaIcvSjW6dQ1/lZ73niCZsQNsCCoNVU7XucpyPeawILmR/
	 jagfUKXCEquHbWHNNpOsx8Rn3vbH+FtNvKKKprgHcr7ucZjgc3t5qt9KQhv6vBquGi
	 xYL5WxxtOx/gbSIZXKWhyfTqqqttqEAuwjIG44Qw=
Date: Thu, 21 Dec 2023 14:12:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Baoquan He
 <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec_core: fix the assignment to kimage->control_page
Message-Id: <20231221141258.7113f9b2599ea6d3b6638e08@linux-foundation.org>
In-Reply-To: <20231221042308.11076-1-ytcoode@gmail.com>
References: <20231221042308.11076-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_141302_189355_60BDF48C 
X-CRM114-Status: UNSURE (   9.22  )
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

On Thu, 21 Dec 2023 12:23:08 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> image->control_page represents the starting address for allocating the next
> control page, while hole_end represents the address of the last valid byte
> of the currently allocated control page.
> 
> Therefore, after successfully allocating a control page, image->control_page
> should be updated to `hole_end + 1`, rather than hole_end.

Thanks.  Again, please include a description of the userspace-visible effects of the bug.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
