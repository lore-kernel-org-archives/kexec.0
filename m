Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bw0-f49.google.com ([209.85.214.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QIM6F-000069-UP
	for kexec@lists.infradead.org; Fri, 06 May 2011 14:33:48 +0000
Received: by bwz1 with SMTP id 1so3354389bwz.36
	for <kexec@lists.infradead.org>; Fri, 06 May 2011 07:33:45 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 6 May 2011 22:33:45 +0800
Message-ID: <BANLkTi=Jt=Q9Q9kM4ogtpW0PN7k=WSLtTQ@mail.gmail.com>
Subject: kdump without the kexec
From: Lei Wen <adrian.wenl@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

Is there any existed solution that could make the kdump without the kexec?
For some kind of system hang, always hardware bug, or software deadlock, which
could not trigger the kernel oops, so that the first kernel cannot
load the second kernel
with kexec tool. The only way here is to directly press the reset key.

We could be assure that the ddr memory would not be corrupted by this
way of reset
(for we don't shutdown the ddr power during the reset). So my question
is that whether
we could take use of bootloader, like the u-boot, to pretend we are
loading the second kernel
after the reset behavior and then perform the kdump process?

Best regards,
Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
