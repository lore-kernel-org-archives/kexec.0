Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mu-out-0910.google.com ([209.85.134.188])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LV68O-0004k9-AA
	for kexec@lists.infradead.org; Thu, 05 Feb 2009 15:27:22 +0000
Received: by mu-out-0910.google.com with SMTP id w9so231360mue.2
	for <kexec@lists.infradead.org>; Thu, 05 Feb 2009 07:27:18 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 5 Feb 2009 16:27:18 +0100
Message-ID: <d53687720902050727q2b40c3ccn7b793b1d30575acf@mail.gmail.com>
Subject: kexec keeps crashing the kernel with low memory
From: Laszlo Benedek <laszlo.benedek@gmail.com>
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

Hi,

I am trying to use kexec and kdump together and everything seems (!)
to work fine if I give kexec a lot of memory (crashkernel=100MB@16MB).
If I lower the size of the preallocated memory then the original
kernel keeps crashing during booting with random errors right after
the bootup script started kexec. The oops are probably caused by some
kind of memory corruption. This made me thinking. How should I choose
the size of the reserved memory and how can I be sure that it is
'stable' and nothing corrupted the kernel memory ?

Thanks in advance.

Best regards,
Laszlo Benedek
p.s.: Can I search in archives of this mailing list? I failed to find
it but I hope it exists somewhere.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
