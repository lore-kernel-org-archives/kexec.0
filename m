Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538FFC0218A
	for <kexec@archiver.kernel.org>; Fri, 31 Jan 2025 01:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pK6e7M/9AXhAmu2KZ6gdcSkSzEL/6RLnzS6QdhIGTbc=; b=XdkHYkQZw1Jkoxnv2/8CZAAytJ
	Tezwk1zCx/omZHxhkD7mLLSQ5rEvEhAwU1KXZTItDRoTcQU/i2Hk9b3S+d2H1qCsPiTd/Up10VJzJ
	nWZC4x0PQDKgLnODo1Q2P8He4Ey9UgOBIs5YALiseG02HuC6rlcZutauPm/ob6bwhCLGStjPPCi4z
	PANhE7e1eKk4fpRc5Qr4INlz/4eOBQh9vHJ8T8rDxPqQ/RGleIa4Sv2rLTK6rfCQbL4ueSlHLD6oP
	bzvBNrN/Fb2JbftA4p3fNzoINYd/HJb7yX378PaTJqW8FvOznUBY9qJzA9ENPl6TGy/WzMgTq08as
	QUJSu8rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdfiM-00000009tT6-3tCe;
	Fri, 31 Jan 2025 01:20:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdfiJ-00000009tSl-3zIH
	for kexec@lists.infradead.org;
	Fri, 31 Jan 2025 01:20:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B7CC25C434B;
	Fri, 31 Jan 2025 01:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFEEC4CED2;
	Fri, 31 Jan 2025 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738286454;
	bh=Fvd0Rm5GcLkbzuSq8JcwSYD4IylYf6UBD6deloZjROU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GfsQsztOw7VdMeDuIIFjzBoleYRXgu4Hltn2z+yKB5PGW4ymuvMPkbDXQg9X5fgrB
	 lcnH+wtkMiB+pWAfnSgcNCXQW8s4KMh+LKfk+Oj4xlpiYuBJEMCR2kwftCKvMSz971
	 PeoUB6H1J2F3i7dOsDxvnkg/2WloTP/uBZ8e+eME=
Date: Thu, 30 Jan 2025 17:20:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] procfs: Fix a locking bug in a vmcore_add_device_dump()
 error path
Message-Id: <20250130172053.74f94d9c5eb9291b64ab586f@linux-foundation.org>
In-Reply-To: <9f3dac06-1329-43d0-89c7-6888d2c96bd2@acm.org>
References: <20250129222003.1495713-1-bvanassche@acm.org>
	<20250130020209-mutt-send-email-mst@kernel.org>
	<20250130155843.05418f6dacfc094c7cc587fb@linux-foundation.org>
	<9f3dac06-1329-43d0-89c7-6888d2c96bd2@acm.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_172056_042326_261AE841 
X-CRM114-Status: GOOD (  15.56  )
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

On Thu, 30 Jan 2025 17:02:08 -0800 Bart Van Assche <bvanassche@acm.org> wrote:

> On 1/30/25 3:58 PM, Andrew Morton wrote:
> > On Thu, 30 Jan 2025 02:02:38 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> >> On Wed, Jan 29, 2025 at 02:20:03PM -0800, Bart Van Assche wrote:
> >>> Unlock vmcore_mutex when returning -EBUSY.
> >>>
> >>> Cc: David Hildenbrand <david@redhat.com>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Michael S. Tsirkin <mst@redhat.com>
> >>> Fixes: 0f3b1c40c652 ("fs/proc/vmcore: disallow vmcore modifications while the vmcore is open")
> >>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > This applies to patches which are in linux-next via your tree (I
> > think), so I'll take the above to mean "thanks, applied" ;)
> 
> Is my understanding correct that the commit fixed by this patch made it
> into Linus' tree a few days ago?
> 

Ah, OK, thanks, grabbed.

(So that's what "git pull" does.  I'll have to write that down.)

