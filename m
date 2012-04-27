Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SNcmU-0003ff-KQ
 for kexec@lists.infradead.org; Fri, 27 Apr 2012 04:27:45 +0000
Date: Fri, 27 Apr 2012 13:24:48 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile availability for x86 3.2 kernels
Message-Id: <20120427132448.d7854fd6.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <4F99AFB3.3070803@canonical.com>
References: <4F99AFB3.3070803@canonical.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: louis.bouchard@canonical.com
Cc: kexec@lists.infradead.org

Hello Louis,

On Thu, 26 Apr 2012 16:27:31 -0400
Bouchard Louis <louis.bouchard@canonical.com> wrote:

> Hello Kumagai-san,
> 
> Do you have an idea of the availability of makedumpfile for 3.2 flavor
> kernels ?
> 
> Ubuntu 12.04 Precise have just been released today and, since it is
> based on a 3.2 kernel, makedumpfile no longer works for it.

Sorry, I haven't tested makedumpfile for 3.2 kernel yet, but I think it 
will work fine. If makedumpfile doesn't work in your environmental, then
would you report it ? 

For your information, Suzuki reported that makedumpfile works for 3.2 kernel
on ppc32.

  http://lists.infradead.org/pipermail/kexec/2012-February/006022.html


Thanks
Atsushi Kumagai


>
> Kind regards,
> 
> ...Louis
> -- 
> Louis Bouchard
> Backline Support Analyst
> Canonical Ltd
> Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
