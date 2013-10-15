Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVzTP-0008J5-78
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 07:55:25 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: enhance bitmap writting function in
 reassemble mode
Date: Tue, 15 Oct 2013 07:52:36 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971B6815@BPXM01GP.gisp.nec.co.jp>
References: <20131014130440.2430.60450.stgit@k.asiapacific.hpqcorp.net>
 <20131014141110.GA9023@dhcp16-109.nay.redhat.com>
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
To: "jingbai.ma@hp.com" <jingbai.ma@hp.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>

(2013/10/14 23:11), WANG Chao wrote:
> On 10/14/13 at 09:04pm, Jingbai Ma wrote:
>> This patch Enhance bitmap writting function in reassemble_kdump_header().
>> Prevent bitmap writting failure if the size of bitmap is too large to fit a
>> sigle write.
>
> This patch looks good to me.
>
> Acked-by: WANG Chao <chaowang@redhat.com>

Thanks, I'll merge this patch into v1.5.5.


Atsushi Kumagai

>>
>> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
>> ---
>>   makedumpfile.c |   45 +++++++++++++++++++++++++++++++--------------
>>   1 files changed, 31 insertions(+), 14 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 130cf9f..f43454a 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -7990,6 +7990,7 @@ reassemble_kdump_header(void)
>>   	struct disk_dump_header dh;
>>   	struct kdump_sub_header kh;
>>   	char *buf_bitmap = NULL;
>> +	ssize_t status, read_size, written_size;
>>
>>   	/*
>>   	 * Write common header.
>> @@ -8068,10 +8069,16 @@ reassemble_kdump_header(void)
>>   		    SPLITTING_DUMPFILE(0), strerror(errno));
>>   		goto out;
>>   	}
>> -	if (read(fd, buf_bitmap, info->len_bitmap) != info->len_bitmap) {
>> -		ERRMSG("Can't read a file(%s). %s\n",
>> -		    SPLITTING_DUMPFILE(0), strerror(errno));
>> -		goto out;
>> +	read_size = 0;
>> +	while (read_size < info->len_bitmap) {
>> +		status = read(fd, buf_bitmap + read_size, info->len_bitmap
>> +			- read_size);
>> +		if (status < 0) {
>> +			ERRMSG("Can't read a file(%s). %s\n",
>> +				SPLITTING_DUMPFILE(0), strerror(errno));
>> +			goto out;
>> +		}
>> +		read_size += status;
>>   	}
>>
>>   	if (lseek(info->fd_dumpfile, offset, SEEK_SET) < 0) {
>> @@ -8079,11 +8086,16 @@ reassemble_kdump_header(void)
>>   		    info->name_dumpfile, strerror(errno));
>>   		goto out;
>>   	}
>> -	if (write(info->fd_dumpfile, buf_bitmap, info->len_bitmap)
>> -	    != info->len_bitmap) {
>> -		ERRMSG("Can't write a file(%s). %s\n",
>> -		    info->name_dumpfile, strerror(errno));
>> -		goto out;
>> +	written_size = 0;
>> +	while (written_size < info->len_bitmap) {
>> +		status = write(info->fd_dumpfile, buf_bitmap + written_size,
>> +			info->len_bitmap - written_size);
>> +		if (status < 0) {
>> +			ERRMSG("Can't write a file(%s). %s\n",
>> +			    info->name_dumpfile, strerror(errno));
>> +			goto out;
>> +		}
>> +		written_size += status;
>>   	}
>>
>>   	if (lseek(info->fd_bitmap, 0x0, SEEK_SET) < 0) {
>> @@ -8091,11 +8103,16 @@ reassemble_kdump_header(void)
>>   		    info->name_bitmap, strerror(errno));
>>   		goto out;
>>   	}
>> -	if (write(info->fd_bitmap, buf_bitmap, info->len_bitmap)
>> -	    != info->len_bitmap) {
>> -		ERRMSG("Can't write a file(%s). %s\n",
>> -		    info->name_bitmap, strerror(errno));
>> -		goto out;
>> +	written_size = 0;
>> +	while (written_size < info->len_bitmap) {
>> +		status = write(info->fd_bitmap, buf_bitmap + written_size,
>> +			info->len_bitmap - written_size);
>> +		if (status < 0) {
>> +			ERRMSG("Can't write a file(%s). %s\n",
>> +			    info->name_bitmap, strerror(errno));
>> +			goto out;
>> +		}
>> +		written_size += status;
>>   	}
>>
>>   	ret = TRUE;
>>
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
