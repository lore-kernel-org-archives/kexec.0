Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KJ8sc-0003FN-2b
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 15:25:22 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 99C5045B0D
	for <kexec@lists.infradead.org>; Wed, 16 Jul 2008 17:25:19 +0200 (CEST)
Date: Wed, 16 Jul 2008 17:26:01 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: problems in kdump kernel if 'maxcpus=1' not specified?
Message-ID: <20080716172601.76338aae@halley.suse.de>
In-Reply-To: <20080716151240.GB711@redhat.com>
References: <487D49DC.8040209@sgi.com>
	<20080716151240.GB711@redhat.com>
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

* Vivek Goyal [2008-07-16 11:12]:
> 
> You need to dive deeper to find out what is taking so much of time.

I think the main difference are the huge memory gaps usual on IA64
systems. makedumpfile processes each PFN sequentially when creating the
1st bitmap.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
