Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from zimbra.tgsmc.com ([63.118.209.91])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OjHrh-0004dC-St
	for kexec@lists.infradead.org; Wed, 11 Aug 2010 20:25:34 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.tgsmc.com (Postfix) with ESMTP id 3840B72AC04D
	for <kexec@lists.infradead.org>; Wed, 11 Aug 2010 13:25:33 -0700 (PDT)
Received: from zimbra.tgsmc.com ([127.0.0.1])
	by localhost (zimbra.tgsmc.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xa-F9S9PpG0S for <kexec@lists.infradead.org>;
	Wed, 11 Aug 2010 13:25:33 -0700 (PDT)
Received: from [10.4.1.136] (unknown [10.4.1.251])
	by zimbra.tgsmc.com (Postfix) with ESMTPSA id EFC1F72AC04C
	for <kexec@lists.infradead.org>; Wed, 11 Aug 2010 13:25:32 -0700 (PDT)
Subject: kexec problem on CentOS 5.3
From: Josh England <josh@tgsmc.com>
Date: Wed, 11 Aug 2010 13:25:32 -0700
Message-ID: <1281558332.1953.1058.camel@ijosh1>
Mime-Version: 1.0
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

I'm running CentOS 5.3 on x86_64 platform with kernel version
2.6.18-128.el5 and having issues running kexec.  I've got the kernel
built with CONFIG_KEXEC and CONFIG_CRASH_DUMP, and I'm booting with
crashkernel=64M@16M, but anytime I try to load a kernel with kexec I get
the following:

Invalid memory segment (nil) - 0x309fff

Did I miss something somewhere?  I will provide any additional
information if needed.

-JE



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
