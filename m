Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UeciW-00076w-Fz
 for kexec@lists.infradead.org; Tue, 21 May 2013 02:54:25 +0000
Message-ID: <519AE1C0.2060401@hp.com>
Date: Tue, 21 May 2013 10:53:52 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: non-cyclic default
References: <E1UcggB-0005h5-8e@eag09.americas.sgi.com>
 <20130521111516.af6d1f8d14f39c8d34d9d18d@mxc.nes.nec.co.jp>
In-Reply-To: <20130521111516.af6d1f8d14f39c8d34d9d18d@mxc.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, cpw@sgi.com, jingbai.ma@hp.com

On 05/21/2013 10:15 AM, Atsushi Kumagai wrote:
> On Wed, 15 May 2013 13:43:59 -0500
> Cliff Wickman<cpw@sgi.com>  wrote:
>
>> From: Cliff Wickman<cpw@sgi.com>
>>
>> Make non-cyclic the default, as it is faster.
>>
>> Dumping a 1TB memory is successful with a crashkernel=512M.
>> And allow -Y on the command line, as well as --non-cylic.
>>
>> Signed-off-by: Cliff Wickman<cpw@sgi.com>
>
> This change causes the failure due to lack of memory, again.
>
> I think reliability is more important than performance, it's desirable
> that anyone can use makedumpfile safely without any considerations.
>
> Only experts who can set "crashkernel" appropriately based on physical
> memory size should use --non-cyclic option manually for performance.
>

I second leave default mode to cyclic. It's difficult to guess how much 
memory the secondary kernel needed. The memory requirement from 
different device driver also be very different, especially on machines 
with many I/O cards.
So we don't know if the memory is enough for non-cyclic.

Once we have kernel 3.9 and kexec-tools-2.0.4, We will have enough 
memory above 4GB address. And then, the next question will be how much 
memory we should reserve for crashkernel.

>
> Thanks
> Atsushi Kumagai
>
>> ---
>>   makedumpfile.c |    9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> Index: makedumpfile.mmap/makedumpfile.c
>> ===================================================================
>> --- makedumpfile.mmap.orig/makedumpfile.c
>> +++ makedumpfile.mmap/makedumpfile.c
>> @@ -8585,13 +8585,14 @@ main(int argc, char *argv[])
>>   	initialize_tables();
>>
>>   	/*
>> -	 * By default, makedumpfile works in constant memory space.
>> +	 * By default, makedumpfile makes one pass through page structures.
>> +	 * Use --cyclic-buffer to work in constant memory space.
>>   	 */
>> -	info->flag_cyclic = TRUE;
>> +	info->flag_cyclic = FALSE;
>>   	
>>   	info->block_order = DEFAULT_ORDER;
>>   	message_level = DEFAULT_MSG_LEVEL;
>> -	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:", longopts,
>> +	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:Y", longopts,
>>   	    NULL)) != -1) {
>>   		switch (opt) {
>>   		case 'A':
>> @@ -8694,6 +8695,8 @@ main(int argc, char *argv[])
>>   			break;
>>   		case 'Z':
>>   			info->bufsize_cyclic = atoi(optarg);
>> +			if (info->bufsize_cyclic)
>> +				info->flag_cyclic = TRUE;
>>   			break;
>>   		case '?':
>>   			MSG("Commandline parameter is invalid.\n");
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
