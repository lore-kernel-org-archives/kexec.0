Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhevQ-0003vM-5M
 for kexec@lists.infradead.org; Wed, 29 May 2013 11:52:17 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 29 May 2013 12:49:44 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 42B622190063
 for <kexec@lists.infradead.org>; Wed, 29 May 2013 12:54:51 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4TBpa3952953328
 for <kexec@lists.infradead.org>; Wed, 29 May 2013 11:51:36 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r4TBpkVA023956
 for <kexec@lists.infradead.org>; Wed, 29 May 2013 05:51:46 -0600
Date: Wed, 29 May 2013 13:51:44 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130529135144.7f95c4c0@holzheu>
In-Reply-To: <20130528135500.GC7088@redhat.com>
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com>
 <20130524170626.2ac06efe@holzheu>
 <20130524152849.GF18218@redhat.com> <87mwrkatgu.fsf@xmission.com>
 <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
 <51A076FE.3060604@gmail.com> <20130525145217.0549138a@holzheu>
 <20130528135500.GC7088@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Tue, 28 May 2013 09:55:01 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Sat, May 25, 2013 at 02:52:17PM +0200, Michael Holzheu wrote:

[snip]

> > Besides of the newmem mechanism, for completeness, we also
> > implemented the oldmem ELF header mechansim in kexec. But this is
> > disabled by default.
> > 
> > See: "#ifdef WITH_ELF_HEADER" in kexec/arch/s390/crashdump-s390.c
> > 
> > Currently no distribution uses the oldmem mechanism.
> 
> Hi Michael,
> 
> Mechanism to read from newmem is not there yet (your patches are still
> being reviewed) and you mentioned that no distribution is building
> kexec-tools with WITH_ELF_HEADER on s390. So how things are currently
> working for kdump on s390?

Hello Vivek,

On s390, if we do not get the ELF header from the 1st kernel with
"elfcorehdr=", we build the ELF header in the 2nd kernel. This is
currently the default because WITH_ELF_HEADER is not defined for
kexec tools.

>>> START QUOTE

[PATCH v3 1/3] kdump: Introduce ELF header in new memory feature

Currently for s390 we create the ELF core header in the 2nd kernel with
a small trick. We relocate the addresses in the ELF header in a way
that for the /proc/vmcore code it seems to be in the 1st kernel (old)
memory and the read_from_oldmem() returns the correct data. This allows
the /proc/vmcore code to use the ELF header in the 2nd kernel.

>>> END QUOTE

For our current zfcpdump project (see "[PATCH 3/3]s390/kdump: Use
vmcore for zfcpdump") we could no longer use this trick. Therefore we
sent you the patches to get a clean interface for ELF header creation
in the 2nd kernel.

> > 
> > Therefore, if necessary, IMHO we can switch to the ELF header memory
> > swap mechanism for s390 in the kernel. Of course we would then also
> > have to adjust the (disabled) kexec code.
> 
> So are you saying that s390 is ready to switch to mechanism of
> creating ELF headers in first kernel by kexec-tools and new kernel
> does not have to preare ELF headers?

No, I meant that currently nobody is using the kexec tools ELF header
creation in the 1st kernel on s390. We create the ELF header in the
2nd kernel (mainly because of our cpuplugd issue).

Therefore, I think, we can safely change the ELF header creation in 2nd
kernel to use your p_offset swap trick *and* we remove the swap code in
the copy_oldmem_page() implementation (same kernel).

Best Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
