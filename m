Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout4.freenet.de ([2001:748:100:40::2:6])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LbKRG-0001dC-9e
	for kexec@lists.infradead.org; Sun, 22 Feb 2009 19:56:37 +0000
Received: from [195.4.92.12] (helo=2.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID michael_reichenbach@freenet.de)
	(port 25) (Exim 4.69 #76) id 1LbKRD-00019y-44
	for kexec@lists.infradead.org; Sun, 22 Feb 2009 20:56:31 +0100
Received: from p57ac87d2.dip0.t-ipconnect.de ([87.172.135.210]:1259
	helo=[192.168.2.101])
	by 2.mx.freenet.de with esmtpsa (ID michael_reichenbach@freenet.de)
	(TLSv1:AES256-SHA:256) (port 465) (Exim 4.69 #76) id 1LbKRC-00019E-To
	for kexec@lists.infradead.org; Sun, 22 Feb 2009 20:56:31 +0100
Message-ID: <49A1ADED.1020005@freenet.de>
Date: Sun, 22 Feb 2009 20:56:29 +0100
From: Michael Reichenbach <michael_reichenbach@freenet.de>
MIME-Version: 1.0
Subject: implementation idea, booting non-linux os
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

With great interest I followed the past discussions on booting non-linux
operating systems with kexec.

There is an implementation of the linux kernel as an MS-DOS executable.
[1] I see some potential in it. If I understand this linux.exe project
correctly it's possible to start linux as an normal executable, use
linux, shut down linux and finally return to DOS.

Couldn't the linux.exe approach be used in order to start non-linux
operating systems without going thought BIOS again?

There is also a DOS-based bootloader (grub.exe) to chainload other
Master Boot Records, Volume Boot Records or even system files (such as
NTLDR) directly. [2]

If all can be put together well it should be possible to shut down linux
and to boot a non-linux operating system without going thought BIOS.

[1] http://kerneltrap.org/mailarchive/linux-kernel/2008/9/8/3224284
[2] https://gna.org/projects/grub4dos

regards,
-mr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
