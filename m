Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T45qa-0006Tw-3q
 for kexec@lists.infradead.org; Wed, 22 Aug 2012 07:59:28 +0000
Received: from 24.104.77.188.dynamic.jazztel.es ([188.77.104.24]
 helo=mail.viric.name)
 by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.72) (envelope-from <viric@viric.name>) id 1T45qY-000K9N-Sb
 for kexec@lists.infradead.org; Wed, 22 Aug 2012 07:59:27 +0000
Date: Wed, 22 Aug 2012 09:59:22 +0200
From: =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
Subject: Trying to kexec on panic, 3.5.1, tools 2.0.3
Message-ID: <20120822075922.GF1960@vicerveza.homeunix.net>
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

Hello all,

I'm trying to get kexec working in case of panic. I write because it does n=
ot
work for me...

Nevertheless, if I change '-p' for '-l' in my kexec command line, and then I
issue a "kexec -e", the new kernel loads perfectly fine.

But if I use '-p' (for the panic situation), and I do sysrq-c to cause a Cr=
ash,
I see the Oops in my netconsole, and then the screen of the computer (vga
virtual console) shows over the previous kernel log, at the top:

early console in decompress_kernel
I'm in purgatory

And that's the last I see, computer hanged.

I'm using kexectools 2.0.3, on linux 3.5.1. Any idea of what can be happeni=
ng?
I'm confused because "-l/-e" looks like working, but "-p" not, in the trivi=
al
sysrq-c case.

Regards,
Llu=EDs.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
