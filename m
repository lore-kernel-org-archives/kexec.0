Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NXWeY-0008Vc-P0
	for kexec@lists.infradead.org; Wed, 20 Jan 2010 09:15:10 +0000
Received: by ewy23 with SMTP id 23so4205476ewy.4
	for <kexec@lists.infradead.org>; Wed, 20 Jan 2010 01:15:04 -0800 (PST)
From: Florian Fainelli <florian@openwrt.org>
Subject: Re: bzip2-compressed bzimage support?
Date: Wed, 20 Jan 2010 10:14:56 +0100
References: <cone.1263962411.847498.22847.1000@toolshiner.phx1.kidfixit.com>
In-Reply-To: <cone.1263962411.847498.22847.1000@toolshiner.phx1.kidfixit.com>
MIME-Version: 1.0
Message-Id: <201001201014.56630.florian@openwrt.org>
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
To: kexec@lists.infradead.org
Cc: Joey Korkames <joey@kidfixit.com>

Hi Joey,

On Wednesday 20 January 2010 05:40:11 Joey Korkames wrote:
> Does kexec-tools support bzip2-compressed bzImages? I'm trying the latest
> git master against this kernel....
> 
> http://packages.debian.org/sid/amd64/linux-image-2.6.32-trunk-amd64/downloa
> d
> 
> ...but am having no success. I'm assuming that it must be because the
> kernel-section is bzip2 compressed because gzip/lzma seems to be explicitly
> supported in the master branch's commits.

a bzImage, whether it is compressed using bzip2, lzma, whatever remains a 
bzImage and as such can be used without knowing the compression used.

> 
> xen2:~# kexec --load --type=bzImage
>  --initrd=/boot/debian/initrd.img-2.6.32-trunk-amd64
>  --command-line="root=/dev/mapper/mirror_dsksAB-OS_disk console=tty0"
>  /boot/debian/vmlinuz-2.6.32-trunk-amd64 kexec_load failed: Function not
>  implemented

The "Function not implemented" error appears when the kernel you are running 
this command does not support the kexec system call, recompile with support 
for it and you should be fine.

> entry       = 0x7fff5640 flags = 0
> nr_segments = 4
> segment[0].buf   = 0x1f77a30
> segment[0].bufsz = 3874
> segment[0].mem   = 0x3000
> segment[0].memsz = 4000
> segment[1].buf   = 0x7f28267dc810
> segment[1].bufsz = 239800
> segment[1].mem   = 0x1000000
> segment[1].memsz = 23a000
> segment[2].buf   = 0x7f2825f93010
> segment[2].bufsz = 8456ab
> segment[2].mem   = 0x7f7ae000
> segment[2].memsz = 846000
> segment[3].buf   = 0x1f6f910
> segment[3].bufsz = 80e0
> segment[3].mem   = 0x7fff5000
> segment[3].memsz = a000
> 
> please CC me in to any replies, I am not subscribed to the list.
> 
> Thanks for reading
> -joey
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

-- 
Regards, Florian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
