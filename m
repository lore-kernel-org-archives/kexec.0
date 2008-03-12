Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZQDG-0006pG-Ef
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 12:37:43 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: initramfs failing, 7MB limit? 
In-reply-to: <p06230929c3fb22e35e94@[192.168.9.5]> 
References: <p06230929c3fb22e35e94@[192.168.9.5]>
Date: Wed, 12 Mar 2008 13:36:35 +0100
Message-ID: <17393.1205325395@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Scott D. Davilla" <davilla@4pi.com>
Cc: kexec@lists.infradead.org

> This is OT but I'm seeing what seems like a 7MB limit on an initramfs 
> under 2.6.24.3.
> 
> I can boot an initramfs which also works under kexec that has a cpio 
> size of 6480384 bytes.  I have another (created the same way) that 
> has more userland tools with a size of 7395328 bytes. That fails 
> under both boot and kexec with the kernel not finding "/init" and 
> panicking. "/init"  is present and executable in the initramfs. This 
> fails on the target hardware and two other standard PC hardware with 
> 256M, 512M and 1G of RAM.
> 
> I use the kernel scripts (scripts/gen_initramfs_list.sh  and 
> usr/gen_init_cpio ) to create the cpio based initramfs but it's not 
> embedded in the kernel. It's a standalone initramfs that gets passed 
> to the bootloader/kexec.
> 
> It's my understanding that with an initramfs, one is just limited to 
> available RAM and there are no set size limits.
> 
> Anyone else see this behavior or am I doing something incredibly stupid.

We have booted with very large initramfs (greater than 100MB) on ppc64
and not had a problem.  

You're probably having problems the initramfs overwriting some other
important information.  What does the memory map look like?  Where is
the initramfs located in memory and what is after it?

Mikey


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
