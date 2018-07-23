Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fhbvP-0003vH-Sp
 for kexec@lists.infradead.org; Mon, 23 Jul 2018 14:35:01 +0000
Date: Mon, 23 Jul 2018 16:34:43 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v7 4/4] kexec_file: Load kernel at top of system RAM if
 required
Message-ID: <20180723143443.GD18181@dhcp22.suse.cz>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-5-bhe@redhat.com>
 <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
 <20180719151753.GB7147@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180719151753.GB7147@localhost.localdomain>
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
Cc: nicolas.pitre@linaro.org, brijesh.singh@amd.com, devicetree@vger.kernel.org, airlied@linux.ie, linux-pci@vger.kernel.org, richard.weiyang@gmail.com, keith.busch@intel.com, jcmvbkbc@gmail.com, baiyaowei@cmss.chinamobile.com, kys@microsoft.com, frowand.list@gmail.com, dan.j.williams@intel.com, lorenzo.pieralisi@arm.com, sthemmin@microsoft.com, linux-nvdimm@lists.01.org, patrik.r.jakobsson@gmail.com, andy.shevchenko@gmail.com, linux-input@vger.kernel.org, gustavo@padovan.org, bp@suse.de, dyoung@redhat.com, vgoyal@redhat.com, thomas.lendacky@amd.com, haiyangz@microsoft.com, maarten.lankhorst@linux.intel.com, josh@joshtriplett.org, jglisse@redhat.com, robh+dt@kernel.org, seanpaul@chromium.org, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, jonathan.derrick@intel.com, chris@zankel.net, monstr@monstr.eu, linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, fengguang.wu@intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Thu 19-07-18 23:17:53, Baoquan He wrote:
> Kexec has been a formal feature in our distro, and customers owning
> those kind of very large machine can make use of this feature to speed
> up the reboot process. On uefi machine, the kexec_file loading will
> search place to put kernel under 4G from top to down. As we know, the
> 1st 4G space is DMA32 ZONE, dma, pci mmcfg, bios etc all try to consume
> it. It may have possibility to not be able to find a usable space for
> kernel/initrd. From the top down of the whole memory space, we don't
> have this worry. 

I do not have the full context here but let me note that you should be
careful when doing top-down reservation because you can easily get into
hotplugable memory and break the hotremove usecase. We even warn when
this is done. See memblock_find_in_range_node
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
