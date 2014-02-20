Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WGJVN-0007vE-OV
 for kexec@lists.infradead.org; Thu, 20 Feb 2014 02:36:55 +0000
Date: Wed, 19 Feb 2014 21:36:22 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: How could we get rid of saved_max_pfn for calgary iommu?
Message-ID: <20140220023622.GD2970@redhat.com>
References: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
 <CAPoiz9yuLg4exX58bh5=XumgAmYNq-9kPjc+f1wa8kMU3-dBbg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPoiz9yuLg4exX58bh5=XumgAmYNq-9kPjc+f1wa8kMU3-dBbg@mail.gmail.com>
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
To: Jon Mason <jdmason@kudzu.us>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, discuss@x86-64.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, WANG Chao <chaowang@redhat.com>

On Wed, Feb 19, 2014 at 05:04:22PM -0700, Jon Mason wrote:
> On Tue, Feb 18, 2014 at 11:18 PM, WANG Chao <chaowang@redhat.com> wrote:
> > Hi, All
> >
> > arch/x86/kernel/pci-calgary.c is the only user of saved_max_pfn today:
> >
> > int __init detect_calgary(void)
> > {
> >         [..]
> >         specified_table_size = determine_tce_table_size((is_kdump_kernel() ?
> >                                         saved_max_pfn : max_pfn) * PAGE_SIZE);
> >         [..]
> > }
> 
> IIUC, the purpose of this code is to reuse the TCE table from the
> previous kernel.  Thus, it needs to be of the same size as the
> pre-kdump kernel.  It is using the max_pfn to determine the TCE table
> size in the non-kdump case.  If there is another way to determine the
> size it used before, then I am fine making the change to use that way.

How about passing old tce table size on command line to second kernel.
Given the fact that it is specific to calgary only, we can it very
specific. Say calgary_iommu_old_tce_table_sz=<size>.

But we will then need to know the size of TCE table in first kernel. Is
this information exported to user space somewhere?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
