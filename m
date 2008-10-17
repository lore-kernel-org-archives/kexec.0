Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.18.175])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KqrwZ-0004XT-FE
	for kexec@lists.infradead.org; Fri, 17 Oct 2008 16:12:52 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m9HGBq8A002343
	for <kexec@lists.infradead.org>; Sat, 18 Oct 2008 03:11:52 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9HGClZi289214
	for <kexec@lists.infradead.org>; Sat, 18 Oct 2008 03:12:48 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9HGClaV024152
	for <kexec@lists.infradead.org>; Sat, 18 Oct 2008 03:12:47 +1100
Message-ID: <48F8B980.7000403@in.ibm.com>
Date: Fri, 17 Oct 2008 21:42:48 +0530
From: Chandru <chandru@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
In-Reply-To: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

Maxim Uvarov wrote:
> Hello all,
>
> As you all know it is not easy to count exact value of memory ranges 
> from device tree on powerpc.
> It very depends on how dts file was written. What do you think about 
> really dynamic allocation buffers
> for this buffers? Patch is attached.
>
> -- 
> Best regards,
> Maxim Uvarov

Maxim,

The changes seem to be better in allocating memory ranges dynamically.   
From the patch, it looks like there are couple of other places in 
get_devtree_details() to make a  call to realloc_memory_ranges(). Also 
the patch removes the initialization of lmb_size and num_of_lmbs which 
are required for  the recent dynamic-reconf-memory changes to 
kexec-tools.  Else these values could also be read from 
/proc/device-tree wherever necessary .   I applied the patch on a ppc64 
machine and got the following

# ./build/sbin/kexec -p /boot/vmlinux-kdump --append="root=/dev/sda3   
elevator=deadline sysrq=1 reset_devices " --initrd=/boot/initrd-kdump
get memory ranges:2
Could not find a free area of memory of 82b2b8 bytes...
Base address: ffffffff is not page aligned

Without the patch , kexec loads the crashkernel in to memory.  Trying to 
see whats wrong...
 
Chandru

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
