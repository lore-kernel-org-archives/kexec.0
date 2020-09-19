Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJXGL-0003zw-UV
 for kexec@lists.infradead.org; Sat, 19 Sep 2020 07:26:26 +0000
Date: Sat, 19 Sep 2020 15:26:13 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200919072613.GA3649@dhcp-128-65.nay.redhat.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, bhe@redhat.com, linux-kernel@vger.kernel.org

On 09/18/20 at 05:47pm, Andrew Morton wrote:
> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
> 
> > crash_kexec_post_notifiers enables running various panic notifier
> > before kdump kernel booting. This increases risks of kdump failure.
> > It is well documented in kernel-parameters.txt. We do not suggest
> > people to enable it together with kdump unless he/she is really sure.
> > This is also not suggested to be enabled by default when users are
> > not aware in distributions.
> > 
> > But unfortunately it is enabled by default in systemd, see below
> > discussions in a systemd report, we can not convince systemd to change
> > it:
> > https://github.com/systemd/systemd/issues/16661
> > 
> > Actually we have got reports about kdump kernel hangs in both s390x
> > and powerpcle cases caused by the systemd change,  also some x86 cases
> > could also be caused by the same (although that is in Hyper-V code
> > instead of systemd, that need to be addressed separately).
> > 
> > Thus to avoid the auto enablement here just disable the param writable
> > permission in sysfs.
> > 
> 
> Well.  I don't think this is at all a desirable way of resolving a
> disagreement with the systemd developers
> 
> At the above github address I'm seeing "ryncsn added a commit to
> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
> enable crash_kexec_post_notifiers by default".  So didn't that address
> the issue?
> 

I hope that commit can be merged in systemd, but we are really not
optimize about that. The discussion is clear there but we did not get
response since Aug 6.

BTW, Kairui sent the systemd pull request 15 days ago, the new update added some
comment.

Thanks
Dave 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
