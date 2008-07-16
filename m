Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KJA7Y-0000PY-As
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 16:44:57 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 57AE34185F
	for <kexec@lists.infradead.org>; Wed, 16 Jul 2008 18:44:50 +0200 (CEST)
Date: Wed, 16 Jul 2008 18:45:32 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: problems in kdump kernel if 'maxcpus=1' not specified?
Message-ID: <20080716184532.4ee555e2@halley.suse.de>
In-Reply-To: <20080716163404.GD711@redhat.com>
References: <487D49DC.8040209@sgi.com> <20080716151240.GB711@redhat.com>
	<20080716172601.76338aae@halley.suse.de>
	<20080716163404.GD711@redhat.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

* Vivek Goyal [2008-07-16 12:34]:
>
> On Wed, Jul 16, 2008 at 05:26:01PM +0200, Bernhard Walle wrote:
> > * Vivek Goyal [2008-07-16 11:12]:
> > > 
> > > You need to dive deeper to find out what is taking so much of time.
> > 
> > I think the main difference are the huge memory gaps usual on IA64
> > systems. makedumpfile processes each PFN sequentially when creating the
> > 1st bitmap.
> 
> By memory gaps you mean large amount of memory?

No, the whole system memory mappend (beside of boot memory) beyond
1^32. Like (from /proc/iomem):

6000100000-60003fffff : System RAM
6003000000-6033dfffff : System RAM
6033e00000-6043ffffff : System RAM
6044000000-6045b9efff : System RAM
6045b9f000-60f7ffdfff : System RAM
16000100000-160003fffff : System RAM
16003000000-16033dfffff : System RAM
...



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
