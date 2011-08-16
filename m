Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QtGh7-00020b-6W
	for kexec@lists.infradead.org; Tue, 16 Aug 2011 10:16:28 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p7GAGAHK030008
	for <kexec@lists.infradead.org>; Tue, 16 Aug 2011 15:46:10 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7GAGAoe4055260
	for <kexec@lists.infradead.org>; Tue, 16 Aug 2011 15:46:10 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7GAG9lR007273
	for <kexec@lists.infradead.org>; Tue, 16 Aug 2011 15:46:10 +0530
Message-ID: <4E4A4369.1000008@linux.vnet.ibm.com>
Date: Tue, 16 Aug 2011 15:46:09 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/8] makedumpfile: Add erased information in	compressed
	kdump file
References: <20110517200608.12740.68790.stgit@mars.in.ibm.com>
	<20110816100035.e27d97c0.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110816100035.e27d97c0.oomichi@mxs.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Ken'ichi,

On 08/16/2011 06:30 AM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Wed, 18 May 2011 01:36:17 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>> @@ -9452,6 +9747,7 @@ reassemble_kdump_pages(void)
>>  	struct cache_data cd_pd, cd_data;
>>  	struct timeval tv_start;
>>  	char *data = NULL;
>> +	unsigned long data_buf_size = info->page_size;
>>  
>>  	initialize_2nd_bitmap(&bitmap2);
>>  
>> @@ -9465,7 +9761,7 @@ reassemble_kdump_pages(void)
>>  		free_cache_data(&cd_pd);
>>  		return FALSE;
>>  	}
>> -	if ((data = malloc(info->page_size)) == NULL) {
>> +	if ((data = malloc(data_buf_size)) == NULL) {
>>  		ERRMSG("Can't allcate memory for page data.\n");
>>  		free_cache_data(&cd_pd);
>>  		free_cache_data(&cd_data);
>> @@ -9570,6 +9866,49 @@ reassemble_kdump_pages(void)
>>  	if (!write_cache_bufsz(&cd_data))
>>  		goto out;
>>  
>> +	info->offset_eraseinfo = cd_data.offset;
>> +	/* Copy eraseinfo from split dumpfiles to o/p dumpfile */
>> +	for (i = 0; i < info->num_dumpfile; i++) {
>> +		if (!SPLITTING_SIZE_EI(i))
>> +			continue;
>> +
>> +		if (SPLITTING_SIZE_EI(i) > data_buf_size) {
>> +			data_buf_size = SPLITTING_SIZE_EI(i);
>> +			if ((data = realloc(data, data_buf_size)) == NULL) {
>> +				ERRMSG("Can't allcate memory for eraseinfo"
>> +					" data.\n");
>> +				goto out;
>> +			}
>> +		}
>> +		if ((fd = open(SPLITTING_DUMPFILE(i), O_RDONLY)) < 0) {
>> +			ERRMSG("Can't open a file(%s). %s\n",
>> +			    SPLITTING_DUMPFILE(i), strerror(errno));
>> +			goto out;
>> +		}
>> +		if (lseek(fd, SPLITTING_OFFSET_EI(i), SEEK_SET) < 0) {
>> +			ERRMSG("Can't seek a file(%s). %s\n",
>> +			    SPLITTING_DUMPFILE(i), strerror(errno));
>> +			goto out;
>> +		}
>> +		if (read(fd, data, SPLITTING_SIZE_EI(i)) !=
>> +						SPLITTING_SIZE_EI(i)) {
>> +			ERRMSG("Can't read a file(%s). %s\n",
>> +			    SPLITTING_DUMPFILE(i), strerror(errno));
>> +			goto out;
>> +		}
>> +		if (!write_cache(&cd_data, data, SPLITTING_SIZE_EI(i)))
>> +			goto out;
>> +		info->size_eraseinfo += SPLITTING_SIZE_EI(i);
>> +
>> +		close(fd);
>> +		fd = 0;
>> +	}
>> +	if (!write_cache_bufsz(&cd_data))
>> +		goto out;
>> +
>> +	if (!update_sub_header())
>> +		goto out;
> 
> The above update_sub_header() breaks "--reassemble" option if a dumpfile
> does not contain eraseinfo data :

My bad. Thanks for catching it.

Thanks,
-Mahesh.

> 
> ---
> # makedumpfile --split -d30 vmcore dump.1 dump.2
> Copying data                       : [100 %]
> Copying data                       : [100 %]
> 
> The dumpfiles are saved to dump.1, and dump.2.
> 
> makedumpfile Completed.
> # makedumpfile --reassemble dump.1 dump.2 dump.3
> Copying data                       : [100 %]
> The dumpfile is saved to dump.3.
> 
> makedumpfile Completed.
> # crash vmlinux dump.3
> [..]
> 
> crash: page excluded: kernel virtual address: ffffffff8040b220  type: "cpu_possible_mask"
> #
> ---
> 
> The cause is that info->sub_header, which is written in update_sub_header(),
> is filled with 0x0.
> The following change fixes this problem:
> 
> ---
> @@ -9378,6 +9680,7 @@ reassemble_kdump_header(void)
>                     info->name_dumpfile, strerror(errno));
>                 return FALSE;
>         }
> +       memcpy(&info->sub_header, &kh, sizeof(kh));
> 
>         /*
>          * Write dump bitmap to both a dumpfile and a bitmap file.
> ---
> 
> Thanks
> Ken'ichi Ohmichi
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
