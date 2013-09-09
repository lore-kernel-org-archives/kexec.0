Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIvOD-0005qS-3h
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 06:56:02 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 365DD3EE0BB
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:55:39 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2807645DE4E
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:55:39 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 00E5445DE4D
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:55:39 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E93981DB8041
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:55:38 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 847A21DB8037
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:55:38 +0900 (JST)
Message-ID: <522D70C9.9050306@jp.fujitsu.com>
Date: Mon, 09 Sep 2013 15:55:05 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: search for a debug vmlinux
References: <E1VEnuJ-0000KR-TT@eag09.americas.sgi.com>
 <521FF12D.3050505@jp.fujitsu.com> <20130903184809.GB13282@sgi.com>
In-Reply-To: <20130903184809.GB13282@sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

(2013/09/04 3:48), Cliff Wickman wrote:
> On Fri, Aug 30, 2013 at 10:11:09AM +0900, HATAYAMA Daisuke wrote:
>> (2013/08/29 7:08), Cliff Wickman wrote:
>>> From: Cliff Wickman <cpw@sgi.com>
>>>
>>>
>>> makedumpfile needs the debug info from either /proc/vmcore or in vmlinux
>>> to know how to find free pages using the buddy method.
>>>
>>> The distro procedures do not pass the vmlinux (with the -x option), so
>>> add a search for a debug vmlinux in the usual locations.
>>> It's not needed if the page info is in vmcore.  But warn if it is found
>>> in neither place.
>>>
>>
>> makedumpfile is designed to get necessary debug information from VMCOREINFO note
>> available from /proc/vmcore. Why do you need vmlinux?
>
> The vmcore doesn't always provide the page structure information.
> Specifically, the offset of 'private' and '_mapcount' in the page
> structure, which are needed for identification of user huge pages.
> (I've seen this to be true on a sles11s2 and rhel65 (3.0.80 2.6.32-410))
> I'm using the huge page patch from Petr Tesarik. The one that I think you
> said Kumagai-san is reworking.
>

I don't know your situation in each distribution, but simply, you should post
patch to distribution sides, not upstream makedumpfile. Try to extend VMCOREINFO in
kernels or add the workaround of this patch series in makedumpfile on each
distributions.

Also, I think automatic search is not absolutely necessary. It's enough to
specify vmlinux path manually in configuration file. Using vmlinux file itself is
possible without any problem. This workaround doesn't need makedumpfile change.

If you still want automatic search, it's enough to prepare a script that does that
and add it to initramfs by extra_bins directive and then specify it in core_collector
directive. This is way on RHEL. I don't way on SLES, but it's SLES issue.

> I did improve my patch, as provided below.
> The below version does not try to replace the debuginfo from vmcore, but
> only to extract the few bits of page structure information needed for
> the Tesarik patch.
>
> You may not see the need for the additional (page) info on current kernels.
> So I understand that you may not be interested in this patch, as it may
> not be needed for kernels that are current when the huge page
> identification patch is ready.
>
> -Cliff

kdump framework is designed carefully, primarily focusing on how to keep
reliability. Not assuming root device in the 2nd kernel is one of them.
Keeping reliability is more important. We should not break that by this kind of
workaround.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
