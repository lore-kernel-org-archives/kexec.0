Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CALZhoSQSOTxV_OKVWwrmUt2tVqo3STEwonZcdzY398MLbP9U9w@mail.gmail.com>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
	<20110916054556.GA10298@verge.net.au>
	<CALZhoSQSOTxV_OKVWwrmUt2tVqo3STEwonZcdzY398MLbP9U9w@mail.gmail.com>
Date: Mon, 19 Sep 2011 10:29:11 +0800
Message-ID: <CALZhoSSpx3e8JAb8JLdOoXXay_055XQ126SJLVyUPedUh9KAjw@mail.gmail.com>
Subject: Re: [PATCH] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
From: Lei Wen <adrian.wenl@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Lei Wen <leiwen@marvell.com>, Yu Tang <ytang5@marvell.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Chao Xie <chao.xie@marvell.com>

On Sat, Sep 17, 2011 at 9:58 PM, Lei Wen <adrian.wenl@gmail.com> wrote:
> Hi Simon,
>
> On Fri, Sep 16, 2011 at 1:45 PM, Simon Horman <horms@verge.net.au> wrote:
>> On Thu, Sep 15, 2011 at 10:32:09PM -0700, Lei Wen wrote:
>>> This copy really don't need to do at the very second before the kernel
>>> would crash.
>>>
>>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>>
>> This seems reasonable to me.
>>
>> Acked-by: Simon Horman <horms@verge.net.au>
>
> Thanks for acked. :)
>
> BTW, do you know which git tree should this patch be merged?
>

Push it to Russell's patch tracking system. :)

Best regards,
Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
