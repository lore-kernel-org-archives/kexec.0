Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0VDk-0007Io-Cp
 for kexec@lists.infradead.org; Tue, 28 Jul 2020 19:25:05 +0000
Subject: Re: [RESEND PATCH v5 07/11] ppc64/kexec_file: enable early kernel's
 OPAL calls
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <159579233676.5790.10701756666641782647.stgit@hbathini>
 <87365b7nx4.fsf@mpe.ellerman.id.au>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <23baef6a-6ddc-572a-82c5-21a7fa441485@linux.ibm.com>
Date: Wed, 29 Jul 2020 00:54:47 +0530
MIME-Version: 1.0
In-Reply-To: <87365b7nx4.fsf@mpe.ellerman.id.au>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>



On 28/07/20 7:16 pm, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
>> Kernel built with CONFIG_PPC_EARLY_DEBUG_OPAL enabled expects r8 & r9
>> to be filled with OPAL base & entry addresses respectively. Setting
>> these registers allows the kernel to perform OPAL calls before the
>> device tree is parsed.
> 
> I'm not convinced we want to do this.
> 
> If we do it becomes part of the kexec ABI and we have to honour it into
> the future.
> 
> And in practice there are no non-development kernels built with OPAL early
> debugging enabled, so it's not clear it actually helps anyone other than
> developers.
> 

Hmmm.. kexec-tools does it since commit d58ad564852c ("kexec/ppc64
Enable early kernel's OPAL calls") for kexec_load syscall. So, we would
be breaking kexec ABI either way, I guess.

Let me put this patch at the end of the series in the respin to let you
decide whether to have it or not..

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
