Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769F7C0218A
	for <kexec@archiver.kernel.org>; Thu, 30 Jan 2025 23:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8Y/oTL16BNmppk+sK0U5ot3jgsgfKw2umITWrRCyKE=; b=s65eAC+MNv6QuDjSiHWjO65Ivx
	pY1qghiqNSGqFIDzZOocwEEKDwfRmBGgGMkhdsz7iIE6RhlSHO+Pm+Wv4Lm4yxSQTKcdE87SD+VbJ
	31rg8R6XgUMTQtCT9Fk+lTeCDIhX1p7JPvU5h7wx6x245lEuFPFexs3XAGwkBRaJ26tkYxMzTBukk
	PCpTgAvYxL9QjTPc+Q9i4eM8hAWWAF34gp6p4AUQi8DOeYhmKxb0YcCKL53Ln4oISKk7k6ePfsv5a
	bx4Mo5wi1mRQ0BzsqZ8a0Q0cZzzi3fuT6PuqSYyPmICWSr/XoItBvyScMV8X8RPhgU98uHNqd6NMN
	8l27+pwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdeQt-00000009pFM-2XHk;
	Thu, 30 Jan 2025 23:58:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdeQo-00000009pF2-0NeB
	for kexec@lists.infradead.org;
	Thu, 30 Jan 2025 23:58:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C78BA5C61BD;
	Thu, 30 Jan 2025 23:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507A5C4CED2;
	Thu, 30 Jan 2025 23:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738281524;
	bh=iuXorDdB3O+GUjfEXSy5QDHqIiREeUAmIPL2tXdcbco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yQLXWpBh5XUm8CsNbJcUX48MnmXaXe3nUwC9CYtRjLT7dX20YeiiHuLHvB3JVVX4Z
	 rr2qaSdUSBgVf6C5WqiAwEWIwLoQTsWTWArz1hkt/MQ86JRkK4cZ+d7mHHKmk3T+Fw
	 sP6y2fpro0E/o0Ae5rgIDEe6rkryj6vtIqeEcFM4=
Date: Thu, 30 Jan 2025 15:58:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] procfs: Fix a locking bug in a vmcore_add_device_dump()
 error path
Message-Id: <20250130155843.05418f6dacfc094c7cc587fb@linux-foundation.org>
In-Reply-To: <20250130020209-mutt-send-email-mst@kernel.org>
References: <20250129222003.1495713-1-bvanassche@acm.org>
	<20250130020209-mutt-send-email-mst@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_155846_177704_511CD145 
X-CRM114-Status: GOOD (  12.14  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, 30 Jan 2025 02:02:38 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 29, 2025 at 02:20:03PM -0800, Bart Van Assche wrote:
> > Unlock vmcore_mutex when returning -EBUSY.
> > 
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Fixes: 0f3b1c40c652 ("fs/proc/vmcore: disallow vmcore modifications while the vmcore is open")
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

This applies to patches which are in linux-next via your tree (I
think), so I'll take the above to mean "thanks, applied" ;)

btw, 0f3b1c40c652 doesn't have a Link: tag.  Please add to your todo list?

