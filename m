Return-path: <kexec-bounces@lists.infradead.org>
Received: from rgminet01.oracle.com ([148.87.113.118])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Ihske-0002Et-H5
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 21:10:56 +0100
Date: Tue, 16 Oct 2007 13:06:57 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: kexec: Cannot determine the file type of arch/x86/boot/bzImage
Message-Id: <20071016130657.8cc17011.randy.dunlap@oracle.com>
In-Reply-To: <47151631.9000307@m3y3r.de>
References: <47151631.9000307@m3y3r.de>
Mime-Version: 1.0
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
Errors-To: kexec-bounces@lists.infradead.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 16 Oct 2007 21:51:13 +0200 Thomas Meyer wrote:

[adding kexec mailing list]


> Hi.
> 
> Look at this:
> 
> $ file arch/x86/boot/bzImage (tree 821f3eff7cdb9d6c7076effabd46c96c322daed1)
> arch/x86/boot/bzImage: Linux kernel x86 boot executable zImage, version
> 2.6.23 (thomas@hotzenplotz) #39, RO-rootFS, root_dev 0x803, swap_dev
> 0x1, Prompt for Videomode
> 
> $ file /boot/bzImage-2.6.23
> /boot/bzImage-2.6.23: Linux kernel x86 boot executable RO-rootFS,
> root_dev 0x803, swap_dev 0x1, Normal VGA
> 
> and this:
> 
> # kexec -l arch/x86/boot/bzImage
> Cannot determine the file type of arch/x86/boot/bzImage
> 
> How to solve this error?
> 
> mfg
> thomas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


---
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
