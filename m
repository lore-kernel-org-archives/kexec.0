Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtLnJ-0003kj-0U
	for kexec@lists.infradead.org; Thu, 01 Oct 2009 13:34:09 +0000
Received: by ewy23 with SMTP id 23so228495ewy.2
	for <kexec@lists.infradead.org>; Thu, 01 Oct 2009 06:34:01 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 1 Oct 2009 15:34:01 +0200
Message-ID: <d1b08f940910010634m1570a1cfqef90c7742b51f61d@mail.gmail.com>
Subject: ARM misdetection
From: Andrea Adami <andrea.adami@gmail.com>
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

Hello,

Building kexec-tools_2.0.1 against glibc for armv5te I found out the
code in kexec/phys_arch.c can lead to arch misdetection.
The uname's output of my kernel is "armv5tel" and this won't match the
string "arm".

I added a patch to the OpenEmbedded buildsystem following the example
in the old kexec-tools-arm.patch (arch_compat_trampoline).

http://cgit.openembedded.org/cgit.cgi/openembedded/tree/recipes/kexec/files/fix-arm-arch-detection.patch

Other than adding some overhead for other archies, it just seems to work.

Regards

Andrea


P.S. I'm working on the static recipe against klibc. Probably I'll
come back soon for help...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
