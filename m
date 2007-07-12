Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]
	helo=bifrost.lang.hm)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I948F-0003bH-Vx
	for kexec@lists.infradead.org; Thu, 12 Jul 2007 20:15:21 +0100
Date: Thu, 12 Jul 2007 12:09:31 -0700 (PDT)
From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base hibernation
In-Reply-To: <m14pk9fuqa.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0707121206240.25614@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711172243.ab44c4d4.akpm@linux-foundation.org>
	<1184251423.9346.55.camel@caritas-dev.intel.com>
	<m14pk9fuqa.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Thu, 12 Jul 2007, Eric W. Biederman wrote:

>> 2. Do not reserve memory for kexec kernel. That is, backup needed memory
>> before kexec and restore them after kexec.
>> 3. Support the in-place kexec? The relocatable kernel is not necessary
>> if this can be implemented.
>
> It sounds like what you really want is the normal kexec path enhanced
> so that you can return to the kernel you started with.
>
> The normal kexec path already knows how to do the memory shuffle so
> it can do on demand memory allocation.  That code just needs to
> enhanced slightly so that you allocate an extra page, setup an inverse
> scatter gather list for restoring the pages, and teach relocate_kernel.S
> to preserve it's destination pages by using the inverse scatter gather
> list.
>
> The normal kexec path already calls device_shutdown and the like to
> stop devices from running.  Although again that code path is not
> prepared to restore the devices.

we shouldn't need a restore code path if the new kernel re-detects 
everything. if kexec already shuts down all the devices we may not need to 
implement anything new here (although there may be room for future 
performance optimization)

> ...
>
> For prototyping I would:
> - reserve a chunk of memory (possibly with the crashkernel= option)
>  and run a relocatable kernel out of it.
>
>  By using the normal kexec you can boot a relocatable restore kernel
>  in that reserved region. It is an extra step but it makes things
>  work today.
>
> - I would use the normal sys_kexec_load.
>
> - I would debug/tweak the user space and the code to reenter the
>  old kernel.  I.e. the device driver stop/start code.
>
>  Once it was basically working I would the update normal kexec
>  memory copy code in relocate.S to preserve the destination pages.

for prototyping there's no need to use the same kernel.

>> 4. Image writing/reading. (Only user space application is needed).
>
> And possibly a few fixes to /dev/mem.  This is pretty much the same
> process as generating a core dump so there should be some synergy with that.

what fixes are you thinking of?

you are makeing this sound very simple ;-)

David Lang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
