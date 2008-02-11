Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from edna.telenet-ops.be ([195.130.132.58])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JOXuY-0003eR-0X
	for kexec@lists.infradead.org; Mon, 11 Feb 2008 12:37:32 +0000
Date: Mon, 11 Feb 2008 13:36:58 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: why kexec insists on syncing with recent kernels?
In-Reply-To: <47AC8F34.3020705@wpkg.org>
Message-ID: <Pine.LNX.4.64.0802111335000.31167@anakin>
References: <47AB120A.1000600@wpkg.org> <20080207163752.GD11969@redhat.com>
	<47AB38E2.9050509@wpkg.org> <20080208160408.GB18782@redhat.com>
	<20080208090407.4ab240f1.randy.dunlap@oracle.com>
	<47AC8F34.3020705@wpkg.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463808512-662959786-1202733418=:31167"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Horms <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808512-662959786-1202733418=:31167
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 8 Feb 2008, Tomasz Chmielewski wrote:
> Randy Dunlap schrieb:
> 
> (...)
> 
> > > Even if you did -f, it must have shutdown the network. I think somehow
> > > in latest kernels there is some dependency on network and that's why
> > > not shutting down network in this case is helping you.
> > 
> > I'm seeing NFS mounts take forever to unmount (at shutdown/reboot).
> > (forever => 1 hour ... or never completes)
> > 
> > Is this similar to the problem that the OP is asking about?
> 
> Is it a diskless station?
> 
> Even in not, just make sure you don't shut the network down before NFS is
> actually unmounted...?

JFYI, on PS3, kexec works fine with NFS root.

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---1463808512-662959786-1202733418=:31167
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

---1463808512-662959786-1202733418=:31167--

