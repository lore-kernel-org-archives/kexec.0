Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RdW5U-0005X9-4I
 for kexec@lists.infradead.org; Thu, 22 Dec 2011 00:00:47 +0000
Subject: Re: [PATCH] makedumpfile: s390x: Auto-detect the correct
 MAX_PHYSMEM_BITSusedin vmcore being analyzed.
In-reply-to: <4EF1B019.3030201@linux.vnet.ibm.com>
Message-Id: <20111221214809tachibana@mail.jp.nec.com>
References: <4EF1B019.3030201@linux.vnet.ibm.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Wed, 21 Dec 2011 21:48:09 +0900
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
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: tachibana@mxm.nes.nec.co.jp, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Ananth Narayan <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Mahesh,

On 2011/12/21 15:38:25 +0530, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> On 12/21/2011 11:41 AM, tachibana@mxm.nes.nec.co.jp wrote:
> > Hi Mahesh,
> > 
> > Thank you for the patch.
> > I will review it.
> > However I have never dumped 1 terabyte or more data using makedumpfile.
> > Has anyone ever dumped it successfully?
> > 
> 
> I have seen makedumpfile successfully compressing vmcore generated on
> system with 1TB memory.

Thank you for your information.

Thanks.
tachibana

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
