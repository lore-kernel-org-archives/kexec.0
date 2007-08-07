Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 83-216-141-215.markhi700.adsl.metronet.co.uk ([83.216.141.215]
	helo=mx.hindley.org.uk)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIS1r-00083j-2j
	for kexec@lists.infradead.org; Tue, 07 Aug 2007 12:35:33 -0400
Date: Tue, 7 Aug 2007 17:35:13 +0100
Subject: Re: Kexec from xterm -> uhci_hcd. irq 4: nobody cared
Message-ID: <20070807163513.GA9302@hindley.org.uk>
References: <20070807113048.GE5065@hindley.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
From: Mark Hindley <mark@hindley.org.uk>
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
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org

On Tue, Aug 07, 2007 at 08:04:15PM +0530, Vivek Goyal wrote:
> On Tue, Aug 07, 2007 at 12:30:48PM +0100, Mark Hindley wrote:
> > Hi,
> > 
> > I have just started using kexec. If I kexec from within an xterm I get
> > the following error on reboot. kexec from a console there is no error.
> > 
> > This is from 2.6.23-rc2, but I get something similar back to 2.6.16.
> > 
> 
> How are you using kexec? Are you doing directly "kexec -e" ? You should
> be using "reboot". This will first shutdown X and other user space applications
> and then do a kexec (if kexec kernel was loaded). 

Yes, I was using directly because debian init scripts kexec -l a kernel
just before calling kexec -e in runlevel 6. There appears no way of preventing that
with the scripts as they stand, but that looks like a problem to take up
with the debian maintainer.

Thanks for the help.

Mark

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
