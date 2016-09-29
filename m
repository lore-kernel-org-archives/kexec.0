Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpW5W-000615-01
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 07:49:02 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T7mIge129291
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 03:48:40 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25rq5xaxny-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 03:48:40 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 17:48:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6AC7D2BB005B
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 17:48:34 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8T7mYvJ46727264
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 17:48:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8T7mYhs003201
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 17:48:34 +1000
Subject: Re: [PATCH] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
References: <1474615059-9510-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160923095046.GB22928@localhost.localdomain>
 <20160929074122.GC14497@verge.net.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 29 Sep 2016 13:18:32 +0530
MIME-Version: 1.0
In-Reply-To: <20160929074122.GC14497@verge.net.au>
Message-Id: <86b7bdc5-e943-ec5e-7bd9-a306f050e82a@linux.vnet.ibm.com>
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
To: Simon Horman <horms@verge.net.au>, Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org



On Thursday 29 September 2016 01:11 PM, Simon Horman wrote:
> On Fri, Sep 23, 2016 at 03:20:46PM +0530, Pratyush Anand wrote:
>> On 23/09/2016:12:47:39 PM, Madhavan Srinivasan wrote:
>>> In dt_copy_old_root_param(), FILE * returned
>>> from fopen is not checked for NULL pointer
>>> before passinig to fclose(). This could trigger
>>> a segfault. Patch adds a check.
>>>
>>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>> ---
>>>   kexec/fs2dt.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
>>> index 6ed2399759cf..2c1ebdf525f4 100644
>>> --- a/kexec/fs2dt.c
>>> +++ b/kexec/fs2dt.c
>>> @@ -540,7 +540,8 @@ static void dt_copy_old_root_param(void)
>>>   	if (last_cmdline)
>>>   		free(last_cmdline);
>>>   
>>> -	fclose(fp);
>>> +	if (fp)
>>> +		fclose(fp);
>> Looks fine, however a better practise could be to return just after fopen() if
>> fp was null.
> That sounds like it would be somewhat cleaner.
> Madhavan, could you see about making it so?

Yep. re-spinning now.

Maddy


>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
