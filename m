Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LKZNl-0002Sh-PH
	for kexec@lists.infradead.org; Wed, 07 Jan 2009 14:27:43 +0000
In-Reply-To: <1231296172.8292.20.camel@localhost>
References: <kexec-29-1-1r.miltonm@bga.com>
	<1231296172.8292.20.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <2078205b8668529382796ad92bc66ab3@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH kexec-tools 1/5] ppc64: always check number of ranges when
	adding
Date: Wed, 7 Jan 2009 08:34:09 -0600
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: michael@ellerman.id.au
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "M. Mohan Kumar" <mohan@in.ibm.com>

On Jan 6, 2009, at 8:42 PM, Michael Ellerman wrote:
> On Fri, 2009-01-02 at 15:04 -0600, Milton Miller wrote:
>> make the idom "always call realloc_memory_ranges when filling a range 
>> entry"

>> @@ -666,6 +674,8 @@ int setup_memory_ranges(unsigned long ke
>>  		memory_range[j].end = exclude_range[i+1].start - 1;
>>  		memory_range[j].type = RANGE_RAM;
>>  		j++;
>> +		if (i >= max_memory_ranges)
>> +			realloc_memory_ranges();
>
> Should this be checking against i or j?
>

It does look like it should be against j.  I'll build test and respin 
later.

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
