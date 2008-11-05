Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kxjwa-0003S3-36
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 15:05:16 +0000
Date: Wed, 5 Nov 2008 13:04:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 00/14] x86: disable virt on kdump and emergency_restart
Message-ID: <20081105150454.GG5247@blackpad>
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<49107E2C.8090803@redhat.com> <20081105144412.GD8993@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081105144412.GD8993@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Nov 05, 2008 at 09:44:12AM -0500, Vivek Goyal wrote:
> On Tue, Nov 04, 2008 at 06:54:04PM +0200, Avi Kivity wrote:
> > Eduardo Habkost wrote:
> >> Hi,
> >>
> >> This is a new version of the series to disabling virtualization on kdump,
> >> now extended to do the same tricks on emergency_restart() if needed.
> >>   
> >
> > Looks good.  If you me to push it upstream, I'll need kexec/kdump acks.   
> > Otherwise, ack for the kvm bits.
> 
> Looks good to me from kdump perspective.
> 
> Is there a way we can prevent any other module from using virt disable
> callback incase kvm is not loaded?

I think we can't prevent other modules from using the API. But 3rd-party
modules deal with CPU virtualization extensions today won't live with
KVM today, anyway. And between not living together with KVM and breaking
kdump/reboot, and not living together with KVM and making kdump and
reboot working, I the the latter looks better.

But I see this as an orthogonal issue. If we include a "CPU virtualization
extensions core API" in the future, it could simply keep the same
emergency_virt_disable() API available for emergency_restart and kdump.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
