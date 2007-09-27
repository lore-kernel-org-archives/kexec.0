Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Iatu4-0000lL-F9
	for kexec@lists.infradead.org; Thu, 27 Sep 2007 09:59:48 -0400
Received: from dsl093-132-204.sfo4.dsl.speakeasy.net (HELO [192.168.1.100])
	([66.93.132.204]) (envelope-sender <msundius@sundius.com>)
	by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <kexec@lists.infradead.org>; 27 Sep 2007 13:57:31 -0000
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <5bf40e35adf3a20c89b5976850af992a@sundius.com>
From: C Michael Sundius <msundius@sundius.com>
Subject: using bios after linux
Date: Thu, 27 Sep 2007 06:57:30 -0700
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


Hi,

  I've been working on a project where we are using linux as an =

operating environment for some
  setup work prior to booting windows. our control flow looks like this

  reset =3D> (1)linux & linux aplication=A0 =3D>
  (2)kexec =3D> (3)proprietery 16bit real code (uses bios) =3D>
  (4)ntloader =3D> (5)Windows

  I have come into this project in the middle, however I've seen enough =

to understand that its not an easy
  task to run bios calls after linux, especially int13 and power =

management stuff. The contractor that
  has been working on this prior to me, used Grub-for-DOS as glue code =

to get most machines to boot correctly.
  i.e. kexec-tools loads Grub-for-DOS (GFD) and our proprietery =

pre-windows real mode code (I'll call that the
  real mode "stuff" from here on); kexec starts GFD, which then starts =

the RM "stuff" that does some thing
  and then finally kicks off ntloader and Windows.

  It seems as though Grub-for-DOS does some magic since if we simply =

load our RM STUFF using some simple
  pergetory code to switch us into real mode the processor goes off into =

the weeds when we call BIOS
  int13; not on all machines of course, but many more than with GFD.

  I'll also say that we are working off of an older version of =

kexec-tools, say 6mo to 1year ago.

  QUESTIONS:
  1) Is GFD the defacto way of running BIOS calls after linux (chain =

booting DOS or windows) or has
  the kexec team or anyone else gotten some a simpler program to go from =

linux to realmode (and BIOS)?
  Any pointers to previous work or helpful hints would be greatly =

appreciated.


  2) It would be best if our linux application that runs before kexec =

call kexec directly*. Thus has anyone
  thought to provide a kexec-tools-lib and an api such that programs can =

acess the same high level utility of
  the kexec program just as easily as from the shell? This would be a =

great help.=A0 Are the
  "kexec-tools-powers-that-be" interested in that being integrated into =

your project? (if we contributed it or
  part of it)

  * I'll just add that we would like to pass pointers to the buffer (of =

code that is loaded) directly to
  the kexec user program instead of having to store them somewhere (in a =

file) and then let the kexec
  program retrieve them (i'm talking about our Real Mode STUFF that runs =

before windows and after linux).

  Apologies if you have discussed this before, I've looked through your =

archives quite a ways back and didn't
  see anything that exactly answered my questions. thanks for your help.

  Mike


C Michael Sundius
Solico Group LLC
232 Nevada St
San Francisco, CA 94110
msundius@sundius.com
(415)608-0121
http://www.sundius.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
