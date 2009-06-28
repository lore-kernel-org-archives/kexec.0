Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from web28308.mail.ukl.yahoo.com ([87.248.110.127])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MKwMG-00068S-Bn
	for kexec@lists.infradead.org; Sun, 28 Jun 2009 15:32:02 +0000
Message-ID: <163875.92539.qm@web28308.mail.ukl.yahoo.com>
Date: Sun, 28 Jun 2009 15:25:13 +0000 (GMT)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: Does kexec surpoort powerpc e500 core?
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, "wilbur.chan" <wilbur512@gmail.com>


--- El dom, 28/6/09, wilbur.chan <wilbur512@gmail.com> escribi=F3:
> However, PowerPC e500=A0 does not allow users to turn
> off the MMU, so we
> can not used physical address directly in our code.
> =

> =

> My question is : how to implement kexec in e500 ,
> which=A0 can not turn off MMU?

If you cannot turn off the mmu, you can create a 1:1 mapping instead.
You'll need to special case that processor whenever the MMU is currently tu=
rned on/off on the kexec reboot path.

Cheers,
Albert



      =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
