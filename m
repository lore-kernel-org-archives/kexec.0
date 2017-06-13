Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dKgNu-0000lP-Fp
 for kexec@lists.infradead.org; Tue, 13 Jun 2017 07:37:06 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF53983F40
 for <kexec@lists.infradead.org>; Tue, 13 Jun 2017 07:36:16 +0000 (UTC)
Date: Tue, 13 Jun 2017 03:36:15 -0400 (EDT)
From: Pingfan Liu <piliu@redhat.com>
Message-ID: <102818823.21629841.1497339375650.JavaMail.zimbra@redhat.com>
In-Reply-To: <817b653f-9191-70c2-21b9-6fba9a196399@redhat.com>
References: <1496822990-17848-1-git-send-email-piliu@redhat.com>
 <1496822990-17848-2-git-send-email-piliu@redhat.com>
 <817b653f-9191-70c2-21b9-6fba9a196399@redhat.com>
Subject: Re: [makedumpfile PATCHv2 2/2] print_info: show the remaining time
 of dump progress
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org





----- Original Message -----
> From: "Pratyush Anand" <panand@redhat.com>
> To: kexec@lists.infradead.org
> Sent: Thursday, June 8, 2017 3:09:46 PM
> Subject: Re: [makedumpfile PATCHv2 2/2] print_info: show the remaining time of dump progress
> 
> 
> 
> On Wednesday 07 June 2017 01:39 PM, Pingfan Liu wrote:
> > If the dump progress is slow, it is better to show  an estimate of
> > remaining time of the progress to the user. The estimator simply uses
> > the average speed to work.
> 
> Nice improvement.
> 
> It could have been better to write about how does log looks before and after
> this patch.
>
The progress bar looks like: Copying data                                      : [  1.8 %] /          eta: 39s
I will update the commit log.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > ---
> > v1 -> v2: fold  eta string into eta_to_human_short()
> >
> >
> >  makedumpfile.c | 46 +++++++++++++++++++++++-----------------------
> >  print_info.c   | 41 +++++++++++++++++++++++++++++++++++------
> >  print_info.h   |  3 ++-
> >  3 files changed, 60 insertions(+), 30 deletions(-)
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 301772a..35a36ce 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -5175,7 +5175,7 @@ _exclude_free_page(struct cycle *cycle)
> >
> >  	for (num_nodes = 1; num_nodes <= vt.numnodes; num_nodes++) {
> >
> > -		print_progress(PROGRESS_FREE_PAGES, num_nodes - 1, vt.numnodes);
> > +		print_progress(PROGRESS_FREE_PAGES, num_nodes - 1, vt.numnodes, NULL);
> >
> >  		node_zones = pgdat + OFFSET(pglist_data.node_zones);
> >
> > @@ -5188,7 +5188,7 @@ _exclude_free_page(struct cycle *cycle)
> >  		for (i = 0; i < nr_zones; i++) {
> >
> >  			print_progress(PROGRESS_FREE_PAGES, i + nr_zones * (num_nodes - 1),
> > -					nr_zones * vt.numnodes);
> > +					nr_zones * vt.numnodes, NULL);
> >
> >  			zone = node_zones + (i * SIZE(zone));
> >  			if (!readmem(VADDR, zone + OFFSET(zone.spanned_pages),
> > @@ -5216,7 +5216,7 @@ _exclude_free_page(struct cycle *cycle)
> >  	/*
> >  	 * print [100 %]
> >  	 */
> > -	print_progress(PROGRESS_FREE_PAGES, vt.numnodes, vt.numnodes);
> > +	print_progress(PROGRESS_FREE_PAGES, vt.numnodes, vt.numnodes, NULL);
> >  	print_execution_time(PROGRESS_FREE_PAGES, &tv_start);
> >
> >  	return TRUE;
> > @@ -5403,7 +5403,7 @@ create_1st_bitmap_file(void)
> >  	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
> >
> >  		if (!info->flag_mem_usage)
> > -			print_progress(PROGRESS_HOLES, i, num_pt_loads);
> > +			print_progress(PROGRESS_HOLES, i, num_pt_loads, NULL);
> >
> >  		pfn_start = paddr_to_pfn(phys_start);
> >  		pfn_end   = paddr_to_pfn(phys_end);
> > @@ -5422,7 +5422,7 @@ create_1st_bitmap_file(void)
> >  	 * print 100 %
> >  	 */
> >  	if (!info->flag_mem_usage) {
> > -		print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr);
> > +		print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr, NULL);
> >  		print_execution_time(PROGRESS_HOLES, &tv_start);
> >  	}
> >
> > @@ -5548,7 +5548,7 @@ create_bitmap_from_memhole(struct cycle *cycle,
> > struct dump_bitmap *bitmap, int
> >  		pfn_start = MAX(paddr_to_pfn(phys_start), cycle->start_pfn);
> >  		pfn_end = MIN(paddr_to_pfn(phys_end), cycle->end_pfn);
> >
> > -		print_progress(PROGRESS_HOLES, i, num_pt_loads);
> > +		print_progress(PROGRESS_HOLES, i, num_pt_loads, NULL);
> >
> >  		if (pfn_start >= pfn_end)
> >  			continue;
> > @@ -5587,7 +5587,7 @@ create_bitmap_from_memhole(struct cycle *cycle,
> > struct dump_bitmap *bitmap, int
> >  	/*
> >  	 * print 100 %
> >  	 */
> > -	print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr);
> > +	print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr, NULL);
> >  	print_execution_time(PROGRESS_HOLES, &tv_start);
> >
> >  	return TRUE;
> > @@ -5842,7 +5842,7 @@ exclude_unnecessary_pages(struct cycle *cycle)
> >  	for (mm = 0; mm < info->num_mem_map; mm++) {
> >
> >  		if (!info->flag_mem_usage)
> > -			print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
> > +			print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map, NULL);
> >
> >  		mmd = &info->mem_map_data[mm];
> >
> > @@ -5860,7 +5860,7 @@ exclude_unnecessary_pages(struct cycle *cycle)
> >  	 * print [100 %]
> >  	 */
> >  	if (!info->flag_mem_usage) {
> > -		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map,
> > info->num_mem_map);
> > +		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map,
> > NULL);
> >  		print_execution_time(PROGRESS_UNN_PAGES, &tv_start);
> >  	}
> >
> > @@ -7334,7 +7334,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header,
> > struct cache_data *cd_page)
> >  				}
> >
> >  				if ((num_dumped % per) == 0)
> > -					print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
> > +					print_progress(PROGRESS_COPY, num_dumped, num_dumpable, &tv_start);
> >
> >  				num_dumped++;
> >
> > @@ -7453,7 +7453,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header,
> > struct cache_data *cd_page)
> >  	/*
> >  	 * print [100 %]
> >  	 */
> > -	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
> > +	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable, &tv_start);
> >  	print_execution_time(PROGRESS_COPY, &tv_start);
> >  	PROGRESS_MSG("\n");
> >
> > @@ -7931,7 +7931,7 @@ write_kdump_pages_parallel_cyclic(struct cache_data
> > *cd_header,
> >  		}
> >
> >  		if ((num_dumped % per) == 0)
> > -			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
> > +			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable,
> > &tv_start);
> >
> >  		num_dumped++;
> >
> > @@ -7967,7 +7967,7 @@ finish:
> >  	/*
> >  	 * print [100 %]
> >  	 */
> > -	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
> > +	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &tv_start);
> >  	print_execution_time(PROGRESS_COPY, &tv_start);
> >  	PROGRESS_MSG("\n");
> >
> > @@ -8084,7 +8084,7 @@ write_kdump_pages_cyclic(struct cache_data
> > *cd_header, struct cache_data *cd_pag
> >  	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> >
> >  		if ((num_dumped % per) == 0)
> > -			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
> > +			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable,
> > &tv_start);
> >
> >  		/*
> >  		 * Check the excluded page.
> > @@ -8164,7 +8164,7 @@ out:
> >  		free(wrkmem);
> >  #endif
> >
> > -	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
> > +	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &tv_start);
> >  	print_execution_time(PROGRESS_COPY, &tv_start);
> >
> >  	return ret;
> > @@ -8622,7 +8622,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data
> > *cd_header, struct cache_d
> >  	/*
> >  	 * print [100 %]
> >  	 */
> > -	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
> > +	print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &tv_start);
> >  	print_execution_time(PROGRESS_COPY, &tv_start);
> >  	PROGRESS_MSG("\n");
> >
> > @@ -9216,7 +9216,7 @@ exclude_xen3_user_domain(void)
> >  	 */
> >  	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
> >
> > -		print_progress(PROGRESS_XEN_DOMAIN, i, num_pt_loads);
> > +		print_progress(PROGRESS_XEN_DOMAIN, i, num_pt_loads, NULL);
> >
> >  		pfn     = paddr_to_pfn(phys_start);
> >  		pfn_end = paddr_to_pfn(phys_end);
> > @@ -9224,7 +9224,7 @@ exclude_xen3_user_domain(void)
> >
> >  		for (j = 0; pfn < pfn_end; pfn++, j++) {
> >  			print_progress(PROGRESS_XEN_DOMAIN, j + (size * i),
> > -					size * num_pt_loads);
> > +					size * num_pt_loads, NULL);
> >
> >  			if (!allocated_in_map(pfn)) {
> >  				clear_bit_on_2nd_bitmap(pfn, NULL);
> > @@ -9280,7 +9280,7 @@ exclude_xen4_user_domain(void)
> >  	 */
> >  	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
> >
> > -		print_progress(PROGRESS_XEN_DOMAIN, i, num_pt_loads);
> > +		print_progress(PROGRESS_XEN_DOMAIN, i, num_pt_loads, NULL);
> >
> >  		pfn     = paddr_to_pfn(phys_start);
> >  		pfn_end = paddr_to_pfn(phys_end);
> > @@ -9288,7 +9288,7 @@ exclude_xen4_user_domain(void)
> >
> >  		for (j = 0; pfn < pfn_end; pfn++, j++) {
> >  			print_progress(PROGRESS_XEN_DOMAIN, j + (size * i),
> > -					size * num_pt_loads);
> > +					size * num_pt_loads, NULL);
> >
> >  			page_info_addr = info->frame_table_vaddr + pfn * SIZE(page_info);
> >  			if (!readmem(VADDR_XEN,
> > @@ -9356,7 +9356,7 @@ exclude_xen_user_domain(void)
> >  	/*
> >  	 * print [100 %]
> >  	 */
> > -	print_progress(PROGRESS_XEN_DOMAIN, 1, 1);
> > +	print_progress(PROGRESS_XEN_DOMAIN, 1, 1, NULL);
> >  	print_execution_time(PROGRESS_XEN_DOMAIN, &tv_start);
> >
> >  	return ret;
> > @@ -10342,7 +10342,7 @@ reassemble_kdump_pages(void)
> >
> >  			num_dumped++;
> >
> > -			print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
> > +			print_progress(PROGRESS_COPY, num_dumped, num_dumpable, &tv_start);
> >
> >  			if (lseek(fd, offset_ph_org, SEEK_SET) < 0) {
> >  				ERRMSG("Can't seek a file(%s). %s\n",
> > @@ -10439,7 +10439,7 @@ reassemble_kdump_pages(void)
> >  						    size_eraseinfo))
> >  			goto out;
> >  	}
> > -	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
> > +	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable, &tv_start);
> >  	print_execution_time(PROGRESS_COPY, &tv_start);
> >
> >  	ret = TRUE;
> > diff --git a/print_info.c b/print_info.c
> > index 79dfe5e..4e0bb5c 100644
> > --- a/print_info.c
> > +++ b/print_info.c
> > @@ -15,8 +15,9 @@
> >   */
> >  #include "print_info.h"
> >  #include <time.h>
> > +#include <string.h>
> >
> > -#define PROGRESS_MAXLEN		"35"
> > +#define PROGRESS_MAXLEN		"50"
> >
> >  int message_level;
> >  int flag_strerr_message;
> > @@ -350,14 +351,36 @@ static void calc_delta(struct timeval *tv_start,
> > struct timeval *delta)
> >  	}
> >  }
> >
> > +/* produce less than 12 bytes on msg */
> > +static int eta_to_human_short (int secs, char* msg)
> > +{
> > +	strcpy(msg, "eta: ");
> > +	msg += strlen("eta: ");
> > +	if (secs < 100)
> > +		sprintf(msg, "%ds", secs);
> > +	else if (secs < 100 * 60)
> > +		sprintf(msg, "%dm%ds", secs / 60, secs % 60);
> > +	else if (secs < 48 * 3600)
> > +		sprintf(msg, "%dh%dm", secs / 3600, (secs / 60) % 60);
> > +	else if (secs < 100 * 86400)
> > +		sprintf(msg, "%dd%dh", secs / 86400, (secs / 3600) % 24);
> > +	else
> > +		sprintf(msg, ">2day");
> > +	return 0;
> > +}
> > +
> > +
> >  void
> > -print_progress(const char *msg, unsigned long current, unsigned long end)
> > +print_progress(const char *msg, unsigned long current, unsigned long end,
> > struct timeval *start)
> >  {
> >  	float progress;
> >  	time_t tm;
> >  	static time_t last_time = 0;
> >  	static unsigned int lapse = 0;
> >  	static const char *spinner = "/|\\-";
> > +	struct timeval delta;
> > +	double eta;
> > +	char eta_msg[16] = " ";
> >
> >  	if (current < end) {
> >  		tm = time(NULL);
> > @@ -368,13 +391,19 @@ print_progress(const char *msg, unsigned long
> > current, unsigned long end)
> >  	} else
> >  		progress = 100;
> >
> > +	if (start != NULL) {
> > +		calc_delta(start, &delta);
> > +		eta = delta.tv_sec + delta.tv_usec/1e6;
> 
> space around /
> and better to write hex value as 0x1e6
> 
> Sorry, I could not understand what is this magic number 1e6?
> 
Ah, it is 10^6.

> 
> > +		eta = (100 - progress) * eta/progress;
> 
> space around /
> 
Adopted.

Thank you for review.

Regards,
Pingfan

> > +		eta_to_human_short(eta, eta_msg);
> > +	}
> >  	if (flag_ignore_r_char) {
> > -		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c\n",
> > -			     msg, progress, spinner[lapse % 4]);
> > +		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s\n",
> > +			     msg, progress, spinner[lapse % 4], eta_msg);
> >  	} else {
> >  		PROGRESS_MSG("\r");
> > -		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c",
> > -			     msg, progress, spinner[lapse % 4]);
> > +		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s",
> > +			     msg, progress, spinner[lapse % 4], eta_msg);
> >  	}
> >  	lapse++;
> >  }
> > diff --git a/print_info.h b/print_info.h
> > index 01e3706..1ce3593 100644
> > --- a/print_info.h
> > +++ b/print_info.h
> > @@ -25,7 +25,8 @@ extern int flag_ignore_r_char;
> >
> >  void show_version(void);
> >  void print_usage(void);
> > -void print_progress(const char *msg, unsigned long current, unsigned long
> > end);
> > +void print_progress(const char *msg, unsigned long current, unsigned long
> > end, struct timeval *start);
> > +
> >  void print_execution_time(char *step_name, struct timeval *tv_start);
> >
> >  /*
> >
> 
> ~Pratyush
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
