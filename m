Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKXNS-0006Td-O0
 for kexec@lists.infradead.org; Tue, 22 Sep 2020 01:45:55 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
Date: Mon, 21 Sep 2020 20:45:00 -0500
In-Reply-To: <20200921201811.GB3437@char.us.oracle.com> (Konrad Rzeszutek
 Wilk's message of "Mon, 21 Sep 2020 16:18:12 -0400")
Message-ID: <87v9g6fuub.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>, Dave Young <dyoung@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:

> On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
>> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
>> 
>> > crash_kexec_post_notifiers enables running various panic notifier
>> > before kdump kernel booting. This increases risks of kdump failure.
>> > It is well documented in kernel-parameters.txt. We do not suggest
>> > people to enable it together with kdump unless he/she is really sure.
>> > This is also not suggested to be enabled by default when users are
>> > not aware in distributions.
>> > 
>> > But unfortunately it is enabled by default in systemd, see below
>> > discussions in a systemd report, we can not convince systemd to change
>> > it:
>> > https://github.com/systemd/systemd/issues/16661
>> > 
>> > Actually we have got reports about kdump kernel hangs in both s390x
>> > and powerpcle cases caused by the systemd change,  also some x86 cases
>> > could also be caused by the same (although that is in Hyper-V code
>> > instead of systemd, that need to be addressed separately).
>
> Perhaps it may be better to fix the issus on s390x and PowerPC as well?
>
>> > 
>> > Thus to avoid the auto enablement here just disable the param writable
>> > permission in sysfs.
>> > 
>> 
>> Well.  I don't think this is at all a desirable way of resolving a
>> disagreement with the systemd developers
>> 
>> At the above github address I'm seeing "ryncsn added a commit to
>> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
>> enable crash_kexec_post_notifiers by default".  So didn't that address
>> the issue?
>
> It does in systemd, but there is a strong interest in making this on
> by default.

There is also a strong interest in removing this code entirely from the
kernel.

This failure is a case in point.

I think I am at my I told you so point.  This is what all of the testing
over all the years has said.  Leaving functionality to the peculiarities
of firmware when you don't have to, and can actually control what is
going on doesn't work.

Eric



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
