Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ddfIy-0006sn-Ip
 for kexec@lists.infradead.org; Fri, 04 Aug 2017 16:18:30 +0000
Subject: Re: [makedumpfile PATCH] Wipe excluded pages that are written into
 ELF dump file
References: <1501508130-27022-1-git-send-email-eric.devolder@oracle.com>
 <20170731175956.GE7443@olila.local.net-space.pl>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <5a750e32-2f26-93c9-43e5-e1e4a942ef2d@oracle.com>
Date: Fri, 4 Aug 2017 05:19:27 -0700
MIME-Version: 1.0
In-Reply-To: <20170731175956.GE7443@olila.local.net-space.pl>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, konrad.wilk@oracle.com



On 07/31/2017 10:59 AM, Daniel Kiper wrote:
> On Mon, Jul 31, 2017 at 06:35:30AM -0700, Eric DeVolder wrote:
[...snip...]
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 8a05794..9ccd06d 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -1266,6 +1266,7 @@ struct DumpInfo {
>>   	int		vmemmap_cnt;
>>   	struct ppc64_vmemmap	*vmemmap_list;
>>   	unsigned long	kaslr_offset;
>> +	unsigned long	fill_excluded_pages_value; /* fill value for excluded pages */
>>
>>   	/*
>>   	 * page table info for ppc64
>> @@ -2275,6 +2276,7 @@ struct elf_prstatus {
>>   #define OPT_WORKING_DIR         OPT_START+15
>>   #define OPT_NUM_THREADS	OPT_START+16
>>   #define OPT_PARTIAL_DMESG	OPT_START+17
>> +#define OPT_FILL_EXCLUDED_PAGES	OPT_START+18
> 
> Oh, no please fix alignment somehow here. Separate patch?
> And I think that just in case it should be:
> 
> #define OPT_FILL_EXCLUDED_PAGES      (OPT_START+18)
> 
> And probably this applies to others. Next patch?

I will fix formatting in a subsequent patch.
eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
