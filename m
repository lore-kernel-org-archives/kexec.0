Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 24 Aug 2021 19:05:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v16 00/15] arm64: MMU enabled kexec relocation
Message-ID: <20210824180555.GD623@arm.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com, kernelfans@gmail.com, akpm@linux-foundation.org, madvenka@linux.microsoft.com

Hi Pavel,

This series is still missing reviews from those who understand kexec
better than me.

On Mon, Aug 02, 2021 at 05:53:53PM -0400, Pavel Tatashin wrote:
> Enable MMU during kexec relocation in order to improve reboot performance.
> 
> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs takes a significant portion
> of reboot.
> 
> The reason for slow relocation is because it is done without MMU, and thus
> not benefiting from D-Cache.

The performance improvements are indeed significant on some platforms
(going from 7s to ~40ms), so I think the merging the series is worth it.
Some general questions so I better understand the impact:

- Is the kdump path affected in any way? IIUC that doesn't need any
  relocation but we should also make sure we don't create the additional
  page table unnecessarily (should keep as much memory intact as
  possible). Maybe that's already handled.

- What happens if trans_pgd_create_copy() fails to allocate memory. Does
  it fall back to an MMU-off relocation?

And I presume this series does not introduce any changes to the kexec
tools ABI.

Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
