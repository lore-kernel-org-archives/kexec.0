Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyleb-0004bS-Mz
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 00:33:38 +0000
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com>
 <159524966309.20855.15216784717419378243.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 10/12] ppc64/kexec_file: prepare elfcore header for
 crashing kernel
In-reply-to: <159524966309.20855.15216784717419378243.stgit@hbathini.in.ibm.com>
Date: Thu, 23 Jul 2020 21:33:23 -0300
Message-ID: <87365h69bg.fsf@morokweng.localdomain>
MIME-Version: 1.0
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> Prepare elf headers for the crashing kernel's core file using
> crash_prepare_elf64_headers() and pass on this info to kdump
> kernel by updating its command line with elfcorehdr parameter.
> Also, add elfcorehdr location to reserve map to avoid it from
> being stomped on while booting.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
