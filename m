Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ezIEF-0000SL-LM
 for kexec@lists.infradead.org; Fri, 23 Mar 2018 08:39:17 +0000
Date: Fri, 23 Mar 2018 16:38:58 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 0/2] Kexec_file: Load kernel at top of system ram
Message-ID: <20180323083858.GB25740@localhost.localdomain>
References: <20180322033722.9279-1-bhe@redhat.com>
 <20180322153802.0763bb46978c0c1a3d3f11c0@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180322153802.0763bb46978c0c1a3d3f11c0@linux-foundation.org>
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
To: vgoyal@redhat.com, hpa@zytor.com, yinghai@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: prudo@linux.vnet.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, ebiederm@xmission.com, dyoung@redhat.com

On 03/22/18 at 03:38pm, Andrew Morton wrote:
> On Thu, 22 Mar 2018 11:37:20 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > The current kexec_file ignores kexec_buf.top_down value when call
> > arch_kexec_walk_mem() to allocate memory for loading kernel/initrd
> > stuffs. This is not supposed to be what kexec_buf.top_down is used
> > for.
> 
> OK, but why is this a problem?  When fixing a bug, please fully
> describe the user-visible effects of that bug.  That helps others
> understand the importance of the fix, whether it should be backported
> into various kernels, etc.

The problem is the current kexec file loading has different behaviour
with the old kexec loading. In kexec loading, user space kexec_tools
utility does most of job, it searches in /proc/iomem to try to find a
memory region from top to down to load kernel. Therefore with the kexec
loading, x86_64 bzImage kernel are all loaded at top of System RAM.
However, the kexec file loading just searches for available memory
region in iomem resource from bottom to top, then try to allocate from
top to down in that region. E.g on my testing system with 2G memory as
below, the kexec loading will put kernel near 0x000000013fffffff, while
kexec file loading will put kernel near 0x000000003ffddfff. There's no
bug reported yet, just we need consider it when take care of the kexec
collaboration with other kernel components like kaslr/hotplug etc, and
also the consistentency between the different kexec interface.

[Mar23 15:13] Linux version 4.16.0-rc3+ (bhe@localhost.localdomain) (gcc version
[  +0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.16.0-rc3+ root=UUID=be8f8e3a-9
[  +0.000000] x86/fpu: x87 FPU will use FXSAVE
[  +0.000000] e820: BIOS-provided physical RAM map:
[  +0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[  +0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffddfff] usable
[  +0.000000] BIOS-e820: [mem 0x000000003ffde000-0x000000003fffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable

I searched on internet and found the original patches posted for adding
bzImage 64 support into the old kexec loading, which is located in user
space kexec_tools utility made by Yinghai, and Vivek and hpa reviewed
patches. Still I didn't found out why kernel has to be put at top of
system RAM. I guess low memory are reserved for system usage mostly,
putting kexec kernel at top is safer and no need to exclude those resereved
regions by system or firmware which we may not find out all of them, but
not very sure about it.

Hi Yinghai, Vivek, hpa,

Do you know why we load kexec kernel at top of system RAM when do
x86_64 bzImage loading?

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
