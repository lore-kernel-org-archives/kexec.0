Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2on0131.outbound.protection.outlook.com
 ([207.46.100.131] helo=na01-by2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aZfTu-0000Ox-TY
 for kexec@lists.infradead.org; Sat, 27 Feb 2016 14:04:28 +0000
Subject: Re: [Crash-utility] makedumpfile: 4.5 kernel commit breaks page
 filtering
References: <349750156.30030224.1455814657685.JavaMail.zimbra@redhat.com>
 <649995246.30033929.1455815111557.JavaMail.zimbra@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E21775@BPXM01GP.gisp.nec.co.jp>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E24FD4@BPXM01GP.gisp.nec.co.jp>
From: Joe Lawrence <joe.lawrence@stratus.com>
Message-ID: <56D1ACC8.3000400@stratus.com>
Date: Sat, 27 Feb 2016 09:03:52 -0500
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E24FD4@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, "anderson@redhat.com" <anderson@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Laurence Oberman <loberman@redhat.com>, "Discussion list for crash utility usage, 
 maintenance and development" <crash-utility@redhat.com>

On 02/25/2016 07:35 PM, Atsushi Kumagai wrote:
> Hello Dave,
>
>>> Note that PAGE_MAPPING_ANON is now only set in the compound_head page,
>>> so when makedumpfile walks though the pages, it will have to look
>>> at each page's head page for the bit setting.
>>
>> Thanks for your report.
>> As you said, it seems checking the head page like kernel does is necessary.
>> I'll try to work it out, please give me some time.
>
> Reading head page's page->mapping for each tail page will take extra time,
> so I contrived another way.
>
> It's just skipping compound tail pages for filtering.
> If makedumpfile excludes compound pages, it will be done at a time by
> exclude_range() at the time of checking the compound head page. We don't
> need to check compound tail pages individually.
>
> I made the patch, could you test the *compound* branch below ?
> This version requires a new unexported symbol, you need to specify
> -x vmlinux for now.
>
>    https://sourceforge.net/p/makedumpfile/code/ci/compound/tree/

Hi Atsushi, Dave,

Running the makedumpfile compound branch on 4.5-rc5 and this kdump.conf 
setting:

core_collector makedumpfile -l --message-level 1 -d 31 -x 
/kdumproot/var/crash/vmlinux

I was able to collect and successfully read a few test dumps without 
incident.  This was inside a VM without any interesting system load, but 
was regularly giving me issues before the patch.

Regards,

-- Joe

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
