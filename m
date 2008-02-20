Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JRjl1-0000LW-TV
	for kexec@lists.infradead.org; Wed, 20 Feb 2008 07:52:48 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A65FB37445
	for <kexec@lists.infradead.org>; Wed, 20 Feb 2008 08:52:45 +0100 (CET)
Date: Wed, 20 Feb 2008 08:52:45 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [ANNOUNCE] kexec-tools-testing v20071017-rc
Message-ID: <20080220075245.GA5542@suse.de>
References: <20080219081130.GA3919@verge.net.au>
	<20080219160512.GA15701@suse.de>
	<20080220015114.GC18944@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080220015114.GC18944@verge.net.au>
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

* Simon Horman <horms@verge.net.au> [2008-02-20 02:51]:
> > 
> > Can you fix this? :)
> 
> Appologies. This has now been fixed.

Thanks! I also get following error when trying to build

$ make
make: *** No rule to make target `/home/horms/local/opt/crosstool/i686/gcc-3.4.5-glibc-2.3.6/i686-unknown-linux-gnu/bin/../lib/gcc/i686-unknown-linux-gnu/3.4.5/../../../../i686-unknown-linux-gnu/sys-include/stdio.h', needed by `kexec/kexec.o'.  Stop.

"make clean" before works.



        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
