Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFlYZ-0005uA-4z
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 17:03:15 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MGsAOH009380
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 13:02:54 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23qq3k226b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 13:02:53 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 14:02:50 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 9430C1DC0080
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 13:02:41 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MH2mcF17432888
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 14:02:48 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MH2mFc016336
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 14:02:48 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
Date: Wed, 22 Jun 2016 14:02:45 -0300
In-Reply-To: <20160622232946.793d6c04@350D>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622232946.793d6c04@350D>
MIME-Version: 1.0
Message-Id: <2895031.4C8tZ3BP2G@hactar>
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
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hello Balbir,

Am Mittwoch, 22 Juni 2016, 23:29:46 schrieb Balbir Singh:
> On Tue, 21 Jun 2016 16:48:32 -0300
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:
> > This patch series implements the kexec_file_load system call on
> > PowerPC.
> > 
> > This system call moves the reading of the kernel, initrd and the
> > device tree from the userspace kexec tool to the kernel. This is
> > needed if you want to do one or both of the following:
> > 
> > 1. only allow loading of signed kernels.
> > 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
> > 
> >    command line and other boot inputs for the Integrity Measurement
> >    Architecture subsystem.
> > 
> > The above are the functions kexec already has built into
> > kexec_file_load. Yesterday I posted a set of patches which allows a
> > third feature:
> > 
> > 3. have IMA pass-on its event log (where integrity measurements are
> > 
> >    registered) accross kexec to the second kernel, so that the event
> >    history is preserved.
> 
> OK.. and this is safe? Do both the kernels need to be signed by the
> same certificate?

They don't. The integrity of the event log (assuming that is what you mean 
by "this" in "this is safe") is guaranteed by the TPM device. Each event in 
the measurement list extends a PCR and records its PCR value. It is 
cryptographically guaranteed that if you replay the PCR extends recorded in 
the event log and in the end of the process they match the current PCR 
values in the TPM device, then that event log is correct.

The kernel signature serves to ensure that you only run kernels from an 
authorized provider. It doesn't play a role in integrity assurance, which 
aims to verify that the machine is really running the code it says it is 
running. As I understand it, at least. It's a bit subtle and I could be 
missing something...

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
