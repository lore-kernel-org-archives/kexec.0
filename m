Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKuTq-0003p4-1d
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 02:26:05 +0000
Date: Wed, 23 Sep 2020 10:25:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200923022547.GA3642@dhcp-128-65.nay.redhat.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921201811.GB3437@char.us.oracle.com>
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
Cc: bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 09/21/20 at 04:18pm, Konrad Rzeszutek Wilk wrote:
> On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
> > On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
> > 
> > > crash_kexec_post_notifiers enables running various panic notifier
> > > before kdump kernel booting. This increases risks of kdump failure.
> > > It is well documented in kernel-parameters.txt. We do not suggest
> > > people to enable it together with kdump unless he/she is really sure.
> > > This is also not suggested to be enabled by default when users are
> > > not aware in distributions.
> > > 
> > > But unfortunately it is enabled by default in systemd, see below
> > > discussions in a systemd report, we can not convince systemd to change
> > > it:
> > > https://github.com/systemd/systemd/issues/16661
> > > 
> > > Actually we have got reports about kdump kernel hangs in both s390x
> > > and powerpcle cases caused by the systemd change,  also some x86 cases
> > > could also be caused by the same (although that is in Hyper-V code
> > > instead of systemd, that need to be addressed separately).
> 
> Perhaps it may be better to fix the issus on s390x and PowerPC as well?
> 
> > > 
> > > Thus to avoid the auto enablement here just disable the param writable
> > > permission in sysfs.
> > > 
> > 
> > Well.  I don't think this is at all a desirable way of resolving a
> > disagreement with the systemd developers
> > 
> > At the above github address I'm seeing "ryncsn added a commit to
> > ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
> > enable crash_kexec_post_notifiers by default".  So didn't that address
> > the issue?
> 
> It does in systemd, but there is a strong interest in making this on by default.

I understand there could be such interest, but we have to keep in mind
that any extra things after a system crash can cause kdump unreliable.

I do not object people to use pstore, but I do object to enable the
notifiers by default.

BTW, crash notifiers are not limited to pstore, there are quite a log of
other pieces like led trigger etc.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
