Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RsYsY-0006B9-2h
 for kexec@lists.infradead.org; Wed, 01 Feb 2012 12:01:34 +0000
Received: by dakp5 with SMTP id p5so958819dak.36
 for <kexec@lists.infradead.org>; Wed, 01 Feb 2012 04:01:31 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 1 Feb 2012 13:01:31 +0100
Message-ID: <CAA=oPahsrH7T=im0FZZvt-fzPPUcSVfJAW7ch108oALxJGJN0A@mail.gmail.com>
Subject: Kexec hangs when loading a SMP kernel
From: Christian Frost <cf@cfrost.dk>
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

Hi all,

I have a problem when loading a SMP kernel using kexec. When i try to
load a similar kernel without SMP and ACPI enabled in the kernel
config, the kernel is loaded correctly. However, when enabled it hangs
after printing "Starting new kernel".

Do you have any suggestions? Please let me know if you need more information.

Regards,
Christian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
