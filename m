Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JS7jJ-0002cn-8X
	for kexec@lists.infradead.org; Thu, 21 Feb 2008 09:28:37 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 7F216314B4
	for <kexec@lists.infradead.org>; Thu, 21 Feb 2008 10:28:33 +0100 (CET)
Date: Thu, 21 Feb 2008 10:28:33 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Fix compilation warning
Message-ID: <20080221092832.GA22609@suse.de>
References: <20080220080755.GB5542@suse.de>
	<20080221092153.GB15981@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080221092153.GB15981@verge.net.au>
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

* Simon Horman <horms@verge.net.au> [2008-02-21 10:21]:
> On Wed, Feb 20, 2008 at 09:07:55AM +0100, Bernhard Walle wrote:
> > This patch fixes following compilation warning:
> > 
> > purgatory/purgatory.c:21: warning: passing argument 2 of 'sha256_update' makes pointer from integer without a cast
> > 
> 
> Thanks Bernhard, I have queued that up.
> Although I notice that on arm the warning turns into
> 
> purgatory/purgatory.c: In function 'verify_sha256_digest':
> purgatory/purgatory.c:21: warning: cast to pointer from integer of different size

Isn't this the case on every 32 bit system?


        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
