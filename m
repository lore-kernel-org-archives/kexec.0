Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WGib9-0006Ml-7x
 for kexec@lists.infradead.org; Fri, 21 Feb 2014 05:24:32 +0000
Received: by mail-ob0-f180.google.com with SMTP id vb8so3111596obc.11
 for <kexec@lists.infradead.org>; Thu, 20 Feb 2014 21:24:00 -0800 (PST)
MIME-Version: 1.0
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Fri, 21 Feb 2014 09:23:45 +0400
Message-ID: <CACaajQtDmtz4MoAk8FWwue2reUgb2nRGdNgh6+fFOwXV2=n5jg@mail.gmail.com>
Subject: kexec with unpacked initrd to memory
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello all. I'm try to use kexec in unusual space - i want to kexec new
kernel with new initrd already unpacked at some place in memory.
For example  i have pxe booted server, that need about 5 minutes to
boot and configured via chef.
I want to minimize this time creating ramdisk , setup new system on it
in chroot and after all ok kexec new kernel.
Does this possible ? Or i must cpio | gzip this dir to initrd file and
kexec with it?
I want to avoid unneeded steps with cpio because kernel must do
uncompress after kexec ...
Sorry for bad english.

-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
jabber: vase@selfip.ru

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
