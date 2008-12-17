Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from metropolitan.anduras.de ([80.237.200.159])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LD65F-0004xM-QG
	for kexec@lists.infradead.org; Wed, 17 Dec 2008 23:45:42 +0000
Received: from popper.anduras.local (p5491CEC0.dip.t-dialin.net
	[84.145.206.192]) (Authenticated sender: anduras@anduras.priv)
	by metropolitan.anduras.de (Postfix) with ESMTP id 5CC4A1E5500
	for <kexec@lists.infradead.org>; Thu, 18 Dec 2008 00:45:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by popper.anduras.local (Postfix) with ESMTP id DB42E1B401E
	for <kexec@lists.infradead.org>; Thu, 18 Dec 2008 00:45:40 +0100 (CET)
Received: from popper.anduras.local ([127.0.0.1])
	by localhost (popper.anduras.local [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 23683-02 for <kexec@lists.infradead.org>;
	Thu, 18 Dec 2008 00:45:40 +0100 (CET)
Received: from [10.10.23.170] (suburban.anduras.local [10.10.20.242])
	by popper.anduras.local (Postfix) with ESMTP id 970F81B4001
	for <kexec@lists.infradead.org>; Thu, 18 Dec 2008 00:45:40 +0100 (CET)
Message-ID: <49498F24.7040000@anduras.de>
Date: Thu, 18 Dec 2008 00:45:40 +0100
From: Sven Anders <anders@anduras.de>
MIME-Version: 1.0
Subject: kexec kernel with embedded initrd?
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello!

Sorry to bother you, just a short question, because I didn't find anything
in the documentation or mailing list and I want to know if it should work
before I try to find the error.

I want to boot a kernel (bzImage) with an embedded initrd (CPIO archive usi=
ng
the CONFIG_INITRAMFS_SOURCE option).

Can I simply load the kernel with kexec or do I have to extract the initrd
first and load them using the --initrd option?

If I have to extract them first, is there a tool for this?

Regards
 Sven

Mit freundlichen Gr=FC=DFen
 Sven Anders

-- =

 Sven Anders <anders@anduras.de>                 () Ascii Ribbon Campaign
                                                 /\ Support plain text e-ma=
il
 ANDURAS service solutions AG
 Innstra=DFe 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 50-=
55

Rechtsform: Aktiengesellschaft - Sitz: Passau - Amtsgericht Passau HRB 6032
Mitglieder des Vorstands: Sven Anders, Marcus Junker
Vorsitzender des Aufsichtsrats: Mark Peters


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
