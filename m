Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KOI43-0007aP-CJ
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 20:14:27 +0000
Date: Wed, 30 Jul 2008 22:14:24 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 2/2] firmware/memmap: Move kobject initialisation before
	kobject_add()
Message-ID: <20080730221424.0d997fb0@kopernikus.site>
In-Reply-To: <1217448752-13859-3-git-send-email-bwalle@suse.de>
References: <1217448752-13859-1-git-send-email-bwalle@suse.de>
	<1217448752-13859-3-git-send-email-bwalle@suse.de>
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
To: akpm@linux-foundation.org
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

* Bernhard Walle <bwalle@suse.de> [2008-07-30 22:12]:
>
> Because kobject_init() call could be done from firmware_map_add_entry()
> which is called before kmalloc() can be used (we use the early bootmem allocator
> here), move that call to memmap_init() which is a late_initcall.

You can leave out that patch now since kobject_init() was adapted with
the other patch ... But I think it would still make sense to include
that one.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
