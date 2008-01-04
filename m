Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.wp.pl ([212.77.101.5])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JAnun-0002EP-GL
	for kexec@lists.infradead.org; Fri, 04 Jan 2008 14:53:00 +0000
From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: kdump from x86_64 using i386 capture kernel
Date: Fri, 4 Jan 2008 16:00:26 +0100
References: <200801041346.38120.stf_xl@wp.pl>
	<20080104135516.GB8380@hmsendeavour.rdu.redhat.com>
In-Reply-To: <20080104135516.GB8380@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200801041600.26866.stf_xl@wp.pl>
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
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org

On Friday 04 January 2008 14:55, Neil Horman wrote:
> > It is possible to achieve valid vmcore when first is x86_64 and capture 
> > is i386 ?
> Possible I think, but not reliable.  If oldmem has regions to capture above the
> 4GB range, a 386 kernel won't be able to access those addresses, and as such,
> you won't get a complete vmcore.
Uffff, I missed this fact. 

> I'm also confused about what exactly you are trying to accomplish.  Why are you
> trying to use an x86 kernel to capture a x86_64 vmcore?  The available
System load from flash and there is limited space. I tried to do one capture
kernel, but see this was bad idea. I will scarify another 2MB and make separate
image for x86_64. 

> kexec-tools package in Fedora and RHEL provides a arch independent utility to
> build a minimal initrd to capute vmcores via a number of targets, including via
> nfs and ssh already (mkdumprd), have you looked at the Fedora package?  It may
> well provide most/all of what you are trying to do.
I will see, thanks.

Stanislaw Gruszka

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
