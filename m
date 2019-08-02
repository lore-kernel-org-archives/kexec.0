Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1htSTn-0007G4-9I
 for kexec@lists.infradead.org; Fri, 02 Aug 2019 08:00:01 +0000
Date: Fri, 2 Aug 2019 15:59:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [x86/boot] 5b51ae969e: kexec boot failed
Message-ID: <20190802075949.GA4681@dhcp-128-65.nay.redhat.com>
References: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
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
To: kernel test robot <rong.a.chen@intel.com>
Cc: x86@kernel.org, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, Borislav Petkov <bp@suse.de>, lkp@01.org

Hi,

On 08/02/19 at 03:48pm, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24 ("x86/boot: Call get_rsdp_addr() after console_init()")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git  master
> 
> in testcase: boot
> 
> on test machine: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
> 
> The commit broke kexec boot on physical machines, We have to set "nokaslr" to kernel cmdline to avoid the issue.
> 

Does moving line of "sanitize_boot_params(boot_params);" after get_rsdp_addr()
callback work?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
