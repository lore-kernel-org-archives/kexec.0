Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail3.symplicity.com ([66.151.109.77] helo=mail.symplicity.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OZN5p-00065K-9q
	for kexec@lists.infradead.org; Thu, 15 Jul 2010 11:59:09 +0000
Received: from [10.120.101.106] (unknown [10.120.101.106])
	by mail.symplicity.com (Postfix) with ESMTPSA id 1E3CE9C43C
	for <kexec@lists.infradead.org>; Thu, 15 Jul 2010 07:59:08 -0400 (EDT)
Message-ID: <4C3EF80B.1040400@symplicity.com>
Date: Thu, 15 Jul 2010 07:59:07 -0400
From: Richard Genthner <rgenthner@symplicity.com>
MIME-Version: 1.0
Subject: Kexec Reboot Network Issue
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

I'm currently using the following string:

kexex --type=elf-x86_64 --args-linux -l /boot/vmlinuz-2.6.18-12.el5 
--initrid=/boot/initrd-2.6.18-128.el6.img --append="`cat /proc/cmdline`"
kexec -e

Some times we can get to the box from any subnet, other times we can 
only get to the box from the same subnet only. Our solution to this is 
to down the iface and then restart networking. Has anyone else run into 
this issue?

-- 
Richard Genthner
Systems Administration
Symplicity
ph. 703-351-0200 x8051



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
