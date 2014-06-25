Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from p02c11o144.mxlogic.net ([208.65.144.77])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wzv6L-0005wr-CS
 for kexec@lists.infradead.org; Wed, 25 Jun 2014 21:51:33 +0000
From: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
Subject: Kexec and Mips64 XLP processor
Date: Wed, 25 Jun 2014 21:51:02 +0000
Message-ID: <F9C551623D2CBB4C9488801D14F864C68AB22495@ex-mb3.corp.adtran.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>

Anyone have any experience with kernel switching an XLP mips64 n32
processor?

With a quick (like 5 minutes quick) test, this fails with our current
configuration of Linux 2.6.32.9 and kexec 2.0.4.

If you see anything here that immediately puts up your hackles, please
let me know.

Also, if you have any advice (other than bumping the kexec version,
which is my next attempt), please let me know!

Thanks,
Andy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
