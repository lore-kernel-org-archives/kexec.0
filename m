Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x232.google.com ([2a00:1450:4010:c04::232])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wn0MY-0007cz-2A
 for kexec@lists.infradead.org; Wed, 21 May 2014 06:50:54 +0000
Received: by mail-lb0-f178.google.com with SMTP id w7so1211817lbi.37
 for <kexec@lists.infradead.org>; Tue, 20 May 2014 23:50:29 -0700 (PDT)
MIME-Version: 1.0
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Wed, 21 May 2014 08:50:09 +0200
Message-ID: <CAGm1_kvH+fozfoLkKYTQZgaTRAgAfJvjENoXda6W1vcdx49DMQ@mail.gmail.com>
Subject: FIT (flattened image tree) support
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
To: kexec <kexec@lists.infradead.org>

u-boot has support for FIT images
(http://elinux.org/images/f/f4/Elc2013_Fernandes.pdf). This way one
can package kernel image, devie tree blob and ramdisk image in one
file. Is anyone working on this support for kexec?

Regards,
Yegor

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
