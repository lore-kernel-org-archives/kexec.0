Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www262.sakura.ne.jp ([202.181.97.72])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hpul1-0004vc-W5
 for kexec@lists.infradead.org; Tue, 23 Jul 2019 13:23:09 +0000
Subject: Re: [PATCH] kexec: Bail out upon SIGKILL when allocating memory.
References: <000000000000a861f6058b2699e0@google.com>
 <000000000000c0103a058b2ba0ec@google.com>
 <993c9185-d324-2640-d061-bed2dd18b1f7@I-love.SAKURA.ne.jp>
 <612eebbe-336a-c1d0-904b-5970d3c4dbb0@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <eb662b31-3a56-f3fd-6a0c-7e9f8b36ca8a@I-love.SAKURA.ne.jp>
Date: Tue, 23 Jul 2019 22:22:55 +0900
MIME-Version: 1.0
In-Reply-To: <612eebbe-336a-c1d0-904b-5970d3c4dbb0@I-love.SAKURA.ne.jp>
Content-Language: en-US
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

Andrew, can you pick up this patch? 

On 2019/07/01 19:52, Tetsuo Handa wrote:
> Andrew, can you pick up this patch? We might miss next merge window, for
> Eric Biederman seems to be offline for two weeks. 
> 
> On 2019/06/14 19:16, Tetsuo Handa wrote:
>> syzbot found that a thread can stall for minutes inside kexec_load() after
>> that thread was killed by SIGKILL [1]. It turned out that the reproducer
>> was trying to allocate 2408MB of memory using kimage_alloc_page() from
>> kimage_load_normal_segment(). Let's check for SIGKILL before doing memory
>> allocation.
>>
>> [1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
>> ---
>>  kernel/kexec_core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index fd5c95f..2b25d95 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -302,6 +302,8 @@ static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
>>  {
>>  	struct page *pages;
>>  
>> +	if (fatal_signal_pending(current))
>> +		return NULL;
>>  	pages = alloc_pages(gfp_mask & ~__GFP_ZERO, order);
>>  	if (pages) {
>>  		unsigned int count, i;
>>
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
