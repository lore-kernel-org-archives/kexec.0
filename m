Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16F8C7EE25
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 05:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v2d5pAev9PF1pVfw81Gw3d5wKasuNnXx/dVJq4d5IMU=; b=f+XbXTP6mbGjGy
	wdlBAqg9ijhO/R6WhRNNP2Qm+3iZgmKpzebwH+8iB7n6+OSedp6aQWeI8WSsXIBbOiMTW1fxhC5vw
	lujYsBqstRv95ncN40WCOD1Lf3+zad3DZFsjPn7WtwYcw7cFdM3lI/wGGC/OpR3c/J3v9cfxpY7yd
	J5qwOVFKsf7lwQqQiBwShk3mdRILhJsBwA4YR9ANI75wbq0LkQp72Fi0NZnC0dUH7OP1aHQ+qPH4C
	zihk04OF/KmXhY0nF1AMvlr+MVHSG2XNXbKEVMM91RvFKyxurcf3jD1JHzYwdduA/HGukXBhy+7tm
	a42qzmxWzrKoVdf3NV4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q77lu-0086fC-39;
	Thu, 08 Jun 2023 05:01:18 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q77lq-0086dy-2B;
	Thu, 08 Jun 2023 05:01:14 +0000
Date: Wed, 7 Jun 2023 22:01:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs: unify locking semantics for fs freeze / thaw
Message-ID: <ZIFgmjywefaAqLGi@infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-2-mcgrof@kernel.org>
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

On Sun, May 07, 2023 at 06:17:12PM -0700, Luis Chamberlain wrote:
> Right now freeze_super()  and thaw_super() are called with
> different locking contexts. To expand on this is messy, so
> just unify the requirement to require grabbing an active
> reference and keep the superblock locked.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Maybe I'm just getting old, but where did I suggest this?

That being said, holding an active reference over any operation is a
good thing.  As Jan said it can be done way simpler than this, though.

Also please explain the actual different locking contexts and what
semantics you unify in the commit log please.

> - * freeze_super - lock the filesystem and force it into a consistent state
> + * freeze_super - force a filesystem backed by a block device into a consistent state
>   * @sb: the super to lock

This is not actually true.  Nothing in here has anything to do
with block devices, and it is used on a at least one non-block file
system.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
