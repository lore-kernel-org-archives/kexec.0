Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3cEK-0003kN-9w
 for kexec@lists.infradead.org; Thu, 27 Apr 2017 05:44:41 +0000
Date: Thu, 27 Apr 2017 13:44:09 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
Message-ID: <20170427054409.GA14079@dhcp-128-65.nay.redhat.com>
References: <1492688374-27903-1-git-send-email-xlpang@redhat.com>
 <20170426071916.GD5381@dhcp-128-65.nay.redhat.com>
 <59006DAB.8030908@redhat.com> <59007405.6070107@redhat.com>
 <20170427030607.GB10602@dhcp-128-65.nay.redhat.com>
 <590180AF.3030202@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <590180AF.3030202@redhat.com>
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
To: xlpang@redhat.com
Cc: Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, akpm@linux-foundation.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>

Hi Xunlei,

On 04/27/17 at 01:25pm, Xunlei Pang wrote:
> On 04/27/2017 at 11:06 AM, Dave Young wrote:
> > [snip]
> >>>>>  
> >>>>>  static int __init crash_save_vmcoreinfo_init(void)
> >>>>>  {
> >>>>> +	/* One page should be enough for VMCOREINFO_BYTES under all archs */
> >>>> Can we add a comment in the VMCOREINFO_BYTES header file about the one
> >>>> page assumption?
> >>>>
> >>>> Or just define the VMCOREINFO_BYTES as PAGE_SIZE instead of 4096
> >>> Yes, I considered this before, but VMCOREINFO_BYTES is also used by VMCOREINFO_NOTE_SIZE
> >>> definition which is exported to sysfs, also some platform has larger page size(64KB), so
> >>> I didn't touch this 4096 value.
> >>>
> >>> I think I should use kmalloc() to allocate both of them, then move this comment to Patch3 
> >>> kimage_crash_copy_vmcoreinfo().
> >> But on the other hand, using a separate page for them seems safer compared with
> >> using frequently-used slab, what's your opinion?
> > I feel current page based way is better.
> >
> > For 64k page the vmcore note size will increase it seems fine. Do you
> > have concern in mind?
> 
> Since tools are supposed to acquire vmcoreinfo note size from sysfs, it should be safe to do so,
> except that there is some waste in memory for larger PAGE_SIZE.

Either way is fine to me, I think it is up to your implementation, if
choose page alloc then modify the macro with PAGE_SIZE looks better.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
