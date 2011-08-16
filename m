Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QtHi1-0002hx-3j
	for kexec@lists.infradead.org; Tue, 16 Aug 2011 11:21:26 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7GBLJkc011236
	for <kexec@lists.infradead.org>; Tue, 16 Aug 2011 21:21:19 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7GBLJdP1782006
	for <kexec@lists.infradead.org>; Tue, 16 Aug 2011 21:21:19 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7GBLIpj006422
	for <kexec@lists.infradead.org>; Tue, 16 Aug 2011 21:21:19 +1000
Message-ID: <4E4A52AC.2060407@linux.vnet.ibm.com>
Date: Tue, 16 Aug 2011 16:51:16 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [UPDATED PATCH v2 8/8] makedumpfile: Add erase information in
	ELF formatted dumpfile
References: <20110517200715.12740.67863.stgit@mars.in.ibm.com>
	<20110715091602.GA719@in.ibm.com>
	<20110815145451.44f9d605.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110815145451.44f9d605.oomichi@mxs.nes.nec.co.jp>
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
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>

On 08/15/2011 11:24 AM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Fri, 15 Jul 2011 14:46:02 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>> @@ -4647,6 +4650,15 @@ write_cache_bufsz(struct cache_data *cd)
>>  }
>>  
>>  int
>> +write_cache_zero(struct cache_data *cd, size_t size)
>> +{
>> +	memset(cd->buf + cd->buf_size, 0, size);
>> +	cd->buf_size += size;
>> +
>> +	return write_cache_bufsz(cd);
>> +}
> 
> if cd->buf_size is a little smaller than cd->cache_size and
> the argument "size" is bigger than info->page_size, the above
> a SIGSEGV happens at the above memset().
> 
> Previous write_cache_bufsze() call will avoid that :
> ---
>  int
>  write_cache_zero(struct cache_data *cd, size_t size)
>  {
> +	if (!write_cache_bufsz(cd))
> +		return FALSE;
> 
> 	memset(cd->buf + cd->buf_size, 0, size);
> 	cd->buf_size += size;
> 
> 	return write_cache_bufsz(cd);
>  }
> ---

Nice catch. Agree.

> 
>>  /*
>> + * ELF note section for erase information
>> + *
>> + * According to elf.h the unused values are 0x15(21) through 0xff. The value
>> + * range 0x1XX, 0x2XX and 0x3XX is been used for PPC, i386 and s390
>> + * respectively.
>> + *
>> + * Using 0xff to be on safer side so that any new Elf Note addition in elf.h
>> + * after 0x15 value would not clash.
>> + */
>> +#ifndef NT_ERASE_INFO
>> +#define NT_ERASE_INFO (0xff)	/* Contains erased information. */
>> +#endif
>> +#define ERASEINFO_NOTE_NAME		"ERASEINFO"
>> +#define ERASEINFO_NOTE_NAME_BYTES	(sizeof(ERASEINFO_NOTE_NAME))
> 
> I feel NT_ERASE_INFO(0xff) is not safe and we can use ERASEINFO_NOTE_NAME
> instead.

Do you mean having n_type set to '0' and just using
'ERASEINFO_NOTE_NAME' to identify the eraseinfo note? if Yes, then I
think I am ok with that.

Thanks,
-Mahesh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
