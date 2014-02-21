Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WGlKn-0002th-Hy
 for kexec@lists.infradead.org; Fri, 21 Feb 2014 08:19:50 +0000
Date: Fri, 21 Feb 2014 16:18:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: How could we get rid of saved_max_pfn for calgary iommu?
Message-ID: <20140221081806.GB1635@dhcp-16-105.nay.redhat.com>
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
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, discuss@x86-64.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, WANG Chao <chaowang@redhat.com>

On 02/19/14 at 05:04pm, Jon Mason wrote:
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

From code the size is from 64K to 8M, saved_max_pfn is needed to get
this. Could it be a fixed size for TCE table? If this can be a fixed
value, E.g 8M,  saved_max_pfn will be not needed any more though a
little memory may be wasted if total ram is smaller than 4G.

Baoquan
Thanks
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
