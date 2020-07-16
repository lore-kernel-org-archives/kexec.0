Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwC6z-0002Mv-6R
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 22:12:18 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466093748.24747.4655547403463921814.stgit@hbathini.in.ibm.com>
 <871rlc9upc.fsf@morokweng.localdomain>
 <6f64a18a-352e-fdec-c902-45aefc31cc0a@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 07/12] ppc64/kexec_file: add support to relocate
 purgatory
In-reply-to: <6f64a18a-352e-fdec-c902-45aefc31cc0a@linux.ibm.com>
Date: Thu, 16 Jul 2020 19:12:04 -0300
Message-ID: <87365rcdor.fsf@morokweng.localdomain>
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
Cc: kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> On 16/07/20 5:50 am, Thiago Jung Bauermann wrote:
>> 
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>> 
>>> So, add support to relocate purgatory in kexec_file_load system call
>>> by setting up TOC pointer and applying RELA relocations as needed.
>> 
>> If we do want to use a C purgatory, Michael Ellerman had suggested
>> building it as a Position Independent Executable, which greatly reduces
>> the number and types of relocations that are needed. See patches 4 and 9
>> here:
>> 
>> https://lore.kernel.org/linuxppc-dev/1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com/
>> 
>> In the series above I hadn't converted x86 to PIE. If I had done that,
>> possibly Dave Young's opinion would have been different. :-)
>> 
>> If that's still not desirable, he suggested in that discussion lifting
>> some code from x86 to generic code, which I implemented and would
>> simplify this patch as well:
>> 
>> https://lore.kernel.org/linuxppc-dev/5009580.5GxAkTrMYA@morokweng/
>> 
>
> Agreed. But I prefer to work on PIE and/or moving common relocation_add code
> for x86 & s390 to generic code later when I try to build on these purgatory
> changes. So, a separate series later to rework purgatory with the things you
> mentioned above sounds ok?

Sounds ok to me. Let's see what the maintainers think, then.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
