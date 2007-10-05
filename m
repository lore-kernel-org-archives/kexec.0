Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Idg2Q-0002Ar-HZ
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 06:47:53 +0100
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l955jlEB007761
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 14:45:47 +0900 (JST)
Message-ID: <4705CEEA.6060100@ah.jp.nec.com>
Date: Fri, 05 Oct 2007 14:43:06 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] add new notifier function
References: <4704D09D.6080503@ah.jp.nec.com> <20071005043354.GA4893@in.ibm.com>
In-Reply-To: <20071005043354.GA4893@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal wrote:
> On Thu, Oct 04, 2007 at 08:38:05PM +0900, Takenori Nagano wrote:
>
> In summary, right now co-existence of kdb with kdump seems to be your pain
> point. I would prefer that kdb just puts a break point on panic() and we move
> on. If there are more candidates down the line and these can't be easily
> executed in second kernel then we can re-visit this notification list
> mechanism.

Hi Vivek,

Thank you for your comment. :-)

I don't mind kdb and kdump problem now. Because my patches are not merged into
mainline kernel yet. If they are merged, I think how we can resolve about RAS
tools problem.

>> # ls
>> ipmi_msghandler  ipmi_wdog
>> # cat ipmi_msghandler/priority
>> 200
>> # cat ipmi_wdog/priority
>> 150
>> #
>> Kernel panic - not syncing: panic
>> ipmi_msghandler : notifier calls panic_event().
>> ipmi_watchdog : notifier calls wdog_panic_handler().
>>
>> .....(reboot)
>>
> 
> We also need to implement a file which can give a consolidated view. All
> the registered members and their priority.

I tried to implement it, but its impact is large. And we can get all priority
values using "ls" and "cat */priority". I'll implement it if user strongly
expects it.

ex)
# cd panic_notifier_list
# ls
ipmi_msghandler  ipmi_wdog
# cat */priority
200
150
#

Thanks,

Takenori Nagano <t-nagano@ah.jp.nec.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
