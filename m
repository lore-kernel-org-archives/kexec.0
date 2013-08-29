Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFBnM-0005NV-Mi
 for kexec@lists.infradead.org; Thu, 29 Aug 2013 23:38:33 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <521F5297.4070906@linux.intel.com>
Date: Thu, 29 Aug 2013 16:37:44 -0700
In-Reply-To: <521F5297.4070906@linux.intel.com> (H. Peter Anvin's message of
 "Thu, 29 Aug 2013 06:54:31 -0700")
Message-ID: <8738ps131z.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] x86, apic: Disable BSP if boot cpu is AP
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
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, vgoyal@redhat.com, akpm@linux-foundation.org, jingbai.ma@hp.com

"H. Peter Anvin" <hpa@linux.intel.com> writes:

> On 08/29/2013 02:27 AM, HATAYAMA Daisuke wrote:
>> This is the patch series to address the issue that kdump 2nd kernel
>> now fails to wake up multiple CPUs.
>
> Please explain the "now" in the above sentence.  Is this a regression?
> If so, what is its fimpact?

This is not a regression.

>  Is this something that needs to go into 3.11
> as a post-rc7 change, which means it better be hyper-critical?

No.  This is something that does not need to go into 3.11.

This situation is people who run machines of unreasonable size really
would like to use multiple cpus when generating crash dumps.  A
practical problem with that desire is that sending a (startup? init? I
forget which) IPI to a processor with the BSP flag sent triggers that
processor to load code from 0xfffffff0 instead of the vector specified
in the IPI.  At which point the processor which jumped to 0xfffffff0 and
is running BIOS code does not call into the kernel so never comes up
which is unfortunate, and worse almost always triggers a soft reset by
writing hardware registers.

Which means the practical way to avoid this sort of thing is not to send
init/startup IPIs to processors with the BSP bit set.  Which MPtables
and ACPI tables should denote as the boot processor.

In a previous attack on this problem we explored if it was possible to
clear the BSP bit and be able to use all processors but that does not
work.  I think it was actually your suggestion that we just skip the
BSP.

Anyway this long simmering issue has raised it's head again and we have
iron-clad evidence that the only thing people can do is avoid the
problem so this is a patchset to allow people who wind up in a
situtation where they are not booting on the bootstrap processor to to
avoid problems, and use as many of their other processors as possible.

Which should make people with boxes of unusual size happy.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
