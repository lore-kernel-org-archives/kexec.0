Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 05/17] arm64, hibernate: check pgd table allocation
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-6-pasha.tatashin@soleen.com>
Message-ID: <ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com>
Date: Fri, 6 Sep 2019 16:17:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-6-pasha.tatashin@soleen.com>
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

On 21/08/2019 19:31, Pavel Tatashin wrote:
> There is a bug in create_safe_exec_page(), when page table is allocated
> it is not checked that table is allocated successfully:
> 
> But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).

If there is a bug, it shouldn't be fixed part way through a series. This makes it
difficult to backport the fix.

Please split this out as an independent patch with a 'Fixes:' tag for the commit that
introduced the bug.


> Another issue,

So this patch does two things? That is rarely a good idea. Again, this makes it difficult
to backport the fix.


> is that phys_to_ttbr() uses an offset in page table instead
> of pgd directly.

If you were going to reuse this, that would be a bug. But because the only page that is
being mapped, is mapped to PAGE_SIZE, all the top bits will be 0. The offset calls are
boiler-plate. It doesn't look intentional, but its harmless.


Please separate out the potential NULL-dereference bits so there is a clean stand-alone
fix that can be sent to the stable trees.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
