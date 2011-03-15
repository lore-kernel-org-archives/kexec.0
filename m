Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PzP3Y-00070Q-GE
	for kexec@lists.infradead.org; Tue, 15 Mar 2011 07:52:41 +0000
Received: by iyf40 with SMTP id 40so382059iyf.36
	for <kexec@lists.infradead.org>; Tue, 15 Mar 2011 00:52:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110314181315.GA16075@in.ibm.com>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
	<20110309234657.264d3080@kryten>
	<20110309142108.GD16951@cr0.redhat.com>
	<20110314181315.GA16075@in.ibm.com>
Date: Tue, 15 Mar 2011 15:52:38 +0800
Message-ID: <AANLkTi=aDzCaa7_=5XTrnJCzmZPrDy3omXwDarEF8XmH@mail.gmail.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
To: mahesh@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>, akpm@linux-foundation.org, Anton Blanchard <anton@samba.org>

On Tue, Mar 15, 2011 at 2:13 AM, Mahesh J Salgaonkar
<mahesh@linux.vnet.ibm.com> wrote:
>
> During free we do free all of them including RMO region. But since the rtas
> region is always on top of RMO, crashkernel memory overlaps rtas region and
> we endup freeing that even, which is causing the crash.
>

Okay, but with this patch applied, we will just ignore rtas region, right?
Thus, when I echo 0 to free all the 128M crashkernel memory, the final
result will be 32M left, which means crash_size will still show 32M.
This looks odd.

How about skipping the 32M as a whole? I mean once the region being freed
has overlap with this rtas region, skip the whole rtas region, and let
crash_size
show 0?

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
