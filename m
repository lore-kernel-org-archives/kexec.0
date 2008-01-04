Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.wp.pl ([212.77.101.5])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JAlp6-0007vr-2q
	for kexec@lists.infradead.org; Fri, 04 Jan 2008 12:38:59 +0000
Received: from ip-83-238-22-2.netia.com.pl (HELO lapsg1.open-e.pl)
	(stf_xl@wp.pl@[83.238.22.2]) (envelope-sender <stf_xl@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
	for <kexec@lists.infradead.org>; 4 Jan 2008 13:38:45 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: kdump from x86_64 using i386 capture kernel
Date: Fri, 4 Jan 2008 13:46:37 +0100
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200801041346.38120.stf_xl@wp.pl>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi.

I would like to do generic capture system which could be used for x86_64 
and i386 first kernels. This system should be minimal, only capable to copy 
vmcore image over network for futher analysis. First kernel version is 2.6.23.9,
I choose 2.6.16.y for capture.

I have some problems with vmcore when origin is x86_64. With 32 bit kexec 
crash utility do not recognize it, when I use 64 bit kexec /proc/vmcore file 
has size == 0. Reading form oldmem is  fine, I can for example get old 
dmesg from it.

Now questions:
It is possible to achieve valid vmcore when first is x86_64 and capture 
is i386 ?
If no, is there some way to convert oldmem to valid vmcore in this scenario?
Or maybe is possible to use crash with copy of oldmem (I try but without any
success) ?

Regards
Stanislaw Gruszka

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
