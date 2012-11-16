Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZISl-0000Q6-Kn
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 09:43:52 +0000
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 16 Nov 2012 02:43:45 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 09A5A3E4003D
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 02:43:18 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAG9hJdO243116
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 02:43:19 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAG9hIEX023386
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 02:43:19 -0700
Message-ID: <50A60AB2.2040201@linux.vnet.ibm.com>
Date: Fri, 16 Nov 2012 15:13:14 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/7] Initialize and setup eppic
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121108133804.28410.99166.stgit@aravinda>
 <20121115160456.GG2529@redhat.com>
In-Reply-To: <20121115160456.GG2529@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, buendgen@de.ibm.com



On 2012-11-15 21:34, Vivek Goyal wrote:

> On Thu, Nov 08, 2012 at 07:08:04PM +0530, Aravinda Prasad wrote:
> 
> [..]
>> diff --git a/Makefile b/Makefile
>> index d5fc09e..3ac8e63 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -55,6 +55,13 @@ LIBS := -llzo2 $(LIBS)
>>  CFLAGS += -DUSELZO
>>  endif
>>  
>> +ifeq ($(EPPIC), on)
>> +LIBS := -leppic -ltinfo $(LIBS)
> 
> So you also pull in libarary "tinfo". Does that 1MB number include this
> too? What's the total size bloat for makedumpfile once we compile with
> EPPIC on.


Yes it includes. The actual size bloat for makedumpfile with EPPIC=on is
around 850KB

> 
> Thanks
> Vivek
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
