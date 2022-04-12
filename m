From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Tue, 12 Apr 2022 02:25:50 +0000
Subject: [PATCH v3 1/1] check that order of free pages falls within valid
 range
In-Reply-To: <20220411060835.63570-1-egorenar@linux.ibm.com>
References: <20220411060835.63570-1-egorenar@linux.ibm.com>
Message-ID: <TYYPR01MB677730E0385D0E6AC27CE4D5DDED9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

-----Original Message-----
> This change makes __exclude_unnecessary_pages() more robust by
> verifying that the order of a free page is valid before computing the size
> of its memory block in the buddy system.
> 
> The order of a free page cannot be larger than (MAX_ORDER - 1) because
> the array 'zone.free_area' is of size MAX_ORDER.
> 
> This situation is reproducible with some s390x dumps:
> 
> __exclude_unnecessary_pages: Invalid free page order: pfn=2690c0, order=52, max order=8
> 
> References:
> - https://listman.redhat.com/archives/crash-utility/2021-September/009204.html
> - https://www.kernel.org/doc/gorman/html/understand/understand009.html
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  makedumpfile.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 2ef345879524..a6c2a4934ff9 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6457,6 +6457,11 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		else if ((info->dump_level & DL_EXCLUDE_FREE)
>  		    && info->page_is_buddy
>  		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
> +			if (private >= ARRAY_LENGTH(zone.free_area)) {
> +				MSG("WARNING: Invalid free page order: pfn=%llx, order=%lu, max order=%lu\n",
> +				    pfn, private, ARRAY_LENGTH(zone.free_area) - 1);
> +				continue;
> +			}
>  			nr_pages = 1 << private;
>  			pfn_counter = &pfn_free;
>  		}
> --
> 2.34.1

Thanks for the update.
Applied with the available check for ARRAY_LENGTH(zone.free_area).
https://github.com/makedumpfile/makedumpfile/commit/0ea92577d93c93af701101f22ebd0096202c8085

Thanks,
Kazu


