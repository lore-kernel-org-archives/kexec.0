Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81227CA0FE6
	for <kexec@archiver.kernel.org>; Fri,  1 Sep 2023 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9pSyHAsi8e73WEaXmPYxsRyDUnujhdT4rH+cHfD4OMs=; b=qXXvMaaE0fJM3r
	NnTqEvYsBJ8solrjuoz39q22QAL0rp7Izcg/KYKCxYiHkPYQ2D8wNVLu160WrLElB29lSRK6nytAe
	eqZ4fW50M6S3uQz476v0rYojJSzL5Lrw5BDcGCehPzxZiwtBDa2VFRWq4HoKj/yIfngwwmCHWhP/9
	pvX6UadaBUk5rFQcjKtbIG6AT6VZ5bb226MhgS5/xakhvVmJjUQeu69Ve1xx+lZW389tQ/f9+W+7R
	d+WT6wW/6JYE9XQ3JGQNVtyZGCDcDqNZp4a9z+mLD2xH54Q2UZ7mg+lFW9SLCNo7AuhQh081eFauX
	mKYCG4udX0bzJsgczFgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbynl-00GceZ-2y;
	Fri, 01 Sep 2023 07:42:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbyni-00Gce7-2p
	for kexec@lists.infradead.org;
	Fri, 01 Sep 2023 07:42:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B847261E8E;
	Fri,  1 Sep 2023 07:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809CAC433C9;
	Fri,  1 Sep 2023 07:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693554160;
	bh=WtQeNp0aPeVBr6b/FEfeNWaiEcBIo6kUeXszKdx+2Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxLVFBnsV8DTObteFdh2YLHSE7XaKXf90NDxChp03o2eyVSZbI4xxtEeDPo5UowFL
	 Cx7UNaXFhjym9LfZDv9K7rzEH9DZ0df4WQKUxuoHLYcpnhJu0wyWG0SVO+c7FGMUn4
	 LthriBfEWoj42no6worSrJo2fI6IURni1TsZ07XQsbp5COxBh+NAc+J5mPKWba4lvz
	 PJYG0X9Ke+Vi4QAdc0YS+hjDd27bho8hJbtmdekqRROaHzKyBlLz8y1KbOldY0oBuP
	 eJ9pOBugvoCGbRx8jEIdSu4YWTvsXK4DtXgIHJGwOkdovRwCj6lsJxox9zATopu2HG
	 NQ6glyjIyYZiw==
Date: Fri, 1 Sep 2023 09:42:36 +0200
From: Simon Horman <horms@kernel.org>
To: Leah Neukirchen <leah@vuxu.org>
Cc: kexec@lists.infradead.org
Subject: Re: [kexec-tools PATCH] build: fix tarball creation
Message-ID: <20230901074236.GA140739@kernel.org>
References: <20230828095840.595-1-leah@vuxu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230828095840.595-1-leah@vuxu.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_004242_980439_726BA8B4 
X-CRM114-Status: UNSURE (   9.60  )
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

On Mon, Aug 28, 2023 at 11:58:15AM +0200, Leah Neukirchen wrote:
> The fix in 41b77edac did not work, bsdtar still complains about
> "hardlink pointing to itself".
> 
> Simplify the code instead: since the staging directory contains
> exactly the files we want, just package it as a whole.
> 
> Signed-off-by: Leah Neukirchen <leah@vuxu.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
