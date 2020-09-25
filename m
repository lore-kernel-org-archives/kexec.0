Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLp7x-0000iE-8L
 for kexec@lists.infradead.org; Fri, 25 Sep 2020 14:55:14 +0000
Date: Fri, 25 Sep 2020 10:56:25 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200925145625.GH30019@char.us.oracle.com>
References: <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
 <20200923154825.GC7635@char.us.oracle.com>
 <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <874knndtvo.fsf@x220.int.ebiederm.org>
 <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <4f964490-7464-0071-db38-4b16d665503e@oracle.com>
 <20200925030558.GA3446@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925030558.GA3446@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Wei Liu <wei.liu@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, boris.ostrovsky@oracle.com, Eric DeVolder <eric.devolder@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Sep 25, 2020 at 11:05:58AM +0800, Dave Young wrote:
> Hi,
> 
> On 09/24/20 at 01:16pm, boris.ostrovsky@oracle.com wrote:
> > 
> > On 9/24/20 12:43 PM, Michael Kelley wrote:
> > > From: Eric W. Biederman <ebiederm@xmission.com> Sent: Thursday, September 24, 2020 9:26 AM
> > >> Michael Kelley <mikelley@microsoft.com> writes:
> > >>
> > >>>>> Added Hyper-V people and people who created the param, it is below
> > >>>>> commit, I also want to remove it if possible, let's see how people
> > >>>>> think, but the least way should be to disable the auto setting in both systemd
> > >>>>> and kernel:
> > >>> Hyper-V uses a notifier to inform the host system that a Linux VM has
> > >>> panic'ed.  Informing the host is particularly important in a public cloud
> > >>> such as Azure so that the cloud software can alert the customer, and can
> > >>> track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
> > >>> entirely by the customer and how he configures the VM, and we want
> > >>> the host to be informed either way.
> > >> Why?
> > >>
> > >> Why does the host care?
> > >> Especially if the VM continues executing into a kdump kernel?
> > > The host itself doesn't care.  But the host is a convenient out-of-band
> > > channel for recording that a panic has occurred and to collect basic data
> > > about the panic.  This out-of-band channel is then used to notify the end
> > > customer that his VM has panic'ed.  Sure, the customer should be running
> > > his own monitoring software, but customers don't always do what they
> > > should.  Equally important, the out-of-band channel allows the cloud
> > > infrastructure software to notice trends, such as that the rate of Linux
> > > panics has increased, and that perhaps there is a cloud problem that
> > > should be investigated.
> > 
> > 
> > In many cases (especially in cloud environment) your dump device is remote (e.g. iscsi) and kdump sometimes (often?) gets stuck because of connectivity issues (which could be cause of the panic in the first place). So it is quite desirable to inform the infrastructure that the VM is on its way out without waiting for kdump to complete.
> 
> That can probably be done in kdump kernel if it is really needed.  Say
> informing host that panic happened and a kdump kernel is runnning.

If kdump kernel gets to that point. Sometimes (sadly) it ends up being
misconfigured and it chokes up - and hence having multiple ways to emit
the crash information before running kdump kernel is a life-saver.

> 
> But I think to set crash_kexec_post_notifiers by default is still bad. 

Because of the way it is run today I presume? If there was some
safe/unsafe policy that should work right? I would think that the
safe ones that work properly all the time are:

 - HyperV CRASH_MSRs,
 - KVM PVPANIC_[PANIC,CRASHLOAD] push button knob,
 - pstore EFI variables
 - Dumping in memory,

And then some that depend on firmware version (aka BIOS, and vendor) are:
 - ACPI ERST,

And then the unsafe:
 - s390, PowerPC (I don't actually know what they are but that
    was Dave's primary motivator).

> 
> > 
> > 
> > >
> > >> Further like I have mentioned everytime something like this has come up
> > >> a call on the kexec on panic code path should be a direct call (That can
> > >> be audited) not something hidden in a notifier call chain (which can not).
> > >>
> > 
> > We btw already have a direct call from panic() to kmsg_dump() which is indirectly controlled by crash_kexec_post_notifiers, and it would also be preferable to be able to call it before kdump as well.
> 
> Right, that is the same thing we are talking about.
> 
> Thanks
> Dave
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
