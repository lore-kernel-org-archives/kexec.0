Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mailserver.viasat.uk.com ([85.159.88.52])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WG6XU-0007AF-Ib
 for kexec@lists.infradead.org; Wed, 19 Feb 2014 12:46:13 +0000
From: "Caswell, Paul" <Paul.Caswell@viasat.uk.com>
Subject: Kexec question
Date: Wed, 19 Feb 2014 12:46:16 +0000
Message-ID: <55CE1574BF3FA346B57696AC64BF23611703DE95@VS-WHM-S04.Stonewood.local>
Content-Language: en-US
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello List,

I have a project requirement and I was wondering whether it would be possible to solve it using kexec.
I want to run a minimalist Linux OS on a x86 processor based system, I will supply a fixed memory range to
the kernel on boot to limit the physical RAM used.
On shutdown I want to completely overwrite all RAM used by the previously running image.
I thought I could use kexec to load a REALLY simple image whose sole purpose is to overwrite the RAM
used by the previous kernel and then shut the system down.
We have a number of 16bit real mode applications (they utilise flat real mode) that could possibly be
used to realise this feature.  They are normally loaded to 09E0:0000.
Can kexec load non-linux images? Do you think it could load one of our applications and execute it?
I see there's a kexec_test program in the 2.0.5 tarball but was wondering what that does?
Can kexec load and execute that?

Any help really appreciated.

Regards,
Paul



This email and any files transmitted with it may be confidential, legally privileged and protected in law and are intended solely for the use of the individual to whom it is addressed. Any view or opinions presented are solely those of the author and do not necessarily represent those of ViaSat.   If you have received this Email in error please contact the sender by return and confirm that its contents have been destroyed without further distribution or disclosure. Please email admin@viasat.uk.com<mailto:admin@viasat.uk.com> with any questions relating to this disclaimer.

ViaSat has Registered Offices at Sandford Lane, Wareham, Dorset BH20 4DY. The company is registered in England and Wales under no: 3007498.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
