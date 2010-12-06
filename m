Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PPdGK-0003Of-M4
	for kexec@lists.infradead.org; Mon, 06 Dec 2010 15:46:02 +0000
Date: Mon, 6 Dec 2010 10:45:01 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump_post : busybox returns "Applet not found"'
Message-ID: <20101206154501.GF13373@hmsreliant.think-freely.org>
References: <4CF91748.5000401@hp.com>
	<20101205201938.GA2265@localhost.localdomain>
	<4CFBFB8B.2060902@bwalle.de> <4CFCC1FC.2020409@hp.com>
	<20101206132701.GB13373@hmsreliant.think-freely.org>
	<4CFCFB21.9080609@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CFCFB21.9080609@hp.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, Dec 06, 2010 at 04:02:57PM +0100, Louis Bouchard wrote:
> Hello Neil & al,
> 
> On 06/12/2010 14:27, Neil Horman wrote:
> >
> > Try modifying it to #1/bin/msh then, its possible that the script
> which busybox
> > puts together to emulate /bin/sh isn't working properly.  That would
> tell us
> > what needs fixing
> > Neil
> >
> 
> Looks like this was a "friday afternoon" kinda thing and you were right
> in pointing to the shebang not being present in my test script.
> 
> For some ghostly reason, the ! at the start of the script I'm testing
> disapeared so :
> 
> #!/bin/sh
> 
> became
> 
> # /bin/sh
> 
> I didn't have any issue with SLES11 since the #! is there.
> 
> Thanks for your quick help & sorry for the noise.
> 
> Kind regards,
> 
> ...Louis
> 
No problem, firday happens to the best of us :)
Neil

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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
