Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6A6f-0004qN-PU
 for kexec@lists.infradead.org; Mon, 14 Nov 2016 05:47:04 +0000
Received: by mail-pg0-x233.google.com with SMTP id x23so47224138pgx.1
 for <kexec@lists.infradead.org>; Sun, 13 Nov 2016 21:46:40 -0800 (PST)
Date: Mon, 14 Nov 2016 14:55:16 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v27 1/9] memblock: add memblock_cap_memory_range()
Message-ID: <20161114055515.GH381@linaro.org>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
 <20161102045153.12008-1-takahiro.akashi@linaro.org>
 <20161110172720.GB17134@arm.com> <20161111025049.GG381@linaro.org>
 <20161111031903.GB15997@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161111031903.GB15997@arm.com>
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
To: Dennis Chen <dennis.chen@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-mm@kvack.org, james.morse@arm.com, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, nd@arm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On Fri, Nov 11, 2016 at 11:19:04AM +0800, Dennis Chen wrote:
> On Fri, Nov 11, 2016 at 11:50:50AM +0900, AKASHI Takahiro wrote:
> > Will,
> > (+ Cc: Dennis)
> > 
> > On Thu, Nov 10, 2016 at 05:27:20PM +0000, Will Deacon wrote:
> > > On Wed, Nov 02, 2016 at 01:51:53PM +0900, AKASHI Takahiro wrote:
> > > > Add memblock_cap_memory_range() which will remove all the memblock regions
> > > > except the range specified in the arguments.
> > > > 
> > > > This function, like memblock_mem_limit_remove_map(), will not remove
> > > > memblocks with MEMMAP_NOMAP attribute as they may be mapped and accessed
> > > > later as "device memory."
> > > > See the commit a571d4eb55d8 ("mm/memblock.c: add new infrastructure to
> > > > address the mem limit issue").
> > > > 
> > > > This function is used, in a succeeding patch in the series of arm64 kdump
> > > > suuport, to limit the range of usable memory, System RAM, on crash dump
> > > > kernel.
> > > > (Please note that "mem=" parameter is of little use for this purpose.)
> > > > 
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > ---
> > > >  include/linux/memblock.h |  1 +
> > > >  mm/memblock.c            | 28 ++++++++++++++++++++++++++++
> > > >  2 files changed, 29 insertions(+)
> > > > 
> > > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > > index 5b759c9..0e770af 100644
> > > > --- a/include/linux/memblock.h
> > > > +++ b/include/linux/memblock.h
> > > > @@ -334,6 +334,7 @@ phys_addr_t memblock_start_of_DRAM(void);
> > > >  phys_addr_t memblock_end_of_DRAM(void);
> > > >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> > > >  void memblock_mem_limit_remove_map(phys_addr_t limit);
> > > > +void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> > > >  bool memblock_is_memory(phys_addr_t addr);
> > > >  int memblock_is_map_memory(phys_addr_t addr);
> > > >  int memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
> > > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > > index 7608bc3..eb53876 100644
> > > > --- a/mm/memblock.c
> > > > +++ b/mm/memblock.c
> > > > @@ -1544,6 +1544,34 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
> > > >  			      (phys_addr_t)ULLONG_MAX);
> > > >  }
> > > >  
> > > > +void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
> > > > +{
> > > > +	int start_rgn, end_rgn;
> > > > +	int i, ret;
> > > > +
> > > > +	if (!size)
> > > > +		return;
> > > > +
> > > > +	ret = memblock_isolate_range(&memblock.memory, base, size,
> > > > +						&start_rgn, &end_rgn);
> > > > +	if (ret)
> > > > +		return;
> > > > +
> > > > +	/* remove all the MAP regions */
> > > > +	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
> > > > +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> > > > +			memblock_remove_region(&memblock.memory, i);
> > > > +
> > > > +	for (i = start_rgn - 1; i >= 0; i--)
> > > > +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> > > > +			memblock_remove_region(&memblock.memory, i);
> > > > +
> > > > +	/* truncate the reserved regions */
> > > > +	memblock_remove_range(&memblock.reserved, 0, base);
> > > > +	memblock_remove_range(&memblock.reserved,
> > > > +			base + size, (phys_addr_t)ULLONG_MAX);
> > > > +}
> > > 
> > > This duplicates a bunch of the logic in memblock_mem_limit_remove_map. Can
> > > you not implement that in terms of your new, more general, function? e.g.
> > > by passing base == 0, and size == limit?
> > 
> > Obviously it's possible.
> > I actually talked to Dennis before about merging them,
> > but he was against my idea.
> >
> Oops! I thought we have reached agreement in the thread:http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/442817.html
> So feel free to do that as Will'll do

OK, but I found that the two functions have a bit different semantics
in clipping memory range, in particular, when the range [base,base+size)
goes across several regions with a gap.
(This does not happen in my arm64 kdump, though.)
That is, 'limit' in memblock_mem_limit_remove_map() means total size of
available memory, while 'size' in memblock_cap_memory_range() indicates
the size of _continuous_ memory range.

