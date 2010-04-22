Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pw0-f49.google.com ([209.85.160.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O4sq5-0003QO-2J
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 09:36:54 +0000
Received: by pwj3 with SMTP id 3so945963pwj.36
	for <kexec@lists.infradead.org>; Thu, 22 Apr 2010 02:36:50 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Apr 2010 17:36:48 +0800
Message-ID: <w2p7d98bfeb1004220236tb8268ff1pc7108b3d848fe3f0@mail.gmail.com>
Subject: fast boot from linux to xen and vice-versa
From: min li <fly.limin@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi:
=A0=A0 recently i am doing fast boot from linux kernel to Xen
hypervisor,and=A0 vice-versa. it means when linux is running on the real
machine, i just want to switch to Xen hypervisor without going through
bootloader. both linux and dom0 of Xen using the same filesystem. we
boot Xen and the Linux  with the following command in grub:

title       Ubuntu 8.04.2, kernel 2.6.29
root        (hd0,7)
kernel      /boot/vmlinuz-2.6.29
root=3DUUID=3Df16e6c92-7903-4884-a903-95bd7456f8a4 ro quiet splash
locale=3Dzh_CN
initrd      /boot/2.6.29.img
quiet


title Xen 3.3.1 Ubuntu
root (hd0,7)
kernel /boot/xen-3.3.1.gz loglvl=3Dall guest_loglvl=3Dall
debug_stack_lines=3D80 com1=3D9600,8n1
module /boot/vmlinuz-2.6.18.8-xen ro
root=3DUUID=3Df16e6c92-7903-4884-a903-95bd7456f8a4 rhgb quiet
xencons=3DttyS0,9600
module /boot/initrd-2.6.18.8-xen.img

and i write the kexec command like :

fast boot linux script :
kexec -l /boot/vmlinuz-2.6.29
--command-line=3D"root=3DUUID=3Df16e6c92-7903-4884-a903-95bd7456f8a4 ro
quiet splash locale=3Dzh_CN" --initrd=3D"/boot/2.6.29.img"

kexec -e

fast boot xen script :
kexec -l -t multiboot-x86 --append=3D"loglvl=3Dall guest_loglvl=3Dall
debug_stack_lines=3D80 com1=3D9600,8n1"
--module=3D"/boot/vmlinuz-2.6.18.8-xen ro root=3D
UUID=3Df16e6c92-7903-4884-a903-95bd7456f8a4 rhgb quiet
xencons=3DttyS0,9600" --module=3D"/boot/initrd-2.6.18.8-xen.img"
/boot/xen-3.3.1.gz

kexec -e

the consequence is that
(1)when i was in linux, the both two scripts worked fine
(2)when i was in xen dom0, the "fast boot xen script " works fine, but
the "fast boot linux script" failed.

any suggestions to me are appreciated , thanks !

--
Min Li
School of Computer Science and Technology
Cluster and Grid Computing Lab
Services Computing Technology and System Lab
Huazhong University of Science and Technology
Wuhan, 430074, China
Tel: +86-139-8625-1431
Email: fly.limin@gmail.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
