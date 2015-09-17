Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcPsk-0003ym-8h
 for kexec@lists.infradead.org; Thu, 17 Sep 2015 03:29:10 +0000
Message-ID: <55FA332B.40408@cn.fujitsu.com>
Date: Thu, 17 Sep 2015 11:27:39 +0800
From: qiaonuohan <qiaonuohan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: Reducing the size of the dump file/speeding up collection
References: <55F928B1.4080703@kyup.com>
In-Reply-To: <55F928B1.4080703@kyup.com>
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

On 09/16/2015 04:30 PM, Nikolay Borisov wrote:
> Hello,
>
> I've been using makedumpfile as the crash collector with the -d31
> parameter. The machine this is being run on usually have 128-256GB of
> ram and the resulting crash dumps are in the range of 14-20gb which is
> very bug for the type of analysis I'm usually performing on crashed
> machine. I was wondering whether there is a way  to further reduce the
> size and the time to take the dump (now it takes around 25 minutes to
> collect such a dump). I've seen reports where people with TBs of ram
> take that long, meaning for a machine with 256gb it should be even
> faster. I've been running this configuration on kernels 3.12.28 and 4.1
> where mmap for the vmcore file is supported.
>
> Please advise

Hi nikolay,

Yes, this issue is what we are concerning a lot.
About the current situation, try --split, it will save time.


And lzo/snappy instead of zlib, these two compression format are faster
but need more space to save. Or if you still want zlib (to save space),
try multiple threads, check the following site, it will help you:

https://lists.fedoraproject.org/pipermail/kexec/2015-September/002322.html


-- 
Regards
Qiao Nuohan

>
> Regards,
> Nikolay
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
