Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgDxq-0000NR-1M
 for kexec@lists.infradead.org; Sat, 25 May 2013 12:52:51 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Sat, 25 May 2013 13:48:14 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7ED2A1B08023
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 13:52:20 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4PCqAaK20906190
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 12:52:10 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r4PCqJJw008655
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 06:52:20 -0600
Date: Sat, 25 May 2013 14:52:17 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130525145217.0549138a@holzheu>
In-Reply-To: <51A076FE.3060604@gmail.com>
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com>
 <20130524170626.2ac06efe@holzheu>
 <20130524152849.GF18218@redhat.com> <87mwrkatgu.fsf@xmission.com>
 <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
 <51A076FE.3060604@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Sat, 25 May 2013 16:31:58 +0800
Zhang Yanfei <zhangyanfei.yes@gmail.com> wrote:

[snip]

> For s390, if we put swap info into the elf header, This will
> change /sbin/kexec. But at this point, copy_oldmem_page is still
> doing the swap when we try to read the pages among [0 - OLDMEM_SIZE]
> and [OLDMEM_BASE - OLDMEM_BASE + OLDMEM_SIZE]. So removing the swap
> in copy_oldmem_page should be done at the same time. New kexec with
> old kernels would fail and old kexec with new kernels would fail too.
> 
> So could you please explain more about the ""backwards compatible".
> And please correct me if I am wrong.

Hello all,

I think Zhang is right and in theory we are not backwards compatible
because with the ELF header fix old kexec tools would no longer work
with new kernels.

But:

For s390 we normally do *not* create the ELF header in the old
kernel with kexec. Instead the new kernel does all the memory and CPU
detection and creates the ELF header in the new memory.

See also our current discussion with Vivek:
https://lkml.org/lkml/2013/5/24/164

The main reason why we did this for s390 was that we can have many
CPU hotplug events because of a s390 specific daemon called
"cpuplugd" (s390-tools). We wanted to avoid the kdump reloading with
kexec triggered by CPU and memory hotplug events. For s390 distributions
the kexec udev rules are disabled.

Besides of the newmem mechanism, for completeness, we also implemented
the oldmem ELF header mechansim in kexec. But this is disabled
by default.

See: "#ifdef WITH_ELF_HEADER" in kexec/arch/s390/crashdump-s390.c

Currently no distribution uses the oldmem mechanism.

Therefore, if necessary, IMHO we can switch to the ELF header memory
swap mechanism for s390 in the kernel. Of course we would then also
have to adjust the (disabled) kexec code.

Best Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
