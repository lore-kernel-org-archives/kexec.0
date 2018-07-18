Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ffv0t-0006XZ-JZ
 for kexec@lists.infradead.org; Wed, 18 Jul 2018 22:33:40 +0000
Date: Wed, 18 Jul 2018 15:33:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 4/4] kexec_file: Load kernel at top of system RAM if
 required
Message-Id: <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
In-Reply-To: <20180718024944.577-5-bhe@redhat.com>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-5-bhe@redhat.com>
Mime-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: nicolas.pitre@linaro.org, brijesh.singh@amd.com, devicetree@vger.kernel.org, airlied@linux.ie, linux-pci@vger.kernel.org, richard.weiyang@gmail.com, keith.busch@intel.com, jcmvbkbc@gmail.com, baiyaowei@cmss.chinamobile.com, kys@microsoft.com, frowand.list@gmail.com, tglx@linutronix.de, lorenzo.pieralisi@arm.com, sthemmin@microsoft.com, linux-nvdimm@lists.01.org, patrik.r.jakobsson@gmail.com, andy.shevchenko@gmail.com, linux-input@vger.kernel.org, gustavo@padovan.org, bp@suse.de, dyoung@redhat.com, vgoyal@redhat.com, thomas.lendacky@amd.com, haiyangz@microsoft.com, maarten.lankhorst@linux.intel.com, josh@joshtriplett.org, jglisse@redhat.com, robh+dt@kernel.org, seanpaul@chromium.org, bhelgaas@google.com, dan.j.williams@intel.com, yinghai@kernel.org, jonathan.derrick@intel.com, chris@zankel.net, monstr@monstr.eu, linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, devel@linuxdriverproject.org, fengguang.wu@intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Wed, 18 Jul 2018 10:49:44 +0800 Baoquan He <bhe@redhat.com> wrote:

> For kexec_file loading, if kexec_buf.top_down is 'true', the memory which
> is used to load kernel/initrd/purgatory is supposed to be allocated from
> top to down. This is what we have been doing all along in the old kexec
> loading interface and the kexec loading is still default setting in some
> distributions. However, the current kexec_file loading interface doesn't
> do like this. The function arch_kexec_walk_mem() it calls ignores checking
> kexec_buf.top_down, but calls walk_system_ram_res() directly to go through
> all resources of System RAM from bottom to up, to try to find memory region
> which can contain the specific kexec buffer, then call locate_mem_hole_callback()
> to allocate memory in that found memory region from top to down. This brings
> confusion especially when KASLR is widely supported , users have to make clear
> why kexec/kdump kernel loading position is different between these two
> interfaces in order to exclude unnecessary noises. Hence these two interfaces
> need be unified on behaviour.

As far as I can tell, the above is the whole reason for the patchset,
yes?  To avoid confusing users.

Is that sufficient?  Can we instead simplify their lives by providing
better documentation or informative printks or better Kconfig text,
etc?

And who *are* the people who are performing this configuration?  Random
system administrators?  Linux distro engineers?  If the latter then
they presumably aren't easily confused!

In other words, I'm trying to understand how much benefit this patchset
will provide to our users as a whole.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
