Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBDfb-0003jq-UN
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 18:55:12 +0000
Date: Tue, 24 Jun 2008 20:55:08 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: how to cross compile kexec for 64b x86_64 on a 32b x86
Message-ID: <20080624205508.5b5b348a@kopernikus.site>
In-Reply-To: <20080624185225.GA21408@hmsendeavour.rdu.redhat.com>
References: <df1bdeb10806241111q1b992291k35ed22894282377f@mail.gmail.com>
	<20080624185225.GA21408@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org, Srinivas Murthy <codevana@gmail.com>

* Neil Horman <nhorman@redhat.com> [2008-06-24 14:52]:
> On Tue, Jun 24, 2008 at 11:11:36AM -0700, Srinivas Murthy wrote:
> > Hi,
> > 	I need to cross-compile kexec-tools-1.101 for a x86_64 architecture
> > platform on a 32b x86.
> > 
> > 	I didn't see any instructions in the configure, etc. scripts for doing this.
> > 
> > 	Can you please let me know how to do this?
> > 
> Mostly, you can get away with adding -m32 to the top level CFLAGS in the
> makefile and running setarch i386 in the shell where you run make

It's the other way round. Not i386 on x86-64, but x86-64 on i386.

(BTW: 'setarch' does not exist on SUSE, we use 'linux32'. I don't have
an overview about other Linux distributions. Unfortunately, that seems
to be not standardised via LSB.)



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
