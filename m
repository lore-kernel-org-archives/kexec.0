Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f221.google.com ([209.85.217.221])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mgh9u-0005BK-UH
	for kexec@lists.infradead.org; Thu, 27 Aug 2009 15:45:11 +0000
Received: by gxk21 with SMTP id 21so1466813gxk.3
	for <kexec@lists.infradead.org>; Thu, 27 Aug 2009 08:45:04 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 27 Aug 2009 23:45:03 +0800
Message-ID: <e997b7420908270845m2f8472f8vd2eb1ebb1ce047da@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1517373716=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============1517373716==
Content-Type: multipart/alternative; boundary=0016e646182e7cece00472217362

--0016e646182e7cece00472217362
Content-Type: text/plain; charset=ISO-8859-1

There was a patch of kexec on SMP mips 64 , and I attempt to implement kexec
on SMP powerpc .

I found that ,  it was a little different with  mips when booting a kernel.
We know  that, every CPU jumped directly into kernel on

mips, but on powerpc , E500 SMP,  the 'master' CPU was in charge of 'slave'
CPUs , so 'slave' CPU  could do nothing

but to  wait for 'master'  to wake him up in Init function.


How to implement kexec on SMP powerpc?
Any suggestions would be appreciate

regards,

wilbur

--0016e646182e7cece00472217362
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>There was a patch of kexec on SMP=A0mips 64 , and I attempt to impleme=
nt kexec on SMP powerpc .</div>
<div>=A0</div>
<div>I found that , =A0it was a little different with =A0mips when booting =
a kernel. We know =A0that, every CPU jumped directly into kernel on </div>
<div>=A0</div>
<div>mips, but on powerpc , E500 SMP,=A0 the &#39;master&#39; CPU was in ch=
arge of &#39;slave&#39;=A0 CPUs , so=A0&#39;slave&#39; CPU =A0could do noth=
ing </div>
<div>=A0</div>
<div>but to=A0 wait for &#39;master&#39;=A0 to wake him up in Init function=
.</div>
<div>=A0</div>
<div>=A0</div>
<div>How to implement kexec on SMP powerpc?</div>
<div>Any suggestions would be appreciate</div>
<div>=A0</div>
<div>regards,</div>
<div>=A0</div>
<div>wilbur</div>

--0016e646182e7cece00472217362--


--===============1517373716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1517373716==--

