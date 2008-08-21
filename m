Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KWGyB-0001uf-Nu
	for kexec@lists.infradead.org; Thu, 21 Aug 2008 20:41:24 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 08B7045E0E
	for <kexec@lists.infradead.org>; Thu, 21 Aug 2008 22:41:21 +0200 (CEST)
Date: Thu, 21 Aug 2008 22:41:19 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Memory needed for a kdump kernel has been bloated
Message-ID: <20080821224119.4d93da1c@kopernikus.site>
In-Reply-To: <48ADD177.6040201@sgi.com>
References: <48ADD177.6040201@sgi.com>
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

* Jay Lan <jlan@sgi.com> [2008-08-21 13:35]:
>
> 2) the kdump kernel tried to add disk /dev/sdb when it is not even
>    in /etc/fstab. I think only the system disk and the disk where
>    we want to save the vmcore to should be needed.

But what has that to do with the kernel? What do you mean with "add
disk"? Mount? Load driver? That's up to initrd and/or system
configuration ...



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

"Make everything as simple as possible, but not simpler."
        -- Albert Einstein

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
