Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IL1uC-0007fH-9K
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 15:18:17 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id BADFA128E5
	for <kexec@lists.infradead.org>; Tue, 14 Aug 2007 21:18:10 +0200 (CEST)
Date: Tue, 14 Aug 2007 21:18:13 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Kdump for ARM (vmcore generation problem)
Message-ID: <20070814191812.GA31273@suse.de>
References: <46C1AA1A.6050907@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46C1AA1A.6050907@samsung.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

* Indraneel <indraneel.m@samsung.com> [2007-08-14 15:11]:
> I'm trying to make Kdump work for ARM. Till now i've managed to get the 
> /dev/oldmem interface working for taking dumps. Now i want to get the 
> /proc/vmcore interface working.
> I'm unclear how to generate the elfcore headers required by routines in 
> vmcore.c.

The core headers are generated in kexec-tools (userspace).


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
