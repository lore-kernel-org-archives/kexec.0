Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PPb6s-00068l-Et
	for kexec@lists.infradead.org; Mon, 06 Dec 2010 13:28:07 +0000
Date: Mon, 6 Dec 2010 08:27:01 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump_post : busybox returns "Applet not found"'
Message-ID: <20101206132701.GB13373@hmsreliant.think-freely.org>
References: <4CF91748.5000401@hp.com>
	<20101205201938.GA2265@localhost.localdomain>
	<4CFBFB8B.2060902@bwalle.de> <4CFCC1FC.2020409@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CFCC1FC.2020409@hp.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Louis Bouchard <louis.bouchard@hp.com>
Cc: kexec@lists.infradead.org

On Mon, Dec 06, 2010 at 11:59:08AM +0100, Louis Bouchard wrote:
> Hello,
> 
> On 05/12/2010 21:52, Bernhard Walle wrote:
> > Am 05.12.10 21:19, schrieb Neil Horman:
> >> I'm kind of suprised this is working at all.  I don't see a #!/bin/sh or
> >> #!/bin/msh line at the top of the script.  How does the system know what
> >> interpreter to use?
> > 
> > /bin/sh is the default interpreter.
> > 
> > 
> > Regards,
> > Bernhard
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> While, as Bernhard said, /bin/sh is default so the test script does
> work, the crashdc scripts that I'm testing do have the #!/bin/sh at the
> beginning, with identical behavior.
> 
Try modifying it to #1/bin/msh then, its possible that the script which busybox
puts together to emulate /bin/sh isn't working properly.  That would tell us
what needs fixing
Neil

> Kind regards,
> 
> ..Louis
> 
> -- 
> Louis Bouchard
> Linux Support Engineer
> Team lead, EMEA Linux Competency Center,
> Linux Advocate, HP
> 
> HP Technology Services - Global Competency Center
> Hewlett-Packard Company
> 
> louis.bouchard@hp.com     / Email
> Mon-Fri 9-17<WET>,<GMT+2> / Working Hours
> Mark Fay                  / Manager
> mark.fay@hp.com           / Manager's Email
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
