Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx.4pi.com ([24.172.19.59])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZQiR-0005TF-3C
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 13:09:56 +0000
Mime-Version: 1.0
Message-Id: <p06230940c3fd8f3b64c4@[192.168.9.5]>
In-Reply-To: <17393.1205325395@neuling.org>
References: <p06230929c3fb22e35e94@[192.168.9.5]>
	<17393.1205325395@neuling.org>
Date: Wed, 12 Mar 2008 09:08:51 -0500
From: "Scott D. Davilla" <davilla@4pi.com>
Subject: Re: initramfs failing, 7MB limit?
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
To: Michael Neuling <mikey@neuling.org>
Cc: kexec@lists.infradead.org

>  > This is OT but I'm seeing what seems like a 7MB limit on an initramfs
>>  under 2.6.24.3.
>>
>>  I can boot an initramfs which also works under kexec that has a cpio
>>  size of 6480384 bytes.  I have another (created the same way) that
>>  has more userland tools with a size of 7395328 bytes. That fails
>>  under both boot and kexec with the kernel not finding "/init" and
>>  panicking. "/init"  is present and executable in the initramfs. This
>>  fails on the target hardware and two other standard PC hardware with
>>  256M, 512M and 1G of RAM.
>>
>>  I use the kernel scripts (scripts/gen_initramfs_list.sh  and
>>  usr/gen_init_cpio ) to create the cpio based initramfs but it's not
>>  embedded in the kernel. It's a standalone initramfs that gets passed
>>  to the bootloader/kexec.
>>
>>  It's my understanding that with an initramfs, one is just limited to
>>  available RAM and there are no set size limits.
>>
>>  Anyone else see this behavior or am I doing something incredibly stupid.
>
>We have booted with very large initramfs (greater than 100MB) on ppc64
>and not had a problem. 
>
>You're probably having problems the initramfs overwriting some other
>important information.  What does the memory map look like?  Where is
>the initramfs located in memory and what is after it?
>

I'm not sure that's the case, this occurs independent of using a) 
kexec, b) syslinux or c) atv-bootloader on three different x86 
hardware platforms with one having three difference memory 
configurations.

I'm pretty sure kexec will place the initrd in a proper location as 
does syslinux. Since I'm writing atv-bootloader, the initrd is placed 
just under the bootloader which is loaded at 0xB000000 (darwin mach 
kernel load location). So the failure does not seem to depend on 
initial load location of the initramfs. I could track down the actual 
load locations but don't think this problem is dependent on that.

In addition, on two of the platforms, I has serial support so I can 
run a serial console to capture the kernel output of the panic'd 
load. The kernel finds the initramfs (initrd), loads it and seem 
happy with it. It then panics later when trying to run "/init". I am 
building both initrds with kernel scripts and the only difference is 
the addition of wget and support glibc libs and these are not 
referenced in the init code. So the cpio built processes should be 
ok. Unless cpio itself is barfing.

It's either something about the cpio construction or the kernel's 
unpacking. I did read something about one cannot have ext3 support as 
a compiled module or bad things happen, but that seems really goofy, 
why should the kernel be using ext3 for an initramfs, ext3 seems 
really stupid for a ram disk, what's to save?

Scott

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
