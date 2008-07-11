Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KHKEf-0002Rt-8x
	for kexec@lists.infradead.org; Fri, 11 Jul 2008 15:08:37 +0000
Date: Fri, 11 Jul 2008 17:09:15 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 2/3] Remove redundancy between
	get_memory_ranges_proc_iomem() and get_memory_ranges_sysfs()
Message-ID: <20080711170915.727c3e36@halley.suse.de>
In-Reply-To: <20080710232834.GG11227@verge.net.au>
References: <20080707070621.GD788@verge.net.au>
	<1215441822-13820-3-git-send-email-bwalle@suse.de>
	<20080709004138.GD13710@verge.net.au>
	<20080709131208.32f90f73@halley.suse.de>
	<20080710232834.GG11227@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

* Simon Horman [2008-07-11 09:28]:
> 
> I'm using crosstool. I guess its crazy enough to show up things like this.

Ah! Maybe I should install that too, but since we have 5
architectures in our build system natively, I always use that infra
structure to test my builds ...

> These problems do indeed seem to be fixed now, I have applied all
> three patches.

Thanks!




Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
