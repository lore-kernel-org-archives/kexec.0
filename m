Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zducp-0006p8-Pc
 for kexec@lists.infradead.org; Mon, 21 Sep 2015 06:30:57 +0000
Message-ID: <55FFA33A.6090404@cn.fujitsu.com>
Date: Mon, 21 Sep 2015 14:27:06 +0800
From: qiaonuohan <qiaonuohan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: Reducing the size of the dump file/speeding up collection
References: <55F928B1.4080703@kyup.com> <55FA332B.40408@cn.fujitsu.com>
 <55FA5E8C.9020506@kyup.com> <55FB7937.9030208@cn.fujitsu.com>
 <55FC0763.8050509@kyup.com>
In-Reply-To: <55FC0763.8050509@kyup.com>
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
To: Nikolay Borisov <kernel@kyup.com>, kexec@lists.infradead.org
Cc: SiteGround Operations <operations@siteground.com>

On 09/18/2015 08:45 PM, Nikolay Borisov wrote:
> Yeah, I did see the commit browser. But in my case I haven't even tested
> the split option so I guess there are things to try. Am I correct in my
> understanding as to how --split is supposed to work ( i tried that to no
> avail though):
>
> My core_collector line is this:
>
> core_collector makedumpfile --message-level 1 -d 3 --split dump1 dump2
> dump3 dump4 dump5 dump6
>
> And then in /etc/sysconfig/kdump I have:
>
> KDUMP_COMMANDLINE_APPEND="irqpoll nr_cpus=6 reset_devices
> cgroup_disable=memory mce=off"
>
> (the machine I'm testing on has 4 cores x2 hyperthreads so 8 logical
> cores in total). Do I need to do something else to utilize the --split
> option?

As I recall, it is OK to go on the test.

>
> On 09/18/2015 05:38 AM, qiaonuohan wrote:
>> On 09/17/2015 02:32 PM, Nikolay Borisov wrote:
>>> Hi Qiao,
>>>
>>> Thanks for the reply. So far I haven't been using the the compression
>>> feature of makedumpfile. But I want to ask if anything wouldn't
>>> compression make the dump process slower since in addition to having to
>>> write the dump to disk it also has to compress it which would put more
>>> strain on the cpu. Also, which part of the dump process is the
>>> bottleneck:
>>>
>>> - Reading from /proc/vmcore - that has mmap support so should be fairly
>>> fast?
>>> - Discarding unnecessary pages as memory is being scanned?
>>> - Writing/compressing content to disk?
>>
>> I cannot recall percentage of each part. But writing/compression takes most
>> of the time
>>
>> 1. mmap is used for reading faster
>> 2. --split is used to split the dump task into several processes, so
>> compressing
>>     and writing will be speeded up.
>> 3. multiple-thread is another option for speeding up compressing, it is
>> a recently
>>     committed patch, so you cannot find it in the master branch, checkout
>> devel branch
>>     or find it here:
>>
>> http://sourceforge.net/p/makedumpfile/code/commit_browser
>>
>> Make makedumpfile available to read and compress pages parallelly.
>>
>>>
>>> Regards,
>>> Nikolay
>>>
>>> On 09/17/2015 06:27 AM, qiaonuohan wrote:
>>>> On 09/16/2015 04:30 PM, Nikolay Borisov wrote:
>>>>> Hello,
>>>>>
>>>>> I've been using makedumpfile as the crash collector with the -d31
>>>>> parameter. The machine this is being run on usually have 128-256GB of
>>>>> ram and the resulting crash dumps are in the range of 14-20gb which is
>>>>> very bug for the type of analysis I'm usually performing on crashed
>>>>> machine. I was wondering whether there is a way  to further reduce the
>>>>> size and the time to take the dump (now it takes around 25 minutes to
>>>>> collect such a dump). I've seen reports where people with TBs of ram
>>>>> take that long, meaning for a machine with 256gb it should be even
>>>>> faster. I've been running this configuration on kernels 3.12.28 and 4.1
>>>>> where mmap for the vmcore file is supported.
>>>>>
>>>>> Please advise
>>>>
>>>> Hi nikolay,
>>>>
>>>> Yes, this issue is what we are concerning a lot.
>>>> About the current situation, try --split, it will save time.
>>>>
>>>>
>>>> And lzo/snappy instead of zlib, these two compression format are faster
>>>> but need more space to save. Or if you still want zlib (to save space),
>>>> try multiple threads, check the following site, it will help you:
>>>>
>>>> https://lists.fedoraproject.org/pipermail/kexec/2015-September/002322.html
>>>>
>>>>
>>>>
>>> .
>>>
>>
>>
> .
>


-- 
Regards
Qiao Nuohan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
