Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-px0-f202.google.com ([209.85.216.202])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MxjHP-0006wC-Ag
	for kexec@lists.infradead.org; Tue, 13 Oct 2009 15:27:20 +0000
Received: by pxi40 with SMTP id 40so185956pxi.24
	for <kexec@lists.infradead.org>; Tue, 13 Oct 2009 08:27:13 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 13 Oct 2009 20:57:13 +0530
Message-ID: <b2ac5deb0910130827l5c02fbf9y844c458e29f77044@mail.gmail.com>
Subject: Loading kernel at a higher physical offset
From: Swapnil Pimpale <swapnil.pict@gmail.com>
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

Hi All,

I have a Intel Core 2 Duo processor.
I want to run a kernel in a higher physical offset. i.e. If I have 1
GB of memory, I want to give upper 512 MB for loading another kernel
on second core. Is this possible for x86 or x86_64 architecture?

I have read that kexec uses a mechanism which loads a crash kernel at
a reserved space in RAM. Can this mechanism be used to achieve the
above goal?

Thanking in anticipation,
Swapnil Pimpale.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
