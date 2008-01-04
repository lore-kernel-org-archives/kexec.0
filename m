Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JAn15-0006lA-1a
	for kexec@lists.infradead.org; Fri, 04 Jan 2008 13:55:25 +0000
Date: Fri, 4 Jan 2008 08:55:16 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump from x86_64 using i386 capture kernel
Message-ID: <20080104135516.GB8380@hmsendeavour.rdu.redhat.com>
References: <200801041346.38120.stf_xl@wp.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200801041346.38120.stf_xl@wp.pl>
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
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: kexec@lists.infradead.org

On Fri, Jan 04, 2008 at 01:46:37PM +0100, Stanislaw Gruszka wrote:
> Hi.
> 
> I would like to do generic capture system which could be used for x86_64 
> and i386 first kernels. This system should be minimal, only capable to copy 
> vmcore image over network for futher analysis. First kernel version is 2.6.23.9,
> I choose 2.6.16.y for capture.
> 
> I have some problems with vmcore when origin is x86_64. With 32 bit kexec 
> crash utility do not recognize it, when I use 64 bit kexec /proc/vmcore file 
> has size == 0. Reading form oldmem is  fine, I can for example get old 
> dmesg from it.
> 
> Now questions:
> It is possible to achieve valid vmcore when first is x86_64 and capture 
> is i386 ?
Possible I think, but not reliable.  If oldmem has regions to capture above the
4GB range, a 386 kernel won't be able to access those addresses, and as such,
you won't get a complete vmcore.

> If no, is there some way to convert oldmem to valid vmcore in this scenario?
> Or maybe is possible to use crash with copy of oldmem (I try but without any
> success) ?
> 
Doubtful, given that you may not be able to access all the needed data in the
first place.

I'm also confused about what exactly you are trying to accomplish.  Why are you
trying to use an x86 kernel to capture a x86_64 vmcore?  The available
kexec-tools package in Fedora and RHEL provides a arch independent utility to
build a minimal initrd to capute vmcores via a number of targets, including via
nfs and ssh already (mkdumprd), have you looked at the Fedora package?  It may
well provide most/all of what you are trying to do.

Regards
Neil

> Regards
> Stanislaw Gruszka
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

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
