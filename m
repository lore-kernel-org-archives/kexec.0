Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqnBY-0007hb-JB
 for kexec@lists.infradead.org; Wed, 22 Mar 2017 20:48:51 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MKdA7B065772
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 16:48:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29btm534s6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 16:48:27 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 20:48:25 -0000
Date: Wed, 22 Mar 2017 21:48:19 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
In-Reply-To: <20170322043004.GB4424@dhcp-128-65.nay.redhat.com>
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
 <87pohbz4lo.fsf@xmission.com>
 <20170322025536.GA4424@dhcp-128-65.nay.redhat.com>
 <87pohaxam1.fsf@xmission.com>
 <20170322043004.GB4424@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <20170322214819.0b64d49c@TP-holzheu>
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
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, hbathini@linux.vnet.ibm.com, akpm@linux-foundation.org, kexec@lists.infradead.org

Am Wed, 22 Mar 2017 12:30:04 +0800
schrieb Dave Young <dyoung@redhat.com>:

> On 03/21/17 at 10:18pm, Eric W. Biederman wrote:
> > Dave Young <dyoung@redhat.com> writes:
> > 

[snip]

> > > I think makedumpfile is using it, but I also vote to remove the
> > > CRASHTIME. It is better not to do this while crashing and a makedumpfile
> > > userspace patch is needed to drop the use of it.
> > >
> > >> 
> > >> As we are looking at reliability concerns removing CRASHTIME should make
> > >> everything in vmcoreinfo a boot time constant.  Which should simplify
> > >> everything considerably.
> > >
> > > It is a nice improvement..
> > 
> > We also need to take a close look at what s390 is doing with vmcoreinfo.
> > As apparently it is reading it in a different kind of crashdump process.
> 
> Yes, need careful review from s390 and maybe ppc64 especially about
> patch 2/3, better to have comments from IBM about s390 dump tool and ppc
> fadump. Added more cc.

On s390 we have at least an issue with patch 1/3. For stand-alone dump
and also because we create the ELF header for kdump in the new
kernel we save the pointer to the vmcoreinfo note in the old kernel on a
defined memory address in our absolute zero lowcore.

This is done in arch/s390/kernel/setup.c:

static void __init setup_vmcoreinfo(void)
{
        mem_assign_absolute(S390_lowcore.vmcore_info, paddr_vmcoreinfo_note());
}

Since with patch 1/3 paddr_vmcoreinfo_note() returns NULL at this point in
time we have a problem here.

To solve this - I think - we could move the initialization to
arch/s390/kernel/machine_kexec.c:

void arch_crash_save_vmcoreinfo(void)
{
        VMCOREINFO_SYMBOL(lowcore_ptr);
        VMCOREINFO_SYMBOL(high_memory);
        VMCOREINFO_LENGTH(lowcore_ptr, NR_CPUS);
        mem_assign_absolute(S390_lowcore.vmcore_info, paddr_vmcoreinfo_note());
}

Probably related to this is my observation that patch 3/3 leads to
an empty VMCOREINFO note for kdump on s390. The note is there ...

# readelf -n /var/crash/127.0.0.1-2017-03-22-21:14:39/vmcore | grep VMCORE
  VMCOREINFO           0x0000068e       Unknown note type: (0x00000000)

But it contains only zeros.

Unfortunately I have not yet understood the reason for this.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
