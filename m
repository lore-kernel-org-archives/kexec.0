Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hx54u-00034l-J5
 for kexec@lists.infradead.org; Mon, 12 Aug 2019 07:49:18 +0000
Subject: Re: [LKP] [x86/boot] 5b51ae969e: kexec boot failed
References: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
 <20190802093024.GB30710@zn.tnic>
 <0f817336-2d87-2110-13c0-e0a417d70e90@intel.com>
 <20190806084543.GA2164@dhcp-128-65.nay.redhat.com>
From: Rong Chen <rong.a.chen@intel.com>
Message-ID: <44d5e337-ac6a-46f1-41d4-a963f820391b@intel.com>
Date: Mon, 12 Aug 2019 15:49:18 +0800
MIME-Version: 1.0
In-Reply-To: <20190806084543.GA2164@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, Borislav Petkov <bp@suse.de>, lkp@01.org

Hi,

On 8/6/19 4:45 PM, Dave Young wrote:
> On 08/05/19 at 07:49pm, Chen, Rong A wrote:
>> Hi,
>>
>> On 8/2/2019 5:30 PM, Borislav Petkov wrote:
>>> On Fri, Aug 02, 2019 at 03:48:53PM +0800, kernel test robot wrote:
>>>> FYI, we noticed the following commit (built with gcc-7):
>>>>
>>>> commit: 5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24 ("x86/boot: Call get_rsdp_addr() after console_init()")
>>>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git  master
>>>>
>>>> in testcase: boot
>>>>
>>>> on test machine: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
>>>>
>>>> The commit broke kexec boot on physical machines, We have to set "nokaslr" to kernel cmdline to avoid the issue.
>>> How exactly do you trigger it? Details?
>>>
>> We use the following command to boot a new kernel:
>> kexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.6/gcc-7/5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24/vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a
>> --initrd=/opt/rootfs/tmp/initrd-concatenated
>>
> --noefi is a corner case as kexec now supports efi, it is expected not
> work with old kexec-tools in case you do not use acpi_rsdp= cmdline
> explicitly.
>   
> I suspect it is still the rsdp getting failed instead of the moving
> chunk after console_init.
>   
> Can you do more testing?
>    
> 1.  test latest kexec-tools
> git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

There's no problem if using the latest kexec-tools
root@lkp-bdw-de1 ~# ./kexec --version
kexec-tools 2.0.20
root@lkp-bdw-de1 ~# ./kexec --noefi -l 
vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a --initrd final_initrd-borrow 
--reuse-cmdline
root@lkp-bdw-de1 ~# ./kexec -e

>   
> 2. still use your old kexec-tools:
>    a. test without --noefi

root@lkp-bdw-de1 ~# kexec vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a 
--initrd final_initrd-borrow --reuse-cmdline
Unknown type (Reserved) while parsing /sys/firmware/memmap/7/type. 
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/13/type. 
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/11/type. 
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/1/type. 
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/4/type. 
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/12/type. 
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/2/type. 
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/9/type. 
Please report this as bug. Using RANGE_RESERVED now.
Connection to lkp-bdw-de1 closed by remote host.
Connection to lkp-bdw-de1 closed.


>    b. test with --noefi but with some appending acpi_rsdp= cmdline, for
> example (enable serial to capture console log):
> kexec --noefi -l .../vmlinuz-... --reuse-cmdline --append
> "acpi_rsdp=0xaabbccdd earlyprintk=serial"

Sorry, I can't get console log from this machine.

Best Regards,
Rong Chen

>   
> Note: get the acpi pointer by:
> cat /sys/firmware/efi/systab
> for example on my laptop the acpi cmdline should be acpi_rsdp=0x7b5fe014:
> [root@dhcp-*-* dyoung]# cat /sys/firmware/efi/systab
> ACPI20=0x7b5fe014
> ACPI=0x7b5fe000
> SMBIOS3=0x7a671000
> SMBIOS=0x7a674000


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
