Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OZPIM-0001cL-Sq
	for kexec@lists.infradead.org; Thu, 15 Jul 2010 14:20:15 +0000
Date: Thu, 15 Jul 2010 23:20:06 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Kexec Reboot Network Issue
Message-ID: <20100715142003.GB19856@verge.net.au>
References: <4C3EF80B.1040400@symplicity.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4C3EF80B.1040400@symplicity.com>
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
To: Richard Genthner <rgenthner@symplicity.com>
Cc: kexec@lists.infradead.org

On Thu, Jul 15, 2010 at 07:59:07AM -0400, Richard Genthner wrote:
> I'm currently using the following string:
> 
> kexex --type=elf-x86_64 --args-linux -l /boot/vmlinuz-2.6.18-12.el5
> --initrid=/boot/initrd-2.6.18-128.el6.img --append="`cat
> /proc/cmdline`"
> kexec -e
> 
> Some times we can get to the box from any subnet, other times we can
> only get to the box from the same subnet only. Our solution to this
> is to down the iface and then restart networking. Has anyone else
> run into this issue?

Hi Richard,

could you be more specific about which NIC you are using?
And is it at all possible to test a newer kernel version?

What I suspect is happening is that the NIC is getting into an unknown
state. And what I'm hoping is that is a problem thats already been
addressed.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
