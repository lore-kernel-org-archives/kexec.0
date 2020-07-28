Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0FBR-000703-DE
 for kexec@lists.infradead.org; Tue, 28 Jul 2020 02:17:38 +0000
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <159579233676.5790.10701756666641782647.stgit@hbathini>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RESEND PATCH v5 07/11] ppc64/kexec_file: enable early kernel's
 OPAL calls
In-reply-to: <159579233676.5790.10701756666641782647.stgit@hbathini>
Date: Mon, 27 Jul 2020 23:17:23 -0300
Message-ID: <87eeowxu18.fsf@morokweng.localdomain>
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
Cc: Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> Kernel built with CONFIG_PPC_EARLY_DEBUG_OPAL enabled expects r8 & r9
> to be filled with OPAL base & entry addresses respectively. Setting
> these registers allows the kernel to perform OPAL calls before the
> device tree is parsed.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
