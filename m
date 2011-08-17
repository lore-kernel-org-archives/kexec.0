Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-gx0-f177.google.com ([209.85.161.177])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QtZVR-0006Q9-Bo
	for kexec@lists.infradead.org; Wed, 17 Aug 2011 06:21:38 +0000
Received: by gxk2 with SMTP id 2so568312gxk.36
	for <kexec@lists.infradead.org>; Tue, 16 Aug 2011 23:21:34 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Aug 2011 14:21:33 +0800
Message-ID: <CALZhoSQ5dXghiq618_5D-uXnhc_8UU60xeouALARRiWDxmoBXA@mail.gmail.com>
Subject: makedumpfile cross compile for ARM?
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

Does anyone know how to cross compile makedumpfile for the arm?
I try to build out binary from qemu, but it works only under qemu env,
while I copy it to the board, it run fail and report Segamatation
fault.

So I want to have another try with cross compile, however it seems to
me that makedumpfile doesn't support this from the look of its
Makefile.
Does anyone know any patch to fix this?

Thanks,
Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
