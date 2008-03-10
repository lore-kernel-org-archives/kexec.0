Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx.4pi.com ([24.172.19.59])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JYlJd-0008AZ-GC
	for kexec@lists.infradead.org; Mon, 10 Mar 2008 16:57:33 +0000
Received: from [192.168.9.5] (rbl.4pi.com [24.172.19.62])
	by mx.4pi.com (Postfix) with ESMTP id 138AA3A3635F
	for <kexec@lists.infradead.org>; Mon, 10 Mar 2008 12:57:31 -0400 (EDT)
Mime-Version: 1.0
Message-Id: <p06230929c3fb22e35e94@[192.168.9.5]>
Date: Mon, 10 Mar 2008 12:56:38 -0500
From: "Scott D. Davilla" <davilla@4pi.com>
Subject: initramfs failing, 7MB limit?
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
To: kexec@lists.infradead.org

This is OT but I'm seeing what seems like a 7MB limit on an initramfs 
under 2.6.24.3.

I can boot an initramfs which also works under kexec that has a cpio 
size of 6480384 bytes.  I have another (created the same way) that 
has more userland tools with a size of 7395328 bytes. That fails 
under both boot and kexec with the kernel not finding "/init" and 
panicking. "/init"  is present and executable in the initramfs. This 
fails on the target hardware and two other standard PC hardware with 
256M, 512M and 1G of RAM.

I use the kernel scripts (scripts/gen_initramfs_list.sh  and 
usr/gen_init_cpio ) to create the cpio based initramfs but it's not 
embedded in the kernel. It's a standalone initramfs that gets passed 
to the bootloader/kexec.

It's my understanding that with an initramfs, one is just limited to 
available RAM and there are no set size limits.

Anyone else see this behavior or am I doing something incredibly stupid.

Thanks
Scott

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
