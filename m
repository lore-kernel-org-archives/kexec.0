Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9Yci-0007rz-O6
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 09:43:46 +0000
Received: from 210.106.77.188.dynamic.jazztel.es ([188.77.106.210]
 helo=mail.viric.name)
 by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.72) (envelope-from <viric@viric.name>) id 1T9Yce-000F38-Jb
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 09:43:40 +0000
Date: Thu, 6 Sep 2012 11:43:36 +0200
From: =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
Subject: Getting the kexec on panic
Message-ID: <20120906094336.GJ1943@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Disposition: inline
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

Hello,

while I can load immediately a kernel using kexec, when I set it for panic =
and
crash with sysrq-c, the computer hangs.

I'm using the nvidia X driver; can it be that it stops the panic handling f=
rom
working? I don't understand why it would work with normal kexec though, if =
it
were the case.

Regards,
Llu=EDs.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
