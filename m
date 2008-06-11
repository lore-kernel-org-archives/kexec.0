Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K6SUu-0004Xa-E3
	for kexec@lists.infradead.org; Wed, 11 Jun 2008 15:44:28 +0000
Date: Wed, 11 Jun 2008 17:45:03 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Limit E820 map and /proc/iomem for mem parameter on x86-64
Message-ID: <20080611174503.3e6b18e8@halley.suse.de>
In-Reply-To: <20080611153901.GD6450@redhat.com>
References: <20080610215325.GA20673@suse.de> <20080611153901.GD6450@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Vivek Goyal [2008-06-11 11:39]:
>
> Also I would like to have another interface (say /proc/iomem_kernel)which
> actually gets modified based on the user specified options. So effectively we
> can have both the views. BIOS view and user defined view.

Yes, of course, I just don't have time to work full-time on that, so be
a bit patient. :)



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
