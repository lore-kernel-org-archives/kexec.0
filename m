Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaxeP-0004Mp-Km
 for kexec@lists.infradead.org; Tue, 29 Oct 2013 00:59:19 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 0DBEF3EE0C2
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:58:51 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id F27A345DE50
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:58:50 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CC09545DE4D
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:58:50 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C07F21DB8041
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:58:50 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 74B931DB8032
 for <kexec@lists.infradead.org>; Tue, 29 Oct 2013 09:58:50 +0900 (JST)
Message-ID: <526F07F9.6050900@jp.fujitsu.com>
Date: Tue, 29 Oct 2013 09:57:29 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: print spinner in progress information
References: <5269CD32.200@jp.fujitsu.com> <5269DE2E.3000304@hp.com>
 <5269DF9C.9000207@hp.com>
In-Reply-To: <5269DF9C.9000207@hp.com>
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
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

(2013/10/25 12:03), Jingbai Ma wrote:
> On 10/25/2013 10:57 AM, Jingbai Ma wrote:
>> On 10/25/2013 09:45 AM, HATAYAMA Daisuke wrote:
>>> On system with huge memory, percentage in progress information is
>>> updated at very slow interval, because 1 percent on 1 TiB memory is
>>> about 10 GiB, which looks like as if system has freezed. Then,
>>> confused users might get tempted to push a reset button to recover the
>>> system. We want to avoid such situation as much as possible.
>>>
>>> To address the issue, this patch adds spinner that rotates in the
>>> order of /, |, \ and - next to the progress indicator in percentage,
>>> which helps users to get aware that system is still active and crash
>>> dump process is still in progress now.
>>>
>>> This code is borrowed from diskdump code.
>>>
>>> The example is like this:
>>>
>>> Copying data : [ 0 %] /
>>> Copying data : [ 8 %] |
>>> Copying data : [ 11 %] \
>>> Copying data : [ 14 %] -
>>> Copying data : [ 16 %] /
>>> ...
>>> Copying data : [ 99 %] /
>>> Copying data : [100 %] |
>>>
>>> Signed-off-by: HATAYAMA Daisuke<d.hatayama@jp.fujitsu.com>
>>> ---
>>> print_info.c | 11 +++++++----
>>> 1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/print_info.c b/print_info.c
>>> index 3527970..879fa4b 100644
>>> --- a/print_info.c
>>> +++ b/print_info.c
>>> @@ -286,6 +286,8 @@ print_progress(const char *msg, unsigned long
>>> current, unsigned long end)
>>> int progress;
>>> time_t tm;
>>> static time_t last_time = 0;
>>> + static unsigned int lapse = 0;
>>> + const char *spinner = "/|\\-";
>>
>> I believe your spinner should be:
>> const char *spinner = "/|\-/|\-";
>>
>
> Oh, it seems not a full round, this one should be better:
> const char *spinner = "/|\-";
>

It's escape sequence.

>>>
>>> if (current< end) {
>>> tm = time(NULL);
>>> @@ -297,13 +299,14 @@ print_progress(const char *msg, unsigned long
>>> current, unsigned long end)
>>> progress = 100;
>>>
>>> if (flag_ignore_r_char) {
>>> - PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%]\n",
>>> - msg, progress);
>>> + PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] %c\n",
>>> + msg, progress, spinner[lapse& 3]);
>
> And then, this line should be:
> msg, progress, spinner[lapse % 4]);
>

OK, though I think either is fine.

>>> } else {
>>> PROGRESS_MSG("\r");
>>> - PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ",
>>> - msg, progress);
>>> + PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] %c",
>>> + msg, progress, spinner[lapse& 3]);
>
> This line too:
> msg, progress, spinner[lapse % 4]);
>

OK.

>>> }
>>> + lapse++;
>>> }
>>>
>>> void
>>
>>
>
>


-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
