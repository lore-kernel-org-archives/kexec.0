Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fed1rmmtao105.cox.net ([68.230.241.41])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NXSgC-0001yO-Vt
	for kexec@lists.infradead.org; Wed, 20 Jan 2010 05:00:37 +0000
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao105.cox.net
	(InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP id
	<20100120050028.JGNK12229.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>
	for <kexec@lists.infradead.org>; Wed, 20 Jan 2010 00:00:28 -0500
Received: from toolshiner.phx1.kidfixit.com (unknown [10.1.0.2])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.phx1.kidfixit.com (Postfix) with ESMTP id 9F8CE808C420
	for <kexec@lists.infradead.org>; Wed, 20 Jan 2010 04:40:12 +0000 (UTC)
Message-ID: <cone.1263962411.847498.22847.1000@toolshiner.phx1.kidfixit.com>
From: Joey Korkames <joey@kidfixit.com>
Subject: bzip2-compressed bzimage support?
Date: Tue, 19 Jan 2010 21:40:11 -0700
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

Does kexec-tools support bzip2-compressed bzImages? I'm trying the latest 
git master against this kernel....

http://packages.debian.org/sid/amd64/linux-image-2.6.32-trunk-amd64/download

...but am having no success. I'm assuming that it must be because the 
kernel-section is bzip2 compressed because gzip/lzma seems to be explicitly 
supported in the master branch's commits.

xen2:~# kexec --load --type=bzImage --initrd=/boot/debian/initrd.img-2.6.32-trunk-amd64 --command-line="root=/dev/mapper/mirror_dsksAB-OS_disk console=tty0" /boot/debian/vmlinuz-2.6.32-trunk-amd64
kexec_load failed: Function not implemented
entry       = 0x7fff5640 flags = 0
nr_segments = 4
segment[0].buf   = 0x1f77a30
segment[0].bufsz = 3874
segment[0].mem   = 0x3000
segment[0].memsz = 4000
segment[1].buf   = 0x7f28267dc810
segment[1].bufsz = 239800
segment[1].mem   = 0x1000000
segment[1].memsz = 23a000
segment[2].buf   = 0x7f2825f93010
segment[2].bufsz = 8456ab
segment[2].mem   = 0x7f7ae000
segment[2].memsz = 846000
segment[3].buf   = 0x1f6f910
segment[3].bufsz = 80e0
segment[3].mem   = 0x7fff5000
segment[3].memsz = a000

please CC me in to any replies, I am not subscribed to the list.

Thanks for reading
-joey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
