Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SAFZv-0006mM-HV
 for kexec@lists.infradead.org; Wed, 21 Mar 2012 07:03:29 +0000
Date: Wed, 21 Mar 2012 15:43:28 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: Fwd: Re: makedumpfile security key enhancement using SIAL
Message-Id: <20120321154328.4bbcff7d.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <4F6870DD.6060102@linux.vnet.ibm.com>
References: <4F6870DD.6060102@linux.vnet.ibm.com>
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
To: aravinda@linux.vnet.ibm.com
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, lucchouina@yahoo.com, anderson@redhat.com

Hello Aravinda,

I have two questions, could you answer me ?

First, what problems do you have about the current format of makedumpfile.conf ?
Second, what benefits do you expect from using SIAL ? I can't imagine 
specific benefits with using SIAL now.

By the way, could you add kexec-ML to CC field from next time ?

  kexec mailing list:
    kexec@lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/kexec


Thanks
Atsushi Kumagai


On Tue, 20 Mar 2012 17:28:21 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> Hi Luc,
> 
> We are looking for utilising SIAL as a language construct for the 
> makedumpfile kernel data filtering from vmcore feature. The details of 
> which are in the mail forward.
> 
> The proposed enhancement will require libsial.a and as SIAL is not 
> currently built/shipped, we are looking for possibilities on how 
> libsial.a can be made available to makedumpfile. Please let us know your 
> opinion on the same.
> 
> Regards,
> Aravinda
> 
> 
> -------- Original Message --------
> Subject: Re: makedumpfile security key enhancement using SIAL
> Date: Tue, 13 Mar 2012 10:27:43 -0400 (EDT)
> From: Dave Anderson <anderson@redhat.com>
> To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> CC: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>,         Masaki 
> Tachibana <tachibana@mxm.nes.nec.co.jp>,        Ananth N 
> Mavinakayanahalli <ananth@in.ibm.com>,        Mahesh J Salgaonkar 
> <mahesh@linux.vnet.ibm.com>
> 
> 
> 
> ----- Original Message -----
> > Hi Dave,
> >
> > Last year, we worked on the makedumpfile security key filtering where we
> > added support to filter out kernel data from vmcore. This year, we are
> > working on enhancing the framework to provide more flexibility for the
> > customers to specify rules to traverse and filter out kernel data - for
> > which we are planning to use SIAL.
> >
> > We are looking into using SIAL as language construct to specify
> > rules/commands to erase data in the image file. The makedumpfile would
> > interpret the rules provided in SIAL macro using SIAL library (which
> > could be dynamically loaded) and erase out suitable data in the vmcore.
> > We are planning to reuse SIAL as it provides a C language like
> > construct, which is flexible and powerful enough to specify rules to
> > erase data in vmcore.
> >
> > As SIAL is not built and shipped along with crash, we are looking for
> > possibilities on how SIAL can be leveraged by makedumpfile and would
> > like to know your opinion.
> 
> Sorry but I cannot give you any help with SIAL.  Luc Chouinard is the
> maintainer of the SIAL extension module adaptation for the crash utility,
> and he can answer your questions w/respect to adapting it for makedumpfile.
> And ultimately, that's a question for the makedumpfile maintainers.
> 
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
