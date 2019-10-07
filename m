Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHZOw-0007iG-OK
 for kexec@lists.infradead.org; Mon, 07 Oct 2019 20:14:40 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: Fix divide by zero in print_report()
Date: Mon, 7 Oct 2019 20:13:07 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0359146E@BPXM09GP.gisp.nec.co.jp>
References: <20190924194005.GA7666@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359079B@BPXM09GP.gisp.nec.co.jp>
 <20190926193253.GA10258@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035909ED@BPXM09GP.gisp.nec.co.jp>
 <20191004170357.GA12416@codemonkey.org.uk>
In-Reply-To: <20191004170357.GA12416@codemonkey.org.uk>
Content-Language: en-US
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
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> On Fri, Sep 27, 2019 at 08:39:04PM +0000, Kazuhito Hagio wrote:
>  > > -----Original Message-----
>  > > On Thu, Sep 26, 2019 at 06:41:48PM +0000, Kazuhito Hagio wrote:
>  > >
>  > >  > > -----Original Message-----
>  > >  > > If info->max_mapnr and pfn_memhole are equal, we divide by zero when
>  > >  > > trying determine the 'shrinking' value.
>  > >  > >
>  > >  > > On the system I saw this error, we arrived at this function with
>  > >  > > info->max_mapnr:0x0000000001080000 pfn_memhole:0x0000000001080000
>  > >  >
>  > >  > Thank you for the patch.
>  > >  > I suppose that you see the error with the -E option, right?
>  > >  >
>  > >  > It seems that the -E option has some problems with its statistics,
>  > >  > so I'm checking whether there is a better way to fix this.
>  > >
>  > > Yes, we use the -E option.
>  > > We manage to get useful info from the generated dump after this fix, so
>  > > it seems it only affects the statistics output.
>  >
>  > OK, the statistics in cyclic mode with the -E option is completely wrong
>  > but a possible fix is likely to affect the whole of cyclic processing, so
>  > I just cover the hole with your patch and leave the statistics problem as
>  > a known issue at this time.  I would revisit it when I have time.
>  >
>  > The patch was applied to the devel branch.
> 
> While this patch does avoid the divide by zero, some further analysis
> shows that there seems to be some deeper problem when we encounter this
> 'original pages = 0' situation.
> 
> Take a look at the attached output from makedumpfile.
> 
> Key part in the summary:
> 
> [  518.819690] Original pages  : 0x0000000000000000
> [  518.828894]   Excluded pages   : 0x0000000003decd15
> [  518.838635]     Pages filled with zero  : 0x00000000000210ee
> [  518.849920]     Non-private cache pages : 0x000000000000271a
> [  518.861218]     Private cache pages     : 0x000000000000da47
> [  518.872502]     User process data pages : 0x0000000003d6bdc8
> [  518.883786]     Free pages              : 0x000000000004fcfe
> [  518.895070]     Hwpoison pages          : 0x0000000000000000
> [  518.906356]     Offline pages           : 0x0000000000000000
> [  518.917659]   Remaining pages  : 0xfffffffffc2132eb
> [  518.927398] Memory Hole     : 0x0000000004080000
> 
> In this case, 'remaining pages' has gone negative which looks concerning.

This is the known issue that I wrote above and am looking for a safe fix.
How does this patch work?

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -56,6 +56,9 @@ static void first_cycle(mdf_pfn_t start, mdf_pfn_t max, struct cycle *cycle)
	if (cycle->end_pfn > max)
		cycle->end_pfn = max;
 
+	if (cycle->start_pfn < start)
+		cycle->start_pfn = start;
+
	cycle->exclude_pfn_start = 0;
	cycle->exclude_pfn_end = 0;
 }
@@ -7595,6 +7598,9 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
			}
 
			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
+				if (info->flag_cyclic)
+					pfn_memhole--;
+
				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
					num_excluded++;
					if ((pfn == pfn_end - 1) && frac_tail)

If it looks good, I'll look into its side effects further,
but might take some time..

> 
> And the crashdump seems corrupt:
> 
> 'crash' complains:
> WARNING: possibly corrupt Elf64_Nhdr: n_namesz: 2079035392 n_descsz: 3 n_type: 1000
> 
> vmcore-dmesg complains "Missing the log_buf symbol", even though the makedumpfile log
> shows it was present at ffffffff822510a0
> 
> Readelf seems to think the notes sections are mangled.
> 
> # readelf -n vmcore
> 
> Displaying notes found at file offset 0x00015468 with length 0x0000556c:
>   Owner                 Data size       Description
>                        0x00000007       Unknown note type: (0x727c79d4)
> readelf: vmcore: Warning: Corrupt note: name size is too big: 7beb9000
>   (NONE)               0x00000003       Unknown note type: (0x00001000)
> readelf: vmcore: Warning: Corrupt note: name size is too big: 55a000
>   (NONE)               0x00000000       Unknown note type: (0x00000000)
>   (NONE)               0x00000001       Unknown note type: (0x00000007)
> readelf: vmcore: Warning: note with invalid namesz and/or descsz found at offset 0x44
> readelf: vmcore: Warning:  type: 0xffff8803, namesize: 0x00000000, descsize: 0x7c413000

I don't think that the statistics issue corrupts a dumpfile itself
so far.  Could you show me the output of "readelf -a vmcore"?
Does this issue always reproduce?

Thanks,
Kazu

> 
> 
> 
> Any thoughts on where to add additional debugging in makedumpfile ?
> 
> 	Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
