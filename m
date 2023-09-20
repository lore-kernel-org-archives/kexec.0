Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0E7CE79D1
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 11:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dvyMCXwtd118MlL5ywuBxhik28ZLm3RZHvJ6Z2u6L94=; b=UY50pPxoertMeQ
	kkt6qwqXmnRdVMO7YTddnqCTimdGoLYsmY+gU59Bu5+ZMftXWXxLuyxLVJttQOlSz+h88/uvEdHFY
	MqNp/wgHcUeegrcddqqhXUMuadNuUJZHakkZ8oiZLRTZW/Hl48JVc548uBMuHHShXE47Gq+GRodxq
	cIQ7ArFlCjsPLDUbxjyoFnbuUlOV8GXvJ5XxdN9xcmd9FOx96PqnlaX3D7x8UvQM5s7QhGPDqvJbz
	QhKzvIa1GrL+uOTUo83U5RPXCljJl9TWl/dGJs+K4cr9updkM8Er4TylXyVa9Npwk1g2km4WOvvzg
	ks9nNWHaugdWGpqRldng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qivmM-002vrj-11;
	Wed, 20 Sep 2023 11:54:02 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qivmI-002vqX-2B
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 11:53:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4A593B81CE2;
	Wed, 20 Sep 2023 11:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A02DC433C9;
	Wed, 20 Sep 2023 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695210835;
	bh=cJdVOOK/lI8L1RqXBiHPKMeuwOZIcO45C4fhk7Z1hno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvMklHmk84WIoz+jUOS/bw4sb1tPYCaQUVRSj/J/NOUvi7x2MEPASKE6c1ZhrkBmf
	 REuoydzGMnlnGGKQKfz8Psqh9cKcpeNv/glFS+/bNS7rb57s1sVFlbzReBjJOllWVs
	 auwlGndb0byrbxFd6MgF7fnioYt+qVA7PThn+ENQpa9GXxLWgiyKnnq5Dazmwv8l2l
	 HmzbuRp3UN+kI4wZdy9Dvn0Q1dCNJAjAkPb8nEH2AVQSSHNxwjMc62fHspnYsAdi1k
	 fNIxEptJfpVg7opTSPqibWNXWCVp39SecusLbfG6N+c0vUNNYzxy/joXm85D7254bX
	 Sdlx/qdzL4D5Q==
Date: Wed, 20 Sep 2023 12:53:50 +0100
From: Simon Horman <horms@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crash_core: Remove duplicated include in
 crash_core.c
Message-ID: <20230920115350.GF224399@kernel.org>
References: <20230915055844.37935-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915055844.37935-1-yang.lee@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_045358_907329_F6BB1BAB 
X-CRM114-Status: UNSURE (   8.11  )
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

On Fri, Sep 15, 2023 at 01:58:44PM +0800, Yang Li wrote:
> ./kernel/crash_core.c: linux/kexec.h is included more than once.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

FWIIW, this seems to have been added recently, by

926f75c8a5ab ("Add linux-next specific files for 20230920")

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
