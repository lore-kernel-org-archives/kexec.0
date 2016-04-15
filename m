Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqtgM-00067j-OP
 for kexec@lists.infradead.org; Fri, 15 Apr 2016 02:40:31 +0000
Message-ID: <57105428.2090900@cn.fujitsu.com>
Date: Fri, 15 Apr 2016 10:38:32 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6] Improve the performance of --num-threads -d 31
References: <1460612555-19430-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160415023957.GA26257@dhcp-128-25.nay.redhat.com>
In-Reply-To: <20160415023957.GA26257@dhcp-128-25.nay.redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: kexec@lists.infradead.org

On 04/15/2016 10:39 AM, Minfei Huang wrote:
> On 04/14/16 at 01:42pm, Zhou Wenjian wrote:
>> @@ -10223,6 +10263,20 @@ calculate_cyclic_buffer_size(void) {
>>   	 *  free memory for safety.
>>   	 */
>>   	limit_size = get_free_memory_size() * 0.6;
>> +
>> +	/*
>> +	 * Recalculate the limit_size according to num_threads.
>> +	 * And reset num_threads if there is not enough memory.
>> +	 */
>> +	if (limit_size - maximum_size < THREAD_REGION * info->num_threads) {
>> +		MSG("There isn't enough memory for %d threads.\n", info->num_threads);
>> +
>> +		info->num_threads = MAX(0, limit_size - maximum_size) / THREAD_REGION;
>
> Hi, Zhou.
>
> Since both limit_size and maximum_size are unsigned long long,
> comparison is necessary for the if branch. Thus the micro MAX can be
> removed as well.
>

Oh, I made a stupid mistake.
Thanks for pointing it out.

-- 
Thanks
Zhou



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
