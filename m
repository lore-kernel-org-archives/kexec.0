Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1esfHv-0000ss-8O
 for kexec@lists.infradead.org; Mon, 05 Mar 2018 01:51:40 +0000
Date: Mon, 5 Mar 2018 09:51:18 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 4/5] kexec: fallback to KEXEC_LOAD when KEXEC_FILE_LOAD
 is not supported.
Message-ID: <20180305015118.GA3878@dhcp-128-65.nay.redhat.com>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
 <ebc4bc6f1dc7d62ba5c81f40c7f7d83a8ae3eb5d.1519646210.git.msuchanek@suse.de>
 <20180302092419.GB15374@dhcp-128-65.nay.redhat.com>
 <20180302133252.69a36ffd@kitsune.suse.cz>
 <20180302124610.3tyvym3dayq3coiz@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180302124610.3tyvym3dayq3coiz@verge.net.au>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Tony Jones <tonyj@suse.com>, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>

On 03/02/18 at 01:46pm, Simon Horman wrote:
> On Fri, Mar 02, 2018 at 01:32:52PM +0100, Michal Such=E1nek wrote:
> > On Fri, 2 Mar 2018 17:24:19 +0800
> > Dave Young <dyoung@redhat.com> wrote:
> > =

> > > On 02/26/18 at 01:00pm, Michal Suchanek wrote:
> > > > Not all architectures implement KEXEC_FILE_LOAD. However, on some
> > > > archiectures KEXEC_FILE_LOAD is required when secure boot is
> > > > enabled in locked-down mode. Previously users had to select the
> > > > KEXEC_FILE_LOAD syscall with undocumented -s option. However, if
> > > > they did pass the option kexec would fail on architectures that do
> > > > not support it.
> > > > =

> > > > When no option is passed to select one syscall or the other try
> > > > KEXEC_FILE_LOAD and fall back to KEXEC_LOAD when not suported.  =

> > > =

> > > Again, IMHO the default behavior should not be changed..
> > =

> > So adding a new option to enable the fallback would be ok?
> =

> I am also wary of changing the default behaviour and
> I think a new fallback option would be better.
> =

> Dave?

Simon, I have same feeling, and a new option looks good to me as well

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
