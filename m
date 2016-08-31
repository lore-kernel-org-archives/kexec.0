Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bfE9X-0000Px-RV
 for kexec@lists.infradead.org; Wed, 31 Aug 2016 22:38:40 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7VMaecc065977
 for <kexec@lists.infradead.org>; Wed, 31 Aug 2016 18:38:18 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 255pm0vvd8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 31 Aug 2016 18:38:17 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 04:08:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 02E8B3940060
 for <kexec@lists.infradead.org>; Thu,  1 Sep 2016 04:08:12 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7VMcBbh34341042
 for <kexec@lists.infradead.org>; Thu, 1 Sep 2016 04:08:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7VMcAgl001679
 for <kexec@lists.infradead.org>; Thu, 1 Sep 2016 04:08:11 +0530
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 31 Aug 2016 18:38:06 -0400
In-Reply-To: <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
Mime-Version: 1.0
Message-Id: <1472683086.2607.17.camel@linux.vnet.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-security-module <linux-security-module@vger.kernel.org>, linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>

On Wed, 2016-08-31 at 13:50 -0700, Andrew Morton wrote:
> On Tue, 30 Aug 2016 18:40:02 -0400 Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > The TPM PCRs are only reset on a hard reboot.  In order to validate a
> > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> > of the running kernel must be saved and then restored on the subsequent
> > boot, possibly of a different architecture.
> > 
> > The existing securityfs binary_runtime_measurements file conveniently
> > provides a serialized format of the IMA measurement list. This patch
> > set serializes the measurement list in this format and restores it.
> > 
> > Up to now, the binary_runtime_measurements was defined as architecture
> > native format.  The assumption being that userspace could and would
> > handle any architecture conversions.  With the ability of carrying the
> > measurement list across kexec, possibly from one architecture to a
> > different one, the per boot architecture information is lost and with it
> > the ability of recalculating the template digest hash.  To resolve this
> > problem, without breaking the existing ABI, this patch set introduces
> > the boot command line option "ima_canonical_fmt", which is arbitrarily
> > defined as little endian.
> > 
> > The need for this boot command line option will be limited to the
> > existing version 1 format of the binary_runtime_measurements.
> > Subsequent formats will be defined as canonical format (eg. TPM 2.0
> > support for larger digests).
> > 
> > This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> > hand-over for the next kernel" patch set. 
> > 
> > These patches can also be found in the next-kexec-restore branch of:
> > git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> 
> I'll merge these into -mm to get some linux-next exposure.  I don't
> know what your upstream merge plans will be?

Sounds good.  I'm hoping to get some review/comments on this patch set
as well.  At the moment, I'm chasing down a kernel test robot report
from this afternoon.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
