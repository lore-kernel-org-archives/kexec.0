Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwiWx-0006dE-N2
	for kexec@lists.infradead.org; Thu, 15 May 2008 18:50:20 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
Date: Thu, 15 May 2008 11:39:47 -0700
In-Reply-To: <1210827473.23707.133.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Thu, 15 May 2008 12:57:53 +0800")
Message-ID: <m1lk2bs970.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec multi-stage
	load
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

"Huang, Ying" <ying.huang@intel.com> writes:

> On Wed, 2008-05-14 at 14:43 -0700, Eric W. Biederman wrote:
> [...]
>> Then as a preliminary design let's plan on this.
>> 
>> - Pass the rentry point as the return address (using the C ABI).
>>   We may want to load the stack pointer etc so we can act as
>>   a direct entry point for new code.
>
> There are some issues about passing entry point as return address. The
> kexec jump (or kexec with return) is used for
>
> - Switching between original kernel (A) and kexeced kernel (B)
> - Call some code (such as BIOS code) in physical mode
>
> 1) When call some code in physical mode, the called code can use a
> simple return to return to kernel A. So there is no return address on
> stack after return to kernel A. Instead, argument 1 is on stack top.
>
> 2) When switch back from kernel B to kernel A, kernel B will call the
> jump back entry of kernel A with C ABI. So, the return address is on
> stack top. And kernel A get jump back entry of kernel B via the return
> address.
>
> Because the stack state is different between 1) and 2), the jump back
> entry of kernel A should distinguish them.

Yes.  Because the stack state is different we need to be careful.

However I don't see that we care how we got to the proper piece of
code.  If we don't care we don't need to distinguish them.

Therefore I see two possible solutions.
1) Write a tiny trampoline that goes in the core file to keep
   the calling conventions sane.

2) After we figure out our address read the stack pointer from
   a fixed location and simply set it.  (This is my preference)

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
