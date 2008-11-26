Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5G2r-0002c7-Fv
	for kexec@lists.infradead.org; Wed, 26 Nov 2008 08:46:49 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 39C0241769
	for <kexec@lists.infradead.org>; Wed, 26 Nov 2008 09:46:46 +0100 (CET)
Date: Wed, 26 Nov 2008 09:46:45 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Don't use /sys/firmware/memmap for Xen
Message-ID: <20081126094645.14dd2fb7@hale.suse.de>
In-Reply-To: <1227617358-20560-1-git-send-email-bwalle@suse.de>
References: <1227617358-20560-1-git-send-email-bwalle@suse.de>
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

* Bernhard Walle [2008-11-25 13:49]:
>
> On Xen, we have to use /proc/iomem to retrieve the memory area for the kexec'd
> kernel, not /sys/firmware/memmap. Dom0 kernel gets a E820 map that contains
> only one region:
> 
>     0000000000000000-0000000018e5e000 (System RAM)

I just noticed that this has a compile warning. A fixed patch follows.


    Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
