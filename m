Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PiWvK-00050c-Ox
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 18:50:27 +0000
Date: Thu, 27 Jan 2011 13:50:21 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: include sysctl to disable
Message-ID: <20110127185021.GE23047@redhat.com>
References: <20110119222630.6755.63928.stgit@paris.rdu.redhat.com>
	<ih8gpe$41t$1@dough.gmane.org> <ih8he2$41t$2@dough.gmane.org>
	<AANLkTi=LJWvT5r=0rSBxV4aQdm6n2YAS_0y0RkKdTXQp@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=LJWvT5r=0rSBxV4aQdm6n2YAS_0y0RkKdTXQp@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Eric Paris <eparis@parisplace.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Jan 27, 2011 at 01:40:02PM -0500, Eric Paris wrote:
> Ping, not hearing any argument is usually a good thing   :)
> =


So if we allowing locking down module loading, why not allow locking down
kexec kernel loading, hence...

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> -Eric
> =

> On Thu, Jan 20, 2011 at 12:32 AM, WANG Cong <xiyou.wangcong@gmail.com> wr=
ote:
> =

> >> On Wed, 19 Jan 2011 17:26:30 -0500, Eric Paris wrote:
> >>
> >>> much like /proc/sys/kernel/modules_disable is used to disable module
> >>> loading, /proc/sys/kernel/kexec_disable is used to disable kexec code
> >>> loading. =A0It would still be possible to use kexec -l to load a kern=
el,
> >>> set the tunable to 1 so the kernel waiting to boot couldn't change, a=
nd
> >>> then launch the kernel at a later time (through kexec -e or through a
> >>> crash)
> =

> > Acked-by: WANG Cong <xiyou.wangcong@gmail.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