So I added an extra argument, exact, to a common function to specify
distinct behaviors. Confusing? Please see the patch below.

If nobody objects to this merge, I will submit a whole patchset of kdump
again.

Thanks,
-Takahiro AKASHI
===8<===
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 91 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5b759c9..0e770af 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -334,6 +334,7 @@ phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
 void memblock_mem_limit_remove_map(phys_addr_t limit);
+void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
 bool memblock_is_memory(phys_addr_t addr);
 int memblock_is_map_memory(phys_addr_t addr);
 int memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 7608bc3..5f849a9 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1473,9 +1473,10 @@ phys_addr_t __init_memblock memblock_end_of_DRAM(void)
 	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
 }
 
-static phys_addr_t __init_memblock __find_max_addr(phys_addr_t limit)
+static phys_addr_t __init_memblock __find_max_addr(phys_addr_t min,
+							phys_addr_t limit)
 {
-	phys_addr_t max_addr = (phys_addr_t)ULLONG_MAX;
+	phys_addr_t max_addr = (phys_addr_t)ULLONG_MAX, base, size;
 	struct memblock_region *r;
 
 	/*
@@ -1484,11 +1485,22 @@ static phys_addr_t __init_memblock __find_max_addr(phys_addr_t limit)
 	 * of those regions, max_addr will keep original value ULLONG_MAX
 	 */
 	for_each_memblock(memory, r) {
-		if (limit <= r->size) {
-			max_addr = r->base + limit;
+		if (min >= r->base + r->size)
+			continue;
+
+		if (r->base <= min) {
+			base = min;
+			size = r->base + r->size - min;
+		} else {
+			base = r->base;
+			size = r->size;
+		}
+
+		if (limit <= size) {
+			max_addr = base + limit;
 			break;
 		}
-		limit -= r->size;
+		limit -= size;
 	}
 
 	return max_addr;
@@ -1501,7 +1513,7 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 	if (!limit)
 		return;
 
-	max_addr = __find_max_addr(limit);
+	max_addr = __find_max_addr(0, limit);
 
 	/* @limit exceeds the total size of the memory, do nothing */
 	if (max_addr == (phys_addr_t)ULLONG_MAX)
@@ -1514,34 +1526,65 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 			      (phys_addr_t)ULLONG_MAX);
 }
 
-void __init memblock_mem_limit_remove_map(phys_addr_t limit)
+/*
+ * __memblock_cap_memory_range - cap memblock regions
+ * @base: lowest address to clip
+ * @size: size of memory range
+ * @exact: true or false
+ *
+ * If @exact is true, the exact range [@base, @base+@size) of memory with
+ * kernel direct mapping is clipped from memblock.memory. Otherwise, total
+ * of @size of memory is clipped starting from @base.
+ */
+static void __init __memblock_cap_memory_range(phys_addr_t base,
+					phys_addr_t size, bool exact)
 {
-	struct memblock_type *type = &memblock.memory;
-	phys_addr_t max_addr;
-	int i, ret, start_rgn, end_rgn;
+	int start_rgn, end_rgn;
+	int i, ret;
 
-	if (!limit)
+	if (!size)
 		return;
 
-	max_addr = __find_max_addr(limit);
+	if (!exact) {
+		phys_addr_t max_addr;
 
-	/* @limit exceeds the total size of the memory, do nothing */
-	if (max_addr == (phys_addr_t)ULLONG_MAX)
-		return;
+		max_addr = __find_max_addr(base, size);
+		/* @size exceeds the total size of the memory, do nothing */
+		if (max_addr == (phys_addr_t)ULLONG_MAX)
+			return;
+
+		/* recalc the size to clip the exact range [@base, max_addr) */
+		size = max_addr  - base;
+	}
 
-	ret = memblock_isolate_range(type, max_addr, (phys_addr_t)ULLONG_MAX,
-				&start_rgn, &end_rgn);
+	ret = memblock_isolate_range(&memblock.memory, base, size,
+						&start_rgn, &end_rgn);
 	if (ret)
 		return;
 
-	/* remove all the MAP regions above the limit */
-	for (i = end_rgn - 1; i >= start_rgn; i--) {
-		if (!memblock_is_nomap(&type->regions[i]))
-			memblock_remove_region(type, i);
-	}
+	/* remove all the other MAP regions */
+	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	for (i = start_rgn - 1; i >= 0; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
 	/* truncate the reserved regions */
-	memblock_remove_range(&memblock.reserved, max_addr,
-			      (phys_addr_t)ULLONG_MAX);
+	memblock_remove_range(&memblock.reserved, 0, base);
+	memblock_remove_range(&memblock.reserved,
+			base + size, (phys_addr_t)ULLONG_MAX);
+}
+
+void __init memblock_mem_limit_remove_map(phys_addr_t limit)
+{
+	__memblock_cap_memory_range(0, limit, false);
+}
+
+void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
+{
+	__memblock_cap_memory_range(base, size, true);
 }
 
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
-- 
2.10.0

===>8===

> > 
> > Thanks,
> > -Takahiro AKASHI
> > 
> > > Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
