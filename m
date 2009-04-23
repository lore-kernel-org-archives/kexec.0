Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from n22.bullet.mail.ukl.yahoo.com ([87.248.110.139])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Lwz5T-0004vV-AB
	for kexec@lists.infradead.org; Thu, 23 Apr 2009 13:35:41 +0000
Message-ID: <422486.66643.qm@web28303.mail.ukl.yahoo.com>
Date: Thu, 23 Apr 2009 13:35:32 +0000 (GMT)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: kexec source code for ppc32
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
To: Nguyen Hong Kien <kiennh@atvn.com.vn>
Cc: kexec@lists.infradead.org


Hi,

--- El jue, 23/4/09, Nguyen Hong Kien <kiennh@atvn.com.vn> escribi=F3:
> Hi all,
> Im looking for kexec source code for ppc32. Could you tell
> me where i can get this source code?

The kernel kexec source code for ppc32 is already in Linus' tree:

 http://www.kernel.org

kexec-tools userspace has already code for ppc32 but in its current state i=
s only useful for embedded boards (and after manually tweaking the useable =
memory ranges and recompiling...).
The code should be modified to use the device tree instead, as with the ppc=
64 code (all surviving powerpc 32-bit platforms now use a device tree via a=
 device tree blob or open firmware).
If no one steps up, I may dedicate some of my spare time to that (with no g=
uarantees, no dates).

 http://git.kernel.org/?p=3Dlinux/kernel/git/horms/kexec-tools.git

> Thank so much,
> Kien

Cheers,
Albert





      =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
