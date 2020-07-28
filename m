Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0FUZ-0001Tq-77
 for kexec@lists.infradead.org; Tue, 28 Jul 2020 02:37:24 +0000
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <159579235754.5790.5203600072984600891.stgit@hbathini>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RESEND PATCH v5 08/11] ppc64/kexec_file: setup backup region for
 kdump kernel
In-reply-to: <159579235754.5790.5203600072984600891.stgit@hbathini>
Date: Mon, 27 Jul 2020 23:37:08 -0300
Message-ID: <87d04gxt4b.fsf@morokweng.localdomain>
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

> Though kdump kernel boots from loaded address, the first 64KB of it is
> copied down to real 0. So, setup a backup region and let purgatory
> copy the first 64KB of crashed kernel into this backup region before
> booting into kdump kernel. Update reserve map with backup region and
> crashed kernel's memory to avoid kdump kernel from accidentially using
> that memory.
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
