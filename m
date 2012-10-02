Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]
 helo=mho-02-ewr.mailhop.org)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TIzE3-0001At-4Z
 for kexec@lists.infradead.org; Tue, 02 Oct 2012 09:57:15 +0000
Received: from 172.44.21.95.dynamic.jazztel.es ([95.21.44.172]
 helo=mail.viric.name)
 by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.72) (envelope-from <viric@viric.name>) id 1TIzDx-0002j3-A1
 for kexec@lists.infradead.org; Tue, 02 Oct 2012 09:57:09 +0000
Date: Tue, 2 Oct 2012 11:57:03 +0200
From: =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
Subject: Trying crashkernel on 3.6.0
Message-ID: <20121002095703.GH24121@vicerveza.homeunix.net>
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

I've set up kexec for launching on panic and a cmdline mentioning
"crashkernel=3D64M nmi_watchdog=3Dpanic"; in linux 3.5, using sysrq-c I cou=
ld only
get the message of "going to the purgatory", but I was told that there coul=
d be
a bug fixed upstream.

In 3.6, I see the purgatory message, then Booting linux, and finally:
PANIC: early exception 0d rip 10:ffffffff813df8b9 error 58b cr2 0

That happens mixed with the previous 80x25 console text I had at the time I
pressed sysrq-c.

Any idea what it can be about?

Regards,
Llu=EDs.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
