Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dqLhV-0004Lk-7x
 for kexec@lists.infradead.org; Fri, 08 Sep 2017 16:00:15 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v88FxELg102912
 for <kexec@lists.infradead.org>; Fri, 8 Sep 2017 11:59:52 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cuuw0856k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 08 Sep 2017 11:59:52 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 8 Sep 2017 09:59:51 -0600
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-10-takahiro.akashi@linaro.org>
 <20170824170440.GD29665@leverpostej>
 <20170825012103.GB7245@akashi-kouhiroshi-no-MacBook-Air.local>
 <20170825104133.GB3127@leverpostej> <20170908025044.GD17186@linaro.org>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/14] arm64: kexec_file: add sha256 digest check in
 purgatory
In-reply-to: <20170908025044.GD17186@linaro.org>
Date: Fri, 08 Sep 2017 12:59:38 -0300
MIME-Version: 1.0
Message-Id: <87lglpp4et.fsf@linux.vnet.ibm.com>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, akpm@linux-foundation.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com


AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
> On Fri, Aug 25, 2017 at 11:41:33AM +0100, Mark Rutland wrote:
>> On Fri, Aug 25, 2017 at 10:21:06AM +0900, AKASHI Takahiro wrote:
>> > On Thu, Aug 24, 2017 at 06:04:40PM +0100, Mark Rutland wrote:
>> > > On Thu, Aug 24, 2017 at 05:18:06PM +0900, AKASHI Takahiro wrote:
>> > > > +void *memcpy(void *dst, const void *src, size_t len)
>> > > > +{
>> > > > +	int i;
>> > > > +
>> > > > +	for (i = 0; i < len; i++)
>> > > > +		((u8 *)dst)[i] = ((u8 *)src)[i];
>> > > > +
>> > > > +	return NULL;
>> > > > +}
>> > > > +
>> > > > +void *memset(void *dst, int c, size_t len)
>> > > > +{
>> > > > +	int i;
>> > > > +
>> > > > +	for (i = 0; i < len; i++)
>> > > > +		((u8 *)dst)[i] = (u8)c;
>> > > > +
>> > > > +	return NULL;
>> > > > +}
>> > > > +
>> > > > +int memcmp(const void *src, const void *dst, size_t len)
>> > > > +{
>> > > > +	int i;
>> > > > +
>> > > > +	for (i = 0; i < len; i++)
>> > > > +		if (*(char *)src != *(char *)dst)
>> > > > +			return 1;
>> > > > +
>> > > > +	return 0;
>> > > > +}
>> > > 
>> > > How is the compiler prevented from "optimising" these into calls to
>> > > themselves?
>> > 
>> > I don't get what you mean by "calls to themselves."
>> 
>> There are compiler optimizations that recognise sequences like:
>> 
>> 	for (i = 0; i < len; i++)
>> 		dst[i] = src[i];
>> 
>> ... and turn those into:
>> 
>> 	memcpy(dst, src, len);
>> 
>> ... these have been known to "optimize" memcpy implementations into
>> calls to themselves. Likewise for other string operations.
>> 
>> One way we avoid that today is by writing our memcpy in assembly.
>
> I see, thanks.
>
>> Do we have a guarnatee that this will not happen here? e.g. do we pass
>> some compiler flag that prevents this?
>
> I don't know any options to do this.
> (maybe -nostdlib?)

kexec-tools calls gcc with -fno-builtin -ffreestanding (though according
to the man page, the former is implied in the latter), which tells the
compiler that the standard library may not exist. I don't know
specifically that this options turns off the memcpy optimization, but it
seems logical that it does.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
