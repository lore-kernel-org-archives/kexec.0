Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSiPh-0005ix-Dj
 for kexec@lists.infradead.org; Wed, 26 Mar 2014 07:38:19 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: reduce unnecessary memory copy
Date: Wed, 26 Mar 2014 07:35:19 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F9B50@BPXM01GP.gisp.nec.co.jp>
References: <20140317084318.13494.34955.stgit@k.asiapacific.hpqcorp.net>
 <20140317.183214.300888078.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140317.183214.300888078.d.hatayama@jp.fujitsu.com>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>

Hello Jingbai,

>> This patch intends to reduce unnecessary memory copy in compressing memory
>> blocks.
>>
>> old logic like this:
>>     compress(buf_out, &size_out, buf, size);
>>     ...
>>     memcpy(buf, buf_out, pd.size);
>>     ...
>>     write_cache(cd_page, buf, pd.size)
>>
>> new logic:
>>     compress(buf_out, &size_out, buf, size);
>>     ...
>>     if (compressed?)
>>         write_cache(cd_page, buf_out, pd.size)
>>     else
>>         write_cache(cd_page, buf, pd.size)
>>
>> This occurs for each single page, so by the new logic it can reduce a lot of
>> unnecessary memcpy() on machines with huge memory.
>> This patch wasn't expected to improve the kdump performance dramatically due to
>> the memory copy operations on modern processors are pretty fast.
>>
>
>Now /proc/vmcore has zero copy mechanism with mmap(), but now
>makedumpfile still uses buffers some places in makedumpfile to keep
>changes as less as possible for ease of maintainance. I think ease of
>maintainance is important, so I don't think we should soon totally
>remove copy in makedumpfile. We should first benchmark where can be
>improved very much by just removing copy and then should decide where
>to optimize.
>
>OTOH, this patch also seems to be a kind of clean-up patch. Even if
>amount of improvement is a little, I don't object this patch; of
>course, then patch description should say it's rather cleanup patch
>than optimization.

I have no additional comments, so please send the v2 patch.


Thanks
Atsushi Kumagai

>>
>> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
>> ---
>>  makedumpfile.c |   24 ++++++++++++++----------
>>  1 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 23251a1..80f76cf 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -6245,7 +6245,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>>  		    && (size_out < info->page_size)) {
>>  			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
>>  			pd.size  = size_out;
>> -			memcpy(buf, buf_out, pd.size);
>>  #ifdef USELZO
>>  		} else if (info->flag_lzo_support
>>  			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
>> @@ -6255,7 +6254,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>>  			   && (size_out < info->page_size)) {
>>  			pd.flags = DUMP_DH_COMPRESSED_LZO;
>>  			pd.size  = size_out;
>> -			memcpy(buf, buf_out, pd.size);
>>  #endif
>>  #ifdef USESNAPPY
>>  		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
>> @@ -6267,7 +6265,6 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>>  			   && (size_out < info->page_size)) {
>>  			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
>>  			pd.size  = size_out;
>> -			memcpy(buf, buf_out, pd.size);
>>  #endif
>>  		} else {
>>  			pd.flags = 0;
>> @@ -6286,8 +6283,13 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>>  		/*
>>  		 * Write the page data.
>>  		 */
>> -		if (!write_cache(cd_page, buf, pd.size))
>> -			goto out;
>> +		if (pd.flags == 0) {
>> +			if (!write_cache(cd_page, buf, pd.size))
>> +				goto out;
>> +		} else {
>> +			if (!write_cache(cd_page, buf_out, pd.size))
>> +				goto out;
>> +		}
>>  	}
>
>if (!write_cache(cd_page, pd.flags ? buf_out : buf, pd.size))
>    goto out;
>
>>
>>  	/*
>> @@ -6424,7 +6426,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>>  		    && (size_out < info->page_size)) {
>>  			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
>>  			pd.size  = size_out;
>> -			memcpy(buf, buf_out, pd.size);
>>  #ifdef USELZO
>>  		} else if (info->flag_lzo_support
>>  			   && (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
>> @@ -6434,7 +6435,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>>  			   && (size_out < info->page_size)) {
>>  			pd.flags = DUMP_DH_COMPRESSED_LZO;
>>  			pd.size  = size_out;
>> -			memcpy(buf, buf_out, pd.size);
>>  #endif
>>  #ifdef USESNAPPY
>>  		} else if ((info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
>> @@ -6446,7 +6446,6 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>>  			   && (size_out < info->page_size)) {
>>  			pd.flags = DUMP_DH_COMPRESSED_SNAPPY;
>>  			pd.size  = size_out;
>> -			memcpy(buf, buf_out, pd.size);
>>  #endif
>>  		} else {
>>  			pd.flags = 0;
>> @@ -6465,8 +6464,13 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
>>                  /*
>>                   * Write the page data.
>>                   */
>> -                if (!write_cache(cd_page, buf, pd.size))
>> -                        goto out;
>> +		if (pd.flags == 0) {
>> +			if (!write_cache(cd_page, buf, pd.size))
>> +				goto out;
>> +		} else {
>> +			if (!write_cache(cd_page, buf_out, pd.size))
>> +				goto out;
>> +		}
>>          }
>
>Similaly.
>
>>
>>  	ret = TRUE;
>>
>
>Thanks.
>HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
