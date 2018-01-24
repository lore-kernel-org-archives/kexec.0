Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by casper.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eePS9-0002it-ST
 for kexec@lists.infradead.org; Wed, 24 Jan 2018 18:07:19 +0000
Subject: Re: [PATCH v2 2/2] kexec-tools: Make xc_dlhandle static
References: <1516734771-14795-1-git-send-email-eric.devolder@oracle.com>
 <1516734771-14795-3-git-send-email-eric.devolder@oracle.com>
 <20180123205914.GQ4675@olila.local.net-space.pl>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <88bcb0c6-6007-7de5-72a6-aeda57649478@oracle.com>
Date: Wed, 24 Jan 2018 12:07:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180123205914.GQ4675@olila.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

Daniel, thanks for the review, inline responses below.
eric

On 01/23/2018 02:59 PM, Daniel Kiper wrote:
> On Tue, Jan 23, 2018 at 01:12:51PM -0600, Eric DeVolder wrote:
>> This patch is a follow-on to commit 43d3932e "kexec-tools: Perform
>> run-time linking of libxenctrl.so". This patch addresses feedback
>> from Daniel Kiper.
>>
>> This patch implements Daniel's suggestion to make the
>> xc_dlhandle variable static.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> Just two nitpicks... Otherwise you can add
> 
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> 
>> ---
>> v1: 23jan2018
>>   - Implemented feedback from Daniel Kiper
>>
>> v2: 23jan2018
>>   - Implemented feedback from Daniel Kiper
>>   - Broke patch into two
>> ---
>>   kexec/kexec-xen.c | 9 ++++++++-
>>   kexec/kexec-xen.h | 9 ++++-----
>>   2 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
>> index 75f8758..960fa16 100644
>> --- a/kexec/kexec-xen.c
>> +++ b/kexec/kexec-xen.c
>> @@ -15,8 +15,15 @@
>>   #include "crashdump.h"
>>
>>   #ifdef CONFIG_LIBXENCTRL_DL
>> -void *xc_dlhandle;
>> +/* The handle from dlopen(), needed by dlsym(), dlclose() */
>> +static void *xc_dlhandle;
>>   xc_hypercall_buffer_t XC__HYPERCALL_BUFFER_NAME(HYPERCALL_BUFFER_NULL);
>> +
>> +void *__xc_dlsym(const char *symbol)
>> +{
>> +	return dlsym(xc_dlhandle, symbol);
>> +}
>> +
>>   xc_interface *__xc_interface_open(xentoollog_logger *logger,
>>   				  xentoollog_logger *dombuild_logger,
>>   				  unsigned open_flags)
>> diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
>> index ffb8743..8955334 100644
>> --- a/kexec/kexec-xen.h
>> +++ b/kexec/kexec-xen.h
>> @@ -6,9 +6,8 @@
>>
>>   #ifdef CONFIG_LIBXENCTRL_DL
>>   #include <dlfcn.h>
> 
> I think that you can drop this include too.

I did check and this is the only place in kexec-tools that includes this 
header file (it has the prototypes for dlopen/close/sym()). Without this 
header file included, compilation fails. Thus I've left it in.

> 
>> -
>> -/* The handle from dlopen(), needed by dlsym(), dlclose() */
>> -extern void *xc_dlhandle;
>> +/* Lookup symbols in libxenctrl.so */
>> +void *__xc_dlsym(const char *symbol);
> 
> extern void *__xc_dlsym(const char *symbol);?

Done for this and the others.

> 
> But then, IMO, you should put extern for __xc_interface_open()
> and __xc_interface_close() below too. You can do it in separate
> patch with Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> 
> Daniel

Thanks, I've posted v3 of this patch, including your RB.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
