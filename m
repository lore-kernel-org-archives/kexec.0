Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PzXTz-0003Fw-Nc
	for kexec@lists.infradead.org; Tue, 15 Mar 2011 16:52:32 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p2FGlI7S019915
	for <kexec@lists.infradead.org>; Wed, 16 Mar 2011 03:47:18 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2FGqPD62416750
	for <kexec@lists.infradead.org>; Wed, 16 Mar 2011 03:52:25 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2FGqOmY015816
	for <kexec@lists.infradead.org>; Wed, 16 Mar 2011 03:52:25 +1100
Date: Tue, 15 Mar 2011 22:22:19 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
Message-ID: <20110315165219.GA22509@in.ibm.com>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
	<20110309234657.264d3080@kryten>
	<20110309142108.GD16951@cr0.redhat.com>
	<20110314181315.GA16075@in.ibm.com>
	<AANLkTi=aDzCaa7_=5XTrnJCzmZPrDy3omXwDarEF8XmH@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=aDzCaa7_=5XTrnJCzmZPrDy3omXwDarEF8XmH@mail.gmail.com>
Reply-To: mahesh@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>, akpm@linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Mar 15, 2011 at 03:52:38PM +0800, Am=E9rico Wang wrote:
> On Tue, Mar 15, 2011 at 2:13 AM, Mahesh J Salgaonkar
> <mahesh@linux.vnet.ibm.com> wrote:
> >
> > During free we do free all of them including RMO region. But since the =
rtas
> > region is always on top of RMO, crashkernel memory overlaps rtas region=
 and
> > we endup freeing that even, which is causing the crash.
> >
> =

> Okay, but with this patch applied, we will just ignore rtas region, right?
Correct.
> Thus, when I echo 0 to free all the 128M crashkernel memory, the final
> result will be 32M left, which means crash_size will still show 32M.
> This looks odd.
> =

> How about skipping the 32M as a whole? I mean once the region being freed
> has overlap with this rtas region, skip the whole rtas region, and let
> crash_size
> show 0?
The existing code from crash_shrink_memory() function reduces the crash
size to 0 when echo'ed 0. I did test this patchset and verified that
/sys/kernel/kexec_crash_size show 0 value.

Thanks,
-Mahesh.
> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- =

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
