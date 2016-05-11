Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 11 May 2016 16:29:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 00/12] Fixing TI Keystone2 kexec
Message-ID: <20160511082923.GC8995@dhcp-128-65.nay.redhat.com>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160428092644.GX19428@n2100.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

Hi, Russell

On 04/28/16 at 10:26am, Russell King - ARM Linux wrote:
> These changes are required for TI Keystone2 kexec to be functional.  TI
> Keystone2 has the run-time view of physical memory above 4GiB, but with
> a boot time alias below 4GiB which can only be used during the early
> boot.
> 
> This means we need to translate run-time physical addresses (which the
> kernel uses) to boot-time physical addresses, which, having discussed
> with Eric, is what the kexec tools and kexec kernel API requires.
> 
> We publish a special set of boot time resources in /proc/iomem, which
> the (modified) kexec tools look for in preference to the normal resources.
> Hence, if these are found, the kexec tools make use of these resources,
> and thus kexec tools use the boot-time view of physical memory.

I think getting memory ranges from device tree will be better than
adding more stuff to /proc/iomem. Geoff's arm64 kexec patches is using dtb
you can refer to the patchset.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
