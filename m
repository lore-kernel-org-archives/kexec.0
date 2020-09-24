Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLU4i-0003yh-El
 for kexec@lists.infradead.org; Thu, 24 Sep 2020 16:26:29 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
 <20200923154825.GC7635@char.us.oracle.com>
 <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date: Thu, 24 Sep 2020 11:25:31 -0500
In-Reply-To: <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 (Michael Kelley's message of "Thu, 24 Sep 2020 16:15:03 +0000")
Message-ID: <874knndtvo.fsf@x220.int.ebiederm.org>
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
To: Michael Kelley <mikelley@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "bhe@redhat.com" <bhe@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>, Dave Young <dyoung@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

Michael Kelley <mikelley@microsoft.com> writes:

> From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> Sent: Wednesday, September 23, 2020 8:48 AM
>> 
>> On Wed, Sep 23, 2020 at 10:43:29AM +0800, Dave Young wrote:
>> > + more people who may care about this param
>> 
>> Paarty time!!
>> 
>> (See below, didn't snip any comments)
>> > On 09/21/20 at 08:45pm, Eric W. Biederman wrote:
>> > > Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:
>> > >
>> > > > On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
>> > > >> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
>> > > >>
>> > > >> > crash_kexec_post_notifiers enables running various panic notifier
>> > > >> > before kdump kernel booting. This increases risks of kdump failure.
>> > > >> > It is well documented in kernel-parameters.txt. We do not suggest
>> > > >> > people to enable it together with kdump unless he/she is really sure.
>> > > >> > This is also not suggested to be enabled by default when users are
>> > > >> > not aware in distributions.
>> > > >> >
>> > > >> > But unfortunately it is enabled by default in systemd, see below
>> > > >> > discussions in a systemd report, we can not convince systemd to change
>> > > >> > it:
>> > > >> >
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fsyst
>> emd%2Fsystemd%2Fissues%2F16661&amp;data=02%7C01%7Cmikelley%40microsoft.com%
>> 7C3631bae06f7147c0f92908d85fd7f2b2%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%
>> 7C637364728378052956&amp;sdata=9CUpPUxcKLLggbJ1bjubBjbFUAhPVeZhIc4yss8wAiU%3
>> D&amp;reserved=0
>> > > >> >
>> > > >> > Actually we have got reports about kdump kernel hangs in both s390x
>> > > >> > and powerpcle cases caused by the systemd change,  also some x86 cases
>> > > >> > could also be caused by the same (although that is in Hyper-V code
>> > > >> > instead of systemd, that need to be addressed separately).
>> > > >
>> > > > Perhaps it may be better to fix the issus on s390x and PowerPC as well?
>> > > >
>> > > >> >
>> > > >> > Thus to avoid the auto enablement here just disable the param writable
>> > > >> > permission in sysfs.
>> > > >> >
>> > > >>
>> > > >> Well.  I don't think this is at all a desirable way of resolving a
>> > > >> disagreement with the systemd developers
>> > > >>
>> > > >> At the above github address I'm seeing "ryncsn added a commit to
>> > > >> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
>> > > >> enable crash_kexec_post_notifiers by default".  So didn't that address
>> > > >> the issue?
>> > > >
>> > > > It does in systemd, but there is a strong interest in making this on
>> > > > by default.
>> > >
>> > > There is also a strong interest in removing this code entirely from the
>> > > kernel.
>> >
>> > Added Hyper-V people and people who created the param, it is below
>> > commit, I also want to remove it if possible, let's see how people
>> > think, but the least way should be to disable the auto setting in both systemd
>> > and kernel:
>
> Hyper-V uses a notifier to inform the host system that a Linux VM has
> panic'ed.  Informing the host is particularly important in a public cloud
> such as Azure so that the cloud software can alert the customer, and can
> track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
> entirely by the customer and how he configures the VM, and we want
> the host to be informed either way.

Why?

Why does the host care?
Especially if the VM continues executing into a kdump kernel?

Further like I have mentioned everytime something like this has come up
a call on the kexec on panic code path should be a direct call (That can
be audited) not something hidden in a notifier call chain (which can not).

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
