Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ti-out-0910.google.com ([209.85.142.186])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIO8S-0003zS-O7
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 13:30:37 +0000
Received: by ti-out-0910.google.com with SMTP id a21so2332949tia.2
	for <kexec@lists.infradead.org>; Mon, 14 Jul 2008 06:30:32 -0700 (PDT)
Message-ID: <851fc09e0807140630w6edfa613oc176c6479808a6bd@mail.gmail.com>
Date: Mon, 14 Jul 2008 21:30:31 +0800
From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
In-Reply-To: <20080711122131.b6461ab1.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080708145051.GA14745@redhat.com>
	<20080711122131.b6461ab1.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Sat, Jul 12, 2008 at 3:21 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 8 Jul 2008 10:50:51 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:
>
>> On Mon, Jul 07, 2008 at 11:25:22AM +0800, Huang Ying wrote:
>> > This patch provides an enhancement to kexec/kdump. It implements
>> > the following features:
>> >
>> > - Backup/restore memory used by the original kernel before/after
>> >   kexec.
>> >
>> > - Save/restore CPU state before/after kexec.
>> >
>>
>> Hi Huang,
>>
>> In general this patch set looks good enough to live in -mm and
>> get some testing going.
>>
>> To me, adding capability to return back to original kernel looks
>> like a logical extension to kexec functionality.
>
> Exciting ;)  It's much less code than I expected.
>
> I don't think I understand the feature any more.  Once upon a time we
> thought that this might become a new and better (or at least
> better-code-sharing) way of doing suspend-to-disk.  How far are we from
> that?

At least there are still issues as follow:

- We need a mechanism to pass some information (such as backup pages
map) from hibernated kernel to hibernating kernel. Maybe in C calling
convention.
- To load hibernation image via /sbin/kexec, the segment number
constraint of sys_kexec_load needs to be extended (maybe via
multi-stage loading).
- Make kexec based hibernation compatible with ACPI S4.
- Extend makedumpfile utility for kexec based hibernation.

> What are the prospects of supporting other architectures?

I will work on x86_64 supporting.

> Who maintains kexec-tools, and are they OK with merging up the
> corresponding changes?

I will work with kexec-tools mailing list for corresponding kexec-tools patches.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
