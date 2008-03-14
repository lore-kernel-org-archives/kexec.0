Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JaDGM-0003oH-JA
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 17:00:12 +0000
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JaDGE-0000XP-OG
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 17:00:02 +0000
Received: from charybdis-ext.suse.de ([195.135.221.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 17:00:02 +0000
Received: from bwalle by charybdis-ext.suse.de with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 17:00:02 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] x86_64 purgatory Makefile typo fix.
Date: Fri, 14 Mar 2008 17:56:03 +0100
Message-ID: <frean3$i63$1@ger.gmane.org>
References: <47DA428C.3040608@in.ibm.com>
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

* Sachin P. Sant [2008-03-14 10:17]:
> 
> It turns out that entry64.S file under purgatory/arch/x86_64 was not
> compiled. The original x86_64_PURGATORY_SRCS were being overwritten
> in the Makefile.
> 
> Here is a patch to fix this issue.

*arg* Didn't see that posting and fixed it myself. ;-) Anyway, you
didn't catch the missing files since you don't use the tarball, so my
work was not completely superflous.


        Bernhard



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
