Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z8NnO-0003R0-9D
 for kexec@lists.infradead.org; Fri, 26 Jun 2015 07:11:30 +0000
Date: Fri, 26 Jun 2015 15:10:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.10
Message-ID: <20150626071058.GA13761@dhcp-128-60.nay.redhat.com>
References: <20150625102013.GA4706@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150625102013.GA4706@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 06/25/15 at 07:20pm, Simon Horman wrote:
> Hi all,
> 
> I am happy to announce the release of kexec-tools 2.0.10.
> 
> This is a feature release coinciding with the release of the v4.1 Linux Kernel.
> 
> This release can be downloaded from kernel.org:
> 
> 	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.10.tar.xz
> 	http://kernel.org/pub/linux/utils/kernel/kexec/
> 
> It is also tagged it in git:
> 
> 	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> 
> Thanks to everyone who has contributed to kexec.

Simon, thanks for the new release.

We updated Fedora kexec-tools to 2.0.9, plan to move to 2.0.10 soon.

But I see below error:
R_X86_64_29
Unhandled rela relocation: R_X86_64_29

There was a similar report before:
http://lists.infradead.org/pipermail/kexec/2015-February/013305.html

The strange thing is local build works for me, but koji build server
build does not work. 2.0.10 koji build also fails to load.

Appreciate for any hints or idea.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
