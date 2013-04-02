Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMx7Y-0004j4-IG
 for kexec@lists.infradead.org; Tue, 02 Apr 2013 09:03:13 +0000
Date: Tue, 2 Apr 2013 18:03:07 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] [RFC] get rid of dist
Message-ID: <20130402090307.GB25093@verge.net.au>
References: <1364815385-26722-1-git-send-email-richard@nod.at>
 <1364815385-26722-2-git-send-email-richard@nod.at>
 <20130402011031.GD14785@verge.net.au> <515A6E6E.8030805@nod.at>
 <515A71ED.7050104@cn.fujitsu.com> <515A72BA.5040607@nod.at>
 <515A75FE.1060200@cn.fujitsu.com>
 <20130402072051.514be33d@spider.haslach.nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130402072051.514be33d@spider.haslach.nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: kexec@lists.infradead.org, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

On Tue, Apr 02, 2013 at 07:20:51AM +0200, Richard Weinberger wrote:
> Am Tue, 02 Apr 2013 14:09:02 +0800
> schrieb Zhang Yanfei <zhangyanfei@cn.fujitsu.com>:
> > Yeah, this is one case.
> > 
> > Someone may also download a kexec-tools tarball from internet,
> > and then want to build a RPM. Even git isn't installed in his system,
> > the RPM could be built.
> 
> Building the tarball is maintainer work.
> The maintainer creates a "clean" tarball to distribute it.
> Don't tell me that the maintainer has no git installed.
> 
> End users fetch the generated tarball to build/distribute kexec-tools.
> AFAIK the rpm spec file is generated and only available in the generated
> tarball. They don't need git. Only the maintainer which generates the distribution
> tarball needs git...

There are many ways to obtain kexec-tools.
I'm really not very exited about requiring git to make a tarball.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
