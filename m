Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-x232.google.com ([2a00:1450:400c:c05::232])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z3JIs-0002TD-Nh
 for kexec@lists.infradead.org; Fri, 12 Jun 2015 07:23:04 +0000
Received: by wigg3 with SMTP id g3so8191389wig.1
 for <kexec@lists.infradead.org>; Fri, 12 Jun 2015 00:22:39 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 12 Jun 2015 15:22:38 +0800
Message-ID: <CAC2xGuKoMf4s0-btj2FiCE2kTcaeREKtTmuWJtk9Bgay4x3qxw@mail.gmail.com>
Subject: kexec-tools built with musl-libc fail to load kernel
From: Yan Yin <yinyan192@gmail.com>
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
To: kexec@lists.infradead.org

Hi experts,

I'm trying to get  kexec 2.0.9 built with musl-libc to work with my
customized kernel, but failed with no luck:

the error for i586 is:
my_load:667: do
Could not find a free area of memory of 0x9000 bytes...
locate_hole failed

the error for x86_64 is:
Overlapping memory segments at 0x400000
sort_segments failed
Nothing has been loaded!

I did many tests on various combinations, and find below configs work:
* kexec.musl  can work well with Ubuntu kernel, but can't work with my kernel;
* kexec.eglibc can work well with both Ubuntu kernel and my kernel;

The issue seems to be related with both kernel/libc, I'm curious on:
1) what must be in kernel for kexec to work? it's a trimmed down
kernel for embedded devices, so I may turn off something wrongly.
(however this can't explain why kexec.eglibc works with the same
trimmed kernel)
2) what conditions must be meet in libc/compiler for kexec to work?

Thanks for your help in advance!

BTW:
1) kexec.eglibc is built manually in Ubuntu 14.04, v2.0.9;
2) kexec.musl is built using Yocto recipe, v2.0.9
(http://layers.openembedded.org/layerindex/recipe/4861/);
3) I tried both static link and dynamic link, same results.
4) Ubuntu kernel is vmlinuz-3.13.0-32-generic, uLinux kernel is bzImage--3.19

--
Regards,
Yan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
