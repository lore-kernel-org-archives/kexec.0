Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkYqT-0005RR-C5
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 15:45:02 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FFhF1f014085
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 11:44:39 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fmmjyn8p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 11:44:39 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 21:14:35 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 16290E0040
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:13:50 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FFiXS936634674
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:14:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FFiUFT021992
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:14:32 +0530
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 15 Sep 2016 11:44:23 -0400
In-Reply-To: <1472683086.2607.17.camel@linux.vnet.ibm.com>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
 <1472683086.2607.17.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Message-Id: <1473954263.2526.88.camel@linux.vnet.ibm.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-security-module <linux-security-module@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>

Hi Andrew,

On Wed, 2016-08-31 at 18:38 -0400, Mimi Zohar wrote:
> On Wed, 2016-08-31 at 13:50 -0700, Andrew Morton wrote:
> > On Tue, 30 Aug 2016 18:40:02 -0400 Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > 
> > > The TPM PCRs are only reset on a hard reboot.  In order to validate a
> > > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> > > of the running kernel must be saved and then restored on the subsequent
> > > boot, possibly of a different architecture.
> > > 
> > > The existing securityfs binary_runtime_measurements file conveniently
> > > provides a serialized format of the IMA measurement list. This patch
> > > set serializes the measurement list in this format and restores it.
> > > 
> > > Up to now, the binary_runtime_measurements was defined as architecture
> > > native format.  The assumption being that userspace could and would
> > > handle any architecture conversions.  With the ability of carrying the
> > > measurement list across kexec, possibly from one architecture to a
> > > different one, the per boot architecture information is lost and with it
> > > the ability of recalculating the template digest hash.  To resolve this
> > > problem, without breaking the existing ABI, this patch set introduces
> > > the boot command line option "ima_canonical_fmt", which is arbitrarily
> > > defined as little endian.
> > > 
> > > The need for this boot command line option will be limited to the
> > > existing version 1 format of the binary_runtime_measurements.
> > > Subsequent formats will be defined as canonical format (eg. TPM 2.0
> > > support for larger digests).
> > > 
> > > This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> > > hand-over for the next kernel" patch set. 
> > > 
> > > These patches can also be found in the next-kexec-restore branch of:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > 
> > I'll merge these into -mm to get some linux-next exposure.  I don't
> > know what your upstream merge plans will be?
> 
> Sounds good.  I'm hoping to get some review/comments on this patch set
> as well.  At the moment, I'm chasing down a kernel test robot report
> from this afternoon.

My concern about changing the canonical format as originally defined in
patch 9/9 from big endian to little endian never materialized.  Andreas
Steffan, the patch author, is happy either way.

We proposed two methods of addressing Eric Biederman's concerns of not
including the IMA measurement list segment in the kexec hash as
described in  https://lkml.org/lkml/2016/9/9/355.

- defer calculating and verifying the serialized IMA measurement list
buffer hash to IMA
- calculate the kexec hash on load, verify it on the kexec execute,
before re-calculating and updating it.

We implemented both options, which can be found in the
next-kexec-restore.with-ima-checksum and next-kexec-restore branches of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Thiago's patches posted yesterday and mine posted this morning are based
on kexec doing the hashing (the second option).

Lastly, we've addressed the automated kernel build and runtime bug
reports.

Since the IMA patches are dependent on the kexec ones, the two patch
sets need to be upstreamed together.  How should we proceed?   Should
they be upstreamed through your tree?

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
