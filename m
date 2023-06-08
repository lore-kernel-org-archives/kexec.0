Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17F7C7EE29
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 19:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xLusvhB65KafJGGgibT84pB18i0URZdOCb/Ic5TWlP8=; b=akjLTtO7VEHwdP
	0VRs6N6J45WrKVO4KP9868UhFJrThNv1zhKFVCmEAvl6VnrpthrfcOKVJOBoPkwdg9iPzD79C+jaM
	mixTIIZgckSNSohBCn2+/J/LyzGtVo1fosfvem4j5XVRmvlqmTU4iD7/psGyCGg4PFo73Qs1jfaoC
	Jd/zZlVxtiaxn7K8b/4Lz9tK8HpkKoxJ8DaOdslo9piaaZoLQykf6ui0TQpw4lDu8M1Eeha/rAj0a
	8ljvIrg+9UVu4U2OrVNcAcQ8xPaVE2D1ItrwX48EllbdWcF9EE7wBGdRO8BYWfR419FKbbuK8uekf
	N2BGbixftfwoUb7BEDHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7LjR-00ASe0-1c;
	Thu, 08 Jun 2023 19:55:41 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q7LjO-00ASde-0D;
	Thu, 08 Jun 2023 19:55:38 +0000
Date: Thu, 8 Jun 2023 12:55:38 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: djwong@kernel.org, sandeen@sandeen.net, song@kernel.org,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs: unify locking semantics for fs freeze / thaw
Message-ID: <ZIIyOsHlZLHqP0QB@bombadil.infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-2-mcgrof@kernel.org>
 <ZIFgmjywefaAqLGi@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZIFgmjywefaAqLGi@infradead.org>
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

On Wed, Jun 07, 2023 at 10:01:14PM -0700, Christoph Hellwig wrote:
> On Sun, May 07, 2023 at 06:17:12PM -0700, Luis Chamberlain wrote:
> > Right now freeze_super()  and thaw_super() are called with
> > different locking contexts. To expand on this is messy, so
> > just unify the requirement to require grabbing an active
> > reference and keep the superblock locked.
> > 
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Maybe I'm just getting old, but where did I suggest this?

https://lore.kernel.org/all/20210420120335.GA3604224@infradead.org/

"I don't think we need both variants, just move the locking and s_active
acquisition out of free_super.  Same for the thaw side."

> That being said, holding an active reference over any operation is a
> good thing.  As Jan said it can be done way simpler than this, though.

Great.


  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
