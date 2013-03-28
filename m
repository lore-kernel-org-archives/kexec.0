Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
Date: Thu, 28 Mar 2013 10:50:11 +0800
Message-ID: <CAFNq8R6pgz_-yfB2DPhcH02e-NZGh1LJHJ0GpD2QJ_iy0SP83Q@mail.gmail.com>
Subject: Question about crashkernel parameter on cmdline
From: Li Haifeng <omycle@gmail.com>
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
To: kexec@lists.infradead.org, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>, linux-arm-kernel@lists.infradead.org

Hi, list.

I am running kexec-tools on ARM soc to dump vmcore file. In my case,
the crashkernel parameter of crash kernel 's cmdline is
"crashkernel=20M@10M". Then in bash of crash kernel, "echo c >
/proc/sysrq-trigger", and the capture kernel launches. But it will
fail on initializing /proc/vmcore. Because it trigger
"WARN_ON(pfn_valid(pfn))" in   __arm_ioremap_pfn_caller()
@arch/arm/mm/ioremap.c.

I check the reason as follows.

 #define pfn_valid(pfn) ((pfn) >= ARCH_PFN_OFFSET && ((pfn) -
ARCH_PFN_OFFSET) < max_mapnr)

To my case, pfn:x01d00, ARCH_PFN_OFFSET:0, max_mapnr:0x1300.
So pfn-ARCH_PFN_OFFSET is less than max_mapnr, and the
WARN_ON(pfn_valid(pfn)) is triggered on.

I want to know, to ignore this warning, whether I should comment this
WARN_ON() in kernel source code for my case.
And another doubt, will this warning corrupt my dumpfile? Because,
when I use the crash utility to analyse this vmcore, many errors
throw.

Any suggestion will be appreciate.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
