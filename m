Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tuxdriver-1-pt.tunnel.tserv13.ash1.ipv6.he.net
	([2001:470:7:9c9::2] helo=smtp.tuxdriver.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PiX1M-00054A-Q0
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 18:56:41 +0000
Date: Thu, 27 Jan 2011 13:56:27 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] kexec: include sysctl to disable
Message-ID: <20110127185627.GA3455@shamino.rdu.redhat.com>
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
> =

Acked-by: Neil Horman <nhorman@tuxdriver.com>

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
