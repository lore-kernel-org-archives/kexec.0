Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.122.233] helo=mgw-mx06.nokia.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NsdvQ-0005vv-Qm
	for kexec@lists.infradead.org; Fri, 19 Mar 2010 15:15:53 +0000
Subject: Re: [PATCH] kexec-tools: Fix a typo in rpm spec description
From: Ameya Palande <ameya.palande@nokia.com>
In-Reply-To: <20100319145942.GT15159@redhat.com>
References: <dc79caccb36f1bf0dbd5b105cbd4e885ff79dd71.1269007108.git.ameya.palande@nokia.com>
	<20100319145942.GT15159@redhat.com>
Date: Fri, 19 Mar 2010 17:14:24 +0200
Message-ID: <1269011664.2154.0.camel@sanganak>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ext Don Zickus <dzickus@redhat.com>
Cc: "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, 2010-03-19 at 15:59 +0100, ext Don Zickus wrote:
> On Fri, Mar 19, 2010 at 03:58:52PM +0200, Ameya Palande wrote:
> > From: Ameya Palande <ameya.palande@nokia.com>
> > 
> > Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> > ---
> >  kexec-tools.spec.in |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/kexec-tools.spec.in b/kexec-tools.spec.in
> > index 5eadece..ae91b73 100644
> > --- a/kexec-tools.spec.in
> > +++ b/kexec-tools.spec.in
> > @@ -9,7 +9,7 @@ Packager: Eric Biederman <ebiederman@xmission.com>
> >  BuildRoot: %{_tmppath}/%{name}
> >  
> >  %description
> > -/sbin/kexec is a user space utiltity for loading another kernel
> > +/sbin/kexec is a user space utilitity for loading another kernel
> 
> I believe the word you want is 'utility'. ;-)

Ya! :O Thanks for pointing out!

Cheers,
Ameya.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
