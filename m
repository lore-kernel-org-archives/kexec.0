Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f196.google.com ([209.85.210.196])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MKnfw-0000NM-RB
	for kexec@lists.infradead.org; Sun, 28 Jun 2009 06:15:47 +0000
Received: by yxe34 with SMTP id 34so3124384yxe.28
	for <kexec@lists.infradead.org>; Sat, 27 Jun 2009 23:15:39 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 28 Jun 2009 14:15:39 +0800
Message-ID: <e997b7420906272315x2a7e8301g51c8c4fc10fa4bc0@mail.gmail.com>
Subject: Does kexec surpoort powerpc e500 core?
From: "wilbur.chan" <wilbur512@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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

As we know , kexec stores  data  for new kernel image ,  in the form
of   a page list.

And kexec uses the physical address of the another  page for a
"next-page" pointer.

However, PowerPC e500  does not allow users to turn off the MMU, so we
can not used physical address directly in our code.


My question is : how to implement kexec in e500 , which  can not turn off MMU?

kernel 2.6.21.7

Thank you

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
