Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrGiS-0007QR-08
 for kexec@lists.infradead.org; Thu, 10 Jun 2021 09:11:09 +0000
Received: by mail-io1-xd32.google.com with SMTP id q7so26084538iob.4
 for <kexec@lists.infradead.org>; Thu, 10 Jun 2021 02:11:07 -0700 (PDT)
MIME-Version: 1.0
From: manty kuma <mantykuma@gmail.com>
Date: Thu, 10 Jun 2021 18:10:55 +0900
Message-ID: <CAB6A5-DjJORLex-WGihXEGp6PUPcGea0k+bx-uC=2fL1BT94bg@mail.gmail.com>
Subject: Compiling makedumpfile (and elfutils) from source
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
To: kexec-ml <kexec@lists.infradead.org>

What version of elfutils is needed by latest `makedumpfile`?
elfutils-0.144 is mentioned in README.
I tried this one but the compilation is broken.

https://sourceware.org/elfutils/ftp/0.144/

Should I try to use the latest one instead?

Regards,
Manty

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
