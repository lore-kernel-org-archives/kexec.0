Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from omzsmtpe04.verizonbusiness.com ([199.249.25.207])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VzYkA-0005kY-Cx
 for kexec@lists.infradead.org; Sat, 04 Jan 2014 21:26:55 +0000
From: Don Slutz <dslutz@verizon.com>
Message-ID: <52C87C86.1070901@terremark.com>
Date: Sat, 04 Jan 2014 16:26:30 -0500
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 1/4] Make domian.is_hvm optional
References: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
 <1388862686-1832-2-git-send-email-dslutz@verizon.com>
 <20140104211347.GD9395@phenom.dumpdata.com>
In-Reply-To: <20140104211347.GD9395@phenom.dumpdata.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Don Slutz <dslutz@verizon.com>, xen-devel@lists.xen.org, crash-utility@redhat.com

On 01/04/14 16:13, Konrad Rzeszutek Wilk wrote:
> On Sat, Jan 04, 2014 at 02:11:23PM -0500, Don Slutz wrote:
>
> You title should say 'domain'.
>
Will fix.
     -Don Slutz
>> ---
>>   xen_hyper.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/xen_hyper.c b/xen_hyper.c
>> index 7c7d3e1..3d56516 100644
>> --- a/xen_hyper.c
>> +++ b/xen_hyper.c
>> @@ -1247,7 +1247,8 @@ xen_hyper_store_domain_context(struct xen_hyper_domain_context *dc,
>>   		dc->domain_flags = ULONG(dp + XEN_HYPER_OFFSET(domain_domain_flags));
>>   	else if (XEN_HYPER_VALID_MEMBER(domain_is_shut_down)) {
>>   		dc->domain_flags = 0;
>> -		if (*(dp + XEN_HYPER_OFFSET(domain_is_hvm))) {
>> +                if (XEN_HYPER_VALID_MEMBER(domain_is_hvm) &&
>> +                    *(dp + XEN_HYPER_OFFSET(domain_is_hvm))) {
>>   			dc->domain_flags |= XEN_HYPER_DOMS_HVM;
>>   		} else if (*(dp + XEN_HYPER_OFFSET(domain_is_privileged))) {
>>   			dc->domain_flags |= XEN_HYPER_DOMS_privileged;
>> -- 
>> 1.8.4
>>
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xen.org
>> http://lists.xen.org/xen-devel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
