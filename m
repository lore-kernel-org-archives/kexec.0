Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XHpdT-00087a-VO
 for kexec@lists.infradead.org; Thu, 14 Aug 2014 07:39:48 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [Patch v3 3/7] preparation functions for parsing vmcoreinfo
Date: Thu, 14 Aug 2014 07:37:52 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9724CA25@BPXM01GP.gisp.nec.co.jp>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-4-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246615@BPXM01GP.gisp.nec.co.jp>
 <20140812094623.GB4887@dhcp-16-105.nay.redhat.com>
 <20140812100156.GC4887@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20140812100156.GC4887@dhcp-16-105.nay.redhat.com>
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

>On 08/12/14 at 05:46pm, Baoquan He wrote:
>> On 08/01/14 at 07:12am, Atsushi Kumagai wrote:
>> > >diff --git a/makedumpfile.c b/makedumpfile.c
>> > >index 220570e..78aa7a5 100644
>> > >--- a/makedumpfile.c
>> > >+++ b/makedumpfile.c
>> > >@@ -681,6 +681,10 @@ get_kernel_version(char *release)
>> > > 	int32_t version;
>> > > 	long maj, min, rel;
>> > > 	char *start, *end;
>> > >+	static int done = 0;
>> > >+
>> > >+	if (done)
>> > >+		return info->kernel_version;
>> >
>> > This function just convert the argument as string into
>> > a number, it shouldn't be affected by external factors.
>> >
>> > You should use info->kernel_version in the caller side if
>> > you want to avoid duplicate calling of this function, but
>> > I think it's unnecessary since this function is small.
>>
>> In show_mem_usage() implementaion, the page_offset is needed before
>> initial() calling because the dumpable elf program loads have ot be
>> prepared before that. However in current commited code, the page_offset
>> is got in initial() when call check_release().
>>
>> So I have to get it in advance by this way. Then the
>> get_kernel_version() can be reused in this way. Anyway, by this I
>> needn't change the code in initial().
>>
>> If use info->kernel_version directly before initial() calling, it's
>> still zero.
>>
>
>I add the static variable "done" just because it always print below
>warning message twice, this makes me uncomfortable. Otherwise
>get_kernel_version() can be called any time no matter how many times it
>has been called if it's only a converting utility function.
>
>The kernel version is not supported.
>The created dumpfile may be incomplete.

Yeah, I understand the reason.
I agree with your idea, but I think it's better to check the
kernel_version directly like:

	if (info->kernel_version)
		return info->kernel_version;


Thanks
Atsushi Kumagai

>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
