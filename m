Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cr6p8-0002m6-VA
 for kexec@lists.infradead.org; Thu, 23 Mar 2017 17:47:00 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2NHdTsq120971
 for <kexec@lists.infradead.org>; Thu, 23 Mar 2017 13:46:38 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29bv4kct4y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 23 Mar 2017 13:46:38 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 23 Mar 2017 17:46:35 -0000
Date: Thu, 23 Mar 2017 18:46:31 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
In-Reply-To: <58D39429.9020200@redhat.com>
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
 <87pohbz4lo.fsf@xmission.com>
 <20170322025536.GA4424@dhcp-128-65.nay.redhat.com>
 <87pohaxam1.fsf@xmission.com>
 <20170322043004.GB4424@dhcp-128-65.nay.redhat.com>
 <20170322214819.0b64d49c@TP-holzheu> <58D39429.9020200@redhat.com>
MIME-Version: 1.0
Message-Id: <20170323184631.1cd671ba@TP-holzheu>
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
Cc: Baoquan He <bhe@redhat.com>, xpang@redhat.com, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, hbathini@linux.vnet.ibm.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org

Am Thu, 23 Mar 2017 17:23:53 +0800
schrieb Xunlei Pang <xpang@redhat.com>:

> On 03/23/2017 at 04:48 AM, Michael Holzheu wrote:
> > Am Wed, 22 Mar 2017 12:30:04 +0800
> > schrieb Dave Young <dyoung@redhat.com>:
> >
> >> On 03/21/17 at 10:18pm, Eric W. Biederman wrote:
> >>> Dave Young <dyoung@redhat.com> writes:
> >>>
> > [snip]
> >
> >>>> I think makedumpfile is using it, but I also vote to remove the
> >>>> CRASHTIME. It is better not to do this while crashing and a makedumpfile
> >>>> userspace patch is needed to drop the use of it.
> >>>>
> >>>>> As we are looking at reliability concerns removing CRASHTIME should make
> >>>>> everything in vmcoreinfo a boot time constant.  Which should simplify
> >>>>> everything considerably.
> >>>> It is a nice improvement..
> >>> We also need to take a close look at what s390 is doing with vmcoreinfo.
> >>> As apparently it is reading it in a different kind of crashdump process.
> >> Yes, need careful review from s390 and maybe ppc64 especially about
> >> patch 2/3, better to have comments from IBM about s390 dump tool and ppc
> >> fadump. Added more cc.
> > On s390 we have at least an issue with patch 1/3. For stand-alone dump
> > and also because we create the ELF header for kdump in the new
> > kernel we save the pointer to the vmcoreinfo note in the old kernel on a
> > defined memory address in our absolute zero lowcore.
> >
> > This is done in arch/s390/kernel/setup.c:
> >
> > static void __init setup_vmcoreinfo(void)
> > {
> >         mem_assign_absolute(S390_lowcore.vmcore_info, paddr_vmcoreinfo_note());
> > }
> >
> > Since with patch 1/3 paddr_vmcoreinfo_note() returns NULL at this point in
> > time we have a problem here.
> >
> > To solve this - I think - we could move the initialization to
> > arch/s390/kernel/machine_kexec.c:
> >
> > void arch_crash_save_vmcoreinfo(void)
> > {
> >         VMCOREINFO_SYMBOL(lowcore_ptr);
> >         VMCOREINFO_SYMBOL(high_memory);
> >         VMCOREINFO_LENGTH(lowcore_ptr, NR_CPUS);
> >         mem_assign_absolute(S390_lowcore.vmcore_info, paddr_vmcoreinfo_note());
> > }
> >
> > Probably related to this is my observation that patch 3/3 leads to
> > an empty VMCOREINFO note for kdump on s390. The note is there ...
> >
> > # readelf -n /var/crash/127.0.0.1-2017-03-22-21:14:39/vmcore | grep VMCORE
> >   VMCOREINFO           0x0000068e       Unknown note type: (0x00000000)
> >
> > But it contains only zeros.
> 
> Yes, this is a good catch, I will do more tests.

Hello Xunlei,

After spending some time on this, I now understood the problem:

In patch 3/3 you copy vmcoreinfo into the control page before
machine_kexec_prepare() is called. For s390 we give back all the
crashkernel memory to the hypervisor before the new crashkernel
is loaded:

/*
 * Give back memory to hypervisor before new kdump is loaded
 */
static int machine_kexec_prepare_kdump(void)
{
#ifdef CONFIG_CRASH_DUMP
        if (MACHINE_IS_VM)
                diag10_range(PFN_DOWN(crashk_res.start),
                             PFN_DOWN(crashk_res.end - crashk_res.start + 1));
        return 0;
#else
        return -EINVAL;
#endif
}

So after machine_kexec_prepare_kdump() the contents of your control page
is gone and therefore the vmcorinfo ELF note contains only zeros.

If you call kimage_crash_copy_vmcoreinfo() after
machine_kexec_prepare_kdump() the problem should be solved for s390.

Regards
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
