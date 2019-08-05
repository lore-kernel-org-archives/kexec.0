Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hubV1-0004bq-VY
 for kexec@lists.infradead.org; Mon, 05 Aug 2019 11:50:01 +0000
Subject: Re: [LKP] [x86/boot] 5b51ae969e: kexec boot failed
References: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
 <20190802093024.GB30710@zn.tnic>
From: "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <0f817336-2d87-2110-13c0-e0a417d70e90@intel.com>
Date: Mon, 5 Aug 2019 19:49:54 +0800
MIME-Version: 1.0
In-Reply-To: <20190802093024.GB30710@zn.tnic>
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
Cc: x86@kernel.org, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, lkp@01.org

Hi,

On 8/2/2019 5:30 PM, Borislav Petkov wrote:
> On Fri, Aug 02, 2019 at 03:48:53PM +0800, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24 ("x86/boot: Call get_rsdp_addr() after console_init()")
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git  master
>>
>> in testcase: boot
>>
>> on test machine: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
>>
>> The commit broke kexec boot on physical machines, We have to set "nokaslr" to kernel cmdline to avoid the issue.
> How exactly do you trigger it? Details?
>

We use the following command to boot a new kernel:
kexec --noefi -l 
/opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.6/gcc-7/5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24/vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a 
--initrd=/opt/rootfs/tmp/initrd-concatenated

Best Regards,
Rong Chen



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
