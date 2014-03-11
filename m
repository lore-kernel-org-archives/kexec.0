Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNG7z-00013s-6c
 for kexec@lists.infradead.org; Tue, 11 Mar 2014 06:25:29 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile: get_max_mapnr() from ELF header problem
Date: Tue, 11 Mar 2014 06:22:41 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F4AFE@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971EFABE@BPXM01GP.gisp.nec.co.jp>
 <20140303104408.7031a457@holzheu>
In-Reply-To: <20140303104408.7031a457@holzheu>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Mon, 3 Mar 2014 03:11:23 +0000
>Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
>
>> Hello Michael,
>>
>> >Hello Atsushi,
>> >
>> >On s390 we have the following little problem:
>> >
>> >We use hypervisor or stand-alone dump tools to create Linux system
>> >dumps. These tools do not know the kernel parameter line and dump the
>> >full physical memory.
>> >
>> >We use makedumpfile to filter those dumps.
>> >
>> >If a Linux system has specified the "mem=" parameter, the dump tools
>> >still dump the whole phypsical memory.
>>
>> I guess this is a problem of the tools, it sounds that the tools ignore
>> the actual memory map and just make wrong ELF headers.
>> How do the tools decide the range of System RAM to create ELF headers ?
>
>The tools do a physical memory detection and that defines the range
>of memory to be dumped and also defines the memory chunks for the
>ELF header.

makedumpfile is designed for kdump, this means it relies on dependable ELF
headers. If we support such an incorrect ELF header, makedumpfile has to get
the actual memory map from vmcore (but I have no ideas how to do it now) and
re-calculate all PT_LOAD regions with it. It sounds too much work for
irregular case, I don't plan to take care of it now.

>And I think we are not the only ones that have this problem. For example,
>the KVM virsh dump probably also has that problem.

virsh dump seems to have the same issue as you said, but I suppose qemu
developers don't worry about that because they are developing an original
way to dump guest's memory in kdump-compressed format as "dump-guest-memory"
command. It seems that they know such case is out of the scope of makedumpfile.


Thanks
Atsushi Kumagai

>> At least, if the tools respect the actual memory map like /proc/vmcore, it
>> can create correct ELF headers and makedumpfile will work normally.
>
>As I said, the tools do not know the Linux memory map. They only know
>the physical available memory.
>
>Michael
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
