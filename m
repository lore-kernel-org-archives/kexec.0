Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P0NDO-00039R-HE
	for kexec@lists.infradead.org; Mon, 27 Sep 2010 23:34:35 +0000
Message-ID: <4CA129EB.5000309@zytor.com>
Date: Mon, 27 Sep 2010 16:34:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: kexec load failure introduced by "x86,
	memblock: Replace e820_/_early string with memblock_"
References: <632974489.2046131285586512527.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<4CA11918.7050708@kernel.org> <4CA11FB7.2080101@zytor.com>
	<4CA126BE.7000609@kernel.org> <4CA1283C.9010105@zytor.com>
	<4CA12976.5060504@kernel.org>
In-Reply-To: <4CA12976.5060504@kernel.org>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, kexec <kexec@lists.infradead.org>, caiqian@redhat.com, linux-kernel@vger.kernel.org

On 09/27/2010 04:32 PM, Yinghai Lu wrote:
> On 09/27/2010 04:26 PM, H. Peter Anvin wrote:
>> On 09/27/2010 04:20 PM, Yinghai Lu wrote:
>>>
>>> x86 own version for find_area?
>>>
>>
>> No, double no.
>>
>> Same kind of crap: overloading an interface with semantics it shouldn't
>> have.  The right thing is to introduce a new interface with carries the
>> explicitly needed policy with it... e.g. memblock_find_in_range_lowest().
>>
>> That interface would have the explicit semantics of returning the lowest
>> possible address, as opposed to any suitable address (which may change
>> if policy requirements change.)
>>
>> The other question is why does kexec need this in the first place?  Is
>> this due to a design bug in kexec or is there some fundamental reason
>> for this?
> 
> bzImage is used here. so need range below 4g.
> 

OK, so why don't you cap the range to 4 GiB and then pass that down to
the existing interface?  That's different from "lowest possible address".

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
