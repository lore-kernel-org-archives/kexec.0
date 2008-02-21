Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JS8FJ-00058q-DD
	for kexec@lists.infradead.org; Thu, 21 Feb 2008 10:01:41 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 973A037542
	for <kexec@lists.infradead.org>; Thu, 21 Feb 2008 11:01:39 +0100 (CET)
Date: Thu, 21 Feb 2008 11:01:39 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [ANNOUNCE] kexec-tools-testing v20080221-rc
Message-ID: <20080221100139.GA3815@suse.de>
References: <20080221091628.GA15981@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080221091628.GA15981@verge.net.au>
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

* Simon Horman <horms@verge.net.au> [2008-02-21 10:16]:
> 
> commit e959e493753c740eb7554bc2191c58b079761e11
> Author: Simon Horman <horms@verge.net.au>
> 
>     Only include needed files in distribution tarball
> 
>  create mode 100644 doc/Makefile
>  create mode 100644 include/Makefile
>  create mode 100644 kexec/arch/alpha/Makefile

I think the configure script should be distributed with the tarball,
not only configure.ac. Usually, "make dist" should be used to generate
a working distribution tarball.


        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
