Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcTJ2-0000PU-6j
 for kexec@lists.infradead.org; Thu, 17 Sep 2015 07:08:33 +0000
Received: by wicge5 with SMTP id ge5so105026604wic.0
 for <kexec@lists.infradead.org>; Thu, 17 Sep 2015 00:08:09 -0700 (PDT)
Subject: Re: Reducing the size of the dump file/speeding up collection
References: <55F928B1.4080703@kyup.com> <55FA332B.40408@cn.fujitsu.com>
 <55FA5E8C.9020506@kyup.com>
From: Nikolay Borisov <kernel@kyup.com>
Message-ID: <55FA66D8.10900@kyup.com>
Date: Thu, 17 Sep 2015 10:08:08 +0300
MIME-Version: 1.0
In-Reply-To: <55FA5E8C.9020506@kyup.com>
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
To: qiaonuohan <qiaonuohan@cn.fujitsu.com>, kexec@lists.infradead.org
Cc: SiteGround Operations <operations@siteground.com>

Just to follow up: which version of kexec/makedumpfile are required to
have the parallel dump feature? The thread you referenced adds
documentation how to use that and I grepped the source of makedumpfile
1.5.8 and couldn't find any references to the num-threads option? So
what version of the code do I need to test that ?

On 09/17/2015 09:32 AM, Nikolay Borisov wrote:
> Hi Qiao,
> 
> Thanks for the reply. So far I haven't been using the the compression
> feature of makedumpfile. But I want to ask if anything wouldn't
> compression make the dump process slower since in addition to having to
> write the dump to disk it also has to compress it which would put more
> strain on the cpu. Also, which part of the dump process is the bottleneck:
> 
> - Reading from /proc/vmcore - that has mmap support so should be fairly
> fast?
> - Discarding unnecessary pages as memory is being scanned?
> - Writing/compressing content to disk?
> 
> Regards,
> Nikolay
> 
> On 09/17/2015 06:27 AM, qiaonuohan wrote:
>> On 09/16/2015 04:30 PM, Nikolay Borisov wrote:
>>> Hello,
>>>
>>> I've been using makedumpfile as the crash collector with the -d31
>>> parameter. The machine this is being run on usually have 128-256GB of
>>> ram and the resulting crash dumps are in the range of 14-20gb which is
>>> very bug for the type of analysis I'm usually performing on crashed
>>> machine. I was wondering whether there is a way  to further reduce the
>>> size and the time to take the dump (now it takes around 25 minutes to
>>> collect such a dump). I've seen reports where people with TBs of ram
>>> take that long, meaning for a machine with 256gb it should be even
>>> faster. I've been running this configuration on kernels 3.12.28 and 4.1
>>> where mmap for the vmcore file is supported.
>>>
>>> Please advise
>>
>> Hi nikolay,
>>
>> Yes, this issue is what we are concerning a lot.
>> About the current situation, try --split, it will save time.
>>
>>
>> And lzo/snappy instead of zlib, these two compression format are faster
>> but need more space to save. Or if you still want zlib (to save space),
>> try multiple threads, check the following site, it will help you:
>>
>> https://lists.fedoraproject.org/pipermail/kexec/2015-September/002322.html
>>
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
