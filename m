Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZUrwY-0000Rm-Bq
 for kexec@lists.infradead.org; Thu, 27 Aug 2015 07:49:54 +0000
Date: Thu, 27 Aug 2015 13:19:30 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH RFC] Drop release date from kexec-tools version output
Message-ID: <20150827074930.GJ13340@dhcppc13.redhat.com>
References: <20150824091005.GA10044@dhcp-16-198.nay.redhat.com>
 <20150824102923.GA21306@dhcppc13.redhat.com>
 <20150825084759.GC20225@dhcp-129-120.nay.redhat.com>
 <20150825104219.GA2948@dhcppc13>
 <20150827062956.GD3427@dhcp-129-155.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150827062956.GD3427@dhcp-129-155.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 27/08/2015:02:29:57 PM, Dave Young wrote:
> Pratyush, rethink about it, it is still confused. Considering below case:
> 
> git clone kexec-tools;
> bootstrap and build, the version and date is the current git version and current date
> after some time, git pull, upstream bumps to new version
> run make again, build/sbin/kexec --version will still show the old date along with new version

OK, got it..

May be we can take this patch and then it will be good to take Geoff's following patch.

http://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git/commit/?id=0b18e1d9311e21d2a2f1392607eade138b9aefe7

With this patch we get something like this:
$ ./build/sbin/kexec -v
kexec version: 15.05.14.11.29-g4f6d8ec17529
kexec-tools 2.0.10.git released 27 August 2015

So, we have Date, Time and git shaid as well.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
