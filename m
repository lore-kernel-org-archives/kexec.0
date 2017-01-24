Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cW9sr-0003E4-Bj
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 22:48:15 +0000
Subject: Re: [PATCH v3] kexec: implemented XEN KEXEC STATUS to determine if an
 image is loaded
References: <1485284135-3058-1-git-send-email-eric.devolder@oracle.com>
 <20170124191640.GC16671@olila.local.net-space.pl>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <87de0f8a-21b9-8aa4-f07b-78083f2610c2@oracle.com>
Date: Tue, 24 Jan 2017 16:47:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170124191640.GC16671@olila.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com, xen-devel@lists.xenproject.org

On 01/24/2017 01:16 PM, Daniel Kiper wrote:
> On Tue, Jan 24, 2017 at 12:55:35PM -0600, Eric DeVolder wrote:
>> Instead of the scripts having to poke at various fields we can
>> provide that functionality via the -S parameter.
>>
>> kexec_loaded/kexec_crash_loaded exposes Linux kernel kexec/crash
>> state. It does not say anything about Xen kexec/crash state. So,
>> we need a special approach to get the latter. Though for
>> compatibility we provide similar functionality in kexec-tools
>> for the former.
>>
>> This change enables the --status or -S option to work either
>> with or without Xen.
>>
>> Returns 0 if the payload is loaded. Can be used in combination
>> with -l or -p to get the state of the proper kexec image.
>>
>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>> Note: The corresponding Xen changes have been committed
>> to the Xen staging branch. Follow this thread:
>> https://lists.xenproject.org/archives/html/xen-devel/2017-01/msg01570.html
>>
>> CC: Andrew Cooper <andrew.cooper3@citrix.com>
>> CC: kexec@lists.infradead.org
>> CC: xen-devel@lists.xenproject.org
>> CC: Daniel Kiper <daniel.kiper@oracle.com>
>>
>> v0: First version (internal product).
>> v1: Posted on kexec mailing list. Changed -s to -S
>> v2: Incorporated feedback from kexec mailing list, posted on kexec mailing list
>> v3: Incorporated feedback from kexec mailing list
>> ---
>>  configure.ac      |  8 ++++++-
>>  kexec/kexec-xen.c | 26 +++++++++++++++++++++++
>>  kexec/kexec.8     |  6 ++++++
>>  kexec/kexec.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>>  kexec/kexec.h     |  5 ++++-
>>  5 files changed, 98 insertions(+), 9 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 3044185..c6e864b 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -165,8 +165,14 @@ fi
>>  dnl find Xen control stack libraries
>>  if test "$with_xen" = yes ; then
>>  	AC_CHECK_HEADER(xenctrl.h,
>> -		[AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
>> +		[AC_CHECK_LIB(xenctrl, xc_kexec_load, [ have_xenctrl_h=yes ],
>>  		AC_MSG_NOTICE([Xen support disabled]))])
>> +if test "$have_xenctrl_h" = yes ; then
>> +	AC_CHECK_LIB(xenctrl, xc_kexec_status,
>> +		AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
>> +			[The kexec_status call is available]),
>> +		AC_MSG_NOTICE([The kexec_status call is not available]))
>> +fi
>
> I have a feeling that you have missed my comment. Please add two TABs
> starting from "+if test "$have_xenctrl_h" = yes ; then" up to "+fi".
> So, it should look more or less like this:
>
> 		AC_MSG_NOTICE([Xen support disabled]))])
> +		if test "$have_xenctrl_h" = yes ; then
> +			AC_CHECK_LIB(xenctrl, xc_kexec_status,
> ...
>
> If it is not needed or something like that please drop me a line.
>
>>  fi
>>
>>  dnl ---Sanity checks
>> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
>> index 24a4191..2b448d3 100644
>> --- a/kexec/kexec-xen.c
>> +++ b/kexec/kexec-xen.c
>> @@ -105,6 +105,27 @@ int xen_kexec_unload(uint64_t kexec_flags)
>>  	return ret;
>>  }
>>
>> +int xen_kexec_status(uint64_t kexec_flags)
>> +{
>> +	xc_interface *xch;
>> +	uint8_t type;
>> +	int ret = -1;
>> +
>> +#ifdef HAVE_KEXEC_CMD_STATUS
>> +	xch = xc_interface_open(NULL, NULL, 0);
>> +	if (!xch)
>> +		return -1;
>> +
>> +	type = (kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>> +
>> +	ret = xc_kexec_status(xch, type);
>> +
>> +	xc_interface_close(xch);
>> +#endif
>> +
>> +	return ret;
>> +}
>> +
>>  void xen_kexec_exec(void)
>>  {
>>  	xc_interface *xch;
>> @@ -130,6 +151,11 @@ int xen_kexec_unload(uint64_t kexec_flags)
>>  	return -1;
>>  }
>>
>> +int xen_kexec_status(uint64_t kexec_flags)
>> +{
>> +	return -1;
>> +}
>> +
>>  void xen_kexec_exec(void)
>>  {
>>  }
>> diff --git a/kexec/kexec.8 b/kexec/kexec.8
>> index 4d0c1d1..f4b39a6 100644
>> --- a/kexec/kexec.8
>> +++ b/kexec/kexec.8
>> @@ -107,6 +107,12 @@ command:
>>  .B \-d\ (\-\-debug)
>>  Enable debugging messages.
>>  .TP
>> +.B \-S\ (\-\-status)
>> +Return 0 if the type (by default crash) is loaded. Can be used in conjuction
>> +with -l or -p to toggle the type. Note this option supersedes other options
>> +and it will
>> +.BR not\ load\ or\ unload\ the\ kernel.
>
> Same as above. I think that you have missed my earlier comments.
> I suppose that you can join "+and it will" and "+.BR not\ load\ or\
> unload\ the\ kernel." into one line.
>
>> +.TP
>>  .B \-e\ (\-\-exec)
>>  Run the currently loaded kernel. Note that it will reboot into the loaded kernel without calling shutdown(8).
>>  .TP
>> diff --git a/kexec/kexec.c b/kexec/kexec.c
>> index 500e5a9..defbbe3 100644
>> --- a/kexec/kexec.c
>> +++ b/kexec/kexec.c
>> @@ -51,6 +51,9 @@
>>  #include "kexec-lzma.h"
>>  #include <arch/options.h>
>>
>> +#define KEXEC_LOADED_PATH "/sys/kernel/kexec_loaded"
>> +#define KEXEC_CRASH_LOADED_PATH "/sys/kernel/kexec_crash_loaded"
>> +
>>  unsigned long long mem_min = 0;
>>  unsigned long long mem_max = ULONG_MAX;
>>  static unsigned long kexec_flags = 0;
>> @@ -58,6 +61,8 @@ static unsigned long kexec_flags = 0;
>>  static unsigned long kexec_file_flags = 0;
>>  int kexec_debug = 0;
>>
>> +static int kexec_loaded(const char *file);
>> +
>
> Why are you shuffling this...
>
>>  void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
>>  {
>>  	int i;
>> @@ -890,8 +895,6 @@ static int my_exec(void)
>>  	return -1;
>>  }
>>
>> -static int kexec_loaded(void);
>> -
>
> ...and this. Could not you leave this forward declaration here (of
> course with arg change)? Or is it possible to drop it at all?

It is possible to relocate kexec_loaded() so that the forward 
declaration is not needed. I will do so.

eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
