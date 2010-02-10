Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NfFTk-0003YE-8k
	for kexec@lists.infradead.org; Wed, 10 Feb 2010 16:31:57 +0000
Received: by ewy20 with SMTP id 20so203094ewy.20
	for <kexec@lists.infradead.org>; Wed, 10 Feb 2010 08:31:49 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 10 Feb 2010 17:31:47 +0100
Message-ID: <b08bcbf51002100831k3c1e35d7t8b0d80a1bf89fa07@mail.gmail.com>
Subject: kdump not writing any vmcore
From: Gallus <gall.cwpl@gmail.com>
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

Hello

What can be any reasons why kdump isn't writing vmcore file in
/var/crash/[date] directory? I have a box on which Kexec is property
configured: /etc/init.d/kdump status shows: "Kdump is operational".
There is no message like: "disabling kdump" in dmesg. Instead, there
are messages: "kdump: kexec: loaded kdump kernel" and "kdump: started
up".

After the random system-wide error occurs, kdump reacts correctly. New
kernel is started, and there are messages like: "Memory for crash
kernel (0x0 to 0x0) notwithin permissible range" (this is correct,
secondary kernel starts with different kernel command line, without
the crashkernel option, because it doesn't load any third kernel, as
we know) and "disabling kdump". But, there is no message: "kdump:
saved a vmcore to /var/crash/*" and no vmcore is saved.

When I tested exactly the same box with manually triggered system
crash (echo c >/proc/sysrq....), everything was the same except that
the "kdump: saved a vmcore to /var/crash/*" was emitted and the vmcore
was saved.

Regards,
Gallus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
