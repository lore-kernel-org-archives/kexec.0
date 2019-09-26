Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDYkH-00048A-Ov
 for kexec@lists.infradead.org; Thu, 26 Sep 2019 18:44:07 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: Fix divide by zero in print_report()
Date: Thu, 26 Sep 2019 18:41:48 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0359079B@BPXM09GP.gisp.nec.co.jp>
References: <20190924194005.GA7666@codemonkey.org.uk>
In-Reply-To: <20190924194005.GA7666@codemonkey.org.uk>
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

Hi Dave,

> -----Original Message-----
> If info->max_mapnr and pfn_memhole are equal, we divide by zero when
> trying determine the 'shrinking' value.
> 
> On the system I saw this error, we arrived at this function with
> info->max_mapnr:0x0000000001080000 pfn_memhole:0x0000000001080000

Thank you for the patch.
I suppose that you see the error with the -E option, right?

It seems that the -E option has some problems with its statistics,
so I'm checking whether there is a better way to fix this.

Thanks,
Kazu

> 
> Change the code to only print out the shrinking value if it makes sense.
> 
> Signed-off-by: Dave Jones <davej@codemonkey.org.uk>
> 
> diff -wbBdu -urN makedumpfile-1.6.6/makedumpfile.c src/makedumpfile-code/makedumpfile.c
> --- makedumpfile-1.6.6/makedumpfile.c	2019-06-27 08:42:40.000000000 -0400
> +++ makedumpfile-code/makedumpfile.c	2019-09-24 15:28:06.456549495 -0400
> @@ -9778,8 +9778,6 @@
> 
>  	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
>  	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
> -	shrinking = (pfn_original - pfn_excluded) * 100;
> -	shrinking = shrinking / pfn_original;
> 
>  	REPORT_MSG("\n");
>  	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
> @@ -9794,8 +9792,13 @@
>  	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
>  	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
>  	    pfn_original - pfn_excluded);
> -	REPORT_MSG("  (The number of pages is reduced to %lld%%.)\n",
> -	    shrinking);
> +
> +	if (pfn_original != 0) {
> +		shrinking = (pfn_original - pfn_excluded) * 100;
> +		shrinking = shrinking / pfn_original;
> +		REPORT_MSG("  (The number of pages is reduced to %lld%%.)\n",
> +		    shrinking);
> +	}
>  	REPORT_MSG("Memory Hole     : 0x%016llx\n", pfn_memhole);
>  	REPORT_MSG("--------------------------------------------------\n");
>  	REPORT_MSG("Total pages     : 0x%016llx\n", info->max_mapnr);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
