Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v6 02/17] arm64: hibernate: pass the allocated pgdp to
 ttbr0
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-3-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <bb937db3-f23a-809b-4ad8-ca86f689554d@arm.com>
Date: Fri, 11 Oct 2019 19:17:22 +0100
MIME-Version: 1.0
In-Reply-To: <20191004185234.31471-3-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 04/10/2019 19:52, Pavel Tatashin wrote:
> ttbr0 should be set to the beginning of pgdp, however, currently
> in create_safe_exec_page it is set to pgdp after pgd_offset_raw(),
> which works by accident.
> 
> Fixes: 0194e760f7d2 ("arm64: hibernate: avoid potential TLB conflict")

(That was a 'break before make' fix, the affected code comes from:
 82869ac57b5d (""arm64: kernel: Add support for hibernate/suspend-to-disk))

But, it works in all one circumstances its used: we know all the top bits will be zero.
I agree its by accident and we should fix it.

I don't think we should send it to stable.
Please drop the fixes tag, with that:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James


[0] https://lore.kernel.org/linux-arm-kernel/ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
