Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HmdEx-000359-NW
	for kexec@lists.infradead.org; Fri, 11 May 2007 18:05:33 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 5E21512240
	for <kexec@lists.infradead.org>; Sat, 12 May 2007 00:05:18 +0200 (CEST)
Date: Sat, 12 May 2007 00:05:15 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Does kexec on IA64 work?
Message-ID: <20070511220514.GA1625@suse.de>
References: <1178917927.10349.210.camel@ustr-shaha1-linux2.na.uis.unisys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1178917927.10349.210.camel@ustr-shaha1-linux2.na.uis.unisys.com>
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

* Amul Shah <amul.shah@unisys.com> [2007-05-11 23:12]:
> I am using a redhat derived 2.6.18 linux kernel and I am experiencing a
> panic when the second kernel boots.  I can't find the exact set of
> emails that I want to tell me that kexec on IA64 isn't ready yet.

Well, it basically works ...

> Horms said this a month ago:
> https://lists.linux-foundation.org/pipermail/fastboot/2007-March/013286.html
>         My recommendation is that 2.6.21rc3 is a farily good release for
>         kexec,
>         and if you aren't worried about ia64 then 2.6.20 is probably
>         good too.
>         If you really need something against 2.6.9, then I guess you
>         will have
>         to try to pull the patches out of git, but that is going to be
>         really hard work given that 2.6.9 is quite old now.
> 
> For the curious, the panic log is below.  I did a cursory inspection of
> the kernel sources and found that the function start_secondary is called
> from head.S.  I don't know much about IA64 arch and assembly, so I
> thought I would ask first if the IA64 implementation works.

Did you try the 'maxpus=1' option for the panic kernel?


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
