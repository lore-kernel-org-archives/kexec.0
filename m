Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1huv6P-0001XX-Ka
 for kexec@lists.infradead.org; Tue, 06 Aug 2019 08:45:55 +0000
Date: Tue, 6 Aug 2019 16:45:43 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [LKP] [x86/boot] 5b51ae969e: kexec boot failed
Message-ID: <20190806084543.GA2164@dhcp-128-65.nay.redhat.com>
References: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
 <20190802093024.GB30710@zn.tnic>
 <0f817336-2d87-2110-13c0-e0a417d70e90@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f817336-2d87-2110-13c0-e0a417d70e90@intel.com>
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
To: "Chen, Rong A" <rong.a.chen@intel.com>
Cc: x86@kernel.org, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, Borislav Petkov <bp@suse.de>, lkp@01.org

On 08/05/19 at 07:49pm, Chen, Rong A wrote:
> Hi,
> 
> On 8/2/2019 5:30 PM, Borislav Petkov wrote:
> > On Fri, Aug 02, 2019 at 03:48:53PM +0800, kernel test robot wrote:
> > > FYI, we noticed the following commit (built with gcc-7):
> > > 
> > > commit: 5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24 ("x86/boot: Call get_rsdp_addr() after console_init()")
> > > https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > > 
> > > in testcase: boot
> > > 
> > > on test machine: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
> > > 
> > > The commit broke kexec boot on physical machines, We have to set "nokaslr" to kernel cmdline to avoid the issue.
> > How exactly do you trigger it? Details?
> > 
> 
> We use the following command to boot a new kernel:
> kexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.6/gcc-7/5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24/vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a
> --initrd=/opt/rootfs/tmp/initrd-concatenated
> 

--noefi is a corner case as kexec now supports efi, it is expected not
work with old kexec-tools in case you do not use acpi_rsdp= cmdline
explicitly.
 
I suspect it is still the rsdp getting failed instead of the moving
chunk after console_init.
 
Can you do more testing?
  
1.  test latest kexec-tools
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
 
2. still use your old kexec-tools:
  a. test without --noefi
  b. test with --noefi but with some appending acpi_rsdp= cmdline, for
example (enable serial to capture console log):
kexec --noefi -l .../vmlinuz-... --reuse-cmdline --append
"acpi_rsdp=0xaabbccdd earlyprintk=serial"
 
Note: get the acpi pointer by:
cat /sys/firmware/efi/systab
for example on my laptop the acpi cmdline should be acpi_rsdp=0x7b5fe014:
[root@dhcp-*-* dyoung]# cat /sys/firmware/efi/systab
ACPI20=0x7b5fe014
ACPI=0x7b5fe000
SMBIOS3=0x7a671000
SMBIOS=0x7a674000

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
