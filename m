Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 50-200-209-228-static.hfc.comcastbusiness.net ([50.200.209.228]
 helo=mail.litepoint.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3vBa-0007mh-4q
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 01:59:07 +0000
From: Rudici Cazeao <rudici.cazeao@litepoint.com>
Subject: RE: ARM lockup during Kexec operation
Date: Fri, 28 Apr 2017 01:43:16 +0000
Message-ID: <7f67b6aa05124ca68dd71667ed67eaca@LPHQEX2013.litepoint.internal>
Content-Language: en-US
MIME-Version: 1.0
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

I am running kexec in consecutive loops on 4 different dual-core arm processors.  On 3 of these processors, usually, somewhere between the 500th and the 5000th loop, the kernel gets stuck at "Starting new kernel". On the remaining processor, kexec is run over and over without running into this issue. And this appears to be pretty consistent. Any ideas?

Also, on rare occasions, the kernel gets stuck at " Uncompressing Linux... done, booting the kernel". 

The SoC is Cortex-A9 (ARMv7-A)
The kernel version is 3.0.51-rt75



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
