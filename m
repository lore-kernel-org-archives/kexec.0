Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUqx1-0007JT-JA
 for kexec@lists.infradead.org; Tue, 01 Apr 2014 05:09:33 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Date: Tue, 1 Apr 2014 05:06:33 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FBB75@BPXM01GP.gisp.nec.co.jp>
References: <20140325171420.6b558576@holzheu>
 <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
 <20140326185426.5e2e5fc4@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FA0EC@BPXM01GP.gisp.nec.co.jp>
 <20140327145441.4c956989@holzheu> <20140328120047.24a056ea@hananiah.suse.cz>
 <20140328174622.2896296e@holzheu> <20140328175303.2ed0232a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FB6BA@BPXM01GP.gisp.nec.co.jp>
 <20140331123742.21beb21a@hananiah.suse.cz>
In-Reply-To: <20140331123742.21beb21a@hananiah.suse.cz>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "ptesarik@suse.cz" <ptesarik@suse.cz>, "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

[...]
>>
>> In the first place, we shouldn't truncate max_mapnr
>> based on dom0's mem_section since there are some domU's
>> memories on Xen dumps. Now, I think a better way for Xen
>> is just leaving max_mapnr as it is.
>>
>> Do you agree with my view ?
>
>Definitely! For Xen, info->max_mapnr gives the maximum machine PFN
>(ie. it corresponds to total memory installed in the machine).
>
>The data in mem_section describes Dom0 kernel memory map (and gets
>initialized from info->dom0_mapnr). It may be substantially smaller
>than info->max_mapnr...

Thanks for your confirming.

>A "clean" solution would be to change info->max_mapnr so that it always
>gives the maximum physical PFN, but that doesn't fly very well in
>practice, because memory bitmaps and other stuff must still be sized
>according to the number of machine PFNs, so I would have to add special
>cases all around the place...

I don't know how to capture a dump on Xen well, so do you have any idea
how to produce the difference between actual memory regions and the ELF
header like the s390 case ?
If it isn't possible, we don't need to change info->max_mapnr since the
value calculated from the ELF header must be correct.

>OTOH, Michal's patch is still neded to fix non-Xen non-cyclic dumps.

Yes, the fix for create_1st_bitmap() is still necessary.

Michael, could you fix your patch ? We need to add the conditional
check for Xen like below:

+	if (!is_xen_memory()) {
+	       for (i = 0; i < info->num_mem_map; i++) {
+   	            if (info->mem_map_data[i].mem_map == NOT_MEMMAP_ADDR)
+       	                continue;
+           	    max_pfn = MAX(max_pfn, info->mem_map_data[i].pfn_end);
+       	}
+       	info->max_mapnr = MIN(info->max_mapnr, max_pfn);
+	}


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
