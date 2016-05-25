Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5Ynf-000103-KP
 for kexec@lists.infradead.org; Wed, 25 May 2016 13:24:40 +0000
Message-ID: <1464182650.16344.6.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Kdump maintainers update
From: Joe Perches <joe@perches.com>
In-Reply-To: <20160525131616.GB27291@redhat.com>
References: <20160525131616.GB27291@redhat.com>
Date: Wed, 25 May 2016 06:24:10 -0700
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>

On Wed, 2016-05-25 at 09:16 -0400, Vivek Goyal wrote:
> I am proposing following updates to kdump maintainership. I have got
> busy in other things and not getting time to spend on kdump.=A0
> =

> Removed Haren Myneni as he has not participated in kdump development for
> a long time now.
> =

> Proposing adding the names of Dave and Baoquan as kdump maintainers as
> they have been contributing to kdump for a long time now and they are in
> a much better position to spend time on this than me.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -6189,8 +6189,9 @@ F:	Documentation/kbuild/kconfig-language.txt
> =A0F:	scripts/kconfig/
> =A0
> =A0KDUMP
> +M:	Dave Young <dyoung@redhat.com>
> +M:	Baoquan He <bhe@redhat.com>
> =A0M:	Vivek Goyal <vgoyal@redhat.com>

You could mark yourself as an "R:" reviewer
instead of an "M:" maintainer.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
