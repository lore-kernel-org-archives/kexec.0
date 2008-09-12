Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KeH1x-0006Qh-8W
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 22:22:21 +0000
Message-ID: <48CAEB6A.8080405@sgi.com>
Date: Fri, 12 Sep 2008 15:21:30 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com> <20080911143226.GT29908@sgi.com>
	<48C9D22A.5010404@mxs.nes.nec.co.jp> <48CA70CD.2090500@sgi.com>
	<48CAC7DB.4090904@sgi.com> <48CAD340.7000701@redhat.com>
In-Reply-To: <48CAD340.7000701@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0207825806=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org, Hedi Berriche <hedi@sgi.com>

--===============0207825806==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Dave Anderson wrote:
> Try using at least -d4 and redirect the output to a file.  It's much
> more verbose than the above, but it shows every readmem() made from
> the dumpfile:
> 
>  # crash -d4 vmlinux vmcore.cp > /tmp/debug.cp
>  q
>  # crash -d4 vmlinux vmcore.makedumpfile > /tmp/debug.makedumpfile
>  q
>  #
> 
> Then compare the two outputs -- they should be pretty much identical
> (except for any crash utility user addresses) until the vmcore.makedumpfile
> fails.  So you should see a successful readmem() of e0000060031417a8 in
> the "vmcore.cp" debug output at the point where it fails doing the
> read in "vmcore.makedumpfile" above.
> 
> What's kind of strange is that pglist_data.node_zones structure that
> it's reading from is in the same page as the base pglist_data
> at e000006003140000, i.e., at page offset 17a8 (6056).  And the code
> looks like it has already read data from that same page prior to
> reading the "zone spanned pages".  (I'm presuming that the ia64 page
> size you're using is greater than 4k).  But the -d4 output will
> confirm that.

Looks like it.

In the case of 'cp':
...
<readmem: a0000001010be338, KVADDR, "pgdat_list", 8, (ROE),
600fffffff8abfc0>
<readmem: e00000600315fb70, KVADDR, "pglist node_id", 4, (FOE),
600fffffff8ac01c>
                        <readmem: e00000600315fb48, KVADDR,
"node_mem_map", 8, (FOE), 600fffffff8ac020>
<readmem: e00000600315fb58, KVADDR, "pglist node_start_pfn", 8, (FOE),
600fffffff8ac030>
<readmem: e00000600315fb68, KVADDR, "pglist node_spanned_pages", 8,
(FOE), 600fffffff8ac040>
<readmem: e00000600315fb60, KVADDR, "pglist node_present_pages", 8,
(FOE), 600fffffff8ac048>
<readmem: e00000600315fb50, KVADDR, "pglist bdata", 8, (FOE),
600fffffff8ac090> node_table[0]:
             id: 0

          pgdat: e000006003140000
           size: 62720

        present: 62720
        mem_map: a07ffff8fdd0a800

    start_paddr: 6003000000
    start_mapnr: 6292224

<readmem: e0000060031417a8, KVADDR, "zone spanned_pages", 8, (FOE),
600fffffff8ac058>
                    <readmem: e0000060031416c8, KVADDR, "zone[_struct]
free_pages", 8, (FOE), 600fffffff8ac050>

...


In the case of makedumpfile:
...
<readmem: a0000001010be338, KVADDR, "pgdat_list", 8, (ROE),
600ffffffff4bfb0>
<readmem: e00000600315fb70, KVADDR, "pglist node_id", 4, (FOE),
600ffffffff4c00c>
<readmem: e00000600315fb48, KVADDR, "node_mem_map", 8, (FOE),
600ffffffff4c010>
<readmem: e00000600315fb58, KVADDR, "pglist node_start_pfn", 8, (FOE),
600ffffffff4c020>
<readmem: e00000600315fb68, KVADDR, "pglist node_spanned_pages", 8,
(FOE), 600ffffffff4c030>
<readmem: e00000600315fb60, KVADDR, "pglist node_present_pages", 8,
(FOE), 600ffffffff4c038>
<readmem: e00000600315fb50, KVADDR, "pglist bdata", 8, (FOE),
600ffffffff4c080> node_table[0]:
             id: 0

          pgdat: e000006003140000
           size: 62720

        present: 62720
        mem_map: a07ffff8fdd0a800

    start_paddr: 6003000000
    start_mapnr: 6292224

<readmem: e0000060031417a8, KVADDR, "zone spanned_pages", 8, (FOE),
600ffffffff4c048>
crash: page excluded: kernel virtual address: e0000060031417a8  type:
"zone spanned_pages"



jay

> 
> Dave
> 
> 



--===============0207825806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0207825806==--
