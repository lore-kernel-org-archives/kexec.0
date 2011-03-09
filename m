Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PxCwR-0001rb-MK
	for kexec@lists.infradead.org; Wed, 09 Mar 2011 06:32:16 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.4/8.13.1) with ESMTP id p296W8xa030902
	for <kexec@lists.infradead.org>; Wed, 9 Mar 2011 12:02:08 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p296W8AE872636
	for <kexec@lists.infradead.org>; Wed, 9 Mar 2011 12:02:08 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p296W7xw009096
	for <kexec@lists.infradead.org>; Wed, 9 Mar 2011 17:32:07 +1100
Message-ID: <4D771EE6.5050404@linux.vnet.ibm.com>
Date: Wed, 09 Mar 2011 12:02:06 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
In-Reply-To: <m139u37cii.fsf@fess.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, kexec@lists.infradead.org, Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org

On 08/25/2010 06:07 AM, Eric W. Biederman wrote:
> Anton Blanchard <anton@samba.org> writes:
> 
>> On ppc64 the crashkernel region almost always overlaps an area of firmware.
>> This works fine except when using the sysfs interface to reduce the kdump
>> region. If we free the firmware area we are guaranteed to crash.
> 
> That is ppc64 bug.  firmware should not be in the reserved region.  Any
> random kernel like thing can be put in to that region at any valid
> address and the fact that shrinking the region frees your firmware means
> that using that region could also stomp your firmware (which I assume
> would be a bad thing).
The issue only happens while shrinking the region using sysfs interface.
We already have checks in kexec for not to stomp over on the firmware
overlap area while loading capture kernel. Currently we do a top-down
allocation for the firmware region which means it sits at the top of the
RMO, right in the middle of the crashdump region. We can not move the
crashkernel region beyond firmware region because kernel needs its some
of memory in RMO region.
> 
> So please fix the ppc64 reservation.
> 
> Eric
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
