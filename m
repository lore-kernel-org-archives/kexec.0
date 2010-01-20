Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fed1rmmtao106.cox.net ([68.230.241.40])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NXdId-0002OX-Na
	for kexec@lists.infradead.org; Wed, 20 Jan 2010 16:21:00 +0000
Received: from fed1rmimpo03.cox.net ([70.169.32.75]) by fed1rmmtao106.cox.net
	(InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP id
	<20100120162054.RRGQ18268.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>
	for <kexec@lists.infradead.org>; Wed, 20 Jan 2010 11:20:54 -0500
Received: from toolshiner.phx1.kidfixit.com (unknown [10.1.0.2])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.phx1.kidfixit.com (Postfix) with ESMTP id A6745808C421
	for <kexec@lists.infradead.org>; Wed, 20 Jan 2010 16:00:10 +0000 (UTC)
References: <cone.1263962411.847498.22847.1000@toolshiner.phx1.kidfixit.com>
	<201001201014.56630.florian@openwrt.org>
	<cone.1264002495.970050.22847.1000@toolshiner.phx1.kidfixit.com>
Message-ID: <cone.1264003210.167206.22847.1000@toolshiner.phx1.kidfixit.com>
From: Joey Korkames <joey+lists@kidfixit.com>
Subject: Re: bzip2-compressed bzimage support?
Date: Wed, 20 Jan 2010 09:00:10 -0700
Mime-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Perhaps I spoke too soon:

xen2:~# grep -rn KEXEC /boot/debian/config-2.6.32-trunk-amd64 
378:CONFIG_KEXEC=y
380:# CONFIG_KEXEC_JUMP is not set

I figure that there should be an ELF hint indicating if a kernel is 
kexec-able so that kexec-tools can emit a specific (and useful) error 
message if given an unsuitable kernel. But this doesn't appear to be an 
unsuitable kernel based on the .config.

And just for good measure, it also appears to be a plain gzip bzImage.

xen2:~# grep -rn -E 'BZIP|GZIP|LZMA' /boot/debian/config-2.6.32-trunk-amd64 
68:CONFIG_HAVE_KERNEL_GZIP=y
69:CONFIG_HAVE_KERNEL_BZIP2=y
70:CONFIG_HAVE_KERNEL_LZMA=y
71:CONFIG_KERNEL_GZIP=y
72:# CONFIG_KERNEL_BZIP2 is not set
73:# CONFIG_KERNEL_LZMA is not set
125:CONFIG_RD_GZIP=y
126:CONFIG_RD_BZIP2=y
127:CONFIG_RD_LZMA=y
4682:CONFIG_DECOMPRESS_GZIP=y
4683:CONFIG_DECOMPRESS_BZIP2=y
4684:CONFIG_DECOMPRESS_LZMA=y

Now, if it doesn't matter how the bzImage is compressed, then what are the 
recent lzma commits to kexec-tools.git for?

Thanks for reading
Joey

Joey Korkames writes:

> Gotcha, kexec resuses the bzImage's decompression stub. Now I have another 
> reason to dislike the Debian.org kernels. I didn't know the 
> _destination_ kernel had to have the config option as well.
> 
> Thanks!
> -joey
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
