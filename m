Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hx5WB-0006R9-Kp
 for kexec@lists.infradead.org; Mon, 12 Aug 2019 08:17:29 +0000
Subject: Re: [LKP] [x86/boot] 5b51ae969e: kexec boot failed
From: Rong Chen <rong.a.chen@intel.com>
References: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
 <20190802093024.GB30710@zn.tnic>
 <0f817336-2d87-2110-13c0-e0a417d70e90@intel.com>
 <20190805130221.GA18887@zn.tnic> <20190805133210.GB18887@zn.tnic>
 <c83ef145-83ef-d1b8-8a41-4957f20039e8@intel.com>
Message-ID: <669b2392-e9ce-76f7-638c-4b32878c53b5@intel.com>
Date: Mon, 12 Aug 2019 16:17:29 +0800
MIME-Version: 1.0
In-Reply-To: <c83ef145-83ef-d1b8-8a41-4957f20039e8@intel.com>
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
To: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, lkp@01.org, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>



On 8/12/19 3:43 PM, Rong Chen wrote:
> Hi,
>
> On 8/5/19 9:32 PM, Borislav Petkov wrote:
>> On Mon, Aug 05, 2019 at 03:02:21PM +0200, Borislav Petkov wrote:
>>> On Mon, Aug 05, 2019 at 07:49:54PM +0800, Chen, Rong A wrote:
>>>> We use the following command to boot a new kernel:
>>>> kexec --noefi -l 
>>>> /opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.6/gcc-7/5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24/vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a
>>>> --initrd=/opt/rootfs/tmp/initrd-concatenated
>>> And this "concatenated" initrd, how do you generate that?
>> And the "-l" thing is just the kexec load command to load the second
>> kernel. I need you to give me a step-by-step, exact command-by-command
>> list of things you do to trigger.
>>
>> Also, pls send me dmesg from the first kernel. Privately is fine too.
>>
>> Thx.
>
> Sorry for the delay, I've found a machine which can reproduce the 
> issue at last.
>
> root@lkp-bdw-de1 ~# kexec --version
> kexec-tools 2.0.14
>
> kexec reboots the system without "-e option"
> root@lkp-bdw-de1 ~# kexec --noefi 
> vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a --initrd final_initrd-borrow 
> --reuse-cmdline
> Unknown type (Reserved) while parsing /sys/firmware/memmap/7/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/13/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/11/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/1/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/4/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/12/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/2/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/9/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Connection to lkp-bdw-de1 closed by remote host.
> Connection to lkp-bdw-de1 closed.
>
> The behavior is as usual if using "nokaslr"
> root@lkp-bdw-de1 ~# kexec -l vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a 
> --initrd final_initrd-borrow --reuse-cmdline --append "nokaslr"
> Unknown type (Reserved) while parsing /sys/firmware/memmap/7/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/13/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/11/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/1/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/4/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/12/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/2/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/9/type. 
> Please report this as bug. Using RANGE_RESERVED now.
> root@lkp-bdw-de1 ~# kexec -e
>
> And please find the pre-dmesg in the attachment.

I've uploaded the vmlinuz and initrd files to 
https://download.01.org/0day-ci/lkp-qemu/fbc/5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24

Best Regards,
Rong Chen

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
