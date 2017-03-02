Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjJbF-0004ym-DD
 for kexec@lists.infradead.org; Thu, 02 Mar 2017 05:48:27 +0000
Received: by mail-pg0-f44.google.com with SMTP id 25so28454594pgy.0
 for <kexec@lists.infradead.org>; Wed, 01 Mar 2017 21:48:05 -0800 (PST)
Subject: Re: [Makedumpfile Patch v2 7/7] mem-usage: allow to work only with -f
 for kernel version < 4.11
References: <cover.1488260510.git.panand@redhat.com>
 <72c8ce7c8c2a54714a8338a08e2ab5ae31e6d4e2.1488260510.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EAA666@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <ccd8139b-e5a4-3167-aa5b-94f86689767b@redhat.com>
Date: Thu, 2 Mar 2017 11:18:00 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EAA666@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

Hi Atsushi,

On Thursday 02 March 2017 10:19 AM, Atsushi Kumagai wrote:
> Hello Pratyush,
>
>> PT_LOAD of kcore does not have valid p_paddr values for kernel version
>> less that v4.11. Therefore, older kernel will no long work for mem-usage
>> with current makedumpfile code. They can only work when they are patched
>> with fix to "update physical address for kcore ram and text".
>>
>> This patch fixes the makedumpfile so that it does not allow to work
>> older kernel for --mem-usage until someone is sure that kernel is
>> rightly patched and so uses -f in command line.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>> makedumpfile.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 3b8e9810468d..bf006ea5dd5f 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -11269,6 +11269,12 @@ main(int argc, char *argv[])
>> 			MSG("Try `makedumpfile --help' for more information.\n");
>> 			goto out;
>> 		}
>> +		if (info->kernel_version < KERNEL_VERSION(4, 11, 0) &&
>> +				!info->flag_force) {
>> +			MSG("mem-usage not supported for this kernel.\n");
>> +			MSG("You can try with -f if your kernel's kcore has valid p_paddr\n");
>> +			return COMPLETED;
>> +		}
>
> Should use "goto out" to prevent memory leaks since some heap blocks are
> allocated at the head of main().

OK

>
> BTW, the descriptions of -f option in man and print_usage() don't mention this usage:
>
>        -f     Force existing DUMPFILE to be overwritten.
>               Example:
>               # makedumpfile -f -d 31 -x vmlinux /proc/vmcore dumpfile
>               This command overwrites DUMPFILE even if it already exists.
>
> so they should be updated.

Does following looks fine to you?

$ makedumpfile --help | grep -A3 "\-f"
   [-f]:
       Overwrite DUMPFILE even if it already exists
       Force mem-usage to work with older kernel as well.


$ man makedumpfile | grep -w "\-f  " -A6
        -f     Force existing DUMPFILE to be overwritten and mem-usage 
to work with older kernel as well.
               Example:
               # makedumpfile -f -d 31 -x vmlinux /proc/vmcore dumpfile
               This command overwrites DUMPFILE even if it already exists.
               # makedumpfile -f --mem-usage /proc/kcore
               Kernel version lesser than v4.11 will not work with 
--mem-usage functionality until it has been  patched  with  upstream  commit
               464920104bf7.  Therefore if you have patched your older 
kernel then use -f.

Thanks for the review.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
