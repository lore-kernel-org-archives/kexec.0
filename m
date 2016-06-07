Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bA8Y7-0008TA-90
 for kexec@lists.infradead.org; Tue, 07 Jun 2016 04:23:33 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH V7] makedumpfile: exclude page structures of non-dumped
 pages
Date: Tue, 7 Jun 2016 04:18:03 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E49B77@BPXM01GP.gisp.nec.co.jp>
References: <20151026142012.E8F891386E2F@asylum.americas.sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E45A3E@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E45A3E@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>If the pgd entry is null, the code below will try to read 0x0.
>This behavior will cause unexpected results, especially if pfn:0 is on
>memory hole.
>I think null pgd (and pud) entries should be skipped, how about you ?
>I would like you to post the bug fix if you have no objection.

For v1.6.0, I fixed this issue with the patch below.
If you notice something is wrong, please let me know that.

--
Author: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Date:   Thu May 26 15:49:59 2016 +0900

    [PATCH] Skip null entries to walk page tables correctly

    If there is a null page table entry, the current code try
    to read 0x0 for -e option as lower page table although it
    should be skipped. This behavior will cause unexpected results.
    Especially if pfn:0 is on a memory hole or excluded, this
    feature will be disabled completely.

    Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

diff --git a/arch/x86_64.c b/arch/x86_64.c
index c51e26e..ddf7be6 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -537,6 +537,8 @@ find_vmemmap_x86_64()
                }
                /* mask the pgd entry for the address of the pud page */
                pud_addr &= PMASK;
