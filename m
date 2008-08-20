Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KVtkv-0001UH-6m
	for kexec@lists.infradead.org; Wed, 20 Aug 2008 19:54:09 +0000
Date: Wed, 20 Aug 2008 21:54:04 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Kdump Automation Mechanism
Message-ID: <20080820215404.0ff117ff@kopernikus.site>
In-Reply-To: <536253.14632.qm@web1114.biz.mail.sk1.yahoo.com>
References: <20080818170257.4271910a@halley.suse.de>
	<536253.14632.qm@web1114.biz.mail.sk1.yahoo.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cai Qian <caiqian@cclom.cn>
Cc: qcai@redhat.com, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org

* Cai Qian <caiqian@cclom.cn> [2008-08-20 09:22]:
> --- Bernhard Walle <bwalle@suse.de> wrote:
> =

> > * Jay Lan [2008-08-14 10:23]:
> > >
> > > If you can put vmcore at the same location... Ahh, asking too much? ;)
> > =

> > Will change that to /var/crash since that's FHS 2.3 anyway. :)
> > [And I personally never liked =E2=80=9C/var/log/dump=E2=80=9D since it'=
s not a logfile.]
> >
> =

> That's a good. Do you have any consideration for standard Kdump options? =
I have created a Kdump
> test suite but it originally written and tested on RHEL and Fedora.
> =

> http://sourceforge.net/mailarchive/message.php?msg_name=3D20080815.210735=
.450985660335275199.qcai%40redhat.com

Thanks for that effort and for letting me that know.

I'll take definitively a look at this, but currently I'm a bit short in
time because of feature development for the next enterprise
distribution.

I put that on my TODO list, and I'll give you feedback, in the next
weeks. :-)



Bernhard
-- =

Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

"Make everything as simple as possible, but not simpler."
        -- Albert Einstein

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
