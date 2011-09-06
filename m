Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143])
	by canuck.infradead.org with smtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R0prF-0003IG-N1
	for kexec@lists.infradead.org; Tue, 06 Sep 2011 07:14:11 +0000
From: Angelo CASTELLO <angelo.castello@st.com>
References: <1315234944-8230-1-git-send-email-angelo.castello@st.com>
	<20110905222940.GA29637@verge.net.au>
In-Reply-To: <20110905222940.GA29637@verge.net.au>
Subject: RE: [PATCH] kexec: sh: Fixed command line management.
Date: Tue, 6 Sep 2011 09:13:38 +0200
Message-ID: <057c01cc6c64$8089ddb0$819d9910$@castello@st.com>
MIME-Version: 1.0
Content-Language: it
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
To: 'Simon Horman' <horms@verge.net.au>
Cc: kexec@lists.infradead.org

> -----Original Message-----
> From: kexec-bounces@lists.infradead.org [mailto:kexec-
> bounces@lists.infradead.org] On Behalf Of Simon Horman
> Sent: marted=EC 6 settembre 2011 0.30
> To: Angelo CASTELLO
> Cc: kexec@lists.infradead.org
> Subject: Re: [PATCH] kexec: sh: Fixed command line management.
> =

> On Mon, Sep 05, 2011 at 05:02:24PM +0200, Angelo CASTELLO wrote:
> > This fixes the command line management to be rightly used by
> > elf-sh and zImage-sh type formats. Basically, the issue was on use
> > of --append option for both set and append the STRING at the cmdline.
> > With this patch we correctly manage the cmdline by means of:
> >   --append=3DSTRING           Append STRING to the current kernel
> command line
> >   --command-line=3DSTRING     Set the kernel command line to STRING
> > Kexec by default gets and runs new kernel using the current
> > kernel command line. Running kexec -h you will see its default
> options.
> =

> Hi Angelo,
> =

> I don't believe that the changes to the processing of command-line
> that you have made are consistent with the implementation on
> other architectures.

Hi Simon,
To be consistent with the concepts of --append and --command-line,
can I use the guide line implemented by the x86_64 ? =

Where we have:
                { "command-line",       1, NULL, OPT_APPEND },
                { "append",             1, NULL, OPT_APPEND },
                { "reuse-cmdline",      0, NULL, OPT_REUSE_CMDLINE },

But from my point of view, one of them is redundant. =

Could be appropriate to change the meant of '--append' from 'set' to
'append',
for all architectures.
What do you think ?

> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
