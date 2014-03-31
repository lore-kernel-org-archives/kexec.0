Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUbor-0008HK-Vo
 for kexec@lists.infradead.org; Mon, 31 Mar 2014 13:00:07 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 31 Mar 2014 13:59:42 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A7262219005F
 for <kexec@lists.infradead.org>; Mon, 31 Mar 2014 13:59:32 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2VCxQQ849283118
 for <kexec@lists.infradead.org>; Mon, 31 Mar 2014 12:59:26 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2VCxbbP024328
 for <kexec@lists.infradead.org>; Mon, 31 Mar 2014 06:59:37 -0600
Date: Mon, 31 Mar 2014 14:59:33 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Message-ID: <20140331145933.4759ee35@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971FB6BA@BPXM01GP.gisp.nec.co.jp>
References: <20140325171420.6b558576@holzheu>
 <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
 <20140326185426.5e2e5fc4@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FA0EC@BPXM01GP.gisp.nec.co.jp>
 <20140327145441.4c956989@holzheu>
 <20140328120047.24a056ea@hananiah.suse.cz>
 <20140328174622.2896296e@holzheu> <20140328175303.2ed0232a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FB6BA@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "ptesarik@suse.cz" <ptesarik@suse.cz>

On Mon, 31 Mar 2014 09:48:05 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> [snip]
> 
> >> > That's because the bitmap length is calculated in prepare_bitmap_buffer
> >> > using info->max_mapnr, but create_1st_bitmap() still loops over all
> >> > PT_LOAD segments, calling set_bit_on_1st_bitmap() for each PFN. The
> >> > offset may easily fall beyond the bitmap size.
> >>
> >> What about the following patch. It works for me when I specify
> >> the "--non-cyclic" option.
> >>
> >> Michael
> >> ---
> >> [PATCH] makedumpfile: Fix bitmap create for adjusted info->max_mapnr
> >>
> >> If info->max_mapnr has been adjusted, for example because the dumped
> >> system has specified the "mem=" kernel parameter, makedumpfile writes
> >> the following error messages for Xen dumps or when the "--non-cyclic"
> >> option has been specified:
> >>
> >> set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap96s9V8). Success
>                                                                ^^^^^^^^
> This looks confusing, is it an actual message ?
> I suppose it must be "Invalid argument" like Petr's log.

Right, I get "Invalid argument".

No idea from where I pasted "Success" here...

> >>
> >> Fix this and consider "info->max_mapnr" in the create bitmap functions.
> >>
> >> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> >> ---
> >

[snip]

> I found another issue of truncating max_mapnr for Xen.
> 
> The bitmap manages MFN(machine frame number) for Xen
> while __exclude_unnecessary_pages() treats PFN(guest-physical frame number).
> __exclude_unnecessary_pages() expects that all bits of PFNs
> are mapped in the bitmap even if it was reduced by truncated 
> max_mapnr. However, PtoM mapping isn't linear(probably...),
> there is no guarantee that a set of continuous PFNs is mapped
> in a set of continuous MFNs.
> So the actual I/O offset can exceed the bitmap size when the
> bitmap size is reduced.
> 
> In the first place, we shouldn't truncate max_mapnr
> based on dom0's mem_section since there are some domU's
> memories on Xen dumps. Now, I think a better way for Xen
> is just leaving max_mapnr as it is.
> 
> Do you agree with my view ?

I don't know the Xen details so I would leave it to Petr
to answer this question.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
