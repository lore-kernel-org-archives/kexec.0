Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IPDao-0004H0-PJ
	for kexec@lists.infradead.org; Sun, 26 Aug 2007 04:35:40 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 7A8DD122BA
	for <kexec@lists.infradead.org>; Sun, 26 Aug 2007 10:35:31 +0200 (CEST)
Date: Sun, 26 Aug 2007 10:35:30 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kexec+kdump + vmcoreinfo patch
Message-ID: <20070826083530.GA30931@suse.de>
References: <20070824144147.5e1cadc2.rdunlap@xenotime.net>
	<20070824170139.021be621.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070824170139.021be621.rdunlap@xenotime.net>
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

* Randy Dunlap <rdunlap@xenotime.net> [2007-08-25 02:01]:
> 
> d.  Documentation/kdump/kdump.txt mentions an option to produce
> ELF32 headers instead of 64-bit headers:  --elf32-core-headers.
> Where is this option used?  I.e., what program recognizes it?
> kdump.txt isn't telling me this info and I can't read it between
> the lines.

It's the kexec userspace program that is invokes to load the kdump
kernel, normally in some init script.



Thanks,
   Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
