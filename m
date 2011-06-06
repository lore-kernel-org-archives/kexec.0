Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QTY01-0002bP-FU
	for kexec@lists.infradead.org; Mon, 06 Jun 2011 11:29:38 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p56BFPml004253
	for <kexec@lists.infradead.org>; Mon, 6 Jun 2011 05:15:25 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p56BTWda153984
	for <kexec@lists.infradead.org>; Mon, 6 Jun 2011 05:29:32 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p565TUSk029964
	for <kexec@lists.infradead.org>; Sun, 5 Jun 2011 23:29:30 -0600
Message-ID: <4DECBA16.7070300@in.ibm.com>
Date: Mon, 06 Jun 2011 16:59:26 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] powerpc: Use the #address-cells information to
	parsememory/reg
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AD73@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD73@saturn3.aculab.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>

On 06/06/11 14:30, David Laight wrote:
>>> Changed the add_usable_mem_property() to accept FILE* fp instead of
> int fd,
>>> as most of the other users of read_memory_region_limits() deals with
> FILE*.
>>>
>>> Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>
>>
>> Could you please let me know your thoughts/comments about this patch ?
>
> Is the change to use 'FILE *' actually progress?
> I'd have thought that the randomly aligned read/lseek system calls
> that this allows to happen are not desirable for anything that
> isn't a true file.
I will revert the other users back to 'fd'
>
> I'd also suggest that the sizeof's should be applied to the
> actual type of the variable being read/written, not arbitrarily
> 'long' or 'int', and this probably ought to be some fixed size type.
I have used 'unsigned long'(for word sized values) or 'unsigned long long'
(for double words) just to make sure we get the right values. Is this OK ?

Thanks
Suzuki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
