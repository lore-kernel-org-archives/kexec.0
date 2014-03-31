Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUZbR-0004Kb-5u
 for kexec@lists.infradead.org; Mon, 31 Mar 2014 10:38:06 +0000
Date: Mon, 31 Mar 2014 12:37:42 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Message-ID: <20140331123742.21beb21a@hananiah.suse.cz>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, 31 Mar 2014 09:48:05 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

>[...]
> 
> In the first place, we shouldn't truncate max_mapnr
> based on dom0's mem_section since there are some domU's
> memories on Xen dumps. Now, I think a better way for Xen
> is just leaving max_mapnr as it is.
> 
> Do you agree with my view ?

Definitely! For Xen, info->max_mapnr gives the maximum machine PFN
(ie. it corresponds to total memory installed in the machine).

The data in mem_section describes Dom0 kernel memory map (and gets
initialized from info->dom0_mapnr). It may be substantially smaller
than info->max_mapnr...

A "clean" solution would be to change info->max_mapnr so that it always
gives the maximum physical PFN, but that doesn't fly very well in
practice, because memory bitmaps and other stuff must still be sized
according to the number of machine PFNs, so I would have to add special
cases all around the place...

OTOH, Michal's patch is still neded to fix non-Xen non-cyclic dumps.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
