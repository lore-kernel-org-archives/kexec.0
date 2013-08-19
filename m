Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VBLYD-0008Gr-I1
 for kexec@lists.infradead.org; Mon, 19 Aug 2013 09:15:02 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6CC6C3EE1DA
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 18:14:33 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5CFE245DE53
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 18:14:33 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 40A3E45DE4E
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 18:14:33 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2D0CC1DB803F
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 18:14:33 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id D7D251DB8037
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2013 18:14:32 +0900 (JST)
Message-ID: <5211E1C3.7090009@jp.fujitsu.com>
Date: Mon, 19 Aug 2013 18:13:39 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [Help Test] kdump, x86, acpi: Reproduce CPU0 SMI corruption issue
 after unsetting BSP flag
References: <5200BFB3.2050202@jp.fujitsu.com> <520A10A3.5080303@hp.com>
 <520B4A22.2030800@hp.com> <87ob90839p.fsf@xmission.com>
 <5211831B.6090704@jp.fujitsu.com>
 <a2ff8170-41ad-42f6-9015-850dbe14983d@email.android.com>
In-Reply-To: <a2ff8170-41ad-42f6-9015-850dbe14983d@email.android.com>
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

(2013/08/19 11:59), Eric W. Biederman wrote:
>
>
>
>>
>> Sorry Eric, I'm not clear to what you mean by ``short one core''...
>> Which are you suggesting? Disabling BSP if crash happens on AP is
>> reasonable?
>> Or restricting cpus to a single one only just as the current kdump
>> configuration is reasonable?
>
> I am suggesting we start every cpu except the BSP from the AP we started on.
>
> N-1 cpus seems like a good tradeoff between performance and reliability for those who need it.
>
> Eric
>

Thanks. I'm now clear.

Well, I'll post a version 2 patch after upgrading it for current upstream kernel.
But it would be next week or later.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
