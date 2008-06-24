Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBFC7-0001kZ-LY
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 20:32:51 +0000
Date: Tue, 24 Jun 2008 16:32:48 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: how to cross compile kexec for 64b x86_64 on a 32b x86
Message-ID: <20080624203248.GA21889@hmsendeavour.rdu.redhat.com>
References: <df1bdeb10806241111q1b992291k35ed22894282377f@mail.gmail.com>
	<20080624185225.GA21408@hmsendeavour.rdu.redhat.com>
	<20080624205508.5b5b348a@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080624205508.5b5b348a@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Srinivas Murthy <codevana@gmail.com>

On Tue, Jun 24, 2008 at 08:55:08PM +0200, Bernhard Walle wrote:
> * Neil Horman <nhorman@redhat.com> [2008-06-24 14:52]:
> > On Tue, Jun 24, 2008 at 11:11:36AM -0700, Srinivas Murthy wrote:
> > > Hi,
> > > 	I need to cross-compile kexec-tools-1.101 for a x86_64 architecture
> > > platform on a 32b x86.
> > > 
> > > 	I didn't see any instructions in the configure, etc. scripts for doing this.
> > > 
> > > 	Can you please let me know how to do this?
> > > 
> > Mostly, you can get away with adding -m32 to the top level CFLAGS in the
> > makefile and running setarch i386 in the shell where you run make
> 
> It's the other way round. Not i386 on x86-64, but x86-64 on i386.
> 
ah, my bad. yes, for 64 bit on a 32 bit arch, you'll certainly need a cross-cc.

Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
