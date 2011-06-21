Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pz0-f43.google.com ([209.85.210.43])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QZ90P-0004Xm-Uh
	for kexec@lists.infradead.org; Tue, 21 Jun 2011 22:01:10 +0000
Received: by pzk1 with SMTP id 1so207562pzk.16
	for <kexec@lists.infradead.org>; Tue, 21 Jun 2011 15:01:05 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 21 Jun 2011 15:01:05 -0700
Message-ID: <BANLkTin7FZLkjqY1-Z_7DvQRgrFe3zYtwQ@mail.gmail.com>
Subject: initramfs size & crashkernel reserved area
From: Sujit V <sujit.linux@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org

I am observing the following.

We are using linux 2.6.23 kernel
crashkernel=128M@16M

We also have few kernel modules in our code base.

The kernel modules are gzip'ed in the cpio archive which is included
in the .init.ramfs section of vmlinux

When the size of the .init.ramfs section goes beyond certain limit
then it corrupts the crash kernel reserved area.

If the .init.ramfs size is 0x33d0f6 then things work ok.

If the init.ramfs size is 0x4be430 then it corrupts the crashkernel area.

Any pointers for further debugging?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
