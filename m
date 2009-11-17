Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NAEe8-0007cU-TY
	for kexec@lists.infradead.org; Tue, 17 Nov 2009 03:22:29 +0000
Date: Tue, 17 Nov 2009 14:22:23 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: Fast reboot from linux to Xen hypervisor with kexec
Message-ID: <20091117032222.GE12541@verge.net.au>
References: <200911171040002189644@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911171040002189644@gmail.com>
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
To: "fly.limin" <fly.limin@gmail.com>
Cc: kexec <kexec@lists.infradead.org>

On Tue, Nov 17, 2009 at 10:40:02AM +0800, fly.limin wrote:
> Hi:
>    recently i am researching fast boot from linux kernel to Xen hypervisor, it means when linux is running on the real machine, i just want to switch to Xen hypervisor without going through bootloader. both linux and dom0 of Xen using the same filesystem. since we boot Xen with the following command in grub:
> 
>  title Xen 3.1.0 / XenLinux 2.6.18
>       kernel /boot/xen-3.gz
>       module /boot/vmlinuz-2.6.18-xen ro root=LABEL=/ rhgb quiet
>       module /boot/initrd-2.6.18-xen.img 
> it's different from linux, but i think there are something in common.
> so is there any suggestions for me! 

Kexecing from Linux to Xen and vice-versa should work fine.

On x86 try something like this:
kexec -l -t multiboot-x86 \
	--append="$XEN_ARGS" \
	--module="/boot/vmlinuz-2.6.18-xen ro root=LABEL=/ rhgb quiet" \
	--module=/boot/initrd-2.6.18-xen.img \
	/boot/xen-3.gz
kexec -e

Or on ia64 try something like this:

kexec -l \
	--append="$XEN_ARGS -- ro root=LABEL=/ rhgb quiet" \
	--initrd=/tmp/initramfs_data.cpio \
	--vmm=/boot/xen-3.gz \
	/boot/vmlinuz-2.6.18-xen

Where $XEN_ARGS is any command line parameters that you want to
provide to the hypervisor. In the case of the example you gave
it would be empty in which case the --append line in my x86 example
could be removed.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
