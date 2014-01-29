Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W8YO0-0001dk-4G
 for kexec@lists.infradead.org; Wed, 29 Jan 2014 16:53:13 +0000
Date: Wed, 29 Jan 2014 11:52:45 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: More frequent kexec-tools releases
Message-ID: <20140129165245.GD15077@redhat.com>
References: <20140128184042.GA7098@redhat.com>
 <1391013993.19367.22.camel@rhapsody>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1391013993.19367.22.camel@rhapsody>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Khalid Aziz <khalid@gonehiking.org>
Cc: Dave Young <dyoung@redhat.com>, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On Wed, Jan 29, 2014 at 09:46:33AM -0700, Khalid Aziz wrote:
> On Tue, 2014-01-28 at 13:40 -0500, Vivek Goyal wrote:
> > I am wondering if there is any interest in more frequent releases of
> > kexec-tools. Say every 3 months or every 6 months.
> 
> Yes, that will be good. I maintain the kexec-tools package for Debian
> and I often find myself backporting fixes from git into Debian package
> as users find bugs that are already fixed in upstream. Being able to
> update the entire package to new release with all accumulated bugfixes
> periodically will be helpful.

Agreed. If we have more frequent releases of kexec-tools, then
distributions can easily rebase to newer releases more frequently and
that will reduce the overhead of cherry-picking and backporting fixes.

Also it allows distribution users to test new features sooner. For example,
kexec support on EFI systems. In worst case, a distribution user will have
to wait for an year or more before a release happens and user can test this
feature. And this is true for any feature which is introduced in kexec-tools.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
