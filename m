Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PPZnG-0006MJ-Hm
	for kexec@lists.infradead.org; Mon, 06 Dec 2010 12:03:47 +0000
Date: Mon, 6 Dec 2010 07:03:37 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump_post : busybox returns "Applet not found"
Message-ID: <20101206120337.GA13373@hmsreliant.think-freely.org>
References: <4CF91748.5000401@hp.com>
	<20101205201938.GA2265@localhost.localdomain>
	<4CFBFB8B.2060902@bwalle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CFBFB8B.2060902@bwalle.de>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: kexec@lists.infradead.org

On Sun, Dec 05, 2010 at 09:52:27PM +0100, Bernhard Walle wrote:
> Am 05.12.10 21:19, schrieb Neil Horman:
> > I'm kind of suprised this is working at all.  I don't see a #!/bin/sh or
> > #!/bin/msh line at the top of the script.  How does the system know what
> > interpreter to use?
> 
> /bin/sh is the default interpreter.
> 
You might want to try adding that, is what I'm saying.  Busybox uses msh by
default, and may not have the code to handle that same inferrence.  Make the
interpreter an explicit #!/bin/sh or #!/bin/msh
Neil
> 
> Regards,
> Bernhard
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
