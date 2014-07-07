Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from p01c11o142.mxlogic.net ([208.65.144.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4Hij-0005Ci-8C
 for kexec@lists.infradead.org; Mon, 07 Jul 2014 22:49:13 +0000
From: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
Subject: RE: Kexec and Mips64 XLP processor
Date: Mon, 7 Jul 2014 22:48:41 +0000
Message-ID: <F9C551623D2CBB4C9488801D14F864C68AB297D8@ex-mb3.corp.adtran.com>
References: <F9C551623D2CBB4C9488801D14F864C68AB22495@ex-mb3.corp.adtran.com>
In-Reply-To: <F9C551623D2CBB4C9488801D14F864C68AB22495@ex-mb3.corp.adtran.com>
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
To: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>, "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>

Guess my answer is no.

Okay, next question:  Does anyone have in process adding DTB support to
MIPS/64?  I'm working on it now, but I don't know that I'm the best
person for the Job.  I'm following the work that was done by Simon and
Matthew Leach to try to make the correct changes to hook up the DTB for
mips.  I'm VERY willing to accept guidance on this one :).

Thanks,
Andy

> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of ANDY KENNEDY
> Sent: Wednesday, June 25, 2014 4:51 PM
> To: 'kexec@lists.infradead.org'
> Subject: Kexec and Mips64 XLP processor
> 
> Anyone have any experience with kernel switching an XLP mips64 n32
> processor?
> 
> With a quick (like 5 minutes quick) test, this fails with our current
> configuration of Linux 2.6.32.9 and kexec 2.0.4.
> 
> If you see anything here that immediately puts up your hackles, please
> let me know.
> 
> Also, if you have any advice (other than bumping the kexec version,
> which is my next attempt), please let me know!
> 
> Thanks,
> Andy
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
