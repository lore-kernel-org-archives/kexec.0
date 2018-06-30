Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fZMaA-0005ia-18
 for kexec@lists.infradead.org; Sat, 30 Jun 2018 20:35:00 +0000
Received: by mail-pg0-f67.google.com with SMTP id b10-v6so5421857pgq.11
 for <kexec@lists.infradead.org>; Sat, 30 Jun 2018 13:34:42 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] kexec-arm64: Add functionality to dump 2nd dtb
References: <1529576678-14615-1-git-send-email-bhsharma@redhat.com>
 <1529576678-14615-3-git-send-email-bhsharma@redhat.com>
 <20180627120437.gdq66rfr7q2yiynd@verge.net.au>
 <20180627233647.GL23681@linaro.org>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <7b41fef5-6932-6e55-d8f0-26926be2d723@redhat.com>
Date: Sun, 1 Jul 2018 02:04:34 +0530
MIME-Version: 1.0
In-Reply-To: <20180627233647.GL23681@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, bhupesh.linux@gmail.com, dyoung@redhat.com, james.morse@arm.com

Hi Simon and Akashi,

Sorry for the delay, I was out of office most of last week.

On 06/28/2018 05:06 AM, AKASHI Takahiro wrote:
> On Wed, Jun 27, 2018 at 02:04:38PM +0200, Simon Horman wrote:
>> On Thu, Jun 21, 2018 at 03:54:38PM +0530, Bhupesh Sharma wrote:
>>> Since during the arm64 kexec_load()/kdump invocation,
>>> the dtb is passed to the second kernel, it is sometimes useful
>>> to dump the dtb contents (to verify the correctness
>>> of the same).
>>>
>>> This patch adds this feature which is enabled when '-d' flag is
>>> used with kexec command line invocation.
>>
>> This seems significantly more verbose than what -d already outputs.
>> Perhaps a second debug level is warranted here?
> 
> +1
> Debug messages on arm64 are already noisy due to ones from
> machine_apply_elf_rel(), which are not very useful in most cases,
> even making logs hard to understand.
> Some sort of level be helpful here, too.

Ok, will work on the same and send out a v5 with the fixes.

Thanks,
Bhupesh

>>
>>>
>>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>> ---
>>>   kexec/arch/arm64/kexec-arm64.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
>>> index a206c172b1aa..47df756bd595 100644
>>> --- a/kexec/arch/arm64/kexec-arm64.c
>>> +++ b/kexec/arch/arm64/kexec-arm64.c
>>> @@ -540,6 +540,8 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
>>>   	dtb->buf = new_buf;
>>>   	dtb->size = fdt_totalsize(new_buf);
>>>   
>>> +	dbgprintf("%s: found %s\n", __func__, dtb->path);
>>> +	dump_fdt(dtb->buf);
>>>   	dump_reservemap(dtb);
>>>   
>>>   	return result;
>>> -- 
>>> 2.7.4
>>>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
