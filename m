Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50080CDB47E
	for <kexec@archiver.kernel.org>; Wed, 18 Oct 2023 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EA1FTskUTmYsMRnKebp8ARJD8T8lusRMjKh6GPI2X5A=; b=qbe64tWNNdEhMt
	lUq7e1IGnQv37BOjfkR5xlldt+fXb3xcfEdrAJtEJuHNqT8nZg4zaFMn8Gqw4nLmFzUWl83K9RklZ
	LfMTPwdJZvLdAxaqRDGIg/WC9N9vkR0/4vc82txr+MZX38KhiTYHc2+Eo9aEKW25DmG9gu0WleNEr
	IXENf0bmhAe8lHYwX9kOTfhIHmjUcujdLxpqep6qG4VmEY7sThLP3eVM6k39qwl3uvuF6801xIVf/
	hI998WuwyY4IhKiwRyD1/n9naZ0glFlz5/huE+lwdbx5ETNd+/lSZKXaORhLL/9ybEB0kVdu5szUM
	z2KD/n9dz8XkbrbPYVVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt3Ag-00EJ7B-0H;
	Wed, 18 Oct 2023 09:48:58 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt3Ad-00EJ6o-0q
	for kexec@lists.infradead.org;
	Wed, 18 Oct 2023 09:48:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 6C153B8221B
	for <kexec@lists.infradead.org>; Wed, 18 Oct 2023 09:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B8BC433C7
	for <kexec@lists.infradead.org>; Wed, 18 Oct 2023 09:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697622532;
	bh=jfJdkJi8tUpNVOdTrDFyfpAbGPHM0hqCObdyWAlnYIw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=jT4gLnXHo5Dc8qJFCSaDojeZvVgcKCTqUJxDG0jfg9VsQaz+nheftAiyL5hCyiM8u
	 A3MzjKdFoAqWr4gUat9nekBVBP4qpKd0tz/CDsYxG7XHlytPJYnJ+PYodoWUD48AgT
	 tyW10QLzOSuDyHW2fvSbyawl3TwSwrsMdHpUxfqYSfwcuuUGLxN1b/fpaDl86ghbRI
	 7zE9WvYq/GxXd/d733N070wYLtpuWhk7LlMprtaiSEc6qx1aH1I/iYQ1RSyf1ItQ//
	 fd+yLoDKgHqTuFL1yyzLEvcZilc1YJuAoHcJbllnVRzs7gjvNhzJyg6BtfNvmbzlJs
	 2aAbWBYrGenXg==
Date: Wed, 18 Oct 2023 11:48:50 +0200
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools] workflow: update to Ubuntu 22.04
Message-ID: <20231018094850.GC1940501@kernel.org>
References: <20231011085933.212360-1-horms@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011085933.212360-1-horms@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_024855_446003_0BA8D448 
X-CRM114-Status: UNSURE (   7.69  )
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

On Wed, Oct 11, 2023 at 10:59:33AM +0200, Simon Horman wrote:
> Bump workflow to use latest LTS release.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

FTR, this has been applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
