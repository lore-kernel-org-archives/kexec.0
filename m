Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f221.google.com ([209.85.217.221])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MghIt-0001pn-82
	for kexec@lists.infradead.org; Thu, 27 Aug 2009 15:54:27 +0000
Received: by gxk21 with SMTP id 21so1477740gxk.3
	for <kexec@lists.infradead.org>; Thu, 27 Aug 2009 08:54:22 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 27 Aug 2009 23:54:22 +0800
Message-ID: <e997b7420908270854v423b51f9vc7e2d012c91360f@mail.gmail.com>
Subject: Does kexec support SMP on powerpc? E500 V2
From: "wilbur.chan" <wilbur512@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

There was a patch of kexec on SMP mips 64 , and I attempt to implement
kexec on SMP powerpc .

I found that ,=A0 it was a little different with=A0 mips when booting a
kernel. We know=A0 that, every CPU jumped directly into kernel on

mips, but on powerpc , E500 SMP,=A0 the 'master' CPU was in charge of
'slave'=A0 CPUs , so 'slave' CPU=A0 could do nothing

but to=A0 wait for 'master'=A0 to wake him up in Init function.


How to implement kexec on SMP powerpc?

Any suggestions would be appreciate

regards,

wilbur

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
