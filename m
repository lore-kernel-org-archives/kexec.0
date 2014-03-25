Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSTE8-0008CS-Qb
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 15:25:22 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 25 Mar 2014 15:24:57 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D11261B08070
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 15:24:47 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2PFOhWp459168
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 15:24:43 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2PFOsSo029957
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 09:24:54 -0600
Date: Tue, 25 Mar 2014 16:24:52 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: makedumpfile: get_max_mapnr() from ELF header problem
Message-ID: <20140325162452.792f5ad4@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971F909B@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu> <531FDF6D.5080901@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
 <20140312171812.02f0bfe1@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F672F@BPXM01GP.gisp.nec.co.jp>
 <20140314151928.5c49f17f@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F7B95@BPXM01GP.gisp.nec.co.jp>
 <20140319180903.2c6e2b72@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F909B@BPXM01GP.gisp.nec.co.jp>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, 25 Mar 2014 01:14:21 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

[snip]

> >But it looks like get_mm_sparsemem() does not check for zero.
> >The nr_to_section() function just returns an invalid address
> >(something between 0 and 4096) for section in case we get zero
> >from the "mem_section" entry. This is address is then used for
> >calculating "mem_map":
> 
> In other architectures, the check by is_kaddr() avoids to
> read invalid address, but it doesn't do anything in the case
> of s390 due to the its memory management mechanism:
> 
> s390x: Fix KVBASE to correct value for	s390x architecture.
> http://lists.infradead.org/pipermail/kexec/2011-March/004930.html

Right, for s390 the zero page is valid.
 
> Finally I've understood the cause of this issue completely,
> thanks for your report.
> 
> >mem_map = section_mem_map_addr(section);
> >mem_map = sparse_decode_mem_map(mem_map, section_nr);
> >
> >With the patch below I could use makedumpfile (1.5.3) successfully
> >on the 1TB dump with mem=1G. I attached the -D output that is
> >created by makedumpfile with the patch.
> >
> >But compared to my first patch it takes much longer and the resulting
> >dump is bigger (version 1.5.3):
> >
> >             | Dump time   | Dump size
> >-------------+-------------+-----------
> >First patch  |  10 sec     |  124 MB
> >Second patch |  87 minutes | 6348 MB
> >
> >No idea why the dump is bigger with the second patch. I think the time
> >is consumed in write_kdump_pages_cyclic() by checking for zero pages
> >for the whole range:
> 
> I suppose this difference was resolved with the v2 of the second patch,
> right?

Right, with the last patch the dump time and size were ok.

[snip]

> >So the first patch would be better for my scenario. What in particular are your
> >concerns with that patch?
> 
> I think the v2 second patch is a reasonable patch to fix the
> bug of get_mm_sparsemem().
> Additionally, the latest patch you posted to adjust max_mapnr
> (which using mem_map_data[]) is acceptable instead of the first
> patch.
> So could you re-post the two as a formal patch set?
> I mean patch descriptions and your signature are needed.

Ok great! I will resend the patches.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
