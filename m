Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KfG16-0004ny-0j
	for kexec@lists.infradead.org; Mon, 15 Sep 2008 15:29:36 +0000
Message-ID: <48CE7E33.6040601@redhat.com>
Date: Mon, 15 Sep 2008 11:24:35 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com> <20080911143226.GT29908@sgi.com>
	<48C9D22A.5010404@mxs.nes.nec.co.jp> <48CA70CD.2090500@sgi.com>
	<48CAC7DB.4090904@sgi.com> <48CAD340.7000701@redhat.com>
	<48CAEB6A.8080405@sgi.com>
In-Reply-To: <48CAEB6A.8080405@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0104749222=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org, Hedi Berriche <hedi@sgi.com>

--===============0104749222==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Jay Lan wrote:
> Dave Anderson wrote:
> 
>>Try using at least -d4 and redirect the output to a file.  It's much
>>more verbose than the above, but it shows every readmem() made from
>>the dumpfile:
>>
>> # crash -d4 vmlinux vmcore.cp > /tmp/debug.cp
>> q
>> # crash -d4 vmlinux vmcore.makedumpfile > /tmp/debug.makedumpfile
>> q
>> #
>>
>>Then compare the two outputs -- they should be pretty much identical
>>(except for any crash utility user addresses) until the vmcore.makedumpfile
>>fails.  So you should see a successful readmem() of e0000060031417a8 in
>>the "vmcore.cp" debug output at the point where it fails doing the
>>read in "vmcore.makedumpfile" above.
>>
>>What's kind of strange is that pglist_data.node_zones structure that
>>it's reading from is in the same page as the base pglist_data
>>at e000006003140000, i.e., at page offset 17a8 (6056).  And the code
>>looks like it has already read data from that same page prior to
>>reading the "zone spanned pages".  (I'm presuming that the ia64 page
>>size you're using is greater than 4k).  But the -d4 output will
>>confirm that.
> 
> 
> Looks like it.
> 
> In the case of 'cp':
> ...
> <readmem: a0000001010be338, KVADDR, "pgdat_list", 8, (ROE),
> 600fffffff8abfc0>
> <readmem: e00000600315fb70, KVADDR, "pglist node_id", 4, (FOE),
> 600fffffff8ac01c>
>                         <readmem: e00000600315fb48, KVADDR,
> "node_mem_map", 8, (FOE), 600fffffff8ac020>
> <readmem: e00000600315fb58, KVADDR, "pglist node_start_pfn", 8, (FOE),
> 600fffffff8ac030>
> <readmem: e00000600315fb68, KVADDR, "pglist node_spanned_pages", 8,
> (FOE), 600fffffff8ac040>
> <readmem: e00000600315fb60, KVADDR, "pglist node_present_pages", 8,
> (FOE), 600fffffff8ac048>
> <readmem: e00000600315fb50, KVADDR, "pglist bdata", 8, (FOE),
> 600fffffff8ac090> node_table[0]:
>              id: 0
> 
>           pgdat: e000006003140000
>            size: 62720
> 
>         present: 62720
>         mem_map: a07ffff8fdd0a800
> 
>     start_paddr: 6003000000
>     start_mapnr: 6292224
> 
> <readmem: e0000060031417a8, KVADDR, "zone spanned_pages", 8, (FOE),
> 600fffffff8ac058>
>                     <readmem: e0000060031416c8, KVADDR, "zone[_struct]
> free_pages", 8, (FOE), 600fffffff8ac050>
> 
> ...
> 
> 
> In the case of makedumpfile:
> ...
> <readmem: a0000001010be338, KVADDR, "pgdat_list", 8, (ROE),
> 600ffffffff4bfb0>
> <readmem: e00000600315fb70, KVADDR, "pglist node_id", 4, (FOE),
> 600ffffffff4c00c>
> <readmem: e00000600315fb48, KVADDR, "node_mem_map", 8, (FOE),
> 600ffffffff4c010>
> <readmem: e00000600315fb58, KVADDR, "pglist node_start_pfn", 8, (FOE),
> 600ffffffff4c020>
> <readmem: e00000600315fb68, KVADDR, "pglist node_spanned_pages", 8,
> (FOE), 600ffffffff4c030>
> <readmem: e00000600315fb60, KVADDR, "pglist node_present_pages", 8,
> (FOE), 600ffffffff4c038>
> <readmem: e00000600315fb50, KVADDR, "pglist bdata", 8, (FOE),
> 600ffffffff4c080> node_table[0]:
>              id: 0
> 
>           pgdat: e000006003140000
>            size: 62720
> 
>         present: 62720
>         mem_map: a07ffff8fdd0a800
> 
>     start_paddr: 6003000000
>     start_mapnr: 6292224
> 
> <readmem: e0000060031417a8, KVADDR, "zone spanned_pages", 8, (FOE),
> 600ffffffff4c048>
> crash: page excluded: kernel virtual address: e0000060031417a8  type:
> "zone spanned_pages"
> 

Ok, so it was the first reference/read of that page, which was excluded
from the makedumpfile-generated dumpfile, so my "kind of strange" blather
was irrelevant.

Anyway, it may or may not help your cause, but the "crash --minimal ..."
command line option that the IBM guys added may be helpful in verifying/tracking
down which pages of memory were excluded from the dumpfile.  One of the few
commands available in "minimal-mode" is "rd".

Dave




--===============0104749222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0104749222==--
