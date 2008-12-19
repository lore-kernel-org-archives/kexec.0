Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]
	helo=SG2EHSOBE006.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1LDj1m-0006SI-SM
	for kexec@lists.infradead.org; Fri, 19 Dec 2008 17:20:43 +0000
Message-ID: <494BD7DF.8080101@am.sony.com>
Date: Fri, 19 Dec 2008 09:20:31 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: kexec kernel with embedded initrd?
References: <49498F24.7040000@anduras.de>
In-Reply-To: <49498F24.7040000@anduras.de>
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
To: Sven Anders <anders@anduras.de>
Cc: kexec@lists.infradead.org

Sven Anders wrote:
> I want to boot a kernel (bzImage) with an embedded initrd (CPIO archive using
> the CONFIG_INITRAMFS_SOURCE option).
> 
> Can I simply load the kernel with kexec or do I have to extract the initrd
> first and load them using the --initrd option?
> 
> If I have to extract them first, is there a tool for this?

You should be able to just load the bzImage.  The kernel image should know
how to then use the initramfs.  I know it works for powepc64 at least.

-Geoff 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
