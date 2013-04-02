Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMtu6-0005vS-PJ
 for kexec@lists.infradead.org; Tue, 02 Apr 2013 05:37:09 +0000
Message-ID: <515A6E6E.8030805@nod.at>
Date: Tue, 02 Apr 2013 07:36:46 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] [RFC] get rid of dist
References: <1364815385-26722-1-git-send-email-richard@nod.at>
 <1364815385-26722-2-git-send-email-richard@nod.at>
 <20130402011031.GD14785@verge.net.au>
In-Reply-To: <20130402011031.GD14785@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: zhangyanfei@cn.fujitsu.com, kexec@lists.infradead.org

Simon,

Am 02.04.2013 03:10, schrieb Simon Horman:
> On Mon, Apr 01, 2013 at 01:23:05PM +0200, Richard Weinberger wrote:
>> Replace the dist variable by git ls-files.
>> The following files are now included in the dist tarball too:
>
> I'm sorry but I don't think it is reasonable to
> add git as a requirement for building a tarball.

It is not about building a tarball, it is about tracking files.
Currently you are abusing make to keep track of your files.
git does this already for you.
Tracking files manually in the Makefile is also error prone.
doc/mpc85xx.txt and arch/i386/timer.c have already been forgotten...
If I'm not mistaken kexec-tools uses git as SCM, so you'll need
git anyways to checkout the source and work with it.

Thanks,
//richard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
