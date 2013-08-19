Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VBFEi-0004Mh-9f
 for kexec@lists.infradead.org; Mon, 19 Aug 2013 02:30:29 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 03CC23EE1DC
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 11:30:06 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E8D5E45DEBE
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 11:30:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D0DCB45DEBA
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 11:30:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C3B041DB803E
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 11:30:05 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2E4D3E08006
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 11:30:05 +0900 (JST)
Message-ID: <5211831B.6090704@jp.fujitsu.com>
Date: Mon, 19 Aug 2013 11:29:47 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [Help Test] kdump, x86, acpi: Reproduce CPU0 SMI corruption issue
 after unsetting BSP flag
References: <5200BFB3.2050202@jp.fujitsu.com> <520A10A3.5080303@hp.com>
 <520B4A22.2030800@hp.com> <87ob90839p.fsf@xmission.com>
In-Reply-To: <87ob90839p.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Mitchell,
 Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com, Jingbai Ma <jingbai.ma@hp.com>

(2013/08/15 4:45), Eric W. Biederman wrote:
> Jingbai Ma <jingbai.ma@hp.com> writes:
>
>> I found a side effect of unsetting BSP flag.
>> It affected system rebooting, once the BSP flags been removed, and issue
>> reboot command, system will hang after message:
>> Restarting system.
>> And have to do a hardware reset to recover it.
>>
>> I have reproduced this problem on the following systems:
>> HP EliteBook 6930p
>> HP Compaq DC7700
>> HP ProLiant DL980 (4 sockets, 40 cores)
>>
>> I have an idea: To avoid such kind of issue, we can unset BSP flag in
>> the first kernel during crash processing, and restore it in the second
>> kernel in the APs initializing.
>
> The premise was clearing BSP would not be an issue.  If we could
> reliably count on unsetting the BSP during crash processing we could
> just switch to the BSP and be done totally avoid this problem.
>
> Given that there are reald world issues with clearing the BSP flag,
> I believe the alternate suggestion was to simply never attempt to start
> the bootstrap processor during processor bring up.
>
> If as normal we are running on the bootstrap processor everything will
> work the same, but if we are in the kdump scenario we will be short one
> core.  Being short one core seems like a reasonable tradeoff between
> reliability and performance.
>
> Eric

Sorry Eric, I'm not clear to what you mean by ``short one core''...
Which are you suggesting? Disabling BSP if crash happens on AP is reasonable?
Or restricting cpus to a single one only just as the current kdump
configuration is reasonable?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
