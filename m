Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eUB4h-0003fT-Lz
 for kexec@lists.infradead.org; Wed, 27 Dec 2017 12:44:49 +0000
Date: Wed, 27 Dec 2017 20:44:29 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171227124429.GB15255@x1>
References: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
 <20171216010142.GK12442@x1>
 <20171217214735.nuxq5zo2eknqpbpi@pd.tnic>
 <20171218134736.GA4035@x1>
 <20171218143753.k7xyq6yiyjisnonh@pd.tnic>
 <20171219015804.GC4035@x1>
 <20171219175827.oqfskuax6zzm2ljq@dwarf.suse.cz>
 <20171227074449.GA15255@x1> <20171227122523.GC13909@nazgul.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171227122523.GC13909@nazgul.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Jiri Bohac <jbohac@suse.cz>, Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, yinghai@kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 12/27/17 at 01:25pm, Borislav Petkov wrote:
> On Wed, Dec 27, 2017 at 03:44:49PM +0800, Baoquan He wrote:
> > > yes, instead of crashing the machine (because GART may be initialized in the
> > > 2nd kernel, overlapping the 1st kernel memory, which the 2nd kernel with its
> > > fake e820 map sees as unused).
> > > 
> > > I'd say this is an improvement.
> > 
> > I don't get what you said. If 'iommu=off' only specified in 1st kernel,
> > kdump kernel will think the memory which GART bar pointed as a hole.
> > This is incorrect. I don't see the improvement.
> 
> So he says, this memory is unused. Why is that incorrect?!?

'iommu=off' specified in 1st kernel, that region will be normal memory,
there could be important kernel data written into the place. While kdump
kernel will take that region as a gart aperture, trying to read data
from that region will cause error which Jiri originally tried to fix.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
