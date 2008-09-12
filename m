Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.171.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ke8rZ-0006Ek-KJ
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 13:39:06 +0000
Message-ID: <48CA70CD.2090500@sgi.com>
Date: Fri, 12 Sep 2008 06:38:21 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com> <20080911143226.GT29908@sgi.com>
	<48C9D22A.5010404@mxs.nes.nec.co.jp>
In-Reply-To: <48C9D22A.5010404@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1217505454=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, Hedi Berriche <hedi@sgi.com>

--===============1217505454==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Ken'ichi Ohmichi wrote:
> Hi Hedi, Jay,
> 
> Hedi Berriche wrote:
>> In addition to what other folks have mentioned about giving the latest crash
>> version a try, I'd like to point out that makedumpfile did spit a couple of
>> warnings while creating the vmcore
>>
>>
>> | Can't distinguish the pgtable.
>> | The kernel version is not supported.
>> | The created dumpfile may be incomplete.
>>
>> these warnings added to the fact that later on crash choked with
>>
>> | NOTE: page_hash_table does not exist in this kernel
>> | crash: page excluded: kernel virtual address: e000006003108e00  type:
>>
>> seem to suggest that the makedumpfile warnings could be relevant to the
>> end result.
> 
> Oh, good point.
> If makedumpfile cannot distinguish the pgtable, it guesses PGTABLE_3 and
> creates a dumpfile. If Jay's kernel .config file has CONFIG_PGTABLE_4=y,
> makedumpfile misunderstands the pgtable. If it has CONFIG_PGTABLE_4=y,
> could you please try the attached patch ? This patch is only for debugging,
> and I'll investigate the cause.

My .config uses CONFIG_PGTABLE_3=y.
I will try to build makedumpfile-1.2.9 and report back.

Thanks
jay

> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> ---
> diff -puN backup/makedumpfile-1.2.9/ia64.c makedumpfile/ia64.c
> --- backup/makedumpfile-1.2.9/ia64.c	2008-09-04 16:31:58.000000000 +0900
> +++ makedumpfile/ia64.c	2008-09-12 11:27:38.000000000 +0900
> @@ -79,6 +79,7 @@ get_machdep_info_ia64(void)
>  		vt.mem_flags |= MEMORY_PAGETABLE_3L;
>  		DEBUG_MSG("PAGETABLE_3L : ON\n");
>  	} else {
> +		vt.mem_flags |= MEMORY_PAGETABLE_4L;
>  		MSG("Can't distinguish the pgtable.\n");
>  	}
>  
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



--===============1217505454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1217505454==--
