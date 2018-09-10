Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fzGow-0003o1-R8
 for kexec@lists.infradead.org; Mon, 10 Sep 2018 07:41:20 +0000
Date: Mon, 10 Sep 2018 15:40:42 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: A small problem about useless initramfs of kdump should be removed
Message-ID: <20180910074042.GA6687@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, dyoung@redhat.com, bhe@redhat.com, piliu@redhat.com
Cc: caoj.fnst@cn.fujitsu.com

Hi all,

In my machine, there are 3 useful versions of kernel,
4.17.9-200.fc28.x86_64
4.17.14-202.fc28.x86_64
4.18.5-200.fc28.x86_64
But there are some useless initramfs not removed:
cfan@localhost ~> ls /boot/initramfs* -Alh
-rw-rw-r--. 1 root root 49M Jan 13  2016 /boot/initramfs-0-rescue-07370110c3b34387b6128d7c9873a109.img
-rw-------  1 root root 24M Aug 20 16:17 /boot/initramfs-4.17.14-202.fc28.x86_64+debug.img
-rw-------  1 root root 16M Sep 10 12:32 /boot/initramfs-4.17.14-202.fc28.x86_64+debugkdump.img
-rw-------  1 root root 24M Aug 20 16:18 /boot/initramfs-4.17.14-202.fc28.x86_64.img
-rw-------  1 root root 16M Aug 27 15:43 /boot/initramfs-4.17.14-202.fc28.x86_64kdump.img
-rw-------  1 root root 16M Jul 20 11:15 /boot/initramfs-4.17.6-200.fc28.x86_64+debugkdump.img
-rw-------  1 root root 16M Jul 19 16:48 /boot/initramfs-4.17.6-200.fc28.x86_64kdump.img
-rw-------  1 root root 24M Jul 30 10:24 /boot/initramfs-4.17.9-200.fc28.x86_64+debug.img
-rw-------  1 root root 16M Jul 31 09:17 /boot/initramfs-4.17.9-200.fc28.x86_64+debugkdump.img
-rw-------  1 root root 24M Jul 30 10:25 /boot/initramfs-4.17.9-200.fc28.x86_64.img
-rw-------  1 root root 16M Jul 30 10:33 /boot/initramfs-4.17.9-200.fc28.x86_64kdump.img
-rw-------  1 root root 24M Sep 10 14:23 /boot/initramfs-4.18.5-200.fc28.x86_64+debug.img
-rw-------  1 root root 16M Sep 10 15:12 /boot/initramfs-4.18.5-200.fc28.x86_64+debugkdump.img
-rw-------  1 root root 24M Sep 10 14:22 /boot/initramfs-4.18.5-200.fc28.x86_64.img
-rw-------  1 root root 16M Sep 10 14:31 /boot/initramfs-4.18.5-200.fc28.x86_64kdump.img

The old initramfs of 4.17.6 has been removed after # dnf update, but the
kdump initramfs not.
initramfs-4.17.6-200.fc28.x86_64+debugkdump.img and
initramfs-4.17.6-200.fc28.x86_64kdump.img are useless, every time
updating kernel, I need remove them by hand. So whether it's OK if
kexec-tools can clean them.
My verions of kexec-tools is kexec-tools-2.0.17-3.fc28.x86_64

Thanks,
Chao Fan



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
