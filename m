Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn7nam10on2102.outbound.protection.outlook.com
 ([40.107.92.102] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLUKp-0005t8-P6
 for kexec@lists.infradead.org; Thu, 24 Sep 2020 16:43:08 +0000
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Date: Thu, 24 Sep 2020 16:43:03 +0000
Message-ID: <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
 <20200923154825.GC7635@char.us.oracle.com>
 <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <874knndtvo.fsf@x220.int.ebiederm.org>
In-Reply-To: <874knndtvo.fsf@x220.int.ebiederm.org>
Content-Language: en-US
MIME-Version: 1.0
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Wei Liu <wei.liu@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "bhe@redhat.com" <bhe@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>, Dave Young <dyoung@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

From: Eric W. Biederman <ebiederm@xmission.com> Sent: Thursday, September 24, 2020 9:26 AM
> 
> Michael Kelley <mikelley@microsoft.com> writes:
> 
> >> >
> >> > Added Hyper-V people and people who created the param, it is below
> >> > commit, I also want to remove it if possible, let's see how people
> >> > think, but the least way should be to disable the auto setting in both systemd
> >> > and kernel:
> >
> > Hyper-V uses a notifier to inform the host system that a Linux VM has
> > panic'ed.  Informing the host is particularly important in a public cloud
> > such as Azure so that the cloud software can alert the customer, and can
> > track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
> > entirely by the customer and how he configures the VM, and we want
> > the host to be informed either way.
> 
> Why?
> 
> Why does the host care?
> Especially if the VM continues executing into a kdump kernel?

The host itself doesn't care.  But the host is a convenient out-of-band
channel for recording that a panic has occurred and to collect basic data
about the panic.  This out-of-band channel is then used to notify the end
customer that his VM has panic'ed.  Sure, the customer should be running
his own monitoring software, but customers don't always do what they
should.  Equally important, the out-of-band channel allows the cloud
infrastructure software to notice trends, such as that the rate of Linux
panics has increased, and that perhaps there is a cloud problem that
should be investigated.

> 
> Further like I have mentioned everytime something like this has come up
> a call on the kexec on panic code path should be a direct call (That can
> be audited) not something hidden in a notifier call chain (which can not).
> 

The use case I describe has no particular requirement that it be
implemented via the notifier call chain.  If there's a better way to run
some out-of-band notification code on all Linux panics regardless of
whether a kdump is taken, we're open to such an alternative.

Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
