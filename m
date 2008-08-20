Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from web1114.biz.mail.sk1.yahoo.com ([74.6.114.46])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KVqS8-00074b-Ed
	for kexec@lists.infradead.org; Wed, 20 Aug 2008 16:22:32 +0000
Date: Wed, 20 Aug 2008 09:22:30 -0700 (PDT)
From: Cai Qian <caiqian@cclom.cn>
Subject: Re: Kdump Automation Mechanism
In-Reply-To: <20080818170257.4271910a@halley.suse.de>
MIME-Version: 1.0
Message-ID: <536253.14632.qm@web1114.biz.mail.sk1.yahoo.com>
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
To: Bernhard Walle <bwalle@suse.de>, Neil Horman <nhorman@redhat.com>
Cc: qcai@redhat.com, kexec@lists.infradead.org

Hi Bernhard and Neil,

--- Bernhard Walle <bwalle@suse.de> wrote:

> * Jay Lan [2008-08-14 10:23]:
> >
> > If you can put vmcore at the same location... Ahh, asking too much? ;)
> =

> Will change that to /var/crash since that's FHS 2.3 anyway. :)
> [And I personally never liked =E2=80=9C/var/log/dump=E2=80=9D since it's =
not a logfile.]
>

That's a good. Do you have any consideration for standard Kdump options? I =
have created a Kdump
test suite but it originally written and tested on RHEL and Fedora.

http://sourceforge.net/mailarchive/message.php?msg_name=3D20080815.210735.4=
50985660335275199.qcai%40redhat.com

I hope it could also work for SLES, OpenSUSE and other distros. However, I =
have no environment to
test it yet, and I found it is kind of difficult to port it to other distro=
s for so many different
options.

I'd appreciate if you guys could have a look, and come out a standard Kdump=
 options. I'd also be
happy to modify the suite accordingly.

Thanks,
CaiQian

> =

> =

> Bernhard
> -- =

> Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development
> =

> =E2=80=9CMake everything as simple as possible, but not simpler.=E2=80=9D
>        -- Albert Einstein
> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
