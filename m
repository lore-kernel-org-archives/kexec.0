Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XMREx-0001IS-N5
 for kexec@lists.infradead.org; Wed, 27 Aug 2014 00:37:32 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v5 8/8] add a new interface to show the memory usage of
 1st kernel
Date: Wed, 27 Aug 2014 00:32:08 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97250016@BPXM01GP.gisp.nec.co.jp>
References: <1408937592-2609-1-git-send-email-bhe@redhat.com>
 <1408937592-2609-9-git-send-email-bhe@redhat.com>
 <20140825063622.GB1501@dhcp-16-105.nay.redhat.com>
 <20140825200418.GK14379@redhat.com>
 <20140826063709.GC15032@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20140826063709.GC15032@dhcp-16-116.nay.redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Hello Baoquan,

>On 08/25/14 at 04:04pm, Vivek Goyal wrote:
>> On Mon, Aug 25, 2014 at 02:36:22PM +0800, Baoquan He wrote:
>
>> > The print is like below:
>> >
>> > ~$ ./makedumpfile --mem-usage /proc/kcore
>> > The kernel version is not supported.
>> > The created dumpfile may be incomplete.
>>
>> I still think that above messages should go. It does not make
>> any sense with --mem-usage. No dumpfile is being created here.
>
>This is printed by function get_kernel_version(), it will be used by
>other makedumpfile main code flows too. This message is used to warn
>users that users' using kernel may not be tested suffciently. I think
>those tests are mainly taken by Atsushi. When he finished sufficient
>tests on a new version of kernel, the LATEST_VERSION will be changed to
>be a larger value. I am fine with this message, since it won't occur on
>our distribution, anyway kernel for distribution are all tested. And if
>LATEST_VERSION is older than our distribution kernel, maintainer may be
>pushed to take tests and update this value. So don't worry about this
>message.
>
>But I would like to change the message like below to clean up
>misunderstanding if Atsushi doesn't object, this mostly occur when
>people working on latest upstream kernel.
>-------------------------------------------------
>The kernel version is not supported.
>The makedumpfile operation may not be successful.
>--------------------------------------------------

Good change, let's do it. --mem-usage doesn't create a dumpfile
but the behavior still depend on the kernel version, this message
is meaningful. Also, as Vivek said, the latter line can be
changed based on the operating mode, but I don't think it's
necessary.

>>
>> > Excluding unnecessary pages        : [100.0 %] |
>>
>>
>> >
>> > Page number of memory in different use
>> > --------------------------------------------------
>>
>> I think above header can completely go away.  It kind of looks odd.
>
>OK, will remove it.
>
>>
>> > TYPE		PAGES			EXCLUDABLE	DESCRIPTION
>> > ZERO		29149           	yes		Pages filled with zero
>> > CACHE		171288          	yes		Cache pages
>> > CACHE_PRIVATE	12051           	yes		Cache pages + private
>> > USER		31816           	yes		User process pages
>> > FREE		3700059         	yes		Free pages
>> > KERN_DATA	105305          	no		Dumpable kernel data
>> >
>> > Total pages on system:	4049668
>> >
>> > Showing page number of memory in different use successfully.
>>
>> I think we don't need above line. I am not even sure what does it mean.
>
>Will remove it.
>
>> >
>> > makedumpfile Completed.
>>
>> We don't need above line either.
>
>This is also a public message printing, means if makedumpfile operation
>is successful or not. Maybe I can add a check like below:
>
>@@ -9546,7 +9553,7 @@ main(int argc, char *argv[])
>        retcd = COMPLETED;
> out:
>        MSG("\n");
>-       if (retcd == COMPLETED)
>+       if ((retcd == COMPLETED) && (!info->flag_mem_usage))
>                MSG("makedumpfile Completed.\n");
>        else
>                MSG("makedumpfile Failed.\n");

This code always show "makedumpfile Failed" for --mem-usage :-)

Anyway,

>Hi Atsushi,
>
>How do you think about this? And for the excluding progress indication
>too, add a check that if it's mem-usage handling, not printing.

I don't think we need to change the both messages, they indicate
the actual progress and result even in the mem-usage mode.


Thanks
Atsushi Kumagai

>Thanks
>Baoquan
>
>>
>> In output we should just show the actual table. If there is an error,
>> we should output error and exit (no table).
>
>>
>> Thanks
>> Vivek
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
