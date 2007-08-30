Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IQea6-0000EY-9Y
	for kexec@lists.infradead.org; Thu, 30 Aug 2007 03:36:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: reenable HPET before kexec
References: <20070820205530.1ffd5876@windmill.dev.rtsoft.ru>
	<20070823090845.GA13065@in.ibm.com>
	<20070823154936.3b7ae498@windmill.dev.rtsoft.ru>
	<20070827053656.GC9809@in.ibm.com>
	<653FFBB4508B9042B5D43DC9E18836F501522051@scsmsx415.amr.corp.intel.com>
	<20070828165832.5047d4de@windmill.dev.rtsoft.ru>
Date: Thu, 30 Aug 2007 01:32:30 -0600
In-Reply-To: <20070828165832.5047d4de@windmill.dev.rtsoft.ru> (Konstantin
	Baydarov's message of "Tue, 28 Aug 2007 16:58:32 +0400")
Message-ID: <m1ps1532b5.fsf@ebiederm.dsl.xmission.com>
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
To: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Cc: RT <linux-rt-users@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, vgoyal@in.ibm.com, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>

Konstantin Baydarov <kbaidarov@ru.mvista.com> writes:

> On Mon, 27 Aug 2007 11:26:29 -0700
> "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
>
>> 
>> 
>> - Another thing to try is to disable HPET and boot with PIT in the
>> first kernel. Just to check whether PIT never works on this platform
>> or the first kernel is doing something to stop PIT. You can try
>> "hpet=disable" boot option for that.
>> 
>> Thanks,
>> Venki
>
> I've tried kernel 1 with HPET disabled - it boots fine, PIT works!
> Then I made additional investigations and found out that PIT won't work
> in kernel 2 if bit HPET_CFG_LEGACY is set.
> Bit HPET_CFG_LEGACY is set by hpet_enable_int() during HPET
> initialization, so if this bit is cleared in machine_kexec() kernel 2
> boots fine.
> I can't explain this magic, maybe someone can explain this. Thanks.
>
> Here is new version of workaround for 2.6.23-rc3

Ok.  It looks like you understand this issue.

Can you please try calling hpet_disable_int from
hpet_set_mode under CLOCK_EVT_MODE_SHUTDOWN.  I haven't
traced the clock event methods all of the way through
but as a first approximation I think that will get
things called at the appropriate time with out needing
to patch machine_kexec.  Which is very much the wrong
place to add call any hpet code from.

We may also need to make the hpet initialization more
robust so we can do something sane in the kexec on panic
case, where we deliberately don't run any shutdown methods.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
