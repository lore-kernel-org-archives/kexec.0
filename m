Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzpMh-0003lO-5A
 for kexec@lists.infradead.org; Thu, 18 Jul 2013 14:39:32 +0000
Date: Thu, 18 Jul 2013 10:38:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v7 0/5] kdump: Allow ELF header creation in new kernel
Message-ID: <20130718143834.GC785@redhat.com>
References: <OF6010D9F0.5A45F2CF-ONC1257BAB.002B1F3E-C1257BAB.002B2812@de.ibm.com>
 <20130717180049.3b9c6ec8@holzheu>
 <20130717214207.GB27633@redhat.com>
 <20130718124004.098b85f4@holzheu> <20130718132757.GA785@redhat.com>
 <20130718163121.0b7fdcba@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130718163121.0b7fdcba@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jul 18, 2013 at 04:31:21PM +0200, Michael Holzheu wrote:

[..]
> > Hi Michael,
> > 
> > Once this patch series gets merged for 3.12, can we first do some cleanup
> > of s390 code before we do further development there. Basically there is
> > no reason that s390 kdump should be any different than x86. So all the
> > logic of OLD base can go away. 
> 
> Hello Vivek,
> 
> You mean that we first integrate the agreed "ELF header in new memory"
> patch series, then do the cleanup, and after that we discuss the further
> development (storage keys)?

Yes. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