+               if (pud_addr == 0)
+                         continue;
                /* read the entire pud page */
                if (!readmem(PADDR, (unsigned long long)pud_addr, (void *)pud_page,
                                        PTRS_PER_PUD * sizeof(unsigned long))) {
@@ -549,6 +551,8 @@ find_vmemmap_x86_64()
                                        pudindex < PTRS_PER_PUD; pudindex++, pudp++) {
                        pmd_addr = *pudp & PMASK;
                        /* read the entire pmd page */
+                       if (pmd_addr == 0)
+                               continue;
                        if (!readmem(PADDR, pmd_addr, (void *)pmd_page,
                                        PTRS_PER_PMD * sizeof(unsigned long))) {
                                ERRMSG("Can't get pud entry for slot %ld.\n", pudindex);

Thanks,
Atsushi Kumagai

>
>>>+		/* read the entire pud page */
>>>+		if (!readmem(PADDR, (unsigned long long)pud_addr, (void *)pud_page,
>>>+					PTRS_PER_PUD * sizeof(unsigned long))) {
>>>+			ERRMSG("Can't get pud entry for pgd slot %ld.\n", pgdindex);
>>>+			return FAILED;
>>>+		}
>>>+		/* step thru each pmd address in the pud page */
>>>+		/* pudp points to an entry in the pud page */
>>>+		for (pudp = (unsigned long *)pud_page, pudindex = 0;
>>>+					pudindex < PTRS_PER_PUD; pudindex++, pudp++) {
>>>+			pmd_addr = *pudp & PMASK;
>>>+			/* read the entire pmd page */
>>>+			if (!readmem(PADDR, pmd_addr, (void *)pmd_page,
>>>+					PTRS_PER_PMD * sizeof(unsigned long))) {
>>>+				ERRMSG("Can't get pud entry for slot %ld.\n", pudindex);
>>>+				return FAILED;
>>>+			}
>>>+			/* pmdp points to an entry in the pmd */
>>>+			for (pmdp = (unsigned long *)pmd_page, pmdindex = 0;
>>>+					pmdindex < PTRS_PER_PMD; pmdindex++, pmdp++) {
>>>+				/* linear page position in this page table: */
>>>+				pmd = *pmdp;
>>>+				num_pmds++;
>>>+				tpfn = (pvaddr - VMEMMAP_START) /
>>>+							pagestructsize;
>>>+				if (tpfn >= high_pfn) {
>>>+					done = 1;
>>>+					break;
>>>+				}
>>>+				/*
>>>+				 * vmap_offset_start:
>>>+				 * Starting logical position in the
>>>+				 * vmemmap array for the group stays
>>>+				 * constant until a hole in the table
>>>+				 * or a break in contiguousness.
>>>+				 */
>>>+
>>>+				/*
>>>+				 * Ending logical position in the
>>>+				 * vmemmap array:
>>>+				 */
>>>+				vmap_offset_end += hugepagesize;
>>>+				do_break = 0;
>>>+				break_in_valids = 0;
>>>+				break_after_invalids = 0;
>>>+				/*
>>>+				 * We want breaks either when:
>>>+				 * - we hit a hole (invalid)
>>>+				 * - we discontiguous page is a string of valids
>>>+				 */
>>>+				if (pmd) {
>>>+					data_addr = (pmd & PMASK);
>>>+					if (start_range) {
>>>+						/* first-time kludge */
>>>+						start_data_addr = data_addr;
>>>+						last_data_addr = start_data_addr
>>>+							 - hugepagesize;
>>>+						start_range = 0;
>>>+					}
>>>+					if (last_invalid) {
>>>+						/* end of a hole */
>>>+						start_data_addr = data_addr;
>>>+						last_data_addr = start_data_addr
>>>+							 - hugepagesize;
>>>+						/* trigger update of offset */
>>>+						do_break = 1;
>>>+					}
>>>+					last_valid = 1;
>>>+					last_invalid = 0;
>>>+					/*
>>>+					 * we have a gap in physical
>>>+					 * contiguousness in the table.
>>>+					 */
>>>+					/* ?? consecutive holes will have
>>>+					   same data_addr */
>>>+					if (data_addr !=
>>>+						last_data_addr + hugepagesize) {
>>>+						do_break = 1;
>>>+						break_in_valids = 1;
>>>+					}
>>>+					DEBUG_MSG("valid: pud %ld pmd %ld pfn %#lx"
>>>+						" pvaddr %#lx pfns %#lx-%lx"
>>>+						" start %#lx end %#lx\n",
>>>+						pudindex, pmdindex,
>>>+						data_addr >> 12,
>>>+						pvaddr, tpfn,
>>>+						tpfn + structsperhpage - 1,
>>>+						vmap_offset_start,
>>>+						vmap_offset_end);
>>>+					num_pmds_valid++;
>>>+					if (!(pmd & _PAGE_PSE)) {
>>>+						printf("vmemmap pmd not huge, abort\n");
>>>+						return FAILED;
>>>+					}
>>>+				} else {
>>>+					if (last_valid) {
>>>+						/* this a hole after some valids */
>>>+						do_break = 1;
>>>+						break_in_valids = 1;
>>>+						break_after_invalids = 0;
>>>+					}
>>>+					last_valid = 0;
>>>+					last_invalid = 1;
>>>+					/*
>>>+					 * There are holes in this sparsely
>>>+					 * populated table; they are 2MB gaps
>>>+					 * represented by null pmd entries.
>>>+					 */
>>>+					DEBUG_MSG("invalid: pud %ld pmd %ld %#lx"
>>>+						" pfns %#lx-%lx start %#lx end"
>>>+						" %#lx\n", pudindex, pmdindex,
>>>+						pvaddr, tpfn,
>>>+						tpfn + structsperhpage - 1,
>>>+						vmap_offset_start,
>>>+						vmap_offset_end);
>>>+				}
>>>+				if (do_break) {
>>>+					/* The end of a hole is not summarized.
>>>+					 * It must be the start of a hole or
>>>+					 * hitting a discontiguous series.
>>>+					 */
>>>+					if (break_in_valids || break_after_invalids) {
>>>+						/*
>>>+						 * calculate that pfns
>>>+						 * represented by the current
>>>+						 * offset in the vmemmap.
>>>+						 */
>>>+						/* page struct even partly on this page */
>>>+						rep_pfn_start = vmap_offset_start /
>>>+							pagestructsize;
>>>+						/* ending page struct entirely on
>>>+ 						   this page */
>>>+						rep_pfn_end = ((vmap_offset_end -
>>>+							hugepagesize) / pagestructsize);
>>>+ 						DEBUG_MSG("vmap pfns %#lx-%lx "
>>>+							"represent pfns %#lx-%lx\n\n",
>>>+							start_data_addr >> PAGESHIFT(),
>>>+							last_data_addr >> PAGESHIFT(),
>>>+							rep_pfn_start, rep_pfn_end);
>>>+						groups++;
>>>+						vmapp = (struct vmap_pfns *)malloc(
>>>+								sizeof(struct vmap_pfns));
>>>+						/* pfn of this 2MB page of page structs */
>>>+						vmapp->vmap_pfn_start = start_data_addr
>>>+									>> PTE_SHIFT;
>>>+						vmapp->vmap_pfn_end = last_data_addr
>>>+									>> PTE_SHIFT;
>>>+						/* these (start/end) are literal pfns
>>>+ 						 * on this page, not start and end+1 */
>>>+						vmapp->rep_pfn_start = rep_pfn_start;
>>>+						vmapp->rep_pfn_end = rep_pfn_end;
>>>+
>>>+						if (!vmaphead) {
>>>+							vmaphead = vmapp;
>>>+							vmapp->next = vmapp;
>>>+							vmapp->prev = vmapp;
>>>+						} else {
>>>+							tail = vmaphead->prev;
>>>+							vmaphead->prev = vmapp;
>>>+							tail->next = vmapp;
>>>+							vmapp->next = vmaphead;
>>>+							vmapp->prev = tail;
>>>+						}
>>>+					}
>>>+
>>>+					/* update logical position at every break */
>>>+					vmap_offset_start =
>>>+						vmap_offset_end - hugepagesize;
>>>+					start_data_addr = data_addr;
>>>+				}
>>>+
>>>+				last_data_addr = data_addr;
>>>+				pvaddr += hugepagesize;
>>>+				/*
>>>+				 * pvaddr is current virtual address
>>>+				 *   eg 0xffffea0004200000 if
>>>+				 *    vmap_offset_start is 4200000
>>>+				 */
>>>+			}
>>>+		}
>>>+		tpfn = (pvaddr - VMEMMAP_START) / pagestructsize;
>>>+		if (tpfn >= high_pfn) {
>>>+			done = 1;
>>>+			break;
>>>+		}
>>>+	}
>>>+	rep_pfn_start = vmap_offset_start / pagestructsize;
>>>+	rep_pfn_end = (vmap_offset_end - hugepagesize) / pagestructsize;
>>>+	DEBUG_MSG("vmap pfns %#lx-%lx represent pfns %#lx-%lx\n\n",
>>>+		start_data_addr >> PAGESHIFT(), last_data_addr >> PAGESHIFT(),
>>>+		rep_pfn_start, rep_pfn_end);
>>>+	groups++;
>>>+	vmapp = (struct vmap_pfns *)malloc(sizeof(struct vmap_pfns));
>>>+	vmapp->vmap_pfn_start = start_data_addr >> PTE_SHIFT;
>>>+	vmapp->vmap_pfn_end = last_data_addr >> PTE_SHIFT;
>>>+	vmapp->rep_pfn_start = rep_pfn_start;
>>>+	vmapp->rep_pfn_end = rep_pfn_end;
>>>+	if (!vmaphead) {
>>>+		vmaphead = vmapp;
>>>+		vmapp->next = vmapp;
>>>+		vmapp->prev = vmapp;
>>>+	} else {
>>>+		tail = vmaphead->prev;
>>>+		vmaphead->prev = vmapp;
>>>+		tail->next = vmapp;
>>>+		vmapp->next = vmaphead;
>>>+		vmapp->prev = tail;
>>>+	}
>>>+	DEBUG_MSG("num_pmds: %d num_pmds_valid %d\n", num_pmds, num_pmds_valid);
>>>+
>>>+	/* transfer the linked list to an array */
>>>+	cur = vmaphead;
>>>+	gvmem_pfns = (struct vmap_pfns *)malloc(sizeof(struct vmap_pfns) * groups);
>>>+	i = 0;
>>>+	do {
>>>+		vmapp = gvmem_pfns + i;
>>>+		vmapp->vmap_pfn_start = cur->vmap_pfn_start;
>>>+		vmapp->vmap_pfn_end = cur->vmap_pfn_end;
>>>+		vmapp->rep_pfn_start = cur->rep_pfn_start;
>>>+		vmapp->rep_pfn_end = cur->rep_pfn_end;
>>>+		cur = cur->next;
>>>+		free(cur->prev);
>>>+		i++;
>>>+	} while (cur != vmaphead);
>>>+	nr_gvmem_pfns = i;
>>>+	return COMPLETED;
>>>+}
>>>+
>>> #endif /* x86_64 */
>>>
>>
>>_______________________________________________
>>kexec mailing list
>>kexec@lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/kexec
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
