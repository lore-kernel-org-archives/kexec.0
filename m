Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bX6Hf-0006x7-Aq
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 12:37:28 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79CTjeS083415
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 08:37:06 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nbys6ucd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 09 Aug 2016 08:37:05 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 18:07:03 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2DAE9E005B
 for <kexec@lists.infradead.org>; Tue,  9 Aug 2016 18:11:26 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79Cb03G46334146
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 18:07:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79Caw2f006536
 for <kexec@lists.infradead.org>; Tue, 9 Aug 2016 18:06:59 +0530
Subject: Re: [PATCH 0/7] ima: carry the measurement list across kexec
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 08:36:44 -0400
In-Reply-To: <91fa2f95-4d70-a056-d599-01cb3bbe6771@gmail.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <91fa2f95-4d70-a056-d599-01cb3bbe6771@gmail.com>
Mime-Version: 1.0
Message-Id: <1470746204.2881.101.camel@linux.vnet.ibm.com>
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
To: Balbir Singh <bsingharora@gmail.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org

On Tue, 2016-08-09 at 15:19 +1000, Balbir Singh wrote:
> 
> On 04/08/16 22:24, Mimi Zohar wrote:
> > The TPM PCRs are only reset on a hard reboot.  In order to validate a
> > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> > of the running kernel must be saved and then restored on the subsequent
> > boot.
> > 
> > The existing securityfs binary_runtime_measurements file conveniently
> > provides a serialized format of the IMA measurement list. This patch
> > set serializes the measurement list in this format and restores it.
> > 
> > This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
> > hand-over for the next kernel" patch set* for actually carrying the
> > serialized measurement list across the kexec.
> > 
> > Mimi
> > 
> 
> Hi, Mimi
> 
> I am trying to convince myself of the security of the solution. I asked
> Thiago as well, but may be I am be lagging behind in understanding.
> 
> We trust the kernel to hand over PCR values of the old kernel (which
> cannot be validated) to the IMA subsystem in the new kernel for storage.
> I guess the idea is for ima_add_boot_aggregate to do the right thing?
> How do we validate what the old kernel is giving us? Why do we care for
> the old measurement list? Is it still of significance in the new kernel?
> 

Hi Balbir,

To validate the hardware TPM PCR values requires walking the measurement
list simulating the TPM extend operation.  The resulting values should
match the hardware TPM PCRs.

In the case of a soft reboot, the TPM PCRs are not reset to 0, so all
the measurements of the running system, including those from previous
soft reboots, need to be included in the measurement list.   Without
these measurements, the simulated PCR values will not match the hardware
TPM PCR values.  Thus the need for this patch set.

Measurements can not be added/removed/changed in the measurement list
without it being detectable.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
