Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bi4ss-0006W8-KX
 for kexec@lists.infradead.org; Thu, 08 Sep 2016 19:21:15 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u88JHdlD068275
 for <kexec@lists.infradead.org>; Thu, 8 Sep 2016 15:20:53 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25bc346d36-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 08 Sep 2016 15:20:53 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 8 Sep 2016 16:20:51 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id A1E45352006E
 for <kexec@lists.infradead.org>; Thu,  8 Sep 2016 15:20:25 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u88JKml525362496
 for <kexec@lists.infradead.org>; Thu, 8 Sep 2016 16:20:48 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u88JKloP019386
 for <kexec@lists.infradead.org>; Thu, 8 Sep 2016 16:20:48 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 0/5] kexec_file: Add buffer hand-over for the next
 kernel
Date: Thu, 08 Sep 2016 16:20:45 -0300
In-Reply-To: <871t0vlrlv.fsf@x220.int.ebiederm.org>
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8760q7lswz.fsf@x220.int.ebiederm.org> <871t0vlrlv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-Id: <3106532.NfQxgDJQ20@hactar>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Balbir Singh <bsingharora@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Eric Richter <erichte@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

Am Mittwoch, 07 September 2016, 09:19:40 schrieb Eric W. Biederman:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> >> Hello,
> >> 
> >> The purpose of this new version of the series is to fix a small issue
> >> that I found, which is that the kernel doesn't remove the memory
> >> reservation for the hand-over buffer it received from the previous
> >> kernel in the device tree it sets up for the next kernel. The result
> >> is that for each successive kexec, a stale hand-over buffer is left
> >> behind, wasting memory.
> >> 
> >> This is fixed by changes to kexec_free_handover_buffer and
> >> setup_handover_buffer in patch 2. The other change is to fix checkpatch
> >> warnings in the last patch.
> > 
> > This is fundamentally broken.  You do not increase the integrity of a
> > system by dropping integrity checks.
> > 
> > No. No. No. No.
> > 
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

The IMA measurement list can be verified without the need of a checksum over 
its contents by replaying the PCR extend operations and checking that the 
result matches the registers in the TPM device. So the fact that it is not 
part of the kexec segments checksum verification doesn't actually reduce the 
integrity of the system.

Currently, IMA doesn't perform that verification when it restores the 
measurement list from the kexec handover buffer, so if you believe it's 
necessary to do that check at boot time, we could do one of the following:

1. Have IMA replay the PCR extend operations when it restores the 
measurement list from the handover buffer and validate it against the TPM 
PCRs, or

2. Have a buffer hash in the ima_kexec_hdr that IMA includes in the handover 
buffer, and verify the buffer checksum before restoring the measurement 
list.

What do you think?

> To be constructive the way we have handled similiar situations in the
> past (hotplu memory) is to call kexec_load again.

Thanks for your suggestion. Unfortunately it's always possible for new 
measurements to be added to the measurement list between the kexec_file_load 
and the reboot. We see that happen in practice with system scripts and 
configuration files that are only read or executed during the reboot 
process. They are only measured by IMA as a result of the kexec execute.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
